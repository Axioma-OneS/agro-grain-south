﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Форма предполагает несколько различных сценариев использования.
	// Для определения сценария работы используется параметр СценарийИспользования. Тип Строка.
	// На текущий момент известно о трех сценариях работы, они обозначаются следующими значениями параметра:
	//  * ПубликацияТорговыхПредложенийБезКонтекста
	//  * ПубликацияТорговыхПредложений
	//  * ВыгрузкаНоменклатуры
	// Значение по умолчанию – ПубликацияТорговыхПредложенийБезКонтекста для обеспечения обратной совместимости (то есть если параметр не задан)
	// При появлении новых сценариев, форму нужно будет адаптировать под них.
	Если Параметры.Свойство("СценарийИспользования") Тогда
		СценарийИспользования = Параметры.СценарийИспользования;
	Иначе
		СценарийИспользования = "ПубликацияТорговыхПредложенийБезКонтекста";
	КонецЕсли;
	
	Если СценарийИспользования = "ПубликацияТорговыхПредложенийБезКонтекста" Тогда
		Заголовок = НСтр("ru = 'Свойство категории 1С:Бизнес-сеть'");
	ИначеЕсли СценарийИспользования = "ПубликацияТорговыхПредложений" Тогда
		Заголовок = НСтр("ru = 'Свойство категории 1С:Бизнес-сеть'");
	ИначеЕсли СценарийИспользования = "ВыгрузкаНоменклатуры" Тогда
		Заголовок = НСтр("ru = 'Свойство категории 1С:Номенклатура'");
	КонецЕсли;
	
	Параметры.Свойство("ИдентификаторКатегории"          , ИдентификаторКатегории);
	Параметры.Свойство("ИдентификаторРеквизитаКатегории" , ИдентификаторРеквизита);
	Параметры.Свойство("Категория"                       , Категория);
	Параметры.Свойство("ПредставлениеРеквизитаКатегории" , Свойство);
	Параметры.Свойство("ТипРеквизитаРубрикатора"         , ТипРеквизитаРубрикатора);
	
	Если ТипРеквизитаРубрикатора = "Список" Тогда
		КлючСохраненияПоложенияОкна = "Список";
		ЗагрузитьЗначенияРеквизитаРубрикатора(Отказ);
	Иначе
		КлючСохраненияПоложенияОкна = "Значение";
		Элементы.Список.Видимость   = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗагрузитьЗначенияРеквизитаРубрикатора(Отказ)
	
	ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("ИдентификаторКатегории"                , ИдентификаторКатегории);
	ПараметрыМетода.Вставить("ИдентификаторДополнительногоРеквизита" , ИдентификаторРеквизита);
	Результат = РаботаСНоменклатурой.ДанныеЗначенийДополнительногоРеквизитаКатегории(ПараметрыМетода, Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат.Количество() Тогда
		
		ТаблицаЗначений = Результат[0].Значения;
		
		Для Каждого ЗначенияРубрикатора Из ТаблицаЗначений Цикл
			НоваяСтрока = Список.Добавить();
			НоваяСтрока.Значение = ЗначенияРубрикатора.Наименование;
		КонецЦикла;
		
		Список.Сортировать("Значение");
			
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
