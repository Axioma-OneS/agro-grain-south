﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	СтруктураНастройки = Неопределено;
	Параметры.Свойство("ГруппировкаСпискаКОформлению", СтруктураНастройки);
	
	Если ТипЗнч(СтруктураНастройки) = Тип("Структура") И СтруктураНастройки.Количество() > 0 Тогда
		
		ИспользоватьГруппировку = Истина;
		
		Для Каждого ПолеГруппировки Из СтруктураНастройки Цикл
			ЭтотОбъект[ПолеГруппировки.Ключ] = Истина;
		КонецЦикла;
		
	КонецЕсли;
	
	Если ДатаПродажи Или Месяц Тогда
		Дата = Истина;
	КонецЕсли;
	
	Периодичность = ?(ДатаПродажи, "День", "Месяц");
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьДоговорыСКлиентами") И Договор Тогда
		Договор = Ложь;
	КонецЕсли;
	
	Элементы.ГруппаДетализацияФлажки.Доступность = ИспользоватьГруппировку;
	Элементы.ГруппаПериодичность.Доступность = Дата;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьГруппировкуПриИзменении(Элемент)
	
	Элементы.ГруппаДетализацияФлажки.Доступность = ИспользоватьГруппировку;
	
	Если Не ИспользоватьГруппировку Тогда
		
		Дата = Ложь;
		Договор = Ложь;
		Контрагент = Ложь;
		Менеджер = Ложь;
		Месяц = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	Элементы.ГруппаПериодичность.Доступность = Дата;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Применить(Команда)
	
	СтруктураНастройки = Новый Структура;
	Если Дата И Периодичность = "День" Тогда
		СтруктураНастройки.Вставить("ДатаПродажи", Нстр("ru='дням'"));
	КонецЕсли;
	Если Дата И Периодичность = "Месяц" Тогда
		СтруктураНастройки.Вставить("Месяц", Нстр("ru='месяцам'"));
	КонецЕсли;
	Если Договор Тогда
		СтруктураНастройки.Вставить("Договор", Нстр("ru='договорам'"));
	КонецЕсли;
	Если Контрагент Тогда
		СтруктураНастройки.Вставить("Контрагент", Нстр("ru='контрагентам'"));
	КонецЕсли;
	Если Менеджер Тогда
		СтруктураНастройки.Вставить("Менеджер", Нстр("ru='менеджерам'"));
	КонецЕсли;
	
	Закрыть(СтруктураНастройки);
	
КонецПроцедуры

#КонецОбласти