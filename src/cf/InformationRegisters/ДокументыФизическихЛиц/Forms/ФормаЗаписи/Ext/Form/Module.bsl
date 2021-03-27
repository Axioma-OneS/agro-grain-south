﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьВидимостьДоступность(ЭтотОбъект);
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Запись, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Возврат; // в УТ11 не используется
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если Запись.ЯвляетсяДокументомУдостоверяющимЛичность Тогда
		ПараметрыЗаписи = Новый Структура;
		ПараметрыЗаписи.Вставить("ВидДокумента", Запись.ВидДокумента);
		ПараметрыЗаписи.Вставить("ПаспортСерия", Запись.Серия);
		ПараметрыЗаписи.Вставить("ПаспортНомер", Запись.Номер);
		ПараметрыЗаписи.Вставить("ПаспортВыдан", Запись.КемВыдан);
		ПараметрыЗаписи.Вставить("ПаспортДатаВыдачи", Запись.ДатаВыдачи);
		ПараметрыЗаписи.Вставить("Представление", Запись.Представление);
		Оповестить("Запись_ДокументФизЛица", ПараметрыЗаписи, ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидДокументаПриИзменении(Элемент)
	
	Если ЯвляетсяУдостоверениемЛичности(Запись.Физлицо, Запись.ВидДокумента, Запись.Период) Тогда
		Запись.ЯвляетсяДокументомУдостоверяющимЛичность = Истина;
	КонецЕсли;
	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ЯвляетсяУдостоверениемЛичности(Физлицо, ВидДокумента, Дата)
	
	Возврат РегистрыСведений.ДокументыФизическихЛиц.ЯвляетсяУдостоверениемЛичности(Физлицо, ВидДокумента, Дата);
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьДоступность(Форма)
	
	Возврат; // в УТ11 не используется
	
КонецПроцедуры

#КонецОбласти

