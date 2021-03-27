﻿///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Повторно используемые значения для механизмов
//	- партионного учета версии 2.2
//	- расчета себестоимости
//	- закрытия месяца.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ТипыЗаписейПартий

// Возвращает правила заполнения полей в первичных движениях документов по регистру "Себестоимость товаров".
//
// Параметры:
//	ИмяДокументаДляОтбора - Строка - имя документа для отбора строк таблицы; если не указано, то выводится таблица по всем документам
//
// Возвращаемое значение:
//	ТаблицаЗначений - правила заполнения записей, полученные из макета регистра накопления СебестоимостьТоваров
//
Функция ПравилаЗаполненияПоляТипЗаписи(ИмяДокументаДляОтбора = "") Экспорт
	
	ТаблицаПравил = Новый ТаблицаЗначений;
	ТаблицаПравил.Колонки.Добавить("ИмяДокумента", 				 Новый ОписаниеТипов("Строка"));
	ТаблицаПравил.Колонки.Добавить("ПустоеЗначениеРегистратора", Новый ОписаниеТипов(Документы.ТипВсеСсылки()));
	ТаблицаПравил.Колонки.Добавить("ХозяйственнаяОперация",   	 Новый ОписаниеТипов("ПеречислениеСсылка.ХозяйственныеОперации"));
	ТаблицаПравил.Колонки.Добавить("ПоложительноеКоличество", 	 Новый ОписаниеТипов("Булево, NULL")); // допустимо Неопределено
	ТаблицаПравил.Колонки.Добавить("ТипЗаписиПриход", 		  	 Новый ОписаниеТипов("ПеречислениеСсылка.ТипыЗаписейПартий, NULL")); // допустимо Неопределено
	ТаблицаПравил.Колонки.Добавить("ТипЗаписиРасход", 		  	 Новый ОписаниеТипов("ПеречислениеСсылка.ТипыЗаписейПартий, NULL")); // допустимо Неопределено
	ТаблицаПравил.Колонки.Добавить("ДокументИсточникВПриходе", 	 Новый ОписаниеТипов("Булево"));
	ТаблицаПравил.Колонки.Добавить("ДокументИсточникВРасходе", 	 Новый ОписаниеТипов("Булево"));
	ТаблицаПравил.Колонки.Добавить("КорПартияВРасходе", 		 Новый ОписаниеТипов("Булево"));
	
	Макет = РегистрыНакопления.СебестоимостьТоваров.ПолучитьМакет("ПравилаЗаполненияРеквизитаТипЗаписи");
	Макет.КодЯзыка = Метаданные.Языки.Русский.КодЯзыка; // язык текста в макете должен соответствовать языку, на котором записаны имена объектов метаданных
	
	// Первая строка макета содержит заголовок, остальные строки - правила заполнения.
	Для НомерСтроки = 2 По Макет.ВысотаТаблицы Цикл
		
		// 1. Регистратор
		ИмяДокумента = СокрЛП(Макет.Область(НомерСтроки, 1, НомерСтроки, 1).Текст);
		Если НЕ ЗначениеЗаполнено(ИмяДокумента) Тогда
			Прервать; // возможно есть пустые строки в конце документа или под таблицей правил есть комментарии
		ИначеЕсли ЗначениеЗаполнено(ИмяДокументаДляОтбора) И НРег(ИмяДокументаДляОтбора) <> НРег(ИмяДокумента) Тогда
			Продолжить; // не тот тип документа
		ИначеЕсли Метаданные.Документы.Найти(ИмяДокумента) = Неопределено Тогда
			Продолжить; // в этой конфигурации (УТ11, КА2) нет такого документа
		КонецЕсли;
		
		НовоеПравило = ТаблицаПравил.Добавить();
		НовоеПравило.ИмяДокумента 				= ИмяДокумента;
		НовоеПравило.ПустоеЗначениеРегистратора = Документы[ИмяДокумента].ПустаяСсылка();
		
		// 2. Хозяйственная операция
		ИмяХозОперации = СокрЛП(Макет.Область(НомерСтроки, 2, НомерСтроки, 2).Текст);
		Если НЕ ПустаяСтрока(ИмяХозОперации) Тогда
			НовоеПравило.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации[ИмяХозОперации];
		КонецЕсли;
		
		// 3. Отрицательное количество
		ЗнакКоличества = СокрЛП(Макет.Область(НомерСтроки, 3, НомерСтроки, 3).Текст);
		НовоеПравило.ПоложительноеКоличество = ?(ПустаяСтрока(ЗнакКоличества), Неопределено, (ЗнакКоличества = "+"));
		
		// 4. Тип записи приходных движений
		ТипЗаписиПриход = СокрЛП(Макет.Область(НомерСтроки, 4, НомерСтроки, 4).Текст);
		Если ПустаяСтрока(ТипЗаписиПриход) Тогда 
			НовоеПравило.ТипЗаписиПриход = Неопределено;
		ИначеЕсли ТипЗаписиПриход = "<>" Тогда
			НовоеПравило.ТипЗаписиПриход = Перечисления.ТипыЗаписейПартий.ПустаяСсылка();
		Иначе
			НовоеПравило.ТипЗаписиПриход = Перечисления.ТипыЗаписейПартий[ТипЗаписиПриход];
		КонецЕсли;
		
		// 5. Тип записи расходных движений
		ТипЗаписиРасход = СокрЛП(Макет.Область(НомерСтроки, 5, НомерСтроки, 5).Текст);
		Если ПустаяСтрока(ТипЗаписиРасход) Тогда 
			НовоеПравило.ТипЗаписиРасход = Неопределено;
		ИначеЕсли ТипЗаписиРасход = "<>" Тогда
			НовоеПравило.ТипЗаписиРасход = Перечисления.ТипыЗаписейПартий.ПустаяСсылка();
		Иначе
			НовоеПравило.ТипЗаписиРасход = Перечисления.ТипыЗаписейПартий[ТипЗаписиРасход];
		КонецЕсли;
		
		// 6. Заполнение документа-источника в приходе
		ДокументИсточникВПриходе = СокрЛП(Макет.Область(НомерСтроки, 6, НомерСтроки, 6).Текст);
		НовоеПравило.ДокументИсточникВПриходе = НЕ ПустаяСтрока(ДокументИсточникВПриходе);
		
		// 7. Заполнение документа-источника в расходе
		ДокументИсточникВРасходе = СокрЛП(Макет.Область(НомерСтроки, 7, НомерСтроки, 7).Текст);
		НовоеПравило.ДокументИсточникВРасходе = НЕ ПустаяСтрока(ДокументИсточникВРасходе);
		
		// 8. Указание кор. партии в расходе
		КорПартияВРасходе = СокрЛП(Макет.Область(НомерСтроки, 8, НомерСтроки, 8).Текст);
		НовоеПравило.КорПартияВРасходе = НЕ ПустаяСтрока(КорПартияВРасходе);
		
		// 9. Комментарий (не используется)
		
	КонецЦикла;
	
	Возврат ТаблицаПравил;
	
КонецФункции

// Определяет, является ли указанный тип записи записью партии.
//
// Параметры:
// 	ТипЗаписи - ПеречислениеСсылка.ТипыЗаписейПартий - проверяемый тип записи
// 	
// Возвращаемое значение:
//	Булево - проверяемый тип записи относится к первичной партии.
// 	
Функция ЭтоТипЗаписиПервичнойПартии(ТипЗаписи) Экспорт
	
	Возврат (РасчетСебестоимостиПрикладныеАлгоритмы.ТипыЗаписейПервичныхПартий().Найти(ТипЗаписи) <> Неопределено);
	
КонецФункции

// Определяет, возможен ли пересчет записи указанного типа.
//
// Параметры:
// 	ТипЗаписи - ПеречислениеСсылка.ТипыЗаписейПартий - проверяемый тип записи
//
// Возвращаемое значение:
//	Булево - проверяемый тип записи относится к непересчитываемым типам записей.
//
Функция ЭтоНепересчитываемыйТипЗаписи(ТипЗаписи) Экспорт
	
	Возврат (РасчетСебестоимостиПрикладныеАлгоритмы.НепересчитываемыеТипыЗаписей().Найти(ТипЗаписи) <> Неопределено);
	
КонецФункции

// Определяет, является ли переданный тип записи расчетным (не используется в первичных движениях).
// Если это расчетный тип записи (например, Выпуск, Распределение), значит она сгенерирована
// на этапе заполнения партий в себестоимости - для таких записей устанавливается признак "РасчетПартий".
// В противном случае считаем что это уже существующая первичная запись, для которой просто заполнились поля партионного
// учета. Используется только для регистра СебестоимостьТоваров на этапе заполнения партий в движениях этого регистра.
//
// Параметры:
// 	ТипЗаписи - ПеречислениеСсылка.ТипыЗаписейПартий - проверяемый тип записи
//
// Возвращаемое значение:
//	Булево - ролверяемый тип записи относится к расчетным типам записей.
//
Функция ЭтоТолькоРасчетныйТипЗаписи(ТипЗаписи) Экспорт
	
	Правила = РасчетСебестоимостиПовтИсп.ПравилаЗаполненияПоляТипЗаписи();
	СтрокаПравил = Правила.Найти(ТипЗаписи, "ТипЗаписиПриход, ТипЗаписиРасход");
	
	Возврат (СтрокаПравил = Неопределено); // тип записи не используется в первичных движениях
	
КонецФункции

#КонецОбласти

#Область УчетСебестоимости

// Возвращает признак возможности расчета себестоимости.
//
//	Параметры:
//		Период - Дата - период, для которого проверяется возможность расчета себестоимости.
//
//	Возвращаемое значение:
//		Булево - признак возможности расчета себестоимости.
//
Функция ВозможенРасчетСебестоимости(Период = Неопределено) Экспорт
	
	ВедетсяУчет = ПолучитьФункциональнуюОпцию("ИспользоватьУчетСебестоимости");
	
	Если НЕ ВедетсяУчет ИЛИ Период = Неопределено Тогда
		Возврат ВедетсяУчет;
	КонецЕсли;
	
	// Расчет возможен с периода, предшествующего периоду начала учета себестоимости (с периода, в котором вводятся начальные остатки)
	ДатаПроверки = НачалоМесяца(НачалоМесяца(Константы.ДатаНачалаУчетаСебестоимости.Получить()) - 1);
	
	Возврат ДатаПроверки <= НачалоМесяца(Период);
	
КонецФункции

// Возвращает признак необходимости формирования движений по регистрам себестоимости.
//
//	Параметры:
//		Период			- Дата		- период, для которого проверяется возможность расчета себестоимости.
//		ЭтоВводОстатков	- Булево	- признак того, что регистратор является вводом остатков.
//
//	Возвращаемое значение:
//		Булево - признак необходимости формирования движений по регистрам себестоимости.
//
Функция ФормироватьДвиженияПоРегистрамСебестоимости(Период, ЭтоВводОстатков = Ложь) Экспорт
	
	ВедетсяУчет = ПолучитьФункциональнуюОпцию("ИспользоватьУчетСебестоимости");
	
	Если НЕ ВедетсяУчет Тогда
		Возврат Ложь;
	КонецЕсли;
	
	// Движения документов формируются с периода начала учета себестоимости.
	ДатаПроверки = НачалоМесяца(Константы.ДатаНачалаУчетаСебестоимости.Получить());
	
	Если ЭтоВводОстатков Тогда
		// Документы ввода остатков формируют движения начиная с периода, предшествующего периоду начала учета себестоимости.
		ДатаПроверки = НачалоМесяца(ДатаПроверки - 1);
	КонецЕсли;
	
	Возврат ДатаПроверки <= НачалоМесяца(?(ЗначениеЗаполнено(Период), Период, ТекущаяДатаСеанса()));
	
КонецФункции

// Возвращает признак возможности наличия неиспользуемых движений себестоимости.
//
//	Возвращаемое значение:
//		Булево - признак возможности наличия неиспользуемых движений себестоимости.
//
Функция ВозможныНеиспользуемыеДвиженияПоРегистрамСебестоимости() Экспорт
	
	ВестиУчет = ПолучитьФункциональнуюОпцию("ИспользоватьУчетСебестоимости");
	ДатаНачалаУчета = НачалоМесяца(Константы.ДатаНачалаУчетаСебестоимости.Получить());
	
	Если ВестиУчет И НЕ ЗначениеЗаполнено(ДатаНачалаУчета) Тогда
		Возврат Ложь; // учет себестоимости ведется во всех периодах
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

// Возвращает перечень регистров, которые не используются при отключенном учете себестоимости.
//
//	Возвращаемое значение:
//		Соответствие - перечень регистров, которые не используются при отключенном учете себестоимости.
//
Функция РегистрыНеИспользуемыеПриВыключенномУчетеСебестоимости() Экспорт
	
	ПереченьРегистров = Новый Соответствие;
	
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.ПартииПрочихРасходов, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.ПрочиеДоходы, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.ПрочиеРасходы, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.СебестоимостьТоваров, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.ФинансовыеРезультаты, Истина);
	
	ПереченьРегистров.Вставить(Метаданные.РегистрыСведений.СтоимостьТоваров, Истина);
	
	РасчетСебестоимостиЛокализация.ДополнитьРегистрыНеИспользуемыеПриВыключенномУчетеСебестоимости(ПереченьРегистров);
	
	Возврат ПереченьРегистров;
	
КонецФункции

// Возвращает перечень регистров, которые не рассчитываются при отключенном учете себестоимости.
//
//	Возвращаемое значение:
//		Соответствие - перечень регистров, которые не рассчитываются при отключенном учете себестоимости.
//
Функция РегистрыНеРассчитываемыеПриВыключенномУчетеСебестоимости() Экспорт
	
	ПереченьРегистров = Новый Соответствие;
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.ВыручкаИСебестоимостьПродаж, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.ДвиженияНоменклатураДоходыРасходы, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.ДвиженияНоменклатураНоменклатура, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.Закупки, Истина);
	ПереченьРегистров.Вставить(Метаданные.РегистрыНакопления.МатериалыИРаботыВПроизводстве, Истина);
	
	Возврат ПереченьРегистров;
	
КонецФункции

// Возвращает перечень документов, которые формируют движения при отключенном учете себестоимости.
//
//	Возвращаемое значение:
//		Соответствие - перечень документов, которые формируют движения при отключенном учете себестоимости.
//
Функция РегистраторыСДвижениямиПриВыключенномУчетеСебестоимости() Экспорт
	
	ПереченьРегистраторов = Новый Соответствие;
	
	ПереченьРегистраторов.Вставить(Метаданные.Документы.ВводОстатков, Истина);
	ПереченьРегистраторов.Вставить(Метаданные.Документы.РасчетСебестоимостиТоваров, Истина);
	
	Возврат ПереченьРегистраторов;
	
КонецФункции

#КонецОбласти

#Область РежимыПартионногоУчета

// Определяет, используется ли партионный учет версии 2.2 на указанную дату.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить режим партионного учета.
//
// Возвращаемое значение:
//	Булево - признак использования партионного учета версии 2.2 на указанную дату
//	Если дата не указана, то определяется сам факт использования партионного учета версии 2.2.
//
Функция ПартионныйУчетВерсии22(Дата = Неопределено) Экспорт
	Возврат РасчетСебестоимостиЛокализация.ПартионныйУчетВерсии22(Дата);
КонецФункции

// Определяет, используется ли партионный учет версии 2.1 на указанную дату.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить режим партионного учета.
//
// Возвращаемое значение:
//	Булево - признак использования партионного учета версии 2.1 на указанную дату
//	Если дата не указана, то определяется сам факт использования партионного учета версии 2.1.
//
Функция ПартионныйУчетВерсии21(Дата = Неопределено) Экспорт
	
	БылВключенПартионныйУчет = РасчетСебестоимостиПовтИсп.ИспользовалсяПартионныйУчетДоПереходаНаВерсию22(Дата);
	
	Возврат ?(БылВключенПартионныйУчет = Неопределено, Ложь, БылВключенПартионныйУчет);
	
КонецФункции

// Определяет, отключен ли партионный учет на указанную дату.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить режим партионного учета.
//
// Возвращаемое значение:
//	Булево - признак отключенного партионного учета на указанную дату.
//
Функция ПартионныйУчетНеИспользуется(Дата = Неопределено) Экспорт
	
	БылВключенПартионныйУчет = РасчетСебестоимостиПовтИсп.ИспользовалсяПартионныйУчетДоПереходаНаВерсию22(Дата);
	
	Возврат ?(БылВключенПартионныйУчет = Неопределено, Ложь, НЕ БылВключенПартионныйУчет);
	
КонецФункции

// Определяет, включен ли партионный учет на указанную дату.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить режим партионного учета.
//
// Возвращаемое значение:
//	Булево - признак использования партионного учета на указанную дату.
//
Функция ПартионныйУчетВключен(Дата = Неопределено) Экспорт
	
	БылВключенПартионныйУчет =
		РасчетСебестоимостиПовтИсп.ПартионныйУчетВерсии22(Дата)
		ИЛИ РасчетСебестоимостиПовтИсп.ПартионныйУчетВерсии21(Дата);
	
	Возврат БылВключенПартионныйУчет;
	
КонецФункции

// Определяет "старый" режим партионного учета, до перехода на партионный учет версии 2.2.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить режим партионного учета.
//
// Возвращаемое значение:
//	Булево, Неопределено - признак использования партионного учета на указанную дату
// 		Если параметр Дата не передан, или Дата находится в периоде действия партионного учета версии 2.2,
//		то возвращается значение Неопределено - в такой проверке нет смысла.
//
Функция ИспользовалсяПартионныйУчетДоПереходаНаВерсию22(Дата) Экспорт
	Возврат РасчетСебестоимостиЛокализация.ИспользовалсяПартионныйУчетДоПереходаНаВерсию22(Дата);
КонецФункции

// Возвращает дату перехода на партионный учет версии 2.2.
// Дата может быть пустой - значит партионный учет версии 2.2 включен для всех периодов.
//
// Возвращаемое значение:
//	Дата - начало месяца перехода на партионный учет версии 2.2.
//
Функция ДатаПереходаНаПартионныйУчетВерсии22() Экспорт
	Возврат РасчетСебестоимостиЛокализация.ДатаПереходаНаПартионныйУчетВерсии22();
КонецФункции

#КонецОбласти

#Область УправленческийУчетОрганизаций

// Возвращает дату начала ведения управленческого учета организаций.
// Дата может быть пустой - значит управленческий учет организаций включен для всех периодов.
//
// Возвращаемое значение:
//	Дата - начало месяца ведения управленческого учета организаций
//
Функция ДатаНачалаВеденияУправленческогоУчетаОрганизаций() Экспорт
	
	Возврат РасчетСебестоимостиЛокализация.ДатаНачалаВеденияУправленческогоУчетаОрганизаций();
	
КонецФункции

// Определяет, включен ли управленческий учет организаций на указанную дату.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить ведение управленческого учета организаций.
//
// Возвращаемое значение:
//	Булево - признак использования управленческого учета организаций на указанную дату
//	Если дата не указана, то определяется сам факт включения партионного учета организаций.
//
Функция УправленческийУчетОрганизаций(Дата = Неопределено) Экспорт
	Возврат РасчетСебестоимостиЛокализация.УправленческийУчетОрганизаций(Дата);
КонецФункции

#КонецОбласти

#Область УчетПоНазначениям

// Возвращает дату начала включения обособленного учета себестоимости по назначениям.
//
// Возвращаемое значение:
//	Дата - начало месяца включения обособленного учета по назначениям.
//
Функция ДатаВключенияОбособленногоУчетаСебестоимостиПоНазначениям() Экспорт
	
	Возврат НачалоМесяца(Константы.ДатаВключенияОбособленногоУчетаСебестоимостиПоНазначениям.Получить());
	
КонецФункции

// Определяет, включен ли учет себестоимости по назначениям на указанную дату.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить ведение учета себестоимости по назначениям.
//
// Возвращаемое значение:
//	Булево - признак учета себестоимости по назначениям на указанную дату
//	Если дата не указана, то определяется сам факт учета себестоимости по назначениям.
//
Функция СебестоимостьТоваровПоНазначениям(Дата = Неопределено) Экспорт
	
	УчитыватьСебестоимостьТоваровПоНазначениям = ПолучитьФункциональнуюОпцию("УчитыватьСебестоимостьТоваровПоНазначениям")
		И (Дата = Неопределено
			ИЛИ Дата >= РасчетСебестоимостиПовтИсп.ДатаВключенияОбособленногоУчетаСебестоимостиПоНазначениям());
	
	Возврат УчитыватьСебестоимостьТоваровПоНазначениям;
	
КонецФункции

#КонецОбласти

#Область ТехнологическиеПараметрыРасчета

// Возвращает значения технологических параметров операции закрытия месяца.
//
// Параметры:
//	Операция - ПеречислениеСсылка.ОперацииЗакрытияМесяца - операция, для которой получаются технологические параметры;
//				если не указана, то возвращаются значения параметров для операции "Расчет партий и себестоимости".
//	СкрытыеИмеютЗначенияПоУмолчанию - Булево - для скрытых параметров будет возвращено
//		значение по умолчанию независимо от наличия измененного значения
//
// Возвращаемое значение:
//	Структура - см. Константы.НастройкиЗакрытияМесяца.СоздатьМенеджерЗначения().УстановленныеЗначенияПараметровОперации().
//
Функция ЗначенияТехнологическихПараметров(Операция = Неопределено, СкрытыеИмеютЗначенияПоУмолчанию = Истина) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Операция = Неопределено Тогда
		Операция = Перечисления.ОперацииЗакрытияМесяца.РасчетПартийИСебестоимости;
	КонецЕсли;
	
	ЗначенияПараметров = Константы.НастройкиЗакрытияМесяца.СоздатьМенеджерЗначения().УстановленныеЗначенияПараметровОперации(
		Операция,
		СкрытыеИмеютЗначенияПоУмолчанию);
	
	Возврат ЗначенияПараметров;
	
КонецФункции

#КонецОбласти

#Область АнализСостоянияСистемы

// Возвращает важность указанной проверки состояния системы.
//
// Параметры:
//	Проверка - СправочникСсылка.ПроверкиСостоянияСистемы - проверка.
//
// Возвращаемое значение:
//	ПеречислениеСсылка.ВариантыВажностиПроблемыСостоянияСистемы - важность проверки.
//
Функция ВажностьПроверкиСостоянияСистемы(Проверка) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Важность = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Проверка, "Важность");
	
	Возврат Важность;
	
КонецФункции

#КонецОбласти

#КонецОбласти
