﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Процедура ПриЗаписи(Отказ, Замещение)
	
	// ОбменДанными.Загрузка не требуется.
	// Запись служебных данных в безопасном режиме запрещена.
	Если РаботаВБезопасномРежиме.УстановленБезопасныйРежим() Тогда
		
		ТекущийБезопасныйРежим = БезопасныйРежим();
		
		Для Каждого Запись Из ЭтотОбъект Цикл
			
			Если Запись.БезопасныйРежим <> ТекущийБезопасныйРежим Тогда
				
				ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Безопасный режим %1 отличается от текущего %2'"),
					Запись.БезопасныйРежим, ТекущийБезопасныйРежим);
				
			КонецЕсли;
			
			ПрограммныйМодуль = РаботаВБезопасномРежимеСлужебный.СсылкаИзРегистраРазрешений(
				Запись.ТипВладельца, Запись.ИдентификаторПрограммногоМодуля);
			
			Если ПрограммныйМодуль <> Справочники.ИдентификаторыОбъектовМетаданных.ПустаяСсылка() Тогда
				
				БезопасныйРежимПрограммногоМодуля = РегистрыСведений.РежимыПодключенияВнешнихМодулей.РежимПодключенияВнешнегоМодуля(
					ПрограммныйМодуль);
				
				Если Запись.БезопасныйРежим <> БезопасныйРежимПрограммногоМодуля Тогда
					
					ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Для программного модуля %1 не может быть выполнен запрос разрешений из безопасного режима %2'"),
						Строка(ПрограммныйМодуль), Запись.БезопасныйРежим);
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли