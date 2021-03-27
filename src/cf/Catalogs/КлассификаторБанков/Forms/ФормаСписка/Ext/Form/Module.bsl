﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	ИмяОбработки = "ЗагрузкаКлассификатораБанков";
	ЕстьИсточникЗагрузкиДанных = Метаданные.Обработки.Найти(ИмяОбработки) <> Неопределено;
	
	МожноОбновлятьКлассификатор = Ложь;
	ИмяОбработки = "ЗагрузкаКлассификатораБанков";
	Если Метаданные.Обработки.Найти(ИмяОбработки) <> Неопределено Тогда
		МожноОбновлятьКлассификатор = Обработки[ИмяОбработки].ДоступнаЗагрузкаКлассификатора();
	КонецЕсли;
	
	МожноОбновлятьКлассификатор = МожноОбновлятьКлассификатор
		И Не ОбщегоНазначения.ЭтоПодчиненныйУзелРИБ()   // В узле РИБ обновляется автоматически.
		И ПравоДоступа("Изменение", Метаданные.Справочники.КлассификаторБанков); // Пользователь с необходимыми правами.
	
	Элементы.ФормаЗагрузитьКлассификатор.Видимость = МожноОбновлятьКлассификатор И ЕстьИсточникЗагрузкиДанных;
	
	Если ОбщегоНазначения.РазделениеВключено() Или ОбщегоНазначения.ЭтоПодчиненныйУзелРИБ() Тогда
		ТолькоПросмотр = Истина;
	КонецЕсли;
	
	ПредлагатьЗагрузкуКлассификатора = МожноОбновлятьКлассификатор И ЕстьИсточникЗагрузкиДанных 
		И РаботаСБанкамиСлужебный.ПредлагатьЗагрузкуКлассификатора();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ПредлагатьЗагрузкуКлассификатора Тогда
		ПодключитьОбработчикОжидания("ПредложитьЗагрузкуКлассификатора", 1, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗагрузитьКлассификатор(Команда)
	
	РаботаСБанкамиКлиент.ОткрытьФормуЗагрузкиКлассификатора();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	Список.УсловноеОформление.Элементы.Очистить();
	Элемент = Список.УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеятельностьПрекращена");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	
КонецПроцедуры

&НаКлиенте
Процедура ПредложитьЗагрузкуКлассификатора()
	
	РаботаСБанкамиКлиент.ПредложитьЗагрузкуКлассификатора();
	
КонецПроцедуры

#КонецОбласти