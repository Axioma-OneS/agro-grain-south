﻿#Область ПрограммныйИнтерфейс

Функция ИмяПодсистемы() Экспорт
	
	Возврат "ИСМП";
	
КонецФункции

Функция ПредставлениеПодсистемы() Экспорт
	
	Возврат "ИС МП";
	
КонецФункции

Функция ИмяКомандыПулКодовМаркировки(ИмяПодсистемы) Экспорт
	
	Возврат
		ИнтеграцияИСКлиентСервер.ОбщийПрефиксКомандыНавигационнойСсылки(ИмяПодсистемы)
		+ "ПерейтиВПулКодовМаркировки";
	
КонецФункции

Функция ЭтоКомандаНавигационнойСсылкиПулКодовМаркировки(ОписаниеКоманды) Экспорт
	
	Возврат ОписаниеКоманды[2] = "ПерейтиВПулКодовМаркировки";
	
КонецФункции

Процедура ЗаполнитьСоответствиеПолейДокументовОснований(Форма, СоответствиеПолей) Экспорт
	
	Если СтрНачинаетсяС(Форма.ИмяФормы, "Документ.ЗаказНаЭмиссиюКодовМаркировкиСУЗ") Тогда
		
		СоответствиеПолей.Вставить("ПеремаркировкаТоваровИСМП", Новый Соответствие);
		СоответствиеПолей["ПеремаркировкаТоваровИСМП"].Вставить("Организация", "Организация");
		
		СоответствиеПолей.Вставить("МаркировкаТоваровИСМП", Новый Соответствие);
		СоответствиеПолей["МаркировкаТоваровИСМП"].Вставить("Организация",   "Организация");
		СоответствиеПолей["МаркировкаТоваровИСМП"].Вставить("ВидМаркировки", "ВидМаркировки");
		
	КонецЕсли;
	
	ИнтеграцияИСМПКлиентСерверПереопределяемый.ЗаполнитьСоответствиеПолейДокументовОснований(Форма, СоответствиеПолей);
	
КонецПроцедуры

Функция ШаблонКодаМаркировкиПоВидуПродукции(ВидПродукции) Экспорт
	
	СписокШаблонов = ШаблоныКодовПоВидуПродукции(ВидПродукции);
	
	Если СписокШаблонов.Количество() Тогда
		Возврат СписокШаблонов.Получить(0).Значение;
	КонецЕсли;
	
КонецФункции

// Возвращает доступные шаблоны по виду продукции с представлением.
// 
// Параметры:
// 	ВидПродукции     - ПеречислениеСсылка.ВидыПродукцииИС - Вид продукции.
// 	ВключатьКомлекты - Булево                             - Признак включения шаблонов для комплектов.
// Возвращаемое значение:
// 	СписокЗначений - Список значений с представлениями.
Функция ШаблоныКодовПоВидуПродукции(ВидПродукции, ВключатьКомлекты = Истина) Экспорт
	
	СписокВыбора = Новый СписокЗначений();
	Если ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.ТабачнаяПачка"));
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.БлокТабачныхПачек"));
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Обувь") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.Обувь"));
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукция") Тогда
		СписокВыбора.Добавить(
			ПредопределенноеЗначение(
				"Перечисление.ШаблоныКодовМаркировкиСУЗ.МолочнаяПродукцияБезУказанияСроковГодности"));
		СписокВыбора.Добавить(
			ПредопределенноеЗначение(
				"Перечисление.ШаблоныКодовМаркировкиСУЗ.МолочнаяПродукция"));
		СписокВыбора.Добавить(
			ПредопределенноеЗначение(
				"Перечисление.ШаблоныКодовМаркировкиСУЗ.СкоропортящаясяМолочнаяПродукция"));
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.ЛегкаяПромышленность"));
		Если ВключатьКомлекты Тогда
			СписокВыбора.Добавить(
				ПредопределенноеЗначение(
					"Перечисление.ШаблоныКодовМаркировкиСУЗ.ЛегкаяПромышленностьКомплект"));
		КонецЕсли;
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Шины") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.Шины"));
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Фотоаппараты") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.Фотоаппараты"));
		Если ВключатьКомлекты Тогда
			СписокВыбора.Добавить(
				ПредопределенноеЗначение(
					"Перечисление.ШаблоныКодовМаркировкиСУЗ.ФотоаппаратыКомплект"));
		КонецЕсли;
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Велосипеды") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.Велосипеды"));
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.КреслаКоляски") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.КреслаКоляски"));
	ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Духи") Тогда
		СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.Духи"));
		Если ВключатьКомлекты Тогда
			СписокВыбора.Добавить(ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.ДухиКомплект"));
		КонецЕсли;
	КонецЕсли;
	
	ПредставленияШаблонов = ПредставленияШаблоновКодаМаркировки();
	Для Каждого ЭлементСпискаЗначений Из СписокВыбора Цикл
		ЭлементПредставления = ПредставленияШаблонов.НайтиПоЗначению(ЭлементСпискаЗначений.Значение);
		Если ЭлементПредставления <> Неопределено Тогда
			ЭлементСпискаЗначений.Представление = ЭлементПредставления.Представление;
		КонецЕсли;
	КонецЦикла;
	
	Возврат СписокВыбора;
	
КонецФункции

Функция ШаблоныКодовПоНоменклатуре(Номенклатура) Экспорт
	
	ВидПродукции = ИнтеграцияИСМПВызовСервера.ВидПродукцииПоНоменклатуре(Номенклатура);
	
	Возврат ШаблоныКодовПоВидуПродукции(ВидПродукции);
	
КонецФункции

// Признак возможности маркировки остатков.
// 
// Параметры:
// 	ВидМаркируемойПродукции - ПеречислениеСсылка.ВидыПродукцииИС - вид маркируемой продукции
// Возвращаемое значение:
// 	Булево - Допступность маркировки остатков товаров для виду продукции.
Функция ВидПродукцииПодлежитМаркировкеОстатков(ВидМаркируемойПродукции) Экспорт
	
	Если ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак")
		Или ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Духи")
		Или ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.КреслаКоляски")
		Или ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Велосипеды")
		Или ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукция") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

Функция ДоступностьТрансграничнойТорговлиПоВидуПродукции(ВидМаркируемойПродукции) Экспорт
	
	Если ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Обувь") Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

Функция ПредставлениеGTINОстаткиПоВидуПродукции(Представление, ВидПродукции) Экспорт
	
	Если ЗначениеЗаполнено(Представление) Тогда
		Возврат Представление;
	КонецЕсли;
	
	МассивПредставления = Новый Массив();
	МассивПредставления.Добавить(НСтр("ru = 'Остатки'"));
	Если ЗначениеЗаполнено(ВидПродукции) Тогда
		МассивПредставления.Добавить(ВидПродукции);
	КонецЕсли;
	
	ПредставлениеНовое = СтрСоединить(МассивПредставления, ". ");
	
	Возврат ПредставлениеНовое;
	
КонецФункции

Функция ОперацииНанесенияКодовМаркировки() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ОтчетОПередачеКМНаПроизводственнуюЛинию"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ОтчетОПередачеКМНаПринтер"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ОтчетОПечатиКМ"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ОтчетОВерификацииНанесенныхКМ"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ВидыОперацийИСМП.ОтчетОПотереРаспечатанныхКМ"));
	Возврат Результат;
	
КонецФункции

#Область ОтборПоОрганизации

Процедура НастроитьОтборПоОрганизации(Форма, Результат, Префикс = Неопределено, Знач ЗначениеПрефиксы = Неопределено) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Массив") Тогда
		Форма.Организации.ЗагрузитьЗначения(Результат);
	ИначеЕсли ТипЗнч(Результат) = Тип("СписокЗначений") Тогда
	ИначеЕсли Результат = Неопределено Или Не ЗначениеЗаполнено(Результат) Тогда
		Форма.Организации.Очистить();
	Иначе
		Форма.Организации.Очистить();
		ЭлементСписка = Форма.Организации.Добавить();
		ЭлементСписка.Значение = Результат;
		Если Не(ЭлементСписка.Значение = Результат) Тогда
			Форма.Организации.Очистить();
		КонецЕсли;
	КонецЕсли;
	
	Если Форма.Организации.Количество() = 1 Тогда
		Форма.Организация = Форма.Организации.Получить(0).Значение;
		Форма.ОрганизацииПредставление = Строка(Форма.Организация);
	ИначеЕсли Форма.Организации.Количество() = 0 Тогда
		Форма.Организация = Неопределено;
		Форма.ОрганизацииПредставление = "";
	Иначе
		Форма.Организация = Неопределено;
		Форма.ОрганизацииПредставление = Строка(Форма.Организации);
	КонецЕсли;
	
	Если ЗначениеПрефиксы = Неопределено Тогда
		Префиксы = Новый Массив;
		Префиксы.Добавить("Оформлено");
		Префиксы.Добавить("КОформлению");
	Иначе
		Если ТипЗнч(ЗначениеПрефиксы) = Тип("Строка") Тогда
			Префиксы = Новый Массив();
			Префиксы.Добавить(ЗначениеПрефиксы);
		Иначе
			Префиксы = ЗначениеПрефиксы;
		КонецЕсли;
	КонецЕсли;
	
	Для Каждого Значение Из Префиксы Цикл
		
		Если Форма.Организации.Количество() > 1 Тогда
			Окончание = "Организации";
		Иначе 
			Окончание = "Организация";
		КонецЕсли;
		
		Если Значение = "Отбор" Тогда
			Постфикс = Окончание;
		Иначе
			Постфикс = "Отбор" + Окончание;
		КонецЕсли;
		
		СтраницыОтбораОрганизация = Форма.Элементы.Найти("Страницы" + Значение + Постфикс);
		Если СтраницыОтбораОрганизация <> Неопределено Тогда
			СтраницыОтбораОрганизация.ТекущаяСтраница = Форма.Элементы["Страница" + Значение + Окончание];
		КонецЕсли;
	КонецЦикла;
	
	Если Префикс <> Неопределено Тогда
		ЭлементОтбораОрганизация = Форма.Элементы.Найти(Префикс + ?(Форма.Организации.Количество() > 1,
		                                                                "Организации",
		                                                                "Организация"));
		Если ЭлементОтбораОрганизация <> Неопределено Тогда
			Форма.ТекущийЭлемент = ЭлементОтбораОрганизация;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура УстановитьКартинкуСканированияКодаПоВидуПродукции(ЭлементФормыКартинка, ВидМаркируемойПродукции) Экспорт
	
	Если ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак") Тогда
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиТабакаИСМП;
	ИначеЕсли ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукция") Тогда
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиМолочнойПродукцииИСМП;
	ИначеЕсли ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Шины") Тогда
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиШинИСМП;
	ИначеЕсли ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Фотоаппараты") Тогда
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиФотоаппаратовИСМП;
	ИначеЕсли ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Велосипеды") Тогда
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиВелосипедовИСМП;
	ИначеЕсли ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.КреслаКоляски") Тогда
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиКреслоКолясокИСМП;
	ИначеЕсли ВидМаркируемойПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Духи") Тогда
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиДуховИСМП;
	Иначе
		КартинкаСканированияКода = БиблиотекаКартинок.СканированиеКодаМаркировкиИСМП;
	КонецЕсли;
	
	ЭлементФормыКартинка.Картинка = КартинкаСканированияКода; 
	
КонецПроцедуры

Функция ПредставленияШаблоновКодаМаркировки() Экспорт
	
	СписокВидовПродукции = Новый СписокЗначений();
	
	СписокВидовПродукции.Добавить(
		ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.ТабачнаяПачка"),
		НСтр("ru = 'Пачка'"));
	СписокВидовПродукции.Добавить(
		ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.БлокТабачныхПачек"),
		НСтр("ru = 'Блок'"));
	СписокВидовПродукции.Добавить(
		ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.МолочнаяПродукцияБезУказанияСроковГодности"),
		НСтр("ru = 'Без срока годности'"));
	СписокВидовПродукции.Добавить(
		ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.МолочнаяПродукция"),
		НСтр("ru = 'Со сроком годности (до дней)'"));
	СписокВидовПродукции.Добавить(
		ПредопределенноеЗначение("Перечисление.ШаблоныКодовМаркировкиСУЗ.СкоропортящаясяМолочнаяПродукция"),
		НСтр("ru = 'Со сроком годности (до часов)'"));
	
	Возврат СписокВидовПродукции;
	
КонецФункции

#Область ЗаполнениеСтруктур

Функция РеквизитыСозданияКонтрагента() Экспорт
	
	ДанныеКонтрагента = Новый Структура;
	ДанныеКонтрагента.Вставить("Наименование");
	ДанныеКонтрагента.Вставить("НаименованиеПолное");
	ДанныеКонтрагента.Вставить("ИНН");
	ДанныеКонтрагента.Вставить("КПП");
	ДанныеКонтрагента.Вставить("ЮридическийАдрес");
	Возврат ДанныеКонтрагента;
	
КонецФункции

#КонецОбласти


//Возвращает представление первичного документа собранное из составных частей
//
//Параметры:
//   Реквизиты - Структура - информация о первичном документе:
//   * Оплачен - Булево - оплачен
//   * ВидПервичногоДокумента - ПеречислениеСсылка.ВидыПервичныхДокументовИСМП - вид документа
//   * НаименованиеПервичногоДокумента - Строка - наименование документа
//   * НомерПервичногоДокумента - Строка - номер документа
//   * ДатаПервичногоДокумента - Дата - дата документа
//
//Возвращаемое значение:
//   Строка - представление первичного документа
//
Функция ПредставлениеПервичногоДокумента(Реквизиты) Экспорт
	
	Если Не ЗначениеЗаполнено(Реквизиты.ВидПервичногоДокумента) Тогда
		Возврат "";
	КонецЕсли;
	
	ЧастиИмени = Новый Массив;
	
	Если Реквизиты.ВидПервичногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыПервичныхДокументовИСМП.АктУничтожения") Тогда
		ЧастиИмени.Добавить(НСтр("ru = 'Акт уничтожения'"));
	ИначеЕсли Реквизиты.ВидПервичногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыПервичныхДокументовИСМП.КассовыйЧек") Тогда
		ЧастиИмени.Добавить(НСтр("ru = 'Чек'"));
	ИначеЕсли Реквизиты.ВидПервичногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыПервичныхДокументовИСМП.ТаможеннаяДекларация") Тогда
		ЧастиИмени.Добавить(НСтр("ru = 'ГТД'"));
	ИначеЕсли Реквизиты.ВидПервичногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыПервичныхДокументовИСМП.ТоварнаяНакладная") Тогда
		ЧастиИмени.Добавить(НСтр("ru = 'Товарная накладная'"));
	ИначеЕсли Реквизиты.ВидПервичногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыПервичныхДокументовИСМП.ТоварныйЧек") Тогда
		ЧастиИмени.Добавить(НСтр("ru = 'Товарный чек'"));
	ИначеЕсли Реквизиты.ВидПервичногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыПервичныхДокументовИСМП.УПД") Тогда
		ЧастиИмени.Добавить(НСтр("ru = 'УПД'"));
	ИначеЕсли Реквизиты.ВидПервичногоДокумента = ПредопределенноеЗначение("Перечисление.ВидыПервичныхДокументовИСМП.Прочее") Тогда
		ЧастиИмени.Добавить(Реквизиты.НаименованиеПервичногоДокумента);
	КонецЕсли;
	ЧастиИмени.Добавить(СтрШаблон(НСтр("ru = '№ %1'"), Реквизиты.НомерПервичногоДокумента));
	ЧастиИмени.Добавить(СтрШаблон(НСтр("ru = 'от %1'"), Формат(Реквизиты.ДатаПервичногоДокумента,"ДЛФ=D;")));
	Если Реквизиты.Оплачен Тогда
		ЧастиИмени.Добавить(НСтр("ru = '(оплачен)'"));
	КонецЕсли;
	Возврат СтрСоединить(ЧастиИмени, " ");
	
КонецФункции

#КонецОбласти