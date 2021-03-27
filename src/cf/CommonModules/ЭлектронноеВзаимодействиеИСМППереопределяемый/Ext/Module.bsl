﻿#Область ПрограммныйИнтерфейс

// (См. ЭлектронноеВзаимодействиеИСМП.ЗаполнитьСведенияОМаркировке)
// Переопределяет заполнение сведений о маркировке. Установить СтандартнаяОбработка=Ложь для переопределенных вызовов.
Процедура ЗаполнитьСведенияОМаркировке(Приемник, Источник, ДанныеШтрихкодовУпаковок, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры

// (См. ЭлектронноеВзаимодействиеИСМП.ЗаполнитьСведенияОМаркировке_2019)
// Переопределяет заполнение сведений о маркировке. Установить СтандартнаяОбработка=Ложь для переопределенных вызовов.
Процедура ЗаполнитьСведенияОМаркировке_2019(Приемник, Источник, ДанныеШтрихкодовУпаковок, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры

// При необходимости перед формированием документа ЭДО выполняет проверку соответствия маркируемой продукции и
// товарной части документа.
//
// Параметры:
//  Ссылка - ДокументСсылка - проверяемый документ
//  Отказ  - Булево - флаг отказа от дельнейших действий
Процедура ПроверитьМаркируемуюПродукциюДокумента(Ссылка, Отказ) Экспорт

	//++ НЕ ГОСИС
	ТипДокумента = ТипЗнч(Ссылка);
	Если ТипДокумента = Тип("ДокументСсылка.РеализацияТоваровУслуг")
		ИЛИ ТипДокумента = Тип("ДокументСсылка.ВозвратТоваровПоставщику")
		ИЛИ ТипДокумента = Тип("ДокументСсылка.КорректировкаРеализации") Тогда 
		Отказ = Отказ ИЛИ НЕ ЭлектронноеВзаимодействиеИСМП.ДанныеДокументаСоответствуютДаннымУпаковок(Ссылка);
	КонецЕсли;
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

//При записи документа ЭДО может измениться статус оформления документа, по которому происходит электронный документооборот:
//   * Для прямого обмена с ИС МП (документ "Отгрузка товаров") указание кодов маркировки требуется или в ЭДО, или в отгрузке.
//   * Подразумевается, что документ ЭДО не может изменить свой документ-основание.
//
// Параметры:
//  ЭлектронныйДокументИсходящийОбъект - ДокументОбъект.ЭлектронныйДокументИсходящий - записываемый документ.
//  ДокументыТребующиеПересчета - Массив Из см. РасчетСтатусовОформленияИСМП.РассчитатьСтатусыОформленияДокументов - 
//   документы, связанные с записываемым электронным, для которых требуется пересчитать статус оформления.
//
Процедура ТребуетсяПересчетСтатусовОформления(ЭлектронныйДокументИсходящийОбъект, ДокументыТребующиеПересчета) Экспорт
	
	//++ НЕ ГОСИС
	Основания = ЭлектронныйДокументИсходящийОбъект.ДокументыОснования;
	ДокументыПоТипам = Новый Соответствие;
	Для Каждого Строка Из Основания Цикл
		ТипОснования = ТипЗнч(Строка.ДокументОснование);
		Элемент = ДокументыПоТипам.Получить(ТипОснования);
		Если Элемент = Неопределено Тогда
			Элемент = Новый Массив;
		КонецЕсли;
		Элемент.Добавить(Строка.ДокументОснование);
		ДокументыПоТипам.Вставить(ТипОснования, Элемент);
	КонецЦикла;
	
	СчетаФактуры = ДокументыПоТипам.Получить(Тип("ДокументСсылка.СчетФактураВыданный"));
	Если СчетаФактуры<>Неопределено Тогда
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("Ссылка", СчетаФактуры);
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	СчетФактураВыданныйДокументыОснования.ДокументОснование КАК ДокументОснование
		|ИЗ
		|	Документ.СчетФактураВыданный.ДокументыОснования КАК СчетФактураВыданныйДокументыОснования
		|ГДЕ
		|	СчетФактураВыданныйДокументыОснования.Ссылка В(&Ссылка)";
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			ТипОснования = ТипЗнч(Выборка.ДокументОснование);
			Элемент = ДокументыПоТипам.Получить(ТипОснования);
			Если Элемент = Неопределено Тогда
				Элемент = Новый Массив;
			КонецЕсли;
			Элемент.Добавить(Выборка.ДокументОснование);
			ДокументыПоТипам.Вставить(ТипОснования, Элемент);
		КонецЦикла;
	КонецЕсли;
	
	Для Каждого Тип Из Метаданные.ОпределяемыеТипы.ОснованиеОтгрузкаТоваровИСМП.Тип.Типы() Цикл
		ДокументыТипа = ДокументыПоТипам.Получить(Тип);
		Если ДокументыТипа<>Неопределено Тогда
			ДокументыТребующиеПересчета.Добавить(ДокументыТипа);
		КонецЕсли;
	КонецЦикла;
	
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

#КонецОбласти

// Процедуры и функции для работы с другими версиями БЭД
//
#Область СлужебныйПрограммныйИнтерфейс

// Предназначена для получения значения из дерева значений по полному пути.
// (См. ЭлектронноеВзаимодействие.ЗначениеРеквизитаВДереве)
//
// Параметры:
//  ЗначениеРеквизита    - Произвольный   - найденное значения.
//  ДеревоДанных         - ДеревоЗначений - объект поиска.
//  ПолныйПуть           - Строка         - значение поиска.
//  СтандартнаяОбработка - Булево         - признак стандартной обработки (установить Ложь для переопределенных)
// 
Процедура ПриОпределенииЗначенияРеквизитаВДереве(ЗначениеРеквизита, ДеревоДанных, ПолныйПуть, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры

//Предназначена для вывода ошибки заполнения ЭД пользователю
//   (См. ЭлектронноеВзаимодействие.ДобавитьВТаблицуОбработкуОшибкиЧерезСообщениеПользователю)
//
//Параметры:
//   СтрокиТаблицы - Массив,ТаблицаЗначений - см. ЭлектронноеВзаимодействие.ДобавитьВТаблицуОбработкуОшибкиЧерезСообщениеПользователю.СтрокиТаблицы.
//   ПолеТаблицы   - Строка                 - см. ЭлектронноеВзаимодействие.ДобавитьВТаблицуОбработкуОшибкиЧерезСообщениеПользователю.ПолеТаблицы.
//   КлючДанных    - Строка, ЛюбаяСсылка    - см. ЭлектронноеВзаимодействие.ДобавитьВТаблицуОбработкуОшибкиЧерезСообщениеПользователю.КлючДанных.
//   ПутьКДанным   - Строка                 - см. ЭлектронноеВзаимодействие.ДобавитьВТаблицуОбработкуОшибкиЧерезСообщениеПользователю.ПутьКДанным.
//   СтандартнаяОбработка - Булево - признак стандартной обработки (установить Ложь для переопределенных)
//
Процедура ПриВыводеОшибкиЗаполненияПользователю(СтрокиТаблицы, ПолеТаблицы, КлючДанных, ПутьКДанным, СтандартнаяОбработка) Экспорт

	Возврат;

КонецПроцедуры

//Предназначена переопределения имени обработки обмена с контрагентами.
//
//Параметры:
//   Имя - Строка - имя обработки в метаданных.
//
Процедура ПриОпределенииИмениОбработкиОбменаПоЭДО(Имя) Экспорт

	Возврат;

КонецПроцедуры

#КонецОбласти