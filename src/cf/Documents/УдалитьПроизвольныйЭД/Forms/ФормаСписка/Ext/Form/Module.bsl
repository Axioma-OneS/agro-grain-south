﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если НЕ ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ЗначениеФункциональнойОпции("ИспользоватьОбменЭД") Тогда
		ТекстСообщения = ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ТекстСообщенияОНеобходимостиНастройкиСистемы("РаботаСЭД");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , , , Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновитьСостояниеЭД" Тогда
		Элементы.СписокИсходящих.Обновить();
		Элементы.СписокВходящих.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьПодчиненныеДокументы(СтрокаОснование, МассивСтрок, ТЗПодчиненных)
	
	ТЗ = ТЗПодчиненных.Скопировать(МассивСтрок);
	ТЗ.Сортировать("Дата, Номер");
	Для Каждого СтрокаТЗ Из ТЗ Цикл
		НоваяСтрока = СтрокаОснование.Строки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТЗ);
		Отбор = Новый Структура("ДокументОснование", СтрокаТЗ.Ссылка);
		НайденныеСтроки = ТЗПодчиненных.НайтиСтроки(Отбор);
		Если НайденныеСтроки.Количество() > 0 Тогда
			ЗаполнитьПодчиненныеДокументы(НоваяСтрока, НайденныеСтроки, ТЗПодчиненных);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СписокВходящих.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("СписокВходящих.Прочитан");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(WindowsШрифты.ШрифтДиалоговИМеню, , , Истина, Ложь, Ложь, Ложь));
	
	
КонецПроцедуры

#КонецОбласти
