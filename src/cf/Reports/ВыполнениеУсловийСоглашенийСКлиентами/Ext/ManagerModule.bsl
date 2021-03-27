﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область КомандыПодменюОтчеты

// Добавляет команду отчета в список команд.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов.
//
Функция ДобавитьКомандуВыполнениеУсловийСоглашенийСКлиентами(КомандыОтчетов) Экспорт

	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.ВыполнениеУсловийСоглашенийСКлиентами) 
			И ПолучитьФункциональнуюОпцию("ИспользоватьСоглашенияСКлиентами") Тогда
		
		КомандаОтчет = КомандыОтчетов.Добавить();
		
		КомандаОтчет.Менеджер = Метаданные.Отчеты.ВыполнениеУсловийСоглашенийСКлиентами.ПолноеИмя();
		КомандаОтчет.Представление = НСтр("ru = 'Выполнение регулярных условий'");
		
		КомандаОтчет.МножественныйВыбор = Ложь;
		КомандаОтчет.Важность = "Важное";
		КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "ВыполнениеУсловийСоглашенийСКлиентами");
		
		Возврат КомандаОтчет;
		
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

// Добавляет команду отчета в список команд.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов.
//
Функция ДобавитьКомандуВыполнениеУсловийСоглашенийСКлиентамиПоПартнеру(КомандыОтчетов) Экспорт

	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.ВыполнениеУсловийСоглашенийСКлиентами) 
			И ПолучитьФункциональнуюОпцию("ИспользоватьСоглашенияСКлиентами") Тогда
		
		КомандаОтчет = КомандыОтчетов.Добавить();
		
		КомандаОтчет.Менеджер = Метаданные.Отчеты.ВыполнениеУсловийСоглашенийСКлиентами.ПолноеИмя();
		КомандаОтчет.Представление = НСтр("ru = 'Выполнение регулярных условий соглашений'");
		
		КомандаОтчет.МножественныйВыбор = Истина;
		КомандаОтчет.Важность = "Важное";
		КомандаОтчет.ФункциональныеОпции = "ИспользоватьДанныеПартнераКлиентаКонтекст";
		КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "ВыполнениеУсловийСоглашенийСКлиентамиПоПартнеру");
		
		Возврат КомандаОтчет;
		
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли