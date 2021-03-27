﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	ЕстьОшибки = Ложь;

	МассивДопустимыхТиповОС= РегистрыСведений.СвойстваЛокальныхКомпьютеровДляОблачногоАрхива.ПолучитьЗначенияДопустимыхТиповОС();

	Для каждого ТекущаяЗапись Из ЭтотОбъект Цикл
		ТекущаяЗапись.ТипОС = СтрЗаменить(ТекущаяЗапись.ТипОС, " ", "_"); // Стандартные функции возвращают, например, "Windows x86" вместо "Windows_x86".
		Если МассивДопустимыхТиповОС.Найти(ТекущаяЗапись.ТипОС) = Неопределено Тогда
			ЕстьОшибки = Истина;
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Недопустимое значение типа ОС: [%1]'"),
				ТекущаяЗапись.ТипОС);
			Сообщение = Новый СообщениеПользователю();
			Сообщение.Текст = ТекстСообщения;
			Сообщение.Поле  = "ТипОС";
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
		КонецЕсли;
	КонецЦикла;

	Отказ = ЕстьОшибки;

КонецПроцедуры

Процедура ПередЗаписью(Отказ, Замещение)

	// Проверка должна находиться в самом начале процедуры.
	// Это необходимо для того, чтобы никакая бизнес-логика объекта не выполнялась при записи объекта через механизм обмена данными,
	//  поскольку она уже была выполнена для объекта в том узле, где он был создан.
	// В этом случае все данные загружаются в ИБ "как есть", без искажений (изменений),
	//  проверок или каких-либо других дополнительных действий, препятствующих загрузке данных.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Для каждого ТекущаяЗапись Из ЭтотОбъект Цикл
		ТекущаяЗапись.MachineGuid = НРег(ТекущаяЗапись.MachineGuid);
		ТекущаяЗапись.ВерсияАгентаКопирования = ИнтернетПоддержкаПользователейКлиентСервер.ВнутреннееПредставлениеНомераВерсии(ТекущаяЗапись.ВерсияАгентаКопирования);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#КонецЕсли