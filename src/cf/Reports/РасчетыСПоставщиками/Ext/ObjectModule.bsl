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
	
	// Установка значений по умолчанию
	НастроитьПараметрыОтборыПоУмолчанию(КомпоновщикНастроекФормы);
	
	НовыеНастройкиКД = КомпоновщикНастроекФормы.Настройки;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	СегментыСервер.ВключитьОтборПоСегментуПартнеровВСКД(КомпоновщикНастроек);
	
	ПараметрДанных = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ДанныеПоРасчетам");
	ПользовательскаяНастройка = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(
		ПараметрДанных.ИдентификаторПользовательскойНастройки);
	
	Если ПользовательскаяНастройка <> Неопределено Тогда
		Если ПользовательскаяНастройка.Значение = 2 // В валюте упр. учета
			ИЛИ ПользовательскаяНастройка.Значение = 3 Тогда // В валюте регл. учета
			#Область АктуализацияВзаиморасчетов
			УстановитьПривилегированныйРежим(Истина);
			ПоляОтбора = РаспределениеВзаиморасчетовВызовСервера.ПоляОтбораПоУмолчанию();
			ДопСвойства = КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства;
			РаспределениеВзаиморасчетовВызовСервера.ВосстановитьРасчетыПоОтборам(КомпоновщикНастроек, ПоляОтбора, ДопСвойства);
			УстановитьПривилегированныйРежим(Ложь);
			#КонецОбласти	
		КонецЕсли;
		
	КонецЕсли;
	
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);

	КомпоновкаДанныхСервер.УстановитьЗаголовкиМакетаКомпоновки(СтруктураЗаголовковПолей(), МакетКомпоновки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);

	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	#Область ПроверкаВзаиморасчетов
	РегистрыСведений.ЗаданияКРаспределениюРасчетовСПоставщиками.ВывестиАктуальностьРасчета(ДокументРезультат, ДопСвойства);
	#КонецОбласти
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	ВспомогательныеПараметры = Новый Массив;
	КомпоновкаДанныхСервер.ДобавитьВспомогательныеПараметрыОтчетаПоФункциональнымОпциям(ВспомогательныеПараметры);
	КомпоновкаДанныхСервер.СкрытьВспомогательныеПараметрыОтчета(СхемаКомпоновкиДанных, КомпоновщикНастроек, ДокументРезультат, ВспомогательныеПараметры);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СтруктураЗаголовковПолей()
	СтруктураЗаголовковПолей = Новый Структура;
	
	ИспользоватьНесколькоВалют = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют");
	ПараметрДанныеПоРасчетам = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "ДанныеПоРасчетам");
	ДанныеПоРасчетам = ПараметрДанныеПоРасчетам.Значение;
	Если ИспользоватьНесколькоВалют Тогда
		Если ДанныеПоРасчетам = 1 Тогда
			СтруктураЗаголовковПолей.Вставить("ВалютаОтчета", "");
		ИначеЕсли ДанныеПоРасчетам = 2 Тогда
			ПараметрВалюта = Константы.ВалютаУправленческогоУчета.Получить();
			СтруктураЗаголовковПолей.Вставить("ВалютаОтчета", "(" + ПараметрВалюта + ")");
		ИначеЕсли ДанныеПоРасчетам = 3 Тогда
			ПараметрВалюта = Константы.ВалютаРегламентированногоУчета.Получить();
			СтруктураЗаголовковПолей.Вставить("ВалютаОтчета", "(" + ПараметрВалюта + ")");
		КонецЕсли;
	Иначе
		СтруктураЗаголовковПолей.Вставить("ВалютаОтчета", "");
	КонецЕсли;
	
	Возврат СтруктураЗаголовковПолей;
КонецФункции

Процедура НастроитьПараметрыОтборыПоФункциональнымОпциям(КомпоновщикНастроекФормы)
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьПартнеровКакКонтрагентов") Тогда
		КомпоновкаДанныхСервер.УдалитьЭлементОтбораИзВсехНастроекОтчета(КомпоновщикНастроекФормы, "Контрагент");
	КонецЕсли;
	
КонецПроцедуры

Процедура НастроитьПараметрыОтборыПоУмолчанию(КомпоновщикНастроекФормы, ПользовательскиеНастройки = Ложь)
	ФиксНастройкаПериода = ФиксированнаяНастройкаПараметра(КомпоновщикНастроекФормы, "Период");
	
	Если ФиксНастройкаПериода.Использование = Истина Тогда
		
		ПользНастройкаПериода = ПользовательскаяНастройкаПараметра(КомпоновщикНастроекФормы, "Период");
		ПользНастройкаПериода.Использование = Истина;
		ПользНастройкаПериода.Значение.ДатаНачала = ФиксНастройкаПериода.Значение.ДатаНачала;
		ПользНастройкаПериода.Значение.ДатаОкончания = ФиксНастройкаПериода.Значение.ДатаОкончания;
		
		ФиксНастройкаПериода.Использование = Ложь;
		
	КонецЕсли;
КонецПроцедуры

Функция ФиксированнаяНастройкаПараметра(КомпоновщикНастроекФормы, ИмяПараметра)

	ПараметрДанных = КомпоновщикНастроекФормы.ФиксированныеНастройки.ПараметрыДанных.Элементы.Найти(ИмяПараметра);
	
	Возврат ПараметрДанных;

КонецФункции

Функция ПользовательскаяНастройкаПараметра(КомпоновщикНастроекФормы, ИмяПараметра)

	ПараметрДанных = КомпоновщикНастроекФормы.Настройки.ПараметрыДанных.Элементы.Найти(ИмяПараметра);
	Если ПараметрДанных <> Неопределено Тогда
		ПараметрПользовательскойНастройки = КомпоновщикНастроекФормы.ПользовательскиеНастройки.Элементы.Найти(ПараметрДанных.ИдентификаторПользовательскойНастройки);
		Если ПараметрПользовательскойНастройки <> Неопределено Тогда
			Возврат ПараметрПользовательскойНастройки;
		Иначе
			Возврат ПараметрДанных;
		КонецЕсли;
	КонецЕсли;
	Возврат Неопределено;

КонецФункции

#КонецОбласти

#КонецЕсли