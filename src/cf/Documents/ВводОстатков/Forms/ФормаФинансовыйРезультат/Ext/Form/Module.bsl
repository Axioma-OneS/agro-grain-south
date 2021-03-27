﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ИспользоватьУчетПрочихРасходов = ПолучитьФункциональнуюОпцию("ИспользоватьУчетПрочихДоходовРасходов");
	Если НЕ ИспользоватьУчетПрочихРасходов Тогда
		Возврат;
	КонецЕсли;
	
	ВалютаУправленческогоУчета = Константы.ВалютаУправленческогоУчета.Получить();
	ВалютаСтр = Строка(ВалютаУправленческогоУчета);

	СтрокаЗаголовка = "%1 (%2)";
	ЗаголовокСумма = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаЗаголовка, НСтр("ru = 'Сумма расходов'"), ВалютаСтр);
	Элементы.ФинансовыйРезультатРасходыСуммаРасходов.Заголовок = ЗаголовокСумма;
	ЗаголовокСумма = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаЗаголовка, НСтр("ru = 'Сумма доходов'"), ВалютаСтр);
	Элементы.ФинансовыйРезультатДоходыСуммаДоходов.Заголовок = ЗаголовокСумма;
	
	ИспользуетсяНесколькоОрганизаций = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизаций");
	
	Если Не (ИспользуетсяНесколькоОрганизаций ИЛИ ЗначениеЗаполнено(Объект.Организация)) Тогда
		Объект.Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию();
	КонецЕсли;
	
	УстановитьЗаголовок();
	УстановитьДоступностьКомандБуфераОбмена();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды


КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// Обработчик механизма "ДатыЗапретаИзменения"
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ПараметрыЗаписи.Вставить("ТипОперации", Объект.ТипОперации);
	Оповестить("Запись_ВводОстатков", ПараметрыЗаписи, Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "КопированиеСтрокВБуферОбмена" Тогда
		
		УстановитьДоступностьКомандБуфераОбменаНаКлиенте();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	УстановитьЗаголовок();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииСервер();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовПодвалаФормы

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования, 
		ЭтотОбъект, 
		"Объект.Комментарий");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура ВставитьСтроки(Команда)
	
	Если Элементы.ГруппаТипыОпераций.ТекущаяСтраница = Элементы.ГруппаФинансовыйРезультатРасходы Тогда
		КоличествоСтрокДоВставки = Объект.ФинансовыйРезультатРасходы.Количество();
		ПолучитьСтрокиИзБуфераОбмена(Элементы.ФинансовыйРезультатРасходы.Имя);
		КоличествоВставленных = Объект.ФинансовыйРезультатРасходы.Количество()-КоличествоСтрокДоВставки;
	Иначе
		КоличествоСтрокДоВставки = Объект.ФинансовыйРезультатДоходы.Количество();
		ПолучитьСтрокиИзБуфераОбмена(Элементы.ФинансовыйРезультатДоходы.Имя);
		КоличествоВставленных = Объект.ФинансовыйРезультатДоходы.Количество()-КоличествоСтрокДоВставки;
	КонецЕсли;
	КопированиеСтрокКлиент.ОповеститьПользователяОВставкеСтрок(КоличествоВставленных);
	
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьСтроки(Команда)
	
	Если Элементы.ГруппаТипыОпераций.ТекущаяСтраница = Элементы.ГруппаФинансовыйРезультатРасходы Тогда
		Если КопированиеСтрокКлиент.ВозможноКопированиеСтрок(Элементы.ФинансовыйРезультатРасходы.ТекущаяСтрока) Тогда
			СкопироватьСтрокиНаСервере(Элементы.ФинансовыйРезультатРасходы.Имя);
			КопированиеСтрокКлиент.ОповеститьПользователяОКопированииСтрок(Элементы.ФинансовыйРезультатРасходы.ВыделенныеСтроки.Количество());
		КонецЕсли;
	Иначе
		Если КопированиеСтрокКлиент.ВозможноКопированиеСтрок(Элементы.ФинансовыйРезультатДоходы.ТекущаяСтрока) Тогда
			СкопироватьСтрокиНаСервере(Элементы.ФинансовыйРезультатДоходы.Имя);
			КопированиеСтрокКлиент.ОповеститьПользователяОКопированииСтрок(Элементы.ФинансовыйРезультатДоходы.ВыделенныеСтроки.Количество());
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	КомпоновкаДанныхКлиентСервер.ДобавитьОформляемоеПоле(Элемент.Поля, Элементы["Подразделение"].Имя);
	
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ТипОперации", Перечисления.ТипыОперацийВводаОстатков.ФинансовыйРезультатЗаПрошлыеПериоды);

	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗаголовок()
	
	АвтоЗаголовок = Ложь;
	Заголовок = Документы.ВводОстатков.ЗаголовокДокументаПоТипуОперации(Объект.Ссылка,
																						  Объект.Номер,
																						  Объект.Дата,
																						  Объект.ТипОперации);
	
КонецПроцедуры

&НаСервере
Процедура ОрганизацияПриИзмененииСервер()

	Если ЗначениеЗаполнено(Объект.Организация) Тогда
		Объект.НалогообложениеНДС = Справочники.Организации.НалогообложениеНДС(
			Объект.Организация,
			,
			Объект.Дата);
	КонецЕсли;

КонецПроцедуры

#Область РаботаСБуферомОбмена

&НаСервере
Процедура СкопироватьСтрокиНаСервере(ИмяТаблицыФормы)
	
	КопированиеСтрокСервер.ПоместитьВыделенныеСтрокиВБуферОбмена(Элементы[ИмяТаблицыФормы].ВыделенныеСтроки,
																										?(ИмяТаблицыФормы = Элементы.ФинансовыйРезультатРасходы.Имя,
																										   Объект.ФинансовыйРезультатРасходы,
																										   Объект.ФинансовыйРезультатДоходы)
																										);
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьСтрокиИзБуфераОбмена(ИмяТаблицыФормы)
	
	ТаблицаСтрок = КопированиеСтрокСервер.ПолучитьСтрокиИзБуфераОбмена();
	Если ИмяТаблицыФормы = Элементы.ФинансовыйРезультатРасходы.Имя Тогда
		Для Каждого Строка Из ТаблицаСтрок Цикл
			ТекущаяСтрока = Объект.ФинансовыйРезультатРасходы.Добавить();
			ЗаполнитьЗначенияСвойств(ТекущаяСтрока, Строка, "НаправлениеДеятельности, СтатьяРасходов, СуммаРасходов, ДатаОтражения");
		КонецЦикла;
	Иначе
		Для Каждого Строка Из ТаблицаСтрок Цикл
			ТекущаяСтрока = Объект.ФинансовыйРезультатДоходы.Добавить();
			ЗаполнитьЗначенияСвойств(ТекущаяСтрока, Строка, "НаправлениеДеятельности, СтатьяДоходов, СуммаДоходов, ДатаОтражения");
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьКомандБуфераОбмена()
	
	МассивЭлементов = Новый Массив();
	МассивЭлементов.Добавить("ФинансовыйРезультатРасходыВставитьСтроки");
	МассивЭлементов.Добавить("ФинансовыйРезультатДоходыВставитьСтроки");
	МассивЭлементов.Добавить("ФинансовыйРезультатРасходыКонтекстноеМенюВставитьСтроки");
	МассивЭлементов.Добавить("ФинансовыйРезультатДоходыКонтекстноеМенюВставитьСтроки");
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов,
		"Доступность",
		НЕ ОбщегоНазначения.ПустойБуферОбмена("Строки"));
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьКомандБуфераОбменаНаКлиенте()
	
	МассивЭлементов = Новый Массив();
	МассивЭлементов.Добавить("ФинансовыйРезультатРасходыВставитьСтроки");
	МассивЭлементов.Добавить("ФинансовыйРезультатДоходыВставитьСтроки");
	МассивЭлементов.Добавить("ФинансовыйРезультатРасходыКонтекстноеМенюВставитьСтроки");
	МассивЭлементов.Добавить("ФинансовыйРезультатДоходыКонтекстноеМенюВставитьСтроки");
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Доступность", Истина);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
