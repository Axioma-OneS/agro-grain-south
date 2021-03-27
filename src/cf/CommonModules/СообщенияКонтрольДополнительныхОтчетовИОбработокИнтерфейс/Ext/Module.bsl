﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - 
//
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/1cFresh/ApplicationExtensions/Control/" + Версия();
	
КонецФункции

// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - 
//
Функция Версия() Экспорт
	
	Возврат "1.0.1.1";
	
КонецФункции

// Возвращает название программного интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - 
//
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ApplicationExtensionsControl";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
// Параметры:
//  МассивОбработчиков - Массив - общие модули или модули менеджеров.
//
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
//
// Параметры:
//  МассивОбработчиков - Массив - общие модули или модули менеджеров.
//
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
	МассивОбработчиков.Добавить(СообщенияКонтрольДополнительныхОтчетовИОбработокОбработчикТрансляции_1_0_0_1);
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ApplicationExtensions/Control/a.b.c.d}ExtensionInstalled
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипОбъектаXDTO - 
//
Функция СообщениеДополнительныйОтчетИлиОбработкаУстановлена(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ExtensionInstalled");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ApplicationExtensions/Control/a.b.c.d}ExtensionDeleted
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипОбъектаXDTO - 
//
Функция СообщениеДополнительныйОтчетИлиОбработкаУдалена(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ExtensionDeleted");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ApplicationExtensions/Control/a.b.c.d}ExtensionInstallFailed
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипОбъектаXDTO - 
//
Функция СообщениеОшибкаУстановкиДополнительногоОтчетаИлиОбработки(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ExtensionInstallFailed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ApplicationExtensions/Control/a.b.c.d}ExtensionDeleteFailed
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипОбъектаXDTO - 
//
Функция СообщениеОшибкаУдаленияДополнительногоОтчетаИлиОбработки(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ExtensionDeleteFailed");
	
КонецФункции

Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = Пакет();
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

#КонецОбласти
