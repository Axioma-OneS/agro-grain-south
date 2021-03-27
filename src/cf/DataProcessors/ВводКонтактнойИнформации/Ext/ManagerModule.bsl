﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		
		Если Параметры <> Неопределено И Параметры.Свойство("ОткрытаПоСценарию") Тогда
			СтандартнаяОбработка = Ложь;
			ВидИнформации = Параметры.ВидКонтактнойИнформации;
			ВыбраннаяФорма = ИмяФормыВводаКонтактнойИнформации(ВидИнформации);
			
			Если ВыбраннаяФорма = Неопределено Тогда
				ВызватьИсключение НСтр("ru = 'Не обрабатываемый тип адреса: """ + ВидИнформации + """'");
			КонецЕсли;
		КонецЕсли;
		
	#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает имя формы для редактирования типа контактной информации.
//
// Параметры:
//      ВидИнформации - ПеречислениеСсылка.ТипыКонтактнойИнформации, СправочникСсылка.ВидыКонтактнойИнформации -
//                      запрашиваемый тип.
//
// Возвращаемое значение:
//      Строка - полное имя формы.
//
Функция ИмяФормыВводаКонтактнойИнформации(Знач ВидИнформации)
	
	ТипИнформации = УправлениеКонтактнойИнформациейСлужебныйПовтИсп.ТипВидаКонтактнойИнформации(ВидИнформации);
	
	ВсеТипы = "Перечисление.ТипыКонтактнойИнформации.";
	Если ТипИнформации = ПредопределенноеЗначение(ВсеТипы + "Адрес") Тогда
		
		Если Метаданные.Обработки.Найти("РасширенныйВводКонтактнойИнформации") = Неопределено Тогда
			Возврат "Обработка.ВводКонтактнойИнформации.Форма.ВводАдресаВСвободнойФорме";
		Иначе
			Возврат "Обработка.РасширенныйВводКонтактнойИнформации.Форма.ВводАдреса";
		КонецЕсли;
		
	ИначеЕсли ТипИнформации = ПредопределенноеЗначение(ВсеТипы + "Телефон") Тогда
		Возврат "Обработка.ВводКонтактнойИнформации.Форма.ВводТелефона";
		
	ИначеЕсли ТипИнформации = ПредопределенноеЗначение(ВсеТипы + "ВебСтраница") Тогда
		Возврат "Обработка.ВводКонтактнойИнформации.Форма.ВебСайт";
		
	ИначеЕсли ТипИнформации = ПредопределенноеЗначение(ВсеТипы + "Факс") Тогда
		Возврат "Обработка.ВводКонтактнойИнформации.Форма.ВводТелефона";
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#КонецЕсли


