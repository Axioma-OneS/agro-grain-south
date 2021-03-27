﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Параметры.Свойство("Ключ"    ,Элементы.ОписаниеОшибокКлючПараметра.Заголовок);
	Параметры.Свойство("Значение",Элементы.ОписаниеОшибокЗначениеПараметра.Заголовок);
	
	ОписаниеОшибокИсточник = Неопределено;
	
	Если Параметры.Свойство("ОписаниеОшибок", ОписаниеОшибокИсточник) Тогда
		
		Для Каждого Описание Из ОписаниеОшибокИсточник Цикл
			
			НоваяСтрока = ОписаниеОшибок.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Описание);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);
	
	ОтборЭлемента = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ОписаниеОшибок.Поставщик");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	
	ПолеЭлемента = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ОписаниеОшибокПоставщик");
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	
КонецПроцедуры

#КонецОбласти

