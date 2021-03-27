﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

//РаботаСВнешнимОборудованием
Перем глПодключаемоеОборудование Экспорт; // для кэширования на клиенте
Перем глПодключаемоеОборудованиеСобытиеОбработано Экспорт; // для предотвращения повторной обработки события
Перем глДоступныеТипыОборудования Экспорт;
//Конец РаботаСВнешнимОборудованием

//++ НЕ ГОСИС
// ЭлектронноеВзаимодействие
Перем ПараметрыПодсистемыОбменСБанками Экспорт;
// При соответствующих настройках сертификата ЭП в соответствии будут храниться пары Сертификат-Пароль (в данном сеансе)
Перем СоответствиеСертификатаИПароля Экспорт;
// Конец ЭлектронноеВзаимодействие

// ШтрихкодыБольничныхЛистов
Перем глШтрихкодыБольничныхЛистовСобытиеОбработано Экспорт; 
// Конец ШтрихкодыБольничныхЛистов

Перем глКомпонентаОбменаСМобильнымиПриложениями Экспорт;
Перем глФормаНачальнойНастройкиПрограммы Экспорт;
//-- НЕ ГОСИС

// СтандартныеПодсистемы

// Хранилище глобальных переменных.
//
// ПараметрыПриложения - Соответствие - хранилище переменных, где:
//   * Ключ - Строка - имя переменной в формате "ИмяБиблиотеки.ИмяПеременной";
//   * Значение - Произвольный - значение переменной.
//
// Инициализация (на примере СообщенияДляЖурналаРегистрации):
//   ИмяПараметра = "СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации";
//   Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
//     ПараметрыПриложения.Вставить(ИмяПараметра, Новый СписокЗначений);
//   КонецЕсли;
//  
// Использование (на примере СообщенияДляЖурналаРегистрации):
//   ПараметрыПриложения["СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации"].Добавить(...);
//   ПараметрыПриложения["СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации"] = ...;
Перем ПараметрыПриложения Экспорт;

// Конец СтандартныеПодсистемы

// ТехнологияСервиса
Перем ОповещениеПриПримененииЗапросовНаИспользованиеВнешнихРесурсовВМоделиСервиса Экспорт;
// Конец ТехнологияСервиса

// Параметры для фоновых заданий
Перем ПараметрыПроверкиФоновыхЗаданий Экспорт;

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПередНачаломРаботыСистемы()
	
	//++ НЕ ГОСИС
	глФормаНачальнойНастройкиПрограммы = ОткрытиеФормПриНачалеРаботыСистемыВызовСервера.ФормаНачальнойНастройкиПрограммы();
	//-- НЕ ГОСИС
	
	// СтандартныеПодсистемы
	СтандартныеПодсистемыКлиент.ПередНачаломРаботыСистемы();
	// Конец СтандартныеПодсистемы
	
	//++ Локализация
	//++ НЕ ГОСИС
	// ИнтернетПоддержкаПользователей
	ИнтернетПоддержкаПользователейКлиент.ПередНачаломРаботыСистемы();
	// Конец ИнтернетПоддержкаПользователей
	//-- НЕ ГОСИС
	//-- Локализация
	
	// ПодключаемоеОборудование
	МенеджерОборудованияКлиент.ПередНачаломРаботыСистемы();
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

Процедура ПриНачалеРаботыСистемы()
	
	// СтандартныеПодсистемы
	СтандартныеПодсистемыКлиент.ПриНачалеРаботыСистемы();
	// Конец СтандартныеПодсистемы
	
	// ПодключаемоеОборудование
	МенеджерОборудованияКлиент.ПриНачалеРаботыСистемы();
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

Процедура ПередЗавершениемРаботыСистемы(Отказ, ТекстПредупреждения)
	
	// СтандартныеПодсистемы
	СтандартныеПодсистемыКлиент.ПередЗавершениемРаботыСистемы(Отказ, ТекстПредупреждения);
	// Конец СтандартныеПодсистемы
	
	// ПодключаемоеОборудование
	МенеджерОборудованияКлиент.ПередЗавершениемРаботыСистемы();
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

Процедура ОбработкаВнешнегоСобытия(Источник, Событие, Данные)
	
	//++ НЕ ГОСИС
	Если Лев(Источник, 17) = "MobileApplication" Тогда
		МобильныеПриложенияКлиент.ОбработатьВнешнееСобытиеОтМобильногоПриложения(Источник, Событие, Данные);
		Возврат;
	КонецЕсли;
	//-- НЕ ГОСИС
	
	глПодключаемоеОборудованиеСобытиеОбработано = Ложь;
	глШтрихкодыБольничныхЛистовСобытиеОбработано = Ложь;
	
	//РаботаСВнешнимОборудованием
	// Подготовить данные
	ОписаниеСобытия = Новый Структура();
	ОписаниеОшибки  = "";
	
	ОписаниеСобытия.Вставить("Источник", Источник);
	ОписаниеСобытия.Вставить("Событие",  Событие);
	ОписаниеСобытия.Вставить("Данные",   Данные);
	
	// Передать на обработку данные
	Результат = МенеджерОборудованияКлиент.ОбработатьСобытиеОтУстройства(ОписаниеСобытия, ОписаниеОшибки);
	Если Не Результат Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='При обработке внешнего события от устройства произошла ошибка.'")
		                                                 + Символы.ПС + ОписаниеОшибки);
	КонецЕсли;
	//Конец РаботаСВнешнимОборудованием
	
КонецПроцедуры

#КонецОбласти

#Область Инициализация

//++ НЕ ГОСИС
глНомерКонтейнераСбербанк     = 0;
глУстановленКаналСоСбербанком = Ложь;
//-- НЕ ГОСИС

глПодключаемоеОборудованиеСобытиеОбработано = Ложь;
глШтрихкодыБольничныхЛистовСобытиеОбработано = Ложь;

#КонецОбласти