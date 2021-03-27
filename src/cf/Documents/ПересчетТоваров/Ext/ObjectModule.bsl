﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект,ДанныеЗаполнения);
	КонецЕсли;
	
	ИнициализироватьДокумент();
	
	ПересчетТоваровЛокализация.ОбработкаЗаполнения(ЭтотОбъект, ДанныеЗаполнения, СтандартнаяОбработка);

КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	УстановитьПривилегированныйРежим(Истина);
	
	НоменклатураСервер.ОчиститьНеиспользуемыеСерии(ЭтотОбъект,
														НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ПересчетТоваров));
	
	ПроведениеСерверУТ.УстановитьРежимПроведения(ЭтотОбъект,  РежимЗаписи, РежимПроведения);
	
	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
		
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		Если РежимПроведения = РежимПроведенияДокумента.Оперативный Тогда
			Дата = ПолучитьОперативнуюОтметкуВремени();
		КонецЕсли;
		
		ПрошлыйСтатус = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Статус");
		
		Если (НЕ ЗначениеЗаполнено(ПрошлыйСтатус) 
				ИЛИ ПрошлыйСтатус = Перечисления.СтатусыПересчетовТоваров.Подготовлено)
			И (Статус = Перечисления.СтатусыПересчетовТоваров.ВнесениеРезультатов
				ИЛИ Статус = Перечисления.СтатусыПересчетовТоваров.Выполнено
					И СкладыСервер.ИспользоватьСтатусыПересчетовТоваров(Склад)) Тогда
					
			Если ЗначениеЗаполнено(Ссылка) Тогда 
				ТекстСообщения = НСтр("ru = 'Невозможно провести документ ""%Документ%"" в статусе ""%НовыйСтатус%"". Необходимо сначала провести документ в статусе ""%СтатусВРаботе%"".'");
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Документ%", Ссылка);
			Иначе
				ТекстСообщения = НСтр("ru = 'Невозможно провести документ в статусе ""%НовыйСтатус%"". Необходимо сначала провести документ в статусе ""%СтатусВРаботе%"".'");
			КонецЕсли;
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НовыйСтатус%", Статус);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%СтатусВРаботе%", Перечисления.СтатусыПересчетовТоваров.ВРаботе);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,, Отказ);
			
			Если Отказ Тогда 
				Возврат;
			КонецЕсли;
			
		КонецЕсли;
		
		Если Статус = Перечисления.СтатусыПересчетовТоваров.Подготовлено
				И РежимЗаписи = РежимЗаписиДокумента.Проведение
			ИЛИ Статус = Перечисления.СтатусыПересчетовТоваров.ВРаботе
			ИЛИ Статус = Перечисления.СтатусыПересчетовТоваров.ВнесениеРезультатов Тогда
			
			Если СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, Дата) Тогда
				ПроверитьЯчейкиПередБлокировкой(Отказ);
			Иначе
				ПроверитьДругиеПересчеты(Отказ);
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не УчетныеДанныеЗаполнены 
			И Не Отказ Тогда
			ЗаполнитьКоличествоПоУчету();
		КонецЕсли;
	ИначеЕсли  РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда	
		УчетныеДанныеЗаполнены = Ложь;
	КонецЕсли;	
	
	ПересчетТоваровЛокализация.ПередЗаписью(ЭтотОбъект, Отказ, РежимЗаписи, РежимПроведения);

КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);
	
	Документы.ПересчетТоваров.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);
	
	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	ЗапасыСервер.ОтразитьТоварыКОформлениюИзлишковНедостач(ДополнительныеСвойства, Движения, Отказ);//
	СкладыСервер.ОтразитьТоварныеМестаКОтражениюИзлишковНедостач(ДополнительныеСвойства, Движения, Отказ);//
	СкладыСервер.ОтразитьТоварыВЯчейках(ДополнительныеСвойства, Движения, Отказ);
	СкладыСервер.ОтразитьБлокировкиСкладскихЯчеек(ДополнительныеСвойства, Движения, Отказ);
	СкладыСервер.ОтразитьДвиженияСерийТоваров(ДополнительныеСвойства, Движения, Отказ);//
	ЗапасыСервер.ОтразитьОбеспечениеЗаказов(ДополнительныеСвойства, Движения, Отказ);	
	ЗапасыСервер.ОтразитьТоварыНаСкладах(ДополнительныеСвойства, Движения, Отказ);
	ЗапасыСервер.ОтразитьСвободныеОстатки(ДополнительныеСвойства, Движения, Отказ);
	
	СформироватьСписокРегистровДляКонтроля();
	
	ПересчетТоваровЛокализация.ОбработкаПроведения(ЭтотОбъект, Отказ, РежимПроведения);

	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	ПроведениеСерверУТ.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	ПроведениеСерверУТ.ЗаписатьПодчиненныеНаборамЗаписейДанные(ЭтотОбъект, Отказ);
	
	РегистрыСведений.СостоянияЗаказовКлиентов.ОтразитьСостояниеЗаказа(ЭтотОбъект, Отказ);
	
	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);
	
	СкладыСервер.ОтразитьСостоянияПересчетовЯчеек(ЭтотОбъект.Ссылка, ЭтотОбъект.Статус, Отказ);
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	СформироватьСписокРегистровДляКонтроля();
	ПересчетТоваровЛокализация.ОбработкаУдаленияПроведения(ЭтотОбъект, Отказ);

	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	ПроведениеСерверУТ.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	ПроведениеСерверУТ.ЗаписатьПодчиненныеНаборамЗаписейДанные(ЭтотОбъект, Отказ);
	
	РегистрыСведений.СостоянияЗаказовКлиентов.ОтразитьСостояниеЗаказа(ЭтотОбъект, Отказ);
	
	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)

	УчетныеДанныеЗаполнены = Ложь;
	
	ИнициализироватьДокумент();

	ПересчетТоваровЛокализация.ПриКопировании(ЭтотОбъект, ОбъектКопирования);

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если НЕ Проведен
			И (Статус = Перечисления.СтатусыПересчетовТоваров.ВнесениеРезультатов
	 	ИЛИ Статус = Перечисления.СтатусыПересчетовТоваров.Выполнено)
	 		И СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, Дата) Тогда
		
		ТекстСообщения = НСтр("ru = 'Нельзя проводить документ сразу в статусе ""%ТекущийСтатус%"". Необходимо сначала провести документ в предыдущем статусе.'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ТекущийСтатус%",Статус);
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект, "Статус", "Объект", Отказ);
		
	КонецЕсли;
	
	ПараметрыПроверки = ОбщегоНазначенияУТ.ПараметрыПроверкиЗаполненияКоличества();
	ПараметрыПроверки.СуффиксДопРеквизита = "Факт";
	ПараметрыПроверки.ПроверитьВозможностьОкругления = Ложь;
	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ, ПараметрыПроверки);
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если НЕ СкладыСервер.ИспользоватьСкладскиеПомещения(Склад,Дата) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Помещение");
	КонецЕсли;
	
	Если НЕ ИспользоватьОтдельнуюЯчейкуИзлишков Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ЯчейкаКонсолидацииИзлишковТоваров");
	КонецЕсли;
	Если НЕ ИспользоватьОтдельнуюЯчейкуПорчи Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ЯчейкаКонсолидацииИспорченныхТоваров");
	КонецЕсли;
	
	ИспользоватьАдресноеХранение = СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, Дата);
	
	Если Не ИспользоватьАдресноеХранение Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Ячейка");
		
	ИначеЕсли Не ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры") Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
		
		ТекстСообщения = НСтр("ru='В настройках программы не включено использование упаковок номенклатуры, 
			|поэтому нельзя оформить документ по складу с адресным хранением остатков. Обратитесь к администратору'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,,Отказ);
	Иначе
		НоменклатураСервер.ПроверитьЗаполнениеУпаковок(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ)
	КонецЕсли;
	
	Если ИспользоватьАдресноеХранение Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Номенклатура");
		
	КонецЕсли;
	
	Если НЕ УчетныеДанныеЗаполнены Тогда
		
		КлючевыеРеквизиты = Новый Массив;
		КлючевыеРеквизиты.Добавить("Номенклатура");
		КлючевыеРеквизиты.Добавить("Характеристика");
		КлючевыеРеквизиты.Добавить("Назначение");
		КлючевыеРеквизиты.Добавить("Серия");
		КлючевыеРеквизиты.Добавить("Ячейка");
		КлючевыеРеквизиты.Добавить("Упаковка");
		
		ОбщегоНазначенияУТ.ПроверитьНаличиеДублейСтрокТЧ(ЭтотОбъект, "Товары", КлючевыеРеквизиты, Отказ)
		
	КонецЕсли;
	
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(
		ЭтотОбъект,
		МассивНепроверяемыхРеквизитов,
		Отказ);
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект,
												НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.ПересчетТоваров),
												Отказ,
												МассивНепроверяемыхРеквизитов);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);

	ПересчетТоваровЛокализация.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент()

	Дата          = ТекущаяДатаСеанса();
	Ответственный = Пользователи.ТекущийПользователь();
	
	Склад = ЗначениеНастроекПовтИсп.ПолучитьСкладПоУмолчанию(Склад);
	
	ИспользуетсяАдресноеХранение = СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение);
	ИспользоватьСтатусыПересчетовТоваров = СкладыСервер.ИспользоватьСтатусыПересчетовТоваров(Склад);
	Если Не ИспользоватьСтатусыПересчетовТоваров Тогда
		Статус = Перечисления.СтатусыПересчетовТоваров.Выполнено;
	ИначеЕсли ИспользуетсяАдресноеХранение Тогда
		Статус = Перечисления.СтатусыПересчетовТоваров.Подготовлено;
	Иначе
		Статус = Перечисления.СтатусыПересчетовТоваров.ВРаботе;
	КонецЕсли;
	
	СтруктураЯчеек = Документы.ПересчетТоваров.ПолучитьЯчейкиИзлишковИБракаПоУмолчанию(Ссылка, Склад, Помещение);
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, СтруктураЯчеек);

	ПечататьКоличествоПоУчету = Документы.ПересчетТоваров.ПолучитьЗначениеПризнакаПечататьКоличествоПоУчетуПоУмолчанию(Ссылка, Ответственный);
	
КонецПроцедуры

Процедура ЗаполнитьКоличествоПоУчету()
	
	Запрос = Новый Запрос;
	
	Если СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, Дата) Тогда
		Запрос.Текст =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура КАК Номенклатура,
		|	Таблица.Упаковка КАК Упаковка,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Назначение КАК Назначение,
		|	Таблица.Серия КАК Серия,
		|	Таблица.Ячейка КАК Ячейка,
		|	Таблица.КоличествоФакт КАК КоличествоФакт,
		|	Таблица.КоличествоУпаковокФакт КАК КоличествоУпаковокФакт,
		|	Таблица.НомерСтроки
		|ПОМЕСТИТЬ ТаблицаНоменклатуры
		|ИЗ
		|	&ТаблицаНоменклатуры КАК Таблица
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицаТоваровСОстатками.Ячейка,
		|	ТаблицаТоваровСОстатками.Номенклатура,
		|	ТаблицаТоваровСОстатками.Характеристика,
		|	ТаблицаТоваровСОстатками.Назначение,
		|	ТаблицаТоваровСОстатками.Упаковка,
		|	ТаблицаТоваровСОстатками.Серия КАК Серия,
		|	СУММА(ТаблицаТоваровСОстатками.КоличествоУпаковок) КАК КоличествоУпаковок,
		|	СУММА(ТаблицаТоваровСОстатками.Количество) КАК Количество,
		|	СУММА(ТаблицаТоваровСОстатками.КоличествоФакт) КАК КоличествоФакт,
		|	СУММА(ТаблицаТоваровСОстатками.КоличествоУпаковокФакт) КАК КоличествоУпаковокФакт
		|ПОМЕСТИТЬ ТаблицаТоваровСОстатками
		|ИЗ
		|	(ВЫБРАТЬ
		|		ТаблицаНоменклатуры.Ячейка КАК Ячейка,
		|		ТаблицаНоменклатуры.Номенклатура КАК Номенклатура,
		|		ТаблицаНоменклатуры.Характеристика КАК Характеристика,
		|		ТаблицаНоменклатуры.Назначение КАК Назначение,
		|		ТаблицаНоменклатуры.Упаковка КАК Упаковка,
		|		ТаблицаНоменклатуры.Серия КАК Серия,
		|		0 КАК КоличествоУпаковок,
		|		0 КАК Количество,
		|		ТаблицаНоменклатуры.КоличествоФакт КАК КоличествоФакт,
		|		ТаблицаНоменклатуры.КоличествоУпаковокФакт КАК КоличествоУпаковокФакт
		|	ИЗ
		|		ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
		|	ГДЕ
		|		ТаблицаНоменклатуры.Номенклатура <> ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ РАЗЛИЧНЫЕ
		|		ТаблицаНоменклатуры.Ячейка,
		|		ЕСТЬNULL(ТоварыВЯчейкахОстатки.Номенклатура, ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)),
		|		ЕСТЬNULL(ТоварыВЯчейкахОстатки.Характеристика, ЗНАЧЕНИЕ(Справочник.ХарактеристикиНоменклатуры.ПустаяСсылка)),
		|		ЕСТЬNULL(ТоварыВЯчейкахОстатки.Назначение, ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)),
		|		ЕСТЬNULL(ТоварыВЯчейкахОстатки.Упаковка, ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)),
		|		ЕСТЬNULL(ТоварыВЯчейкахОстатки.Серия, ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка)),
		|		ЕСТЬNULL(ТоварыВЯчейкахОстатки.ВНаличииОстаток, 0),
		|		ВЫБОР
		|			КОГДА ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки, 0) = 0
		|				ТОГДА ЕСТЬNULL(ТоварыВЯчейкахОстатки.ВНаличииОстаток, 0)
		|			ИНАЧЕ ЕСТЬNULL(ТоварыВЯчейкахОстатки.ВНаличииОстаток, 0) * &ТекстЗапросаКоэффициентУпаковки
		|		КОНЕЦ,
		|		0,
		|		0
		|	ИЗ
		|		ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
		|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыВЯчейках.Остатки(&ДатаОстатков, ) КАК ТоварыВЯчейкахОстатки
		|			ПО (ТоварыВЯчейкахОстатки.Ячейка = ТаблицаНоменклатуры.Ячейка)
		|				И (ВЫБОР
		|					КОГДА ТаблицаНоменклатуры.Номенклатура = ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|						ТОГДА ИСТИНА
		|					ИНАЧЕ ТоварыВЯчейкахОстатки.Номенклатура = ТаблицаНоменклатуры.Номенклатура
		|				КОНЕЦ)
		|				И (ВЫБОР
		|					КОГДА ТаблицаНоменклатуры.Номенклатура = ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|						ТОГДА ИСТИНА
		|					ИНАЧЕ ТоварыВЯчейкахОстатки.Характеристика = ТаблицаНоменклатуры.Характеристика
		|				КОНЕЦ)
		|				И (ВЫБОР
		|					КОГДА ТаблицаНоменклатуры.Номенклатура = ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|						ТОГДА ИСТИНА
		|					ИНАЧЕ ТоварыВЯчейкахОстатки.Назначение = ТаблицаНоменклатуры.Назначение
		|				КОНЕЦ)
		|				И (ВЫБОР
		|					КОГДА ТаблицаНоменклатуры.Номенклатура = ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|						ТОГДА ИСТИНА
		|					ИНАЧЕ ТоварыВЯчейкахОстатки.Серия = ТаблицаНоменклатуры.Серия
		|				КОНЕЦ)
		|				И (ВЫБОР
		|					КОГДА ТаблицаНоменклатуры.Номенклатура = ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|						ТОГДА ИСТИНА
		|					ИНАЧЕ ТоварыВЯчейкахОстатки.Упаковка = ТаблицаНоменклатуры.Упаковка
		|				КОНЕЦ)
		|	ГДЕ
		|		(ТаблицаНоменклатуры.Номенклатура = ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|				ИЛИ ТаблицаНоменклатуры.Номенклатура <> ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
		|					И НЕ(ТоварыВЯчейкахОстатки.Номенклатура ЕСТЬ NULL 
		|							И ТоварыВЯчейкахОстатки.Характеристика ЕСТЬ NULL 
		|							И ТоварыВЯчейкахОстатки.Назначение ЕСТЬ NULL
		|							И ТоварыВЯчейкахОстатки.Упаковка ЕСТЬ NULL 
		|							И ТоварыВЯчейкахОстатки.Серия ЕСТЬ NULL ))) КАК ТаблицаТоваровСОстатками
		|
		|СГРУППИРОВАТЬ ПО
		|	ТаблицаТоваровСОстатками.Ячейка,
		|	ТаблицаТоваровСОстатками.Упаковка,
		|	ТаблицаТоваровСОстатками.Характеристика,
		|	ТаблицаТоваровСОстатками.Назначение,
		|	ТаблицаТоваровСОстатками.Номенклатура,
		|	ТаблицаТоваровСОстатками.Серия
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицаТоваровСОстатками.Номенклатура КАК Номенклатура,
		|	ТаблицаТоваровСОстатками.Характеристика КАК Характеристика,
		|	ТаблицаТоваровСОстатками.Назначение КАК Назначение,
		|	ТаблицаТоваровСОстатками.Упаковка КАК Упаковка,
		|	ТаблицаТоваровСОстатками.Ячейка КАК Ячейка,
		|	ТаблицаТоваровСОстатками.Серия КАК Серия,
		|	ТаблицаТоваровСОстатками.КоличествоУпаковок,
		|	ТаблицаТоваровСОстатками.Количество,
		|	ТаблицаТоваровСОстатками.КоличествоФакт,
		|	ТаблицаТоваровСОстатками.КоличествоУпаковокФакт,
		|	ЕСТЬNULL(ТаблицаНоменклатуры.НомерСтроки, &МаксимальноВозможноеКоличествоСтрокВТЧ) КАК НомерСтроки,
		|	ЛОЖЬ КАК ИзлишекПорча
		|ИЗ
		|	ТаблицаТоваровСОстатками КАК ТаблицаТоваровСОстатками
		|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
		|		ПО ТаблицаТоваровСОстатками.Номенклатура = ТаблицаНоменклатуры.Номенклатура
		|			И ТаблицаТоваровСОстатками.Характеристика = ТаблицаНоменклатуры.Характеристика
		|			И ТаблицаТоваровСОстатками.Назначение = ТаблицаНоменклатуры.Назначение
		|			И ТаблицаТоваровСОстатками.Упаковка = ТаблицаНоменклатуры.Упаковка
		|			И ТаблицаТоваровСОстатками.Ячейка = ТаблицаНоменклатуры.Ячейка
		|			И ТаблицаТоваровСОстатками.Серия = ТаблицаНоменклатуры.Серия
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерСтроки,
		|	ВЫРАЗИТЬ(ТаблицаТоваровСОстатками.Ячейка КАК Справочник.СкладскиеЯчейки).РабочийУчасток,
		|	ВЫРАЗИТЬ(ТаблицаТоваровСОстатками.Ячейка КАК Справочник.СкладскиеЯчейки).ПорядокОбхода,
		|	ВЫРАЗИТЬ(ТаблицаТоваровСОстатками.Ячейка КАК Справочник.СкладскиеЯчейки).Код,
		|	ТаблицаТоваровСОстатками.Серия.Номер,
		|	ТаблицаТоваровСОстатками.Серия.ГоденДо";
		
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТекстЗапросаКоэффициентУпаковки",
			Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
				"ТоварыВЯчейкахОстатки.Упаковка",
				"ТоварыВЯчейкахОстатки.Номенклатура"));
		Запрос.УстановитьПараметр("ТаблицаНоменклатуры", Товары.Выгрузить());
		Запрос.УстановитьПараметр("ДатаОстатков", Дата);
		Запрос.УстановитьПараметр("МаксимальноВозможноеКоличествоСтрокВТЧ", 100000);
			
	Иначе
		Запрос.Текст =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Назначение КАК Назначение,
		|	Таблица.Серия КАК Серия,
		|	Таблица.КоличествоФакт КАК КоличествоФакт,
		|	Таблица.КоличествоУпаковокФакт КАК КоличествоУпаковокФакт,
		|	Таблица.НомерСтроки
		|ПОМЕСТИТЬ ТаблицаНоменклатуры
		|ИЗ
		|	&ТаблицаНоменклатуры КАК Таблица
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицаТоваровСОстатками.Номенклатура КАК Номенклатура,
		|	ТаблицаТоваровСОстатками.Характеристика КАК Характеристика,
		|	ТаблицаТоваровСОстатками.Назначение КАК Назначение,
		|	ТаблицаТоваровСОстатками.Серия КАК Серия,
		|	СУММА(ТаблицаТоваровСОстатками.КоличествоУпаковок) КАК КоличествоУпаковок,
		|	СУММА(ТаблицаТоваровСОстатками.Количество) КАК Количество,
		|	СУММА(ТаблицаТоваровСОстатками.КоличествоФакт) КАК КоличествоФакт,
		|	СУММА(ТаблицаТоваровСОстатками.КоличествоУпаковокФакт) КАК КоличествоУпаковокФакт
		|ПОМЕСТИТЬ ТаблицаТоваровСОстатками
		|ИЗ
		|	(ВЫБРАТЬ
		|		ТаблицаНоменклатуры.Номенклатура КАК Номенклатура,
		|		ТаблицаНоменклатуры.Характеристика КАК Характеристика,
		|		ТаблицаНоменклатуры.Назначение КАК Назначение,
		|		ТаблицаНоменклатуры.Серия КАК Серия,
		|		0 КАК КоличествоУпаковок,
		|		0 КАК Количество,
		|		ТаблицаНоменклатуры.КоличествоФакт КАК КоличествоФакт,
		|		ТаблицаНоменклатуры.КоличествоУпаковокФакт КАК КоличествоУпаковокФакт
		|	ИЗ
		|		ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ
		|		ТоварыНаСкладахОстатки.Номенклатура,
		|		ТоварыНаСкладахОстатки.Характеристика,
		|		ТоварыНаСкладахОстатки.Назначение,
		|		ТоварыНаСкладахОстатки.Серия,
		|		ТоварыНаСкладахОстатки.ВНаличииОстаток,
		|		ТоварыНаСкладахОстатки.ВНаличииОстаток,
		|		0,
		|		0
		|	ИЗ
		|		РегистрНакопления.ТоварыНаСкладах.Остатки(
		|				&ДатаОстатков,
		|				(Номенклатура, Характеристика, Назначение, Склад, Помещение) В
		|					(ВЫБРАТЬ
		|						Таблица.Номенклатура,
		|						Таблица.Характеристика,
		|						Таблица.Назначение,
		|						&Склад,
		|						&Помещение
		|					ИЗ
		|						ТаблицаНоменклатуры КАК Таблица)) КАК ТоварыНаСкладахОстатки) КАК ТаблицаТоваровСОстатками
		|
		|СГРУППИРОВАТЬ ПО
		|	ТаблицаТоваровСОстатками.Номенклатура,
		|	ТаблицаТоваровСОстатками.Характеристика,
		|	ТаблицаТоваровСОстатками.Назначение,
		|	ТаблицаТоваровСОстатками.Серия
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицаТоваровСОстатками.Номенклатура,
		|	ТаблицаТоваровСОстатками.Характеристика,
		|	ТаблицаТоваровСОстатками.Назначение,
		|	ТаблицаТоваровСОстатками.Серия КАК Серия,
		|	ТаблицаТоваровСОстатками.КоличествоУпаковок КАК КоличествоУпаковок,
		|	ТаблицаТоваровСОстатками.Количество КАК Количество,
		|	ТаблицаТоваровСОстатками.КоличествоФакт КАК КоличествоФакт,
		|	ТаблицаТоваровСОстатками.КоличествоУпаковокФакт КАК КоличествоУпаковокФакт,
		|	ТаблицаНоменклатуры.НомерСтроки КАК НомерСтроки,
		|	ЛОЖЬ КАК ИзлишекПорча
		|ИЗ
		|	ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТаблицаТоваровСОстатками КАК ТаблицаТоваровСОстатками
		|		ПО ТаблицаНоменклатуры.Номенклатура = ТаблицаТоваровСОстатками.Номенклатура
		|			И ТаблицаНоменклатуры.Характеристика = ТаблицаТоваровСОстатками.Характеристика
		|			И ТаблицаНоменклатуры.Серия = ТаблицаТоваровСОстатками.Серия
		|			И ТаблицаНоменклатуры.Назначение = ТаблицаТоваровСОстатками.Назначение
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерСтроки,
		|	ТаблицаТоваровСОстатками.Серия.Номер,
		|	ТаблицаТоваровСОстатками.Серия.ГоденДо";
		
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		Запрос.УстановитьПараметр("Склад", Склад);
		Запрос.УстановитьПараметр("Помещение", Помещение);
		Запрос.УстановитьПараметр("ТаблицаНоменклатуры", Товары.Выгрузить());
		Запрос.УстановитьПараметр("ДатаОстатков", Дата);
	КонецЕсли;	
	
	Товары.Загрузить(Запрос.Выполнить().Выгрузить());
	
	НоменклатураСервер.ЗаполнитьСтатусыУказанияСерий(ЭтотОбъект,
НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, 		Документы.ПересчетТоваров));
	
	УчетныеДанныеЗаполнены = Истина;
КонецПроцедуры

#КонецОбласти

#Область Прочее

Процедура ПроверитьЯчейкиПередБлокировкой(Отказ)
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.БлокировкиСкладскихЯчеек");
	ЭлементБлокировки.Режим          = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.ИсточникДанных = Товары;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Ячейка", "Ячейка");
	
	ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.ТоварыВЯчейках");
	ЭлементБлокировки.Режим          = РежимБлокировкиДанных.Исключительный;   
	ЭлементБлокировки.ИсточникДанных = Товары;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Ячейка", "Ячейка");
	
	Блокировка.Заблокировать();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаНоменклатуры.Ячейка КАК Ячейка,
	|	ТаблицаНоменклатуры.НомерСтроки КАК НомерСтроки
	|ПОМЕСТИТЬ ТаблицаЯчеекДляЗапроса
	|ИЗ
	|	&ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫРАЗИТЬ(ТаблицаЯчеекДляЗапроса.Ячейка КАК Справочник.СкладскиеЯчейки) КАК Ячейка,
	|	МИНИМУМ(ТаблицаЯчеекДляЗапроса.НомерСтроки) КАК НомерСтроки
	|ПОМЕСТИТЬ ТаблицаЯчеек
	|ИЗ
	|	ТаблицаЯчеекДляЗапроса КАК ТаблицаЯчеекДляЗапроса
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаЯчеекДляЗапроса.Ячейка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаЯчеек.Ячейка КАК Ячейка,
	|	ТаблицаЯчеек.Ячейка.ТипСкладскойЯчейки КАК ТипСкладскойЯчейки,
	|	ТаблицаЯчеек.НомерСтроки,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТоварыВЯчейкахОстатки.КОтборуОстаток, 0) <> 0
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ЕстьЗаданияНаОтбор,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТоварыВЯчейкахОстатки.КРазмещениюОстаток, 0) <> 0
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ЕстьЗаданияНаРазмещение,
	|	ВЫБОР
	|		КОГДА БлокировкиСкладскихЯчеек.ТипБлокировки ЕСТЬ NULL 
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ЕстьБлокировкиПоЯчейке
	|ИЗ
	|	ТаблицаЯчеек КАК ТаблицаЯчеек
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыВЯчейках.Остатки(
	|				,
	|				Ячейка В
	|					(ВЫБРАТЬ
	|						ТаблицаЯчеек.Ячейка КАК Ячейка
	|					ИЗ
	|						ТаблицаЯчеек КАК ТаблицаЯчеек)) КАК ТоварыВЯчейкахОстатки
	|		ПО ТаблицаЯчеек.Ячейка = ТоварыВЯчейкахОстатки.Ячейка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.БлокировкиСкладскихЯчеек КАК БлокировкиСкладскихЯчеек
	|		ПО (ТаблицаЯчеек.Ячейка = БлокировкиСкладскихЯчеек.Ячейка
	|				И БлокировкиСкладскихЯчеек.Регистратор <> &Ссылка)
	|ГДЕ
	|	(ЕСТЬNULL(ТоварыВЯчейкахОстатки.КОтборуОстаток, 0) <> 0
	|			ИЛИ ЕСТЬNULL(ТоварыВЯчейкахОстатки.КРазмещениюОстаток, 0) <> 0
	|			ИЛИ (НЕ БлокировкиСкладскихЯчеек.ТипБлокировки ЕСТЬ NULL ))
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ячейка";
	Запрос.УстановитьПараметр("ТаблицаНоменклатуры", Товары.Выгрузить());
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ТекстСообщения = НСтр("ru='Невозможно заблокировать %ТипЯчейки% %Ячейка%:
		|%Причина%'");
		Если Выборка.ЕстьБлокировкиПоЯчейке Тогда
			ТекстПричины = НСтр("ru='ячейка заблокирована другим документом'");
		Иначе
			ТекстПричины = "";
			Если Выборка.ЕстьЗаданияНаОтбор <> 0 Тогда
				ТекстПричины = НСтр("ru='есть невыполненные задания на отбор товара из ячейки'");
			КонецЕсли;
			Если Выборка.ЕстьЗаданияНаРазмещение <> 0 Тогда
				Если ЗначениеЗаполнено(ТекстПричины) Тогда
					ТекстПричины = ТекстПричины + ";
						|"
				КонецЕсли;
				ТекстПричины = ТекстПричины + НСтр("ru='есть невыполненные задания на размещение в ячейку'");
				Если Выборка.ТипСкладскойЯчейки = Перечисления.ТипыСкладскихЯчеек.Отгрузка Тогда
					ТекстПричины = ТекстПричины + " " + НСтр("ru='или есть расходные ордера (ордера на перемещение) в неокончательном статусе с неотгружаемыми товарами, размещаемыми в эту зону отгрузки'");
				КонецЕсли;
			КонецЕсли;
			
		КонецЕсли;
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ТипЯчейки%",
			?(Выборка.ТипСкладскойЯчейки = Перечисления.ТипыСкладскихЯчеек.Отгрузка, НСтр("ru='зону отгрузки'"),
				?(Выборка.ТипСкладскойЯчейки = Перечисления.ТипыСкладскихЯчеек.Приемка, НСтр("ru='зону приемки'"),
					НСтр("ru='ячейку'"))));
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ТекстПричины);
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ячейка%", Выборка.Ячейка);
		
		Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", Выборка.НомерСтроки, "Ячейка");
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект,Поле,"Объект",Отказ);
	КонецЦикла;
КонецПроцедуры

Процедура ПроверитьДругиеПересчеты(Отказ)
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.ТоварыКОформлениюИзлишковНедостач");
	
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
	ЭлементБлокировки.УстановитьЗначение("Склад", Склад);
	ЭлементБлокировки.ИсточникДанных = Товары;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Номенклатура", "Номенклатура");
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Характеристика", "Характеристика");
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Серия", "Серия");
	
	СтатусБыл = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Статус");
	
	Если Статус = Перечисления.СтатусыПересчетовТоваров.Выполнено
		ИЛИ СтатусБыл = Перечисления.СтатусыПересчетовТоваров.Выполнено Тогда
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	Иначе
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
	КонецЕсли;
	
	Блокировка.Заблокировать();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаТовары.Номенклатура,
	|	ТаблицаТовары.Характеристика,
	|	ТаблицаТовары.Серия,
	|	ТаблицаТовары.НомерСтроки
	|ПОМЕСТИТЬ ВТТаблицаТовары
	|ИЗ
	|	&ТаблицаТовары КАК ТаблицаТовары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТТаблицаТовары.НомерСтроки
	|ИЗ
	|	Документ.ПересчетТоваров.Товары КАК ПересчетТоваровТовары
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТТаблицаТовары КАК ВТТаблицаТовары
	|		ПО (ВТТаблицаТовары.Номенклатура = ПересчетТоваровТовары.Номенклатура)
	|			И (ВТТаблицаТовары.Характеристика = ПересчетТоваровТовары.Характеристика)
	|			И (ВТТаблицаТовары.Серия = ПересчетТоваровТовары.Серия)
	|ГДЕ
	|	ПересчетТоваровТовары.Ссылка.Склад = &Склад
	|	И ПересчетТоваровТовары.Ссылка.Помещение = &Помещение
	|	И ПересчетТоваровТовары.Ссылка.Проведен
	|	И НЕ ПересчетТоваровТовары.Ссылка = &Ссылка
	|	И ПересчетТоваровТовары.Ссылка.Статус В (ЗНАЧЕНИЕ(Перечисление.СтатусыПересчетовТоваров.ВРаботе), ЗНАЧЕНИЕ(Перечисление.СтатусыПересчетовТоваров.ВнесениеРезультатов))
	|
	|СГРУППИРОВАТЬ ПО
	|	ВТТаблицаТовары.НомерСтроки";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Склад", Склад);
	Запрос.УстановитьПараметр("Помещение", Помещение);
	Запрос.УстановитьПараметр("ТаблицаТовары", Товары.Выгрузить());
	
	МассивРезультатовЗапроса = Запрос.ВыполнитьПакет();
	ВыборкаПересчеты = МассивРезультатовЗапроса[1].Выбрать();
	Пока ВыборкаПересчеты.Следующий() Цикл
		ТекстСообщения = НСтр("ru = 'Товар в строке %НомерСтроки% уже включен в пересчеты товаров в статусе ""В работе"" или ""Внесение результатов"" на этом же складе (помещении).'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", ВыборкаПересчеты.НомерСтроки);
		Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", ВыборкаПересчеты.НомерСтроки, "НомерСтроки");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект,Поле,"Объект",Отказ);
	КонецЦикла;
		
КонецПроцедуры

Процедура СформироватьСписокРегистровДляКонтроля()

	Массив = Новый Массив;

	ДополнительныеСвойства.ДляПроведения.Вставить("РегистрыДляКонтроля", Массив);

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
