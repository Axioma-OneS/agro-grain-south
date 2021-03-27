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
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	
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
	
КонецПроцедуры

Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		НастроитьПараметрыОтчетаПоВариантуОтчета(Контекст.НастройкиОтчета, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД);
		ОтчетыСервер.ПодключитьСхему(ЭтотОбъект, Контекст, СхемаКомпоновкиДанных, КлючСхемы);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПользовательскиеНастройкиМодифицированы = Ложь;
	
	УстановитьОбязательныеНастройки(ПользовательскиеНастройкиМодифицированы);
	
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.СебестоимостьПартий.Запрос;
	
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаВесУпаковки", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаВесУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения", "АналитикаНоменклатуры.Номенклатура"));
		
	ТекстЗапроса = СтрЗаменить(
		ТекстЗапроса, 
		"&ТекстЗапросаОбъемУпаковки", 
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаОбъемУпаковки("АналитикаНоменклатуры.Номенклатура.ЕдиницаИзмерения", "АналитикаНоменклатуры.Номенклатура"));
	
	СхемаКомпоновкиДанных.НаборыДанных.СебестоимостьПартий.Запрос = ТекстЗапроса;
	
	// Разделение данных по периодам ПУ 2.1 и ПУ 2.2
	ДатаПереходаНаПартионныйУчетВерсии22 = Константы.ДатаПереходаНаПартионныйУчетВерсии22.Получить();
	ИспользоватьПУ22 = Константы.ПартионныйУчетВерсии22.Получить();
	
	ПараметрПериодОтчета = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "Период");
	Если ПараметрПериодОтчета.Использование
		И Не (ПараметрПериодОтчета.Значение.ДатаНачала = '00010101'
			И ПараметрПериодОтчета.Значение.ДатаОкончания = '00010101') Тогда
		
		ДатаНачала = ПараметрПериодОтчета.Значение.ДатаНачала;
		ДатаОкончания = ПараметрПериодОтчета.Значение.ДатаОкончания;
		
		Если ИспользоватьПУ22 
		 И (ДатаНачала >= ДатаПереходаНаПартионныйУчетВерсии22 ИЛИ ДатаОкончания >= ДатаПереходаНаПартионныйУчетВерсии22) Тогда
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("НачалоПериода22", Макс(ДатаНачала, ДатаПереходаНаПартионныйУчетВерсии22));
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ22", ИспользоватьПУ22);
		ИначеЕсли ИспользоватьПУ22 И ДатаОкончания <= ДатаПереходаНаПартионныйУчетВерсии22 Тогда
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("НачалоПериода22", ДатаНачала);
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ21", Истина);
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ22", Ложь);
		Иначе
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("НачалоПериода22", ДатаНачала);
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ21", НЕ ИспользоватьПУ22);
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ22", ИспользоватьПУ22);
		КонецЕсли;
		
		Если ИспользоватьПУ22 И ДатаНачала < ДатаПереходаНаПартионныйУчетВерсии22 Тогда
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("КонецПериода21", Мин(ДатаОкончания, ДатаПереходаНаПартионныйУчетВерсии22 - 1));
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ21", Истина);
		ИначеЕсли Не ИспользоватьПУ22 Тогда
			Если ЗначениеЗаполнено(ДатаОкончания) Тогда
				НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("КонецПериода21", ДатаОкончания);
			КонецЕсли;
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ21", Истина);
		Иначе
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("КонецПериода21", ДатаОкончания);
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ21", Ложь);
		КонецЕсли;
		
	Иначе
		Если ИспользоватьПУ22 Тогда
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("КонецПериода21", ДатаПереходаНаПартионныйУчетВерсии22 - 1);
		Иначе
			НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("КонецПериода21", Дата(1,1,1));
		КонецЕсли;
		НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("НачалоПериода22", ДатаПереходаНаПартионныйУчетВерсии22);
		НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ21", Истина);
		НастройкиОтчета.ПараметрыДанных.УстановитьЗначениеПараметра("ДанныеПУ22", ИспользоватьПУ22);
	КонецЕсли;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);

	КомпоновкаДанныхСервер.УстановитьЗаголовкиМакетаКомпоновки(СтруктураЗаголовковПолей(), МакетКомпоновки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);

	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	РасчетСебестоимостиПрикладныеАлгоритмы.АктуализироватьПартииДляОтчетов(ДокументРезультат, КомпоновщикНастроек);
	
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	КомпоновкаДанныхСервер.СкрытьВспомогательныеПараметрыОтчета(СхемаКомпоновкиДанных, КомпоновщикНастроек, ДокументРезультат, ВспомогательныеПараметрыОтчета());
	
	// Сообщим форме отчета о том, что настройки модифицированы.
	Если ПользовательскиеНастройкиМодифицированы Тогда
		КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ПользовательскиеНастройкиМодифицированы", Истина);
	КонецЕсли;
	
	КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить(
		"ОтчетПустой",
		ОтчетыСервер.ОтчетПустой(ЭтотОбъект, ПроцессорКомпоновки));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
	
Процедура УстановитьОбязательныеНастройки(ПользовательскиеНастройкиМодифицированы)
	
	КомпоновкаДанныхСервер.УстановитьПараметрыВалютыОтчета(КомпоновщикНастроек, ПользовательскиеНастройкиМодифицированы);
	
	СегментыСервер.ВключитьОтборПоСегментуНоменклатурыВСКД(КомпоновщикНастроек);
	
КонецПроцедуры

Функция ВспомогательныеПараметрыОтчета()
	
	ВспомогательныеПараметры = Новый Массив;
	
	ВспомогательныеПараметры.Добавить("КоличественныеИтогиПоЕдИзм");
	
	КомпоновкаДанныхСервер.ДобавитьВспомогательныеПараметрыОтчетаПоФункциональнымОпциям(ВспомогательныеПараметры);
	
	Возврат ВспомогательныеПараметры;

КонецФункции

Функция СтруктураЗаголовковПолей()
	СтруктураЗаголовковПолей = Новый Структура;
	
	СтруктураЗаголовковВалют = КомпоновкаДанныхСервер.СтруктураЗаголовковВалютСквознаяСебестоимость(КомпоновщикНастроек);
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураЗаголовковПолей, СтруктураЗаголовковВалют, Ложь);
	
	СтруктуруЗаголовковПолейЕдиницИзмерений = КомпоновкаДанныхСервер.СтруктураЗаголовковПолейЕдиницИзмерений(КомпоновщикНастроек);
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураЗаголовковПолей, СтруктуруЗаголовковПолейЕдиницИзмерений, Ложь);
	
	Возврат СтруктураЗаголовковПолей;
КонецФункции

Процедура НастроитьПараметрыОтборыПоФункциональнымОпциям(КомпоновщикНастроекФормы)
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьЕдиницыИзмеренияДляОтчетов") Тогда
		КомпоновкаДанныхСервер.УдалитьПараметрИзПользовательскихНастроекОтчета(КомпоновщикНастроекФормы, "ЕдиницыКоличества");
	КонецЕсли;
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьПеремещениеТоваров") Тогда
		КомпоновкаДанныхСервер.УдалитьПараметрИзПользовательскихНастроекОтчета(КомпоновщикНастроекФормы, "ИсключатьХозОперации");
	КонецЕсли;
	
КонецПроцедуры

Процедура НастроитьПараметрыОтчетаПоВариантуОтчета(НастройкиОтчета, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД)
	
	ПредопределенныйВариант = ПолучитьПредопределенныйВариант(НастройкиОтчета.ВариантСсылка);
	
	ПараметрДанныеОтчета = СхемаКомпоновкиДанных.Параметры.Найти("ДанныеОтчета");
	ПараметрПоПредприятию = СхемаКомпоновкиДанных.Параметры.Найти("ПоПредприятию");
	
	СписокВыбора = Новый СписокЗначений;
	
	Если ПредопределенныйВариант.КлючВарианта = "ВедомостьПоПартиямТоваровПредприятия" Тогда
		
		СписокВыбора.Добавить(1, НСтр("ru='В валюте упр. учета с НДС'"));
		СписокВыбора.Добавить(2, НСтр("ru='В валюте упр. учета без НДС'"));
		ПараметрПоПредприятию.Значение = Истина;
		
	Иначе
		
		Если ПолучитьФункциональнуюОпцию("ВестиУправленческийУчетОрганизаций") Тогда
			СписокВыбора.Добавить(3, НСтр("ru = 'В валюте упр. учета'"));
		КонецЕсли;
		СписокВыбора.Добавить(4, НСтр("ru='В валюте регл. учета'"));
		ПараметрПоПредприятию.Значение = Ложь;
		
	КонецЕсли;
	
	ПараметрДанныеОтчета.УстановитьДоступныеЗначения(СписокВыбора);
	
	Если НовыеНастройкиКД = Неопределено
		Или НовыеПользовательскиеНастройкиКД = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗначениеПараметраДанныеОтчета = НовыеНастройкиКД.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ДанныеОтчета"));
	НастройкаДанныеОтчета = НовыеПользовательскиеНастройкиКД.Элементы.Найти(ЗначениеПараметраДанныеОтчета.ИдентификаторПользовательскойНастройки);
	Если Не НастройкаДанныеОтчета = Неопределено
		И СписокВыбора.НайтиПоЗначению(НастройкаДанныеОтчета.Значение) = Неопределено Тогда
		НастройкаДанныеОтчета.Значение = СписокВыбора[0].Значение;
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьПредопределенныйВариант(Знач Вариант)
	
	// Если вариант не задан, то возьмем ВедомостьПоПартиямТоваровПредприятия
	Если Вариант = Неопределено Тогда
		Возврат Новый Структура("КлючВарианта", "ВедомостьПоПартиямТоваровПредприятия");
	КонецЕсли;
	
	Пока Не Вариант.КлючВарианта = "ВедомостьПоПартиямТоваровПредприятия"
		И Не Вариант.КлючВарианта = "ВедомостьПоПартиямТоваровОрганизаций"
		И ЗначениеЗаполнено(Вариант.Родитель) Цикл
		Вариант = Вариант.Родитель;
	КонецЦикла;
	
	Возврат Вариант;
	
КонецФункции

#КонецОбласти

#КонецЕсли
