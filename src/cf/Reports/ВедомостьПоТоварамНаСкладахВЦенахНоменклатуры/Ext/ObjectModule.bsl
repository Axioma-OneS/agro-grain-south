﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - Структура - см. возвращаемое значение ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	Настройки.События.ПередЗагрузкойВариантаНаСервере = Истина;
КонецПроцедуры

// Вызывается в одноименном обработчике формы отчета после выполнения кода формы.
//
// Подробнее - см. ОтчетыПереопределяемый.ПередЗагрузкойВариантаНаСервере
//
Процедура ПередЗагрузкойВариантаНаСервере(ЭтаФорма, НовыеНастройкиКД) Экспорт
	
	Отчет = ЭтаФорма.Отчет;
	КомпоновщикНастроекФормы = Отчет.КомпоновщикНастроек;
	
	// Изменение настроек по функциональным опциям
	НастроитьПараметрыОтборыПоФункциональнымОпциям(КомпоновщикНастроекФормы);
	
	НовыеНастройкиКД = КомпоновщикНастроекФормы.Настройки;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрВидЦены = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "ВидЦены");
	Если ПараметрВидЦены <> Неопределено Тогда
		Если Не ЗначениеЗаполнено(ПараметрВидЦены.Значение) Тогда
			Если Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВидовЦен") Тогда
				КомпоновкаДанныхКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ОценкаЗапасовПоВидуЦен", 3);
				КомпоновкаДанныхКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидЦены", ЦенообразованиеВызовСервера.ВидЦеныПрайсЛист());
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ПараметрОценкаЗапасовПоВидуЦен = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "ОценкаЗапасовПоВидуЦен");
	Если ПараметрОценкаЗапасовПоВидуЦен.Значение = 3 Тогда
		ПараметрВидЦены = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "ВидЦены");
		Если Не ЗначениеЗаполнено(ПараметрВидЦены.Значение) Тогда
			ВызватьИсключение НСтр("ru= 'Не указан ""Вид цены"".'");
		КонецЕсли;
	КонецЕсли;
	
	ЗаменяемыйТекст = 
	"	0 КАК Цена,
	|	0 КАК СтараяЦена,
	|	0 КАК Дельта";
		
	СхемаКомпоновкиДанных = Отчеты.ВедомостьПоТоварамНаСкладахВЦенахНоменклатуры.ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных[0].Запрос;
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры") Тогда
		
		ТекстЗамены = 
		"	ВЫБОР
		|		КОГДА ЦеныНоменклатурыА.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)
		|				ИЛИ ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки1, 0) = 0
		|			ТОГДА ЦеныНоменклатурыА.Цена
		|		ИНАЧЕ ЦеныНоменклатурыА.Цена / &ТекстЗапросаКоэффициентУпаковки1
		|	КОНЕЦ КАК Цена,
		|	ВЫБОР
		|		КОГДА ЦеныНоменклатурыБ.Цена ЕСТЬ NULL
		|			ТОГДА 0
		|		КОГДА ЦеныНоменклатурыБ.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)
		|				ИЛИ ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки2, 0) = 0
		|			ТОГДА ЦеныНоменклатурыБ.Цена
		|		ИНАЧЕ ЦеныНоменклатурыБ.Цена / &ТекстЗапросаКоэффициентУпаковки2
		|	КОНЕЦ КАК СтараяЦена,
		|	ВЫБОР
		|		КОГДА ЦеныНоменклатурыА.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)
		|				ИЛИ ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки1, 0) = 0
		|			ТОГДА ЦеныНоменклатурыА.Цена
		|		ИНАЧЕ ЦеныНоменклатурыА.Цена / &ТекстЗапросаКоэффициентУпаковки1
		|	КОНЕЦ - ВЫБОР
		|		КОГДА ЦеныНоменклатурыБ.Цена ЕСТЬ NULL
		|			ТОГДА 0
		|		КОГДА ЦеныНоменклатурыБ.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)
		|				ИЛИ ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки2, 0) = 0
		|			ТОГДА ЦеныНоменклатурыБ.Цена
		|		ИНАЧЕ ЦеныНоменклатурыБ.Цена / &ТекстЗапросаКоэффициентУпаковки2
		|	КОНЕЦ КАК Дельта";
		
	Иначе
		
		ТекстЗамены = 
		"	ЦеныНоменклатурыА.Цена КАК Цена,
		|	ВЫБОР
		|		КОГДА
		|			ЦеныНоменклатурыБ.Цена ЕСТЬ NULL
		|		ТОГДА
		|			0
		|		ИНАЧЕ
		|			ЦеныНоменклатурыБ.Цена
		|	КОНЕЦ КАК СтараяЦена,
		|		ЦеныНоменклатурыА.Цена
		|		- ВЫБОР
		|			КОГДА
		|				ЦеныНоменклатурыБ.Цена ЕСТЬ NULL
		|			ТОГДА
		|				0
		|			ИНАЧЕ
		|				ЦеныНоменклатурыБ.Цена
		|		КОНЕЦ
		|		 КАК Дельта";
		
	КонецЕсли;
		
	Если СтрНайти(ТекстЗапроса, ЗаменяемыйТекст) = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Некорректный текст запроса'");
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, ЗаменяемыйТекст, ТекстЗамены);
	СхемаКомпоновкиДанных.НаборыДанных[0].Запрос = ТекстЗапроса;
		
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных[0].Запрос;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТекстЗапросаКоэффициентУпаковки1",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
			"ЦеныНоменклатурыА.Упаковка",
			"ЦеныНоменклатурыА.Номенклатура"));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТекстЗапросаКоэффициентУпаковки2",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
			"ЦеныНоменклатурыБ.Упаковка",
			"ЦеныНоменклатурыБ.Номенклатура"));
					
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаВесНоменклатуры1", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки(
			"ТаблицаТоварыНаСкладахМаксимальныйПериод.Номенклатура.ЕдиницаИзмерения", 
			"ТаблицаТоварыНаСкладахМаксимальныйПериод.Номенклатура"));
		
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаОбъемНоменклатуры1", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки(
			"ТаблицаТоварыНаСкладахМаксимальныйПериод.Номенклатура.ЕдиницаИзмерения", 
			"ТаблицаТоварыНаСкладахМаксимальныйПериод.Номенклатура"));

	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаВесНоменклатуры2", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки(
			"БлижайшиеОстаткиПоНоменклатуре.Номенклатура.ЕдиницаИзмерения", 
			"БлижайшиеОстаткиПоНоменклатуре.Номенклатура"));
		
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаОбъемНоменклатуры2", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки(
			"БлижайшиеОстаткиПоНоменклатуре.Номенклатура.ЕдиницаИзмерения", 
			"БлижайшиеОстаткиПоНоменклатуре.Номенклатура"));
	
	СхемаКомпоновкиДанных.НаборыДанных[0].Запрос = ТекстЗапроса;
		
	СегментыСервер.ВключитьОтборПоСегментуНоменклатурыВСКД(КомпоновщикНастроек);
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(
		СхемаКомпоновкиДанных,
		КомпоновщикНастроек.ПолучитьНастройки(),
		ДанныеРасшифровки);

	КомпоновкаДанныхСервер.УстановитьЗаголовкиМакетаКомпоновки(ПолучитьЗаголовкиПолей(), МакетКомпоновки);
	КомпоновкаДанныхСервер.УстановитьЗаголовкиМакетаКомпоновки(СтруктураДинамическихЗаголовков(), МакетКомпоновки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);

	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	ПроцессорВывода.Вывести(ПроцессорКомпоновки, Истина);

	КомпоновкаДанныхСервер.СкрытьВспомогательныеПараметрыОтчета(СхемаКомпоновкиДанных, КомпоновщикНастроек, ДокументРезультат, ВспомогательныеПараметрыОтчета());
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВспомогательныеПараметрыОтчета()
	ВспомогательныеПараметры = Новый Массив;
	
	ПараметрОценкаЗапасовПоВидуЦен = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "ОценкаЗапасовПоВидуЦен");
	Если Не ПараметрОценкаЗапасовПоВидуЦен.Значение = 3 Тогда
		ВспомогательныеПараметры.Добавить("ВидЦены");
	КонецЕсли;
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВидовЦен") Тогда
		ВспомогательныеПараметры.Добавить("ОценкаЗапасовПоВидуЦен");
	КонецЕсли;
	
	ВспомогательныеПараметры.Добавить("КоличественныеИтогиПоЕдИзм");
		
	КомпоновкаДанныхСервер.ДобавитьВспомогательныеПараметрыОтчетаПоФункциональнымОпциям(ВспомогательныеПараметры);
	
	Возврат ВспомогательныеПараметры;
КонецФункции

Функция ПолучитьЗаголовкиПолей()
	
	Возврат КомпоновкаДанныхСервер.СтруктураЗаголовковПолейЕдиницИзмерений(КомпоновщикНастроек);
	
КонецФункции

Функция СтруктураДинамическихЗаголовков()
	ДинамическиеЗаголовки = Новый Структура;
	
	Параметр = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "ГруппировкаНоменклатуры");
	ДоступнаяНастройка = ОтчетыКлиентСервер.НайтиДоступнуюНастройку(КомпоновщикНастроек.Настройки, Параметр);
	Если ДоступнаяНастройка <> Неопределено Тогда
		ПредставлениеЗначенияПараметра = ДоступнаяНастройка.ДоступныеЗначения[Параметр.Значение-1];
		ДинамическиеЗаголовки.Вставить("ГруппировкаНоменклатуры", ПредставлениеЗначенияПараметра);
	КонецЕсли;
	
	Возврат ДинамическиеЗаголовки;
КонецФункции

Процедура НастроитьПараметрыОтборыПоФункциональнымОпциям(КомпоновщикНастроекФормы)
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЕдиницыИзмеренияДляОтчетов") Тогда
		КомпоновкаДанныхСервер.УдалитьПараметрИзПользовательскихНастроекОтчета(КомпоновщикНастроекФормы, "ЕдиницыКоличества");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
