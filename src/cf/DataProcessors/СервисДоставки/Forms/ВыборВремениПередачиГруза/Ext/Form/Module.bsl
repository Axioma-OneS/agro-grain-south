﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ВремяРаботыС", ВремяРаботыС);
	Параметры.Свойство("ВремяРаботыПо", ВремяРаботыПо);
	Параметры.Свойство("ВремяОбедС", ВремяОбедаС);
	Параметры.Свойство("ВремяОбедПо", ВремяОбедаПо);
	Параметры.Свойство("ВариантВыбораВремени", ВариантВыбораВремени);
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Если ВремяЗаполнено() Тогда
		
		Если ВремяЗаполненоКорректно() Тогда
	
			ПараметрыЗакрытияФормы = Новый Структура();
			
			ПараметрыЗакрытияФормы.Вставить("ВремяРаботыС", ВремяРаботыС);
			ПараметрыЗакрытияФормы.Вставить("ВремяРаботыПо", ВремяРаботыПо);
			ПараметрыЗакрытияФормы.Вставить("ВремяОбедС", ВремяОбедаС);  
			ПараметрыЗакрытияФормы.Вставить("ВремяОбедПо", ВремяОбедаПо);
			ПараметрыЗакрытияФормы.Вставить("ВариантВыбораВремени", ВариантВыбораВремени);
			
			Закрыть(ПараметрыЗакрытияФормы);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры
 
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ВремяЗаполненоКорректно()
	
	Отказ = Ложь;
	ОписаниеОшибки = "";
	
	Если ВремяРаботыС >= ВремяРаботыПо И (ЗначениеЗаполнено(ВремяРаботыПо))Тогда
		
		ОписаниеОшибки = ОписаниеОшибки 
						+ ?(ЗначениеЗаполнено(ОписаниеОшибки), Символы.ПС, "")
						 + НСтр("ru='Время окончания работы должно быть больше времени начала работы'");
	КонецЕсли;
	
	Если (ЗначениеЗаполнено(ВремяОбедаПо))
		И ВремяОбедаС >= ВремяОбедаПо Тогда
		
		ОписаниеОшибки = ОписаниеОшибки 
						+ ?(ЗначениеЗаполнено(ОписаниеОшибки), Символы.ПС, "")
						+ НСтр("ru='Время окончания обеда должно быть больше времени начала обеда'");
	КонецЕсли;
	
	Если (ЗначениеЗаполнено(ВремяОбедаС) ИЛИ ЗначениеЗаполнено(ВремяОбедаПо)) 
		И (ВремяОбедаС < ВремяРаботыС) Тогда
		
		ОписаниеОшибки = ОписаниеОшибки 
						+ ?(ЗначениеЗаполнено(ОписаниеОшибки), Символы.ПС, "")
						+ НСтр("ru='Время начала обеда должно быть больше времени начала работы'");
	КонецЕсли;
	
	Если (ЗначениеЗаполнено(ВремяОбедаС) ИЛИ ЗначениеЗаполнено(ВремяОбедаПо)) 
		И (ВремяОбедаС > ВремяРаботыПо) Тогда
		
		ОписаниеОшибки = ОписаниеОшибки 
						+ ?(ЗначениеЗаполнено(ОписаниеОшибки), Символы.ПС, "")
						+ НСтр("ru='Время начала обеда должно быть больше времени начала работы'");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ВремяОбедаПо) И (ВремяОбедаПо > ВремяРаботыПо) Тогда
		
		ОписаниеОшибки = ОписаниеОшибки 
						+ ?(ЗначениеЗаполнено(ОписаниеОшибки), Символы.ПС, "")
						+ НСтр("ru='Время окончания обеда должно быть меньше времени окончания работы'");
	КонецЕсли;
	
	Если ОписаниеОшибки <> "" Тогда
		Отказ = Истина;
		ПоказатьПредупреждение(,ОписаниеОшибки);
	КонецЕсли;
		
	Возврат Не Отказ;
	
КонецФункции

&НаКлиенте
Функция ВремяЗаполнено()
	
	Отказ = Ложь;
	
	ОписаниеОшибки = "";
	
	Если (ЗначениеЗаполнено(ВремяРаботыС)) И (Не ЗначениеЗаполнено(ВремяРаботыПо)) Тогда
		
		ОписаниеОшибки = ОписаниеОшибки 
						+ ?(ЗначениеЗаполнено(ОписаниеОшибки), Символы.ПС, "")
						 + НСтр("ru='Не заполнено время окончания работы'");
	КонецЕсли;
	
	Если (ЗначениеЗаполнено(ВремяОбедаС)) И (Не ЗначениеЗаполнено(ВремяОбедаПо)) Тогда
		
		ОписаниеОшибки = ОписаниеОшибки 
						+ ?(ЗначениеЗаполнено(ОписаниеОшибки), Символы.ПС, "")
						 + НСтр("ru='Не заполнено время окончания обеда'");
	КонецЕсли;
	
	Если ОписаниеОшибки <> "" Тогда
		Отказ = Истина;
		ПоказатьПредупреждение(,ОписаниеОшибки);
	КонецЕсли;
		
	Возврат Не Отказ;
	
КонецФункции

&НаСервере
Процедура УстановитьВидимостьДоступность()
	
	Элементы.ВремяРаботыС.ТолькоПросмотр = ТолькоПросмотр;
	Элементы.ВремяРаботыПо.ТолькоПросмотр = ТолькоПросмотр;
	Элементы.ВремяОбедаС.ТолькоПросмотр = ТолькоПросмотр;
	Элементы.ВремяОбедаПо.ТолькоПросмотр = ТолькоПросмотр;
	
КонецПроцедуры

#КонецОбласти
