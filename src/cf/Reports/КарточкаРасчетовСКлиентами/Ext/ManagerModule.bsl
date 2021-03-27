﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

#Область КомандыПодменюОтчеты

// Добавляет команду отчета в список команд.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов.
//
Функция ДобавитьКомандуКарточкаРасчетовСКлиентом(КомандыОтчетов) Экспорт
	
	Если Константы.НоваяАрхитектураВзаиморасчетов.Получить() Тогда
		Если ПравоДоступа("Просмотр", Метаданные.Отчеты.КарточкаРасчетовСКлиентами24) Тогда
			
			КомандаОтчет = КомандыОтчетов.Добавить();
			
			КомандаОтчет.Менеджер = Метаданные.Отчеты.КарточкаРасчетовСКлиентами24.ПолноеИмя();
			КомандаОтчет.Представление = НСтр("ru = 'Карточка расчетов с клиентами'");
			
			КомандаОтчет.МножественныйВыбор = Истина;
			КомандаОтчет.Важность = "Обычное";
			КомандаОтчет.ФункциональныеОпции = "ИспользоватьДанныеПартнераКлиентаКонтекст";
			КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "Карточка");
			
			Возврат КомандаОтчет;
			
		КонецЕсли;
	Иначе
		Если ПравоДоступа("Просмотр", Метаданные.Отчеты.КарточкаРасчетовСКлиентами) Тогда
			
			КомандаОтчет = КомандыОтчетов.Добавить();
			
			КомандаОтчет.Менеджер = Метаданные.Отчеты.КарточкаРасчетовСКлиентами.ПолноеИмя();
			КомандаОтчет.Представление = НСтр("ru = 'Карточка расчетов с клиентами'");
			
			КомандаОтчет.МножественныйВыбор = Истина;
			КомандаОтчет.Важность = "Обычное";
			КомандаОтчет.ФункциональныеОпции = "ИспользоватьДанныеПартнераКлиентаКонтекст";
			КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "КарточкаРасчетовСКлиентом");
			
			Возврат КомандаОтчет;
			
		КонецЕсли;
	КонецЕсли;
	
	Возврат Неопределено;

КонецФункции

// Добавляет команду отчета в список команд.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов.
//
Функция ДобавитьКомандуКарточкаРасчетовСКлиентомПоДокументам(КомандыОтчетов) Экспорт
	
	Если Константы.НоваяАрхитектураВзаиморасчетов.Получить() Тогда
		Если ПравоДоступа("Просмотр", Метаданные.Отчеты.КарточкаРасчетовСКлиентами24) Тогда
			
			КомандаОтчет = КомандыОтчетов.Добавить();
			
			КомандаОтчет.Менеджер = Метаданные.Отчеты.КарточкаРасчетовСКлиентами24.ПолноеИмя();
			КомандаОтчет.Представление = НСтр("ru = 'Карточка расчетов с клиентами'");
			
			КомандаОтчет.МножественныйВыбор = Истина;
			КомандаОтчет.Важность = "Важное";
			КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "Карточка");
			
			Возврат КомандаОтчет;
			
		КонецЕсли;
	Иначе
		Если ПравоДоступа("Просмотр", Метаданные.Отчеты.КарточкаРасчетовСКлиентами) Тогда
			
			КомандаОтчет = КомандыОтчетов.Добавить();
			
			КомандаОтчет.Менеджер = Метаданные.Отчеты.КарточкаРасчетовСКлиентами.ПолноеИмя();
			КомандаОтчет.Представление = НСтр("ru = 'Карточка расчетов с клиентами'");
			
			КомандаОтчет.МножественныйВыбор = Истина;
			КомандаОтчет.Важность = "Важное";
			КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "КарточкаРасчетовСКлиентомПоДокументам");
			
			Возврат КомандаОтчет;
			
		КонецЕсли;
	КонецЕсли;
	
	Возврат Неопределено;

КонецФункции

#КонецОбласти

#КонецОбласти
		
#КонецЕсли