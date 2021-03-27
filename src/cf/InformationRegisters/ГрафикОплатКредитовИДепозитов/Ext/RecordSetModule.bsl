﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	СуммаИтог = 0; ПроцентыИтог = 0; КомиссияИтог = 0;
	Для каждого СтрокаНабора Из ЭтотОбъект Цикл
		
		СуммаИтог = СуммаИтог + СтрокаНабора.Сумма;
		СтрокаНабора.СуммаИтог = СуммаИтог;
		
		ПроцентыИтог = ПроцентыИтог + СтрокаНабора.Проценты;
		СтрокаНабора.ПроцентыИтог = ПроцентыИтог;
		
		КомиссияИтог = КомиссияИтог + СтрокаНабора.Комиссия;
		СтрокаНабора.КомиссияИтог = КомиссияИтог;
	КонецЦикла;
	
	СФормироватьТаблицуОбъектовОплаты();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	РегистрыСведений.ГрафикПлатежей.РассчитатьГрафикПлатежейПоФинансовымИнструментам(
		ДополнительныеСвойства.ТаблицаОбъектовОплаты.ВыгрузитьКолонку("ОбъектОплаты"));
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		Для Каждого СтрокаНабора Из ЭтотОбъект Цикл
			ЗаполнитьЗначенияСвойств(СтрокаНабора, ДанныеЗаполнения);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует таблицу заказов, которые были раньше в движениях и которые сейчас будут записаны.
//
Процедура СФормироватьТаблицуОбъектовОплаты()
	
	Договор = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Отбор.ВариантГрафика.Значение, "Владелец");
	
	ТаблицаОбъектовОплаты = Новый ТаблицаЗначений;
	ТаблицаОбъектовОплаты.Колонки.Добавить("ОбъектОплаты");
	ТаблицаОбъектовОплаты.Колонки.Добавить("ВариантГрафика");
	НоваяСтрока = ТаблицаОбъектовОплаты.Добавить();
	НоваяСтрока.ОбъектОплаты = Договор;
	НоваяСтрока.ВариантГрафика = Отбор.ВариантГрафика.Значение;
	
	ДополнительныеСвойства.Вставить("ТаблицаОбъектовОплаты", ТаблицаОбъектовОплаты);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли