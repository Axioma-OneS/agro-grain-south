﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

// Заполняет регистр сведений "ABCXYZКлассификацияКлиентов" результатами ABC классификации партнеров.
//
// Параметры:
//  ДатаКлассификации  - Дата - дата, на которую выполняется классификация.
//
Процедура ВыполнитьABCКлассификацию(ДатаКлассификации = Неопределено) Экспорт
	
	ИспользоватьКлассификациюПоВаловойПрибыли = ПолучитьФункциональнуюОпцию("ИспользоватьABCXYZКлассификациюПартнеровПоВаловойПрибыли");
	ИспользоватьКлассификациюПоВыручке = ПолучитьФункциональнуюОпцию("ИспользоватьABCXYZКлассификациюПартнеровПоВыручке");
	ИспользоватьКлассификациюПоКоличеству = ПолучитьФункциональнуюОпцию("ИспользоватьABCXYZКлассификациюПартнеровПоКоличествуПродаж");

	Если НЕ ИспользоватьКлассификациюПоВаловойПрибыли И НЕ ИспользоватьКлассификациюПоВыручке И НЕ ИспользоватьКлассификациюПоКоличеству Тогда

		Возврат;

	КонецЕсли;

	ПериодКлассификации = Константы.ПериодABCКлассификацииПартнеров.Получить();
	КоличествоПериодовКлассификации = Константы.КоличествоПериодовABCКлассификацииПартнеров.Получить();

	Если ПериодКлассификации.Пустая() ИЛИ КоличествоПериодовКлассификации = 0 Тогда

		Возврат;

	КонецЕсли;

	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	РегистрСведенийАналитикаУчетаПоПартнерам.Партнер КАК Партнер,
		|	СУММА(ВыручкаИСебестоимостьПродажОбороты.СуммаВыручкиОборот) - СУММА(ВыручкаИСебестоимостьПродажОбороты.СтоимостьОборот) - СУММА(ВыручкаИСебестоимостьПродажОбороты.ДопРасходыОборот) КАК ВаловаяПрибыль,
		|	СУММА(ВыручкаИСебестоимостьПродажОбороты.СуммаВыручкиОборот) КАК Выручка,
		|	СУММА(ВЫБОР
		|			КОГДА ВыручкаИСебестоимостьПродажОбороты.Регистратор ССЫЛКА Документ.РеализацияТоваровУслуг
		|				ТОГДА 1
		|			ИНАЧЕ 0
		|		КОНЕЦ) КАК Количество
		|ИЗ
		|	РегистрНакопления.ВыручкаИСебестоимостьПродаж.Обороты(&НачалоПериода, &ОкончаниеПериода, Регистратор,(НЕ АналитикаУчетаПоПартнерам.Партнер.Предопределенный) И (НЕ АналитикаУчетаПоПартнерам.Партнер = ЗНАЧЕНИЕ(Справочник.Партнеры.ПустаяСсылка))) КАК ВыручкаИСебестоимостьПродажОбороты
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрСведенийАналитикаУчетаПоПартнерам
		|		ПО ВыручкаИСебестоимостьПродажОбороты.АналитикаУчетаПоПартнерам = РегистрСведенийАналитикаУчетаПоПартнерам.КлючАналитики
		|СГРУППИРОВАТЬ ПО
		|	РегистрСведенийАналитикаУчетаПоПартнерам.Партнер");

	Период = ОбщегоНазначенияУТКлиентСервер.РасширенныйПериод(?(ДатаКлассификации = Неопределено, ТекущаяДатаСеанса(), ДатаКлассификации), ПериодКлассификации, - КоличествоПериодовКлассификации);
	Запрос.УстановитьПараметр("НачалоПериода", Период.ДатаНачала);
	Запрос.УстановитьПараметр("ОкончаниеПериода", Период.ДатаОкончания);

	РезультатКлассификации = Запрос.Выполнить().Выгрузить();

	Если ИспользоватьКлассификациюПоВаловойПрибыли Тогда

		Классификация.ВыполнитьABCКлассификацию(РезультатКлассификации, "ВаловаяПрибыль");
		ОбновитьДанныеКлассификации(
			РезультатКлассификации, Перечисления.ТипыКлассификации.ABC,
			Перечисления.ТипыПараметровКлассификации.ВаловаяПрибыль,
			Период.ДатаОкончания, Перечисления.ABCКлассификация.НеКлассифицирован);

	КонецЕсли;

	Если ИспользоватьКлассификациюПоВыручке Тогда

		Классификация.ВыполнитьABCКлассификацию(РезультатКлассификации, "Выручка");
		ОбновитьДанныеКлассификации(
			РезультатКлассификации, Перечисления.ТипыКлассификации.ABC,
			Перечисления.ТипыПараметровКлассификации.Выручка,
			Период.ДатаОкончания, Перечисления.ABCКлассификация.НеКлассифицирован);

	КонецЕсли;

	Если ИспользоватьКлассификациюПоКоличеству Тогда

		Классификация.ВыполнитьABCКлассификацию(РезультатКлассификации, "Количество");
		ОбновитьДанныеКлассификации(
			РезультатКлассификации, Перечисления.ТипыКлассификации.ABC,
			Перечисления.ТипыПараметровКлассификации.Количество,
			Период.ДатаОкончания, Перечисления.ABCКлассификация.НеКлассифицирован);

	КонецЕсли;

КонецПроцедуры

// Заполняет регистр сведений "ABCXYZКлассификацияКлиентов" результатами XYZ классификации партнеров.
//
// Параметры:
//  ДатаКлассификации  - Дата - дата, на которую выполняется классификация.
//
Процедура ВыполнитьXYZКлассификацию(ДатаКлассификации = Неопределено) Экспорт

	ИспользоватьКлассификациюПоВаловойПрибыли = ПолучитьФункциональнуюОпцию("ИспользоватьABCXYZКлассификациюПартнеровПоВаловойПрибыли");
	ИспользоватьКлассификациюПоВыручке = ПолучитьФункциональнуюОпцию("ИспользоватьABCXYZКлассификациюПартнеровПоВыручке");
	ИспользоватьКлассификациюПоКоличеству = ПолучитьФункциональнуюОпцию("ИспользоватьABCXYZКлассификациюПартнеровПоКоличествуПродаж");

	Если НЕ ИспользоватьКлассификациюПоВаловойПрибыли И НЕ ИспользоватьКлассификациюПоВыручке И НЕ ИспользоватьКлассификациюПоКоличеству Тогда

		Возврат;

	КонецЕсли;

	ПериодКлассификации = Константы.ПериодXYZКлассификацииПартнеров.Получить();
	КоличествоПериодовКлассификации = Константы.КоличествоПериодовXYZКлассификацииПартнеров.Получить();
	ПодпериодКлассификации = Константы.ПодпериодXYZКлассификацииПартнеров.Получить();

	Если ПериодКлассификации.Пустая() ИЛИ КоличествоПериодовКлассификации = 0 ИЛИ ПодпериодКлассификации.Пустая() Тогда

		Возврат;

	КонецЕсли;

	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	0 КАК РазделительКлассификации,
	|	РегистрСведенийАналитикаУчетаПоПартнерам.Партнер КАК Партнер,
	|	НАЧАЛОПЕРИОДА(ВыручкаИСебестоимостьПродажОбороты.Период, " + Строка(ПодпериодКлассификации) + ") КАК Период,
	|	ВыручкаИСебестоимостьПродажОбороты.СуммаВыручкиОборот КАК Выручка,
	|	ЕСТЬNULL(ВыручкаИСебестоимостьПродажОбороты.СуммаВыручкиОборот, 0) - ЕСТЬNULL(ВыручкаИСебестоимостьПродажОбороты.СтоимостьОборот, 0) - ЕСТЬNULL(ВыручкаИСебестоимостьПродажОбороты.ДопРасходыОборот, 0) КАК ВаловаяПрибыль,
	|	ВЫБОР
	|		КОГДА ВыручкаИСебестоимостьПродажОбороты.Регистратор ССЫЛКА Документ.РеализацияТоваровУслуг
	|			ТОГДА 1
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК Количество
	|ИЗ
	|	РегистрНакопления.ВыручкаИСебестоимостьПродаж.Обороты(НАЧАЛОПЕРИОДА(&НачалоПериода, " + Строка(ПодпериодКлассификации) + "), КОНЕЦПЕРИОДА(&ОкончаниеПериода, " + Строка(ПодпериодКлассификации) + "), Регистратор, (НЕ АналитикаУчетаПоПартнерам.Партнер.Предопределенный) И (НЕ АналитикаУчетаПоПартнерам.Партнер = ЗНАЧЕНИЕ(Справочник.Партнеры.ПустаяСсылка))) КАК ВыручкаИСебестоимостьПродажОбороты
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрСведенийАналитикаУчетаПоПартнерам
	|		ПО ВыручкаИСебестоимостьПродажОбороты.АналитикаУчетаПоПартнерам = РегистрСведенийАналитикаУчетаПоПартнерам.КлючАналитики
	|ИТОГИ
	|	МАКСИМУМ(РазделительКлассификации),
	|	СУММА(Выручка),
	|	СУММА(ВаловаяПрибыль),
	|	СУММА(Количество)
	|ПО
	|	Партнер,
	|	Период ПЕРИОДАМИ(" + Строка(ПодпериодКлассификации) + ", НАЧАЛОПЕРИОДА(&НачалоПериода, " + Строка(ПодпериодКлассификации) + "), КОНЕЦПЕРИОДА(&ОкончаниеПериода, " + Строка(ПодпериодКлассификации) + "))");

	Период = ОбщегоНазначенияУТКлиентСервер.РасширенныйПериод(?(ДатаКлассификации = Неопределено, ТекущаяДатаСеанса(), ДатаКлассификации), ПериодКлассификации, - КоличествоПериодовКлассификации);
	Запрос.УстановитьПараметр("НачалоПериода", Период.ДатаНачала);
	Запрос.УстановитьПараметр("ОкончаниеПериода", Период.ДатаОкончания);

	ИсточникДанных = Новый Структура("ИсточникДанных", Запрос.Выполнить());

	Если ИспользоватьКлассификациюПоВаловойПрибыли Тогда

		РезультатКлассификации = Классификация.ВыполнитьXYZКлассификацию(ИсточникДанных, "ВаловаяПрибыль", "Номенклатура");
		ОбновитьДанныеКлассификации(
			РезультатКлассификации, Перечисления.ТипыКлассификации.XYZ,
			Перечисления.ТипыПараметровКлассификации.ВаловаяПрибыль,
			Период.ДатаОкончания, Перечисления.XYZКлассификация.НеКлассифицирован);

	КонецЕсли;

	Если ИспользоватьКлассификациюПоВыручке Тогда

		РезультатКлассификации = Классификация.ВыполнитьXYZКлассификацию(ИсточникДанных, "Выручка", "Номенклатура");
		ОбновитьДанныеКлассификации(
			РезультатКлассификации, Перечисления.ТипыКлассификации.XYZ,
			Перечисления.ТипыПараметровКлассификации.Выручка,
			Период.ДатаОкончания, Перечисления.XYZКлассификация.НеКлассифицирован);

	КонецЕсли;

	Если ИспользоватьКлассификациюПоКоличеству Тогда

		РезультатКлассификации = Классификация.ВыполнитьXYZКлассификацию(ИсточникДанных, "Количество", "Номенклатура");
		ОбновитьДанныеКлассификации(
			РезультатКлассификации, Перечисления.ТипыКлассификации.XYZ,
			Перечисления.ТипыПараметровКлассификации.Количество,
			Период.ДатаОкончания, Перечисления.XYZКлассификация.НеКлассифицирован);

	КонецЕсли;

КонецПроцедуры

// Определяет список команд создания на основании.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	Справочники.ДоговорыКонтрагентов.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Справочники.ДоговорыМеждуОрганизациями.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Справочники.КонтактныеЛицаПартнеров.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Справочники.ПретензииКлиентов.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Справочники.СделкиСКлиентами.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Справочники.СоглашенияСКлиентами.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Справочники.СоглашенияСПоставщиками.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
	Команда = Документы.ЗаказКлиента.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.РежимЗаписи = "";
	КонецЕсли;
	Команда = Документы.ЗаказПоставщику.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.РежимЗаписи = "";
	КонецЕсли;
	Команда = Документы.ЗаявкаНаВозвратТоваровОтКлиента.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.РежимЗаписи = "";
	КонецЕсли;
	Команда = Документы.ПоручениеЭкспедитору.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.РежимЗаписи = "";
	КонецЕсли;
	Команда = Документы.РегистрацияЦенНоменклатурыПоставщика.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.РежимЗаписи = "";
	КонецЕсли;
	
	БизнесПроцессы.Задание.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
	
	
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Ссылка)";
	
	Ограничение.ТекстДляВнешнихПользователей =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК ЭтотСписок
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВнешниеПользователи КАК ВнешниеПользователиПартнеры
	|	ПО ВнешниеПользователиПартнеры.ОбъектАвторизации = ЭтотСписок.Ссылка
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КонтактныеЛицаПартнеров КАК КонтактныеЛицаПартнеров
	|	ПО КонтактныеЛицаПартнеров.Владелец = ЭтотСписок.Ссылка
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВнешниеПользователи КАК ВнешниеПользователиКонтактныеЛица
	|	ПО ВнешниеПользователиКонтактныеЛица.ОбъектАвторизации = КонтактныеЛицаПартнеров.Ссылка
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(ВнешниеПользователиПартнеры.Ссылка)
	|	ИЛИ ЗначениеРазрешено(ВнешниеПользователиКонтактныеЛица.Ссылка)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Результат = ПартнерыИКонтрагентыВызовСервера.ПартнерыДанныеВыбора(Параметры);
	
	Если Результат <> Неопределено Тогда
		
		СтандартнаяОбработка = ЛОЖЬ;
		ДанныеВыбора = Результат;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	ИспользоватьПолнотекстовыйПоиск = ОбщегоНазначенияУТВызовСервера.ИспользуетсяПолнотекстовыйПоиск("ИспользоватьПолнотекстовыйПоиск");
	
	Если ВидФормы = "ФормаОбъекта" Тогда
		
		Если Параметры.Свойство("РежимВыбора") И Параметры.РежимВыбора Тогда
			
			ВыбраннаяФорма = "ПомощникНового";
			СтандартнаяОбработка = Ложь;

		ИначеЕсли ПолучитьФункциональнуюОпцию("ИспользоватьПартнеровКакКонтрагентов") Тогда
			
			ВыбраннаяФорма = "ФормаЭлементаРеквизитыКонтрагента";
			СтандартнаяОбработка = Ложь;
			
		КонецЕсли;
		
	ИначеЕсли ВидФормы = "ФормаВыбора" И НЕ ИспользоватьПолнотекстовыйПоиск Тогда 
		
		ВыбраннаяФорма = "ФормаВыбораБезПолнотекстовогоПоиска";
		СтандартнаяОбработка = Ложь;
		
	ИначеЕсли ВидФормы = "ФормаСписка" И НЕ ИспользоватьПолнотекстовыйПоиск Тогда 
		
		ВыбраннаяФорма = "ФормаСпискаБезПолнотекстовогоПоиска";
		СтандартнаяОбработка = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

#Область Назначения


#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Заполняет предопределенные элементы справочника "Партнеры".
//
Процедура ЗаполнитьПредопределенныхПартнеров() Экспорт
	
	СправочникОбъект = Справочники.Партнеры.НашеПредприятие.ПолучитьОбъект();
	СправочникОбъект.ДатаРегистрации = Дата(1980, 1, 1);
	СправочникОбъект.НаименованиеПолное = НСтр("ru = 'Наше предприятие'");
	СправочникОбъект.ЮрФизЛицо = Перечисления.КомпанияЧастноеЛицо.Компания;
	
	СправочникОбъект.Записать();
	Если ПолучитьФункциональнуюОпцию("ИспользоватьПартнеровКакКонтрагентов") Тогда
		МассивПартнеров = ПартнерыИКонтрагенты.ПолучитьВсехКонтрагентовПартнера(СправочникОбъект.Ссылка);
		Если МассивПартнеров.Количество() = 0 Тогда
			Контрагент = Справочники.Контрагенты.СоздатьЭлемент();
			Контрагент.Наименование = СправочникОбъект.Наименование;
			Контрагент.НаименованиеПолное = СправочникОбъект.НаименованиеПолное;
			Контрагент.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо;
			Контрагент.Партнер = СправочникОбъект.Ссылка;
			Контрагент.Записать();
		КонецЕсли;
	КонецЕсли;
	
	СправочникОбъект = Справочники.Партнеры.РозничныйПокупатель.ПолучитьОбъект();
	СправочникОбъект.Клиент = Истина;
	СправочникОбъект.ДатаРегистрации = Дата(1980, 1, 1);
	СправочникОбъект.НаименованиеПолное = НСтр("ru = 'Розничный покупатель'");
	СправочникОбъект.ЮрФизЛицо = Перечисления.КомпанияЧастноеЛицо.ЧастноеЛицо;
	СправочникОбъект.Записать();
	// Контрагент "Розничный покупатель" заполняется в соответствующей процедуре модуле менеджера справочника "Контрагенты".
	
	СправочникОбъект = Справочники.Партнеры.НеизвестныйПартнер.ПолучитьОбъект();
	СправочникОбъект.Клиент = Истина;
	СправочникОбъект.Поставщик = Истина;
	СправочникОбъект.ПрочиеОтношения = Истина;
	СправочникОбъект.ДатаРегистрации = Дата(1980, 1, 1);
	СправочникОбъект.НаименованиеПолное = НСтр("ru = 'Неизвестный партнер'");
	СправочникОбъект.ЮрФизЛицо = Перечисления.КомпанияЧастноеЛицо.Компания;
	СправочникОбъект.Записать();
	
КонецПроцедуры


#КонецОбласти

#Область Прочее

Процедура ОбновитьДанныеКлассификации(РезультатКлассификации, ТипКлассификации, ТипПараметраКлассификации, ПериодКлассификации, НеКлассифицирован)

	Если РезультатКлассификации.Колонки.Найти("Период") = Неопределено Тогда

		РезультатКлассификации.Колонки.Добавить("Период");

	КонецЕсли;

	Если РезультатКлассификации.Колонки.Найти("ТипПараметраКлассификации") = Неопределено Тогда

		РезультатКлассификации.Колонки.Добавить("ТипПараметраКлассификации");

	КонецЕсли;

	Если РезультатКлассификации.Колонки.Найти("ТипКлассификации") = Неопределено Тогда

		РезультатКлассификации.Колонки.Добавить("ТипКлассификации");

	КонецЕсли;

	РезультатКлассификации.ЗаполнитьЗначения(ПериодКлассификации, "Период");
	РезультатКлассификации.ЗаполнитьЗначения(ТипПараметраКлассификации, "ТипПараметраКлассификации");
	РезультатКлассификации.ЗаполнитьЗначения(ТипКлассификации, "ТипКлассификации");

	НаборЗаписей = РегистрыСведений.ABCXYZКлассификацияКлиентов.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Период.Установить(ПериодКлассификации);
	НаборЗаписей.Отбор.ТипКлассификации.Установить(ТипКлассификации);
	НаборЗаписей.Отбор.ТипПараметраКлассификации.Установить(ТипПараметраКлассификации);

	НаборЗаписей.Загрузить(РезультатКлассификации);
	НаборЗаписей.Записать(Истина);

	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	НАЧАЛОПЕРИОДА(&ПериодКлассификации, ДЕНЬ) КАК Период,
		|	ABCXYZКлассификацияКлиентовСрезПоследних.Партнер КАК Партнер,
		|	ABCXYZКлассификацияКлиентовСрезПоследних.ТипПараметраКлассификации КАК ТипПараметраКлассификации,
		|	ABCXYZКлассификацияКлиентовСрезПоследних.ТипКлассификации КАК ТипКлассификации,
		|	&НеКлассифицирован КАК Класс,
		|	0 КАК ЗначениеПараметраКлассификации
		|ИЗ
		|	РегистрСведений.ABCXYZКлассификацияКлиентов.СрезПоследних(
		|			ДОБАВИТЬКДАТЕ(&ПериодКлассификации, СЕКУНДА, -1),
		|			(НЕ Партнер В
		|						(ВЫБРАТЬ
		|							ABCXYZКлассификацияКлиентов.Партнер КАК Партнер
		|						ИЗ
		|							РегистрСведений.ABCXYZКлассификацияКлиентов КАК ABCXYZКлассификацияКлиентов
		|						ГДЕ
		|							ABCXYZКлассификацияКлиентов.Период = НАЧАЛОПЕРИОДА(&ПериодКлассификации, ДЕНЬ)
		|							И ABCXYZКлассификацияКлиентов.ТипПараметраКлассификации = &ТипПараметраКлассификации
		|							И ABCXYZКлассификацияКлиентов.ТипКлассификации = &ТипКлассификации))
		|				И ТипПараметраКлассификации = &ТипПараметраКлассификации
		|				И ТипКлассификации = &ТипКлассификации) КАК ABCXYZКлассификацияКлиентовСрезПоследних");

	Запрос.УстановитьПараметр("ПериодКлассификации", ПериодКлассификации);
	Запрос.УстановитьПараметр("ТипКлассификации", ТипКлассификации);
	Запрос.УстановитьПараметр("ТипПараметраКлассификации", ТипПараметраКлассификации);
	Запрос.УстановитьПараметр("НеКлассифицирован", НеКлассифицирован);

	РезультатЗапроса = Запрос.Выполнить();

	Если НЕ РезультатЗапроса.Пустой() Тогда

		НаборЗаписей.Загрузить(РезультатЗапроса.Выгрузить());
		НаборЗаписей.Записать(Ложь);

	КонецЕсли;

КонецПроцедуры

Процедура ЗаполнитьСтруктуруПолучателейПечатныхФорм(СтруктураДанныхОбъектаПечати) Экспорт
	
	СтруктураДанныхОбъектаПечати.ОсновнойПолучатель = "Ссылка";

	СтруктураДанныхОбъектаПечати.МассивРеквизитовПолучателей.Добавить("Ссылка");
	
КонецПроцедуры

#КонецОбласти

#Область Отчеты

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - Таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	КомандаОтчет = Отчеты.ДосьеПартнера.ДобавитьКомандуДосьеПартнера(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска";
	КонецЕсли;
	
	ИспользоватьПартнеровКакКонтрагентов = ПолучитьФункциональнуюОпцию("ИспользоватьПартнеровКакКонтрагентов");
	Если ИспользоватьПартнеровКакКонтрагентов Тогда
		КомандаОтчет = ВариантыОтчетовУТПереопределяемый.ДобавитьКомандуДосьеКонтрагента(КомандыОтчетов);
		Если КомандаОтчет <> Неопределено Тогда
			КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
		КонецЕсли;
	КонецЕсли;
	
	КомандаОтчет = Отчеты.ВыполнениеУсловийСоглашенийСКлиентами.ДобавитьКомандуВыполнениеУсловийСоглашенийСКлиентамиПоПартнеру(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.ВыручкаИСебестоимостьПродаж.ДобавитьКомандуПродажи(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.КарточкаРасчетовСКлиентами.ДобавитьКомандуКарточкаРасчетовСКлиентом(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.КарточкаРасчетовСПоставщиками.ДобавитьКомандуКарточкаРасчетовСПоставщиком(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.РасчетыСПартнерами.ДобавитьКомандуОтчета(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.СостояниеРасчетовСКлиентами.ДобавитьКомандуОтчета(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.СостояниеРасчетовСПоставщиками.ДобавитьКомандуОтчета(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.УсловияЗакупок.ДобавитьКомандуОтчетаПоПоставщику(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска,ФормаЭлементаРеквизитыКонтрагента";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.УсловияПродаж.ДобавитьКомандуОтчетаПоПартнеру(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.КонтактнаяИнформация.ДобавитьКомандуКонтактнаяИнформацияПоПартнерам(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска";
	КонецЕсли;
	
	КомандаОтчет = Отчеты.КонтактнаяИнформация.ДобавитьКомандуКонтактнаяИнформацияКонтактныхЛиц(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска";
	КонецЕсли;
	
	КомандаОтчет = ВариантыОтчетовУТПереопределяемый.ДобавитьКомандуВзаимодействияПоКонтакту(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска";
	КонецЕсли;
	
	КомандаОтчет = ВариантыОтчетовУТПереопределяемый.ДобавитьКомандуСегментыПартнера(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаЭлемента,ФормаСписка,ФормаСпискаБезПолнотекстовогоПоиска";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ШаблоныСообщений

// Вызывается при подготовке шаблонов сообщений и позволяет переопределить список реквизитов и вложений.
//
// Параметры:
//  Реквизиты               - ДеревоЗначений - список реквизитов шаблона.
//         ** Имя            - Строка - Уникальное имя общего реквизита.
//         ** Представление  - Строка - Представление общего реквизита.
//         ** Тип            - Тип    - Тип реквизита. По умолчанию строка.
//         ** Формат         - Строка - Формат вывода значения для чисел, дат, строк и булевых значений.
//  Вложения                - ТаблицаЗначений - печатные формы и вложения
//         ** Имя            - Строка - Уникальное имя вложения.
//         ** Представление  - Строка - Представление варианта.
//         ** ТипФайла       - Строка - Тип вложения, который соответствует расширению файла: "pdf", "png", "jpg", mxl"
//                                      и др.
//  ДополнительныеПараметры - Структура - дополнительные сведения о шаблоне сообщений.
//
Процедура ПриПодготовкеШаблонаСообщения(Реквизиты, Вложения, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

// Вызывается в момент создания сообщений по шаблону для заполнения значений реквизитов и вложений.
//
// Параметры:
//  Сообщение - Структура - структура с ключами:
//    * ЗначенияРеквизитов - Соответствие - список используемых в шаблоне реквизитов.
//      ** Ключ     - Строка - имя реквизита в шаблоне;
//      ** Значение - Строка - значение заполнения в шаблоне.
//    * ЗначенияОбщихРеквизитов - Соответствие - список используемых в шаблоне общих реквизитов.
//      ** Ключ     - Строка - имя реквизита в шаблоне;
//      ** Значение - Строка - значение заполнения в шаблоне.
//    * Вложения - Соответствие - значения реквизитов 
//      ** Ключ     - Строка - имя вложения в шаблоне;
//      ** Значение - ДвоичныеДанные, Строка - двоичные данные или адрес во временном хранилище вложения.
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект являющийся источником данных.
//  ДополнительныеПараметры - Структура -  Дополнительная информация о шаблоне сообщения.
//
Процедура ПриФормированииСообщения(Сообщение, ПредметСообщения, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

// Заполняет список получателей SMS при отправке сообщения сформированного по шаблону.
//
// Параметры:
//   ПолучателиSMS - ТаблицаЗначений - список получается SMS.
//     * НомерТелефона - Строка - номер телефона, куда будет отправлено сообщение SMS.
//     * Представление - Строка - представление получателя сообщения SMS.
//     * Контакт       - СправочникСсылка - контакт, которому принадлежит номер телефона.
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект являющийся источником данных.
//
Процедура ПриЗаполненииТелефоновПолучателейВСообщении(ПолучателиSMS, ПредметСообщения) Экспорт
	
КонецПроцедуры

// Заполняет список получателей письма при отправки сообщения сформированного по шаблону.
//
// Параметры:
//   ПолучателиПисьма - ТаблицаЗначений - список получается письма.
//     * Адрес           - Строка - адрес электронной почты получателя.
//     * Представление   - Строка - представление получается письма.
//     * ВариантОтправки - Строка - Варианты отправки письма: "Кому", "Копия", "СкрытаяКопия", "ОбратныйАдреса";
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект являющийся источником данных.
//
Процедура ПриЗаполненииПочтыПолучателейВСообщении(ПолучателиПисьма, ПредметСообщения) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
