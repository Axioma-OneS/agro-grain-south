﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(БанковскийСчет.Владелец)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура создает запись в регистре по переданным данным
//
// Параметры:
//    БанковскийСчет - СправочникСсылка - ссылка на элемент справочника "Банковские счета организаций"
//    ПараметрыЗаписи - Структура - Данные для записи в регистр.
//
Процедура СоздатьЗапись(Период, БанковскийСчет, ПараметрыЗаписи) Экспорт
	
	Если БанковскийСчет = Неопределено Или БанковскийСчет = Справочники.БанковскиеСчетаОрганизаций.ПустаяСсылка()
		Или Не ЗначениеЗаполнено(Период) Тогда
		Возврат;
	КонецЕсли;
	
	НоваяЗапись = СоздатьМенеджерЗаписи();
	НоваяЗапись.Период = Период;
	НоваяЗапись.БанковскийСчет = БанковскийСчет;
	НоваяЗапись.Прочитать();
	ЗаполнитьЗначенияСвойств(НоваяЗапись, ПараметрыЗаписи);
	НоваяЗапись.Период = Период;
	НоваяЗапись.БанковскийСчет = БанковскийСчет;
	
	Попытка
		НоваяЗапись.Записать();
	Исключение
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Запись в регистр сведений ""Остатки на банковских счетах по данным выписок""'",
			ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка,,,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли