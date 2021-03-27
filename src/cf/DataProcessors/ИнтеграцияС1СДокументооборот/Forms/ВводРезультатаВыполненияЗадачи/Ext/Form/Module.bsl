﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Если ЗначениеЗаполнено(РезультатВыполнения) Тогда
		Закрыть(РезультатВыполнения);
	Иначе
		Элементы.РезультатВыполнения.АвтоОтметкаНезаполненного = Истина;
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
		    НСтр("ru = 'Поле ""Комментарий"" не заполнено'"),, 
			"РезультатВыполнения");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти