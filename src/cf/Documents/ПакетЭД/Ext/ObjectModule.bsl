﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Статусы = ОбменСКонтрагентамиСлужебный.СтатусыОбработанногоПакетаЭД();
	Если Статусы.Найти(СтатусПакета) <> Неопределено Тогда
		
		Если СтатусПакета <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "СтатусПакета") Тогда
			// Фиксируем момент времени, для того чтобы в будущем пометить пакет на удаление как обработанный.
			// Срок хранения пакетов в днях определен в константе "СрокХраненияПакетаЭД".
			ДатаОбработки = ТекущаяДатаСеанса();
		КонецЕсли;
		
	КонецЕсли;
	
	ЗаполнитьИсториюОбработки();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПрисоединенныеФайлы.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПакетЭДПрисоединенныеФайлы КАК ПрисоединенныеФайлы
	|ГДЕ
	|	ПрисоединенныеФайлы.ВладелецФайла = &ВладелецФайла";
	Запрос.УстановитьПараметр("ВладелецФайла", Ссылка);
	
	Результат = Запрос.Выполнить().Выбрать();
	Пока результат.Следующий() Цикл
		Объект = ЭлектронноеВзаимодействиеСлужебный.ОбъектПоСсылкеДляИзменения(Результат.Ссылка);
		Если Не Объект.ПометкаУдаления = ПометкаУдаления Тогда 
			Объект.ПометкаУдаления = ПометкаУдаления;
			Объект.Записать();
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьИсториюОбработки() 
	
	СтатусыПолучен = Новый Массив;
	СтатусыРаспакован = Новый Массив;
	СтатусыПодготовлен = Новый Массив;
	СтатусыОтправлен = Новый Массив;
	
	ДатаСеанса = ТекущаяДатаСеанса();
	
	СтатусыРаспакован.Добавить(Перечисления.СтатусыПакетовЭД.Распакован);
	СтатусыРаспакован.Добавить(Перечисления.СтатусыПакетовЭД.РаспакованДокументыНеОбработаны);
	
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(СтатусыПолучен, СтатусыРаспакован);
	СтатусыПолучен.Добавить(Перечисления.СтатусыПакетовЭД.КРаспаковке);

	СтатусыОтправлен.Добавить(Перечисления.СтатусыПакетовЭД.Отправлен);
	СтатусыОтправлен.Добавить(Перечисления.СтатусыПакетовЭД.Доставлен);
	
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(СтатусыПодготовлен, СтатусыОтправлен);
	СтатусыПодготовлен.Добавить(Перечисления.СтатусыПакетовЭД.ПодготовленКОтправке);
	
	Если Не ЗначениеЗаполнено(ДатаПолучения)
		И СтатусыПолучен.Найти(СтатусПакета) <> Неопределено Тогда
		ДатаПолучения = ДатаСеанса;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ДатаРаспаковки)
		И СтатусыРаспакован.Найти(СтатусПакета) <> Неопределено Тогда
		ДатаРаспаковки = ДатаСеанса;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ДатаПодготовки)
		И СтатусыПодготовлен.Найти(СтатусПакета) <> Неопределено Тогда
		ДатаПодготовки = ДатаСеанса;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ДатаОтправки)
		И СтатусыОтправлен.Найти(СтатусПакета) <> Неопределено Тогда
		ДатаОтправки = ДатаСеанса;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
	
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
	
#КонецЕсли
