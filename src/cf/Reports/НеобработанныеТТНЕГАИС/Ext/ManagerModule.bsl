﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Настройки размещения в панели отчетов.
//
// Параметры:
//   Настройки - Коллекция - Используется для описания настроек отчетов и вариантов
//       см. описание к ВариантыОтчетов.ДеревоНастроекВариантовОтчетовКонфигурации().
//   НастройкиОтчета - СтрокаДереваЗначений - Настройки размещения всех вариантов отчета.
//       См. "Реквизиты для изменения" функции ВариантыОтчетов.ДеревоНастроекВариантовОтчетовКонфигурации().
//
// Описание:
//   См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
// Вспомогательные методы:
//   НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//   ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Истина/Ложь); 
// Отчет
//   поддерживает только этот режим.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Основной");
	
	НастройкиВарианта.ФункциональныеОпции.Добавить("ВестиСведенияДляДекларацийПоАлкогольнойПродукции");
	НастройкиВарианта.ВидимостьПоУмолчанию = Истина;
	НастройкиВарианта.Описание = НСтр("ru='Список ТТН, на которые не был отправлен акт.'");
	
	НастройкиВарианта.Размещение.Вставить(Метаданные.Подсистемы.ГосИС.Подсистемы.ЕГАИС.Подсистемы.ОтчетыЕГАИС);
	
КонецПроцедуры

// Возвращает Истина в случае наличия расхождений между полученными данными и данными ИБ. Ложь - в противном случае.
//
Функция ЕстьРасхожденияВПолученныхДанных(ДокументСсылка) Экспорт
	
	Возврат ОтчетыЕГАИС.ЕстьРасхожденияВПолученныхДанных(ДокументСсылка, Метаданные.Отчеты.НеобработанныеТТНЕГАИС.Имя);
	
КонецФункции

#КонецОбласти

#КонецЕсли