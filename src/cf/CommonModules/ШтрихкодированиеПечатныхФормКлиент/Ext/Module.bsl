﻿
#Область ПрограммныйИнтерфейс

// Процедура - Объект не найден
//
// Параметры:
//  Штрихкод - Строка - Штрихкод
//  ИскатьПоВсемОбъектам - Булево - Искать по всем объектам.
//
Процедура ОбъектНеНайден(Штрихкод, ИскатьПоВсемОбъектам = Истина) Экспорт
	
	ВывестиСообщениеОбъектНеНайден = Истина;
	
	Если ИскатьПоВсемОбъектам Тогда
		Состояние(НСтр("ru = 'Выполняется поиск документа по штрихкоду во всех документах информационной базы..'"));
		МассивСсылок = ШтрихкодированиеПечатныхФормВызовСервера.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод);
		Если МассивСсылок.Количество() > 0 Тогда
			ВывестиСообщениеОбъектНеНайден = Ложь;
			ПоказатьЗначение(,МассивСсылок[0]);
		КонецЕсли;
	КонецЕсли;
	
	Если ВывестиСообщениеОбъектНеНайден Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Объект со штрихкодом %1 не найден'"), Штрихкод));
	КонецЕсли;
	
КонецПроцедуры

// Функция - Получить ссылку по штрихкоду табличного документа
//
// Параметры:
//  Штрихкод - Строка - Штрихкод
//  Менеджеры - Массив - Менеджеры документов.
// 
// Возвращаемое значение:
//  Массив - Массив ссылок на найденные документы.
//
Функция ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод, Менеджеры = Неопределено) Экспорт
	
	Состояние(НСтр("ru = 'Выполняется поиск документа по штрихкоду...'"));
	Возврат ШтрихкодированиеПечатныхФормВызовСервера.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод, Менеджеры);
	
КонецФункции

#КонецОбласти
