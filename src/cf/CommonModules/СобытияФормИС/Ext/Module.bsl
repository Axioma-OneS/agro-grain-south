﻿#Область ПрограммныйИнтерфейс

Процедура ПриЧтенииНаСервере(Форма, ТекущийОбъект) Экспорт
	
	ШтрихкодированиеИС.ИнициализироватьКэшМаркируемойПродукции(Форма);
	
	МодификацияФормы(Форма);
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормЕГАИС");
			Модуль.ПриЧтенииНаСервере(Форма, ТекущийОбъект);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормВЕТИС");
			Модуль.ПриЧтенииНаСервере(Форма, ТекущийОбъект);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормГИСМ");
			Модуль.ПриЧтенииНаСервере(Форма, ТекущийОбъект);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормИСМП");
			Модуль.ПриЧтенииНаСервере(Форма, ТекущийОбъект);
		КонецЕсли;
		
	КонецЕсли;
	
	ЗаполнениеРеквизитовГосИС(Форма);
	
КонецПроцедуры

Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка, ДополнительныеПараметры) Экспорт
	
	ТребуетсяЗаполнениеРеквизитов = Ложь;
	
	Если Не ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		МодификацияФормы(Форма);
		ШтрихкодированиеИС.ИнициализироватьКэшМаркируемойПродукции(Форма);
		ТребуетсяЗаполнениеРеквизитов = Истина;
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		СобытияФормИСПереопределяемый.ПриСозданииНаСервереВФормеПрикладногоОбъекта(Форма, Отказ, СтандартнаяОбработка, ДополнительныеПараметры);
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормЕГАИС");
			Модуль.ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормВЕТИС");
			Модуль.ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормГИСМ");
			Модуль.ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормИСМП");
			Модуль.ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
		КонецЕсли;
		
		Если ТребуетсяЗаполнениеРеквизитов Тогда
			ЗаполнениеРеквизитовГосИС(Форма);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеЗаписиНаСервере(Форма) Экспорт
	
	ЗаполнениеРеквизитовГосИС(Форма);
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		СобытияФормИСПереопределяемый.ПослеЗаписиНаСервереФормыПрикладногоОбъекта(Форма);
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормЕГАИС");
			Модуль.ПослеЗаписиНаСервере(Форма);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормВЕТИС");
			Модуль.ПослеЗаписиНаСервере(Форма);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормГИСМ");
			Модуль.ПослеЗаписиНаСервере(Форма);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормИСМП");
			Модуль.ПослеЗаписиНаСервере(Форма);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#Область СобытияЭлементовФорм

// Серверная процедура, вызываемая из обработчика события элемента.
//
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, в которой происходит событие.
//   Элемент                 - Произвольный     - источник события
//   ДополнительныеПараметры - Структура        - значения дополнительных параметров влияющих на обработку.
//
Процедура ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	Если Элемент = "Подключаемый_ОбработатьВводШтрихкода" Тогда 
		
		ДополнительныеПараметры.РезультатОбработкиШтрихкода = ШтрихкодированиеИС.ОбработатьВводШтрихкода(
			Форма, 
			ДополнительныеПараметры.ДанныеШтрихкода,
			ДополнительныеПараметры.КэшированныеЗначения,
			ДополнительныеПараметры.ПараметрыСканирования);
		
	ИначеЕсли Элемент = "Подключаемый_ВыполнитьДействие" Тогда 
		
		ПараметрыОбработкиВыбора    = ШтрихкодированиеИС.ИнициализироватьПараметрыОбработкиВыбора(
			ДополнительныеПараметры.РезультатВыбора,
			ДополнительныеПараметры.РезультатОбработкиШтрихкода,
			ДополнительныеПараметры.КэшированныеЗначения);
		
		ДополнительныеПараметры.РезультатОбработкиШтрихкода = ШтрихкодированиеИС.ВыполнитьДействие(
			Форма,
			ДополнительныеПараметры.Действие,
			ПараметрыОбработкиВыбора);
		
	ИначеЕсли Элемент = "ОбработатьДанныеШтрихкода" Тогда
		
		ДанныеШтрихкода       = ДополнительныеПараметры.ДанныеШтрихкода;
		КэшированныеЗначения  = ДополнительныеПараметры.КэшированныеЗначения;
		ПараметрыСканирования = ДополнительныеПараметры.ПараметрыСканирования;
		
		РезультатОбработкиШтрихкода = ШтрихкодированиеИС.ОбработатьВводШтрихкода(
			Форма, ДанныеШтрихкода, КэшированныеЗначения, ПараметрыСканирования);
		ДополнительныеПараметры.Вставить("РезультатОбработкиШтрихкода", РезультатОбработкиШтрихкода);
		
	ИначеЕсли Элемент = "ОбработкаКодаМаркировкиВыполнитьДействиеСервер" Тогда
		
		РезультатВыбора             = ДополнительныеПараметры.РезультатВыбора;
		РезультатОбработкиШтрихкода = ДополнительныеПараметры.РезультатОбработкиШтрихкода;
		КэшированныеЗначения        = ДополнительныеПараметры.КэшированныеЗначения;
		Действие                    = ДополнительныеПараметры.Действие;
		
		ПараметрыОбработкиВыбора    = ШтрихкодированиеИС.ИнициализироватьПараметрыОбработкиВыбора(РезультатВыбора, РезультатОбработкиШтрихкода, КэшированныеЗначения);
		РезультатОбработкиШтрихкода = ШтрихкодированиеИС.ВыполнитьДействие(Форма, Действие, ПараметрыОбработкиВыбора);
		ДополнительныеПараметры.РезультатОбработкиШтрихкода = РезультатОбработкиШтрихкода;
		
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		СобытияФормИСПереопределяемый.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормЕГАИС");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормВЕТИС");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормГИСМ");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначения.ОбщийМодуль("СобытияФормИСМП");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ГиперссылкиВСвязанныхФормахОбъектов

// Модифицирует прикладные формы: добавляет необходимые реквизиты, элементы, команды ГосИС
//   Требуется выполнить до прочей работы с ГосИС в прикладных формах.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - модифицируемая форма
//
Процедура МодификацияФормы(Форма)
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		Возврат;
	КонецЕсли;
	
	МодулиМодификацииФормыГосИС = Новый Массив;
	ДобавляемыеРеквизиты = Новый Массив;
	СобытияФормИСПереопределяемый.ПриОпределенииПараметровИнтеграцииФормыПрикладногоОбъекта(Форма, МодулиМодификацииФормыГосИС);
	
	ПараметрыИнтеграцииГосИС = Новый Соответствие;
	
	Если МодулиМодификацииФормыГосИС.Количество() Тогда
		
		Реквизит = Новый РеквизитФормы("ПараметрыИнтеграцииГосИС", Новый ОписаниеТипов);
		ДобавляемыеРеквизиты.Добавить(Реквизит);
		
		Для Каждого ИмяМодуля Из МодулиМодификацииФормыГосИС Цикл
			
			МодульМодификации = ОбщегоНазначения.ОбщийМодуль(ИмяМодуля);
			МодульМодификации.МодификацияРеквизитовФормы(Форма, ПараметрыИнтеграцииГосИС, ДобавляемыеРеквизиты);
			
		КонецЦикла;
		
		Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
		Форма.ПараметрыИнтеграцииГосИС = Новый ФиксированноеСоответствие(ПараметрыИнтеграцииГосИС);
		
		Для Каждого ИмяМодуля Из МодулиМодификацииФормыГосИС Цикл
			
			МодульМодификации = ОбщегоНазначения.ОбщийМодуль(ИмяМодуля);
			МодульМодификации.МодификацияЭлементовФормы(Форма);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

// Заполнение созданных реквизитов ГосИС 
//   Требуется выполнить при открытии формы после создания реквизитов, после записи объекта (перезаполнение).
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - заполняемая форма.
//
Процедура ЗаполнениеРеквизитовГосИС(Форма)
	
	Если НЕ ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого КлючИЗначение Из Форма.ПараметрыИнтеграцииГосИС Цикл
		
		Если ТипЗнч(КлючИЗначение.Значение) = Тип("Структура") Тогда
			Если КлючИЗначение.Значение.Свойство("МодульЗаполнения") Тогда
				ИмяМодуляЗаполнения = КлючИЗначение.Значение.МодульЗаполнения;
				Если ЗначениеЗаполнено(ИмяМодуляЗаполнения) Тогда
					МодульЗаполнения = ОбщегоНазначения.ОбщийМодуль(ИмяМодуляЗаполнения);
					МодульЗаполнения.ЗаполнениеРеквизитовФормы(Форма);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает структуру, заполненную значениями по умолчанию, используемую для интеграции реквизитов ГосИС
//   в прикладные формы конфигурации - потребителя библиотеки ГосИС.
//   Содержит настройки встраивания 1 реквизита формы в связке с 1 элементом.
//
// ВозвращаемоеЗначение:
//  ПараметрыИнтеграции - Структура - значения, используемые для интеграции форматированной строки в прикладной документ:
//   * Ключ                       - Строка - ключ настроек интеграции
//   * ИмяЭлементаФормы           - Строка - имя элемента для размещения на форме
//   * ИмяРодительскойГруппыФормы - Строка - имя группы для размещения на форме (для унификации она всегда создается)
//   * РазмещениеВ                - Строка - имя группы/страницы формы где будет размещаться создаваемая группа
//   * РазмещениеПеред            - Строка - имя элемента формы перед которым будет размещаться создаваемая группа
//   * ИмяРеквизитаФормы          - Строка - имя реквизита формы, содержащего форматированную строку (для создания)
//   * Заголовок                  - Строка - заголовок создаваемого реквизита (пустой = не отображать).
//
Функция ПараметрыИнтеграцииДляДокументаОснования() Экспорт
	
	ПараметрыНадписи = Новый Структура();
	ПараметрыНадписи.Вставить("Ключ",                       "ЗаполнениеТекстаДокументаГосИС");
	ПараметрыНадписи.Вставить("ИмяЭлементаФормы",           "");
	ПараметрыНадписи.Вставить("ИмяРодительскойГруппыФормы", "ГруппаСостояниеГосИС");
	ПараметрыНадписи.Вставить("РазмещениеВ",                "");
	ПараметрыНадписи.Вставить("РазмещениеПеред",            "");
	ПараметрыНадписи.Вставить("ИмяРеквизитаФормы",          "");
	ПараметрыНадписи.Вставить("Заголовок",                  "");
	
	Возврат ПараметрыНадписи;
	
КонецФункции

// Возвращает структуру, заполненную значениями по умолчанию, используемую для интеграции реквизитов ГосИС
//   в прикладные формы конфигурации - потребителя библиотеки ГосИС.
//   Содержит общие настройки встраивания подсистемы
//
// ВозвращаемоеЗначение:
//  ПараметрыИнтеграции - Структура - значения, используемые для интеграции подсистемы в прикладную форму:
//   * МодульЗаполнения        - Строка - модуль в котором размещаются действия по заполнению реквизитов ГосИС при открытии формы
//   * ИмяРеквизитаФормыОбъект - Строка - имя реквизита формы, содержащего связанный объект.
//
Функция ОбщиеПараметрыИнтеграции(ИмяМодуляЗаполнения = Неопределено) Экспорт
	
	ОбщиеПараметры = Новый Структура;
	ОбщиеПараметры.Вставить("МодульЗаполнения",        ИмяМодуляЗаполнения);
	ОбщиеПараметры.Вставить("ИмяРеквизитаФормыОбъект", "Объект");
	Возврат ОбщиеПараметры;
	
КонецФункции

//Добавляет в элементы формы-потребителя группу и элемент для взаимодействия со связанными библиотечными объектами ГосИС
//
//Параметры:
//   Форма     - ФормаКлиентскогоПриложения - форма-потребитель интеграции
//   Настройки - Структура        - настройки расположения и интерфейса элементов интеграции в прикладной форме
//     (См. ПараметрыИнтеграцииДляДокументаОснования).
//
Процедура ВстроитьСтрокуИнтеграцииВДокументОснованиеПоПараметрам(Форма, Настройки) Экспорт
	
	ПараметрыИнтеграции = Форма.ПараметрыИнтеграцииГосИС.Получить(Настройки);
	Если ПараметрыИнтеграции = Неопределено Тогда
		Возврат;
	ИначеЕсли НЕ ЗначениеЗаполнено(ПараметрыИнтеграции.ИмяЭлементаФормы) Тогда
		Возврат;
	ИначеЕсли ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма.Элементы, ПараметрыИнтеграции.ИмяЭлементаФормы) Тогда
		Возврат;
	КонецЕсли;
	
	ГруппаИнтеграцииГосИС = ДобавитьПолучитьГруппуИнтеграцииНаФормуДокументаОснования(Форма, ПараметрыИнтеграции);
	
	ДобавитьПолеИнтеграцииНаФормуДокументаОснования(Форма, ПараметрыИнтеграции, ГруппаИнтеграцииГосИС);
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции


// Добавляет группу интеграции на форму-потребитель (форму объекта прикладного документа конфигурации)
//
// Параметры:
//   Форма               - ФормаКлиентскогоПриложения - форма-потребитель интеграции
//   ПараметрыИнтеграции - Структура (См. ПараметрыИнтеграцииДляДокументаОснования)
//
// Возвращаемое значение:
//   ГруппаФормы         - добавленная группа интеграции
//
Функция ДобавитьПолучитьГруппуИнтеграцииНаФормуДокументаОснования(Форма, ПараметрыИнтеграции)
	
	ЭлементыФормы = Форма.Элементы;
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ЭлементыФормы, ПараметрыИнтеграции.ИмяРодительскойГруппыФормы) Тогда
		Возврат ЭлементыФормы[ПараметрыИнтеграции.ИмяРодительскойГруппыФормы];
	КонецЕсли;
	
	ГруппаИнтеграцииГосИС = ЭлементыФормы.Добавить(
		ПараметрыИнтеграции.ИмяРодительскойГруппыФормы,
		Тип("ГруппаФормы"),
		?(ЗначениеЗаполнено(ПараметрыИнтеграции.РазмещениеВ), ЭлементыФормы[ПараметрыИнтеграции.РазмещениеВ], Неопределено));
		
	Если ЗначениеЗаполнено(ПараметрыИнтеграции.РазмещениеПеред) Тогда
		ЭлементыФормы.Переместить(ГруппаИнтеграцииГосИС,
		ГруппаИнтеграцииГосИС.Родитель,
		ЭлементыФормы[ПараметрыИнтеграции.РазмещениеПеред]);
	КонецЕсли;
		
	ГруппаИнтеграцииГосИС.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаИнтеграцииГосИС.Отображение = ОтображениеОбычнойГруппы.Нет;
	ГруппаИнтеграцииГосИС.ОтображатьЗаголовок = Ложь;
	ГруппаИнтеграцииГосИС.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	
	Возврат ГруппаИнтеграцииГосИС;
	
КонецФункции


// Добавляет поле интеграции на форму-потребитель (форму объекта прикладного документа конфигурации)
//
// Параметры:
// 	Форма               - ФормаКлиентскогоПриложения - форма-потребитель интеграции
// 	ПараметрыИнтеграции - Структура        - (См. ПараметрыИнтеграцииДляДокументаОснования)
// 	ГруппаИнтеграции    - ГруппаФормы      - группа, в которую будет добавлено поле интеграции
//
Процедура ДобавитьПолеИнтеграцииНаФормуДокументаОснования(Форма, ПараметрыИнтеграции, ГруппаИнтеграции)
	
	ЭлементыФормы = Форма.Элементы;
	
	ТекстСостояния = ЭлементыФормы.Добавить(
		ПараметрыИнтеграции.ИмяЭлементаФормы,
		Тип("ПолеФормы"),
		ГруппаИнтеграции);
	
	Если НЕ ЗначениеЗаполнено(ПараметрыИнтеграции.Заголовок) Тогда
		ТекстСостояния.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	Иначе
		ТекстСостояния.Заголовок = ПараметрыИнтеграции.Заголовок;
	КонецЕсли;
	
	ТекстСостояния.Вид = ВидПоляФормы.ПолеНадписи;
	ТекстСостояния.АвтоМаксимальнаяШирина = Ложь;
	ТекстСостояния.ПутьКДанным = ПараметрыИнтеграции.ИмяРеквизитаФормы;
	
КонецПроцедуры

#КонецОбласти
