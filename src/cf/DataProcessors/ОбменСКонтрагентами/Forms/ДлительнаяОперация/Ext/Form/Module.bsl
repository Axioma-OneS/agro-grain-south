﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("Заголовок", Заголовок);
	
	Если Параметры.Свойство("ТекстСообщения") Тогда
		Если ЗначениеЗаполнено(Параметры.ТекстСообщения) Тогда
			Элементы.ДекорацияПоясняющийТекстДлительнойОперации.Заголовок = Параметры.ТекстСообщения;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти
