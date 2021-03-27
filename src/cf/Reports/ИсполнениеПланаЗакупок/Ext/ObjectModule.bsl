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
	ПользовательскиеНастройкиМодифицированы = Ложь;
	
	ПараметрСценарий = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "Сценарий");
	
	Если НЕ ЗначениеЗаполнено(ПараметрСценарий.Значение) Тогда
		ВызватьИсключение НСтр("ru= 'Не заполнено значение параметра ""Сценарий"".'");
	КонецЕсли; 
	
	СтруктураЗначений = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ПараметрСценарий.Значение, "Периодичность, ПланированиеПоНазначениям, ПланЗакупокПланироватьПоСумме");
	Периодичность = СтруктураЗначений.Периодичность;
	ИспользоватьНазначения = СтруктураЗначений.ПланированиеПоНазначениям;
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ИспользоватьНазначения", ИспользоватьНазначения);
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПланироватьПоСумме", СтруктураЗначений.ПланЗакупокПланироватьПоСумме);
	
	Период = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "ПериодПоступления");
	
	ДатаОкончания = ПланированиеКлиентСервер.РассчитатьДатуОкончанияПериода(Период.Значение.ДатаНачала, Периодичность);
	
	Если ДатаОкончания < Период.Значение.ДатаОкончания Тогда
		ИспользоватьИтоги = Истина;
	Иначе
		ИспользоватьИтоги = Ложь;
	КонецЕсли; 
	
	Для Каждого Группировка Из КомпоновщикНастроек.Настройки.Структура Цикл
		УстановитьДругиеНастройки(Группировка, ИспользоватьИтоги);
	КонецЦикла;
	
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	
	ТекстЗапроса = СхемаКомпоновкиДанных.ВложенныеСхемыКомпоновкиДанных.ПоПоставщикам.Схема.НаборыДанных.НаборДанных1.Запрос;

	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаВесНоменклатуры", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("ПланЗакупокФакт.Номенклатура.ЕдиницаИзмерения", "ПланЗакупокФакт.Номенклатура"));
		
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаОбъемНоменклатуры", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("ПланЗакупокФакт.Номенклатура.ЕдиницаИзмерения", "ПланЗакупокФакт.Номенклатура"));

	СхемаКомпоновкиДанных.ВложенныеСхемыКомпоновкиДанных.ПоПоставщикам.Схема.НаборыДанных.НаборДанных1.Запрос = ТекстЗапроса;


	ТекстЗапроса = СхемаКомпоновкиДанных.ВложенныеСхемыКомпоновкиДанных.ПоПодразделениям.Схема.НаборыДанных.НаборДанных1.Запрос;

	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаВесНоменклатуры", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("ПланЗакупокФакт.Номенклатура.ЕдиницаИзмерения", "ПланЗакупокФакт.Номенклатура"));
		
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаОбъемНоменклатуры", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("ПланЗакупокФакт.Номенклатура.ЕдиницаИзмерения", "ПланЗакупокФакт.Номенклатура"));

	СхемаКомпоновкиДанных.ВложенныеСхемыКомпоновкиДанных.ПоПодразделениям.Схема.НаборыДанных.НаборДанных1.Запрос = ТекстЗапроса;

	ТекстЗапроса = СхемаКомпоновкиДанных.ВложенныеСхемыКомпоновкиДанных.ПоСкладам.Схема.НаборыДанных.НаборДанных1.Запрос;

	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаВесНоменклатуры", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("ПланЗакупокФакт.Номенклатура.ЕдиницаИзмерения", "ПланЗакупокФакт.Номенклатура"));
		
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаОбъемНоменклатуры", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("ПланЗакупокФакт.Номенклатура.ЕдиницаИзмерения", "ПланЗакупокФакт.Номенклатура"));

	СхемаКомпоновкиДанных.ВложенныеСхемыКомпоновкиДанных.ПоСкладам.Схема.НаборыДанных.НаборДанных1.Запрос = ТекстЗапроса;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);

	СтруктураЗаголовковПолей = СтруктураЗаголовковПолей();
	КомпоновкаДанныхСервер.УстановитьЗаголовкиМакетаКомпоновки(СтруктураЗаголовковПолей, МакетКомпоновки);
	Для каждого Макет Из МакетКомпоновки.Тело Цикл
		Если ТипЗнч(Макет) = Тип("ВложенныйОбъектМакетаКомпоновкиДанных") Тогда
			КомпоновкаДанныхСервер.УстановитьЗаголовкиМакетаКомпоновки(СтруктураЗаголовковПолей, Макет.КомпоновкаДанных);
		КонецЕсли;
	КонецЦикла;
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);

	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	КомпоновкаДанныхСервер.СкрытьВспомогательныеПараметрыОтчета(СхемаКомпоновкиДанных, КомпоновщикНастроек, ДокументРезультат, ВспомогательныеПараметрыОтчета());
	
	// Сообщим форме отчета, что настройки модифицированы
	Если ПользовательскиеНастройкиМодифицированы Тогда
		КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ПользовательскиеНастройкиМодифицированы", Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
	
Процедура УстановитьДругиеНастройки(ВложенныйОтчет, ИспользоватьИтоги)
	
	Параметр = Новый ПараметрКомпоновкиДанных("ГоризонтальноеРасположениеОбщихИтогов");
	ПараметрГоризонтальноеРасположениеОбщихИтогов = ВложенныйОтчет.Настройки.ПараметрыВывода.Элементы.Найти(Параметр);
	
	Если ИспользоватьИтоги Тогда
		ПараметрГоризонтальноеРасположениеОбщихИтогов.Значение = РасположениеИтоговКомпоновкиДанных.Конец;
	Иначе
		ПараметрГоризонтальноеРасположениеОбщихИтогов.Значение = РасположениеИтоговКомпоновкиДанных.Нет;
	КонецЕсли;
	
	СегментыСервер.ВключитьОтборПоСегментуПартнеровВСКД(ВложенныйОтчет);
	СегментыСервер.ВключитьОтборПоСегментуНоменклатурыВСКД(ВложенныйОтчет);
	
КонецПроцедуры

Функция ВспомогательныеПараметрыОтчета()
	
	ВспомогательныеПараметры = Новый Массив;
	
	ВспомогательныеПараметры.Добавить("КоличественныеИтогиПоЕдИзм");
	
	КомпоновкаДанныхСервер.ДобавитьВспомогательныеПараметрыОтчетаПоФункциональнымОпциям(ВспомогательныеПараметры);
	
	Возврат ВспомогательныеПараметры;

КонецФункции

Функция СтруктураЗаголовковПолей()
	
	Возврат КомпоновкаДанныхСервер.СтруктураЗаголовковПолейЕдиницИзмерений(КомпоновщикНастроек);
	
КонецФункции

Процедура НастроитьПараметрыОтборыПоФункциональнымОпциям(КомпоновщикНастроекФормы)
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЕдиницыИзмеренияДляОтчетов") Тогда
		КомпоновкаДанныхСервер.УдалитьПараметрИзПользовательскихНастроекОтчета(КомпоновщикНастроекФормы, "ЕдиницыКоличества");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли