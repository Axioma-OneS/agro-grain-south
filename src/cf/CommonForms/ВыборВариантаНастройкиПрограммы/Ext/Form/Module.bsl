﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Элементы.ОткрытьПомощникПереходаСТорговляИСклад77.Видимость	 	  = ПолучитьФункциональнуюОпцию("УправлениеТорговлей");
	Элементы.ОткрытьПомощникПереходаСУправлениеТорговлей103.Видимость = ПолучитьФункциональнуюОпцию("УправлениеТорговлей");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьПомощникПереходаСТорговляИСклад77(Команда)
	
	ОткрытьФорму("Обработка.ПомощникПереходаСТорговляИСклад77.Форма");
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПомощникПереходаСУправлениеТорговлей103(Команда)
	
	ПараметрыОткрытия = Новый Структура("КонфигурацияИсточник", "УТ");
	ОткрытьФорму("Обработка.ПомощникПереходаСДругихКонфигураций.Форма.Форма", ПараметрыОткрытия);
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти
