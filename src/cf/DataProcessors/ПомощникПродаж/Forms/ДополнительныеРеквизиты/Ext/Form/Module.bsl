﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ТолькоПросмотр = Параметры.ТолькоПросмотр;
	ТипДокумента = Параметры.ТипДокумента;
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип(ТипДокумента));
	ОписаниеТипов = Новый ОписаниеТипов(МассивТипов);
	
	МассивРеквизитов = Новый Массив();
	МассивРеквизитов.Добавить(Новый РеквизитФормы("Объект", ОписаниеТипов));
	
	ИзменитьРеквизиты(МассивРеквизитов);
	
	ЭтаФорма["Объект"].ДополнительныеРеквизиты.Загрузить(ПолучитьИзВременногоХранилища(Параметры.АдресВоВременномХранилище));
	 
	// Обработчик подсистемы "Свойства"
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Объект", ЭтаФорма["Объект"]);
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтаФорма, ДополнительныеПараметры);
	
	Если ТолькоПросмотр Тогда
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаДополнительныеРеквизиты", "ТолькоПросмотр", Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения,  СтандартнаяОбработка)
	
	Если ПринудительноЗакрытьФорму Тогда
		Возврат;
	КонецЕсли;
	
	Если Модифицированность И Не СохранитьПараметры И НЕ ЗавершениеРаботы Тогда
		
		СписокКнопок = Новый СписокЗначений();
		СписокКнопок.Добавить("Закрыть", НСтр("ru = 'Закрыть'"));
		СписокКнопок.Добавить("НеЗакрывать", НСтр("ru = 'Не закрывать'"));
		
		ДополнительныеПараметры = Новый Структура;
		Отказ = Истина;
		ПоказатьВопрос(
			Новый ОписаниеОповещения("ПередЗакрытиемВопросЗавершение", ЭтотОбъект, ДополнительныеПараметры),
			НСтр("ru = 'Дополнительные реквизиты были изменены. Закрыть без сохранения реквизитов?'"),
			СписокКнопок);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемВопросЗавершение(ОтветНаВопрос, ДополнительныеРеквизиты) Экспорт
	
	Если ОтветНаВопрос = "НеЗакрывать" Тогда
		
		СохранитьПараметры = Ложь;
		
	Иначе
		
		ПринудительноЗакрытьФорму = Истина;
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если СохранитьПараметры И НЕ ЗавершениеРаботы Тогда
		
		РезультатВыбора = ПоместитьДополнительныеРеквизитыВХранилище();
		ОповеститьОВыборе(РезультатВыбора);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Если Не ТолькоПросмотр Тогда
		СохранитьПараметры = Истина;
	КонецЕсли;
		
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#Область Прочее

&НаСервере
Функция ПоместитьДополнительныеРеквизитыВХранилище()
	
	// Обработчик механизма "Свойства"
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтаФорма,  ЭтаФорма["Объект"]);
	
	АдресТоваровВХранилище = ПоместитьВоВременноеХранилище(ЭтаФорма["Объект"].ДополнительныеРеквизиты.Выгрузить(), УникальныйИдентификатор);
	Возврат Новый Структура("ТипДокумента,ДополнительныеРеквизиты", ТипДокумента, АдресТоваровВХранилище);
	
КонецФункции

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#КонецОбласти
