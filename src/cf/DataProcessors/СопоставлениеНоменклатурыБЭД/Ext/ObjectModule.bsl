﻿////////////////////////////////////////////////////////////////////////////////
// Модуль объекта Обработка.СопоставлениеНоменклатурыБЭД
//  
////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Находит и помещает варианты сопоставления номенклатуры во временное хранилище.
// Используется для поиска вариантов в фоном режиме.
//
// Параметры:
//  Параметры - Структура - параметры поиска вариантов:
//   * НаборНоменклатурыКонтрагентов - Массив из Структура- набор номенклатуры контрагентов, для которой нужно найти варианты.
//                                              См. ОбменСКонтрагентамиСлужебныйКлиентСервер.НоваяНоменклатураКонтрагента.
//  АдресРезультата - Строка - адрес во временном хранилище, по которому будут помещены найденные варианты.
//
Процедура НайтиВариантыСопоставленияНоменклатуры(Параметры, АдресРезультата) Экспорт
	
	НаборНоменклатурыКонтрагентов = Параметры.НаборНоменклатурыКонтрагентов;
	ИспользоватьСервис            = Параметры.ИспользоватьСервис;
	
	ТаблицаНоменклатурыКонтрагентов = ОбменСКонтрагентамиСлужебный.ПреобразоватьНаборНоменклатурыКонтрагентовВТаблицу(НаборНоменклатурыКонтрагентов);
	
	Если ИспользоватьСервис Тогда
		НайтиВариантыСопоставленияНоменклатурыПоИдентификаторам(ТаблицаНоменклатурыКонтрагентов);
	КонецЕсли;
	
	НайденныеВарианты = ОбменСКонтрагентамиСлужебный.ПодобратьВариантыСопоставленияНоменклатуры(
		ТаблицаНоменклатурыКонтрагентов, Параметры.ПроцентТочностиПоискаНоменклатуры, Параметры.ТребуетсяПоискНоменклатуры);
		
	Если НЕ Параметры.Свойство("ТаблицаВариантовСопоставления") Тогда
		ТаблицаВариантовСопоставления = НоваяТаблицаВариантовСопоставления();
	Иначе
		ТаблицаВариантовСопоставления = Параметры.ТаблицаВариантовСопоставления;
	КонецЕсли;
	
	ТаблицаСопоставления = Параметры.ТаблицаСопоставления;
	
	СопоставленоАвтоматически = 0;
	ОбработатьНайденныеВариантыСопоставления(НайденныеВарианты, ТаблицаСопоставления, ТаблицаВариантовСопоставления,
		СопоставленоАвтоматически, Параметры.ПолныйПоиск, Параметры.ТребуетсяПоискНоменклатуры);
	
	СтруктураРезультата = Новый Структура;
	СтруктураРезультата.Вставить("ТаблицаВариантовСопоставления", ТаблицаВариантовСопоставления);
	СтруктураРезультата.Вставить("ТаблицаСопоставления"         , ТаблицаСопоставления);
	СтруктураРезультата.Вставить("СопоставленоАвтоматически"    , СопоставленоАвтоматически);

	ПоместитьВоВременноеХранилище(СтруктураРезультата, АдресРезультата);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Поиск номенклатуры в сервисе 1С:Номенклатура по идентификаторам для последующего сопоставления.
//
// Параметры:
//  НаборНоменклатурыКонтрагентов - Массив из Структура- набор номенклатуры контрагентов, для которой нужно найти варианты.
//                                              См. ОбменСКонтрагентамиСлужебныйКлиентСервер.НоваяНоменклатураКонтрагента.
//
Процедура НайтиВариантыСопоставленияНоменклатурыПоИдентификаторам(ТаблицаНоменклатурыКонтрагентов)
	
	ИдентификаторыОбъектов = Новый Массив;
	
	Для Каждого ЭлементКоллекции Из ТаблицаНоменклатурыКонтрагентов Цикл
		
		Если НЕ ЗначениеЗаполнено(ЭлементКоллекции.ИдентификаторНоменклатурыСервиса) Тогда
			Продолжить;
		КонецЕсли;
		
		ИдентификаторыОбъектов.Добавить(
			Новый Структура("ИдентификаторНоменклатуры, ИдентификаторХарактеристики",
			ЭлементКоллекции.ИдентификаторНоменклатурыСервиса, ЭлементКоллекции.ИдентификаторХарактеристикиСервиса));
	КонецЦикла;

	НайденныеСсылки = Новый Массив;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЭлектронноеВзаимодействие.РаботаСНоменклатурой") Тогда
		
		МодульРаботаСНоменклатурой = ОбщегоНазначения.ОбщийМодуль("РаботаСНоменклатурой");
		
		НайденныеСсылки = МодульРаботаСНоменклатурой.НоменклатураИХарактеристикиПоИдентификаторамСПроверкойВСервисе(ИдентификаторыОбъектов);
		
		ОбработатьВариантыСопоставленияПоИдентификаторамСервиса(НайденныеСсылки, ТаблицаНоменклатурыКонтрагентов);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьНайденныеВариантыСопоставления(Знач НайденныеВарианты, ТаблицаСопоставления,
		ТаблицаВариантовСопоставления, СопоставленоАвтоматически, Знач ПолныйПоиск, Знач ТребуетсяПоискНоменклатуры)
		
	ТаблицаСопоставления.Индексы.Добавить("Владелец,Идентификатор,Номенклатура");
	ТаблицаСопоставления.Индексы.Добавить("Владелец,Идентификатор");
		
	МетаданныеСопоставления = ОбменСКонтрагентамиСлужебный.МетаданныеСопоставленияНоменклатуры();
	
	Для Каждого ВариантСопоставления Из НайденныеВарианты Цикл
		
		ПараметрыОтбора = Новый Структура;
		ПараметрыОтбора.Вставить("Владелец"     , ВариантСопоставления.Владелец);
		ПараметрыОтбора.Вставить("Идентификатор", ВариантСопоставления.Идентификатор);
		
		ВариантыСопоставленияНоменклатурыБЭД = ВариантСопоставления.ВариантыСопоставленияНоменклатурыБЭД;

		СодержитИзменениеВариантов = Ложь;
		Если НЕ ПолныйПоиск И ТребуетсяПоискНоменклатуры
			И НЕ (ЗначениеЗаполнено(ВариантСопоставления.НоменклатураИБ)
			И ВариантыСопоставленияНоменклатурыБЭД.Количество() = 0) Тогда
			ОчиститьВариантыСопоставления(ПараметрыОтбора, ТаблицаВариантовСопоставления, ВариантыСопоставленияНоменклатурыБЭД, СодержитИзменениеВариантов);
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(ВариантСопоставления.НоменклатураИБ)
			И ВариантыСопоставленияНоменклатурыБЭД.Количество() = 0
			И НЕ СодержитИзменениеВариантов Тогда
			Продолжить;
		КонецЕсли;
		
		НоменклатураИБ = ОбменСКонтрагентамиСлужебныйКлиентСервер.НоваяНоменклатураИнформационнойБазы();
	
		ЗаполнитьТаблицуСопоставления(ТаблицаСопоставления, ВариантСопоставления, СопоставленоАвтоматически,
			НоменклатураИБ, ПараметрыОтбора, МетаданныеСопоставления);
		
		Если ЗначениеЗаполнено(ВариантыСопоставленияНоменклатурыБЭД) Тогда
			Для Каждого ВариантНоменклатуры Из ВариантыСопоставленияНоменклатурыБЭД Цикл
				ЗаполнитьВариантСопоставленияНоменклатурыБЭД(ТаблицаВариантовСопоставления, ПараметрыОтбора, ВариантСопоставления,
					НоменклатураИБ, ВариантНоменклатуры);
			КонецЦикла;
		ИначеЕсли ЗначениеЗаполнено(НоменклатураИБ.Номенклатура) Тогда
			ЗаполнитьВариантСопоставленияНоменклатурыБЭД(ТаблицаВариантовСопоставления, ПараметрыОтбора, ВариантСопоставления, НоменклатураИБ);
		КонецЕсли;
		
	КонецЦикла;
	
	ТаблицаСопоставления.Сортировать("Наименование");
	
КонецПроцедуры

Процедура ЗаполнитьВариантСопоставленияНоменклатурыБЭД(ТаблицаВариантовСопоставления, Знач ПараметрыОтбора, Знач ВариантСопоставления,
		Знач НоменклатураИБ, Знач ВариантНоменклатуры = Неопределено)
		
	Если ВариантНоменклатуры <> Неопределено Тогда
		ПоискВариантовНеТребуется = НоменклатураИБ.Номенклатура = ВариантНоменклатуры.НоменклатураИБ;
		Номенклатура              = ВариантНоменклатуры.НоменклатураИБ;
	Иначе
		ПоискВариантовНеТребуется = Истина;
		Номенклатура              = НоменклатураИБ.Номенклатура;
	КонецЕсли;
		
	ПараметрыОтбора.Вставить("Номенклатура", Номенклатура);
	НайденныеСтроки = ТаблицаВариантовСопоставления.НайтиСтроки(ПараметрыОтбора);
	
	Если ЗначениеЗаполнено(НайденныеСтроки) Тогда
		НоваяСтрока = НайденныеСтроки[0];
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ВариантСопоставления);
	ИначеЕсли ВариантНоменклатуры <> Неопределено Тогда
		НоваяСтрока = ТаблицаВариантовСопоставления.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ВариантСопоставления);
		НоваяСтрока.Номенклатура                    = Номенклатура;
		НоваяСтрока.АртикулСопоставлен              = ВариантНоменклатуры.АртикулСопоставлен;
		НоваяСтрока.ШтрихкодСопоставлен             = ВариантНоменклатуры.ШтрихкодСопоставлен;
		НоваяСтрока.ПриоритетныйВариантНоменклатуры = ВариантНоменклатуры.ПриоритетныйВариант;
	Иначе
		Возврат;
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(ВариантСопоставления.ХарактеристикаИБ) Тогда
		НоваяСтрока.Характеристика                      = НоменклатураИБ.Характеристика;
		НоваяСтрока.ВариантыСопоставленияХарактеристики = ВариантСопоставления.ВариантыСопоставленияХарактеристикиБЭД;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ВариантСопоставления.УпаковкаИБ) Тогда
		НоваяСтрока.Упаковка                      = НоменклатураИБ.Упаковка;
		НоваяСтрока.ВариантыСопоставленияУпаковки = ВариантСопоставления.ВариантыСопоставленияУпаковкиБЭД;
	КонецЕсли;
	
	НоваяСтрока.ПоискВариантовНеТребуется       = ПоискВариантовНеТребуется;
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуСопоставления(ТаблицаСопоставления, Знач ВариантСопоставления, СопоставленоАвтоматически,
		НоменклатураИБ, Знач ПараметрыОтбора, Знач МетаданныеСопоставления)
	
	КоличествоВариантовНоменклатуры   = ВариантСопоставления.ВариантыСопоставленияНоменклатурыБЭД.Количество();
	КоличествоВариантовХарактеристики = ВариантСопоставления.ВариантыСопоставленияХарактеристикиБЭД.Количество();
	КоличествоВариантовУпаковки       = ВариантСопоставления.ВариантыСопоставленияУпаковкиБЭД.Количество();
	
	ПодсказкаНайденныхВариантовНоменклатуры = "";
	Если КоличествоВариантовНоменклатуры > 0 Тогда
		ПодсказкаНайденныхВариантовНоменклатуры = МетаданныеСопоставления.НоменклатураПредставлениеОбъекта
			+ " (" + Формат(КоличествоВариантовНоменклатуры, "ЧГ=0") + ")";
	КонецЕсли;
	НоменклатураИБ.Номенклатура = ВариантСопоставления.НоменклатураИБ;
	
	ПодсказкаНайденныхВариантовХарактеристики = МетаданныеСопоставления.ХарактеристикаПредставлениеОбъекта
		+ ?(КоличествоВариантовХарактеристики > 0, " (" + Формат(КоличествоВариантовХарактеристики, "ЧГ=0") + ")", "");
	Если КоличествоВариантовХарактеристики = 1 Тогда
		НоменклатураИБ.Характеристика = ВариантСопоставления.ВариантыСопоставленияХарактеристикиБЭД[0];
	КонецЕсли;
	
	ПодсказкаНайденныхВариантовУпаковки = "";
	Если КоличествоВариантовУпаковки > 0 Тогда
		ПодсказкаНайденныхВариантовУпаковки = НСтр("ru = 'Найдено в моей базе ('") + Формат(КоличествоВариантовУпаковки, "ЧГ=0") + ")";
		Если КоличествоВариантовУпаковки = 1 Тогда
			НоменклатураИБ.Упаковка = ВариантСопоставления.ВариантыСопоставленияУпаковкиБЭД[0];
		КонецЕсли;
	КонецЕсли;
	
	СтрокиСопоставления = ТаблицаСопоставления.НайтиСтроки(ПараметрыОтбора);
	Если ЗначениеЗаполнено(СтрокиСопоставления) Тогда
		Для Каждого ЭлементСопоставления Из СтрокиСопоставления Цикл
			
			Если НЕ ЗначениеЗаполнено(ЭлементСопоставления.Номенклатура) Тогда
				ЭлементСопоставления.Номенклатура                              = НоменклатураИБ.Номенклатура;
				ЭлементСопоставления.КоличествоВариантовНоменклатуры           = КоличествоВариантовНоменклатуры;
				ЭлементСопоставления.ПодсказкаНайденныхВариантовНоменклатуры   = ПодсказкаНайденныхВариантовНоменклатуры;
			КонецЕсли;
			
			Если НЕ ЗначениеЗаполнено(ЭлементСопоставления.Характеристика) Тогда
				ЭлементСопоставления.Характеристика                            = НоменклатураИБ.Характеристика;
				ЭлементСопоставления.ПодсказкаНайденныхВариантовХарактеристики = ПодсказкаНайденныхВариантовХарактеристики;
			КонецЕсли;
			Если НЕ ЗначениеЗаполнено(ЭлементСопоставления.Упаковка) Тогда
				ЭлементСопоставления.Упаковка                                  = НоменклатураИБ.Упаковка;
				ЭлементСопоставления.ПодсказкаНайденныхВариантовУпаковки       = ПодсказкаНайденныхВариантовУпаковки;
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ЭлементСопоставления.Номенклатура) Тогда
				ЭлементСопоставления.ИспользоватьУпаковки                 = ВариантСопоставления.ИспользоватьУпаковки;
				ЭлементСопоставления.ИспользоватьХарактеристики           = ВариантСопоставления.ИспользоватьХарактеристики;
				ЭлементСопоставления.ОбязательноеЗаполнениеХарактеристики = ВариантСопоставления.ОбязательноеЗаполнениеХарактеристики;
				
				Обработки.СопоставлениеНоменклатурыБЭД.ЗаполнитьПризнакСопоставления(ЭлементСопоставления);
				Если ЭлементСопоставления.Сопоставлено Тогда
					СопоставленоАвтоматически = СопоставленоАвтоматически + 1;
				КонецЕсли;
			Иначе
				ЭлементСопоставления.ИспользоватьХарактеристики           = Ложь;
				ЭлементСопоставления.ИспользоватьУпаковки                 = Ложь;
				ЭлементСопоставления.ОбязательноеЗаполнениеХарактеристики = Ложь;
			КонецЕсли;
			
			ЭлементСопоставления.ПоискВариантовНеТребуется = Истина;
			
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОчиститьВариантыСопоставления(ПараметрыОтбора, ТаблицаВариантовСопоставления, ВариантыСопоставленияНоменклатурыБЭД, СодержитИзменениеВариантов)
	
	НайденныеСтроки = ТаблицаВариантовСопоставления.НайтиСтроки(ПараметрыОтбора);
	Для Каждого Строка Из НайденныеСтроки Цикл
		УдалитьВариант = Истина;
		Для Каждого Вариант Из ВариантыСопоставленияНоменклатурыБЭД Цикл
			Если Вариант.НоменклатураИБ = Строка.Номенклатура Тогда
				УдалитьВариант = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если УдалитьВариант Тогда
			СодержитИзменениеВариантов = Истина;
			ТаблицаВариантовСопоставления.Удалить(Строка);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьВариантыСопоставленияПоИдентификаторамСервиса(СсылкиПоИдентификаторам, ТаблицаНоменклатурыКонтрагентов)
	
	Если СсылкиПоИдентификаторам = Неопределено
		ИЛИ НЕ СсылкиПоИдентификаторам.Количество() Тогда
		Возврат;
	КонецЕсли;
	
	Результат = ПоискРазличныхСсылокПоИдентификаторамСервиса(СсылкиПоИдентификаторам);
	
	Если Результат.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	ТаблицаСсылокПоИдентификаторам = Результат.Выгрузить();
	
	ТаблицаНоменклатурыКонтрагентов.Индексы.Очистить();
	ТаблицаНоменклатурыКонтрагентов.Индексы.Добавить("ИдентификаторНоменклатурыСервиса,ИдентификаторХарактеристикиСервиса");

	Для Каждого ЭлементКоллекции Из ТаблицаСсылокПоИдентификаторам Цикл
		
		ПараметрыОтбора = Новый Структура;
		ПараметрыОтбора.Вставить("ИдентификаторНоменклатурыСервиса"  , ЭлементКоллекции.ИдентификаторНоменклатурыСервиса);
		ПараметрыОтбора.Вставить("ИдентификаторХарактеристикиСервиса", ЭлементКоллекции.ИдентификаторХарактеристикиСервиса);
		НайденныеСтроки = ТаблицаНоменклатурыКонтрагентов.НайтиСтроки(ПараметрыОтбора);
		
		Для Каждого НоменклатураКонтрагента Из НайденныеСтроки Цикл
			
			Если ЭлементКоллекции.ОбъектУдален Тогда
				НоменклатураКонтрагента.ИдентификаторНоменклатурыСервиса   = "";
				НоменклатураКонтрагента.ИдентификаторХарактеристикиСервиса = "";
			Иначе
				ПриоритетныйВариантНоменклатуры = Ложь;
				Если ЭлементКоллекции.КоличествоНоменклатур = 1
					И НЕ ЗначениеЗаполнено(НоменклатураКонтрагента.НоменклатураИБ) Тогда
					НоменклатураКонтрагента.НоменклатураИБ = ЭлементКоллекции.Номенклатура;
					ПриоритетныйВариантНоменклатуры  = Истина;
				КонецЕсли;
				
				ВариантыСопоставленияНоменклатурыБЭД = НоменклатураКонтрагента.ВариантыСопоставленияНоменклатурыБЭД;
				
				ВариантСопоставления = ОбменСКонтрагентамиСлужебный.НовыйВариантСопоставленияНоменклатурыБЭД();
				ВариантСопоставления.НоменклатураИБ      = ЭлементКоллекции.Номенклатура;
				ВариантСопоставления.ПриоритетныйВариант = ПриоритетныйВариантНоменклатуры;
				
				Если ЗначениеЗаполнено(ВариантыСопоставленияНоменклатурыБЭД) Тогда
					ЕстьВариантНоменклатуры = Ложь;
					КоличествоНоменклатур = ВариантыСопоставленияНоменклатурыБЭД.Количество() - 1;
					Для Индекс = 0 По КоличествоНоменклатур Цикл
						Вариант = ВариантыСопоставленияНоменклатурыБЭД[Индекс];
						Если ЭлементКоллекции.Номенклатура = Вариант.НоменклатураИБ Тогда
							ЕстьВариантНоменклатуры = Истина;
							ВариантыСопоставленияНоменклатурыБЭД.Удалить(Индекс);
							ВариантыСопоставленияНоменклатурыБЭД.Вставить(0, Вариант);
							Если ПриоритетныйВариантНоменклатуры Тогда
								Вариант.ПриоритетныйВариант = Истина;
							КонецЕсли;
							Прервать;
						КонецЕсли;
					КонецЦикла;
					Если НЕ ЕстьВариантНоменклатуры Тогда
						ВариантыСопоставленияНоменклатурыБЭД.Добавить(ВариантСопоставления);
					КонецЕсли;
				Иначе
					ВариантыСопоставленияНоменклатурыБЭД.Добавить(ВариантСопоставления);
				КонецЕсли;
				
				Если ЗначениеЗаполнено(ЭлементКоллекции.Характеристика) Тогда
					Если ЭлементКоллекции.КоличествоХарактеристик = 1 Тогда
						НоменклатураКонтрагента.ХарактеристикаИБ = ЭлементКоллекции.Характеристика;
					КонецЕсли;
					Если НоменклатураКонтрагента.ВариантыСопоставленияХарактеристикиБЭД.Найти(ЭлементКоллекции.Характеристика) = Неопределено Тогда
						НоменклатураКонтрагента.ВариантыСопоставленияХарактеристикиБЭД.Добавить(ЭлементКоллекции.Характеристика);
					КонецЕсли;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	ТаблицаНоменклатурыКонтрагентов.Индексы.Очистить();
	
КонецПроцедуры

Функция ПоискРазличныхСсылокПоИдентификаторамСервиса(Знач СсылкиПоИдентификаторам)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ТаблицаСсылокПоИдентификаторам", СсылкиПоИдентификаторам);
	
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТаблицаСсылокПоИдентификаторам.Номенклатура КАК Номенклатура,
		|	ТаблицаСсылокПоИдентификаторам.Характеристика КАК Характеристика,
		|	ТаблицаСсылокПоИдентификаторам.ИдентификаторНоменклатуры КАК ИдентификаторНоменклатурыСервиса,
		|	ТаблицаСсылокПоИдентификаторам.ИдентификаторХарактеристики КАК ИдентификаторХарактеристикиСервиса,
		|	ТаблицаСсылокПоИдентификаторам.ОбъектУдален КАК ОбъектУдален
		|ПОМЕСТИТЬ ТаблицыСсылок
		|ИЗ
		|	&ТаблицаСсылокПоИдентификаторам КАК ТаблицаСсылокПоИдентификаторам
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ИдентификаторНоменклатурыСервиса,
		|	ИдентификаторХарактеристикиСервиса
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицыСсылок.ИдентификаторНоменклатурыСервиса КАК ИдентификаторНоменклатурыСервиса,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ТаблицыСсылок.Номенклатура) КАК КоличествоНоменклатур,
		|	ТаблицыСсылок.ИдентификаторХарактеристикиСервиса КАК ИдентификаторХарактеристикиСервиса,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ТаблицыСсылок.Характеристика) КАК КоличествоХарактеристик
		|ПОМЕСТИТЬ ГруппировкаРазличныхСсылок
		|ИЗ
		|	ТаблицыСсылок КАК ТаблицыСсылок
		|ГДЕ
		|	НЕ ТаблицыСсылок.ОбъектУдален
		|
		|СГРУППИРОВАТЬ ПО
		|	ТаблицыСсылок.ИдентификаторНоменклатурыСервиса,
		|	ТаблицыСсылок.ИдентификаторХарактеристикиСервиса
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ИдентификаторНоменклатурыСервиса,
		|	ИдентификаторХарактеристикиСервиса
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицыСсылок.Номенклатура КАК Номенклатура,
		|	ТаблицыСсылок.Характеристика КАК Характеристика,
		|	ТаблицыСсылок.ИдентификаторНоменклатурыСервиса КАК ИдентификаторНоменклатурыСервиса,
		|	ТаблицыСсылок.ИдентификаторХарактеристикиСервиса КАК ИдентификаторХарактеристикиСервиса,
		|	ТаблицыСсылок.ОбъектУдален КАК ОбъектУдален,
		|	ГруппировкаРазличныхСсылок.КоличествоНоменклатур КАК КоличествоНоменклатур,
		|	ГруппировкаРазличныхСсылок.КоличествоХарактеристик КАК КоличествоХарактеристик
		|ИЗ
		|	ТаблицыСсылок КАК ТаблицыСсылок
		|		ЛЕВОЕ СОЕДИНЕНИЕ ГруппировкаРазличныхСсылок КАК ГруппировкаРазличныхСсылок
		|		ПО ТаблицыСсылок.ИдентификаторНоменклатурыСервиса = ГруппировкаРазличныхСсылок.ИдентификаторНоменклатурыСервиса
		|			И ТаблицыСсылок.ИдентификаторХарактеристикиСервиса = ГруппировкаРазличныхСсылок.ИдентификаторХарактеристикиСервиса";
	
	Возврат Запрос.Выполнить();
	
КонецФункции

Функция НоваяТаблицаВариантовСопоставления() 
	
	Строка100 = Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(300));
	
	ТаблицаВариантовСопоставления = Новый ТаблицаЗначений;
	ТаблицаВариантовСопоставления.Колонки.Добавить("Номенклатура"                       , Метаданные.ОпределяемыеТипы.НоменклатураБЭД.Тип);
	ТаблицаВариантовСопоставления.Колонки.Добавить("Характеристика"                     , Метаданные.ОпределяемыеТипы.ХарактеристикаНоменклатурыБЭД.Тип);
	ТаблицаВариантовСопоставления.Колонки.Добавить("Упаковка"                           , Метаданные.ОпределяемыеТипы.УпаковкаНоменклатурыБЭД.Тип);
	ТаблицаВариантовСопоставления.Колонки.Добавить("Владелец"                           , Метаданные.ОпределяемыеТипы.ВладелецНоменклатурыБЭД.Тип);
	ТаблицаВариантовСопоставления.Колонки.Добавить("АртикулСопоставлен"                 , Новый ОписаниеТипов("Булево"));
	ТаблицаВариантовСопоставления.Колонки.Добавить("ШтрихкодСопоставлен"                , Новый ОписаниеТипов("Булево"));
	ТаблицаВариантовСопоставления.Колонки.Добавить("ПриоритетныйВариантНоменклатуры"    , Новый ОписаниеТипов("Булево"));
	ТаблицаВариантовСопоставления.Колонки.Добавить("ВариантыСопоставленияХарактеристики", Новый ОписаниеТипов("Массив"));
	ТаблицаВариантовСопоставления.Колонки.Добавить("ВариантыСопоставленияУпаковки"      , Новый ОписаниеТипов("Массив"));
	ТаблицаВариантовСопоставления.Колонки.Добавить("ПоискВариантовНеТребуется"          , Новый ОписаниеТипов("Булево"));
	ТаблицаВариантовСопоставления.Колонки.Добавить("Идентификатор"                      , Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(300)));
	ТаблицаВариантовСопоставления.Колонки.Добавить("ИдентификаторНоменклатуры"          , Строка100);
	ТаблицаВариантовСопоставления.Колонки.Добавить("ИдентификаторХарактеристики"        , Строка100);
	ТаблицаВариантовСопоставления.Колонки.Добавить("ИдентификаторУпаковки"              , Строка100);
	
	ТаблицаВариантовСопоставления.Индексы.Добавить("Владелец,Идентификатор,Номенклатура");
	ТаблицаВариантовСопоставления.Индексы.Добавить("Владелец,Идентификатор");
	
	Возврат ТаблицаВариантовСопоставления;
	
КонецФункции

#КонецОбласти


#Иначе
	
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
	
#КонецЕсли