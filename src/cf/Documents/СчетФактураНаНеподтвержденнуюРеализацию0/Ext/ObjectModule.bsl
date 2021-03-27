﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Перем Основание;
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Если НЕ ДанныеЗаполнения.Свойство("ДокументОснование", Основание)  Тогда
			ВызватьИсключение НСтр("ru = 'Не указан документ-основание для заполенния счета-фактуры'");
		КонецЕсли;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Строка") Тогда
		// Пропускаем обработку, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
		Если ДанныеЗаполнения = "АвтоТест" Тогда
			Возврат;
		КонецЕсли;
	Иначе
		Основание = ДанныеЗаполнения;
	КонецЕсли;
	
	РеквизитыОснования = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Основание, "Организация, Контрагент, Валюта");
	ДанныеЗаполнения.Вставить("Организация", РеквизитыОснования.Организация);
	ДанныеЗаполнения.Вставить("Контрагент", РеквизитыОснования.Контрагент);
	ДанныеЗаполнения.Вставить("Валюта", РеквизитыОснования.Валюта);
	
	Если ЗначениеЗаполнено(ДанныеЗаполнения.Контрагент) Тогда
		РеквизитыКонтрагента = Справочники.Контрагенты.РеквизитыКонтрагента(ДанныеЗаполнения.Контрагент, ДанныеЗаполнения.Дата);
		ДанныеЗаполнения.Вставить("ИННКонтрагента", РеквизитыКонтрагента.ИНН);
		ДанныеЗаполнения.Вставить("КППКонтрагента", РеквизитыКонтрагента.КПП);
	КонецЕсли;
	
	Если Метаданные.Документы.СчетФактураНаНеподтвержденнуюРеализацию0.Реквизиты.ДокументОснование.Тип.СодержитТип(ТипЗнч(Основание)) Тогда
		ТаблицаТоваров = Документы.СчетФактураНаНеподтвержденнуюРеализацию0.ТоварыПоДокументыОснованию(Основание, ДанныеЗаполнения.Дата);
		Товары.Загрузить(ТаблицаТоваров);
	КонецЕсли;

	МассивОснований = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Основание);
	
	Документы.СчетФактураВыданный.ЗаполнитьПлатежноРасчетныеДокументы(
		ПлатежноРасчетныеДокументы,
		МассивОснований,
		ДанныеЗаполнения.Организация);
		
	СформироватьСтрокуРасчетноПлатежныхДокументов();
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") 
		И НЕ ДанныеЗаполнения.Свойство("КодВидаОперации") Тогда
		ДанныеЗаполнения.Вставить("КодВидаОперации", КодВидаОперации(Основание));
	КонецЕсли;
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	ПроведениеСерверУТ.УстановитьРежимПроведения(ЭтотОбъект, РежимЗаписи, РежимПроведения);
	
	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
	
	ОбщегоНазначенияУТ.ОкруглитьКоличествоШтучныхТоваров(ЭтотОбъект, РежимЗаписи);
	
	Если Не ПометкаУдаления Тогда
		ПроверитьДублиСчетФактуры(Отказ);
	КонецЕсли;
	
	Если ЭтоНовый() И НЕ ЗначениеЗаполнено(Номер) Тогда
		УстановитьНовыйНомер();
	КонецЕсли;
	
	Если РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда
		РучнаяКорректировкаЖурналаСФ = Ложь;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не Отказ
		И Не ДополнительныеСвойства.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		РегистрыСведений.РеестрДокументов.ИнициализироватьИЗаписатьДанныеДокумента(Ссылка, ДополнительныеСвойства, Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);
	
	Документы.СчетФактураНаНеподтвержденнуюРеализацию0.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);
	
	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	УчетНДСУП.СформироватьДвиженияВРегистры(ДополнительныеСвойства, Движения, Отказ);
	РегистрыСведений.РеестрДокументов.ЗаписатьДанныеДокумента(Ссылка, ДополнительныеСвойства, Отказ);
	
	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если НЕ ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДокументОснование, "Проведен") Тогда
		
		ТекстСообщения = НСтр("ru = 'Счет-фактуру можно провести только на основании проведенного документа.'");
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			ТекстСообщения,
			ЭтотОбъект,
			"ДокументОснование",
			, // ПутьКДанным 
			Отказ);
	
	КонецЕсли;
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ);
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект, МассивНепроверяемыхРеквизитов, Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	// Инициализация дополнительных свойств для проведения документа
	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	
	// Подготовка наборов записей
	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	// Запись наборов записей
	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ПриУстановкеНовогоНомера(СтандартнаяОбработка, Префикс)
	
	Префикс = "0";
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)
	
	Если ТипЗнч(ДанныеЗаполнения) <> Тип("Структура") Или Не ДанныеЗаполнения.Свойство("Ответственный") Тогда
		Ответственный = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
КонецПроцедуры

Функция КодВидаОперации(Основание = Неопределено) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Основание) Тогда
		Основание = ДокументОснование;
	КонецЕсли;
	
	КодВидаОперации = "";
	ВерсияКодовВидовОпераций = УчетНДСКлиентСервер.ВерсияКодовВидовОпераций(Дата);
	
	Если ТипЗнч(Основание) = Тип("ДокументСсылка.АктВыполненныхРабот") Тогда
		КодВидаОперации = "01";
		
	ИначеЕсли ТипЗнч(Основание) = Тип("ДокументСсылка.РеализацияТоваровУслуг") Тогда
		КодВидаОперации = КодВидаОперацииРеализацииТоваров(Основание, ВерсияКодовВидовОпераций);
	Иначе
		КодВидаОперации = "01";
	КонецЕсли;
	
	Возврат КодВидаОперации;
	
КонецФункции

Функция КодВидаОперацииРеализацииТоваров(РеализацияТоваров, ВерсияКодовВидовОпераций)
	
	ЕстьКомиссионныйТовар = Ложь;
	ЕстьСобственныйТовар = Ложь;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	&Основание КАК Ссылка
	|ПОМЕСТИТЬ ДокументыПродажи
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	КорректировкаРеализации.Ссылка
	|ИЗ
	|	Документ.КорректировкаРеализации КАК КорректировкаРеализации
	|ГДЕ
	|	КорректировкаРеализации.ДокументОснование = &Основание
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТоварыОрганизаций.ВидЗапасов.ТипЗапасов КАК ТипЗапасов,
	|
	|	СУММА(
	|		ВЫБОР КОГДА ТоварыОрганизаций.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|			ТоварыОрганизаций.Количество
	|		ИНАЧЕ
	|			-ТоварыОрганизаций.Количество
	|		КОНЕЦ
	|	) КАК Количество
	|
	|ИЗ
	|	РегистрНакопления.ТоварыОрганизаций КАК ТоварыОрганизаций
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ДокументыПродажи КАК ДокументыПродажи
	|		ПО ТоварыОрганизаций.Регистратор = ДокументыПродажи.Ссылка
	|ГДЕ
	|	ТоварыОрганизаций.Активность
	|
	|СГРУППИРОВАТЬ ПО
	|	ТоварыОрганизаций.ВидЗапасов.ТипЗапасов,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры,
	|	ТоварыОрганизаций.НомерГТД,
	|	ТоварыОрганизаций.Организация
	|
	|ИМЕЮЩИЕ
	|	СУММА(
	|		ВЫБОР КОГДА ТоварыОрганизаций.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|			ТоварыОрганизаций.Количество
	|		ИНАЧЕ
	|			-ТоварыОрганизаций.Количество
	|		КОНЕЦ) > 0
	|ИТОГИ ПО
	|	ТипЗапасов
	|");
	Запрос.УстановитьПараметр("Основание", РеализацияТоваров);
	
	Выборка = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Выборка.Следующий() Цикл
		Если Выборка.ТипЗапасов = Перечисления.ТипыЗапасов.КомиссионныйТовар Тогда
			ЕстьКомиссионныйТовар = Истина;
		Иначе
			ЕстьСобственныйТовар = Истина;
		КонецЕсли;
	КонецЦикла;
	
	Если ЕстьКомиссионныйТовар И ЕстьСобственныйТовар Тогда
		КодВидаОперации = ?(ВерсияКодовВидовОпераций >= 3, "15", "01;04");
	ИначеЕсли ЕстьКомиссионныйТовар Тогда
		КодВидаОперации = ?(ВерсияКодовВидовОпераций >= 3, "01", "04");
	Иначе
		КодВидаОперации = "01";
	КонецЕсли;
	
	Возврат КодВидаОперации;
	
КонецФункции

#КонецОбласти

#Область Прочее

Процедура ПроверитьДублиСчетФактуры(Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ДанныеДокумента.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.СчетФактураНаНеподтвержденнуюРеализацию0 КАК ДанныеДокумента
	|ГДЕ
	|	ДанныеДокумента.Ссылка <> &Ссылка
	|	И ДанныеДокумента.ДокументОснование = &ДокументОснование
	|	И НЕ ДанныеДокумента.ПометкаУдаления
	|	И (ДанныеДокумента.Организация = &Организация
	|			ИЛИ &Организация = НЕОПРЕДЕЛЕНО)";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("ДокументОснование", ДокументОснование);
	Запрос.УстановитьПараметр("Организация", Организация);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Если Выборка.Следующий() Тогда
		
		Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Для документа %1 по организации %2 уже введен счет-фактура %3'"),
				ДокументОснование,
				Организация,
				Выборка.Ссылка);
				
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				Текст,
				ЭтотОбъект,
				"ДокументОснование",
				,
				Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура СформироватьСтрокуРасчетноПлатежныхДокументов()
	
	СтрокаНомеровИДата = "";
	Для Каждого СтрокаТаблицы Из ПлатежноРасчетныеДокументы Цикл
		СтрокаНомеровИДата = СтрокаНомеровИДата + ?(ПустаяСтрока(СтрокаНомеровИДата), "", ", ")
							 + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
									НСтр("ru = '%1 от %2'"),
									СтрокаТаблицы.НомерПлатежноРасчетногоДокумента,
									Формат(СтрокаТаблицы.ДатаПлатежноРасчетногоДокумента, "ДЛФ=D"));
	КонецЦикла; 
		
	Если СтрокаПлатежноРасчетныеДокументы <> СтрокаНомеровИДата Тогда
		СтрокаПлатежноРасчетныеДокументы = СтрокаНомеровИДата;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
