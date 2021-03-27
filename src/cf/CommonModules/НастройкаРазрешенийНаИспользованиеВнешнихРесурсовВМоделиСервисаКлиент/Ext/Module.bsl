﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Базовая функциональность в модели сервиса".
// Серверные процедуры и функции общего назначения:
// - Поддержка профилей безопасности.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Вызывается при подтверждении запросов на использование внешних ресурсов.
//
// Параметры:
//  Идентификаторы - Массив Из УникальныйИдентификатор - идентификаторы запросов, которые требуется применить,
//  ФормаВладелец - ФормаКлиентскогоПриложения - форма, которая должна блокироваться до окончания применения разрешений,
//  ОповещениеОЗакрытии - ОписаниеОповещения - которое будет вызвано при успешном предоставлении разрешений.
//  СтандартнаяОбработка - Булево - флаг выполнения стандартной обработки применения разрешений на использование
//    внешних ресурсов (подключение к агенту сервера через COM-соединение или сервер администрирования с
//    запросом параметров подключения к кластеру у текущего пользователя). Может быть установлен в значение Ложь
//    внутри обработчика события, в этом случае стандартная обработка завершения сеанса выполняться не будет.
//
Процедура ПриПодтвержденииЗапросовНаИспользованиеВнешнихРесурсов(Знач ИдентификаторыЗапросов, ФормаВладелец, ОповещениеОЗакрытии, СтандартнаяОбработка) Экспорт
	
	Если СтандартныеПодсистемыКлиентПовтИсп.ПараметрыРаботыКлиента().РазделениеВключено Тогда
		
		НачатьИнициализациюЗапросаРазрешенийНаИспользованиеВнешнихРесурсов(ИдентификаторыЗапросов, ФормаВладелец, ОповещениеОЗакрытии, Ложь);
		СтандартнаяОбработка = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура НачатьИнициализациюЗапросаРазрешенийНаИспользованиеВнешнихРесурсов(Знач Идентификаторы, ФормаВладелец, ОповещениеОЗакрытии, РежимПроверки = Ложь) Экспорт
	
	Если СтандартныеПодсистемыКлиентПовтИсп.ПараметрыРаботыКлиентаПриЗапуске().ОтображатьПомощникНастройкиРазрешений Тогда
		
		РезультатОбработки = НастройкаРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервисаВызовСервера.ОбработатьЗапросыНаИспользованиеВнешнихРесурсов(
			Идентификаторы);
		
		Если РезультатОбработки.ТребуетсяПрименениеРазрешений Тогда
			
			Если СтандартныеПодсистемыКлиентПовтИсп.ПараметрыРаботыКлиента().ДоступноИспользованиеРазделенныхДанных Тогда
				
				ИмяФормы = "Обработка.НастройкаРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервиса.Форма.ЗапросРазрешенийУАдминистратораАбонента";
				
			Иначе
				
				ИмяФормы = "Обработка.НастройкаРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервиса.Форма.ЗапросРазрешенийУАдминистратораСервиса";
				
			КонецЕсли;
			
			ПараметрыФормы = Новый Структура();
			ПараметрыФормы.Вставить("ИдентификаторПакета", Идентификаторы);
			
			ОписаниеОповещения = Новый ОписаниеОповещения(
				"ПослеНастройкиРазрешенийНаИспользованиеВнешнихРесурсов",
				НастройкаРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервисаКлиент,
				ПараметрыФормы);
			
			ОткрытьФорму(
				ИмяФормы,
				ПараметрыФормы,
				ФормаВладелец,
				,
				,
				,
				ОписаниеОповещения,
				РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
			
		Иначе
			
			ЗавершитьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовАсинхронно(ОповещениеОЗакрытии);
			
		КонецЕсли;
		
	Иначе
		
		ЗавершитьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовАсинхронно(ОповещениеОЗакрытии);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеНастройкиРазрешенийНаИспользованиеВнешнихРесурсов(Результат, Состояние) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		
		ЗавершитьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовАсинхронно(Состояние.ОписаниеОповещения);
		
	Иначе
		
		ПрерватьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовАсинхронно(Состояние.ОписаниеОповещения);
		
	КонецЕсли;
	
КонецПроцедуры

// Синхронно (по отношению к коду, из которого вызывался мастер) выполняет обработку описания оповещения,
// которое изначально было передано из формы, для которой мастер открывался в псевдо-модальном режиме.
//
// Параметры:
//  КодВозврата - КодВозвратаДиалога 
//
Процедура ЗавершитьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовСинхронно(Знач КодВозврата) Экспорт
	
	ОповещениеОЗакрытии = ПараметрыПриложения["ТехнологияСервиса.ОповещениеПриПримененииЗапросовНаИспользованиеВнешнихРесурсов"];
	ПараметрыПриложения["ТехнологияСервиса.ОповещениеПриПримененииЗапросовНаИспользованиеВнешнихРесурсов"] = Неопределено;
	Если ОповещениеОЗакрытии <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозврата);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Асинхронно (по отношению к коду, из которого вызывался мастер) выполняет обработку описания оповещения,
// которое изначально было передано из формы, для которой мастер открывался в псевдо-модальном режиме, возвращая
// код возврата ОК.
//
// Параметры:
//  ОписаниеОповещения - ОписаниеОповещения - которое было передано из вызывающего кода.
//
Процедура ЗавершитьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовАсинхронно(Знач ОписаниеОповещения)
	
	ИмяПараметра = "ТехнологияСервиса.ОповещениеПриПримененииЗапросовНаИспользованиеВнешнихРесурсов";
	Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
		ПараметрыПриложения.Вставить(ИмяПараметра, Неопределено);
	КонецЕсли;
	ПараметрыПриложения[ИмяПараметра] = ОписаниеОповещения;
	ПодключитьОбработчикОжидания("ЗавершитьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервиса", 0.1, Истина);
	
КонецПроцедуры

// Асинхронно (по отношению к коду, из которого вызывался мастер) выполняет обработку описания оповещения,
// которое изначально было передано из формы, для которой мастер открывался в псевдо-модальном режиме, возвращая
// код возврата Отмена.
//
// Параметры:
//  ОписаниеОповещения - ОписаниеОповещения - которое было передано из вызывающего кода.
//
Процедура ПрерватьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовАсинхронно(Знач ОписаниеОповещения)
	
	ИмяПараметра = "ТехнологияСервиса.ОповещениеПриПримененииЗапросовНаИспользованиеВнешнихРесурсов";
	Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
		ПараметрыПриложения.Вставить(ИмяПараметра, Неопределено);
	КонецЕсли;
	ПараметрыПриложения[ИмяПараметра] = ОписаниеОповещения;
	ПодключитьОбработчикОжидания("ПрерватьНастройкуРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервиса", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти