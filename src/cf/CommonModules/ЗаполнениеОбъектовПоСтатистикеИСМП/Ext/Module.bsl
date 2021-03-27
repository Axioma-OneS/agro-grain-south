﻿#Область СлужебныйПрограммныйИнтерфейс

Функция ДанныеЗаполненияЗаказаНаЭмиссиюКодовМаркировкиСУЗ(Организация) Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация");
	ДанныеЗаполнения.Вставить("ВидПродукции", Перечисления.ВидыПродукцииИС.ПустаяСсылка());
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъект");
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъектАдрес");
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъектАдресСтрокой");
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъектИдентификатор");
	ДанныеЗаполнения.Вставить("ИдентификаторПроизводственнойЛинии");
	ДанныеЗаполнения.Вставить("СпособВводаВОборот");
	ДанныеЗаполнения.Вставить("НомерДоговораСОператором", "");
	ДанныеЗаполнения.Вставить("ДатаДоговораСОператором",  '00010101');
	
	ВидыПродукцииУчета = ИнтеграцияИСМПКлиентСерверПовтИсп.УчитываемыеВидыМаркируемойПродукции();
	
	Если ВидыПродукцииУчета.Количество() = 0 Тогда
		Возврат ДанныеЗаполнения;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	1                                                                    КАК Количество,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.Организация                         КАК Организация,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.ВидПродукции                        КАК ВидПродукции,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.ПроизводственныйОбъект              КАК ПроизводственныйОбъект,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.ПроизводственныйОбъектИдентификатор КАК ПроизводственныйОбъектИдентификатор,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.ПроизводственныйОбъектАдрес         КАК ПроизводственныйОбъектАдрес,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.ПроизводственныйОбъектАдресСтрокой  КАК ПроизводственныйОбъектАдресСтрокой,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.ИдентификаторПроизводственнойЛинии  КАК ИдентификаторПроизводственнойЛинии,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.СпособВводаВОборот                  КАК СпособВводаВОборот,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.НомерДоговораСОператором            КАК НомерДоговораСОператором,
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.ДатаДоговораСОператором             КАК ДатаДоговораСОператором
	|ИЗ
	|	Документ.ЗаказНаЭмиссиюКодовМаркировкиСУЗ КАК ЗаказНаЭмиссиюКодовМаркировкиСУЗ
	|ГДЕ
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.Организация = &Организация Или &БезУчетаОрганизации
	|	И ЗаказНаЭмиссиюКодовМаркировкиСУЗ.Проведен
	|УПОРЯДОЧИТЬ ПО
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗ.Дата УБЫВ");
	
	Запрос.УстановитьПараметр("Организация",         Организация);
	Запрос.УстановитьПараметр("БезУчетаОрганизации", Не ЗначениеЗаполнено(Организация));
	
	РезультатЗапроса = Запрос.Выполнить();
	ДанныеПоследнихДокументов = РезультатЗапроса.Выгрузить();
	
	ДанныеЗаполнения.ВидПродукции = ВидПродукции(ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"НомерДоговораСОператором, ДатаДоговораСОператором",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Организация",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	Если ДанныеЗаполнения.ВидПродукции = Перечисления.ВидыПродукцииИС.Табак Тогда
		
		ЗаполнитьПоСтатистике(
			"ПроизводственныйОбъект,
			|ПроизводственныйОбъектИдентификатор,
			|ПроизводственныйОбъектАдрес,
			|ПроизводственныйОбъектАдресСтрокой,
			|ИдентификаторПроизводственнойЛинии",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
		
	ИначеЕсли ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(ДанныеЗаполнения.ВидПродукции) Тогда
		
		ЗаполнитьПоСтатистике(
			"СпособВводаВОборот",
			ДанныеЗаполнения, ДанныеПоследнихДокументов);
		
	КонецЕсли;
	
	// Значения по-умолчанию
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения.ВидПродукции) Тогда
		ДанныеЗаполнения.ВидПродукции = ВидыПродукцииУчета[0];
		Если ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(ДанныеЗаполнения.ВидПродукции) Тогда
			ДанныеЗаполнения.СпособВводаВОборот = Перечисления.СпособыВводаВОборотСУЗ.Производство;
		КонецЕсли;
	КонецЕсли;
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

// Устарел. Заполненеи по статистике табличной части Товары производится с помощью
// см. ЗаполнениеОбъектовПоСтатистикеИСМП.ЗаполнитьДанныеПоТоварамЗаказаНаЭмиссиюКодовМаркировкиСУЗ
// 
// Параметры:
// 	Номенклатура
// 	Характеристика
// Возвращаемое значение:
// 	ПеречислениеСсылка.СпособыФормированияСерийногоНомераСУЗ - Описание
Функция СпособФормированияСерийногоНомераПоСтатистике(Номенклатура, Характеристика) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СпособФормированияСерийногоНомера КАК СпособФормирования,
	|	1                                                                        КАК Количество
	|ИЗ
	|	Документ.ЗаказНаЭмиссиюКодовМаркировкиСУЗ.Товары КАК ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары
	|ГДЕ
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Номенклатура = &Номенклатура
	|	И ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Характеристика = &Характеристика
	|УПОРЯДОЧИТЬ ПО
	|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Дата УБЫВ");
	Запрос.УстановитьПараметр("Номенклатура",   Номенклатура);
	Запрос.УстановитьПараметр("Характеристика", Характеристика);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Перечисления.СпособыФормированияСерийногоНомераСУЗ.Автоматически;
	КонецЕсли;
	
	ДанныеСтатистики = РезультатЗапроса.Выгрузить();
	ДанныеСтатистики.Свернуть("СпособФормирования", "Количество");
	ДанныеСтатистики.Сортировать("Количество Убыв");
	
	Возврат ДанныеСтатистики[0].СпособФормирования;
	
КонецФункции

Функция ДанныеЗаполненияМаркировкиТоваровИСМП(Организация) Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация");
	ДанныеЗаполнения.Вставить("ВидПродукции", Перечисления.ВидыПродукцииИС.ПустаяСсылка());
	ДанныеЗаполнения.Вставить("Операция");
	ДанныеЗаполнения.Вставить("КодТаможенногоОргана");
	ДанныеЗаполнения.Вставить("ПринятоеРешение");
	ДанныеЗаполнения.Вставить("СтранаПроисхождения");
	ДанныеЗаполнения.Вставить("ИдентификаторПроизводственнойЛинии");
	
	ВидыПродукцииУчета = ИнтеграцияИСМПКлиентСерверПовтИсп.УчитываемыеВидыМаркируемойПродукции();
	
	Если ВидыПродукцииУчета.Количество() = 0 Тогда
		Возврат ДанныеЗаполнения;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	1                                          КАК Количество,
	|	МаркировкаТоваровИСМП.Организация          КАК Организация,
	|	МаркировкаТоваровИСМП.Операция             КАК Операция,
	|	МаркировкаТоваровИСМП.ВидПродукции         КАК ВидПродукции,
	|	МаркировкаТоваровИСМП.КодТаможенногоОргана               КАК КодТаможенногоОргана,
	|	МаркировкаТоваровИСМП.ПринятоеРешение                    КАК ПринятоеРешение,
	|	МаркировкаТоваровИСМП.СтранаПроисхождения                КАК СтранаПроисхождения,
	|	МаркировкаТоваровИСМП.ИдентификаторПроизводственнойЛинии КАК ИдентификаторПроизводственнойЛинии
	|ИЗ
	|	Документ.МаркировкаТоваровИСМП КАК МаркировкаТоваровИСМП
	|ГДЕ
	|	МаркировкаТоваровИСМП.Организация = &Организация Или &БезУчетаОрганизации
	|	И МаркировкаТоваровИСМП.Проведен
	|УПОРЯДОЧИТЬ ПО
	|	МаркировкаТоваровИСМП.Дата УБЫВ");
	
	Запрос.УстановитьПараметр("Организация",         Организация);
	Запрос.УстановитьПараметр("БезУчетаОрганизации", Не ЗначениеЗаполнено(Организация));
	
	РезультатЗапроса = Запрос.Выполнить();
	ДанныеПоследнихДокументов = РезультатЗапроса.Выгрузить();
	
	ДанныеЗаполнения.ВидПродукции = ВидПродукции(ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Операция",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Организация",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	Если ДанныеЗаполнения.ВидПродукции = Перечисления.ВидыПродукцииИС.Табак Тогда
		
		ЗаполнитьПоСтатистике(
			"ИдентификаторПроизводственнойЛинии",
			ДанныеЗаполнения, ДанныеПоследнихДокументов);
		
	ИначеЕсли ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(ДанныеЗаполнения.ВидПродукции) Тогда
		
		ЗаполнитьПоСтатистике(
			"КодТаможенногоОргана, ПринятоеРешение, СтранаПроисхождения",
			ДанныеЗаполнения, ДанныеПоследнихДокументов);
		
	КонецЕсли;
	
	// Значения по-умолчанию
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения.ВидПродукции) Тогда
		ДоступныеВидыПродукцииИС = ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП();
		Для Каждого ВидПродукцииУчета Из ВидыПродукцииУчета Цикл
			Если ДоступныеВидыПродукцииИС.Найти(ВидПродукцииУчета) <> Неопределено Тогда
				
				ДанныеЗаполнения.ВидПродукции = ВидПродукцииУчета;
				
				Если ДанныеЗаполнения.ВидПродукции = Перечисления.ВидыПродукцииИС.Табак Тогда
					ДанныеЗаполнения.Операция = Перечисления.ВидыОперацийИСМП.ОтчетОВерификацииНанесенныхКМ;
				ИначеЕсли ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(ДанныеЗаполнения.ВидПродукции) Тогда
					ДанныеЗаполнения.Операция = Перечисления.ВидыОперацийИСМП.ВводВОборотПроизводствоРФ;
				КонецЕсли;
				
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

Функция ДанныеЗаполненияСписанияКодовМаркировкиИСМП(Организация) Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация");
	ДанныеЗаполнения.Вставить("ВидПродукции", Перечисления.ВидыПродукцииИС.ПустаяСсылка());
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъект");
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъектАдрес");
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъектАдресСтрокой");
	ДанныеЗаполнения.Вставить("ПроизводственныйОбъектИдентификатор");
	ДанныеЗаполнения.Вставить("ИдентификаторПроизводственнойЛинии");
	ДанныеЗаполнения.Вставить("ПричинаСписания");
	
	ВидыПродукцииУчета = ИнтеграцияИСМПКлиентСерверПовтИсп.УчитываемыеВидыМаркируемойПродукции();
	
	Если ВидыПродукцииУчета.Количество() = 0 Тогда
		Возврат ДанныеЗаполнения;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	1                                                               КАК Количество,
	|	СписаниеКодовМаркировкиИСМП.Организация                         КАК Организация,
	|	СписаниеКодовМаркировкиИСМП.ВидПродукции                        КАК ВидПродукции,
	|	СписаниеКодовМаркировкиИСМП.ПричинаСписания                     КАК ПричинаСписания,
	|	СписаниеКодовМаркировкиИСМП.ПроизводственныйОбъект              КАК ПроизводственныйОбъект,
	|	СписаниеКодовМаркировкиИСМП.ПроизводственныйОбъектИдентификатор КАК ПроизводственныйОбъектИдентификатор,
	|	СписаниеКодовМаркировкиИСМП.ПроизводственныйОбъектАдрес         КАК ПроизводственныйОбъектАдрес,
	|	СписаниеКодовМаркировкиИСМП.ПроизводственныйОбъектАдресСтрокой  КАК ПроизводственныйОбъектАдресСтрокой,
	|	СписаниеКодовМаркировкиИСМП.ИдентификаторПроизводственнойЛинии  КАК ИдентификаторПроизводственнойЛинии
	|ИЗ
	|	Документ.СписаниеКодовМаркировкиИСМП КАК СписаниеКодовМаркировкиИСМП
	|ГДЕ
	|	СписаниеКодовМаркировкиИСМП.Организация = &Организация Или &БезУчетаОрганизации
	|	И СписаниеКодовМаркировкиИСМП.Проведен
	|УПОРЯДОЧИТЬ ПО
	|	СписаниеКодовМаркировкиИСМП.Дата УБЫВ");
	
	Запрос.УстановитьПараметр("Организация",         Организация);
	Запрос.УстановитьПараметр("БезУчетаОрганизации", Не ЗначениеЗаполнено(Организация));
	
	РезультатЗапроса = Запрос.Выполнить();
	ДанныеПоследнихДокументов = РезультатЗапроса.Выгрузить();
	
	ДанныеЗаполнения.ВидПродукции = ВидПродукции(ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Организация",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	Если ДанныеЗаполнения.ВидПродукции = Перечисления.ВидыПродукцииИС.Табак Тогда
		
		ЗаполнитьПоСтатистике(
			"ПроизводственныйОбъект,
			|ПроизводственныйОбъектИдентификатор,
			|ПроизводственныйОбъектАдрес,
			|ПроизводственныйОбъектАдресСтрокой,
			|ИдентификаторПроизводственнойЛинии",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
		
		ЗаполнитьПоСтатистике(
			"ПричинаСписания",
			ДанныеЗаполнения, ДанныеПоследнихДокументов);
		
	КонецЕсли;
	
	// Значения по-умолчанию
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения.ВидПродукции) Тогда
		ДанныеЗаполнения.ВидПродукции = ВидыПродукцииУчета[0];
		Если ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(ДанныеЗаполнения.ВидПродукции) Тогда
			ДанныеЗаполнения.ПричинаСписания = Перечисления.ПричиныСписанияКодовМаркировкиИСМП.Испорчен;
		КонецЕсли;
	КонецЕсли;
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

Функция ДанныеЗаполненияВыводаИзОборотаИСМП(Организация) Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация");
	ДанныеЗаполнения.Вставить("ВидПродукции", Перечисления.ВидыПродукцииИС.ПустаяСсылка());
	ДанныеЗаполнения.Вставить("Операция");
	ДанныеЗаполнения.Вставить("ВидПервичногоДокумента");
	ДанныеЗаполнения.Вставить("НаименованиеПервичногоДокумента");
	
	ВидыПродукцииУчета = ИнтеграцияИСМПКлиентСерверПовтИсп.УчитываемыеВидыМаркируемойПродукции();
	
	Если ВидыПродукцииУчета.Количество() = 0 Тогда
		Возврат ДанныеЗаполнения;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	1                                                  КАК Количество,
	|	ВыводИзОборотаИСМП.Организация                     КАК Организация,
	|	ВыводИзОборотаИСМП.ВидПродукции                    КАК ВидПродукции,
	|	ВыводИзОборотаИСМП.Операция                        КАК Операция,
	|	ВыводИзОборотаИСМП.ВидПервичногоДокумента          КАК ВидПервичногоДокумента,
	|	ВыводИзОборотаИСМП.НаименованиеПервичногоДокумента КАК НаименованиеПервичногоДокумента
	|ИЗ
	|	Документ.ВыводИзОборотаИСМП КАК ВыводИзОборотаИСМП
	|ГДЕ
	|	ВыводИзОборотаИСМП.Организация = &Организация Или &БезУчетаОрганизации
	|	И ВыводИзОборотаИСМП.Проведен
	|УПОРЯДОЧИТЬ ПО
	|	ВыводИзОборотаИСМП.Дата УБЫВ");
	
	Запрос.УстановитьПараметр("Организация",         Организация);
	Запрос.УстановитьПараметр("БезУчетаОрганизации", Не ЗначениеЗаполнено(Организация));
	
	РезультатЗапроса = Запрос.Выполнить();
	ДанныеПоследнихДокументов = РезультатЗапроса.Выгрузить();
	
	ДанныеЗаполнения.ВидПродукции = ВидПродукции(ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Операция",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Организация",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"ВидПервичногоДокумента, НаименованиеПервичногоДокумента",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	// Значения по-умолчанию
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения.ВидПродукции) Тогда
		ДоступныеВидыПродукцииИС = ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП();
		Для Каждого ВидПродукцииУчета Из ВидыПродукцииУчета Цикл
			Если ДоступныеВидыПродукцииИС.Найти(ВидПродукцииУчета) <> Неопределено Тогда
				ДанныеЗаполнения.ВидПродукции = ВидПродукцииУчета;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

Функция ДанныеЗаполненияОтгрузкиТоваровИСМП(Организация) Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация");
	ДанныеЗаполнения.Вставить("Операция");
	
	ДанныеЗаполнения.Вставить("ВидПродукции", Перечисления.ВидыПродукцииИС.ПустаяСсылка());
	ДанныеЗаполнения.Вставить("Контрагент",   ИнтеграцияИС.ПустоеЗначениеОпределяемогоТипа("КонтрагентГосИС"));
	
	ВидыПродукцииУчета = ИнтеграцияИСМПКлиентСерверПовтИсп.УчитываемыеВидыМаркируемойПродукции();
	
	Если ВидыПродукцииУчета.Количество() = 0 Тогда
		Возврат ДанныеЗаполнения;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	1                                                   КАК Количество,
	|	ОтгрузкаТоваровИСМП.Организация                     КАК Организация,
	|	ОтгрузкаТоваровИСМП.ВидПродукции                    КАК ВидПродукции,
	|	ОтгрузкаТоваровИСМП.Операция                        КАК Операция,
	|	ОтгрузкаТоваровИСМП.Контрагент                      КАК Контрагент
	|ИЗ
	|	Документ.ОтгрузкаТоваровИСМП КАК ОтгрузкаТоваровИСМП
	|ГДЕ
	|	ОтгрузкаТоваровИСМП.Организация = &Организация Или &БезУчетаОрганизации
	|	И ОтгрузкаТоваровИСМП.Проведен
	|УПОРЯДОЧИТЬ ПО
	|	ОтгрузкаТоваровИСМП.Дата УБЫВ");
	
	Запрос.УстановитьПараметр("Организация",         Организация);
	Запрос.УстановитьПараметр("БезУчетаОрганизации", Не ЗначениеЗаполнено(Организация));
	
	РезультатЗапроса = Запрос.Выполнить();
	ДанныеПоследнихДокументов = РезультатЗапроса.Выгрузить();
	
	ДанныеЗаполнения.ВидПродукции = ВидПродукции(ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Операция",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Организация",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Контрагент",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	// Значения по-умолчанию
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения.ВидПродукции) Тогда
		ДоступныеВидыПродукцииИС = ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП();
		Для Каждого ВидПродукцииУчета Из ВидыПродукцииУчета Цикл
			Если ДоступныеВидыПродукцииИС.Найти(ВидПродукцииУчета) <> Неопределено Тогда
				ДанныеЗаполнения.ВидПродукции = ВидПродукцииУчета;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

Функция ДанныеЗаполненияВозвратаВОборотИСМП(Организация) Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация");
	ДанныеЗаполнения.Вставить("ВидПродукции", Перечисления.ВидыПродукцииИС.ПустаяСсылка());
	ДанныеЗаполнения.Вставить("Операция");
	
	ВидыПродукцииУчета = ИнтеграцияИСМПКлиентСерверПовтИсп.УчитываемыеВидыМаркируемойПродукции();
	
	Если ВидыПродукцииУчета.Количество() = 0 Тогда
		Возврат ДанныеЗаполнения;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	1                               КАК Количество,
	|	ВозвратВОборотИСМП.Организация  КАК Организация,
	|	ВозвратВОборотИСМП.ВидПродукции КАК ВидПродукции,
	|	ВозвратВОборотИСМП.Операция     КАК Операция
	|ИЗ
	|	Документ.ВозвратВОборотИСМП КАК ВозвратВОборотИСМП
	|ГДЕ
	|	ВозвратВОборотИСМП.Организация = &Организация Или &БезУчетаОрганизации
	|	И ВозвратВОборотИСМП.Проведен
	|УПОРЯДОЧИТЬ ПО
	|	ВозвратВОборотИСМП.Дата УБЫВ");
	
	Запрос.УстановитьПараметр("Организация",         Организация);
	Запрос.УстановитьПараметр("БезУчетаОрганизации", Не ЗначениеЗаполнено(Организация));
	
	РезультатЗапроса = Запрос.Выполнить();
	ДанныеПоследнихДокументов = РезультатЗапроса.Выгрузить();
	
	ДанныеЗаполнения.ВидПродукции = ВидПродукции(ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Операция",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Организация",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	// Значения по-умолчанию
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения.ВидПродукции) Тогда
		ДоступныеВидыПродукцииИС = ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП();
		Для Каждого ВидПродукцииУчета Из ВидыПродукцииУчета Цикл
			Если ДоступныеВидыПродукцииИС.Найти(ВидПродукцииУчета) <> Неопределено Тогда
				ДанныеЗаполнения.ВидПродукции = ВидПродукцииУчета;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

Функция ДанныеЗаполненияПеремаркировкиТоваровИСМП(Организация) Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация");
	ДанныеЗаполнения.Вставить("ВидПродукции", Перечисления.ВидыПродукцииИС.ПустаяСсылка());
	
	ВидыПродукцииУчета = ИнтеграцияИСМПКлиентСерверПовтИсп.УчитываемыеВидыМаркируемойПродукции();
	
	Если ВидыПродукцииУчета.Количество() = 0 Тогда
		Возврат ДанныеЗаполнения;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 3
	|	1                               КАК Количество,
	|	ПеремаркировкаТоваровИСМП.Организация  КАК Организация,
	|	ПеремаркировкаТоваровИСМП.ВидПродукции КАК ВидПродукции
	|ИЗ
	|	Документ.ПеремаркировкаТоваровИСМП КАК ПеремаркировкаТоваровИСМП
	|ГДЕ
	|	ПеремаркировкаТоваровИСМП.Организация = &Организация Или &БезУчетаОрганизации
	|	И ПеремаркировкаТоваровИСМП.Проведен
	|УПОРЯДОЧИТЬ ПО
	|	ПеремаркировкаТоваровИСМП.Дата УБЫВ");
	
	Запрос.УстановитьПараметр("Организация",         Организация);
	Запрос.УстановитьПараметр("БезУчетаОрганизации", Не ЗначениеЗаполнено(Организация));
	
	РезультатЗапроса = Запрос.Выполнить();
	ДанныеПоследнихДокументов = РезультатЗапроса.Выгрузить();
	
	ДанныеЗаполнения.ВидПродукции = ВидПродукции(ДанныеПоследнихДокументов);
	
	ЗаполнитьПоСтатистике(
		"Организация",
		ДанныеЗаполнения, ДанныеПоследнихДокументов);
	
	// Значения по-умолчанию
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения.ВидПродукции) Тогда
		ДоступныеВидыПродукцииИС = ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП();
		Для Каждого ВидПродукцииУчета Из ВидыПродукцииУчета Цикл
			Если ДоступныеВидыПродукцииИС.Найти(ВидПродукцииУчета) <> Неопределено Тогда
				ДанныеЗаполнения.ВидПродукции = ВидПродукцииУчета;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

Процедура ЗаполнитьПустойРеквизит(Объект, ДанныеСтатистики, ИмяРеквизита) Экспорт
	
	Если Не ЗначениеЗаполнено(Объект[ИмяРеквизита]) Тогда
		Объект[ИмяРеквизита] = ДанныеСтатистики[ИмяРеквизита];
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуДаннымиЗаполнения(ИсходныеДанные, ДанныеДляЗаполнения, ПоляИсключения = "") Экспорт

	Для Каждого СтрокаДанных Из ДанныеДляЗаполнения Цикл
		СтрокаТовары = ИсходныеДанные.Получить(СтрокаДанных.ИндексИсходнойСтроки);
		Если ЗначениеЗаполнено(СтрокаТовары.Номенклатура) Тогда
			ЗаполнитьЗначенияСвойств(СтрокаТовары, СтрокаДанных,, ПоляИсключения);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьТабличнуюЧастьТоварыЗаказаНаЭмиссиюКодовМаркировкиСУЗ(Объект, ПропускатьЗаполнениеGTIN) Экспорт
	
	ЗаполнитьДанныеПоТоварамЗаказаНаЭмиссиюКодовМаркировкиСУЗ(Объект.Товары, Объект, Неопределено, ПропускатьЗаполнениеGTIN);
	
КонецПроцедуры

Процедура ЗаполнитьДанныеПоТоварамЗаказаНаЭмиссиюКодовМаркировкиСУЗ(ИсходныеДанные, Объект, ПолеОтслеживанияНовойСтроки = Неопределено, ПропускатьЗаполнениеGTIN = Ложь) Экспорт
	
	Если ТипЗнч(ИсходныеДанные) = Тип("ТаблицаЗначений") Тогда
		ВременнаяТаблица = ИсходныеДанные;
	Иначе
		ВременнаяТаблица = ИсходныеДанные.Выгрузить(
			, "Номенклатура, Характеристика, СпособФормированияСерийногоНомера");
	КонецЕсли;
	
	ПронумероватьИсходнуюТаблицуДанныхЗаполнения(ВременнаяТаблица, ПолеОтслеживанияНовойСтроки);
	
	Если Объект.СпособВводаВОборот = Перечисления.СпособыВводаВОборотСУЗ.МаркировкаОстатков Тогда
		ТаблицаДанных = ДанныеЗаполненияТоварыЗаказНаЭмиссиюСУЗМаркировкаОстатков(ВременнаяТаблица, Объект);
	Иначе
		ТаблицаДанных = ДанныеЗаполненияТоварыЗаказНаЭмиссиюСУЗ(ВременнаяТаблица, Объект.Организация);
	КонецЕсли;
	
	Если ПропускатьЗаполнениеGTIN Тогда
		ПоляИсключения = "GTIN";
	КонецЕсли;
	
	ЗаполнитьТаблицуДаннымиЗаполнения(ИсходныеДанные, ТаблицаДанных, ПоляИсключения);
	
КонецПроцедуры

Процедура ЗаполнитьСтрокуТаблицыТоварыЗаказаНаЭмиссиюКодмаМаркировки(ДанныеСтроки, Объект) Экспорт
	
	ТаблицаДанных = Новый ТаблицаЗначений();
	ТаблицаДанных.Колонки.Добавить("Номенклатура",   Метаданные.ОпределяемыеТипы.Номенклатура.Тип);
	ТаблицаДанных.Колонки.Добавить("Характеристика", Метаданные.ОпределяемыеТипы.ХарактеристикаНоменклатуры.Тип);
	ТаблицаДанных.Колонки.Добавить("GTIN",           Метаданные.ОпределяемыеТипы.GTIN.Тип);
	ТаблицаДанных.Колонки.Добавить("ЦелевойПол");
	ТаблицаДанных.Колонки.Добавить("СпособВводаВОборот");
	ТаблицаДанных.Колонки.Добавить("СпособФормированияСерийногоНомера");
	
	НоваяСтрока = ТаблицаДанных.Добавить();
	ЗаполнитьЗначенияСвойств(НоваяСтрока, ДанныеСтроки);
	
	ЗаполнениеОбъектовПоСтатистикеИСМП.ЗаполнитьДанныеПоТоварамЗаказаНаЭмиссиюКодовМаркировкиСУЗ(
		ТаблицаДанных, Объект);
	
	ЗаполнитьЗначенияСвойств(ДанныеСтроки, ТаблицаДанных.Получить(0));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДанныеЗаполненияТоварыЗаказНаЭмиссиюСУЗ(ИсходнаяТаблица, Организация) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ТаблицаТовары.ИндексИсходнойСтроки КАК ИндексИсходнойСтроки,
		|	ТаблицаТовары.Номенклатура         КАК Номенклатура,
		|	ТаблицаТовары.Характеристика       КАК Характеристика
		|ПОМЕСТИТЬ ВременнаяТаблицаТовары
		|ИЗ
		|	&ТаблицаТовары КАК ТаблицаТовары
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура,
		|	Характеристика
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ВременнаяТаблицаТовары.ИндексИсходнойСтроки                              КАК ИндексИсходнойСтроки,
		|	ВременнаяТаблицаТовары.Номенклатура                                      КАК Номенклатура,
		|	ВременнаяТаблицаТовары.Характеристика                                    КАК Характеристика,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СпособФормированияСерийногоНомера КАК СпособФормированияСерийногоНомера,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Шаблон                            КАК Шаблон,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СтатусУказанияСерии               КАК СтатусУказанияСерии,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.GTIN                              КАК GTIN,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка                            КАК Ссылка,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Дата                       КАК Дата
		|ПОМЕСТИТЬ ДокументыПоНоменклатуре
		|ИЗ
		|	ВременнаяТаблицаТовары КАК ВременнаяТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаЭмиссиюКодовМаркировкиСУЗ.Товары КАК ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары
		|		ПО ВременнаяТаблицаТовары.Номенклатура = ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Номенклатура
		|			И ВременнаяТаблицаТовары.Характеристика = ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Характеристика
		|			И (ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Проведен)
		|			И (ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Организация = &Организация)
		|			И (НЕ ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.СпособВводаВОборот = ЗНАЧЕНИЕ(Перечисление.СпособыВводаВОборотСУЗ.МаркировкаОстатков))
		|
		|СГРУППИРОВАТЬ ПО
		|	ВременнаяТаблицаТовары.ИндексИсходнойСтроки,
		|	ВременнаяТаблицаТовары.Номенклатура,
		|	ВременнаяТаблицаТовары.Характеристика,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СпособФормированияСерийногоНомера,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Шаблон,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СтатусУказанияСерии,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.GTIN,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Дата
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура,
		|	Характеристика,
		|	Дата
		|	
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДокументыПоНоменклатуре.Номенклатура   КАК Номенклатура,
		|	ДокументыПоНоменклатуре.Характеристика КАК Характеристика,
		|	МАКСИМУМ(ДокументыПоНоменклатуре.Дата) КАК Дата
		|ПОМЕСТИТЬ ГруппировкаПоМаксимальнойДатеДокумента
		|ИЗ
		|	ДокументыПоНоменклатуре КАК ДокументыПоНоменклатуре
		|
		|СГРУППИРОВАТЬ ПО
		|	ДокументыПоНоменклатуре.Характеристика,
		|	ДокументыПоНоменклатуре.Номенклатура
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура,
		|	Характеристика,
		|	Дата
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВременнаяТаблицаТовары.ИндексИсходнойСтроки              КАК ИндексИсходнойСтроки,
		|	ВременнаяТаблицаТовары.Номенклатура                      КАК Номенклатура,
		|	ВременнаяТаблицаТовары.Характеристика                    КАК Характеристика,
		|	ЕСТЬNULL(ДокументыПоНоменклатуре.СпособФормированияСерийногоНомера,
		|		ЗНАЧЕНИЕ(Перечисление.СпособыФормированияСерийногоНомераСУЗ.Автоматически)) КАК СпособФормированияСерийногоНомера,
		|	ВЫБОР
		|		КОГДА ЕСТЬNULL(ДокументыПоНоменклатуре.СпособФормированияСерийногоНомера, ЗНАЧЕНИЕ(Перечисление.СпособыФормированияСерийногоНомераСУЗ.Автоматически)) = ЗНАЧЕНИЕ(Перечисление.СпособыФормированияСерийногоНомераСУЗ.Автоматически)
		|			ТОГДА 2
		|			ИНАЧЕ ЕСТЬNULL(ДокументыПоНоменклатуре.СтатусУказанияСерии, 2)
		|	КОНЕЦ КАК СтатусУказанияСерии,
		|	ДокументыПоНоменклатуре.GTIN                             КАК GTIN,
		|	ДокументыПоНоменклатуре.Шаблон                           КАК Шаблон
		|ИЗ
		|	ВременнаяТаблицаТовары КАК ВременнаяТаблицаТовары
		|		ЛЕВОЕ СОЕДИНЕНИЕ ДокументыПоНоменклатуре КАК ДокументыПоНоменклатуре
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ГруппировкаПоМаксимальнойДатеДокумента КАК ГруппировкаПоМаксимальнойДатеДокумента
		|			ПО ДокументыПоНоменклатуре.Номенклатура      = ГруппировкаПоМаксимальнойДатеДокумента.Номенклатура
		|				И ДокументыПоНоменклатуре.Характеристика = ГруппировкаПоМаксимальнойДатеДокумента.Характеристика
		|				И ДокументыПоНоменклатуре.Дата           = ГруппировкаПоМаксимальнойДатеДокумента.Дата
		|		ПО ВременнаяТаблицаТовары.Номенклатура      = ДокументыПоНоменклатуре.Номенклатура
		|			И ВременнаяТаблицаТовары.Характеристика = ДокументыПоНоменклатуре.Характеристика";
	
	Запрос.УстановитьПараметр("ТаблицаТовары", ИсходнаяТаблица);
	Запрос.УстановитьПараметр("Организация",   Организация);
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

Функция ДанныеЗаполненияТоварыЗаказНаЭмиссиюСУЗМаркировкаОстатков(ИсходнаяТаблица, Объект) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ТаблицаТовары.ИндексИсходнойСтроки КАК ИндексИсходнойСтроки,
		|	ТаблицаТовары.Номенклатура         КАК Номенклатура,
		|	ТаблицаТовары.Характеристика       КАК Характеристика
		|ПОМЕСТИТЬ ВременнаяТаблицаТовары
		|ИЗ
		|	&ТаблицаТовары КАК ТаблицаТовары
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура,
		|	Характеристика
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ВременнаяТаблицаТовары.ИндексИсходнойСтроки                              КАК ИндексИсходнойСтроки,
		|	ВременнаяТаблицаТовары.Номенклатура                                      КАК Номенклатура,
		|	ВременнаяТаблицаТовары.Характеристика                                    КАК Характеристика,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.GTIN                              КАК GTIN,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Шаблон                            КАК Шаблон,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.ЦелевойПол                        КАК ЦелевойПол,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Модель                            КАК Модель,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.ТоварныйЗнак                      КАК ТоварныйЗнак,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.ВозрастнаяКатегория               КАК ВозрастнаяКатегория,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СпособВводаВОборот                КАК СпособВводаВОборот,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СпособФормированияСерийногоНомера КАК СпособФормированияСерийногоНомера,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СтатусУказанияСерии               КАК СтатусУказанияСерии,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка                            КАК Ссылка,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Дата                       КАК Дата
		|ПОМЕСТИТЬ ДокументыПоНоменклатуре
		|ИЗ
		|	ВременнаяТаблицаТовары КАК ВременнаяТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаЭмиссиюКодовМаркировкиСУЗ.Товары КАК ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары
		|		ПО ВременнаяТаблицаТовары.Номенклатура = ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Номенклатура
		|			И ВременнаяТаблицаТовары.Характеристика = ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Характеристика
		|			И (ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Проведен)
		|			И (ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Организация = &Организация)
		|			И (ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.ВидПродукции = &ВидПродукции)
		|			И (ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.СпособВводаВОборот = ЗНАЧЕНИЕ(Перечисление.СпособыВводаВОборотСУЗ.МаркировкаОстатков))
		|
		|СГРУППИРОВАТЬ ПО
		|	ВременнаяТаблицаТовары.ИндексИсходнойСтроки,
		|	ВременнаяТаблицаТовары.Номенклатура,
		|	ВременнаяТаблицаТовары.Характеристика,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.GTIN,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Шаблон,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.ЦелевойПол,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Модель,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.ТоварныйЗнак,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.ВозрастнаяКатегория,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СпособВводаВОборот,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СпособФормированияСерийногоНомера,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.СтатусУказанияСерии,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка,
		|	ЗаказНаЭмиссиюКодовМаркировкиСУЗТовары.Ссылка.Дата
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура,
		|	Характеристика,
		|	Дата
		|	
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДокументыПоНоменклатуре.Номенклатура   КАК Номенклатура,
		|	ДокументыПоНоменклатуре.Характеристика КАК Характеристика,
		|	МАКСИМУМ(ДокументыПоНоменклатуре.Дата) КАК Дата
		|ПОМЕСТИТЬ ГруппировкаПоМаксимальнойДатеДокумента
		|ИЗ
		|	ДокументыПоНоменклатуре КАК ДокументыПоНоменклатуре
		|
		|СГРУППИРОВАТЬ ПО
		|	ДокументыПоНоменклатуре.Характеристика,
		|	ДокументыПоНоменклатуре.Номенклатура
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура,
		|	Характеристика,
		|	Дата
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВременнаяТаблицаТовары.ИндексИсходнойСтроки               КАК ИндексИсходнойСтроки,
		|	ВременнаяТаблицаТовары.Номенклатура                       КАК Номенклатура,
		|	ВременнаяТаблицаТовары.Характеристика                     КАК Характеристика,
		|	ДокументыПоНоменклатуре.GTIN                              КАК GTIN,
		|	ДокументыПоНоменклатуре.Шаблон                            КАК Шаблон,
		|	ДокументыПоНоменклатуре.ЦелевойПол                        КАК ЦелевойПол,
		|	ДокументыПоНоменклатуре.Модель                            КАК Модель,
		|	ДокументыПоНоменклатуре.ТоварныйЗнак                      КАК ТоварныйЗнак,
		|	ДокументыПоНоменклатуре.ВозрастнаяКатегория               КАК ВозрастнаяКатегория,
		|	ДокументыПоНоменклатуре.СпособВводаВОборот                КАК СпособВводаВОборот,
		|	ЕСТЬNULL(ДокументыПоНоменклатуре.СпособФормированияСерийногоНомера,
		|		ЗНАЧЕНИЕ(Перечисление.СпособыФормированияСерийногоНомераСУЗ.Автоматически)) КАК СпособФормированияСерийногоНомера,
		|	ВЫБОР
		|		КОГДА ЕСТЬNULL(ДокументыПоНоменклатуре.СпособФормированияСерийногоНомера, ЗНАЧЕНИЕ(Перечисление.СпособыФормированияСерийногоНомераСУЗ.Автоматически)) = ЗНАЧЕНИЕ(Перечисление.СпособыФормированияСерийногоНомераСУЗ.Автоматически)
		|			ТОГДА 2
		|			ИНАЧЕ ЕСТЬNULL(ДокументыПоНоменклатуре.СтатусУказанияСерии, 2)
		|	КОНЕЦ КАК СтатусУказанияСерии
		|ИЗ
		|	ВременнаяТаблицаТовары КАК ВременнаяТаблицаТовары
		|		ЛЕВОЕ СОЕДИНЕНИЕ ДокументыПоНоменклатуре КАК ДокументыПоНоменклатуре
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ГруппировкаПоМаксимальнойДатеДокумента КАК ГруппировкаПоМаксимальнойДатеДокумента
		|			ПО ДокументыПоНоменклатуре.Номенклатура      = ГруппировкаПоМаксимальнойДатеДокумента.Номенклатура
		|				И ДокументыПоНоменклатуре.Характеристика = ГруппировкаПоМаксимальнойДатеДокумента.Характеристика
		|				И ДокументыПоНоменклатуре.Дата           = ГруппировкаПоМаксимальнойДатеДокумента.Дата
		|		ПО ВременнаяТаблицаТовары.Номенклатура      = ДокументыПоНоменклатуре.Номенклатура
		|			И ВременнаяТаблицаТовары.Характеристика = ДокументыПоНоменклатуре.Характеристика";
	
	Запрос.УстановитьПараметр("ТаблицаТовары", ИсходнаяТаблица);
	Запрос.УстановитьПараметр("Организация",   Объект.Организация);
	Запрос.УстановитьПараметр("ВидПродукции",  Объект.ВидПродукции);
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

Процедура ПронумероватьИсходнуюТаблицуДанныхЗаполнения(ИсходнаяТаблица, ПолеОтслеживанияНовойСтроки = Неопределено) Экспорт
	
	Если ИсходнаяТаблица.Колонки.Найти("ИндексИсходнойСтроки") = Неопределено Тогда
		ИсходнаяТаблица.Колонки.Добавить("ИндексИсходнойСтроки", ОбщегоНазначения.ОписаниеТипаЧисло(5));
	КонецЕсли;
	
	МассивСтрокДляУдаления = Новый Массив;
	
	Для Каждого СтрокаТаблицы Из ИсходнаяТаблица Цикл
		СтрокаТаблицы.ИндексИсходнойСтроки = ИсходнаяТаблица.Индекс(СтрокаТаблицы);
		Если ЗначениеЗаполнено(ПолеОтслеживанияНовойСтроки)
			И ЗначениеЗаполнено(СтрокаТаблицы[ПолеОтслеживанияНовойСтроки]) Тогда
			МассивСтрокДляУдаления.Добавить(СтрокаТаблицы);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого УдаляемаяСтрока Из МассивСтрокДляУдаления Цикл
		ИсходнаяТаблица.Удалить(ИсходнаяТаблица.Индекс(УдаляемаяСтрока));
	КонецЦикла;
	
КонецПроцедуры

Функция ВидПродукции(ДанныеПоследнихДокументов)
	
	ДанныеАнализа = ДанныеПоследнихДокументов.Скопировать(,"ВидПродукции, Количество");
	ДанныеАнализа.Свернуть("ВидПродукции", "Количество");
	ДанныеАнализа.Сортировать("Количество Убыв");
	Если ДанныеАнализа.Количество() > 0 Тогда
		ВидПродукции = ДанныеАнализа[0].ВидПродукции;
	КонецЕсли;
	
	Если Не ИнтеграцияИСМПКлиентСерверПовтИсп.ВестиУчетМаркируемойПродукции(ВидПродукции) Тогда
		ВидПродукции = Неопределено;
	КонецЕсли;
	
	Возврат ВидПродукции;
	
КонецФункции

Процедура ЗаполнитьПоСтатистике(Поля, ДанныеЗаполнения, ДанныеПоследнихДокументов)
	
	Если ДанныеЗаполнения.ВидПродукции <> Неопределено Тогда
		ОтборПоВидуПродукции = Новый Структура("ВидПродукции", ДанныеЗаполнения.ВидПродукции);
	Иначе
		ОтборПоВидуПродукции = Неопределено;
	КонецЕсли;
	
	ЗаполняемыеПоля = СтрРазделить(Поля, ",");
	
	РезультатыАнализа = ДанныеПоследнихДокументов.Скопировать(
		ОтборПоВидуПродукции, Поля + ", Количество");
	
	РезультатыАнализа.Свернуть(Поля, "Количество");
	РезультатыАнализа.Сортировать("Количество Убыв");
	Если РезультатыАнализа.Количество() > 0 Тогда
		Для Каждого Поле Из ЗаполняемыеПоля Цикл
			ДанныеЗаполнения[СокрЛП(Поле)] = РезультатыАнализа[0][СокрЛП(Поле)];
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
