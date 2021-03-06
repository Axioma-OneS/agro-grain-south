#Область ПрограммныйИнтерфейс

//Выделяет из переданного массива штрихкодов упаковок элементы, в составе которых (на любом уровне вложенности, 
//   в т.ч. частично) находится продукция требуемого вида.
//
//Параметры:
//   ШтрихкодыДляПроверки - Массив - проверяемые элементы типа СправочникСсылка.ШтрихкодыУпаковокТоваров.
//   ВидыПродукции - Массив, ПеречислениеСсылка.ВидыПродукцииИС, Неопределено - Вид отбираемой продукции.
Процедура ВыделитьШтрихкодыСодержащиеВидыПродукции(ШтрихкодыУпаковок, ВидыПродукцииИС) Экспорт
	
	//++ НЕ ГОСИС
	ШтрихкодыУпаковок = ИнтеграцияИСУТ.ШтрихкодыСодержащиеВидыПродукции(ШтрихкодыУпаковок, ВидыПродукцииИС);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// Заполняет соответствие штрихкодов данными по номенклатуре, характеристике, маркируемой продукции.
// 
// Параметры:
//  Штрихкоды            - Соответствие - Список штрихкодов.
//  КэшированныеЗначения - Структура - сохраненные значения параметров, используемых при обработке.
Процедура ЗаполнитьИнформациюПоШтрихкодам(Штрихкоды, КэшированныеЗначения) Экспорт
	
	//++ НЕ ГОСИС
	СписокШтрихкодов = Новый Массив;
	Для Каждого КлючЗначение Из Штрихкоды Цикл
		СписокШтрихкодов.Добавить(КлючЗначение.Ключ);
	КонецЦикла;
	
	Если КэшированныеЗначения = Неопределено Тогда
		КэшированныеЗначения = ОбработкаТабличнойЧастиКлиентСервер.ПолучитьСтруктуруКэшируемыеЗначения();
	КонецЕсли;
	
	РегистрыСведений.ШтрихкодыНоменклатуры.ПолучитьДанныеПоШтрихкодам(КэшированныеЗначения, СписокШтрихкодов);
	
	Для Каждого КлючЗначение Из КэшированныеЗначения.Штрихкоды Цикл
		Если Штрихкоды[КлючЗначение.Ключ] <> Неопределено Тогда
			Штрихкоды[КлючЗначение.Ключ].Номенклатура         = КлючЗначение.Значение.Номенклатура;
			Штрихкоды[КлючЗначение.Ключ].Характеристика       = КлючЗначение.Значение.Характеристика;
			Штрихкоды[КлючЗначение.Ключ].МаркируемаяПродукция = КлючЗначение.Значение.МаркируемаяПродукция;
		КонецЕсли;
	КонецЦикла;
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

//В процедуре нужно реализовать подготовку данных для дальнейшей обработки штрихкодов.
//
//Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма документа, в которой происходит обработка,
//   ДанныеШтрихкодов - Массив - полученные штрихкоды,
//   ПараметрыЗаполнения - см. ИнтеграцияЕГАИСКлиентСервер.ПараметрыЗаполненияТабличнойЧасти.
//   СтруктураДействий - Структура - подготовленные данные.
//
Процедура ПодготовитьДанныеДляОбработкиШтрихкодов(Форма, ДанныеШтрихкодов, ПараметрыЗаполнения, СтруктураДействий) Экспорт
	
	//++ НЕ ГОСИС
	
	СтруктураДействийСДобавленнымиСтроками = Новый Структура;
	СтруктураДействийСИзмененнымиСтроками  = Новый Структура;
	
	Если ПараметрыЗаполнения.ЗаполнитьКодТНВЭД Тогда
		СтруктураДействийСДобавленнымиСтроками.Вставить("ЗаполнитьКодТНВЭД");
	КонецЕсли;
		
	Если ПараметрыЗаполнения.ПересчитатьКоличествоЕдиниц Тогда
		
		СтруктураДействийСДобавленнымиСтроками.Вставить("ПересчитатьКоличествоЕдиниц");
		СтруктураДействийСИзмененнымиСтроками.Вставить("ПересчитатьКоличествоЕдиниц");
		
	КонецЕсли;
	
	Если ПараметрыЗаполнения.ПересчитатьСумму Тогда
		
		СтруктураДействийСДобавленнымиСтроками.Вставить("ПересчитатьСумму");
		СтруктураДействийСИзмененнымиСтроками.Вставить("ПересчитатьСумму");
		
	КонецЕсли;
	
	СтруктураДействийСДобавленнымиСтроками.Вставить("ЗаполнитьПризнакЕдиницаИзмерения",
		Новый Структура("Номенклатура", "ЕдиницаИзмерения"));
	
	Если ШтрихкодированиеИС.ПрисутствуетАлкогольнаяПродукция(ПараметрыЗаполнения.ВидыПродукцииИС) Тогда
		
		ПараметрыЗаполненияНоменклатурыЕГАИС = Новый Структура;
		ПараметрыЗаполненияНоменклатурыЕГАИС.Вставить("ЗаполнитьФлагАлкогольнаяПродукция", Ложь);
		ПараметрыЗаполненияНоменклатурыЕГАИС.Вставить("ИмяКолонки", "АлкогольнаяПродукция");
		СтруктураДействийСДобавленнымиСтроками.Вставить("ЗаполнитьНоменклатуруЕГАИС", ПараметрыЗаполненияНоменклатурыЕГАИС);
		
		Если ПараметрыЗаполнения.ЗаполнитьИндексАкцизнойМарки Тогда
			СтруктураДействийСДобавленнымиСтроками.Вставить("ЗаполнитьИндексАкцизнойМарки");
		КонецЕсли;
		
	КонецЕсли;
	
	Если ШтрихкодированиеИС.ПрисутствуетПродукцияИСМП(ПараметрыЗаполнения.ВидыПродукцииИС)
		Или ШтрихкодированиеИС.ПрисутствуетТабачнаяПродукция(ПараметрыЗаполнения.ВидыПродукцииИС) Тогда
		
		Если ПараметрыЗаполнения.ЗаполнитьGTIN Тогда
			СтруктураДействийСДобавленнымиСтроками.Вставить("ЗаполнитьGTINВСтроке",
			
			Новый Структура("ДобавлятьЛидирующиеНули", Истина));
		КонецЕсли;
		
	КонецЕсли;
	
	СтруктураДействий = ШтрихкодированиеНоменклатурыКлиентСервер.ПараметрыОбработкиШтрихкодов();
	
	СтруктураДействий.Штрихкоды                              = ДанныеШтрихкодов;
	СтруктураДействий.СтруктураДействийСДобавленнымиСтроками = СтруктураДействийСДобавленнымиСтроками;
	СтруктураДействий.СтруктураДействийСИзмененнымиСтроками  = СтруктураДействийСИзмененнымиСтроками;
	СтруктураДействий.ТолькоТовары                           = Истина;
	СтруктураДействий.ШтрихкодыВТЧ                           = ПараметрыЗаполнения.ШтрихкодыВТЧ;
	СтруктураДействий.МаркируемаяПродукцияВТЧ                = ПараметрыЗаполнения.МаркируемаяПродукцияВТЧ;
	
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре нужно реализовать обработку штрихкодов.
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма для которой будут обработаны введенные штрихкоды.
//   ДанныеДляОбработки - Структура - структура параметров обработки штрихкодов.
//                                    и заполняется данными из формы.
//   КэшированныеЗначения - Структура - кэш формы.
Процедура ОбработатьШтрихкоды(Форма, ДанныеДляОбработки, КэшированныеЗначения) Экспорт
	
	//++ НЕ ГОСИС
	ШтрихкодированиеНоменклатурыСервер.ОбработатьШтрихкоды(Форма, Форма.Объект, ДанныеДляОбработки, КэшированныеЗначения);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре требуется реализовать алгоритм обработки полученных штрихкодов из ТСД.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма документа, в которой происходит обработка,
//  ДанныеДляОбработки - Структура - подготовленные ранее данные для обработки,
//  КэшированныеЗначения - Структура - используется механизмом обработки изменения реквизитов ТЧ.
Процедура ОбработатьДанныеИзТСД(Форма, ДанныеДляОбработки, КэшированныеЗначения) Экспорт
	
	//++ НЕ ГОСИС
	ШтрихкодированиеНоменклатурыСервер.ОбработатьШтрихкоды(
		Форма, Форма.Объект,
		ДанныеДляОбработки, КэшированныеЗначения);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре необходимо реализовать заполнение таблицы ДанныеПоEAN на основании заполненной колонки ШтрихкодEAN.
// 
// Параметры:
//  ДанныеПоШтрихкодамEAN - ТаблицаЗначений - передается с обязательной колонкой ШтрихкодEAN, возвращает:
//   * Номенклатура - ОпределяемыйТип.Номенклатура
//   * ПредставлениеНоменклатуры - Строка - Представление номенклатуры
//   * Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры - Характеристика номенклатуры
//   * ШтрихкодEAN - Строка - Штрихкод
//   * ВидПродукцииИС - ПеречислениеСсылка.ВидыПродукцииИС - Вид продукции
//   * Маркируемая - Булево - Признак маркируемой продукции
Процедура ПриЗаполненииИнформацииПоШтрихкодамEAN(ДанныеПоШтрихкодамEAN) Экспорт
	
	//++ НЕ ГОСИС
	ИнтеграцияИСУТ.ЗаполнитьДанныеПоШтрихкодамEAN(ДанныеПоШтрихкодамEAN);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре необходимо реализовать заполнение колонки таблицы значений штрихкодами, соответствующми номенклатуре и характеристике.
//
// Параметры:
//  ДанныеПоШтрихкодамEAN - ТаблицаЗначений - содержит колонки:
//   * Номенклатура   - ОпределяемыйТип.Номенклатура               - входящий.
//   * Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры - входящий.
//   * Штрихкод       - Строка                                     - исходящий.
//  ИмяКолонкиЗаполнения - Строка - Имя колонки таблицы значений, которую требуется заполнить значением штрихкода.
Процедура ЗаполнитьШтрихкоды(ДанныеПоШтрихкодам, ИмяКолонкиЗаполнения = "Штрихкод") Экспорт
	
	//++ НЕ ГОСИС
	ИнтеграцияИСУТ.ЗаполнитьДанныеПоШтрихкодам(ДанныеПоШтрихкодам, ИмяКолонкиЗаполнения);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре необходимо реализовать проверку необходимости выбора серии для номенклатуры.
// 
// Параметры:
//  ДанныеДляРасчетаСерии  - Структура - Данные для расчета серий.
//  ПараметрыУказанияСерий - Структура - Параметры указания серий.
//  ТребуетсяВыбор         - Булево - исходящий, признак необходимости выбора серии.
//  КэшированныеЗначения   - Произвольный - кэшированные значения
//
Процедура ПриОпределенииНеобходимостиВыбораСерии(ДанныеДляРасчетаСерии, ПараметрыУказанияСерий, ТребуетсяВыбор, КэшированныеЗначения = Неопределено) Экспорт
	
	//++ НЕ ГОСИС
	Если КэшированныеЗначения = Неопределено Тогда
		КэшированныеЗначения = Новый Структура;
	КонецЕсли;
	Если Не КэшированныеЗначения.Свойство("ПризнакУказанияСерий") Тогда
		КэшированныеЗначения.Вставить("ПризнакУказанияСерий", Новый Соответствие);
	КонецЕсли;
	
	КэшПоиск = КэшированныеЗначения.ПризнакУказанияСерий.Получить(ДанныеДляРасчетаСерии.Номенклатура);
	Если КэшПоиск <> Неопределено Тогда
		КэшПоиск = КэшПоиск.Получить(ДанныеДляРасчетаСерии.Характеристика);
	Иначе
		КэшированныеЗначения.ПризнакУказанияСерий.Вставить(ДанныеДляРасчетаСерии.Номенклатура, Новый Соответствие);
	КонецЕсли;
	Если КэшПоиск <> Неопределено Тогда
		ТребуетсяВыбор = КэшПоиск;
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока = Новый Структура;
	
	ТекущаяСтрока.Вставить("Номенклатура",    ДанныеДляРасчетаСерии.Номенклатура);
	ТекущаяСтрока.Вставить("Характеристика",  ДанныеДляРасчетаСерии.Характеристика);
	ТекущаяСтрока.Вставить("Склад",           ДанныеДляРасчетаСерии.Склад);
	ТекущаяСтрока.Вставить("ТипНоменклатуры");
	ТекущаяСтрока.Вставить("НомерСтроки",             1);
	ТекущаяСтрока.Вставить("Количество",              1);
	ТекущаяСтрока.Вставить("КоличествоПодобрано",     1);
	ТекущаяСтрока.Вставить("СтатусУказанияСерий",     0);
	ТекущаяСтрока.Вставить("ХарактеристикиИспользуются");
	ТекущаяСтрока.Вставить("Серия");
	
	СтруктураДействий = Новый Структура;
	
	СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу",
		ТекущаяСтрока.Характеристика);
		
	СтруктураДействий.Вставить("ЗаполнитьПризнакХарактеристикиИспользуются",
		Новый Структура("Номенклатура", "ХарактеристикиИспользуются"));
		
	СтруктураДействий.Вставить("ЗаполнитьПризнакТипНоменклатуры",
		Новый Структура("Номенклатура", "ТипНоменклатуры"));

	СтруктураДействий.Вставить("ПроверитьСериюРассчитатьСтатус",
		Новый Структура("ПараметрыУказанияСерий, Склад", ПараметрыУказанияСерий, ДанныеДляРасчетаСерии.Склад));
	
	Кэш = Неопределено;
	ОбработкаТабличнойЧастиСервер.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, Кэш);
	
	ТребуетсяВыбор = Не НоменклатураКлиентСервер.ВЭтомСтатусеСерииНеУказываются(ТекущаяСтрока.СтатусУказанияСерий, ПараметрыУказанияСерий);
	
	КэшированныеЗначения.ПризнакУказанияСерий.Получить(ДанныеДляРасчетаСерии.Номенклатура).Вставить(ДанныеДляРасчетаСерии.Характеристика, ТребуетсяВыбор);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре нужно реализовать заполнение массива ШтрихкодыУпаковок из данных документа.
// 
// Параметры:
//  Документ - ДокументСсылка - проверяемый документ.
//  ШтрихкодыУпаковок - Массив - Список штрихкодов.
Процедура ЗаполнитьШтрихкодыУпаковокДокумента(Документ, ШтрихкодыУпаковок) Экспорт
	
	//++ НЕ ГОСИС
	ШтрихкодыУпаковок = Документ.ШтрихкодыУпаковок.ВыгрузитьКолонку("ЗначениеШтрихкода");
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре нужно реализовать заполнение таблицы данных данными документа основания.
// 
// Параметры:
//  ПараметрыСканирования - (См. ШтрихкодированиеИСКлиент.ПараметрыСканирования и ШтрихкодированиеИС.ПараметрыСканирования).
//  ТаблицаДанных - ТаблицаЗначений - Данные из документа основания.
Процедура СформироватьДанныеДокументаОснования(ПараметрыСканирования, ТаблицаДанных) Экспорт
	
	//++ НЕ ГОСИС
	ИнтеграцияИСУТ.СформироватьДанныеДокументаОснования(ПараметрыСканирования, ТаблицаДанных);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В процедуре необходимо реализовать обработку данных штрихкода для общей формы. результат обработки штрихкода следует
// вернуть в параметре РезультатОбработки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Общая форма.
//  ДанныеШтрихкода - (См. ШтрихкодированиеИСКлиентСервер.ИнициализироватьДанныеШтрихкода).
//  ПараметрыСканирования - (См. ШтрихкодированиеИСКлиент.ПараметрыСканирования и ШтрихкодированиеИС.ПараметрыСканирования).
//  ВложенныеШтрихкоды - (См. ШтрихкодированиеИС.ИнициализироватьДанныеШтрихкода).
//  РезультатОбработки - (См. ШтрихкодированиеИС.ИнициализироватьРезультатОбработкиШтрихкода).
Процедура ОбработатьДанныеШтрихкодаДляОбщейФормы(Форма, ДанныеШтрихкода, ПараметрыСканирования, ВложенныеШтрихкоды, РезультатОбработки) Экспорт
	
	//++ НЕ ГОСИС
	РезультатОбработки = ИнтеграцияИСУТ.ОбработатьДанныеШтрихкодаДляОбщейФормы(Форма, ДанныеШтрихкода, ПараметрыСканирования, ВложенныеШтрихкоды);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В этой процедуре при необходимости следует реализовать дополнительные проверки на ошибки данных по штрихкодам.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма, для которой выполняется обработка штрихкодов.
//  ДанныеПоШтрихкодам - (См. ШтрихкодированиеИС.ИнициализацияДанныхПоШтрихкодам). 
//  ПараметрыСканирования - (См. ШтрихкодированиеИСКлиент.ПараметрыСканирования и ШтрихкодированиеИС.ПараметрыСканирования).
//  ЕстьОшибки - Булево - Истина, если выявлена ошибка.
Процедура ПриПроверкеДанныхПоШтрихкодам(ДанныеПоШтрихкодам, ПараметрыСканирования, ЕстьОшибки) Экспорт
	
	Возврат;
	
КонецПроцедуры

// В данной процедуре требуется переопределить текст запроса, определяющий свойства маркируемой продукции.
// Номенклатура для запроса лежит во временной таблице "ДанныеШтрихкодовУпаковок". (ДанныеШтрихкодовУпаковок.Номенклатура).
// "ВидПродукции". Поле "Номенклатура" желательно индексировать.
//   Колонки временной таблицы "ДанныеШтрихкодовУпаковок":
//    * Номенклатура   - ОпределяемыйТип.Номенклатура
//    * Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры
//    * Серия          - ОпределяемыйТип.СерияНоменклатуры
//   Ожидаемые действия:
//   * Создание временной таблицы "СвойстваМаркируемойПродукции" с колонками:
//     ** Номенклатура         - ОпределяемыйТип.Номенклатура
//     ** МаркируемаяПродукция - Булево
//     ** ВидПродукции         - ПеречислениеСсылка.ВидыПродукцииИС.
// Параметры:
//  ТекстЗапросаСвойстваМаркируемойПродукции - Строка - Переопределяемый текст запроса.
Процедура ПриОпределенииТекстаЗапросаСвойствМаркируемойПродукции(ТекстЗапросаСвойстваМаркируемойПродукции) Экспорт
	
	//++ НЕ ГОСИС
	ТекстЗапросаСвойстваМаркируемойПродукции = "
	|ВЫБРАТЬ
	|	ДанныеШтрихкодовУпаковок.Номенклатура   КАК Номенклатура,
	|	ДанныеШтрихкодовУпаковок.Характеристика КАК Характеристика,
	|	МАКСИМУМ(ЕСТЬNULL(ДанныеШтрихкодовУпаковок.Номенклатура.ВидАлкогольнойПродукции.Маркируемый, ЛОЖЬ))
	|		ИЛИ ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета В (
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ТабачнаяПродукция),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ОбувнаяПродукция),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ЛегкаяПромышленность),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.МолочнаяПродукция),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Шины),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Фотоаппараты),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Велосипеды),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.КреслаКоляски),
	|				ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Духи)
	|	) КАК МаркируемаяПродукция,
	|	ВЫБОР
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура = НЕОПРЕДЕЛЕНО
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.АлкогольнаяПродукция
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Алкогольная)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ТабачнаяПродукция)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Табак)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ОбувнаяПродукция)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Обувь)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ЛегкаяПромышленность)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.МолочнаяПродукция)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.МолочнаяПродукция)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Шины)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Шины)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Фотоаппараты)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Фотоаппараты)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Духи)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Духи)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.КреслаКоляски)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.КреслаКоляски)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Велосипеды)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Велосипеды)
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ КАК ВидПродукции
	|ПОМЕСТИТЬ СвойстваМаркируемойПродукции
	|ИЗ
	|	ДанныеШтрихкодовУпаковок КАК ДанныеШтрихкодовУпаковок
	|СГРУППИРОВАТЬ ПО
	|	ДанныеШтрихкодовУпаковок.Номенклатура,
	|	ДанныеШтрихкодовУпаковок.Характеристика,
	|	ВЫБОР
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура = НЕОПРЕДЕЛЕНО
	|			ТОГДА НЕОПРЕДЕЛЕНО
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.АлкогольнаяПродукция
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Алкогольная)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ТабачнаяПродукция)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Табак)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ОбувнаяПродукция)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Обувь)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.ЛегкаяПромышленность)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.МолочнаяПродукция)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.МолочнаяПродукция)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Шины)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Шины)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Фотоаппараты)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Фотоаппараты)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Духи)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Духи)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.КреслаКоляски)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.КреслаКоляски)
	|		КОГДА ДанныеШтрихкодовУпаковок.Номенклатура.ОсобенностьУчета = ЗНАЧЕНИЕ(Перечисление.ОсобенностиУчетаНоменклатуры.Велосипеды)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Велосипеды)
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Номенклатура";
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// В данной процедуре требуется переопределить сочетание клавиш для команды "Добавить без маркировки" в форме сканирования.
// 
// Параметры:
//  СочетаниеКлавиш - СочетаниеКлавиш - По умолчанию "Ctr + Z".
Процедура ПриОпределенииСочетанияКлавишДобавитьБезМаркировкиВФормеСканирования(СочетаниеКлавиш) Экспорт
	
	Возврат;
	
КонецПроцедуры

// В случае учета серий в данной процедуре необходимо реализовать заполнение таблицы значений "ДанныеТаблицыТовары", 
//   содержащей (как минимум, без учета необходимости учета специфики в прикладных документах) колонки: 
//     "Номенклатура", "Характеристика", "Серия", "Количество".
// Если заданы параметры сканирования, таблицу необходимо положить во временное хранилище, адрес хранилища
//     - в ПараметрыСканирования.ДанныеТаблицыТовары. Иначе просто заполнить ДанныеТаблицыТовары по шаблону.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма, для которой происходит обработка штрихкодов.
//  ДанныеТаблицыТовары - См. ШтрихкодированиеИС.ИнициализицияТаблицыДанныхДокумента.
//  ПараметрыСканирования - См. ШтрихкодированиеИСКлиент.ПараметрыСканирования.
//  СтандартнаяОбработка - Булево, Ложь - если требуется заполнение таблицы в данной процедуре, Истина - заполнение произойдет
//      по стандартному алгоритму.
Процедура ПриФормированииДанныхТабличнойЧастиТовары(Форма, ДанныеТаблицыТовары, ПараметрыСканирования, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры

// В данной процедуре необходимо определить модуль для обработки данных штрихкода. Если модуль не будет определен оббработка
// будет выполнена в модуле менеджера. Процедура, в которой будует выполнена обработка должна называться "ОбработатьДанныеШтрихкода"
// с параметрами: "Форма", "ДанныеШтрихкода", "ПараметрыСканирования", "ВложенныеШтрихкоды".
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - форма объекта.
// 	МодульДляОбработки - Произвольный - Модуль, в котором будет выполнена обработка.
// 	СтандартнаяОбработка - Булево - Если требуется переопределеить модуль для обработки - требуется установить флаг в Ложь.
Процедура ОпределитьМодульДляОбработкиДанныхШтрихкода(Форма, МодульДляОбработки, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры


#КонецОбласти