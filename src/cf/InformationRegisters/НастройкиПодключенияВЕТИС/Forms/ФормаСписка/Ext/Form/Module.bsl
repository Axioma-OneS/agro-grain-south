﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Элемент = Элементы.Найти("ФормаСоздать");
	Если Элемент <> Неопределено Тогда
		Элемент.Отображение = ОтображениеКнопки.КартинкаИТекст;
	КонецЕсли;
	
	Элемент = Элементы.Найти("ФормаСкопировать");
	Если Элемент <> Неопределено Тогда
		Элемент.Видимость = Ложь;
	КонецЕсли;
	
	СобытияФормИСПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
	Если НЕ Копирование Тогда
		ОткрытьФорму("РегистрСведений.НастройкиПодключенияВЕТИС.Форма.ФормаНовогоПодключения",, ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
