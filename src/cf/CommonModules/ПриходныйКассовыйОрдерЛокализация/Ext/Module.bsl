﻿
#Область ПрограммныйИнтерфейс

#Область ОбработчикиСобытий

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый документ.
//  Отказ - Булево - Признак проведения документа.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то проведение документа выполнено не будет.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ОбработкаПроведения(Объект, Отказ, РежимПроведения) Экспорт
	
	Движения = Объект.Движения;
	ДополнительныеСвойства = Объект.ДополнительныеСвойства;
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//
Процедура ОбработкаУдаленияПроведения(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//  РежимЗаписи - РежимЗаписиДокумента - В параметр передается текущий режим записи документа. Позволяет определить в теле процедуры режим записи.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ПередЗаписью(Объект, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект.<Имя документа> - Исходный документ, который является источником копирования.
//
Процедура ПриКопировании(Объект, ОбъектКопирования) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// Определяет список команд создания на основании.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	
КонецПроцедуры

// Добавляет команду создания документа "Авансовый отчет".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Процедура ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт


КонецПроцедуры

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - Таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	
КонецПроцедуры

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	//++ Локализация
	
	Если ПравоДоступа("Изменение", Метаданные.Документы.ПриходныйКассовыйОрдер) Тогда
		// Приходный кассовый ордер
		КомандаПечати = КомандыПечати.Добавить();
		КомандаПечати.Идентификатор = "КО1";
		КомандаПечати.Представление = НСтр("ru = 'Приходный кассовый ордер'");
		КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	КонецЕсли;
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// Формирует печатные формы.
//
// Параметры:
//  МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//  ПараметрыПечати - Структура - дополнительные настройки печати;
//  КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы (выходной параметр)
//  ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                            представление - имя области в которой был выведен объект (выходной параметр);
//  ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов (выходной параметр).
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	//++ Локализация
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "КО1") Тогда
		
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
			КоллекцияПечатныхФорм,
			"КО1",
			НСтр("ru='Приходный кассовый ордер'"),
			СформироватьПечатнуюФормуКО1(МассивОбъектов, ОбъектыПечати, ПараметрыПечати));
		
	КонецЕсли;
	//-- Локализация
КонецПроцедуры

Процедура СформироватьКомплектПечатныхФорм(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, КомплектПечатныхФорм) Экспорт
	//++ Локализация
	КомплектыПечатиПоОбъектам = РегистрыСведений.НастройкиПечатиОбъектов.КомплектыПечатиПоОбъектам(КоллекцияПечатныхФорм,
		КомплектПечатныхФорм,
		МассивОбъектов,
		"КО1");
	Для Каждого КомплектПечати Из КомплектыПечатиПоОбъектам Цикл
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
			КоллекцияПечатныхФорм,
			КомплектПечати.Имя,
			КомплектПечати.Представление,
			СформироватьПечатнуюФормуКО1(КомплектПечати.Объекты, ОбъектыПечати, ПараметрыПечати));
	КонецЦикла;
	//-- Локализация
КонецПроцедуры

Процедура КомплектПечатныхФорм(КомплектПечатныхФорм) Экспорт
	//++ Локализация
	РегистрыСведений.НастройкиПечатиОбъектов.ДобавитьПечатнуюФормуВКомплект(КомплектПечатныхФорм, "КО1", НСтр("ru = 'Приходный кассовый ордер'"), 1);
	//-- Локализация
КонецПроцедуры

//++ Локализация
Функция СформироватьПечатнуюФормуКО1(МассивОбъектов, ОбъектыПечати, ПараметрыПечати)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_КО1";
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.ПриходныйКассовыйОрдер.ПФ_MXL_КО1_ru");
	Макет.КодЯзыка = Метаданные.Языки.Русский.КодЯзыка;
	
	ИспользуетсяРеглУчет = ПолучитьФункциональнуюОпцию("ИспользоватьРеглУчет") И НЕ ПолучитьФункциональнуюОпцию("УправлениеТорговлей");
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ДанныеДокумента.Ссылка КАК Ссылка,
	|	ДанныеДокумента.Дата КАК ДатаДокумента,
	|	ДанныеДокумента.Номер КАК Номер,
	|	ДанныеДокумента.Организация.Наименование КАК НаименованиеОрганизации,
	|	ДанныеДокумента.Организация.НаименованиеСокращенное КАК НаименованиеОрганизацииСокращенное,
	|	ДанныеДокумента.Организация.Префикс КАК Префикс,
	|	ВЫБОР 
	|		КОГДА ДанныеДокумента.Валюта = &ВалютаРеглУчета
	|			ТОГДА ""50.01""
	|		ИНАЧЕ ""50.21""
	|	КОНЕЦ КАК КодДебета,
	|	ДанныеДокумента.Касса.КассоваяКнига.СтруктурноеПодразделение КАК ПредставлениеПодразделения,
	|	ДанныеДокумента.Контрагент КАК Контрагент,
	|	ДанныеДокумента.Контрагент.Представление КАК КонтрагентПредставление,
	|	ДанныеДокумента.ПринятоОт КАК ПринятоОт,
	|	ДанныеДокумента.Основание КАК Основание,
	|	ДанныеДокумента.Приложение КАК Приложение,
	|	ДанныеДокумента.ВТомЧислеНДС КАК ВТомЧисле,
	|	ДанныеДокумента.СуммаДокумента КАК Сумма,
	|	ДанныеДокумента.Валюта КАК Валюта,
	|	ДанныеДокумента.Валюта.Представление КАК ВалютаПредставление,
	|	ДанныеДокумента.Организация.КодПоОКПО КАК ОрганизацияПоОКПО,
	|	ДанныеДокумента.Кассир.ФизическоеЛицо КАК Кассир,
	|	ТаблицаОтветственныеЛица.ГлавныйБухгалтерНаименование КАК ГлавныйБухгалтер,
	|	ДанныеДокумента.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	ДанныеДокумента.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств
	|ИЗ
	|	Документ.ПриходныйКассовыйОрдер КАК ДанныеДокумента
	|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаОтветственныеЛица КАК ТаблицаОтветственныеЛица
	|		ПО ДанныеДокумента.Ссылка = ТаблицаОтветственныеЛица.Ссылка
	|ГДЕ
	|	ДанныеДокумента.Ссылка В(&МассивДокументов)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Номер
	|;";
	
	Если Не ИспользуетсяРеглУчет Тогда
		ТекстЗапроса = ТекстЗапроса + "
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ВложенныйЗапрос.Ссылка,
		|	ВложенныйЗапрос.СтатьяДвиженияДенежныхСредств,
		|	СтатьиДвиженияДенежныхСредств.КорреспондирующийСчет КАК КорСчетКод
		|ИЗ
		|	(ВЫБРАТЬ РАЗЛИЧНЫЕ
		|		ДанныеДокумента.Ссылка КАК Ссылка,
		|		ДанныеДокумента.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств
		|	ИЗ
		|		Документ.ПриходныйКассовыйОрдер КАК ДанныеДокумента
		|	ГДЕ
		|		ДанныеДокумента.Ссылка В(&МассивДокументов)
		|	
		|	ОБЪЕДИНИТЬ
		|	
		|	ВЫБРАТЬ РАЗЛИЧНЫЕ
		|		РасшифровкаПлатежа.Ссылка,
		|		РасшифровкаПлатежа.СтатьяДвиженияДенежныхСредств
		|	ИЗ
		|		Документ.ПриходныйКассовыйОрдер.РасшифровкаПлатежа КАК РасшифровкаПлатежа
		|	ГДЕ
		|		РасшифровкаПлатежа.Ссылка В(&МассивДокументов)) КАК ВложенныйЗапрос
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СтатьиДвиженияДенежныхСредств КАК СтатьиДвиженияДенежныхСредств
		|		ПО ВложенныйЗапрос.СтатьяДвиженияДенежныхСредств = СтатьиДвиженияДенежныхСредств.Ссылка
		|
		|УПОРЯДОЧИТЬ ПО
		|	КорреспондирующийСчет";
	КонецЕсли;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	ОтветственныеЛицаСервер.СформироватьВременнуюТаблицуОтветственныхЛицДокументов(МассивОбъектов, МенеджерВременныхТаблиц);
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("МассивДокументов", МассивОбъектов);
	Запрос.УстановитьПараметр("ВалютаРеглУчета", Константы.ВалютаРегламентированногоУчета.Получить());
	
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	Выборка           = МассивРезультатов[0].Выбрать();
	КорСчета          = МассивРезультатов[1].Выгрузить();
	
	Пока Выборка.Следующий() Цикл
		
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
		
		ОбластьМакета = Макет.ПолучитьОбласть("Шапка");
		ШтрихкодированиеПечатныхФорм.ВывестиШтрихкодВТабличныйДокумент(ТабличныйДокумент, Макет, ОбластьМакета, Выборка.Ссылка);
		ОбластьМакета.Параметры.Заполнить(Выборка);
		
		Если Не ПустаяСтрока(Выборка.НаименованиеОрганизацииСокращенное) Тогда
			ОбластьМакета.Параметры.ПредставлениеОрганизации = Выборка.НаименованиеОрганизацииСокращенное;
		Иначе
			ОбластьМакета.Параметры.ПредставлениеОрганизации = Выборка.НаименованиеОрганизации;
		КонецЕсли;
		
		Сумма = Формат(Выборка.Сумма, "ЧДЦ=2");
		ВалютаРегламентированногоУчета = Константы.ВалютаРегламентированногоУчета.Получить();
		Если ВалютаРегламентированногоУчета <> Выборка.Валюта Тогда
			Сумма = Сумма + " " + СокрЛП(Выборка.ВалютаПредставление);
		КонецЕсли;
		ОбластьМакета.Параметры.Сумма = Сумма;
		ОбластьМакета.Параметры.СуммаРубКоп = ФормированиеПечатныхФорм.СуммаРубКоп(
			Выборка.Сумма, 
			Выборка.Валюта,	
			ВалютаРегламентированногоУчета);
		Если Выборка.Валюта <> ВалютаРегламентированногоУчета Тогда
			ОбластьМакета.Параметры.СуммаРубКоп = ОбластьМакета.Параметры.СуммаРубКоп + " " + СокрЛП(Выборка.ВалютаПредставление); 
		КонецЕсли;
		ОбластьМакета.Параметры.СуммаПрописью = РаботаСКурсамиВалют.СформироватьСуммуПрописью(
			Выборка.Сумма, 
			Выборка.Валюта, 
			Ложь); // ВыводитьСуммуБезКопеек
		ОбластьМакета.Параметры.НомерДокумента = ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(
			Выборка.Номер, 
			Ложь,
			Истина);
		ОбластьМакета.Параметры.СубСчет = КорреспондирующийСчет(Выборка, КорСчета, ИспользуетсяРеглУчет);
		
		Если ПустаяСтрока(Выборка.ВТомЧисле) Тогда
			ОбластьМакета.Параметры.ВТомЧисле = НСтр("ru='без налога (НДС)'", Метаданные.Языки.Русский.КодЯзыка);
		КонецЕсли;
		
		ОбластьМакета.Параметры.ФИОГлавногоБухгалтера = Выборка.ГлавныйБухгалтер;
		ОбластьМакета.Параметры.ФИОКассира = ФизическиеЛицаУТ.ФамилияИнициалыФизЛица(Выборка.Кассир, Выборка.ДатаДокумента);
		
		ТабличныйДокумент.Вывести(ОбластьМакета);
		
		ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(
			ТабличныйДокумент,
			НомерСтрокиНачало,
			ОбъектыПечати,
			Выборка.Ссылка);
		
	КонецЦикла;
	
	
	Возврат ТабличныйДокумент;
	
КонецФункции

Функция КорреспондирующийСчет(ДанныеДокумента, КорСчета, ИспользуетсяРеглУчет)
	
	Отбор = Новый Структура("Ссылка", ДанныеДокумента.Ссылка);
	КорСчетаДокумента = КорСчета.НайтиСтроки(Отбор);
	Результат = "";
	Для Каждого Счет Из КорСчетаДокумента Цикл
		Результат = Результат + " " + СокрЛП(Счет.КорСчетКод);
	КонецЦикла;
	
	Если Результат = "" И Не ИспользуетсяРеглУчет Тогда
		СтатьяДвиженияДенежныхСредств = Справочники.СтатьиДвиженияДенежныхСредств.ПредопределеннаяСтатьяДДС(ДанныеДокумента.ХозяйственнаяОперация,
																											ДанныеДокумента.Валюта);
		Результат = СтатьяДвиженияДенежныхСредств.КорреспондирующийСчет;
	КонецЕсли;
	Возврат Результат;
	
КонецФункции

//-- Локализация

#КонецОбласти


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
//++ Локализация
//-- Локализация

#КонецОбласти

#КонецОбласти
