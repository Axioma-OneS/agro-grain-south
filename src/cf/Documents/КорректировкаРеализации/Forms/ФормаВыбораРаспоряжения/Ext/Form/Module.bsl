﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Перем ЗначениеОтбора;
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Отбор.Свойство("ХозяйственнаяОперация") Тогда
		
		Если ЗначениеЗаполнено(Параметры.Отбор.ХозяйственнаяОперация) Тогда
			
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список,
				"ХозяйственнаяОперация",
				Параметры.Отбор.ХозяйственнаяОперация,
				,,Истина);
			
		Иначе
			
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список,
				"ХозяйственнаяОперация",
				Перечисления.ХозяйственныеОперации.ПередачаНаКомиссию,
				ВидСравненияКомпоновкиДанных.НеРавно,, Истина);
			
		КонецЕсли;
		
		Параметры.Отбор.Удалить("ХозяйственнаяОперация");
		
	КонецЕсли;
	
	МассивОтборов = Новый Массив;
	МассивОтборов.Добавить("Организация");
	МассивОтборов.Добавить("Валюта");
	МассивОтборов.Добавить("Контрагент");
	МассивОтборов.Добавить("Договор");
	МассивОтборов.Добавить("НалогообложениеНДС");
	МассивОтборов.Добавить("Партнер");
	МассивОтборов.Добавить("Соглашение");
	МассивОтборов.Добавить("ЦенаВключаетНДС");
	
	Для каждого ИмяОтбора Из МассивОтборов Цикл
		Если Параметры.Отбор.Свойство(ИмяОтбора, ЗначениеОтбора) Тогда
			
			ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
				Список,
				ИмяОтбора,
				ЗначениеОтбора);
			
			Параметры.Отбор.Удалить(ИмяОтбора);
			
		КонецЕсли;
	КонецЦикла;
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Список,
		"Склад",
		Параметры.Склад);
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Список,
		"ДокументОснование",
		Параметры.ДокументОснование);
		
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Список,
		"ИспользоватьСоглашенияСКлиентами",
		ПолучитьФункциональнуюОпцию("ИспользоватьСоглашенияСКлиентами"));

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекущаяСтрока = Элементы.Список.ТекущиеДанные;
	ОповеститьОВыборе(ТекущаяСтрока.Ссылка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьРаспоряжение(Команда)
	
	ТекущаяСтрока = Элементы.Список.ТекущиеДанные;
	
	Если ТекущаяСтрока <> Неопределено Тогда
		ОповеститьОВыборе(ТекущаяСтрока.Ссылка);
	Иначе
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьДокумент(Команда)
	
	ТекущаяСтрока = Элементы.Список.ТекущиеДанные;
	
	Если ТекущаяСтрока <> Неопределено Тогда
		ПоказатьЗначение(Неопределено, ТекущаяСтрока.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти
