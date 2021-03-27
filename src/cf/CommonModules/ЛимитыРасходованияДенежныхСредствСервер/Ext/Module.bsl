﻿
#Область ПрограммныйИнтерфейс

// Контроль лимитов при проведении заявки на расходование ДС
// 
// Параметры:
//	ЗаявкаОбъект - ДокументОбъект.ЗаявкаНаРасходованиеДенежныхСредств - проверяемый документ
//	Отказ - Булево - признак отказа в проведении документа.
//
Процедура ВыполнитьКонтрольРезультатовПроведения(ЗаявкаОбъект, Отказ) Экспорт
	Перем Ошибки;
	
	СверхЛимита              = ЗаявкаОбъект.СверхЛимита;
	КонтролироватьПревышениеЛимитовДС = ПолучитьФункциональнуюОпцию("КонтролироватьПревышениеЛимитовРасходаДенежныхСредств");
	ИспользоватьЛимитыБюджетирования  = Ложь;
	КонтролироватьПревышение = КонтролироватьПревышениеЛимитовДС
	                       ИЛИ ИспользоватьЛимитыБюджетирования;
	
	Если СверхЛимита Или Не КонтролироватьПревышение Тогда
		Возврат;
	КонецЕсли;
	
	СсылкаНаЗаявку         = ЗаявкаОбъект.Ссылка;
	ДополнительныеСвойства = ЗаявкаОбъект.ДополнительныеСвойства;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ЗаявкаОбъект.Статус = Перечисления.СтатусыЗаявокНаРасходованиеДенежныхСредств.Отклонена Тогда
		Возврат;
	КонецЕсли;
	
	НарушеныТолькоИнформационныеЛимиты = Ложь;
	
		
		ЗаявкаПроходитПоОперативнымЛимитам(СсылкаНаЗаявку, Ошибки, ДополнительныеСвойства);
		
	
	Если КонтролироватьПревышение И Не СверхЛимита Тогда
		Если ИспользоватьЛимитыБюджетирования И НарушеныТолькоИнформационныеЛимиты Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки);
		Иначе
			ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
		КонецЕсли;
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область КонтрольОперативныхЛимитов

Процедура СообщитьОбОшибкахПроведенияПоРегиструЛимитыРасходаДенежныхСредств(Ошибки, РезультатЗапроса)
	
	ВалютаУправленческогоУчета = Константы.ВалютаУправленческогоУчета.Получить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Превышен лимит расхода по статье %1 на сумму %2 %3'"),
				Строка(Выборка.СтатьяДвиженияДенежныхСредств),
				Строка(Выборка.ПревышениеЛимита),
				Строка(ВалютаУправленческогоУчета));
		
		ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "", ТекстСообщения, "");
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаявкаПроходитПоОперативнымЛимитам(СсылкаНаЗаявку, Ошибки, ДополнительныеСвойства)
	Перем ЕстьИзменения;
	
	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	ЕстьИзменения = СтруктураВременныеТаблицы.Свойство("ДвиженияЛимитыРасходаДенежныхСредствИзменение", ЕстьИзменения) И ЕстьИзменения;
	Если Не ЕстьИзменения Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЛимитыРасхода.Ссылка.МоментВремени КАК МоментВремени,
	|	ЛимитыРасхода.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	ЛимитыРасхода.ЕстьЛимит КАК ЕстьЛимит
	|ПОМЕСТИТЬ ВременнаяТаблицаСтатьиДДС
	|ИЗ
	|	Документ.ЛимитыРасходаДенежныхСредств.Лимиты КАК ЛимитыРасхода
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ДвиженияЛимитыРасходаДенежныхСредствИзменение КАК Таблица
	|		ПО (ЛимитыРасхода.Ссылка.Организация = Таблица.Организация
	|				ИЛИ НЕ &ЛимитыПоОрганизациям)
	|			И (ЛимитыРасхода.Ссылка.Подразделение = Таблица.Подразделение
	|				ИЛИ НЕ &ЛимитыПоПодразделениям)
	|			И ЛимитыРасхода.СтатьяДвиженияДенежныхСредств = Таблица.СтатьяДвиженияДенежныхСредств
	|ГДЕ
	|	&КонтролироватьПревышениеЛимитовРасходаДенежныхСредств
	|	И НЕ Таблица.СтатьяДвиженияДенежныхСредств ЕСТЬ NULL
	|	И ЛимитыРасхода.Ссылка.Период МЕЖДУ НАЧАЛОПЕРИОДА(&Период, МЕСЯЦ) И КОНЕЦПЕРИОДА(&Период, МЕСЯЦ)
	|	И ЛимитыРасхода.Ссылка.Проведен
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВременнаяТаблицаСтатьиДДС.СтатьяДвиженияДенежныхСредств
	|ПОМЕСТИТЬ ВременнаяТаблицаСтатьиДДСЛимитНеОграничен
	|ИЗ
	|	ВременнаяТаблицаСтатьиДДС КАК ВременнаяТаблицаСтатьиДДС
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВременнаяТаблицаСтатьиДДС КАК Отбор
	|		ПО ВременнаяТаблицаСтатьиДДС.СтатьяДвиженияДенежныхСредств = Отбор.СтатьяДвиженияДенежныхСредств
	|			И ВременнаяТаблицаСтатьиДДС.МоментВремени < Отбор.МоментВремени
	|ГДЕ
	|	Отбор.МоментВремени ЕСТЬ NULL
	|	И НЕ ВременнаяТаблицаСтатьиДДС.ЕстьЛимит
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Таблица.СтатьяДвиженияДенежныхСредств,
	|	Таблица.Организация,
	|	Таблица.Подразделение
	|ПОМЕСТИТЬ ИзмененияЛимитов
	|ИЗ
	|	ДвиженияЛимитыРасходаДенежныхСредствИзменение КАК Таблица
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВременнаяТаблицаСтатьиДДСЛимитНеОграничен КАК СтатьиДДСЛимитНеОграничен
	|		ПО Таблица.СтатьяДвиженияДенежныхСредств = СтатьиДДСЛимитНеОграничен.СтатьяДвиженияДенежныхСредств
	|ГДЕ
	|	СтатьиДДСЛимитНеОграничен.СтатьяДвиженияДенежныхСредств ЕСТЬ NULL
	|	И Таблица.СтатьяДвиженияДенежныхСредств <> ЗНАЧЕНИЕ(Справочник.СтатьиДвиженияДенежныхСредств.ПустаяСсылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ТаблицаОборотов.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	ТаблицаОборотов.Организация КАК Организация,
	|	ТаблицаОборотов.Подразделение КАК Подразделение,
	|	ТаблицаОборотов.РасходВПределахЛимитаОборот - ТаблицаОборотов.ЛимитОборот КАК ПревышениеЛимита
	|ИЗ
	|	РегистрНакопления.ЛимитыРасходаДенежныхСредств.Обороты(
	|			НАЧАЛОПЕРИОДА(&Период, МЕСЯЦ),
	|			КОНЕЦПЕРИОДА(&Период, МЕСЯЦ),
	|			,
	|			(СтатьяДвиженияДенежныхСредств, Организация, Подразделение) В
	|				(ВЫБРАТЬ
	|					ИзмененияЛимитов.СтатьяДвиженияДенежныхСредств,
	|					ИзмененияЛимитов.Организация,
	|					ИзмененияЛимитов.Подразделение
	|				ИЗ
	|					ИзмененияЛимитов)) КАК ТаблицаОборотов
	|ГДЕ
	|	&КонтролироватьПревышениеЛимитовРасходаДенежныхСредств
	|	И ТаблицаОборотов.РасходВПределахЛимитаОборот - ТаблицаОборотов.ЛимитОборот > 0";
	
	
	РеквизитыЗаявки = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(СсылкаНаЗаявку, "ДатаПлатежа, ЖелательнаяДатаПлатежа, Дата");
	Если ЗначениеЗаполнено(РеквизитыЗаявки.ДатаПлатежа) Тогда
		Период = РеквизитыЗаявки.ДатаПлатежа;
	ИначеЕсли ЗначениеЗаполнено(РеквизитыЗаявки.ЖелательнаяДатаПлатежа) Тогда
		Период = РеквизитыЗаявки.ЖелательнаяДатаПлатежа;
	Иначе
		Период = РеквизитыЗаявки.Дата;
	КонецЕсли;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("ЛимитыПоОрганизациям",
		ПолучитьФункциональнуюОпцию("ИспользоватьЛимитыРасходаДенежныхСредствПоОрганизациям"));
	Запрос.УстановитьПараметр("ЛимитыПоПодразделениям",
		ПолучитьФункциональнуюОпцию("ИспользоватьЛимитыРасходаДенежныхСредствПоПодразделениям"));
	Запрос.УстановитьПараметр("КонтролироватьПревышениеЛимитовРасходаДенежныхСредств",
		ПолучитьФункциональнуюОпцию("КонтролироватьПревышениеЛимитовРасходаДенежныхСредств"));
	
	СообщитьОбОшибкахПроведенияПоРегиструЛимитыРасходаДенежныхСредств(Ошибки, Запрос.Выполнить());
	
КонецПроцедуры

#КонецОбласти


#КонецОбласти 


