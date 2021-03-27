﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКопировании(ОбъектКопирования)
	
	ВидыЗапасовУказаныВручную = Ложь;
	
	Если ВидыЗапасов.Количество() > 0 Тогда
		ВидыЗапасов.Очистить();
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;

	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект, МассивНепроверяемыхРеквизитов, Отказ);
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект,
												НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.КорректировкаОбособленногоУчетаЗапасов),
												Отказ,
												МассивНепроверяемыхРеквизитов);
	
	Если Предназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляСделки Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Сделка");
	КонецЕсли;
	
	Если Предназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляМенеджера Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Менеджер");
	КонецЕсли;
	
	Если Предназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляПодразделения Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Подразделение");
	КонецЕсли;
	
	Если НовоеПредназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляСделки Тогда
		МассивНепроверяемыхРеквизитов.Добавить("НоваяСделка");
	КонецЕсли;
	
	Если НовоеПредназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляМенеджера Тогда
		МассивНепроверяемыхРеквизитов.Добавить("НовыйМенеджер");
	КонецЕсли;
	
	Если НовоеПредназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляПодразделения Тогда
		МассивНепроверяемыхРеквизитов.Добавить("НовоеПодразделение");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(
		ПроверяемыеРеквизиты,
		МассивНепроверяемыхРеквизитов);
	
	Если Предназначение = НовоеПредназначение Тогда
		
		ТекстОшибки = "";
		Если Предназначение = Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляСделки
		 И ЗначениеЗаполнено(Сделка)
		 И Сделка = НоваяСделка Тогда
			ТекстОшибки = НСтр("ru='Исходная сделка равна новой сделке'");
			Поле = "Сделка";
		КонецЕсли;
	 
		Если Предназначение = Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляМенеджера
		 И ЗначениеЗаполнено(Менеджер)
		 И Менеджер = НовыйМенеджер Тогда
			ТекстОшибки = НСтр("ru='Исходной менеджер равен новому менеджеру'");
			Поле = "Менеджер";
		КонецЕсли;
	 
		Если Предназначение = Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляПодразделения
		 И ЗначениеЗаполнено(Подразделение)
		 И Подразделение = НовоеПодразделение Тогда
			ТекстОшибки = НСтр("ru='Исходное подразделение равно новому подразделению'");
			Поле = "Подразделение";
		КонецЕсли;
		
		Если Предназначение = Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначениеНеОграничено Тогда
			ТекстОшибки = НСтр("ru='Исходное предназначение равно новому предназначению'");
			Поле = "Предназначение";
		КонецЕсли;
		
		Если Не ПустаяСтрока(ТекстОшибки) Тогда
	 		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				ТекстОшибки,
				ЭтотОбъект,
				Поле,
				, // ПутьКДанным
				Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

	ПроведениеСерверУТ.УстановитьРежимПроведения(ЭтотОбъект, РежимЗаписи, РежимПроведения);

	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
	
	НоменклатураСервер.ОчиститьНеиспользуемыеСерии(ЭтотОбъект,
														НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.КорректировкаОбособленногоУчетаЗапасов));
	
	Если Предназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляСделки Тогда
		Сделка = Неопределено;
	КонецЕсли;
	
	Если Предназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляМенеджера Тогда
		Менеджер = Неопределено;
	КонецЕсли;
	
	Если Предназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляПодразделения Тогда
		Подразделение = Неопределено;
	КонецЕсли;
	
	Если НовоеПредназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляСделки Тогда
		НоваяСделка = Неопределено;
	КонецЕсли;
	
	Если НовоеПредназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляМенеджера Тогда
		НовыйМенеджер = Неопределено;
	КонецЕсли;
	
	Если НовоеПредназначение <> Перечисления.ТипыПредназначенияВидовЗапасов.ПредназначенДляПодразделения Тогда
		НовоеПодразделение = Неопределено;
	КонецЕсли;
	
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		ЗаполнитьАналитикиУчетаНоменклатуры();
		ЗаполнитьВидыЗапасов(Отказ);
		
	ИначеЕсли РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда
		Если Не ВидыЗапасовУказаныВручную Тогда
			ВидыЗапасов.Очистить();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);

	Документы.КорректировкаОбособленногоУчетаЗапасов.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);

	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	ЗапасыСервер.ОтразитьТоварыОрганизаций(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьДатыПоступленияТоваровОрганизаций(ДополнительныеСвойства, Отказ);
	ДоходыИРасходыСервер.ОтразитьСебестоимостьТоваров(ДополнительныеСвойства, Движения, Отказ);
	
	СформироватьСписокРегистровДляКонтроля();
	ЗапасыСервер.ПодготовитьЗаписьТоваровОрганизаций(ЭтотОбъект, РежимЗаписиДокумента.Проведение);
	
	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	ПараметрыЗаполненения = ПараметрыЗаполненияВидовЗапасов();
	ЗапасыСервер.СформироватьРезервыПоТоварамОрганизаций(ЭтотОбъект, Отказ, ПараметрыЗаполненения);
	
	ПроведениеСерверУТ.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	ПроведениеСерверУТ.СформироватьЗаписиРегистровЗаданий(ЭтотОбъект);

	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)

	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);

	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	СформироватьСписокРегистровДляКонтроля();
	ЗапасыСервер.ПодготовитьЗаписьТоваровОрганизаций(ЭтотОбъект, РежимЗаписиДокумента.ОтменаПроведения);

	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПараметрыЗаполненения = ПараметрыЗаполненияВидовЗапасов();
	ПараметрыЗаполненения.ДокументДелаетИПриходИРасход = Ложь;
	ЗапасыСервер.СформироватьРезервыПоТоварамОрганизаций(ЭтотОбъект, Отказ, ПараметрыЗаполненения);
	
	ПроведениеСерверУТ.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	ПроведениеСерверУТ.СформироватьЗаписиРегистровЗаданий(ЭтотОбъект);

	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)

	Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	Склад = ЗначениеНастроекПовтИсп.ПолучитьСкладПоУмолчанию(Склад);
	
КонецПроцедуры

#КонецОбласти

#Область ВидыЗапасов

Функция ВременныеТаблицыДанныхДокумента() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	&Дата КАК Дата,
	|	&Организация КАК Организация,
	|	&Склад КАК Склад,
	|	&Предназначение КАК Предназначение,
	|	&Подразделение КАК Подразделение,
	|	&Менеджер КАК Менеджер,
	|	&Сделка КАК Сделка,
	|
	|	Неопределено КАК Партнер,
	|	Неопределено КАК Контрагент,
	|	ЗНАЧЕНИЕ(Справочник.СоглашенияСПоставщиками.ПустаяСсылка) КАК Соглашение,
	|	ЗНАЧЕНИЕ(Справочник.ДоговорыКонтрагентов.ПустаяСсылка) КАК Договор,
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК Валюта,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПустаяСсылка) КАК НалогообложениеНДС,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.КорректировкаОбособленногоУчета) КАК ХозяйственнаяОперация,
	|	ЛОЖЬ КАК ЕстьСделкиВТабличнойЧасти,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.Товар) КАК ТипЗапасов
	|ПОМЕСТИТЬ ТаблицаДанныхДокумента
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаТоваров.НомерСтроки КАК НомерСтроки,
	|	ТаблицаТоваров.Номенклатура КАК Номенклатура,
	|	ТаблицаТоваров.Характеристика КАК Характеристика,
	|	ТаблицаТоваров.Серия КАК Серия,
	|	ТаблицаТоваров.СтатусУказанияСерий КАК СтатусУказанияСерий,
	|	ТаблицаТоваров.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ТаблицаТоваров.Количество КАК Количество,
	|	&Склад КАК Склад,
	|	&Сделка КАК Сделка,
	|	ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка) КАК Назначение,
	|	ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.ПустаяСсылка) КАК СтавкаНДС,
	|	0 КАК СуммаСНДС,
	|	0 КАК СуммаНДС,
	|	0 КАК СуммаВознаграждения,
	|	0 КАК СуммаНДСВознаграждения,
	|	ИСТИНА КАК ПодбиратьВидыЗапасов,
	|	ЗНАЧЕНИЕ(Справочник.НомераГТД.ПустаяСсылка) КАК НомерГТД
	|ПОМЕСТИТЬ ТаблицаТоваров
	|ИЗ
	|	&ТаблицаТоваров КАК ТаблицаТоваров
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаВидыЗапасов.НомерСтроки КАК НомерСтроки,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ТаблицаВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.НомерГТД КАК НомерГТД,
	|	ТаблицаВидыЗапасов.Количество КАК Количество,
	|	ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка) КАК СкладОтгрузки,
	|	&Склад КАК Склад,
	|	&Сделка КАК Сделка,
	|	&ВидыЗапасовУказаныВручную КАК ВидыЗапасовУказаныВручную
	|	
	|ПОМЕСТИТЬ ТаблицаВидыЗапасов
	|ИЗ
	|	&ТаблицаВидыЗапасов КАК ТаблицаВидыЗапасов";
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Склад", Склад);
	Запрос.УстановитьПараметр("Сделка", Сделка);
	Запрос.УстановитьПараметр("Менеджер", Менеджер);
	Запрос.УстановитьПараметр("Подразделение", Подразделение);
	Запрос.УстановитьПараметр("Предназначение", Предназначение);
	Запрос.УстановитьПараметр("ВидыЗапасовУказаныВручную", ВидыЗапасовУказаныВручную);
	Запрос.УстановитьПараметр("ТаблицаТоваров", Товары);
	Запрос.УстановитьПараметр("ТаблицаВидыЗапасов", ВидыЗапасов);
	
	ЗапасыСервер.ДополнитьВременныеТаблицыОбязательнымиКолонками(Запрос);
	
	Запрос.Выполнить();
	
	Возврат МенеджерВременныхТаблиц;
	
КонецФункции

Процедура СформироватьВременнуюТаблицуТоваровИАналитики(МенеджерВременныхТаблиц) Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ТаблицаТоваров.АналитикаУчетаНоменклатуры,
	|	ТаблицаТоваров.Номенклатура,
	|	ТаблицаТоваров.Характеристика,
	|	ВЫБОР
	|		КОГДА ТаблицаТоваров.СтатусУказанияСерий = 14
	|			ТОГДА ТаблицаТоваров.Серия
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК Серия,
	|	ТаблицаТоваров.Склад,
	|
	|	ТаблицаДанныхДокумента.Подразделение,
	|	ТаблицаДанныхДокумента.Менеджер,
	|	ТаблицаДанныхДокумента.Сделка,
	|	ТаблицаТоваров.Назначение КАК Назначение,
	|
	|	ЗНАЧЕНИЕ(Справочник.Партнеры.ПустаяСсылка) КАК Партнер,
	|	ЗНАЧЕНИЕ(Справочник.СоглашенияСПоставщиками.ПустаяСсылка) КАК Соглашение,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПустаяСсылка) КАК НалогообложениеНДС,
	|
	|	ТаблицаТоваров.Количество КАК Количество
	|	
	|ПОМЕСТИТЬ ТаблицаТоваровИАналитики
	|ИЗ
	|	ТаблицаТоваров КАК ТаблицаТоваров
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ТаблицаДанныхДокумента КАК ТаблицаДанныхДокумента
	|	ПО
	|		ИСТИНА
	|;
	|");
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ЗаполнитьВидыЗапасов(Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	МенеджерВременныхТаблиц = ВременныеТаблицыДанныхДокумента();
	ПерезаполнитьВидыЗапасов = ЗапасыСервер.ПроверитьНеобходимостьПерезаполненияВидовЗапасовДокумента(ЭтотОбъект);
	
	Если Не Проведен
	 ИЛИ ПерезаполнитьВидыЗапасов
	 ИЛИ ПроверитьИзменениеРеквизитовДокумента(МенеджерВременныхТаблиц)
	 ИЛИ ЗапасыСервер.ПроверитьИзменениеТоваровПоКоличеству(МенеджерВременныхТаблиц) Тогда
	 	ПараметрыЗаполнения = ПараметрыЗаполненияВидовЗапасов();
		
		ЗапасыСервер.ЗаполнитьВидыЗапасовПоТоварамОрганизаций(ЭтотОбъект,
										МенеджерВременныхТаблиц,
										Отказ,
										ПараметрыЗаполнения);
		ВидыЗапасов.Свернуть("АналитикаУчетаНоменклатуры, ВидЗапасов, НомерГТД", "Количество");
		
		ЗаполнитьВидЗапасовОприходование();
	КонецЕсли;
	
КонецПроцедуры

// Заполняет аналитики учета номенклатуры. Используется в отчете ОстаткиТоваровОрганизаций.
Процедура ЗаполнитьАналитикиУчетаНоменклатуры() Экспорт
	
	МестаУчета = РегистрыСведений.АналитикаУчетаНоменклатуры.МестаУчета(Перечисления.ХозяйственныеОперации.КорректировкаОбособленногоУчета, Склад, Подразделение, Неопределено);
	ИменаПолей = РегистрыСведений.АналитикаУчетаНоменклатуры.ИменаПолейКоллекцииПоУмолчанию();
	ИменаПолей.Назначение = "";
	РегистрыСведений.АналитикаУчетаНоменклатуры.ЗаполнитьВКоллекции(Товары, МестаУчета, ИменаПолей);

КонецПроцедуры

#КонецОбласти

#Область Прочее

Процедура СформироватьСписокРегистровДляКонтроля()
	Массив = Новый Массив;
	// Приходы в регистр (сторно расхода из регистра) контролируем при перепроведении и отмене проведения.
	Если Не ДополнительныеСвойства.ЭтоНовый Тогда
		Массив.Добавить(Движения.ТоварыОрганизаций);
	КонецЕсли;
	
	ДополнительныеСвойства.ДляПроведения.Вставить("РегистрыДляКонтроля", Массив);
КонецПроцедуры

Функция ПроверитьИзменениеРеквизитовДокумента(МенеджерВременныхТаблиц)
	
	ИменаРеквизитов = "Организация, Склад";
	
	Возврат ЗапасыСервер.ПроверитьИзменениеРеквизитовДокумента(МенеджерВременныхТаблиц, Ссылка, ИменаРеквизитов);
	
КонецФункции

Процедура ЗаполнитьВидЗапасовОприходование()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТаблицаВидыЗапасов.НомерСтроки,
	|	ВЫРАЗИТЬ(ТаблицаВидыЗапасов.ВидЗапасов КАК Справочник.ВидыЗапасов) КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.НомерГТД,
	|	ТаблицаВидыЗапасов.Количество,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры
	|ПОМЕСТИТЬ ТаблицаВидыЗапасов
	|ИЗ
	|	&ТаблицаВидыЗапасов КАК ТаблицаВидыЗапасов
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	&Организация КАК Организация,
	|	ТаблицаВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.ВидЗапасов.ТипЗапасов КАК ТипЗапасов,
	|	ТаблицаВидыЗапасов.ВидЗапасов.ВладелецТовара КАК ВладелецТовара,
	|	ТаблицаВидыЗапасов.ВидЗапасов.Соглашение КАК Соглашение,
	|	ТаблицаВидыЗапасов.ВидЗапасов.Валюта КАК Валюта,
	|	ТаблицаВидыЗапасов.ВидЗапасов.НалогообложениеНДС КАК НалогообложениеНДС,
	|	&НалогообложениеОрганизации КАК НалогообложениеОрганизации,
	|	ТаблицаВидыЗапасов.ВидЗапасов.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчета,
	|	ВЫБОР
	|		КОГДА ТаблицаВидыЗапасов.ВидЗапасов.ТипЗапасов = ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.КомиссионныйТовар)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПриемНаКомиссию)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщика)
	|	КОНЕЦ КАК ХозяйственнаяОперация,
	|	ТаблицаВидыЗапасов.НомерСтроки КАК НомерСтроки
	|ИЗ
	|	ТаблицаВидыЗапасов КАК ТаблицаВидыЗапасов
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";

	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("НовоеПодразделение", НовоеПодразделение);
	Запрос.УстановитьПараметр("НовыйМенеджер", НовыйМенеджер);
	Запрос.УстановитьПараметр("НовыйМенеджер", НовыйМенеджер);
	Запрос.УстановитьПараметр("НоваяСделка", НоваяСделка);
	Запрос.УстановитьПараметр("НовоеПредназначение", НовоеПредназначение);
	Запрос.УстановитьПараметр("НалогообложениеОрганизации", Справочники.Организации.НалогообложениеНДС(Организация, Неопределено, Дата));
	Запрос.УстановитьПараметр("ТаблицаВидыЗапасов", ВидыЗапасов);
	
	СоответствиеВидовЗапасов = Новый Соответствие;

	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		СтрокаТЧ = ВидыЗапасов[Выборка.НомерСтроки - 1];
		
		ВидЗапасовОприходование = СоответствиеВидовЗапасов.Получить(СтрокаТЧ.ВидЗапасов);
		
		Если ВидЗапасовОприходование = Неопределено Тогда
			ВидЗапасовОприходование = Справочники.ВидыЗапасов.ВидЗапасовДокумента(Выборка.Организация, Выборка.ХозяйственнаяОперация, Выборка);
			СоответствиеВидовЗапасов.Вставить(СтрокаТЧ.ВидЗапасов, ВидЗапасовОприходование);
		КонецЕсли;
		
		СтрокаТЧ.ВидЗапасовОприходование = ВидЗапасовОприходование;
			
	КонецЦикла;
	
КонецПроцедуры 

Функция ПараметрыЗаполненияВидовЗапасов()
	
	ПараметрыЗаполнения = ЗапасыСервер.ПараметрыЗаполненияВидовЗапасов();
	ПараметрыЗаполнения.ДокументДелаетИПриходИРасход = Истина;
	ПараметрыЗаполнения.ПодбиратьВТЧТоварыПринятыеНаОтветственноеХранение = "Никогда";

	Возврат ПараметрыЗаполнения;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
