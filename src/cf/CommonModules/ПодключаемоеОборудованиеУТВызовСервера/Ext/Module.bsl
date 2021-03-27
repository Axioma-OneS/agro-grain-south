﻿#Область ПрограммныйИнтерфейс

// Получить оборудование подключенное к терминалу.
//
// Параметры:
//  ЭквайринговыйТерминал - СправочникСсылка.ЭквайринговыеТерминалы - Эквайринговый терминал.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено, СправочникСсылка.ПодключаемоеОборудование - Терминал.
//   * ККТ - Неопределено, СправочникСсылка.ПодключаемоеОборудование - ККТ.
//
Функция ОборудованиеПодключенноеКТерминалу(ЭквайринговыйТерминал) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ НастройкаРМК
	|ИЗ
	|	Справочник.НастройкиРМК КАК Т
	|ГДЕ
	|	Т.РабочееМесто = &РабочееМесто
	|
	|;
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ЭквайринговыеТерминалы.ПодключаемоеОборудование               КАК Терминал,
	|	ЭквайринговыеТерминалы.ИспользоватьБезПодключенияОборудования КАК ИспользоватьБезПодключенияОборудования,
	|	ЭквайринговыеТерминалы.ПодключаемоеОборудованиеККТ            КАК ККТ
	|ИЗ
	|	Справочник.НастройкиРМК.ЭквайринговыеТерминалы КАК ЭквайринговыеТерминалы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкаРМК КАК НастройкаРМК
	|		ПО НастройкаРМК.Ссылка = ЭквайринговыеТерминалы.Ссылка
	|ГДЕ
	|	ЭквайринговыеТерминалы.ЭквайринговыйТерминал = &ЭквайринговыйТерминал");
	
	Запрос.УстановитьПараметр("РабочееМесто",          МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("ЭквайринговыйТерминал", ЭквайринговыйТерминал);
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		
		ЗаполнитьЗначенияСвойств(ВозвращаемоеЗначение, Выборка);
		Если Выборка.ИспользоватьБезПодключенияОборудования Тогда
			ВозвращаемоеЗначение.Терминал = Неопределено;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Получить оборудование подключенное к кассе.
//
// Параметры:
//  Касса - СправочникСсылка.Кассы - Касса.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено.
//   * ККТ - Неопределено, СправочникСсылка.ПодключаемоеОборудование - ККТ.
//
Функция ОборудованиеПодключенноеККассе(Касса) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ НастройкаРМК
	|ИЗ
	|	Справочник.НастройкиРМК КАК Т
	|ГДЕ
	|	Т.РабочееМесто = &РабочееМесто
	|
	|;
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	Кассы.ПодключаемоеОборудование КАК ККТ
	|ИЗ
	|	Справочник.НастройкиРМК.Кассы КАК Кассы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкаРМК КАК НастройкаРМК
	|		ПО НастройкаРМК.Ссылка = Кассы.Ссылка
	|ГДЕ
	|	Кассы.Касса = &Касса");
	
	Запрос.УстановитьПараметр("РабочееМесто", МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("Касса",        Касса);
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ВозвращаемоеЗначение, Выборка);
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Получить оборудование подключенное к кассе ККМ.
//
// Параметры:
//  КассаККМ - СправочникСсылка.КассыККМ - Касса ККМ.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено.
//   * ККТ - Неопределено, СправочникСсылка.ПодключаемоеОборудование - ККТ.
//
Функция ОборудованиеПодключенноеККассеККМ(КассаККМ) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ НастройкаРМК
	|ИЗ
	|	Справочник.НастройкиРМК КАК Т
	|ГДЕ
	|	Т.РабочееМесто = &РабочееМесто
	|
	|;
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	КассыККМ.ПодключаемоеОборудование КАК ККТ
	|ИЗ
	|	Справочник.НастройкиРМК.КассыККМ КАК КассыККМ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкаРМК КАК НастройкаРМК
	|		ПО НастройкаРМК.Ссылка = КассыККМ.Ссылка
	|ГДЕ
	|	НЕ КассыККМ.ИспользоватьБезПодключенияОборудования
	|	И КассыККМ.КассаККМ = &КассаККМ");
	
	Запрос.УстановитьПараметр("РабочееМесто", МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("КассаККМ",     КассаККМ);
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ВозвращаемоеЗначение, Выборка);
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Получить оборудование подключенное по организации.
//
// Параметры:
//  Организация - ОпределяемыйТип.ОрганизацияБПО - Организация.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено.
//   * ККТ - Массив - ККТ, элементы типа СправочникСсылка.ПодключаемоеОборудование
//
Функция ОборудованиеПодключенноеПоОрганизации(Организация) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ПодключаемоеОборудование.Ссылка КАК ККТ
	|ИЗ
	|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
	|ГДЕ
	|	ПодключаемоеОборудование.Организация = &Организация
	|	И НЕ ПодключаемоеОборудование.ПометкаУдаления
	|	И ПодключаемоеОборудование.УстройствоИспользуется
	|	И ПодключаемоеОборудование.РабочееМесто = &РабочееМесто");
	
	Запрос.УстановитьПараметр("РабочееМесто", МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("Организация",  Организация);
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	ВозвращаемоеЗначение.ККТ = Новый Массив;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ВозвращаемоеЗначение.ККТ.Добавить(Выборка.ККТ);
	КонецЦикла;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

Функция ДанныеФискальнойОперацииСУчетомКорректировкиРеализации(ДокументОснование) Экспорт
	
	ДанныеФискальнойОперации = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	КорректировкаРеализации.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.КорректировкаРеализации КАК КорректировкаРеализации
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ФискальныеОперации КАК ФискальныеОперации
	|		ПО КорректировкаРеализации.Ссылка = ФискальныеОперации.ДокументОснование
	|ГДЕ
	|	КорректировкаРеализации.ДокументОснование = &ДокументОснование
	|
	|УПОРЯДОЧИТЬ ПО
	|	КорректировкаРеализации.Дата УБЫВ";
	Запрос.УстановитьПараметр("ДокументОснование", ДокументОснование);
	
	УстановитьПривилегированныйРежим(Истина);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		ДанныеФискальнойОперации = МенеджерОборудованияВызовСервера.ДанныеФискальнойОперации(Выборка.Ссылка);
	КонецЕсли;
	
	Возврат ДанныеФискальнойОперации;
	
КонецФункции

// Получить параметры фискализации чека.
//
// Параметры:
//  ДанныеДокумента - Структура - РозничныеПродажиКлиентСервер.СтруктураДанныхДокументаДляПараметровФискализацииЧека().
//  СуммаПредоплатыКорректировка - Число - Сумма предоплаты.
//  ЭтоВозврат - Булево - Признак возврата.
// 
// Возвращаемое значение:
//  Структура - см. функцию МенеджерОборудованияКлиентСервер.ПараметрыОперацииФискализацииЧека().
//
Функция ПараметрыФискализацииЧека(ДанныеДокумента, СуммаПредоплатыКорректировка = Неопределено, ЭтоВозврат = Ложь) Экспорт
	
	Шапка = ДанныеДокумента.Шапка;
	Товары = ДанныеДокумента.Товары;
	Заказы = ДанныеДокумента.Заказы;
	ДанныеДляИСМП = ДанныеДокумента.ДанныеДляИСМП;
	
	ВалютаРегл = Константы.ВалютаРегламентированногоУчета.Получить();
	
	СведенияОЮрФизЛице = ФормированиеПечатныхФорм.СведенияОЮрФизЛице(Шапка.Организация, ТекущаяДатаСеанса());
	
	ПараметрыФискализацииЧека = МенеджерОборудованияКлиентСервер.ПараметрыОперацииФискализацииЧека();
	
	ПараметрыФискализацииЧека.ДокументОснование      = Шапка.ДокументСсылка;
	Если ЭтоВозврат Тогда
		ПараметрыФискализацииЧека.ТипРасчета = Перечисления.ТипыРасчетаДенежнымиСредствами.ВозвратДенежныхСредств;
	Иначе
		ПараметрыФискализацииЧека.ТипРасчета = Перечисления.ТипыРасчетаДенежнымиСредствами.ПриходДенежныхСредств;
	КонецЕсли;
	
	Если Шапка.НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяЕНВД Тогда
		ПараметрыФискализацииЧека.СистемаНалогообложения = Перечисления.ТипыСистемНалогообложенияККТ.ЕНВД;
	Иначе
		ПараметрыФискализацииЧека.СистемаНалогообложения = РозничныеПродажи.СистемаНалогообложенияФискальнойОперации(Шапка.Организация);
	КонецЕсли;
	
	// Параметры необходимые для чека ЕНВД на принтере чеков
	ПараметрыФискализацииЧека.Организация		   = Шапка.Организация;
	ПараметрыФискализацииЧека.ОрганизацияНазвание  = СведенияОЮрФизЛице.ПолноеНаименование;
	ПараметрыФискализацииЧека.ОрганизацияИНН       = СведенияОЮрФизЛице.ИНН;
	ПараметрыФискализацииЧека.ОрганизацияКПП       = СведенияОЮрФизЛице.КПП;
	
	ПараметрыФискализацииЧека.АдресМагазина        = СведенияОЮрФизЛице.ФактическийАдрес;
	ПараметрыФискализацииЧека.НаименованиеМагазина = СведенияОЮрФизЛице.СокращенноеНаименование;
	
	Попытка
		ПараметрыФискализацииЧека.ТорговыйОбъект   = Шапка.ТорговыйОбъект;
	Исключение
		ПараметрыФискализацииЧека.ТорговыйОбъект   = СведенияОЮрФизЛице.СокращенноеНаименование;
	КонецПопытки;
	
	СведенияОПокупателе = ФормированиеПечатныхФорм.СведенияОЮрФизЛице(Шапка.Контрагент, ТекущаяДатаСеанса());
	ПараметрыФискализацииЧека.Получатель    = СведенияОПокупателе.ПолноеНаименование;
	ПараметрыФискализацииЧека.ПолучательИНН = СведенияОПокупателе.ИНН;
	
	СуммаПоЗаказам  = 0;
	СуммаБезЗаказов = 0;
	Для Каждого СтрокаТЧ Из Товары Цикл
		
		Если Шапка.ПоЗаказам И СтрокаТЧ.СверхЗаказа Тогда
			СуммаБезЗаказов = СуммаБезЗаказов + СтрокаТЧ.СуммаСНДС;
		ИначеЕсли Шапка.ПоЗаказам Тогда
			СуммаПоЗаказам = СуммаПоЗаказам + СтрокаТЧ.СуммаСНДС;
		Иначе
			СуммаБезЗаказов = СуммаБезЗаказов + СтрокаТЧ.СуммаСНДС;
		КонецЕсли;
		
	КонецЦикла;
	
	СуммаПредоплаты = 0;
	Если СуммаПредоплатыКорректировка <> Неопределено Тогда
		
		СуммаПредоплаты = СуммаПредоплатыКорректировка
		
	Иначе
		
		Для Каждого СтрокаТЧ Из Товары Цикл
			
			Если Шапка.ПоЗаказам И СтрокаТЧ.СверхЗаказа Тогда
				
				Если ВалютаРегл <> Шапка.Валюта Тогда
					
					ПроцентПредоплаты = (Шапка.СуммаПредоплаты / Шапка.СуммаДокумента);
					
					СуммаПредоплаты = ПроцентПредоплаты
					                * СтрокаТЧ.СуммаСНДС + СуммаПредоплаты;
					
				Иначе
					
					// Сумма предоплаты берется из шапки документа
					
				КонецЕсли;
				
			ИначеЕсли Шапка.ПоЗаказам И Заказы <> Неопределено Тогда
				
				ДанныеЗаказа = Заказы.Найти(СтрокаТЧ.Заказ, "Заказ");
				Если ДанныеЗаказа <> Неопределено
					И ДанныеЗаказа.СуммаЗаказа <> 0 Тогда
					ПроцентПредоплаты = Мин((ДанныеЗаказа.СуммаПредоплаты / ДанныеЗаказа.СуммаЗаказа), 1);
				Иначе
					ПроцентПредоплаты = 0;
				КонецЕсли;
				
				СуммаПредоплаты = ПроцентПредоплаты * СтрокаТЧ.СуммаСНДС + СуммаПредоплаты;
				
			Иначе
				
				Если ВалютаРегл <> Шапка.Валюта Тогда
					
					ПроцентПредоплаты = Мин((Шапка.СуммаПредоплаты / СуммаБезЗаказов), 1);
					
					СуммаПредоплаты = ПроцентПредоплаты
					                * СтрокаТЧ.СуммаСНДС + СуммаПредоплаты;
					
				Иначе
					
					// Сумма предоплаты берется из шапки документа
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Если Не Шапка.ПоЗаказам
			И ВалютаРегл = Шапка.Валюта Тогда
			СуммаПредоплаты = СуммаПредоплаты + Шапка.СуммаПредоплаты;
		КонецЕсли;
		
	КонецЕсли;
	
	ОсобенностиУчета = Новый Массив;
	Для Каждого ВидПродукцииИСМП Из ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП(Истина) Цикл
		ОсобенностиУчета.Добавить(ИнтеграцияИСУТКлиентСервер.ОсобенностьУчетаПоВидуПродукции(ВидПродукцииИСМП));
	КонецЦикла;
	
	Для Каждого СтрокаТЧ Из Товары Цикл
		
		МассивСтрокДляДобавленияВЧек = Новый Массив;
		МассивСтрокДляДобавленияВЧек.Добавить(СтрокаТЧ);
		
		// Данные по маркируемой продукции
		Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаТЧ, "ОсобенностьУчета")
			И ОсобенностиУчета.Найти(СтрокаТЧ.ОсобенностьУчета) <> Неопределено
			И ДанныеДляИСМП <> Неопределено Тогда
			// заменяем строки для добавления в чек детализированными данными по табаку
			МассивСтрокДляДобавленияВЧек = ДанныеДляИСМП.НайтиСтроки(Новый Структура("НомерСтроки", СтрокаТЧ.НомерСтроки));
		КонецЕсли;
		
		Для каждого СтрокаДляДобавленияВЧек из МассивСтрокДляДобавленияВЧек Цикл
			СтрокаПозицииЧека = МенеджерОборудованияКлиентСервер.ПараметрыФискальнойСтрокиЧека();
			
			// Общие данные строки чека
			Если СуммаПредоплаты > 0
				И СуммаПредоплаты >= (СуммаБезЗаказов + СуммаПоЗаказам) Тогда
				СтрокаПозицииЧека.ПризнакСпособаРасчета = Перечисления.ПризнакиСпособаРасчета.ПередачаСПолнойОплатой;
			ИначеЕсли СуммаПредоплаты > 0 Тогда
				СтрокаПозицииЧека.ПризнакСпособаРасчета = Перечисления.ПризнакиСпособаРасчета.ПередачаСЧастичнойОплатой;
			Иначе
				СтрокаПозицииЧека.ПризнакСпособаРасчета = Перечисления.ПризнакиСпособаРасчета.ПередачаБезОплаты;
			КонецЕсли;
			СтрокаПозицииЧека.ПризнакПредметаРасчета = РозничныеПродажиКлиентСервер.ПризнакПредметаРасчетаФискальнойОперации(
				СтрокаТЧ.ТипНоменклатуры,
				СтрокаТЧ.ПодакцизныйТовар);
			СтрокаПозицииЧека.Наименование = НоменклатураКлиентСервер.ПредставлениеНоменклатурыДляПечати(
				СтрокаТЧ.НоменклатураНаименование,
				СтрокаТЧ.ХарактеристикаНаименование);
			
			СтрокаПозицииЧека.ЕдиницаИзмерения = СокрЛП(СтрокаТЧ.УпаковкаНаименование);
			
			СтрокаПозицииЧека.НомерСекции       = 1;
			СтрокаПозицииЧека.Цена              = СтрокаТЧ.Цена;
			СтрокаПозицииЧека.СтавкаНДС         = РозничныеПродажиКлиентСервер.СтавкаНДСФискальнойОперации(СтрокаТЧ.СтавкаНДС);
			СтрокаПозицииЧека.СуммаНДС          = СтрокаТЧ.СуммаНДС;
			
			СтрокаПозицииЧека.НомерСтрокиТовара = СтрокаТЧ.НомерСтроки;
			
			// Расчетные данные строки чека
			СтрокаПозицииЧека.Количество = ?(СтрокаДляДобавленияВЧек.КоличествоУпаковок = 0, 1, СтрокаДляДобавленияВЧек.КоличествоУпаковок);
			СтрокаПозицииЧека.Сумма             = СтрокаДляДобавленияВЧек.СуммаСНДС;
			СтрокаПозицииЧека.СуммаСкидок       = СтрокаДляДобавленияВЧек.СуммаСкидки;
			
			Если СтрокаПозицииЧека.Количество <> 0 Тогда
				СтрокаПозицииЧека.ЦенаСоСкидками = Окр(СтрокаПозицииЧека.Сумма / СтрокаПозицииЧека.Количество, 2);
			КонецЕсли;
			
			СтрокаПозицииЧека.ДанныеКодаТоварнойНоменклатуры.ТипМаркировки                          = Неопределено;
			СтрокаПозицииЧека.ДанныеКодаТоварнойНоменклатуры.КонтрольныйИдентификационныйЗнак       = Неопределено;
			СтрокаПозицииЧека.ДанныеКодаТоварнойНоменклатуры.ГлобальныйИдентификаторТорговойЕдиницы = Неопределено;
			СтрокаПозицииЧека.ДанныеКодаТоварнойНоменклатуры.СерийныйНомер                          = Неопределено;
			
			ЗаполнитьСтрокуПоДаннымРазбораШтрихкода(СтрокаПозицииЧека, СтрокаДляДобавленияВЧек);
			
			Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "Штрихкод") Тогда
				СтрокаПозицииЧека.Штрихкод = СтрокаДляДобавленияВЧек.Штрихкод;
			КонецЕсли;
			
			Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "КодВидаНоменклатурнойКлассификации") Тогда
				СтрокаПозицииЧека.КодВидаНоменклатурнойКлассификации = СтрокаДляДобавленияВЧек.КодВидаНоменклатурнойКлассификации;
			КонецЕсли;
			
			Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "ТипЗапасов")
				И ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "Комитент")
				И СтрокаДляДобавленияВЧек.ТипЗапасов = Перечисления.ТипыЗапасов.КомиссионныйТовар Тогда
				
				РеквизитыКомитента = ФормированиеПечатныхФорм.СведенияОЮрФизЛице(СтрокаДляДобавленияВЧек.Комитент, ТекущаяДатаСеанса());
				
				СтрокаПозицииЧека.ПризнакАгентаПоПредметуРасчета = Перечисления.ПризнакиАгента.Комиссионер;
				
				ДанныеПоставщика = Новый Структура();
				ДанныеПоставщика.Вставить("Телефон"	 	, РеквизитыКомитента.Телефоны);
				ДанныеПоставщика.Вставить("Наименование", РеквизитыКомитента.ПолноеНаименование);
				ДанныеПоставщика.Вставить("ИНН"		 	, РеквизитыКомитента.ИНН);
				
				СтрокаПозицииЧека.ДанныеПоставщика = ДанныеПоставщика; 
			КонецЕсли;
			
			Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "ОсобенностьУчета")
				И ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "Агент")
				И СтрокаДляДобавленияВЧек.ОсобенностьУчета = Перечисления.ОсобенностиУчетаНоменклатуры.Партнером
				И ЗначениеЗаполнено(СтрокаДляДобавленияВЧек.Агент) Тогда
				
				РеквизитыКомитента = ФормированиеПечатныхФорм.СведенияОЮрФизЛице(СтрокаДляДобавленияВЧек.Агент, ТекущаяДатаСеанса());
				
				СтрокаПозицииЧека.ПризнакАгентаПоПредметуРасчета = Перечисления.ПризнакиАгента.Агент;
				
				ДанныеПоставщика = Новый Структура();
				ДанныеПоставщика.Вставить("Телефон"	 	, РеквизитыКомитента.Телефоны);
				ДанныеПоставщика.Вставить("Наименование", РеквизитыКомитента.ПолноеНаименование);
				ДанныеПоставщика.Вставить("ИНН"		 	, РеквизитыКомитента.ИНН);
				
				СтрокаПозицииЧека.ДанныеПоставщика = ДанныеПоставщика; 
			КонецЕсли;
			
			ДанныеПоИмпортнойПоставке = Новый Структура("НомерТаможеннойДекларации, КодСтраныПроисхождения", Неопределено, Неопределено);
			ЗаполнитьЗначенияСвойств(ДанныеПоИмпортнойПоставке, СтрокаТЧ);
			
			СтрокаПозицииЧека.НомерТаможеннойДекларации = ДанныеПоИмпортнойПоставке.НомерТаможеннойДекларации; 
			СтрокаПозицииЧека.КодСтраныПроисхожденияТовара = ДанныеПоИмпортнойПоставке.КодСтраныПроисхождения;
			
			ПараметрыФискализацииЧека.ПозицииЧека.Добавить(СтрокаПозицииЧека);
		КонецЦикла;
		
	КонецЦикла;
	
	// Сумма постоплатой (в кредит)
	СтрокаОплаты = Новый Структура();
	СтрокаОплаты.Вставить("ТипОплаты", Перечисления.ТипыОплатыККТ.Постоплата);
	СтрокаОплаты.Вставить("Сумма",     СуммаПоЗаказам + СуммаБезЗаказов - СуммаПредоплаты);
	ПараметрыФискализацииЧека.ТаблицаОплат.Добавить(СтрокаОплаты);
	
	// Сумма предоплатой (зачетом аванса)
	СтрокаОплаты = Новый Структура();
	СтрокаОплаты.Вставить("ТипОплаты", Перечисления.ТипыОплатыККТ.Предоплата);
	СтрокаОплаты.Вставить("Сумма",     СуммаПредоплаты);
	ПараметрыФискализацииЧека.ТаблицаОплат.Добавить(СтрокаОплаты);
	
	Возврат ПараметрыФискализацииЧека;
	
КонецФункции

// Распределяет данные по маркировке по таблице товаров документа
// 
// Параметры:
// 	Товары - ТаблицаЗначений - Товары из документа
// 	МаркированныеТовары - ТаблицаЗначений - Данные по маркировке товаров
// Возвращаемое значение:
// 	ТаблицаЗначений - Данные товара с маркировкой
Функция ТаблицаМаркированныхТоваровСоШтрихкодамиУпаковок(Товары, МаркированныеТовары, ПараметрыУказанияСерий) Экспорт
	
	ТоварыРазобранные = Товары.СкопироватьКолонки();
	ТоварыРазобранные.Колонки.Добавить("Штрихкод");
	
	Для Каждого СтрокаТовары Из Товары Цикл
		
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("НоменклатураСсылка", СтрокаТовары.Номенклатура);
		СтруктураОтбора.Вставить("ХарактеристикаСсылка", СтрокаТовары.Характеристика);
		
		Если Не НоменклатураКлиентСервер.ВЭтомСтатусеСерииНеУказываются(СтрокаТовары.СтатусУказанияСерий, ПараметрыУказанияСерий) Тогда
			СтруктураОтбора.Вставить("СерияСсылка", СтрокаТовары.Серия);
		КонецЕсли;
		
		МассивМаркированныхТоваров = МаркированныеТовары.НайтиСтроки(СтруктураОтбора);
		
		Если МассивМаркированныхТоваров.Количество() = 0 Тогда
			СтрокаТоварыРазобранные = ТоварыРазобранные.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТоварыРазобранные, СтрокаТовары);
			
			Продолжить;
		КонецЕсли;
		
		КоличествоСтрокМассиваМаркированныхТоваров = МассивМаркированныхТоваров.Количество(); 
		ТекущаяСтрока = 1;
		
		Пока КоличествоСтрокМассиваМаркированныхТоваров >= ТекущаяСтрока Цикл
			Если СтрокаТовары.КоличествоЕдиниц = 0 Тогда
				Прервать;
			КонецЕсли;
			
			МаркированныйТовар = МассивМаркированныхТоваров[КоличествоСтрокМассиваМаркированныхТоваров - ТекущаяСтрока];
			
			ЭтоГрупповаяТоварнаяУпаковка = Ложь;
			Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(
				МаркированныйТовар.СтрокаДерева, "ГрупповаяТоварнаяУпаковка") Тогда
				ЭтоГрупповаяТоварнаяУпаковка = МаркированныйТовар.СтрокаДерева.ГрупповаяТоварнаяУпаковка;
			КонецЕсли;
			
			Если НЕ (МаркированныйТовар.СтрокаДерева.ТипУпаковки = Перечисления.ТипыУпаковок.МаркированныйТовар
				И ЭтоГрупповаяТоварнаяУпаковка = Ложь) Тогда
				
				МаркированныеТовары.Удалить(МаркированныйТовар);
				
				ТекущаяСтрока = ТекущаяСтрока + 1;
				Продолжить;
			КонецЕсли;
			
			СтрокаТоварыРазобранные = ТоварыРазобранные.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТоварыРазобранные, СтрокаТовары);
			
			СтрокаТоварыРазобранные.Штрихкод = МаркированныйТовар.ШтрихкодСтрока;
			
			Коэффициент = СтрокаТовары.КоличествоУпаковок / СтрокаТовары.СерииКоличествоУпаковок;
			
			СтрокаТоварыРазобранные.КоличествоУпаковок = 1;
			СтрокаТоварыРазобранные.КоличествоЕдиниц   = 1;
			СтрокаТоварыРазобранные.СуммаСкидки        = Окр(СтрокаТовары.СуммаСкидки / СтрокаТовары.КоличествоЕдиниц / Коэффициент, 2);
			СтрокаТоварыРазобранные.СуммаНДС           = Окр(СтрокаТовары.СуммаНДС / СтрокаТовары.КоличествоЕдиниц / Коэффициент, 2);
			СтрокаТоварыРазобранные.СуммаСНДС          = Окр(СтрокаТовары.СуммаСНДС / СтрокаТовары.КоличествоЕдиниц / Коэффициент, 2);
			СтрокаТоварыРазобранные.Цена               = СтрокаТоварыРазобранные.СуммаСНДС - СтрокаТоварыРазобранные.СуммаСкидки;
			
			Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(СтрокаТоварыРазобранные, "ЕдиницаИзмерения")
				И ЗначениеЗаполнено(СтрокаТоварыРазобранные.ЕдиницаИзмерения)
				И СтрокаТоварыРазобранные.ЕдиницаИзмерения <> СтрокаТоварыРазобранные.Упаковка Тогда
					
				СтрокаТоварыРазобранные.Упаковка = СтрокаТоварыРазобранные.ЕдиницаИзмерения;
			КонецЕсли;
			
			СтрокаТовары.КоличествоЕдиниц 	= СтрокаТовары.КоличествоЕдиниц - СтрокаТоварыРазобранные.КоличествоЕдиниц;
			СтрокаТовары.СуммаСкидки 		= СтрокаТовары.СуммаСкидки - СтрокаТоварыРазобранные.СуммаСкидки;
			СтрокаТовары.СуммаНДС 			= СтрокаТовары.СуммаНДС - СтрокаТоварыРазобранные.СуммаНДС;
			СтрокаТовары.СуммаСНДС 			= СтрокаТовары.СуммаСНДС - СтрокаТоварыРазобранные.СуммаСНДС;
			
			МаркированныеТовары.Удалить(МаркированныйТовар);
			
			ТекущаяСтрока = ТекущаяСтрока + 1;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ТоварыРазобранные;
	
КонецФункции

// Таблица товаров с разделением маркированной продукции до единиц
// 
// Параметры:
// 	Товары - ТаблицаЗначений - Товары из документа
// 	ДанныеДляИСМП - Массив - Данные о продажах (см. ИнтеграцияЕГАИСКлиентСервер.СтруктураСтрокиЧекаЕГАИС()). 
Процедура ТаблицаТоваровСРаспределениемПоИСМП(Товары, ДанныеДляИСМП) Экспорт
	
	ТаблицаТоваровСРаспределениемПоИСМП = Товары.СкопироватьКолонки();
	Если ТаблицаТоваровСРаспределениемПоИСМП.Колонки.Найти("Штрихкод") = Неопределено Тогда
		ТаблицаТоваровСРаспределениемПоИСМП.Колонки.Добавить("Штрихкод");
	КонецЕсли;
	
	ВидыПродукцииИСМП = ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП(Истина);
	Для Каждого СтрокаТЧ Из Товары Цикл
		
		МассивСтрокДляДобавленияВТовары = Новый Массив;
		МассивСтрокДляДобавленияВТовары.Добавить(СтрокаТЧ);
		
		// Данные по табачной и обувной продукции
		ЭтоМаркированнаяПродукция = Ложь;
		Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаТЧ, "ОсобенностьУчета")
			И ВидыПродукцииИСМП.Найти(ИнтеграцияИСУТКлиентСервер.ОсобенностьУчетаПоВидуПродукции(СтрокаТЧ.ОсобенностьУчета))<>Неопределено
			И ДанныеДляИСМП <> Неопределено Тогда

			ЭтоМаркированнаяПродукция = Истина;
			// заменяем строки для добавления в чек детализированными данными по табаку и обуви
			МассивСтрокДляДобавленияВТовары = ДанныеДляИСМП.НайтиСтроки(Новый Структура("НомерСтроки", СтрокаТЧ.НомерСтроки));
		КонецЕсли;
		
		Для каждого СтрокаДляДобавленияВТовары Из МассивСтрокДляДобавленияВТовары Цикл
			Если СтрокаТЧ.КоличествоУпаковок = 0 Тогда
				Прервать;
			КонецЕсли;
			
			СтрокаТоваровСРаспределениемПоИСМП = ТаблицаТоваровСРаспределениемПоИСМП.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТоваровСРаспределениемПоИСМП, СтрокаТЧ);
			ЗаполнитьЗначенияСвойств(СтрокаТоваровСРаспределениемПоИСМП, СтрокаДляДобавленияВТовары);
			
			СтрокаТЧ.КоличествоУпаковок = СтрокаТЧ.КоличествоУпаковок - СтрокаТоваровСРаспределениемПоИСМП.КоличествоУпаковок;
			СтрокаТЧ.СуммаСНДС = СтрокаТЧ.СуммаСНДС - СтрокаТоваровСРаспределениемПоИСМП.СуммаСНДС;
			СтрокаТЧ.СуммаНДС = СтрокаТЧ.СуммаНДС - СтрокаТоваровСРаспределениемПоИСМП.СуммаНДС;
			СтрокаТЧ.СуммаСкидки = СтрокаТЧ.СуммаСкидки - СтрокаТоваровСРаспределениемПоИСМП.СуммаСкидки;
			
			Если ЭтоМаркированнаяПродукция И ЗначениеЗаполнено(СтрокаДляДобавленияВТовары.Упаковка) Тогда
				СтрокаТоваровСРаспределениемПоИСМП.УпаковкаНаименование = СтрокаДляДобавленияВТовары.Упаковка;
			КонецЕсли;
			
			Если ДанныеДляИСМП.Индекс(СтрокаДляДобавленияВТовары) > -1 Тогда
				ДанныеДляИСМП.Удалить(СтрокаДляДобавленияВТовары);
			КонецЕсли;
		КонецЦикла;
		
		Если СтрокаТЧ.КоличествоУпаковок > 0 Тогда
			СтрокаТоваровСРаспределениемПоИСМП = ТаблицаТоваровСРаспределениемПоИСМП.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТоваровСРаспределениемПоИСМП, СтрокаТЧ);
		КонецЕсли;
	КонецЦикла;
	
	Товары = ТаблицаТоваровСРаспределениемПоИСМП;
	
КонецПроцедуры

// Записать операцию в регистр сведений Фискальные операции. Оставлен для совместимости с ОперацияПоЯндексКассе.ОтразитьДокументВЖурналеФискальныхОпераций()
// вызывается ТОЛЬКО оттуда
// раньше запись делалась в регистр сведений ЖурналФискальныхОпераций
// теперь в рамках этого метода НЕ создаются : 
//		РозничныеПродажи.СоздатьДокументВнесениеДенежныхСредствВКассуККМ(ВнесениеДенежныхСредствВКассуККМ);
//      РозничныеПродажи.СоздатьДокументВыемкаДенежныхСредствИзКассыККМ(ВыемкаДенежныхСредствИзКассыККМ);
//
// Параметры:
//  ТребуетсяПовторнаяПопыткаЗаписи - Булево - Требуется повторная попытка записи.
//  РеквизитыОперацииКассовогоУзла - Структура - см. функцию Документ.ОперацияПоЯндексКассе.СтруктураРеквизитыФискальнойОперацииКассовогоУзла().
//
Функция ЗаписатьВЖурналФискальныхОпераций(ТребуетсяПовторнаяПопыткаЗаписи, Знач РеквизитыФискальнойОперацииКассовогоУзла) Экспорт
	
	ПараметрыФискализации = МенеджерОборудованияКлиентСервер.ПараметрыФискализацииЧека();
	
	ПараметрыФискализации.ДокументОснование = РеквизитыФискальнойОперацииКассовогоУзла.ДокументОснование;
	ПараметрыФискализации.Организация = РеквизитыФискальнойОперацииКассовогоУзла.Организация;
	ПараметрыФискализации.ТорговыйОбъект = РеквизитыФискальнойОперацииКассовогоУзла.ТорговыйОбъект;
	ПараметрыФискализации.ТипРасчета = РеквизитыФискальнойОперацииКассовогоУзла.ТипРасчета;
	ПараметрыФискализации.НомерЧекаККТ = РеквизитыФискальнойОперацииКассовогоУзла.НомерЧекаККМ; //в БПО НомерЧекаККТ, в ЯК НомерЧекаККМ
	ПараметрыФискализации.ДатаВремяЧека = РеквизитыФискальнойОперацииКассовогоУзла.Дата;
	
	Если РеквизитыФискальнойОперацииКассовогоУзла.ТипОперации = Перечисления.ТипыОперацииКассовогоУзла.ФискальнаяОперация Тогда
		ПараметрыФискализации.ТипДокумента = Перечисления.ТипыФискальныхДокументовККТ.КассовыйЧек;
	ИначеЕсли РеквизитыФискальнойОперацииКассовогоУзла.ТипОперации = Перечисления.ТипыОперацииКассовогоУзла.ВнесениеДенежныхСредств Тогда	
		ПараметрыФискализации.ТипДокумента = Перечисления.ТипыФискальныхДокументовККТ.Внесение;
	ИначеЕсли РеквизитыФискальнойОперацииКассовогоУзла.ТипОперации = Перечисления.ТипыОперацииКассовогоУзла.ВыемкаДенежныхСредств Тогда	
		ПараметрыФискализации.ТипДокумента = Перечисления.ТипыФискальныхДокументовККТ.Выемка;
	КонецЕсли;	
	
	ПараметрыФискализации.СуммаЧека = РеквизитыФискальнойОперацииКассовогоУзла.Сумма;
	ПараметрыФискализации.ОплатаЭлектронно = РеквизитыФискальнойОперацииКассовогоУзла.СуммаОплатыПлатежнаяКарта;
		
	Результат = ЗаписатьФискальнуюОперациюВТранзакции(ТребуетсяПовторнаяПопыткаЗаписи, ПараметрыФискализации);
	
	Возврат Результат;
	
КонецФункции

// Записать операцию в регистр сведений Фискальные операции в транзакции. 
// Метод добавлен для вызова из клиентского контекста (в частности ПодключаемоеОборудованиеУТКлиент) с возможностью попытки повторной записи
// В дальнейшем предполагается перенести этот метод в ОМ МенеджерОбрудованияВызовСервера БПО.
//
// Параметры:
//  ТребуетсяПовторнаяПопыткаЗаписи - Булево - Требуется повторная попытка записи.
//  ПараметрыФискализации - Структура - см. функцию МенеджерОборудованияКлиентСервер.ПараметрыФискализацииЧека.
//
Функция ЗаписатьФискальнуюОперациюВТранзакции(ТребуетсяПовторнаяПопыткаЗаписи, Знач ПараметрыФискализации) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	НачатьТранзакцию();
	Попытка
		
		Если ПараметрыФискализации <> Неопределено Тогда
			
			НужноЗаписатьФискальнуюОперацию = НЕ ПараметрыФискализации.ОперацияЗаписана;
			НужноЗаписатьФискальнуюОперациюСторно = НЕ ( ПустаяСтрока(ПараметрыФискализации.ЧекКоррекцииСторно)
					 									 ИЛИ ПараметрыФискализации.ЧекКоррекцииСторно.ОперацияЗаписана );
														 
			Если НужноЗаписатьФискальнуюОперацию ИЛИ НужноЗаписатьФискальнуюОперациюСторно Тогда
															 
				Блокировка = Новый БлокировкаДанных;
				
				Если НужноЗаписатьФискальнуюОперацию И ЗначениеЗаполнено(ПараметрыФискализации.ДокументОснование) Тогда
					ЭлементБлокировки = Блокировка.Добавить();
					ЭлементБлокировки.Область = "РегистрСведений.ФискальныеОперации";
					ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
					ЭлементБлокировки.УстановитьЗначение("ДокументОснование", ПараметрыФискализации.ДокументОснование);
				КонецЕсли;	
				
				Если НужноЗаписатьФискальнуюОперациюСторно И ЗначениеЗаполнено(ПараметрыФискализации.ЧекКоррекцииСторно.ДокументОснование) Тогда
					ЭлементБлокировки = Блокировка.Добавить();
					ЭлементБлокировки.Область = "РегистрСведений.ФискальныеОперации";
					ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
					ЭлементБлокировки.УстановитьЗначение("ДокументОснование", ПараметрыФискализации.ЧекКоррекцииСторно.ДокументОснование);
				КонецЕсли;
				
				Если Блокировка.Количество() Тогда
					Блокировка.Заблокировать();
				КонецЕсли;	

				Если НужноЗаписатьФискальнуюОперацию Тогда
					МенеджерОборудованияВызовСервера.ЗаписатьФискальнуюОперацию(ПараметрыФискализации);
				КонецЕсли;
				Если НужноЗаписатьФискальнуюОперациюСторно Тогда
					МенеджерОборудованияВызовСервера.ЗаписатьФискальнуюОперацию(ПараметрыФискализации.ЧекКоррекцииСторно);
				КонецЕсли;
				
			КонецЕсли;
		КонецЕсли;
		
		Результат = Истина;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		ТребуетсяПовторнаяПопыткаЗаписи = Истина;
		
		Результат = Ложь;
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Возращает текст запроса по внереализованной прибыли для фискализации
//
//  ВозвращаемоеЗначение:
//   Строка
//
Функция ТекстЗапросаПоВнереализациннойПрибылиДляФмскализации() Экспорт
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ОплатаПодарочнымСертификатом.Сумма КАК Сумма
	|ПОМЕСТИТЬ ОплатаПодарочнымСертификатом
	|ИЗ
	|	&ОплатаПодарочнымСертификатом КАК ОплатаПодарочнымСертификатом
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СУММА(ОплатаПодарочнымСертификатом.Сумма) КАК Сумма
	|ПОМЕСТИТЬ ОплатаПодарочнымСертификатомИтого
	|ИЗ
	|	ОплатаПодарочнымСертификатом КАК ОплатаПодарочнымСертификатом
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПогашениеПодарочныхСертификатов.ПодарочныйСертификат КАК ПодарочныйСертификат
	|ПОМЕСТИТЬ ПогашениеПодарочныхСертификатов
	|ИЗ
	|	&ПогашениеПодарочныхСертификатов КАК ПогашениеПодарочныхСертификатов
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СУММА(ВидыПодарочныхСертификатов.Номинал) КАК Номинал
	|ПОМЕСТИТЬ ПогашениеПоОрганизациям
	|ИЗ
	|	ПогашениеПодарочныхСертификатов КАК ПогашениеПодарочныхСертификатов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПодарочныеСертификаты КАК ПодарочныеСертификаты
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыПодарочныхСертификатов КАК ВидыПодарочныхСертификатов
	|			ПО ПодарочныеСертификаты.Владелец = ВидыПодарочныхСертификатов.Ссылка
	|				И НЕ ВидыПодарочныхСертификатов.ЧастичнаяОплата
	|		ПО ПогашениеПодарочныхСертификатов.ПодарочныйСертификат = ПодарочныеСертификаты.Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОплатаПодарочнымСертификатомИтого.Сумма КАК Сумма,
	|	ПогашениеПоОрганизациям.Номинал КАК Номинал,
	|	ПогашениеПоОрганизациям.Номинал - ОплатаПодарочнымСертификатомИтого.Сумма КАК Разница
	|ИЗ
	|	ОплатаПодарочнымСертификатомИтого КАК ОплатаПодарочнымСертификатомИтого
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПогашениеПоОрганизациям КАК ПогашениеПоОрганизациям
	|		ПО (ИСТИНА)
	|ГДЕ
	|	ОплатаПодарочнымСертификатомИтого.Сумма < ПогашениеПоОрганизациям.Номинал";
	
	Возврат ТекстЗапроса;
	
КонецФункции

// При обнаружении потери покупателя нужно помести ее во внереализованную прибыль
// Используются при фискализации чека.
//
Процедура ДобавитьВнереализационнуюПрибыль(Знач ДокументСсылка, ОбщиеПараметры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаПоВнереализациннойПрибылиДляФмскализации();
	
	Запрос.УстановитьПараметр("ПогашениеПодарочныхСертификатов",ДокументСсылка.ПодарочныеСертификаты.Выгрузить());
	Запрос.УстановитьПараметр("ОплатаПодарочнымСертификатом", 	ДокументСсылка.ПодарочныеСертификаты.Выгрузить());
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат
	КонецЕсли;
	
	ТаблицаЗапроса = Результат.Выгрузить();
	ПотериПокупателя = ТаблицаЗапроса.Итог("Разница");
	
	Если ПотериПокупателя > 0 Тогда
		
		СтрокаПозицииЧека = МенеджерОборудованияКлиентСервер.ПараметрыФискальнойСтрокиЧека(); 
		СтрокаПозицииЧека.Количество = 1;
		СтрокаПозицииЧека.Наименование = "8";
		Если ОбщиеПараметры.ПозицииЧека.Количество() > 0 Тогда
			ПоследняяПозиция = ОбщиеПараметры.ПозицииЧека[ОбщиеПараметры.ПозицииЧека.Количество() - 1];
			СтрокаПозицииЧека.НомерСекции = ПоследняяПозиция.НомерСекции;
		Иначе
			СтрокаПозицииЧека.НомерСекции = 1;
		КонецЕсли; 
		
		СтрокаПозицииЧека.НомерСтрокиТовара      = ОбщиеПараметры.ПозицииЧека.Количество();
		СтрокаПозицииЧека.ПризнакПредметаРасчета = Перечисления.ПризнакиПредметаРасчета.ВнереализационныйДоход;
		СтрокаПозицииЧека.ПризнакСпособаРасчета  = Перечисления.ПризнакиСпособаРасчета.ПередачаСПолнойОплатой;
		СтрокаПозицииЧека.СтавкаНДС              = Неопределено;
		СтрокаПозицииЧека.Сумма                  = ПотериПокупателя;
		СтрокаПозицииЧека.Цена                   = ПотериПокупателя;
		СтрокаПозицииЧека.ЦенаСоСкидками         = ПотериПокупателя;
		
		ОбщиеПараметры.ПозицииЧека.Добавить(СтрокаПозицииЧека);
		
		СтрокаТаблицыОплат = МенеджерОборудованияКлиентСервер.ПараметрыСтрокиОплаты();
		СтрокаТаблицыОплат.Сумма     = ПотериПокупателя;
		СтрокаТаблицыОплат.ТипОплаты = Перечисления.ТипыОплатыККТ.Предоплата;
		ОбщиеПараметры.ТаблицаОплат.Добавить(СтрокаТаблицыОплат);
		
	КонецЕсли;
	
КонецПроцедуры // ДобавитьВнереализационнуюПрибыль()

// Формирует список операций к фискализации по документу и помещает их в очередь
//
// Параметры:
//  ДокументСсылка - ДокументСсылка - ссылка на документ для которого необходимо сформировать очередь чеков
//
Процедура СформироватьОчередьЧеков(ДокументСсылка) Экспорт
	
	ПодключаемоеОборудованиеУТСервер.УдалитьНеФискализированныеЧекиИзОчереди(ДокументСсылка);
	
	МенеджерОбъекта = ОбщегоНазначения.МенеджерОбъектаПоСсылке(ДокументСсылка);
	
	МассивЧеков = МенеджерОбъекта.СобратьДанныеЧеков(ДокументСсылка);
	Для Каждого Чек Из МассивЧеков Цикл
		МенеджерОборудованияВызовСервера.ДобавитьЧекВОчередьЧековККТ(Чек);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Служебная структура "подключенное оборудование"
// 
// Возвращаемое значение:
//  Структура - с полями
//   * ККТ - подключенное оборудование типа "ККТ"
//   * Терминал - подключенное оборудование типа "ЭквайринговыйТерминал"
//
Функция СтруктураПодключенноеОборудование()
	
	Результат = Новый Структура;
	Результат.Вставить("Терминал");
	Результат.Вставить("ККТ");
	Возврат Результат;
	
КонецФункции

Процедура ЗаполнитьСтрокуПоДаннымРазбораШтрихкода(СтрокаПозицииЧека, СтрокаДляДобавленияВЧек)
	
	ВидПродукции = Неопределено;
	Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "ОсобенностьУчета")
        И ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(СтрокаДляДобавленияВЧек, "Штрихкод")
		И ЗначениеЗаполнено(СтрокаДляДобавленияВЧек.ОсобенностьУчета)
		И ЗначениеЗаполнено(СтрокаДляДобавленияВЧек.Штрихкод) Тогда
		ВидПродукции = ИнтеграцияИСУТКлиентСервер.ОсобенностьУчетаПоВидуПродукции(СтрокаДляДобавленияВЧек.ОсобенностьУчета);
	КонецЕсли;
	
	Если Не (ЗначениеЗаполнено(ВидПродукции) И ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(ВидПродукции, Истина)) Тогда
		Возврат;
	КонецЕсли;
	
	ТипМаркировкиККТ = ИнтеграцияИСКлиентСервер.ТипМаркировкиККТПоВидуПродукции(ВидПродукции);
	Если Не ЗначениеЗаполнено(ТипМаркировкиККТ) Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеРазбора = ШтрихкодированиеИССлужебный.РазобратьКодМаркировки(СтрокаДляДобавленияВЧек.Штрихкод, ВидПродукции);
	Если ДанныеРазбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаПозицииЧека.Штрихкод                                                              = СтрокаДляДобавленияВЧек.Штрихкод;
	СтрокаПозицииЧека.ДанныеКодаТоварнойНоменклатуры.ТипМаркировки                          = ТипМаркировкиККТ;
	СтрокаПозицииЧека.ДанныеКодаТоварнойНоменклатуры.ГлобальныйИдентификаторТорговойЕдиницы = ДанныеРазбора.СоставКодаМаркировки.GTIN;
	СтрокаПозицииЧека.ДанныеКодаТоварнойНоменклатуры.СерийныйНомер                          = ДанныеРазбора.СоставКодаМаркировки.СерийныйНомер;
	
КонецПроцедуры

#КонецОбласти
