﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - Структура - см. возвращаемое значение ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	Настройки.События.ПриСозданииНаСервере = Истина;
КонецПроцедуры

// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   Отказ - Передается из параметров обработчика "как есть".
//   СтандартнаяОбработка - Передается из параметров обработчика "как есть".
//
// См. также:
//   "ФормаКлиентскогоПриложения.ПриСозданииНаСервере" в синтакс-помощнике.
//
Процедура ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка) Экспорт
	
	КомпоновщикНастроекФормы = ЭтаФорма.Отчет.КомпоновщикНастроек;
	Параметры = ЭтаФорма.Параметры;
	
	Если Параметры.Свойство("ПараметрКоманды") Тогда
		
		ЭтаФорма.ФормаПараметры.КлючНазначенияИспользования = Параметры.ПараметрКоманды;
		Параметры.КлючНазначенияИспользования = Параметры.ПараметрКоманды;
		
		ПараметрРегистратор = ПолучитьДокументыРасчетовСПоставщиками(Параметры.ПараметрКоманды);
		
		ЭтаФорма.ФормаПараметры.Отбор.Вставить("ДокументПередачи", ПараметрРегистратор);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьДокументыРасчетовСПоставщиками(Документ)
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	Товары.ДокументРеализации КАК  ДокументРеализации
		|ИЗ
		|	Документ.ВозвратТоваровОтКлиента.Товары КАК Товары
		|ГДЕ
		|	Товары.Ссылка В (&Документ)
		|ОБЪЕДИНИТЬ ВСЕ
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Товары.ДокументРеализации КАК  ДокументРеализации
		|ИЗ
		|	Документ.ВыкупВозвратнойТарыКлиентом.Товары КАК Товары
		|ГДЕ
		|	Товары.Ссылка В (&Документ)
		|ОБЪЕДИНИТЬ ВСЕ
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	РеализацияТоваровУслуг.Ссылка КАК  ДокументРеализации
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|ГДЕ
		|	Товары.Ссылка В (&Документ)
		|");
		
	Если ТипЗнч(Документ) <> Тип("СписокЗначений") Тогда
		СписокДокументов = Новый СписокЗначений();
		СписокДокументов.Добавить(Документ);
	Иначе
		СписокДокументов = Документ;
	КонецЕсли;
		
	Запрос.УстановитьПараметр("Документ", СписокДокументов);
	МассивДокументов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ДокументРеализации");
	СписокОтбора = Новый СписокЗначений();
	СписокОтбора.ЗагрузитьЗначения(МассивДокументов);
	Возврат СписокОтбора;
	
КонецФункции

#КонецОбласти

#КонецЕсли