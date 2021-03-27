﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Позволяет получить данные, для сторнирования движений документа, указанного в параметре "Ссылка".
//
// Возращаемое значение:
//  Строка - Текст запроса получения данных для сторнирования движений документа.
//
Функция ТекстЗапросаСторноЗаписейЗаказа() Экспорт

	Текст =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура     КАК Номенклатура,
		|	Таблица.Характеристика   КАК Характеристика,
		|	Таблица.Склад            КАК Склад,
		|	Таблица.Назначение       КАК Назначение,
		|
		|	- Таблица.Потребность    КАК Потребность,
		|	- Таблица.КЗаказу        КАК КЗаказу
		|
		|ИЗ
		|	РегистрНакопления.ОбеспечениеЗаказов КАК Таблица
		|
		|ГДЕ
		|	Таблица.Активность
		|	И Таблица.Регистратор В(&Ссылка)
		|	И (Таблица.Потребность <> 0 ИЛИ Таблица.КЗаказу <> 0)
		|	И &Отбор
		|;
		|
		|//////////////////////////////////////////////////
		|";

	Возврат Текст;

КонецФункции

// Получает текст запроса для сторнирования движений документа.
//
// Возвращаемое значение:
//  Строка - Текст запроса.
//
Функция ТекстЗапросаСторноЗаписейЗаказаКОтгрузке() Экспорт

	Текст =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура      КАК Номенклатура,
		|	Таблица.Характеристика    КАК Характеристика,
		|	Таблица.Склад             КАК Склад,
		|	Таблица.Назначение        КАК Назначение,
		|
		|	- Таблица.НаличиеПодЗаказ КАК КОтгрузке
		|
		|ИЗ
		|	РегистрНакопления.ОбеспечениеЗаказов КАК Таблица
		|
		|ГДЕ
		|	Таблица.Активность
		|	И Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
		|	И Таблица.Регистратор В(&Ссылка)
		|	И Таблица.НаличиеПодЗаказ <> 0
		|	И &Отбор
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Таблица.Номенклатура      КАК Номенклатура,
		|	Таблица.Характеристика    КАК Характеристика,
		|	Таблица.Склад             КАК Склад,
		|	ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка) КАК Назначение,
		|
		|	Таблица.НаличиеПодЗаказ КАК КОтгрузке
		|
		|ИЗ
		|	РегистрНакопления.ОбеспечениеЗаказов КАК Таблица
		|
		|ГДЕ
		|	Таблица.Активность
		|	И Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
		|	И Таблица.Регистратор В(&Ссылка)
		|	И Таблица.НаличиеПодЗаказ <> 0
		|	И &Отбор
		|;
		|
		|//////////////////////////////////////////////////
		|";

	Возврат Текст;

КонецФункции

// Предназначена для получения текста запроса остатков регистра в разрезе его измерений.
// с предустановленным фильтром по товаром временной таблицы "ВтТоварыОбособленные".
//
// Параметры:
//  ИспользоватьКорректировку - Булево - признак необходимости скорректировать движения регистра перед получением остатков
//  Разделы - Массив - массив в который будет добавлена информация о временных таблицах, создаваемых при выполнении запроса.
//
// Возвращаемое значение:
//   Строка - текст запроса формирования временной таблицы остатков "ВтОбеспечениеЗаказов".
//
Функция ТекстЗапросаОстатков(ИспользоватьКорректировку, Разделы = Неопределено) Экспорт

	Если Не ИспользоватьКорректировку Тогда
		ТекстЗапроса =
			"ВЫБРАТЬ
			|	Т.Номенклатура           КАК Номенклатура,
			|	Т.Характеристика         КАК Характеристика,
			|	Т.Склад                  КАК Склад,
			|	Т.Назначение             КАК Назначение,
			|
			|	Т.НаличиеПодЗаказОстаток КАК Количество,
			|	Т.КЗаказуОстаток         КАК КоличествоКЗаказу
			|
			|ПОМЕСТИТЬ ВтОбеспечениеЗаказов
			|ИЗ
			|	РегистрНакопления.ОбеспечениеЗаказов.Остатки(,
			|		(Номенклатура, Характеристика, Склад, Назначение) В(
			|			ВЫБРАТЬ
			|				Ключи.Номенклатура   КАК Номенклатура,
			|				Ключи.Характеристика КАК Характеристика,
			|				Ключи.Склад          КАК Склад,
			|				Ключи.Назначение     КАК Назначение
			|			ИЗ
			|				ВтТоварыОбособленные КАК Ключи
			|		)) КАК Т
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	Номенклатура, Характеристика, Склад, Назначение
			|;
			|
			|/////////////////////////////////////////////////////////////
			|";
	Иначе
		ТекстЗапроса =
			"ВЫБРАТЬ
			|	НаборДанных.Номенклатура           КАК Номенклатура,
			|	НаборДанных.Характеристика         КАК Характеристика,
			|	НаборДанных.Склад                  КАК Склад,
			|	НаборДанных.Назначение             КАК Назначение,
			|
			|	СУММА(НаборДанных.Количество)         КАК Количество,
			|	СУММА(НаборДанных.КоличествоКЗаказу)  КАК КоличествоКЗаказу
			|
			|ПОМЕСТИТЬ ВтОбеспечениеЗаказов
			|ИЗ (
			|	ВЫБРАТЬ
			|		Т.Номенклатура           КАК Номенклатура,
			|		Т.Характеристика         КАК Характеристика,
			|		Т.Склад                  КАК Склад,
			|		Т.Назначение             КАК Назначение,
			|
			|		Т.НаличиеПодЗаказОстаток КАК Количество,
			|		Т.КЗаказуОстаток         КАК КоличествоКЗаказу
			|
			|	ИЗ
			|	РегистрНакопления.ОбеспечениеЗаказов.Остатки(,
			|		(Номенклатура, Характеристика, Склад, Назначение) В(
			|			ВЫБРАТЬ
			|				Ключи.Номенклатура   КАК Номенклатура,
			|				Ключи.Характеристика КАК Характеристика,
			|				Ключи.Склад          КАК Склад,
			|				Ключи.Назначение     КАК Назначение
			|			ИЗ
			|				ВтТоварыОбособленные КАК Ключи
			|		)) КАК Т
			|
			|	ОБЪЕДИНИТЬ ВСЕ
			|
			|	ВЫБРАТЬ
			|		Т.Номенклатура            КАК Номенклатура,
			|		Т.Характеристика          КАК Характеристика,
			|		Т.Склад                   КАК Склад,
			|		Т.Назначение              КАК Назначение,
			|
			|		- Т.КОтгрузке             КАК Количество,
			|		- Т.КОтгрузке             КАК КоличествоКЗаказу
			|
			|	ИЗ
			|		ВтТоварыКОтгрузкеКорректировка КАК Т
			|	ГДЕ
			|		Т.Назначение <> ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
			|	) КАК НаборДанных
			|
			|СГРУППИРОВАТЬ ПО
			|	НаборДанных.Номенклатура, НаборДанных.Характеристика, НаборДанных.Склад, НаборДанных.Назначение
			|ИМЕЮЩИЕ
			|	СУММА(НаборДанных.Количество) <> 0
			|		ИЛИ СУММА(НаборДанных.КоличествоКЗаказу) <> 0
			|ИНДЕКСИРОВАТЬ ПО
			|	Номенклатура, Характеристика, Склад, Назначение
			|;
			|
			|/////////////////////////////////////////////////////////////
			|";
	КонецЕсли;

	Если Разделы <> Неопределено Тогда
		Разделы.Добавить("ТаблицаОстаткиСкладаОбособленные");
	КонецЕсли;

	Возврат ТекстЗапроса;

КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Склад)";
	
	Ограничение.ТекстДляВнешнихПользователей = Ограничение.Текст;

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьЗаказыИзНазначений(МассивЗаказов, Объект) Экспорт
	
	Для Каждого Набор Из Объект.Движения Цикл
		
		Если Не Набор.ДополнительныеСвойства.Свойство("ДляЗаписиПодчиненныхДанных") Тогда
			Продолжить;
		КонецЕсли;
		
		СтруктураСвойств = Набор.ДополнительныеСвойства.ДляЗаписиПодчиненныхДанных;
		
		Если СтруктураСвойств.Свойство("СтруктураДляРасчетаСостояний") Тогда
			
			Для Каждого Элемент Из СтруктураСвойств.СтруктураДляРасчетаСостояний.МассивЗаказов Цикл
				
				Если (ТипЗнч(Элемент) = Тип("ДокументСсылка.ЗаказКлиента")
					
					Или ТипЗнч(Элемент) = Тип("ДокументСсылка.ЗаявкаНаВозвратТоваровОтКлиента"))
					И МассивЗаказов.Найти(Элемент) = Неопределено Тогда
						
						МассивЗаказов.Добавить(Элемент);
						
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#Область ОбновлениеИнформационнойБазы

#КонецОбласти

#КонецОбласти

#КонецЕсли
