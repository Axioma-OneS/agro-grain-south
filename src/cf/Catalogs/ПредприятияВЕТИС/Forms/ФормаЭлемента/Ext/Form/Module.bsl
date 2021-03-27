﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Элементы.ФормаДанныеВЕТИС.Видимость = ПравоДоступа("Изменение", Метаданные.Справочники.ПредприятияВЕТИС);
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	СобытияФормИСПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ПредприятияВЕТИС"
		И (Источник = Объект.Ссылка
			ИЛИ (ТипЗнч(Параметр) = Тип("Структура")
				И Параметр.Свойство("Ссылка")
				И Параметр.Ссылка = Объект.Ссылка)) Тогда
		
		Прочитать();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДанныеВЕТИС(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Идентификатор",                 Объект.Идентификатор);
	ПараметрыФормы.Вставить("НеПоказыватьСостояниеЗагрузки", Истина);
	
	ОткрытьФорму(
		"Справочник.ПредприятияВЕТИС.Форма.ДанныеКлассификатора",
		ПараметрыФормы, ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти




