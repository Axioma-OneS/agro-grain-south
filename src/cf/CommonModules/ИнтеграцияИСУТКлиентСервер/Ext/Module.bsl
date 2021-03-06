// Универсальные механизмы интеграции ИС (ЕГАИС, ГИСМ, ВЕТИС, ...)

#Область ПрограммныйИнтерфейс

//Определяет соответствие переданного документа проверяемому типу.
//
// Параметры:
//  Контекст - ФормаКлиентскогоПриложения, ДокументСсылка - Контекст для определения типа документа.
//  Имя      - Строка - имя объекта метаданного документа.
//
// Возвращаемое значение:
// 	Булево - это документ.
Функция ЭтоДокументПоНаименованию(Контекст, Имя) Экспорт

	Результат = Ложь;

	ТипКонтекста = ТипЗнч(Контекст);
	ТипДокумента = Тип(СтрШаблон("ДокументСсылка.%1", Имя));

	Если ТипКонтекста = Тип("ФормаКлиентскогоПриложения") Тогда
		Если СтрНачинаетсяС(Контекст.ИмяФормы, СтрШаблон("Документ.%1", Имя)) Тогда
			Результат = Истина;
		ИначеЕсли СтрНачинаетсяС(Контекст.ИмяФормы, "ОбщаяФорма.ПроверкаЗаполненияДокументов") Тогда
			Если ТипЗнч(Контекст.Ссылка) = ТипДокумента Тогда
				Результат = Истина;
			КонецЕсли;
		КонецЕсли;
	ИначеЕсли ТипКонтекста = ТипДокумента Тогда
		Результат = Истина;
	КонецЕсли;

	Возврат Результат;

КонецФункции

//Возвращает значение особености учета номенклатуры по переданному виду продукции ИС
//или вид продукции ИС по переданной особенности учета номенклатуры
// Параметры:
//  ОсобенностьУчетаИлиВидПродукции - ПеречислениеСсылка.ОсобенностиУчетаНоменклатуры, ПеречислениеСсылка.ВидыПродукцииИС - особеннсоть учета номенклатуры или вид продукции ИС
// Возвращаемое значение:
//  ПеречислениеСсылка.ВидыПродукцииИС, ПеречислениеСсылка.ОсобенностиУчетаНоменклатуры - вид продукции ИС или особенность учета номенклатуры
//
Функция ОсобенностьУчетаПоВидуПродукции(ОсобенностьУчетаИлиВидПродукции) Экспорт
	
	Если ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.АлкогольнаяПродукция") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Алкогольная");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.ТабачнаяПродукция") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.ОбувнаяПродукция") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Обувь");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.ЛегкаяПромышленность") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.МолочнаяПродукция") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукция");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Шины") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Шины");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Фотоаппараты") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Фотоаппараты");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Велосипеды") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Велосипеды");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.КреслаКоляски") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.КреслаКоляски");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Духи") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Духи");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Алкогольная") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.АлкогольнаяПродукция");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.ТабачнаяПродукция");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Обувь") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.ОбувнаяПродукция");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.ЛегкаяПромышленность");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукция") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.МолочнаяПродукция");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Шины") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Шины");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Фотоаппараты") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Фотоаппараты");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Велосипеды") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Велосипеды");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.КреслаКоляски") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.КреслаКоляски");
	ИначеЕсли ОсобенностьУчетаИлиВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Духи") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.Духи");
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ЭтоВозвратТовараОтРозничногоКлиента(Контекст) Экспорт
	
	Партнер = ИнтеграцияИСМПСлужебныйКлиентСервер.ЗначениеСвойстваКонтекста(Контекст, "Партнер");
		
	Если Партнер = ПредопределенноеЗначение("Справочник.Партнеры.РозничныйПокупатель") Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВключитьПоддержкуВидовПродукцииИС(Контекст, ПараметрыСканирования, ВидПродукции) Экспорт
	
	Если ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.ЧекККМ") Тогда
		
		ЗаполнитьПараметрыСканированияЧекККМ(ПараметрыСканирования, Контекст, ВидПродукции, Ложь);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.ЧекККМВозврат") Тогда
		
		ЗаполнитьПараметрыСканированияЧекККМВозврат(ПараметрыСканирования, Контекст, ВидПродукции, Ложь);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.РеализацияТоваровУслуг") Тогда
		
		ЗаполнитьПараметрыСканированияРеализацияТоваровУслуг(ПараметрыСканирования, Контекст, ВидПродукции);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.ВозвратТоваровОтКлиента") Тогда
		
		ЗаполнитьПараметрыСканированияВозвратТоваровОтКлиента(ПараметрыСканирования, Контекст, ВидПродукции);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.ПриобретениеТоваровУслуг") Тогда
		
		ЗаполнитьПараметрыСканированияПриобретениеТоваровУслуг(ПараметрыСканирования, Контекст, ВидПродукции);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.ВозвратТоваровПоставщику") Тогда
		
		ЗаполнитьПараметрыСканированияВозвратТоваровПоставщику(ПараметрыСканирования, Контекст, ВидПродукции);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.ПеремещениеТоваров") Тогда
		
		ЗаполнитьПараметрыСканированияПеремещениеТоваров(ПараметрыСканирования, Контекст, ВидПродукции);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "Документ.КорректировкаРеализации") Тогда
		
		ЗаполнитьПараметрыСканированияКорректировкаРеализации(ПараметрыСканирования, Контекст, ВидПродукции);
		
	ИначеЕсли ШтрихкодированиеИСКлиентСервер.ЭтоКонтекстОбъекта(Контекст, "ОбщаяФорма.ПроверкаЗаполненияДокументов") Тогда
		
		Если ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.ЧекККМ") Тогда
			
			ЗаполнитьПараметрыСканированияЧекККМ(ПараметрыСканирования, Контекст, ВидПродукции, Ложь);
			
		ИначеЕсли ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.ЧекККМВозврат") Тогда
			
			ЗаполнитьПараметрыСканированияЧекККМВозврат(ПараметрыСканирования, Контекст, ВидПродукции);
			
		ИначеЕсли ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.РеализацияТоваровУслуг") Тогда
			
			ЗаполнитьПараметрыСканированияРеализацияТоваровУслуг(ПараметрыСканирования, Контекст.Ссылка, ВидПродукции);
			
		ИначеЕсли ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.ВозвратТоваровОтКлиента") Тогда
			
			ЗаполнитьПараметрыСканированияВозвратТоваровОтКлиента(ПараметрыСканирования, Контекст.Ссылка, ВидПродукции);
			
		ИначеЕсли ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.ПриобретениеТоваровУслуг") Тогда
			
			ЗаполнитьПараметрыСканированияПриобретениеТоваровУслуг(ПараметрыСканирования, Контекст.Ссылка, ВидПродукции);
			
		ИначеЕсли ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.ВозвратТоваровПоставщику") Тогда
			
			ЗаполнитьПараметрыСканированияВозвратТоваровПоставщику(ПараметрыСканирования, Контекст.Ссылка, ВидПродукции);
			
		ИначеЕсли ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.ПеремещениеТоваров") Тогда
			
			ЗаполнитьПараметрыСканированияПеремещениеТоваров(ПараметрыСканирования, Контекст.Ссылка, ВидПродукции);
			
		ИначеЕсли ТипЗнч(Контекст.Ссылка) = Тип("ДокументСсылка.КорректировкаРеализации") Тогда
			
			ЗаполнитьПараметрыСканированияКорректировкаРеализации(ПараметрыСканирования, Контекст.Ссылка, ВидПродукции);
			
			ПараметрыСканирования.КлючевыеРеквизиты.Очистить();
			
		КонецЕсли;
		
		ПараметрыСканирования.КлючевыеРеквизиты.Очистить();
		
	КонецЕсли;
	
	ЗаполнитьБазовыеПараметрыСканирования(ПараметрыСканирования, Контекст);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияЧекККМ(ПараметрыСканирования, Контекст, ВидПродукции, ПроверкаКоличества = Неопределено)
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст, "Объект") Тогда
		ИсточникДанных = Контекст.Объект;
	Иначе
		ИсточникДанных = Контекст;
	КонецЕсли;
	
	ПараметрыСканирования.ДопустимыеВидыПродукции.Добавить(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.ПустаяСсылка"));
	ПараметрыСканирования.ОперацияКонтроляАкцизныхМарок = "Продажа";
	ПараметрыСканирования.ИспользуютсяДанныеВыбораПоМаркируемойПродукции = Ложь;
	
	#Область ПоддержкаАлкогольнойПродукции
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст,"ИспользуетсяРегистрацияРозничныхПродажВЕГАИС")
		И ШтрихкодированиеЕГАИСКлиентСервер.ВключитьПоддержкуАлкогольнойПродукции(ПараметрыСканирования) Тогда
		
		ШтрихкодированиеЕГАИСКлиентСервер.ЗаполнитьБазовыеПараметрыСканирования(ПараметрыСканирования, ИсточникДанных);
		ПараметрыСканирования.ДоступныеСтатусы.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыАкцизныхМарок.ВНаличии"));
		ПараметрыСканирования.ДоступныеСтатусы.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыАкцизныхМарок.ПустаяСсылка"));
		
		ПараметрыСканирования.КонтрольАкцизныхМарок              = Истина;
		ПараметрыСканирования.Операция                           = ПредопределенноеЗначение("Перечисление.ВидыДокументовЕГАИС.ЧекККМ");
		ПараметрыСканирования.СоздаватьШтрихкодУпаковки          = Истина;
		ПараметрыСканирования.РазрешенаОбработкаБезУказанияМарки = Истина;
		
		Если ПроверкаКоличества = Истина Тогда
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Штрихкод");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Помещение");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("НоменклатураНабора");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("ХарактеристикаНабора");
		Иначе
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Цена");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("СтавкаНДС");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Штрихкод");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Продавец");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Помещение");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("НоменклатураНабора");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("ХарактеристикаНабора");
		КонецЕсли;
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаТабачнойПродукции
	
	Если ИнтеграцияИСМПКлиентСерверПовтИсп.ВестиУчетМаркируемойПродукции(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак"))
		И ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		
		КонтрольСтатусов = ИнтеграцияИСМПКлиентСерверПовтИсп.КонтролироватьСтатусыКодовМаркировкиВРознице();
		ПараметрыСканирования.ЗапрашиватьСтатусыМОТП                     = КонтрольСтатусов;
		ПараметрыСканирования.ЗапрашиватьДанныеНеизвестныхУпаковокМОТП   = КонтрольСтатусов;
		Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ИсточникДанных, "Организация") Тогда
			ПараметрыСканирования.Организация = ИсточникДанных.Организация;
		КонецЕсли;
		ПараметрыСканирования.Склад = ИсточникДанных.Склад;

		Если Не КонтрольСтатусов Тогда
			ПараметрыСканирования.ВариантПолученияМРЦ = "Вычисление";
		КонецЕсли;
		
		ПараметрыСканирования.СохранятьКодыМаркировкиВПулМОТП = Истина;
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаОбуви
	
	Если ИнтеграцияИСМПКлиентСерверПовтИсп.ВестиУчетМаркируемойПродукции()
		И ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ЗапрашиватьСтатусыИСМП = ИнтеграцияИСМПКлиентСерверПовтИсп.КонтролироватьСтатусыКодовМаркировкиВРознице();
		ПараметрыСканирования.КонтролироватьОкончаниеСрокаГодности = Истина;
		ПараметрыСканирования.ДатаДокумента                        = ИсточникДанных.Дата;
		
	КонецЕсли;
	
	#КонецОбласти
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияЧекККМВозврат(ПараметрыСканирования, Контекст, ВидПродукции, ПроверкаКоличества = Неопределено)
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст, "Объект") Тогда
		ИсточникДанных = Контекст.Объект;
	Иначе
		ИсточникДанных = Контекст;
	КонецЕсли;
	
	ПараметрыСканирования.ДопустимыеВидыПродукции.Добавить(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.ПустаяСсылка"));
	ПараметрыСканирования.ОперацияКонтроляАкцизныхМарок = "Возврат";
	Если ШтрихкодированиеЕГАИСКлиентСервер.ВключитьПоддержкуАлкогольнойПродукции(ПараметрыСканирования) Тогда
		
		ШтрихкодированиеЕГАИСКлиентСервер.ЗаполнитьБазовыеПараметрыСканирования(ПараметрыСканирования, ИсточникДанных);
		ПараметрыСканирования.ДоступныеСтатусы.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыАкцизныхМарок.Реализована"));
		ПараметрыСканирования.ДоступныеСтатусы.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыАкцизныхМарок.ПустаяСсылка"));
		
		ПараметрыСканирования.КонтрольАкцизныхМарок              = Истина;
		ПараметрыСканирования.Операция                           = ПредопределенноеЗначение("Перечисление.ВидыДокументовЕГАИС.ЧекККМ");
		ПараметрыСканирования.СоздаватьШтрихкодУпаковки          = Истина;
		ПараметрыСканирования.РазрешенаОбработкаБезУказанияМарки = Истина;
		
		Если ПроверкаКоличества = Истина Тогда
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Штрихкод");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Помещение");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("НоменклатураНабора");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("ХарактеристикаНабора");
		Иначе
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Цена");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("СтавкаНДС");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Штрихкод");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Продавец");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("Помещение");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("НоменклатураНабора");
			ПараметрыСканирования.КлючевыеРеквизиты.Добавить("ХарактеристикаНабора");
		КонецЕсли;
		
	КонецЕсли;
	
	Если ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Продан"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Продан"));
		
		КонтрольСтатусов = ИнтеграцияИСМПКлиентСерверПовтИсп.КонтролироватьСтатусыКодовМаркировкиВРознице();
		ПараметрыСканирования.ЗапрашиватьСтатусыМОТП                     = КонтрольСтатусов;
		ПараметрыСканирования.ЗапрашиватьДанныеНеизвестныхУпаковокМОТП   = КонтрольСтатусов;
		
		ПараметрыСканирования.СохранятьКодыМаркировкиВПулМОТП = Истина;
		
	КонецЕсли;
	
	Если ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборота"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборота"));
		
		ПараметрыСканирования.ЗапрашиватьСтатусыИСМП = ИнтеграцияИСМПКлиентСерверПовтИсп.КонтролироватьСтатусыКодовМаркировкиВРознице();
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияРеализацияТоваровУслуг(ПараметрыСканирования, Контекст, ВидПродукции)
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст, "Объект") Тогда
		ИсточникДанных = Контекст.Объект;
	Иначе
		ИсточникДанных = Контекст;
	КонецЕсли;
	
	#Область Метаданные
	
	ПараметрыСканирования.ИмяТабличнойЧастиШтрихкодыУпаковок = "ШтрихкодыУпаковок";
	ПараметрыСканирования.ИмяКолонкиШтрихкодУпаковки = "ШтрихкодУпаковки";
	
	#КонецОбласти
	
	#Область ПоддержкаТабачнойПродукции
	
	Если ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		
		ПараметрыСканирования.ВариантПолученияМРЦ = "Вычисление";
		
		ПараметрыСканирования.СохранятьКодыМаркировкиВПулМОТП = Истина;
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаОбуви
	
	Если ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ОтборПоВидуПродукции                 = Истина;
		ПараметрыСканирования.КонтролироватьОкончаниеСрокаГодности = Истина;
		ПараметрыСканирования.ДатаДокумента                        = ИсточникДанных.Дата;
		
	КонецЕсли;
	
	#КонецОбласти
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияКорректировкаРеализации(ПараметрыСканирования, Контекст, ВидПродукции)
	
	#Область Метаданные
	
	ПараметрыСканирования.ИмяТабличнойЧастиШтрихкодыУпаковок = "ШтрихкодыУпаковок";
	ПараметрыСканирования.ИмяКолонкиШтрихкодУпаковки = "ШтрихкодУпаковки";
	
	#КонецОбласти
	
	#Область ПоддержкаТабачнойПродукции
	
	Если ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаОбуви
	
	Если ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
	КонецЕсли;
	
	#КонецОбласти
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияВозвратТоваровОтКлиента(ПараметрыСканирования, Контекст, ВидПродукции)
	
	#Область Метаданные
	
	ПараметрыСканирования.ИмяТабличнойЧастиШтрихкодыУпаковок = "ШтрихкодыУпаковок";
	ПараметрыСканирования.ИмяКолонкиШтрихкодУпаковки = "ШтрихкодУпаковки";
	
	#КонецОбласти
	
	#Область ПоддержкаТабачнойПродукции
	
	Если ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		
		Если ЭтоВозвратТовараОтРозничногоКлиента(Контекст) Тогда
			КонтрольСтатусов = ИнтеграцияИСМПКлиентСерверПовтИсп.КонтролироватьСтатусыКодовМаркировкиВРознице();
		Иначе
			КонтрольСтатусов = ИнтеграцияИСМПКлиентСерверПовтИсп.КонтролироватьСтатусыКодовМаркировки();
		КонецЕсли;
		
		ПараметрыСканирования.ЗапрашиватьСтатусыМОТП                   = КонтрольСтатусов;
		ПараметрыСканирования.ЗапрашиватьДанныеНеизвестныхУпаковокМОТП = КонтрольСтатусов;
		
		ПараметрыСканирования.СохранятьКодыМаркировкиВПулМОТП = Истина;
		
		Если КонтрольСтатусов = Ложь Тогда
			ПараметрыСканирования.ВариантПолученияМРЦ = "Вычисление";
		КонецЕсли;
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаОбуви
	
	Если ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборота"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборотаРозничнаяПродажа"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборотаПоДоговоруРассрочки"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ОжидаетДоставки"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборота"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборотаРозничнаяПродажа"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВыведенИзОборотаПоДоговоруРассрочки"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ОжидаетДоставки"));
		
	КонецЕсли;
	
	#КонецОбласти
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияПриобретениеТоваровУслуг(ПараметрыСканирования, Контекст, ВидПродукции)
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст, "Объект") Тогда
		ИсточникДанных = Контекст.Объект;
	Иначе
		ИсточникДанных = Контекст;
	КонецЕсли;
	
	#Область Метаданные
	
	ПараметрыСканирования.ИмяТабличнойЧастиШтрихкодыУпаковок = "ШтрихкодыУпаковок";
	ПараметрыСканирования.ИмяКолонкиШтрихкодУпаковки = "ШтрихкодУпаковки";
	
	#КонецОбласти
	
	#Область ПоддержкаТабачнойПродукции
	
	Если ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенНеОплачен"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенНеОплачен"));
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаОбуви
	
	Если ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ОжидаетДоставки"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ОжидаетДоставки"));
		
	КонецЕсли;

	#КонецОбласти
	
	ПараметрыСканирования.СопоставлятьНоменклатуру  = Ложь;
	ПараметрыСканирования.СоздаватьШтрихкодУпаковки = Ложь;
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияВозвратТоваровПоставщику(ПараметрыСканирования, Контекст, ВидПродукции)
	
	#Область Метаданные
	
	ПараметрыСканирования.ИмяТабличнойЧастиШтрихкодыУпаковок = "ШтрихкодыУпаковок";
	ПараметрыСканирования.ИмяКолонкиШтрихкодУпаковки = "ШтрихкодУпаковки";
	
	#КонецОбласти
	
	#Область ПоддержкаТабачнойПродукци
	
	Если ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаОбуви
	
	Если ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ОтборПоВидуПродукции = Истина;
		
	КонецЕсли;
	
	#КонецОбласти
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыСканированияПеремещениеТоваров(ПараметрыСканирования, Контекст, ВидПродукции)
	
	#Область Метаданные
	
	ПараметрыСканирования.ИмяТабличнойЧастиШтрихкодыУпаковок = "ШтрихкодыУпаковок";
	ПараметрыСканирования.ИмяКолонкиШтрихкодУпаковки = "ШтрихкодУпаковки";
	
	#КонецОбласти
	
	#Область ПоддержкаТабачнойПродукци
	
	Если ШтрихкодированиеМОТПКлиентСервер.ВключитьПоддержкуТабачнойПродукции(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Эмитирован"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		ПараметрыСканирования.ДопустимыеСтатусыМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенНеОплачен"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Эмитирован"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.Нанесен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенОплачен"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокМОТП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиМОТП.НанесенНеОплачен"));
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ПоддержкаОбуви
	
	Если ШтрихкодированиеИСМПКлиентСервер.ВключитьПоддержкуПродукцииИСМП(ПараметрыСканирования, ВидПродукции) Тогда
		
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборот"));
		ПараметрыСканирования.ДопустимыеСтатусыУпаковокИСМП.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыКодовМаркировкиИСМП.ВведенВОборотПриВозврате"));
		
	КонецЕсли;
	
	#КонецОбласти
	
КонецПроцедуры

Процедура ЗаполнитьБазовыеПараметрыСканирования(ПараметрыСканирования, Контекст)
	
	Если ШтрихкодированиеИСКлиентСервер.ДопустимВидПродукции(ПараметрыСканирования, ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак")) Тогда
		
		Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст, "Объект")
				И ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст.Объект, "Организация") Тогда
			ПараметрыСканирования.Организация = Контекст.Объект.Организация;
		ИначеЕсли ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст, "Организация") Тогда
			ПараметрыСканирования.Организация = Контекст.Организация;
		КонецЕсли;
		
		Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения")
				И ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Контекст, "ПараметрыУказанияСерий") Тогда
			ПараметрыСканирования.ПараметрыУказанияСерий = Контекст.ПараметрыУказанияСерий;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти