﻿#Область СлужебныйПрограммныйИнтерфейс

// Возвращает через третий параметр признак наличия маркируемой продукции.
//
// Параметры:
//  Коллекция                - ДанныеФормыКоллекция - ТЧ с товарами.
//  ВидМаркируемойПродукции  - ПеречислениеСсылка.ВидыПродукцииИС - вид продукции, наличие которой необходимо определить.
//  ЕстьМаркируемаяПродукция - Булево - Исходящий, признак наличия маркируемой продукции.
Процедура ЕстьМаркируемаяПродукцияВКоллекции(Коллекция, ВидМаркируемойПродукции, ЕстьМаркируемаяПродукция) Экспорт
	
	//++ НЕ ГОСИС
	ПроверкаИПодборПродукцииИСМПУТ.ЕстьМаркируемаяПродукцияВКоллекции(Коллекция, ВидМаркируемойПродукции, ЕстьМаркируемаяПродукция);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Возвращает через третий параметр таблицу товаров документа, являющихся маркируемой продукцией требуемого вида.
//
// Параметры:
//  * Контекст                 - ФормаКлиентскогоПриложения, ДокументСсылка - документ, маркируемую продукцию которого необходимо получить.
//  * ВидМаркируемойПродукции  - ПеречислениеСсылка.ВидыПродукцииИС - вид маркируемой продукции, которую необходимо получить.
//  * ТаблицаМаркируемойПродукции - ТаблицаЗначений - Исходящий, таблица с маркируемой продукцией документа. Должна содержать колонки:
//  ** GTIN           - Строка - GTIN продукции
//  ** Номенклатура   - ОпределяемыйТип.Номенклатура - номенклатура маркируемой продукции
//  ** Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры - характеристика номенклатура маркируемой продукции
//  ** Серия          - ОпределяемыйТип.СерияНоменклатуры - серия номенклатура маркируемой продукции
//  ** Количество     - Число - количество маркируемой продукции
Процедура ПриОпределенииМаркируемойПродукцииДокумента(Контекст, ВидМаркируемойПродукции, ТаблицаМаркируемойПродукции) Экспорт
	
	//++ НЕ ГОСИС
	ПроверкаИПодборПродукцииИСМПУТ.ЗаполнитьМаркируемуюПродукциюДокумента(Контекст, ВидМаркируемойПродукции, ТаблицаМаркируемойПродукции);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Возвращает через второй параметр признак что переданный контрагент является нерезидентом.
//
// Параметры:
//  Контрагент - СправочникСсылка.Контрагенты - Проверяемы контрагент
//  НеРезидент - Булево - Признак что контрагент не резидент (Истина) или резидент (Ложь).
//
Процедура ПриОпределенииКонтрагентНеРезидент(Контрагент, НеРезидент) Экспорт
	
	//++ НЕ ГОСИС
	НеРезидент = ПроверкаИПодборПродукцииИСМПУТ.КонтрагентНеРезидент(Контрагент);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Предназначена для реализации функциональности по отражению результатов проверки и подбора в документе, из которого была вызвана соответствующая форма.
// 
// Параметры:
//  ПараметрыОкончанияПроверки - (См. ПроверкаИПодборИСМП.ЗафиксироватьРезультатПроверкиИПодбора).
Процедура ОтразитьРезультатыСканированияВДокументе(ПараметрыОкончанияПроверки) Экспорт
	
	//++ НЕ ГОСИС
	ИнтеграцияИСМПУТ.ОтразитьРезультатыСканированияВДокументе(ПараметрыОкончанияПроверки);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Получает сформированный ранее Акт о расхождениях для переданного документа.
// 
// Параметры:
//  Документ         - ДокументСсылка - ссылка на документ, для которого необходимо получить Акт о расхождениях:
//  АктОРасхождениях - ДокументСсылка - ссылка на Акт о расхождениях:
Процедура ПолучитьСформированныйАктОРасхождениях(Документ, АктОРасхождениях) Экспорт
	
	//++ НЕ ГОСИС
	АктОРасхождениях = ИнтеграцияИСМПУТ.СформированныйАктОРасхождениях(Документ);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Заполняет в табличной части служебные реквизиты, например: признак использования характеристик номенклатуры.
//
// Параметры:
//  Форма          - ФормаКлиентскогоПриложения - Форма.
//  ТабличнаяЧасть - ДанныеФормыКоллекция, ТаблицаЗначений - таблица для заполнения.
Процедура ЗаполнитьСлужебныеРеквизитыВКоллекции(Форма, ТабличнаяЧасть) Экспорт
	
	//++ НЕ ГОСИС
	ПроверкаИПодборПродукцииИСМПУТ.ЗаполнитьСлужебныеРеквизитыВКоллекции(Форма, ТабличнаяЧасть);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Устанавливает режим просмотра (доступности, для команд) элементам формы.
//   Переопределение необходимо использовать для совместной работы с аналогичными механизмами.
//   Обработанные здесь реквизиты мледует удалить из массива "Блокируемые элементы".
// 
// Параметры:
//  Форма               - ФормаКлиентскогоПриложения - форма в которой производится изменение доступности
//  БлокируемыеЭлементы - Массив - наименования реквизитов
//  Заблокировать       - Булево - заблокировать или разблокировать реквизиты
Процедура УстановитьТолькоПросмотрЭлементов(
		Форма,
		БлокируемыеЭлементы,
		Заблокировать) Экспорт
	
	//++ НЕ ГОСИС
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Форма.Элементы, БлокируемыеЭлементы, "Доступность", НЕ Заблокировать);
	БлокируемыеЭлементы = Новый Массив;
	//-- НЕ ГОСИС
	
КонецПроцедуры

#Область СерииНоменклатуры

// Предназначена для расчета статусов указания серий во всех строках таблицы товаров
//
// Параметры:
//  Форма        - ФормаКлиентскогоПриложения - форма с таблицей товаров
//  ПараметрыУказанияСерий - Структура - параметры указания серий
Процедура ЗаполнитьСтатусыУказанияСерий(Форма, ПараметрыУказанияСерий) Экспорт
	
	//++ НЕ ГОСИС
	ПроверкаИПодборПродукцииИСМПУТ.ЗаполнитьСтатусыУказанияСерий(Форма, ПараметрыУказанияСерий);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Возвращает через параметр наличие права на добавление элементов справочника СерииНоменклатуры
//
// Параметры:
//  ПравоДобавлениеСерий - Булево - исходящий, наличие права на добавление.
Процедура ОпределитьПравоДобавлениеСерий(ПравоДобавлениеСерий) Экспорт
	
	//++ НЕ ГОСИС
	ПроверкаИПодборПродукцииИСМПУТ.ОпределитьПравоДобавлениеСерий(ПравоДобавлениеСерий);
	//-- НЕ ГОСИС
	
КонецПроцедуры

#КонецОбласти

#Область ПараметрыИнтеграцииФормыПроверкиИПодбора

// Заполняет специфику интеграции формы проверки и подбора в конкретную форму.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма для которой настраиваются параметры интеграции.
//  ПараметрыИнтеграции - (См.ПроверкаИПодборПродукцииИС.ПараметрыИнтеграцииФормПроверкиИПодбора).
//  ВидПродукции - Перечислениессылка.ВидыПродукцииИС - вид продукции для которого проводится встраивание
//
Процедура ПриОпределенииПараметровИнтеграцииФормыПроверкиИПодбора(Форма, ПараметрыИнтеграции, ВидПродукции = Неопределено) Экспорт
	
	//++ НЕ ГОСИС
	Если ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "РеализацияТоваровУслуг")
		ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ВозвратТоваровПоставщику") Тогда
	
		ПараметрыИнтеграции.ИмяРодительскойГруппыФормы                 = "ГруппаТовары";
		ПараметрыИнтеграции.РазмещатьЭлементыИнтерфейса                = Истина;
		ПараметрыИнтеграции.ИспользоватьКолонкуСтатусаПроверкиПодбора  = Истина;
		ПараметрыИнтеграции.ИспользоватьБезМаркируемойПродукции        = Истина;
		ПараметрыИнтеграции.БлокироватьТабличнуюЧастьТоварыПриПроверке = Ложь;
		ПараметрыИнтеграции.ИспользоватьСтатусПроверкаЗавершена        = Ложь;
		ПараметрыИнтеграции.ЕстьПравоИзменение                         = ПравоДоступа("Изменение", Форма.Объект.Ссылка.Метаданные());
		
	ИначеЕсли ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "КорректировкаРеализации") Тогда
		
		ПараметрыИнтеграции.ИмяРодительскойГруппыФормы                 = "ГруппаТовары";
		ПараметрыИнтеграции.РазмещатьЭлементыИнтерфейса                = Истина;
		ПараметрыИнтеграции.ИспользоватьКолонкуСтатусаПроверкиПодбора  = Истина;
		ПараметрыИнтеграции.ИспользоватьБезМаркируемойПродукции        = ЗначениеЗаполнено(Форма.Объект.Склад);
		ПараметрыИнтеграции.БлокироватьТабличнуюЧастьТоварыПриПроверке = Ложь;
		ПараметрыИнтеграции.ИспользоватьСтатусПроверкаЗавершена        = Ложь;
		ПараметрыИнтеграции.ИмяТабличнойЧастиСерии                     = "";
		ПараметрыИнтеграции.ЕстьПравоИзменение                         = ПравоДоступа("Изменение", Метаданные.Документы.КорректировкаРеализации);
		
	ИначеЕсли ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ВозвратТоваровОтКлиента") Тогда
		
		ПараметрыИнтеграции.ИмяРодительскойГруппыФормы                 = "ГруппаТовары";
		ПараметрыИнтеграции.РазмещатьЭлементыИнтерфейса                = Истина;
		ПараметрыИнтеграции.БлокироватьТабличнуюЧастьТоварыПриПроверке = Ложь;
		ПараметрыИнтеграции.ЕстьПравоИзменение                         = ПравоДоступа("Изменение", Метаданные.Документы.ВозвратТоваровОтКлиента);
		ПараметрыИнтеграции.ЭтоДокументПриобретения                    = Истина;
		ПараметрыИнтеграции.ЕстьЭлектронныйДокумент                    = ЭлектронноеВзаимодействиеИСМП.ДокументСвязанСЭлектронным(Форма.Объект.Ссылка);
		ПараметрыИнтеграции.ИспользоватьКолонкуСтатусаПроверкиПодбора  = Не ПараметрыИнтеграции.ЕстьЭлектронныйДокумент;
		ПараметрыИнтеграции.ИмяСледующейКолонки                        = "ТоварыНомерСтроки";
		ПараметрыИнтеграции.ИспользоватьСтатусПроверкаЗавершена        = ПараметрыИнтеграции.ЕстьЭлектронныйДокумент;
		ПараметрыИнтеграции.ИспользоватьБезМаркируемойПродукции        = Не ПараметрыИнтеграции.ЕстьЭлектронныйДокумент;
		
	ИначеЕсли ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ПриобретениеТоваровУслуг") Тогда
		
		ПараметрыИнтеграции.ИмяРодительскойГруппыФормы                 = "ГруппаТовары";
		ПараметрыИнтеграции.РазмещатьЭлементыИнтерфейса                = Истина;
		ПараметрыИнтеграции.ЕстьПравоИзменение                         = ПравоДоступа("Изменение", Метаданные.Документы.ПриобретениеТоваровУслуг);
		ПараметрыИнтеграции.ЭтоДокументПриобретения                    = Истина;
		ПараметрыИнтеграции.ЕстьЭлектронныйДокумент                    = ЭлектронноеВзаимодействиеИСМП.ДокументСвязанСЭлектронным(Форма.Объект.Ссылка);
		ПараметрыИнтеграции.ИспользоватьКолонкуСтатусаПроверкиПодбора  = Не ПараметрыИнтеграции.ЕстьЭлектронныйДокумент;
		ПараметрыИнтеграции.БлокироватьТабличнуюЧастьТоварыПриПроверке = ПараметрыИнтеграции.ЕстьЭлектронныйДокумент;
		ПараметрыИнтеграции.ИспользоватьСтатусПроверкаЗавершена        = ПараметрыИнтеграции.ЕстьЭлектронныйДокумент;
		
	ИначеЕсли СтрНачинаетсяС(Форма.ИмяФормы,"Документ.ЧекККМ.Форма.ФормаДокументаРМК")
		Или СтрНачинаетсяС(Форма.ИмяФормы,"Документ.ЧекККМВозврат.Форма.ФормаДокументаРМК") Тогда
		
		ПараметрыИнтеграции.ИспользоватьКолонкуСтатусаПроверкиПодбора  = Истина;
		ПараметрыИнтеграции.ИспользоватьСтатусПроверкиПодбораДокумента = Ложь;
		ПараметрыИнтеграции.ИмяТабличнойЧастиШтрихкодыУпаковок         = "АкцизныеМарки";
		ПараметрыИнтеграции.ИмяКолонкиШтрихкодУпаковки                 = "АкцизнаяМарка";
		
	КонецЕсли;
	
	Если ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ВозвратТоваровОтКлиента")
		ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ПриобретениеТоваровУслуг") Тогда
		
		ПараметрыИнтеграции.ЕстьЭлектронныйДокумент = ЭлектронноеВзаимодействиеИСМП.ДокументСвязанСЭлектронным(Форма.Объект.Ссылка);
		
	КонецЕсли;
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// Заполняет специфику применения интеграции формы проверки и подбора в конкретную форму.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма для которой применяются параметры интеграции.
//
Процедура ПриПримененииПараметровИнтеграцииФормыПроверкиИПодбора(Форма) Экспорт
	
	//++ НЕ ГОСИС
	Если СтрНачинаетсяС(Форма.ИмяФормы,"Документ.КорректировкаРеализации") Тогда
		Колонка = Форма.Элементы.Найти("ТоварыСтатусПроверкиГосИС");
		Если Колонка <> Неопределено Тогда
			Колонка.Видимость = ЗначениеЗаполнено(Форма.Объект.Склад);
		КонецЕсли;
	КонецЕсли;
	//-- НЕ ГОСИС
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСТСД

// Обрабатывает таблицу штриховых кодов и получает для каждого из них данные в информационной базе.
//   На входе имеется таблица, в которой заполнены только колонки "Номер строки", "Штриховой код" и "Количество", опционально заполнена 
//   колонка "Родитель".
//   В процедуре заполняется допустимый штрихкод упаковки из справочника или признак новой (неизвестной) упаковки.
//
// Параметры:
//  ТаблицаНеАкцизныеМарки - ТаблицаЗначение - имеет следующие колонки:
//   * ШтриховойКод        - Строка                              - штриховой код полученный с ТСД.
//   * Количество          - Число                               - сколько раз был считан данный штрихкод.
//   * ШтрихКодУпаковки    - Справочник.ШтрихкодыУпаковокТоваров - ссылка на имеющуюся в базе упаковку.
//   * Родитель            - Строка                              - штрихкод внешней упаковки.
//   * НомерСтроки         - Число                               - номер строки таблицы
//   * ЭтоУпаковка         - Булево                              - признак новой упаковки
//
Процедура РаспознатьШтрихкоды(ТаблицаНеАкцизныеМарки) Экспорт
	
	//++ НЕ ГОСИС
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ШтриховыеКоды.ШтриховойКод КАК ШтриховойКод,
	|	ШтриховыеКоды.Количество   КАК Количество,
	|	ШтриховыеКоды.НомерСтроки  КАК НомерСтроки,
	|	ШтриховыеКоды.Родитель     КАК Родитель
	|ПОМЕСТИТЬ Штрихкоды
	|ИЗ
	|	&ШтриховыеКоды КАК ШтриховыеКоды
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Штрихкоды.ШтриховойКод                                  КАК ШтриховойКод,
	|	Штрихкоды.Количество                                    КАК Количество,
	|	Штрихкоды.Родитель                                      КАК Родитель,
	|	Штрихкоды.НомерСтроки                                   КАК НомерСтроки,
	|	ЕСТЬNULL(ШтрихкодыУпаковокТоваров.Ссылка, Неопределено) КАК ШтрихКодУпаковки,
	|	ШтрихкодыНоменклатуры.Штрихкод ЕСТЬ NULL
	|		И ШтрихкодыУпаковокТоваров.Ссылка ЕСТЬ NULL         КАК ЭтоУпаковка
	|ИЗ
	|	Штрихкоды КАК Штрихкоды
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ШтрихкодыУпаковокТоваров КАК ШтрихкодыУпаковокТоваров
	|		ПО Штрихкоды.ШтриховойКод = ШтрихкодыУпаковокТоваров.ЗначениеШтрихкода
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ШтрихкодыНоменклатуры КАК ШтрихкодыНоменклатуры
	|		ПО Штрихкоды.ШтриховойКод = ШтрихкодыНоменклатуры.Штрихкод
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Запрос.УстановитьПараметр("ШтриховыеКоды", ТаблицаНеАкцизныеМарки);
	
	ТаблицаНеАкцизныеМарки = Запрос.Выполнить().Выгрузить();
	//-- НЕ ГОСИС
	Возврат;

КонецПроцедуры

#КонецОбласти

#КонецОбласти