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
	Настройки.События.ПриСозданииНаСервере = Истина;
	Настройки.События.ПередЗагрузкойВариантаНаСервере = Истина;
КонецПроцедуры

// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   Отказ - Передается из параметров обработчика "как есть".
//   СтандартнаяОбработка - Передается из параметров обработчика "как есть".
//
// См. также:
//   "ФормаКлиентскогоПриложения.ПриСозданииНаСервере" в синтакс-помощнике.
//
Процедура ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка) Экспорт
	
	Если ЭтаФорма.Параметры.Свойство("ПараметрКоманды") Тогда
		ЭтаФорма.ФормаПараметры.Отбор.Вставить("ОтчетКомитенту", ЭтаФорма.Параметры.ПараметрКоманды);
	КонецЕсли;
	
	Параметры = ЭтаФорма.ФормаПараметры;
	
	Если Параметры.Свойство("Отбор")
	   И Параметры.Отбор.Свойство("ОтчетКомитенту") Тогда
	   
		Если ТипЗнч(Параметры.Отбор.ОтчетКомитенту) = Тип("ДокументСсылка.ОтчетКомитенту") Тогда
			Реквизиты = Документы.ОтчетКомитенту.РеквизитыДокумента(Параметры.Отбор.ОтчетКомитенту);
			
		ИначеЕсли ТипЗнч(Параметры.Отбор.ОтчетКомитенту) = Тип("ДокументСсылка.ОтчетКомитентуОСписании") Тогда
			Реквизиты = Документы.ОтчетКомитентуОСписании.РеквизитыДокумента(Параметры.Отбор.ОтчетКомитенту);
			
		Иначе
			Реквизиты = Неопределено;
			
		КонецЕсли;
		
		Если Реквизиты <> Неопределено Тогда
			Если ЗначениеЗаполнено(Реквизиты.Партнер) Тогда	
				Параметры.Отбор.Вставить("Комитент", Реквизиты.Партнер);
			КонецЕсли;
			Если ЗначениеЗаполнено(Реквизиты.Организация) Тогда
				Параметры.Отбор.Вставить("Организация", Реквизиты.Организация);
			КонецЕсли;
			Период = Новый СтандартныйПериод;
			Период.Вариант = ВариантСтандартногоПериода.ПроизвольныйПериод;
			Период.ДатаНачала = Реквизиты.НачалоПериода;
			период.ДатаОкончания = Реквизиты.КонецПериода;
			Параметры.Отбор.Вставить("Период", Период);
		КонецЕсли;
		Параметры.Отбор.Удалить("ОтчетКомитенту");
	КонецЕсли;
	

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

	УстановитьОбязательныеНастройки(ПользовательскиеНастройкиМодифицированы);
	
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ТоварыОрганизаций.Запрос;
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаВесНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения",
																							"АналитикаНоменклатуры.Номенклатура"));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаОбъемНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения",
																							"АналитикаНоменклатуры.Номенклатура"));
	СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ТоварыОрганизаций.Запрос = ТекстЗапроса;	

	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ТоварыКОформлениюОтчетовКомитенту.Запрос;
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаВесНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения",
																							"АналитикаНоменклатуры.Номенклатура"));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаОбъемНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения",
																							"АналитикаНоменклатуры.Номенклатура"));
	СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ТоварыКОформлениюОтчетовКомитенту.Запрос = ТекстЗапроса;	
	
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ТоварыОрганизацийДвижения.Запрос;
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаВесНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения",
																							"АналитикаНоменклатуры.Номенклатура"));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаОбъемНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения",
																							"АналитикаНоменклатуры.Номенклатура"));
	СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ТоварыОрганизацийДвижения.Запрос = ТекстЗапроса;	
	
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ЗаказыПоставщикам.Запрос;
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаВесНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("ЗаказыПоставщикам.Номенклатура.ЕдиницаИзмерения",
																							"ЗаказыПоставщикам.Номенклатура"));
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
								"&ТекстЗапросаОбъемНоменклатуры",
								Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("ЗаказыПоставщикам.Номенклатура.ЕдиницаИзмерения",
																							"ЗаказыПоставщикам.Номенклатура"));
	СхемаКомпоновкиДанных.НаборыДанных.РасчетыСКомитентами.Элементы.ЗаказыПоставщикам.Запрос = ТекстЗапроса;	
	
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);

	КомпоновкаДанныхСервер.УстановитьЗаголовкиМакетаКомпоновки(ЗаголовкиПолей(), МакетКомпоновки);
	
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
	
Процедура УстановитьОбязательныеНастройки(ПользовательскиеНастройкиМодифицированы)
	
	ФиксНастройкаПериода = ФиксированнаяНастройкаПараметра("Период");
	Если ФиксНастройкаПериода.Использование = Истина Тогда
		
		ПользНастройкаПериода = ПользовательскаяНастройкаПараметра("Период");
		ПользНастройкаПериода.Использование = Истина;
		ПользНастройкаПериода.Значение.ДатаНачала = ФиксНастройкаПериода.Значение.ДатаНачала;
		ПользНастройкаПериода.Значение.ДатаОкончания = ФиксНастройкаПериода.Значение.ДатаОкончания;
		
		ФиксНастройкаПериода.Использование = Ложь;
		
	КонецЕсли;
	
	СегментыСервер.ВключитьОтборПоСегментуПартнеровВСКД(КомпоновщикНастроек);
	СегментыСервер.ВключитьОтборПоСегментуНоменклатурыВСКД(КомпоновщикНастроек);
	
КонецПроцедуры

Функция ВспомогательныеПараметрыОтчета()
	
	ВспомогательныеПараметры = Новый Массив;
	
	ВспомогательныеПараметры.Добавить("КоличественныеИтогиПоЕдИзм");
	
	КомпоновкаДанныхСервер.ДобавитьВспомогательныеПараметрыОтчетаПоФункциональнымОпциям(ВспомогательныеПараметры);
	
	Возврат ВспомогательныеПараметры;

КонецФункции

Функция ФиксированнаяНастройкаПараметра(ИмяПараметра)

	ПараметрДанных = КомпоновщикНастроек.ФиксированныеНастройки.ПараметрыДанных.Элементы.Найти(ИмяПараметра);
	
	Возврат ПараметрДанных;

КонецФункции

Функция ПользовательскаяНастройкаПараметра(ИмяПараметра)

	ПараметрДанных = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти(ИмяПараметра);
	Если ПараметрДанных <> Неопределено Тогда
		ПараметрПользовательскойНастройки = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ПараметрДанных.ИдентификаторПользовательскойНастройки);
		Если ПараметрПользовательскойНастройки <> Неопределено Тогда
			Возврат ПараметрПользовательскойНастройки;
		Иначе
			Возврат ПараметрДанных;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Неопределено;

КонецФункции

Функция ЗаголовкиПолей()
	
	Возврат КомпоновкаДанныхСервер.СтруктураЗаголовковПолейЕдиницИзмерений(КомпоновщикНастроек);
	
КонецФункции

Процедура НастроитьПараметрыОтборыПоФункциональнымОпциям(КомпоновщикНастроекФормы)
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЕдиницыИзмеренияДляОтчетов") Тогда
		КомпоновкаДанныхСервер.УдалитьПараметрИзПользовательскихНастроекОтчета(КомпоновщикНастроекФормы, "ЕдиницыКоличества");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли