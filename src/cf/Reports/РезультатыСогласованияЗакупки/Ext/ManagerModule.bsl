﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

#Область КомандыПодменюОтчеты

// Добавляет команду отчета в список команд.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов.
//
Функция ДобавитьКомандуОтчета(КомандыОтчетов) Экспорт

	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.РезультатыСогласованияЗакупки) 
			И ПолучитьФункциональнуюОпцию("ИспользоватьСогласованиеЗаказовПоставщикам") Тогда
		
		КомандаОтчет = КомандыОтчетов.Добавить();
		
		КомандаОтчет.Менеджер = Метаданные.Отчеты.РезультатыСогласованияЗакупки.ПолноеИмя();
		КомандаОтчет.Представление = НСтр("ru = 'Результаты согласования'");
		
		КомандаОтчет.МножественныйВыбор = Истина;
		КомандаОтчет.Важность = "Обычное";
		КомандаОтчет.ФункциональныеОпции = "ИспользоватьСогласованиеЗаказовПоставщикам";
		КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "РезультатыСогласованияЗакупки");
		
		Возврат КомандаОтчет;
		
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

// Добавляет команду отчета в список команд.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов.
//
Функция ДобавитьКомандуОтчетаПоДокументу(КомандыОтчетов) Экспорт

	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.РезультатыСогласованияЗакупки) 
			И ПолучитьФункциональнуюОпцию("ИспользоватьСогласованиеЗаказовПоставщикам") Тогда
		
		КомандаОтчет = КомандыОтчетов.Добавить();
		
		КомандаОтчет.Менеджер = Метаданные.Отчеты.РезультатыСогласованияЗакупки.ПолноеИмя();
		КомандаОтчет.Представление = НСтр("ru = 'Результаты согласования'");
		
		КомандаОтчет.МножественныйВыбор = Истина;
		КомандаОтчет.Важность = "Обычное";
		КомандаОтчет.ФункциональныеОпции = "ИспользоватьСогласованиеЗаказовПоставщикам";
		КомандаОтчет.ДополнительныеПараметры.Вставить("ИмяКоманды", "РезультатыСогласованияЗакупкиПоДокументу");
		
		Возврат КомандаОтчет;
		
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

#КонецОбласти

#КонецОбласти
		
#КонецЕсли