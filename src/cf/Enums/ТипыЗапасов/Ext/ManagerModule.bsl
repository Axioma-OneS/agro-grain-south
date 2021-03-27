﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

// Возвращает типы запасов, по которым не требуется контролировать остатки товаров организаций
// 
// Возвращаемое значение:
//  Массив - массив элементов типа ПеречислениеСсылка.ТипыЗапасов
//
Функция НеконтролируемыеПоТоварамОрганизацииТипыЗапасов() Экспорт
	
	ТипыЗапасов = Новый Массив;
	ТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.ТоварТребующийПодтвержденияВыпуска);
	ТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.СобственныйТоварВПути);
	ТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.СобственныйТоварПоНеотфактурованнойПоставке);
	
	Возврат ТипыЗапасов;
	
КонецФункции

// Возвращает типы запасов, которые нужно контролировать на остатках организаций.
// 
// Возвращаемое значение:
//  Массив - массив элементов типа ПеречислениеСсылка.ТипыЗапасов
//
Функция КонтролируемыеТипыЗапасов() Экспорт
	
	КонтролируемыеТипыЗапасов = Новый Массив;
	КонтролируемыеТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.Товар);
	КонтролируемыеТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.КомиссионныйТовар);
	КонтролируемыеТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.МатериалДавальца);
	КонтролируемыеТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.ПродукцияДавальца);
	КонтролируемыеТипыЗапасов.Добавить(Перечисления.ТипыЗапасов.ТоварНаХраненииСПравомПродажи);
	Возврат КонтролируемыеТипыЗапасов;
	
КонецФункции

// Возвращает типы запасов, владельцы которых не содержатся в справочнике Организации.
// 
// Возвращаемое значение:
//  Массив - массив элементов типа ПеречислениеСсылка.ТипыЗапасов
//
Функция ТипыЗапасовВнешнийВладелец() Экспорт
	
	ТипыЗапасовВнешнийВладелец = Новый Массив;
	ТипыЗапасовВнешнийВладелец.Добавить(Перечисления.ТипыЗапасов.КомиссионныйТовар);
	ТипыЗапасовВнешнийВладелец.Добавить(Перечисления.ТипыЗапасов.МатериалДавальца);
	ТипыЗапасовВнешнийВладелец.Добавить(Перечисления.ТипыЗапасов.ПродукцияДавальца);
	ТипыЗапасовВнешнийВладелец.Добавить(Перечисления.ТипыЗапасов.ТоварНаХраненииСПравомПродажи);
	Возврат ТипыЗапасовВнешнийВладелец;
	
КонецФункции

// Возвращает типы запасов, владельцем которых является наша организация.
// 
// Возвращаемое значение:
//  Массив - массив элементов типа ПеречислениеСсылка.ТипыЗапасов
//
Функция ТипыЗапасовСобственные() Экспорт
	
	ТипыЗапасовСобственные = Новый Массив();
	ТипыЗапасовСобственные.Добавить(Перечисления.ТипыЗапасов.Товар);
	ТипыЗапасовСобственные.Добавить(Перечисления.ТипыЗапасов.СобственныйТоварВПути);
	ТипыЗапасовСобственные.Добавить(Перечисления.ТипыЗапасов.СобственныйТоварПоНеотфактурованнойПоставке);
	ТипыЗапасовСобственные.Добавить(Перечисления.ТипыЗапасов.Услуга);
	
	Возврат ТипыЗапасовСобственные;
	
КонецФункции

#КонецОбласти

#КонецЕсли