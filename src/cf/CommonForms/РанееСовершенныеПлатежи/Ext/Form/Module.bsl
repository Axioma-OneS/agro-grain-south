﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	СвойстваСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
	СвойстваСписка.ТекстЗапроса = ТекстЗапросаТаблицаПлатежей();
	ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.ТаблицаПлатежей, СвойстваСписка);
	
	Параметры.Свойство("ТипНалога", ТипНалогаОтбор);
	НеОтбиратьПоТипуНалога = Не ЗначениеЗаполнено(ТипНалогаОтбор);
	
	Элементы.ТипНалогаОтбор.Видимость = Не НеОтбиратьПоТипуНалога;
	
	ТаблицаПлатежей.Параметры.УстановитьЗначениеПараметра("НеОтбиратьПоТипуНалога", НеОтбиратьПоТипуНалога);
	ТаблицаПлатежей.Параметры.УстановитьЗначениеПараметра("ТипНалогаОтбор", ТипНалогаОтбор);
	
	Если Параметры.ПрименениеПриказа107н Тогда
		Элементы.ТаблицаПлатежейКодОКАТО.Заголовок = "ОКТМО";
	Иначе
		Элементы.ТаблицаПлатежейКодОКАТО.Заголовок = "ОКАТО";
	КонецЕсли;
	
	ТаблицаПлатежей.Параметры.УстановитьЗначениеПараметра("ДатаНач", ДобавитьМесяц(ТекущаяДатаСеанса(), -24));
	ТаблицаПлатежей.Параметры.УстановитьЗначениеПараметра("ДатаКон", ТекущаяДатаСеанса());
	ТаблицаПлатежей.Параметры.УстановитьЗначениеПараметра("Ссылка", Параметры.Ссылка);
	
	БанковскийСчет = Параметры.БанковскийСчет;
	БанковскийСчетПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура БанковскийСчетПриИзменении(Элемент)
	
	БанковскийСчетПриИзмененииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура БанковскийСчетПриИзмененииНаСервере()
	
	Если ЗначениеЗаполнено(БанковскийСчет) Тогда
		Организация = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(БанковскийСчет, "Владелец");
		ЭтаФорма.Заголовок = НСтр("ru='Налоги, перечисленные ранее организацией'") + " " + Организация;
	Иначе
		Организация = Неопределено;
		ЭтаФорма.Заголовок = НСтр("ru='Налоги, перечисленные ранее'");
	КонецЕсли;
	
	ТаблицаПлатежей.Параметры.УстановитьЗначениеПараметра("Организация", Организация);
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПлатежейВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОбработатьВыборПлатежа(Элемент.ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	СтрокаТаблицы = Элементы.ТаблицаПлатежей.ТекущиеДанные;
	Если СтрокаТаблицы <> Неопределено Тогда
		ОбработатьВыборПлатежа(СтрокаТаблицы);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ТекстЗапросаТаблицаПлатежей()
	
	ТекстЗапроса = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РеквизитыПлатежей.КодБК КАК КодБК,
	|	РеквизитыПлатежей.КодОКАТО КАК КодОКАТО,
	|	РеквизитыПлатежей.СтатусСоставителя КАК СтатусСоставителя,
	|	РеквизитыПлатежей.ПоказательОснования КАК ПоказательОснования,
	|	РеквизитыПлатежей.Контрагент КАК Контрагент,
	|	РеквизитыПлатежей.ТипНалога КАК ТипНалога,
	|	СписаниеБДСРасшифровка.Ссылка.Дата КАК Дата,
	|	ВЫРАЗИТЬ(СписаниеБДСРасшифровка.Ссылка.НазначениеПлатежа КАК Строка(100)) КАК НазначениеПлатежа,
	|	СписаниеБДСРасшифровка.Ссылка.БанковскийСчетКонтрагента КАК БанковскийСчетКонтрагента,
	|	СписаниеБДСРасшифровка.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	СписаниеБДСРасшифровка.СтатьяРасходов КАК СтатьяРасходов,
	|	СписаниеБДСРасшифровка.АналитикаАктивовПассивов КАК АналитикаАктивовПассивов,
	|	СписаниеБДСРасшифровка.Ссылка.Подразделение КАК Подразделение,
	|	ВЫБОР
	|		КОГДА СписаниеБДСРасшифровка.Ссылка.ИННПлательщика = """" ТОГДА
	|			ЕСТЬNULL(СписаниеБДСРасшифровка.Ссылка.Организация.ИНН, """")
	|		ИНАЧЕ
	|			СписаниеБДСРасшифровка.Ссылка.ИННПлательщика
	|	КОНЕЦ КАК ИННПлательщика,
	|	ВЫБОР
	|		КОГДА СписаниеБДСРасшифровка.Ссылка.КПППлательщика = """" ТОГДА
	|			ВЫБОР
	|				КОГДА СписаниеБДСРасшифровка.Ссылка.РегистрацияВНалоговомОргане В (
	|					ЗНАЧЕНИЕ(Справочник.РегистрацииВНалоговомОргане.ПустаяСсылка),
	|					НЕОПРЕДЕЛЕНО)
	|				ТОГДА ЕСТЬNULL(СписаниеБДСРасшифровка.Ссылка.Организация.КПП, """")
	|				ИНАЧЕ СписаниеБДСРасшифровка.Ссылка.РегистрацияВНалоговомОргане.КПП
	|			КОНЕЦ
	|	ИНАЧЕ
	|		СписаниеБДСРасшифровка.Ссылка.КПППлательщика
	|	КОНЕЦ КАК КПППлательщика,
	|	СписаниеБДСРасшифровка.Ссылка.РегистрацияВНалоговомОргане КАК РегистрацияВНалоговомОргане,
	|	РеквизитыПлатежей.Количество КАК Количество
	|ИЗ
	|	(
	|	ВЫБРАТЬ
	|		РеквизитыПлатежейГруппировка.КодБК,
	|		РеквизитыПлатежейГруппировка.КодОКАТО,
	|		РеквизитыПлатежейГруппировка.СтатусСоставителя,
	|		РеквизитыПлатежейГруппировка.ПоказательОснования,
	|		РеквизитыПлатежейГруппировка.ВидПеречисленияВБюджет,
	|		РеквизитыПлатежейГруппировка.Контрагент,
	|		РеквизитыПлатежейГруппировка.ТипНалога,
	|		РеквизитыПлатежейГруппировка.Количество,
	|		МАКСИМУМ(СписаниеБДС.Ссылка) КАК Ссылка
	|	ИЗ
	|		(ВЫБРАТЬ
	|			СписаниеБДС.КодБК КАК КодБК,
	|			СписаниеБДС.КодОКАТО КАК КодОКАТО,
	|			СписаниеБДС.СтатусСоставителя КАК СтатусСоставителя,
	|			СписаниеБДС.ПоказательОснования КАК ПоказательОснования,
	|			СписаниеБДС.ВидПеречисленияВБюджет КАК ВидПеречисленияВБюджет,
	|			СписаниеБДС.Контрагент КАК Контрагент,
	|			СписаниеБДС.ТипНалога КАК ТипНалога,
	|			КОЛИЧЕСТВО(РАЗЛИЧНЫЕ СписаниеБДС.Ссылка) КАК Количество,
	|			МАКСИМУМ(СписаниеБДС.Дата) КАК Дата
	|		ИЗ
	|			Документ.СписаниеБезналичныхДенежныхСредств КАК СписаниеБДС
	|		ГДЕ
	|			СписаниеБДС.Проведен
	|			И СписаниеБДС.ПеречислениеВБюджет
	|			И СписаниеБДС.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПеречислениеВБюджет)
	|			И СписаниеБДС.Организация = &Организация
	|			И СписаниеБДС.Дата МЕЖДУ &ДатаНач И &ДатаКон
	|			И СписаниеБДС.Ссылка <> &Ссылка
	|			И (СписаниеБДС.ТипНалога = &ТипНалогаОтбор
	|				ИЛИ &НеОтбиратьПоТипуНалога)
	|		СГРУППИРОВАТЬ ПО
	|			СписаниеБДС.КодБК,
	|			СписаниеБДС.КодОКАТО,
	|			СписаниеБДС.СтатусСоставителя,
	|			СписаниеБДС.ПоказательОснования,
	|			СписаниеБДС.ВидПеречисленияВБюджет,
	|			СписаниеБДС.Контрагент,
	|			СписаниеБДС.ТипНалога) КАК РеквизитыПлатежейГруппировка
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеБезналичныхДенежныхСредств КАК СписаниеБДС
	|	ПО
	|		СписаниеБДС.КодБК = РеквизитыПлатежейГруппировка.КодБК
	|		И СписаниеБДС.КодОКАТО = РеквизитыПлатежейГруппировка.КодОКАТО
	|		И СписаниеБДС.СтатусСоставителя = РеквизитыПлатежейГруппировка.СтатусСоставителя
	|		И СписаниеБДС.ПоказательОснования = РеквизитыПлатежейГруппировка.ПоказательОснования
	|		И СписаниеБДС.Контрагент = РеквизитыПлатежейГруппировка.Контрагент
	|		И СписаниеБДС.ТипНалога = РеквизитыПлатежейГруппировка.ТипНалога
	|		И СписаниеБДС.Дата = РеквизитыПлатежейГруппировка.Дата
	|	СГРУППИРОВАТЬ ПО
	|		РеквизитыПлатежейГруппировка.КодБК,
	|		РеквизитыПлатежейГруппировка.КодОКАТО,
	|		РеквизитыПлатежейГруппировка.СтатусСоставителя,
	|		РеквизитыПлатежейГруппировка.ПоказательОснования,
	|		РеквизитыПлатежейГруппировка.ВидПеречисленияВБюджет,
	|		РеквизитыПлатежейГруппировка.Контрагент,
	|		РеквизитыПлатежейГруппировка.ТипНалога,
	|		РеквизитыПлатежейГруппировка.Количество
	|		) КАК РеквизитыПлатежей
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеБезналичныхДенежныхСредств.РасшифровкаПлатежа КАК СписаниеБДСРасшифровка
	|	ПО
	|		СписаниеБДСРасшифровка.Ссылка = РеквизитыПлатежей.Ссылка
	|";
	
	Возврат ТекстЗапроса;
	
КонецФункции

&НаКлиенте
Процедура ОбработатьВыборПлатежа(ВыбраннаяСтрока)
	
	РезультатВыбора = Новый Структура("ТипНалога, РегистрацияВНалоговомОргане, ИННПлательщика, КПППлательщика, КодБК, КодОКАТО, СтатусСоставителя, ПоказательОснования,
		|СтатьяДвиженияДенежныхСредств, СтатьяРасходов, АналитикаАктивовПассивов, Подразделение, Контрагент, БанковскийСчетКонтрагента");
	
	РезультатВыбора.Вставить("БанковскийСчет", БанковскийСчет);
	ЗаполнитьЗначенияСвойств(РезультатВыбора, ВыбраннаяСтрока);
	
	Закрыть();
	
	ОповеститьОВыборе(РезультатВыбора);
	
КонецПроцедуры

#КонецОбласти
