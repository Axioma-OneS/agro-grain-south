﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

#Область КомандыПодменюОтчеты

// Добавляет команду отчета в список команд.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов.
//
Функция ДобавитьКомандуОтчета(КомандыОтчетов) Экспорт

	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.ТоварыПринятыеНаКомиссию) 
			И ПолучитьФункциональнуюОпцию("ИспользоватьКомиссиюПриЗакупках") Тогда
		
		КомандаОтчет = КомандыОтчетов.Добавить();
		
		КомандаОтчет.Менеджер = Метаданные.Отчеты.ТоварыПринятыеНаКомиссию.ПолноеИмя();
		КомандаОтчет.Представление = НСтр("ru = 'Товары, принятые на комиссию'");
		
		КомандаОтчет.МножественныйВыбор = Ложь;
		КомандаОтчет.Важность = "Обычное";
		КомандаОтчет.КлючВарианта = "ТоварыПринятыеНаКомиссию";		
		Возврат КомандаОтчет;
		
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

#КонецОбласти

#КонецОбласти
		
#КонецЕсли