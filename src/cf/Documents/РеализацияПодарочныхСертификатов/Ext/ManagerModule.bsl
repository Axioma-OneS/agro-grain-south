﻿#Область ОбработчикиСобытий

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если ВидФормы = "ФормаОбъекта" Тогда
		
		Если (Параметры.Свойство("Основание")
			И ЗначениеЗаполнено(Параметры.Основание))
			ИЛИ (Параметры.Свойство("Ключ") И Не ЗначениеЗаполнено(Параметры.Ключ)) Тогда
			
			СтандартнаяОбработка = Ложь;
			ВыбраннаяФорма = "ФормаДокументаРМК";
			
		ИначеЕсли Параметры.Свойство("Ключ") И ЗначениеЗаполнено(Параметры.Ключ) Тогда
			
			СтандартнаяОбработка = Ложь;
			ВыбраннаяФорма = "ФормаДокумента";
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Определяет список команд создания на основании.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	Документы.ВозвратПодарочныхСертификатов.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
КонецПроцедуры

// Добавляет команду создания документа "Реализация подарочных сертификатов".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	Если ПравоДоступа("Добавление", Метаданные.Документы.РеализацияПодарочныхСертификатов) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РеализацияПодарочныхСертификатов.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = ОбщегоНазначенияУТ.ПредставлениеОбъекта(Метаданные.Документы.РеализацияПодарочныхСертификатов);
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		КомандаСоздатьНаОсновании.ФункциональныеОпции = "ИспользоватьПодарочныеСертификаты";
	

		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;

	Возврат Неопределено;
КонецФункции

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

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

Функция ДополнительныеИсточникиДанныхДляДвижений(ИмяРегистра) Экспорт

	ИсточникиДанных = Новый Соответствие;

	Возврат ИсточникиДанных; 

КонецФункции

Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	////////////////////////////////////////////////////////////////////////////
	// Создадим запрос инициализации движений
	
	Запрос = Новый Запрос;
	ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка);
	
	////////////////////////////////////////////////////////////////////////////
	// Сформируем текст запроса
	
	ТекстыЗапроса = Новый СписокЗначений;
	ТекстЗапросаПодарочныеСертификаты(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаИсторияПодарочныхСертификатов(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаДенежныеСредстваВКассахККМ(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаРасчетыПоЭквайрингу(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаДенежныеСредстваВПути(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаДвиженияДенежныеСредстваКонтрагент(Запрос, ТекстыЗапроса, Регистры);
	
	ПроведениеСерверУТ.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений, Истина);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	РеализацияПодарочныхСертификатов.Дата         КАК Дата,
	|	РеализацияПодарочныхСертификатов.Организация  КАК Организация,
	|	РеализацияПодарочныхСертификатов.Валюта       КАК Валюта,
	|	РеализацияПодарочныхСертификатов.Статус       КАК Статус
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов КАК РеализацияПодарочныхСертификатов
	|ГДЕ
	|	РеализацияПодарочныхСертификатов.Ссылка = &Ссылка";
	
	Реквизиты = Запрос.Выполнить().Выбрать();
	Реквизиты.Следующий();
	
	Запрос.УстановитьПараметр("Ссылка",                ДокументСсылка);
	Запрос.УстановитьПараметр("Период",                Реквизиты.Дата);
	Запрос.УстановитьПараметр("Валюта",                Реквизиты.Валюта);
	Запрос.УстановитьПараметр("Организация",           Реквизиты.Организация);
	Запрос.УстановитьПараметр("ХозяйственнаяОперация", Перечисления.ХозяйственныеОперации.РеализацияВРозницу);
	Запрос.УстановитьПараметр("СтатьяДвиженияДенежныхСредств", Справочники.СтатьиДвиженияДенежныхСредств.ПоступлениеОплатыОтКлиента);
	Запрос.УстановитьПараметр("ЧекПробит",             Реквизиты.Статус = Перечисления.СтатусыЧековККМ.Пробит);
	
КонецПроцедуры

Процедура УстановитьПараметрыЗапросаКоэффициентыВалют(Запрос)
	
	Если Запрос.Параметры.Свойство("КоэффициентПересчетаВВалютуУпр")
		И Запрос.Параметры.Свойство("КоэффициентПересчетаВВалютуРегл") Тогда
		Возврат;
	КонецЕсли;
	
	Коэффициенты = РаботаСКурсамивалютУТ.ПолучитьКоэффициентыПересчетаВалюты(Запрос.Параметры.Валюта,
	                                                                         Запрос.Параметры.Валюта,
	                                                                         Запрос.Параметры.Период);
	
	Запрос.УстановитьПараметр("КоэффициентПересчетаВВалютуУпр",  Коэффициенты.КоэффициентПересчетаВВалютуУпр);
	Запрос.УстановитьПараметр("КоэффициентПересчетаВВалютуРегл", Коэффициенты.КоэффициентПересчетаВВалютуРегл);
	
КонецПроцедуры

Функция ТекстЗапросаПодарочныеСертификаты(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ПодарочныеСертификаты";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	УстановитьПараметрыЗапросаКоэффициентыВалют(Запрос);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	&Период                                                 КАК Период,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)                  КАК ВидДвижения,
	|	ТабличнаяЧасть.ПодарочныйСертификат                     КАК ПодарочныйСертификат,
	|	ТабличнаяЧасть.ПодарочныйСертификат.Владелец.Номинал    КАК Сумма,
	|	ТабличнаяЧасть.Сумма * &КоэффициентПересчетаВВалютуРегл КАК СуммаРегл
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ПодарочныеСертификаты КАК ТабличнаяЧасть
	|ГДЕ
	|	ТабличнаяЧасть.Ссылка = &Ссылка
	|	И &ЧекПробит";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаИсторияПодарочныхСертификатов(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ИсторияПодарочныхСертификатов";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	&Период                                                          КАК Период,
	|	ТабличнаяЧасть.ПодарочныйСертификат                              КАК ПодарочныйСертификат,
	|	ЗНАЧЕНИЕ(Перечисление.СтатусыПодарочныхСертификатов.Активирован) КАК Статус
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ПодарочныеСертификаты КАК ТабличнаяЧасть
	|ГДЕ
	|	ТабличнаяЧасть.Ссылка = &Ссылка
	|	И &ЧекПробит";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаВтТаблицаСуммаПлатежнымиКартами(Запрос, ТекстыЗапроса)
	
	ИмяРегистра = "ВтТаблицаСуммаПлатежнымиКартами";
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	СУММА(ТабличнаяЧасть.Сумма) КАК Сумма
	|ПОМЕСТИТЬ ВтТаблицаСуммаПлатежнымиКартами
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ОплатаПлатежнымиКартами КАК ТабличнаяЧасть
	|ГДЕ
	|	ТабличнаяЧасть.Ссылка = &Ссылка";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаДенежныеСредстваВКассахККМ(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ДенежныеСредстваВКассахККМ";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 

	Если Не ПроведениеСерверУТ.ЕстьТаблицаЗапроса("ВтТаблицаСуммаПлатежнымиКартами", ТекстыЗапроса) Тогда
		ТекстЗапросаВтТаблицаСуммаПлатежнымиКартами(Запрос, ТекстыЗапроса);
	КонецЕсли; 
	
	УстановитьПараметрыЗапросаКоэффициентыВалют(Запрос);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ДанныеДокумента.Дата КАК Период,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	ДанныеДокумента.КассаККМ.Владелец КАК Организация,
	|	ДанныеДокумента.КассаККМ КАК КассаККМ,
	|	ДанныеДокумента.СуммаДокумента - ЕСТЬNULL(ТаблицаСуммаПлатежнымиКартами.Сумма, 0) КАК Сумма,
	|	ВЫРАЗИТЬ((ДанныеДокумента.СуммаДокумента - ЕСТЬNULL(ТаблицаСуммаПлатежнымиКартами.Сумма, 0)) * &КоэффициентПересчетаВВалютуРегл КАК ЧИСЛО(31,2)) КАК СуммаРегл,
	|	ВЫРАЗИТЬ((ДанныеДокумента.СуммаДокумента - ЕСТЬNULL(ТаблицаСуммаПлатежнымиКартами.Сумма, 0)) * &КоэффициентПересчетаВВалютуУпр КАК ЧИСЛО(31,2)) КАК СуммаУпр,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента) КАК ХозяйственнаяОперация,
	|	&СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов КАК ДанныеДокумента
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВтТаблицаСуммаПлатежнымиКартами КАК ТаблицаСуммаПлатежнымиКартами
	|		ПО (ИСТИНА)
	|ГДЕ
	|	ДанныеДокумента.СуммаДокумента - ЕСТЬNULL(ТаблицаСуммаПлатежнымиКартами.Сумма, 0) <> 0
	|	И ДанныеДокумента.Ссылка = &Ссылка
	|	И &ЧекПробит";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаРасчетыПоЭквайрингу(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "РасчетыПоЭквайрингу";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТаблицаПлатежей.НомерСтроки КАК НомерСтроки,
	|	&Период КАК Период,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыДенежныхСредствПоЭквайрингу.ПоступлениеПоПлатежнойКарте) КАК ТипДенежныхСредств,
	|	&Организация КАК Организация,
	|	&Валюта КАК Валюта,
	|	ТаблицаПлатежей.ЭквайринговыйТерминал КАК ЭквайринговыйТерминал,
	|	ТаблицаПлатежей.КодАвторизации КАК КодАвторизации,
	|	ТаблицаПлатежей.НомерПлатежнойКарты КАК НомерПлатежнойКарты,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиентаПоПлатежнойКарте) КАК ХозяйственнаяОперация,
	|	&СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	&Период КАК ДатаПлатежа,
	|	ТаблицаПлатежей.Сумма
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ОплатаПлатежнымиКартами КАК ТаблицаПлатежей
	|
	|ГДЕ
	|	&ЧекПробит
	|	И ТаблицаПлатежей.Ссылка = &Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаДенежныеСредстваВПути(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ДенежныеСредстваВПути";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	УстановитьПараметрыЗапросаКоэффициентыВалют(Запрос);
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ТаблицаПлатежей.НомерСтроки                                                          КАК НомерСтроки,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)                                               КАК ВидДвижения,
	|	&Период                                                                              КАК Период,
	|
	|	&Организация                                                                         КАК Организация,
	|	ТаблицаПлатежей.ЭквайринговыйТерминал.БанковскийСчет                                 КАК Получатель,
	|	ЗНАЧЕНИЕ(Перечисление.ВидыПереводовДенежныхСредств.ПоступлениеОтБанкаПоЭквайрингу)   КАК ВидПереводаДенежныхСредств,
	|	ТаблицаПлатежей.ЭквайринговыйТерминал.Эквайер                                        КАК Контрагент,
	|	НЕОПРЕДЕЛЕНО                                                                         КАК ПлатежныйДокумент,
	|	&Валюта                                                                              КАК Валюта,
	|
	|	ТаблицаПлатежей.Сумма                                                                КАК Сумма,
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуУпр КАК Число(15,2))    КАК СуммаУпр,
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуРегл КАК Число(15,2))   КАК СуммаРегл,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиентаПоПлатежнойКарте) КАК ХозяйственнаяОперация,
	|	&СтатьяДвиженияДенежныхСредств                                                       КАК СтатьяДвиженияДенежныхСредств
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ОплатаПлатежнымиКартами КАК ТаблицаПлатежей
	|
	|ГДЕ
	|	&ЧекПробит
	|	И ТаблицаПлатежей.Ссылка = &Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаДвиженияДенежныеСредстваКонтрагент(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ДвиженияДенежныеСредстваКонтрагент";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ИнициализироватьВтДвиженияДенежныеСредстваКонтрагент(Запрос);
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Таблица.Период,
	|	Таблица.ХозяйственнаяОперация,
	|	Таблица.Организация,
	|	Таблица.Подразделение,
	|
	|	Таблица.ДенежныеСредства,
	|	Таблица.НаправлениеДеятельностиДС,
	|	Таблица.ТипДенежныхСредств,
	|	Таблица.ВалютаПлатежа,
	|	Таблица.СтатьяДвиженияДенежныхСредств,
	|
	|	Таблица.Партнер,
	|	Таблица.Контрагент,
	|	Таблица.НаправлениеДеятельностиДС КАК НаправлениеДеятельностиКонтрагента,
	|	Таблица.Договор,
	|	Таблица.ОбъектРасчетов,
	|
	|	Таблица.СуммаОплаты,
	|	Таблица.СуммаОплатыРегл,
	|	Таблица.СуммаОплатыВВалютеПлатежа,
	|
	|	Таблица.СуммаПостоплаты,
	|	Таблица.СуммаПостоплатыРегл,
	|	Таблица.СуммаПостоплатыВВалютеПлатежа,
	|	
	|	Таблица.СуммаПредоплаты,
	|	Таблица.СуммаПредоплатыРегл,
	|	Таблица.СуммаПредоплатыВВалютеПлатежа,
	|
	|	Таблица.ВалютаВзаиморасчетов,
	|
	|	Таблица.СуммаОплатыВВалютеВзаиморасчетов,
	|	Таблица.СуммаПостоплатыВВалютеВзаиморасчетов,
	|	Таблица.СуммаПредоплатыВВалютеВзаиморасчетов,
	|
	|	Таблица.ИсточникГФУДенежныхСредств,
	|	Таблица.ИсточникГФУРасчетов
	|ИЗ
	|	ВтДвиженияДенежныеСредстваКонтрагент КАК Таблица
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Процедура ИнициализироватьВтДвиженияДенежныеСредстваКонтрагент(Запрос)
	
	Если Запрос.Параметры.Свойство("ВтДвиженияДенежныеСредстваКонтрагентИнициализирована") Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПараметрыЗапросаКоэффициентыВалют(Запрос);
	
	ЗапросИнициализации = Новый Запрос("
	|ВЫБРАТЬ
	|	ДанныеДокумента.Дата КАК Период,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента) КАК ХозяйственнаяОперация,
	|	ДанныеДокумента.Организация КАК Организация,
	|	ДанныеДокумента.КассаККМ.Подразделение КАК Подразделение,
	|
	|	ДанныеДокумента.КассаККМ КАК ДенежныеСредства,
	|	ВидыПодарочныхСертификатов.НаправлениеДеятельности КАК НаправлениеДеятельностиДС,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыДенежныхСредств.Наличные) КАК ТипДенежныхСредств,
	|	ДанныеДокумента.Валюта КАК ВалютаПлатежа,
	|	&СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|
	|	НЕОПРЕДЕЛЕНО КАК Партнер,
	|	ЗНАЧЕНИЕ(Справочник.Контрагенты.РозничныйПокупатель) КАК Контрагент,
	|	НЕОПРЕДЕЛЕНО КАК Договор,
	|	ТаблицаПлатежей.ПодарочныйСертификат КАК ОбъектРасчетов,
	|
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуУпр КАК Число(15,2)) КАК СуммаОплаты,
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуРегл КАК Число(15,2)) КАК СуммаОплатыРегл,
	|	ТаблицаПлатежей.Сумма КАК СуммаОплатыВВалютеПлатежа,
	|
	|	0 КАК СуммаПостоплаты,
	|	0 КАК СуммаПостоплатыРегл,
	|	0 КАК СуммаПостоплатыВВалютеПлатежа,
	|	
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуУпр КАК Число(15,2)) КАК СуммаПредоплаты,
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуРегл КАК Число(15,2)) КАК СуммаПредоплатыРегл,
	|	ТаблицаПлатежей.Сумма КАК СуммаПредоплатыВВалютеПлатежа,
	|
	|	ДанныеДокумента.Валюта КАК ВалютаВзаиморасчетов,
	|
	|	0 КАК СуммаОплатыВВалютеВзаиморасчетов,
	|	0 КАК СуммаПостоплатыВВалютеВзаиморасчетов,
	|	0 КАК СуммаПредоплатыВВалютеВзаиморасчетов,
	|
	|	ДанныеДокумента.КассаККМ КАК ИсточникГФУДенежныхСредств,
	|	НЕОПРЕДЕЛЕНО КАК ИсточникГФУРасчетов
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов КАК ДанныеДокумента
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РеализацияПодарочныхСертификатов.ПодарочныеСертификаты КАК ТаблицаПлатежей
	|		ПО ИСТИНА
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыПодарочныхСертификатов КАК ВидыПодарочныхСертификатов
	|		ПО ТаблицаПлатежей.ПодарочныйСертификат.Владелец = ВидыПодарочныхСертификатов.Ссылка
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|	И ТаблицаПлатежей.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеДокумента.Дата КАК Период,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиентаПоПлатежнойКарте) КАК ХозяйственнаяОперация,
	|	ДанныеДокумента.Организация КАК Организация,
	|	БанковскиеСчетаОрганизаций.Подразделение КАК Подразделение,
	|
	|	ТаблицаПлатежей.ЭквайринговыйТерминал.Эквайер КАК ДенежныеСредства,
	|	БанковскиеСчетаОрганизаций.НаправлениеДеятельности КАК НаправлениеДеятельностиДС,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыДенежныхСредств.ДенежныеСредстваУЭквайера) КАК ТипДенежныхСредств,
	|	ДанныеДокумента.Валюта КАК ВалютаПлатежа,
	|	&СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|
	|	НЕОПРЕДЕЛЕНО КАК Партнер,
	|	ЗНАЧЕНИЕ(Справочник.Контрагенты.РозничныйПокупатель) КАК Контрагент,
	|	НЕОПРЕДЕЛЕНО КАК Договор,
	|	НЕОПРЕДЕЛЕНО КАК ОбъектРасчетов,
	|
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуУпр КАК Число(15,2)) КАК СуммаОплаты,
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуРегл КАК Число(15,2)) КАК СуммаОплатыРегл,
	|	ТаблицаПлатежей.Сумма КАК СуммаОплатыВВалютеПлатежа,
	|
	|	0 КАК СуммаПостоплаты,
	|	0 КАК СуммаПостоплатыРегл,
	|	0 КАК СуммаПостоплатыВВалютеПлатежа,
	|	
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуУпр КАК Число(15,2)) КАК СуммаПредоплаты,
	|	ВЫРАЗИТЬ(ТаблицаПлатежей.Сумма * &КоэффициентПересчетаВВалютуРегл КАК Число(15,2)) КАК СуммаПредоплатыРегл,
	|	ТаблицаПлатежей.Сумма КАК СуммаПредоплатыВВалютеПлатежа,
	|
	|	ДанныеДокумента.Валюта КАК ВалютаВзаиморасчетов,
	|
	|	0 КАК СуммаОплатыВВалютеВзаиморасчетов,
	|	ТаблицаПлатежей.Сумма КАК СуммаПостоплатыВВалютеВзаиморасчетов,
	|	0 КАК СуммаПредоплатыВВалютеВзаиморасчетов,
	|
	|	ТаблицаПлатежей.ЭквайринговыйТерминал.БанковскийСчет КАК ИсточникГФУДенежныхСредств,
	|	НЕОПРЕДЕЛЕНО КАК ИсточникГФУРасчетов
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов КАК ДанныеДокумента
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РеализацияПодарочныхСертификатов.ОплатаПлатежнымиКартами КАК ТаблицаПлатежей
	|		ПО ИСТИНА
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчетаОрганизаций
	|		ПО ТаблицаПлатежей.ЭквайринговыйТерминал.БанковскийСчет = БанковскиеСчетаОрганизаций.Ссылка
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|	И ТаблицаПлатежей.Ссылка = &Ссылка
	|");
	
	ЗапросИнициализации.Параметры.Вставить("Ссылка", Запрос.Параметры.Ссылка);
	ЗапросИнициализации.Параметры.Вставить("КоэффициентПересчетаВВалютуУпр", Запрос.Параметры.КоэффициентПересчетаВВалютуУпр);
	ЗапросИнициализации.Параметры.Вставить("КоэффициентПересчетаВВалютуРегл", Запрос.Параметры.КоэффициентПересчетаВВалютуРегл);
	ЗапросИнициализации.Параметры.Вставить("СтатьяДвиженияДенежныхСредств", Запрос.Параметры.СтатьяДвиженияДенежныхСредств);
	
	РезультатЗапроса = ЗапросИнициализации.ВыполнитьПакет();
	ОплатаПодарочныеСертификаты = РезультатЗапроса[0].Выгрузить();
	ОплатаПлатежныеКарты        = РезультатЗапроса[1].Выгрузить();
	
	ЗапросПомещениеВоВременнуюТаблицу = Новый Запрос("
	|ВЫБРАТЬ
	|	Таблица.Период,
	|	Таблица.ХозяйственнаяОперация,
	|	Таблица.Организация,
	|	Таблица.Подразделение,
	|
	|	Таблица.ДенежныеСредства,
	|	Таблица.НаправлениеДеятельностиДС,
	|	Таблица.ТипДенежныхСредств,
	|	Таблица.ВалютаПлатежа,
	|	Таблица.СтатьяДвиженияДенежныхСредств,
	|
	|	Таблица.Партнер,
	|	Таблица.Контрагент,
	|	Таблица.Договор,
	|	Таблица.ОбъектРасчетов,
	|
	|	Таблица.СуммаОплаты,
	|	Таблица.СуммаОплатыРегл,
	|	Таблица.СуммаОплатыВВалютеПлатежа,
	|
	|	Таблица.СуммаПостоплаты,
	|	Таблица.СуммаПостоплатыРегл,
	|	Таблица.СуммаПостоплатыВВалютеПлатежа,
	|	
	|	Таблица.СуммаПредоплаты,
	|	Таблица.СуммаПредоплатыРегл,
	|	Таблица.СуммаПредоплатыВВалютеПлатежа,
	|
	|	Таблица.ВалютаВзаиморасчетов,
	|
	|	Таблица.СуммаОплатыВВалютеВзаиморасчетов,
	|	Таблица.СуммаПостоплатыВВалютеВзаиморасчетов,
	|	Таблица.СуммаПредоплатыВВалютеВзаиморасчетов,
	|
	|	Таблица.ИсточникГФУДенежныхСредств,
	|	Таблица.ИсточникГФУРасчетов
	|ПОМЕСТИТЬ ВтДвиженияДенежныеСредстваКонтрагент
	|ИЗ
	|	&Таблица КАК Таблица
	|");
	
	ДвиженияДенежныеСредстваКонтрагент = ПодарочныеСертификатыСервер.ПодготовитьТаблицуДвиженияДенежныеСредстваКонтрагент(
		ОплатаПодарочныеСертификаты,
		ОплатаПлатежныеКарты);
	ЗапросПомещениеВоВременнуюТаблицу.МенеджерВременныхТаблиц = Запрос.МенеджерВременныхТаблиц;
	ЗапросПомещениеВоВременнуюТаблицу.Параметры.Вставить("Таблица", ДвиженияДенежныеСредстваКонтрагент);
	ЗапросПомещениеВоВременнуюТаблицу.Выполнить();
	
	Запрос.УстановитьПараметр("ВтДвиженияДенежныеСредстваКонтрагентИнициализирована", Истина);
	
КонецПроцедуры


#КонецОбласти

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт

	Если ПолучитьФункциональнуюОпцию("ИспользоватьПодарочныеСертификаты") Тогда
		
		// Подарочный сертификат
		КомандаПечати = КомандыПечати.Добавить();
		КомандаПечати.МенеджерПечати = "Обработка.ПечатьПодарочныхСертификатов";
		КомандаПечати.Идентификатор = "ПодарочныйСертификат";
		КомандаПечати.Представление = НСтр("ru = 'Подарочный сертификат'");
		КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
		
	КонецЕсли;

КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
КонецПроцедуры

// Функция получает данные для формирования печатной формы Подарочный сертификат.
//
Функция ПолучитьДанныеДляПечатнойФормыПодарочныйСертификат(ПараметрыПечати, МассивОбъектов) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);

	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ПодарочныеСертификаты.Ссылка        КАК Ссылка,
	|	ПодарочныеСертификаты.Код           КАК СерийныйНомер,
	|	ПодарочныеСертификаты.Штрихкод      КАК Штрихкод,
	|	ПодарочныеСертификаты.МагнитныйКод  КАК МагнитныйКод,
	|	ПодарочныеСертификаты.Владелец.Номинал  КАК Номинал,
	|	ПодарочныеСертификаты.Владелец.Валюта   КАК Валюта
	|ИЗ
	|	Справочник.ПодарочныеСертификаты КАК ПодарочныеСертификаты
	|ГДЕ
	|	ПодарочныеСертификаты.Ссылка В (ВЫБРАТЬ Т.ПодарочныйСертификат ИЗ Документ.РеализацияПодарочныхСертификатов.ПодарочныеСертификаты КАК Т ГДЕ Т.Ссылка В(&МассивДокументов))
	|");
	
	Запрос.УстановитьПараметр("МассивДокументов", МассивОбъектов);
	РезультатЗапроса = Запрос.Выполнить();
	
	СтруктураДанныхДляПечати    = Новый Структура("РезультатЗапроса, ЗаголовокДокумента",
	                                               РезультатЗапроса, НСтр("ru = 'Подарочный сертификат'"));
	
	Если ПривилегированныйРежим() Тогда
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
	Возврат СтруктураДанныхДляПечати;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
