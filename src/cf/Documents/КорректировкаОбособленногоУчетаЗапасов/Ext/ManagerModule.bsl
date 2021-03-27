﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

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
	
	БизнесПроцессы.Задание.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
КонецПроцедуры

// Добавляет команду создания документа "Корректировка обособленного учета".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	Если ПравоДоступа("Добавление", Метаданные.Документы.КорректировкаОбособленногоУчетаЗапасов) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.КорректировкаОбособленногоУчетаЗапасов.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = ОбщегоНазначенияУТ.ПредставлениеОбъекта(Метаданные.Документы.КорректировкаОбособленногоУчетаЗапасов);
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		КомандаСоздатьНаОсновании.ФункциональныеОпции = "ФормироватьВидыЗапасовПоПодразделениямМенеджерам,ФормироватьВидыЗапасовПоСделкам";
	

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
	
	Отчеты.ОстаткиТоваровОрганизаций.ДобавитьКомандуОтчета(КомандыОтчетов);
	
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Склад)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Имена реквизитов, от значений которых зависят параметры указания серий
//
//	Возвращаемое значение:
//		Строка - имена реквизитов, перечисленные через запятую.
//
Функция ИменаРеквизитовДляЗаполненияПараметровУказанияСерий() Экспорт
	ИменаРеквизитов = "Склад,Дата";
	
	Возврат ИменаРеквизитов;
КонецФункции

// Возвращает параметры указания серий для товаров, указанных в документе
//
//	Параметры
//			Объект - Структура - структура значений реквизитов объекта, необходимых для заполнения параметров указания серий
//	Возвращаемое значение
//			Тип Структура
//				Состав полей задается в функции ОбработкаТабличнойЧастиКлиентСервер.ПараметрыУказанияСерий.
//
Функция ПараметрыУказанияСерий(Объект) Экспорт
	
	ПараметрыУказанияСерий = НоменклатураКлиентСервер.ПараметрыУказанияСерий();
	
	ПараметрыУказанияСерий.ПолноеИмяОбъекта = "Документ.КорректировкаОбособленногоУчетаЗапасов";
	
	ПараметрыСерийСклада = СкладыСервер.ИспользованиеСерийНаСкладе(Объект.Склад, Ложь);
	
	ПараметрыУказанияСерий.ИмяТЧСерии = "Товары";
	ПараметрыУказанияСерий.УчитыватьСебестоимостьПоСериям = ПараметрыСерийСклада.УчитыватьСебестоимостьПоСериям;
	ПараметрыУказанияСерий.ИспользоватьСерииНоменклатуры  = ПараметрыСерийСклада.УчитыватьСебестоимостьПоСериям;
	
	ПараметрыУказанияСерий.СкладскиеОперации.Добавить(Перечисления.СкладскиеОперации.ПустаяСсылка());
	
	ПараметрыУказанияСерий.ЭтоНакладная = Истина;
	ПараметрыУказанияСерий.ТолькоСерииДляСебестоимости = Истина;
	ПараметрыУказанияСерий.Дата = Объект.Дата;
	
	Возврат ПараметрыУказанияСерий;
КонецФункции

// Возвращает текст запроса расчета статусов указания серий
//		
Функция ТекстЗапросаЗаполненияСтатусовУказанияСерий(ПараметрыУказанияСерий) Экспорт
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	Товары.Номенклатура,
	|	Товары.Характеристика,
	|	Товары.Серия,
	|	Товары.Количество,
	|	Товары.СтатусУказанияСерий,
	|	Товары.НомерСтроки
	|ПОМЕСТИТЬ Товары
	|ИЗ
	|	&Товары КАК Товары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Товары.НомерСтроки КАК НомерСтроки,
	|	Товары.СтатусУказанияСерий КАК СтарыйСтатусУказанияСерий,
	|	ВЫБОР
	|		КОГДА ПолитикиУчетаСерий.ПолитикаУчетаСерий ЕСТЬ NULL 
	|			ТОГДА 0
	|		ИНАЧЕ ВЫБОР
	|				КОГДА ПолитикиУчетаСерий.ПолитикаУчетаСерий.УчитыватьСебестоимостьПоСериям
	|					ТОГДА ВЫБОР
	|							КОГДА Товары.Серия <> ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка)
	|								ТОГДА 14
	|							ИНАЧЕ 13
	|						КОНЕЦ
	|				ИНАЧЕ 0
	|			КОНЕЦ
	|	КОНЕЦ КАК СтатусУказанияСерий
	|ПОМЕСТИТЬ Статусы
	|ИЗ
	|	Товары КАК Товары
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВидыНоменклатуры.ПолитикиУчетаСерий КАК ПолитикиУчетаСерий
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Склады КАК Склады
	|			ПО ПолитикиУчетаСерий.Склад = Склады.Ссылка
	|		ПО (ПолитикиУчетаСерий.Склад = &Склад)
	|			И (ВЫРАЗИТЬ(Товары.Номенклатура КАК Справочник.Номенклатура).ВидНоменклатуры = ПолитикиУчетаСерий.Ссылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Статусы.НомерСтроки КАК НомерСтроки,
	|	Статусы.СтатусУказанияСерий КАК СтатусУказанияСерий
	|ИЗ
	|	Статусы КАК Статусы
	|ГДЕ
	|	Статусы.СтатусУказанияСерий <> Статусы.СтарыйСтатусУказанияСерий
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Возврат ТекстЗапроса;

КонецФункции

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
	ТекстЗапросаТаблицаТоварыОрганизаций(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаДатыПоступленияТоваровОрганизаций(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаСебестоимостьТоваров(Запрос, ТекстыЗапроса, Регистры);
	
	////////////////////////////////////////////////////////////////////////////
	// Поместим результаты запроса в дополнительные свойства
	
	ПроведениеСерверУТ.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений, Истина);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ДанныеДокумента.Дата 				КАК Период,
	|	ДанныеДокумента.Ссылка 				КАК Ссылка,
	|	ДанныеДокумента.Организация 		КАК Организация,
	|	ДанныеДокумента.Склад 				КАК Склад,
	|	ДанныеДокумента.Менеджер 			КАК Менеджер,
	|	ДанныеДокумента.Подразделение 		КАК Подразделение,
	|	ДанныеДокумента.Подразделение.ВариантОбособленногоУчетаТоваров 				КАК ВариантОбособленногоУчетаТоваров,
	|	ДанныеДокумента.Сделка 				КАК Сделка,
	|	ЕСТЬNULL(ДанныеДокумента.Сделка.ОбособленныйУчетТоваровПоСделке, ЛОЖЬ) 		КАК ОбособленныйУчетТоваровПоСделке,
	|	ДанныеДокумента.НовыйМенеджер 		КАК НовыйМенеджер,
	|	ДанныеДокумента.НовоеПодразделение 	КАК НовоеПодразделение,
	|	ДанныеДокумента.НовоеПодразделение.ВариантОбособленногоУчетаТоваров 		КАК НовыйВариантОбособленногоУчетаТоваров,
	|	ДанныеДокумента.НоваяСделка 		КАК НоваяСделка,
	|	ЕСТЬNULL(ДанныеДокумента.НоваяСделка.ОбособленныйУчетТоваровПоСделке, ЛОЖЬ) КАК НовыйОбособленныйУчетТоваровПоСделке
	|ИЗ
	|	Документ.КорректировкаОбособленногоУчетаЗапасов КАК ДанныеДокумента
	|	
	|ГДЕ
	|	ДанныеДокумента.Ссылка = &Ссылка
	|";
	
	Реквизиты = Запрос.Выполнить().Выбрать();
	Реквизиты.Следующий();
	
	Запрос.УстановитьПараметр("Ссылка", 				  				ДокументСсылка);
	Запрос.УстановитьПараметр("Период", 				  				Реквизиты.Период);
	Запрос.УстановитьПараметр("Склад", 					  				Реквизиты.Склад);
	Запрос.УстановитьПараметр("Организация", 			  				Реквизиты.Организация);
	Запрос.УстановитьПараметр("ХозяйственнаяОперация", 	  				Перечисления.ХозяйственныеОперации.КорректировкаОбособленногоУчета);
	Запрос.УстановитьПараметр("Менеджер", 								Реквизиты.Менеджер);
	Запрос.УстановитьПараметр("Подразделение", 							Реквизиты.Подразделение);
	Запрос.УстановитьПараметр("ВариантОбособленногоУчетаТоваров", 		Реквизиты.ВариантОбособленногоУчетаТоваров);
	Запрос.УстановитьПараметр("Сделка", 								Реквизиты.Сделка);
	Запрос.УстановитьПараметр("ОбособленныйУчетТоваровПоСделке", 		Реквизиты.ОбособленныйУчетТоваровПоСделке);
	Запрос.УстановитьПараметр("НовыйМенеджер", 							Реквизиты.НовыйМенеджер);
	Запрос.УстановитьПараметр("НовоеПодразделение", 					Реквизиты.НовоеПодразделение);
	Запрос.УстановитьПараметр("НовыйВариантОбособленногоУчетаТоваров", 	Реквизиты.НовыйВариантОбособленногоУчетаТоваров);
	Запрос.УстановитьПараметр("НоваяСделка", 							Реквизиты.НоваяСделка);
	Запрос.УстановитьПараметр("НовыйОбособленныйУчетТоваровПоСделке",	Реквизиты.НовыйОбособленныйУчетТоваровПоСделке);
	
	РасчетСебестоимостиПрикладныеАлгоритмы.ЗаполнитьПараметрыИнициализации(Запрос, Реквизиты);
	
КонецПроцедуры

Функция ТекстЗапросаТаблицаВтВидыЗапасов(Запрос, ТекстыЗапроса)
	
	ИмяРегистра = "ВтВидыЗапасов"; 
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ТаблицаВидыЗапасов.НомерСтроки                КАК НомерСтроки,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры.Номенклатура                        КАК Номенклатура,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры.Характеристика                      КАК Характеристика,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры.Серия                               КАК Серия,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры.Назначение                          КАК Назначение,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ТаблицаВидыЗапасов.ВидЗапасов                 КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.ВидЗапасовОприходование    КАК ВидЗапасовОприходование,
	|	ТаблицаВидыЗапасов.НомерГТД                   КАК НомерГТД,
	|	ТаблицаВидыЗапасов.Количество                 КАК Количество
	|ПОМЕСТИТЬ ВтВидыЗапасов
	|ИЗ
	|	Документ.КорректировкаОбособленногоУчетаЗапасов.ВидыЗапасов КАК ТаблицаВидыЗапасов
	|ГДЕ
	|	ТаблицаВидыЗапасов.Ссылка = &Ссылка
	|";
		
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;
КонецФункции

Функция ТекстЗапросаТаблицаТоварыОрганизаций(Запрос, ТекстыЗапроса, Регистры);
	
	ИмяРегистра = "ТоварыОрганизаций";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	Если НЕ ПроведениеСерверУТ.ЕстьТаблицаЗапроса("ВтВидыЗапасов", ТекстыЗапроса) Тогда
		ТекстЗапросаТаблицаВтВидыЗапасов(Запрос, ТекстыЗапроса);
	КонецЕсли;

	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	&Период КАК Период,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	&Организация КАК Организация,
	|	&Организация КАК ОрганизацияОтгрузки,
	|	&Склад КАК Склад,
	|	ТаблицаВидыЗапасов.Номенклатура КАК Номенклатура,
	|	ТаблицаВидыЗапасов.Характеристика КАК Характеристика,
	|	ТаблицаВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.НомерГТД КАК НомерГТД,
	|	ТаблицаВидыЗапасов.Количество КАК Количество,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|	&ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	ТаблицаВидыЗапасов.ВидЗапасовОприходование КАК КорВидЗапасов
	|
	|ИЗ
	|	ВтВидыЗапасов КАК ТаблицаВидыЗапасов
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	&Период,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход),
	|	&Организация,
	|	НЕОПРЕДЕЛЕНО,
	|	&Склад,
	|	ТаблицаВидыЗапасов.Номенклатура,
	|	ТаблицаВидыЗапасов.Характеристика,
	|	ТаблицаВидыЗапасов.ВидЗапасовОприходование,
	|	ТаблицаВидыЗапасов.НомерГТД,
	|	ТаблицаВидыЗапасов.Количество,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|	&ХозяйственнаяОперация,
	|	ТаблицаВидыЗапасов.ВидЗапасов КАК КорВидЗапасов
	|
	|ИЗ
	|	ВтВидыЗапасов КАК ТаблицаВидыЗапасов";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;
КонецФункции

Функция ТекстЗапросаТаблицаДатыПоступленияТоваровОрганизаций(Запрос, ТекстыЗапроса, Регистры);
	
	ИмяРегистра = "ДатыПоступленияТоваровОрганизаций";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	Если НЕ ПроведениеСерверУТ.ЕстьТаблицаЗапроса("ВтВидыЗапасов", ТекстыЗапроса) Тогда
		ТекстЗапросаТаблицаВтВидыЗапасов(Запрос, ТекстыЗапроса);
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПоступленияТоваров.ДатаПоступления КАК ДатаПоступления,
	|	ТаблицаВидыЗапасов.Номенклатура КАК Номенклатура,
	|	ТаблицаВидыЗапасов.Характеристика КАК Характеристика,
	|	ТаблицаВидыЗапасов.Серия КАК Серия,
	|	ТаблицаВидыЗапасов.Назначение КАК Назначение,
	|	ТаблицаВидыЗапасов.ВидЗапасовОприходование КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.НомерГТД КАК НомерГТД
	|ИЗ
	|	ВтВидыЗапасов КАК ТаблицаВидыЗапасов
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.ДатыПоступленияТоваровОрганизаций КАК ПоступленияТоваров
	|	ПО
	|		ТаблицаВидыЗапасов.ВидЗапасов = ПоступленияТоваров.ВидЗапасов
	|		И ТаблицаВидыЗапасов.Номенклатура = ПоступленияТоваров.Номенклатура
	|		И ТаблицаВидыЗапасов.Характеристика = ПоступленияТоваров.Характеристика
	|		И ТаблицаВидыЗапасов.Серия = ПоступленияТоваров.Серия
	|		И ТаблицаВидыЗапасов.Назначение = ПоступленияТоваров.Назначение
	|		И ТаблицаВидыЗапасов.НомерГТД = ПоступленияТоваров.НомерГТД
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.ДатыПоступленияТоваровОрганизаций КАК ПоступленияТоваровПолучатель
	|	ПО
	|		ТаблицаВидыЗапасов.ВидЗапасовОприходование = ПоступленияТоваровПолучатель.ВидЗапасов
	|		И ТаблицаВидыЗапасов.Номенклатура = ПоступленияТоваровПолучатель.Номенклатура
	|		И ТаблицаВидыЗапасов.Характеристика = ПоступленияТоваровПолучатель.Характеристика
	|		И ТаблицаВидыЗапасов.Серия = ПоступленияТоваровПолучатель.Серия
	|		И ТаблицаВидыЗапасов.Назначение = ПоступленияТоваровПолучатель.Назначение
	|		И ТаблицаВидыЗапасов.НомерГТД = ПоступленияТоваровПолучатель.НомерГТД
	|
	|ГДЕ
	|	ТаблицаВидыЗапасов.Номенклатура.ТипНоменклатуры В (
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И (ПоступленияТоваровПолучатель.ДатаПоступления ЕСТЬ NULL
	|		ИЛИ ПоступленияТоваровПолучатель.ДатаПоступления < &Период)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ТаблицаВидыЗапасов.Номенклатура,
	|	ТаблицаВидыЗапасов.Характеристика,
	|	ТаблицаВидыЗапасов.Серия,
	|	ТаблицаВидыЗапасов.Назначение,
	|	ТаблицаВидыЗапасов.НомерГТД
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;
КонецФункции

Функция ТекстЗапросаТаблицаСебестоимостьТоваров(Запрос, ТекстыЗапроса, Регистры) Экспорт
		
	ИмяРегистра = "СебестоимостьТоваров";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	Если НЕ ПроведениеСерверУТ.ЕстьТаблицаЗапроса("ВтВидыЗапасов", ТекстыЗапроса) Тогда
		ТекстЗапросаТаблицаВтВидыЗапасов(Запрос, ТекстыЗапроса);
	КонецЕсли;

	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	&Период КАК Период,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	&Организация КАК Организация,
	|	ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаСкладах) КАК РазделУчета,
	|   ТаблицаВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|
	//	партионный учет версии 2.2
	|	ВЫБОР
	|		КОГДА &ПартионныйУчетВерсии22 ТОГДА
	|			ВЫБОР
	|				КОГДА &ФормироватьВидыЗапасовПоСделкам И &ОбособленныйУчетТоваровПоСделке
	|					ТОГДА &Сделка
	|				КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|				 И &ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоМенеджерамПодразделения)
	|					ТОГДА &Менеджер
	|				КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|				 И &ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоПодразделению)
	|					ТОГДА &Подразделение
	|				ИНАЧЕ НЕОПРЕДЕЛЕНО
	|			КОНЕЦ
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ 												 КАК АналитикаФинансовогоУчета,
	|	ВЫБОР
	|		КОГДА &ФормироватьВидыЗапасовПоСделкам И &НовыйОбособленныйУчетТоваровПоСделке
	|			ТОГДА &НоваяСделка
	|		КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|		 И &НовыйВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоМенеджерамПодразделения)
	|			ТОГДА &НовыйМенеджер
	|		КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|		 И &НовыйВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоПодразделению)
	|			ТОГДА &НовоеПодразделение
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ 												 КАК КорАналитикаФинансовогоУчета,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗаписейПартий.Потребление) КАК ТипЗаписи,
	|
	|	ТаблицаВидыЗапасов.Количество КАК Количество,
	|	0 КАК Стоимость,
	|	&ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаСкладах) КАК КорРазделУчета,
	|	ТаблицаВидыЗапасов.ВидЗапасовОприходование КАК КорВидЗапасов,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|	Неопределено КАК АналитикаУчетаПоПартнерам,
	|	Неопределено КАК Подразделение
	|ИЗ
	|	ВтВидыЗапасов КАК ТаблицаВидыЗапасов
	|ГДЕ
	|	ТаблицаВидыЗапасов.ВидЗапасов.ТипЗапасов = ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.Товар)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	&Период КАК Период,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	&Организация КАК Организация,
	|	ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаСкладах) КАК РазделУчета,
	|	ТаблицаВидыЗапасов.ВидЗапасовОприходование КАК ВидЗапасов,
	|
	//	партионный учет версии 2.2
	|	ВЫБОР
	|		КОГДА &ПартионныйУчетВерсии22 ТОГДА
	|			ВЫБОР
	|				КОГДА &ФормироватьВидыЗапасовПоСделкам И &НовыйОбособленныйУчетТоваровПоСделке
	|					ТОГДА &НоваяСделка
	|				КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|				 И &НовыйВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоМенеджерамПодразделения)
	|					ТОГДА &НовыйМенеджер
	|				КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|				 И &НовыйВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоПодразделению)
	|					ТОГДА &НовоеПодразделение
	|				ИНАЧЕ НЕОПРЕДЕЛЕНО
	|			КОНЕЦ
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ 												 КАК АналитикаФинансовогоУчета,
	|	ВЫБОР
	|		КОГДА &ФормироватьВидыЗапасовПоСделкам И &ОбособленныйУчетТоваровПоСделке
	|			ТОГДА &Сделка
	|		КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|		 И &ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоМенеджерамПодразделения)
	|			ТОГДА &Менеджер
	|		КОГДА &ФормироватьВидыЗапасовПоПодразделениямМенеджерам
	|		 И &ВариантОбособленногоУчетаТоваров = ЗНАЧЕНИЕ(Перечисление.ВариантыОбособленногоУчетаТоваров.ПоПодразделению)
	|			ТОГДА &Подразделение
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ 												 КАК КорАналитикаФинансовогоУчета,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗаписейПартий.Перемещение) КАК ТипЗаписи,
	|
	|	ТаблицаВидыЗапасов.Количество КАК Количество,
	|	0 КАК Стоимость,
	|	&ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаСкладах) КАК КорРазделУчета,
	|   ТаблицаВидыЗапасов.ВидЗапасов КАК КорВидЗапасов,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|	Неопределено КАК АналитикаУчетаПоПартнерам,
	|	Неопределено КАК Подразделение
	|
	|ИЗ
	|	ВтВидыЗапасов КАК ТаблицаВидыЗапасов
	|ГДЕ
	|	ТаблицаВидыЗапасов.ВидЗапасов.ТипЗапасов = ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.Товар)";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;
КонецФункции

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

#КонецОбласти

#КонецОбласти

#КонецЕсли
