﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Параметры.НастройкаЯндексКассы) Тогда
		ТекущаяЗапись = РегистрыСведений.СтатусОбменовСЯндексКассой.СоздатьМенеджерЗаписи();
		ТекущаяЗапись.НастройкаЯндексКассы = Параметры.НастройкаЯндексКассы;
		ТекущаяЗапись.Прочитать();
		
		// Для новой настройки записей в регистре еще нет
		Если Не ТекущаяЗапись.Выбран() Тогда
			ТекущаяЗапись.НастройкаЯндексКассы = Параметры.НастройкаЯндексКассы;
			ТекущаяЗапись.Организация = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.НастройкаЯндексКассы, "Организация");
		КонецЕсли;
	
		ЗначениеВРеквизитФормы(ТекущаяЗапись, "Запись");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

#КонецОбласти