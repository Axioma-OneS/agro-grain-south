﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И( ЗначениеРазрешено(КассаККМ)
	|	ИЛИ ЗначениеРазрешено(Касса)
	|	) ";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Определяет список команд создания на основании.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	БизнесПроцессы.Задание.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
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
	
	ВариантыОтчетовУТПереопределяемый.ДобавитьКомандуСтруктураПодчиненности(КомандыОтчетов);
	
КонецПроцедуры


#Область Проведение

Функция ДополнительныеИсточникиДанныхДляДвижений(ИмяРегистра) Экспорт

	ИсточникиДанных = Новый Соответствие;

	Возврат ИсточникиДанных; 

КонецФункции

Функция АдаптированныйТекстЗапросаДвиженийПоРегистру(ИмяРегистра) Экспорт
	
	Запрос = Новый Запрос;
	ТекстыЗапроса = Новый СписокЗначений;
	
	ПолноеИмяДокумента = "Документ.ВнесениеДенежныхСредствВКассуККМ";
	
	Если ИмяРегистра = "РеестрДокументов" Тогда
		ТекстЗапроса = ТекстЗапросаТаблицаРеестрДокументов(Запрос, ТекстыЗапроса, ИмяРегистра);
	Иначе
		ТекстИсключения = НСтр("ru = 'В документе %ПолноеИмяДокумента% не реализована адаптация текста запроса формирования движений по регистру %ИмяРегистра%.'");
		ТекстИсключения = СтрЗаменить(ТекстИсключения, "%ПолноеИмяДокумента%", ПолноеИмяДокумента);
		ТекстИсключения = СтрЗаменить(ТекстИсключения, "%ИмяРегистра%", ИмяРегистра);
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	Если ИмяРегистра = "РеестрДокументов" Тогда
		ТекстЗапроса = ОбновлениеИнформационнойБазыУТ.АдаптироватьЗапросПроведенияПоНезависимомуРегистру(
			ТекстЗапроса, ПолноеИмяДокумента, "", Ложь);
	Иначе
		ТекстЗапроса = ОбновлениеИнформационнойБазыУТ.АдаптироватьЗапросМеханизмаПроведения(
			ТекстЗапроса, ПолноеИмяДокумента, "");
	КонецЕсли;
	
	Результат = ОбновлениеИнформационнойБазыУТ.РезультатАдаптацииЗапроса();
	Результат.ЗначенияПараметров = ЗначенияПараметровПроведения();
	Результат.ТекстЗапроса = ТекстЗапроса;
	
	Возврат Результат;
	
КонецФункции

Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	////////////////////////////////////////////////////////////////////////////
	// Создадим запрос инициализации движений
	
	Запрос = Новый Запрос;
	ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка);
	
	////////////////////////////////////////////////////////////////////////////
	// Сформируем текст запроса
	ТекстыЗапроса = Новый СписокЗначений;
	ТекстЗапросаТаблицаДенежныеСредстваВКассахККМ(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаДенежныеСредстваВПути(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаДвиженияДенежныхСредств(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаСуммыДокументовВВалютеРегл(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаРеестрДокументов(Запрос, ТекстыЗапроса, Регистры);
	
	ПроведениеСерверУТ.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений, Истина);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ДанныеДокумента.Ссылка                  КАК Ссылка,
	|	ДанныеДокумента.Дата                    КАК Период,
	|	ДанныеДокумента.Номер                   КАК Номер,
	|	ДанныеДокумента.Валюта                  КАК Валюта,
	|	ДанныеДокумента.Организация             КАК Организация,
	|	ДанныеДокумента.КассаККМ                КАК КассаККМ,
	|	ДанныеДокумента.Комментарий             КАК Комментарий,
	|	ДанныеДокумента.СуммаДокумента          КАК СуммаДокумента,
	|	ДанныеДокумента.ПометкаУдаления         КАК ПометкаУдаления,
	|	ДанныеДокумента.Проведен                КАК Проведен
	|ИЗ
	|	Документ.ВнесениеДенежныхСредствВКассуККМ КАК ДанныеДокумента
	|	
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|";
	
	Результат = Запрос.Выполнить();
	Реквизиты = Результат.Выбрать();
	Реквизиты.Следующий();
	
	Для Каждого Колонка Из Результат.Колонки Цикл
		Запрос.УстановитьПараметр(Колонка.Имя, Реквизиты[Колонка.Имя]);
	КонецЦикла;
	
	Для каждого КлючИЗначение Из ЗначенияПараметровПроведения(Реквизиты) Цикл
		Запрос.УстановитьПараметр(КлючИЗначение.Ключ, КлючИЗначение.Значение);
	КонецЦикла;
	
КонецПроцедуры

Функция ЗначенияПараметровПроведения(Реквизиты = Неопределено)
	
	Значения = Новый Структура;
	Значения.Вставить("ИдентификаторМетаданных",                       ОбщегоНазначения.ИдентификаторОбъектаМетаданных("Документ.ВнесениеДенежныхСредствВКассуККМ"));
	Значения.Вставить("ХозяйственнаяОперация",                         Перечисления.ХозяйственныеОперации.ВнесениеДенежныхСредствВКассуККМ);
	Значения.Вставить("ВалютаУправленческогоУчета",                    Константы.ВалютаУправленческогоУчета.Получить());
	Значения.Вставить("ВалютаРегламентированногоУчета",                Константы.ВалютаРегламентированногоУчета.Получить());
	
	Если Реквизиты <> Неопределено Тогда
		Коэффициенты = РаботаСКурсамивалютУТ.ПолучитьКоэффициентыПересчетаВалюты(
			Реквизиты.Валюта, Неопределено, Реквизиты.Период);
			
		Значения.Вставить("КоэффициентПересчетаВВалютуУпр",            Коэффициенты.КоэффициентПересчетаВВалютуУпр);
		Значения.Вставить("КоэффициентПересчетаВВалютуРегл",           Коэффициенты.КоэффициентПересчетаВВалютуРегл);
		Значения.Вставить("НомерНаПечать",                             ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(Реквизиты.Номер));
	КонецЕсли;
	
	Возврат Значения;
	
КонецФункции

Функция ТекстЗапросаТаблицаДенежныеСредстваВКассахККМ(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ДенежныеСредстваВКассахККМ";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ДанныеДокумента.Дата                   КАК Период,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	ДанныеДокумента.Организация            КАК Организация,
	|	ДанныеДокумента.КассаККМ               КАК КассаККМ,
	|	ДанныеДокумента.СуммаДокумента         КАК Сумма,
	|	ВЫРАЗИТЬ(ДанныеДокумента.СуммаДокумента * &КоэффициентПересчетаВВалютуРегл КАК ЧИСЛО(31,2)) КАК СуммаРегл,
	|	ВЫРАЗИТЬ(ДанныеДокумента.СуммаДокумента * &КоэффициентПересчетаВВалютуУпр КАК ЧИСЛО(31,2)) КАК СуммаУпр,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВнесениеДенежныхСредствВКассуККМ) КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиДвиженияДенежныхСредств.ВыдачаДенежныхСредствВДругуюКассу) КАК СтатьяДвиженияДенежныхСредств
	|	
	|ИЗ
	|	Документ.ВнесениеДенежныхСредствВКассуККМ КАК ДанныеДокумента
	|	
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаДенежныеСредстваВПути(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ДенежныеСредстваВПути";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)                                      КАК ВидДвижения,
	|	ДанныеДокумента.Дата                                                        КАК Период,
	|	
	|	ДанныеДокумента.Организация                                                 КАК Организация,
	|	ДанныеДокумента.КассаККМ                                                    КАК Получатель,
	|	НЕОПРЕДЕЛЕНО                                                                КАК Отправитель,
	|	ЗНАЧЕНИЕ(Перечисление.ВидыПереводовДенежныхСредств.ПеремещениеВДругуюКассу) КАК ВидПереводаДенежныхСредств,
	|	НЕОПРЕДЕЛЕНО                                                                КАК Контрагент,
	|	ДанныеДокумента.Валюта                                                      КАК Валюта,
	|	
	|	ДанныеДокумента.СуммаДокумента                                              КАК Сумма,
	|	ВЫРАЗИТЬ(ДанныеДокумента.СуммаДокумента * &КоэффициентПересчетаВВалютуУпр КАК ЧИСЛО(31,2))   КАК СуммаУпр,
	|	ВЫРАЗИТЬ(ДанныеДокумента.СуммаДокумента * &КоэффициентПересчетаВВалютуРегл КАК ЧИСЛО(31,2))  КАК СуммаРегл,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВнесениеДенежныхСредствВКассуККМ) КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиДвиженияДенежныхСредств.ВыдачаДенежныхСредствВДругуюКассу) КАК СтатьяДвиженияДенежныхСредств
	|	
	|ИЗ
	|	Документ.ВнесениеДенежныхСредствВКассуККМ КАК ДанныеДокумента
	|	
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|	И ДанныеДокумента.СуммаДокумента <> 0
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаДвиженияДенежныхСредств(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ДвиженияДенежныхСредств";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ДанныеДокумента.Дата КАК Период,
	|	Значение(Перечисление.ХозяйственныеОперации.ВнесениеДенежныхСредствВКассуККМ) КАК ХозяйственнаяОперация,
	|	ДанныеДокумента.Организация КАК Организация,
	|	ДанныеДокумента.КассаККМ.Подразделение КАК Подразделение,
	|
	|	ДанныеДокумента.Касса КАК ДенежныеСредства,
	|	Значение(Перечисление.ТипыДенежныхСредств.ДенежныеСредстваВПути) КАК ТипДенежныхСредств,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиДвиженияДенежныхСредств.ВыдачаДенежныхСредствВДругуюКассу) КАК СтатьяДвиженияДенежныхСредств,
	|	ДанныеДокумента.Валюта КАК Валюта,
	|	ДанныеДокумента.Валюта КАК КорВалюта,
	|
	|	ДанныеДокумента.КассаККМ КАК КорДенежныеСредства,
	|	Значение(Перечисление.ТипыДенежныхСредств.Наличные) КАК КорТипДенежныхСредств,
	|
	|	ВЫРАЗИТЬ(ДанныеДокумента.СуммаДокумента * &КоэффициентПересчетаВВалютуУпр КАК ЧИСЛО(31,2)) КАК Сумма,
	|	ВЫРАЗИТЬ(ДанныеДокумента.СуммаДокумента * &КоэффициентПересчетаВВалютуРегл КАК ЧИСЛО(31,2)) КАК СуммаРегл,
	|	ДанныеДокумента.СуммаДокумента КАК СуммаВВалюте,
	|	ДанныеДокумента.СуммаДокумента КАК СуммаВКорВалюте,
	|
	|	ДанныеДокумента.Касса КАК ИсточникГФУДенежныхСредств,
	|	НЕОПРЕДЕЛЕНО КАК ИсточникКорГФУДенежныхСредств
	|ИЗ
	|	Документ.ВнесениеДенежныхСредствВКассуККМ КАК ДанныеДокумента
	|	
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;

КонецФункции

Функция ТекстЗапросаТаблицаСуммыДокументовВВалютеРегл(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "СуммыДокументовВВалютеРегл";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	0 КАК НомерСтроки,
	|	&Период КАК Период,
	|	&Валюта КАК Валюта,
	|	"""" КАК ИдентификаторСтроки,
	|	НЕОПРЕДЕЛЕНО КАК СтавкаНДС,
	|	Документ.СуммаДокумента КАК СуммаБезНДС,
	|	0 КАК СуммаНДС,
	|	Документ.СуммаДокумента * &КоэффициентПересчетаВВалютуРегл КАК СуммаБезНДСРегл,
	|	Документ.СуммаДокумента * &КоэффициентПересчетаВВалютуУпр КАК СуммаБезНДСУпр,
	|	0 КАК СуммаНДСРегл,
	|	0 КАК СуммаНДСУпр,
	|	НЕОПРЕДЕЛЕНО КАК ТипРасчетов
	|ИЗ
	|	Документ.ВнесениеДенежныхСредствВКассуККМ КАК Документ
	|ГДЕ
	|	Документ.Ссылка = &Ссылка
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции


Функция ТекстЗапросаТаблицаРеестрДокументов(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "РеестрДокументов";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	&ИдентификаторМетаданных                КАК ТипСсылки,
	|	&ХозяйственнаяОперация                  КАК ХозяйственнаяОперация,
	|	&Организация                            КАК Организация,
	|	НЕОПРЕДЕЛЕНО                            КАК Партнер,
	|	&КассаККМ                               КАК МестоХранения,
	|	НЕОПРЕДЕЛЕНО                            КАК Контрагент,
	|	НЕОПРЕДЕЛЕНО                            КАК Подразделение,
	|	&Период                                 КАК ДатаДокументаИБ,
	|	&Ссылка                                 КАК Ссылка,
	
	|	&Номер                                  КАК НомерДокументаИБ,
	|	НЕОПРЕДЕЛЕНО                            КАК Статус,
	|	НЕОПРЕДЕЛЕНО                            КАК Ответственный,
	|	ЛОЖЬ                                    КАК ДополнительнаяЗапись,
	|	НЕОПРЕДЕЛЕНО                            КАК Дополнительно,
	|	&Комментарий                            КАК Комментарий,
	|	&Проведен                               КАК Проведен,
	|	&ПометкаУдаления                        КАК ПометкаУдаления,
	|	&Период                                 КАК ДатаПервичногоДокумента,
	|	&НомерНаПечать                          КАК НомерПервичногоДокумента,
	|	&СуммаДокумента                         КАК Сумма,
	|	&Валюта                                 КАК Валюта,
	|	НЕОПРЕДЕЛЕНО                            КАК Договор,
	|	НЕОПРЕДЕЛЕНО                            КАК НаправлениеДеятельности,
	|	&Период                                 КАК ДатаОтраженияВУчете
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
