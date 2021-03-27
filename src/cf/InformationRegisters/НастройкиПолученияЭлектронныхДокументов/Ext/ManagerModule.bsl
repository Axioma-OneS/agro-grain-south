﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Удаляет настройки отправки ЭДО
// 
//  Параметры - СписокЗначений - параметры учетной записи для удаления
//  АдресРезультата - Строка - путь временного хранилища
//
Процедура УдалитьНастройкиОтраженияЭДО(Параметры, АдресРезультата) Экспорт
	
	Организация              = Неопределено;
	Контрагент               = Неопределено;
	ИдентификаторКонтрагента = Неопределено;
	ИдентификаторОрганизации = Неопределено;
	Результат                = Истина;
	
	Параметры.Свойство("Организация"             , Организация);
	Параметры.Свойство("Контрагент"              , Контрагент);
	Параметры.Свойство("ИдентификаторОрганизации", ИдентификаторОрганизации);
	Параметры.Свойство("ИдентификаторКонтрагента", ИдентификаторКонтрагента);
	
	НаборЗаписей = РегистрыСведений.НастройкиПолученияЭлектронныхДокументов.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Отправитель.Установить(Контрагент);
	НаборЗаписей.Отбор.Получатель.Установить(Организация);
	
	Если ЗначениеЗаполнено(ИдентификаторОрганизации) Тогда
		НаборЗаписей.Отбор.ИдентификаторПолучателя.Установить(ИдентификаторОрганизации);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИдентификаторКонтрагента) Тогда
		НаборЗаписей.Отбор.ИдентификаторОтправителя.Установить(ИдентификаторКонтрагента);
	КонецЕсли;
	
	НачатьТранзакцию();
	
	Попытка
		// Попытка удаления. Управляемую блокировку устанавливать нет необходимости.
		НаборЗаписей.Записать();
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		
		Информация = ИнформацияОбОшибке();
		
		ТекстОшибки = СтрШаблон(НСтр("ru = 'Не удалось удалить настройки отправки по:
                                      |Организация: %1,
                                      |Контрагент: %2,
                                      |Идентификатор организации: %3.
                                      |Идентификатор контрагента: %4'"), Организация, Контрагент, ИдентификаторОрганизации, ИдентификаторКонтрагента);
		
		ЭлектронноеВзаимодействие.ОбработатьОшибку(НСтр("ru = 'Удаление настроек отражения в учете ЭДО'"), ПодробноеПредставлениеОшибки(Информация), ТекстОшибки);
		Результат = Ложь;
		
	КонецПопытки;
	
	ПоместитьВоВременноеХранилище(Результат, АдресРезультата);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
