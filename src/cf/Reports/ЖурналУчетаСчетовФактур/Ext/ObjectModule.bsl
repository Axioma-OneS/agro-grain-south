﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если НачалоПериода > КонецПериода Тогда
		
		ТекстСообщения = НСтр("ru = 'Неправильно задан период формирования отчета.
			|Дата начала больше даты окончания периода.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "Отчет.НачалоПериода",, Отказ);
		
	ИначеЕсли НЕ УчетНДСПереопределяемый.ДатыРасположеныВнутриОдногоНалоговогоПериода(Организация, НачалоПериода, КонецПериода) Тогда
		
		ТекстСообщения = НСтр("ru = 'Неправильно задан период формирования отчета.
			|Выберите даты внутри одного налогового периода.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "Отчет.КонецПериода",, Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли