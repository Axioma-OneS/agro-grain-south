﻿
#Область ПрограммныйИнтерфейс

Процедура ПриПодбореУчетногоДокументаЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ОткрытьФорму("Документ.СчетФактураПолученный.ФормаВыбора", 
			ДополнительныеПараметры.ПараметрыФормы,,,,, ДополнительныеПараметры.ОповещениеОВыборе, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Иначе
		ОткрытьФорму("Документ.СчетФактураПолученныйАванс.ФормаВыбора", 
			ДополнительныеПараметры.ПараметрыФормы,,,,, ДополнительныеПараметры.ОповещениеОВыборе, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриСозданииНоменклатурыПоДаннымКонтрагента(Знач НаборНоменклатурыКонтрагентов, Знач ОповещениеОЗавершении, СтандартнаяОбработка = Истина) Экспорт
	
	Если Не НаборНоменклатурыКонтрагентов.Количество() Тогда
		Возврат
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	НоменклатураКонтрагента = НаборНоменклатурыКонтрагентов[0];
	
	ПараметрыЗавершения = Новый Структура;
	ПараметрыЗавершения.Вставить("ОповещениеОЗавершении", ОповещениеОЗавершении);
	ПараметрыЗавершения.Вставить("НоменклатураКонтрагента", НоменклатураКонтрагента);
	
	ОписаниеОповещенияОЗакрытииФормы = Новый ОписаниеОповещения("ПриСозданииНоменклатурыПоДаннымКонтрагентаЗавершение",
		ЭтотОбъект, ПараметрыЗавершения);
		
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	ФормаНоменклатуры = ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаЭлемента", ПараметрыФормы,,,,, ОписаниеОповещенияОЗакрытииФормы, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
	Если ФормаНоменклатуры <> Неопределено Тогда
		ДанныеЗаполнения = ЭлектронноеВзаимодействиеУТВызовСервера.ДанныеДляЗаполнения(НоменклатураКонтрагента);
		
		ФормаНоменклатуры.Объект.Артикул = ДанныеЗаполнения.Артикул;
		ФормаНоменклатуры.Объект.Наименование = ДанныеЗаполнения.Наименование;
		ФормаНоменклатуры.Объект.НаименованиеПолное = ДанныеЗаполнения.Наименование;
		ФормаНоменклатуры.Объект.ЕдиницаИзмерения = ДанныеЗаполнения.ЕдиницаИзмерения;
		ФормаНоменклатуры.Объект.СтавкаНДС = ДанныеЗаполнения.СтавкаНДС;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриСозданииНоменклатурыПоДаннымКонтрагентаЗавершение(Знач НоменклатураСсылка, ДополнительныеПараметры) Экспорт
	
	Если НЕ ЗначениеЗаполнено(НоменклатураСсылка) Тогда 
		ДополнительныеПараметры.Свойство("НоменклатураСсылка", НоменклатураСсылка);
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(НоменклатураСсылка) Тогда 
		Возврат;
	КонецЕсли;
	
	Результат = Новый Массив;
	
	НоменклатураИБ = ОбменСКонтрагентамиКлиентСервер.НоваяНоменклатураИнформационнойБазы(НоменклатураСсылка);
		
	СозданныйЭлемент = Новый Структура;
	СозданныйЭлемент.Вставить("НоменклатураКонтрагента", ДополнительныеПараметры.НоменклатураКонтрагента);
	СозданныйЭлемент.Вставить("НоменклатураИБ", НоменклатураИБ);
	Результат.Добавить(СозданныйЭлемент);
	
	ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОповещениеОЗавершении, Результат);
	
КонецПроцедуры
	
Процедура ОткрытьФормуВыбораДоговора(Параметры, Владелец, ОповещениеОЗакрытии, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Отбор = Новый Структура;
	Отбор.Вставить("Контрагент"   , Параметры.Контрагент);
	Отбор.Вставить("Организация", Параметры.Организация);
	
	ПараметрыФормы = Новый Структура("Отбор", Отбор);
	ОткрытьФорму("Справочник.ДоговорыКонтрагентов.ФормаВыбора", ПараметрыФормы, Владелец,,,,ОповещениеОЗакрытии);
	
КонецПроцедуры
	
#КонецОбласти
