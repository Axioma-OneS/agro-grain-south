﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Элементы.ГруппаПанельОтправки.Видимость = НЕ ПолучитьФункциональнуюОпцию("УправлениеТорговлей");
	
	УстановитьФункциональныеОпцииФормы();

	Если Объект.Ссылка.Пустая() Тогда
	
		ПриЧтенииСозданииНаСервере();
	
	КонецЕсли; 
	
	
	// Обработчик механизма "ВерсионированиеОбъектов"
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ИнтеграцияС1СДокументооборотом

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

	Если КлиентскоеПриложение.ТекущийВариантИнтерфейса() = ВариантИнтерфейсаКлиентскогоПриложения.Версия8_2 Тогда
		Элементы.ГруппаИтого.ЦветФона = Новый Цвет();
	КонецЕсли;
	
	
	ИспользоватьНоменклатуруПоставщиков = ПолучитьФункциональнуюОпцию("ИспользоватьНоменклатуруПоставщиков");

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
	
	ПриЧтенииСозданииНаСервере();
	
	Элементы.ГруппаКомментарий.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Комментарий);
	ИспользоватьАкцизыПриИзмененииСервер();

	СобытияФорм.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)

	ТекущийОбъект.СтруктураРеквизитовВыгрузки = Новый ХранилищеЗначения(СтруктураРеквизитовВыгрузки);

	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);

	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);
	// Конец ИнтеграцияС1СДокументооборотом
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	УчетНДСУП.УстановитьЗаголовокСостоянияОплатыНДСПоСчетуФактуре(
		Объект.Ссылка,
		Элементы.СостояниеОплатыПоСчетуФактуре);
		
	Элементы.ГруппаКомментарий.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Комментарий);
	
	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	УправлениеФормой(ЭтаФорма);
	
	Оповестить("Запись_ЗаявлениеОВвозеТоваров", ПараметрыЗаписи, Объект.Ссылка);
	
	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ОповеститьОВыборе(Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	СобытияФормКлиент.ПередЗаписью(ЭтотОбъект, Отказ, ПараметрыЗаписи);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	СобытияФормКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыПередУдалением(Элемент, Отказ)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	КоличествоСтрок = Объект.Товары.Количество();
	
	Для ОбратныйИндекс = 1 По КоличествоСтрок Цикл
		Индекс = КоличествоСтрок - ОбратныйИндекс;
		
		Если Объект.Товары[Индекс].ДокументПоступления = ТекущиеДанные.ДокументПоступления Тогда
			Объект.Товары.Удалить(Объект.Товары.Индекс(Объект.Товары[Индекс]));
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле = Элементы.ТоварыДокументПоступления Тогда
		
		ДанныеСтроки = Элемент.ДанныеСтроки(ВыбраннаяСтрока);
		ОткрытьДокумент(ДанныеСтроки.ДокументПоступления, СтандартнаяОбработка);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНалоговаяБазаНДСПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	ТекущиеДанные.СуммаНДС = УчетНДСУПКлиентСервер.РассчитатьСуммуНДС(
		ТекущиеДанные.НалоговаяБазаНДС,
		УчетНДСУПКлиентСервер.ПолучитьСтавкуНДС(ТекущиеДанные.СтавкаНДС),
		Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСтавкаНДСПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	ТекущиеДанные.СуммаНДС = УчетНДСУПКлиентСервер.РассчитатьСуммуНДС(
		ТекущиеДанные.НалоговаяБазаНДС,
		УчетНДСУПКлиентСервер.ПолучитьСтавкуНДС(ТекущиеДанные.СтавкаНДС),
		Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНалоговаяБазаАкцизыПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	РассчитатьСуммуАкцизов(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыТвердаяСтавкаАкцизаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	РассчитатьСуммуАкцизов(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыАдвалорнаяСтавкаАкцизаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	РассчитатьСуммуАкцизов(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыДокументПоступленияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДокументПоступленияОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры


&НаСервере
Процедура РасчитатьСуммыВТабличнойЧастиНаСервере(СтрокаТабличнойЧасти, ДанныеОбъекта)
	
	// Рассчитаем по фактурной стоимости налоговую базу в рублях на дату принятия на учет.
	Если ДанныеОбъекта.Валюта <> ДанныеОбъекта.ВалютаРегламентированногоУчета Тогда
		СтруктураКурса = РаботаСКурсамиВалют.ПолучитьКурсВалюты(ДанныеОбъекта.Валюта, СтрокаТабличнойЧасти.ДатаПринятияНаУчет);
		СтрокаТабличнойЧасти.НалоговаяБазаНДС = СтрокаТабличнойЧасти.ФактурнаяСтоимость * (СтруктураКурса.Курс/СтруктураКурса.Кратность);
	Иначе
		СтрокаТабличнойЧасти.НалоговаяБазаНДС = СтрокаТабличнойЧасти.ФактурнаяСтоимость;
	КонецЕсли; 
	
	// Рассчитаем по налоговой базе и ставке сумму НДС
	СтрокаТабличнойЧасти.СуммаНДС = УчетНДСУПКлиентСервер.РассчитатьСуммуНДС(
		СтрокаТабличнойЧасти.НалоговаяБазаНДС,
		УчетНДСУПКлиентСервер.ПолучитьСтавкуНДС(СтрокаТабличнойЧасти.СтавкаНДС),
		Ложь);

	// Рассчитаем по налоговой базе в рублях статистическую стоимость в долларах на дату принятия на учет.
	Если ДанныеОбъекта.ВалютаДолларыСША <> Справочники.Валюты.ПустаяСсылка() Тогда
		СтруктураКурса = РаботаСКурсамиВалют.ПолучитьКурсВалюты(ДанныеОбъекта.ВалютаДолларыСША, СтрокаТабличнойЧасти.ДатаПринятияНаУчет);
		СтрокаТабличнойЧасти.СтатСтоимостьДолларыСША = СтрокаТабличнойЧасти.НалоговаяБазаНДС * (СтруктураКурса.Кратность/СтруктураКурса.Курс);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаВыбораРеквизитыПечатиНаСервере(ВыбранноеЗначение)

	СтруктураРеквизитовПечати = ПолучитьИзВременногоХранилища(ВыбранноеЗначение.АдресХранилищаРеквизитовПечати);
	Объект.УчастникиСделки.Загрузить(СтруктураРеквизитовПечати.УчастникиСделки);
	Объект.Спецификации.Загрузить(СтруктураРеквизитовПечати.Спецификации);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьИтоги(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыВесНеттоКгПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	Если Не ТекущиеДанные.ЕдиницыРазличаются Тогда
		ТекущиеДанные.КоличествоПоТНВЭД = ТекущиеДанные.ВесНеттоКг;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьСтроки(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Организация", Объект.Организация);
	ПараметрыФормы.Вставить("Контрагент", Объект.Контрагент);
	ПараметрыФормы.Вставить("Договор", Объект.Договор);
	ПараметрыФормы.Вставить("Ссылка", Объект.Ссылка);
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	Если ТекущаяСтрока <> Неопределено Тогда
		ПараметрыФормы.Вставить("ТекущийДокумент", ТекущаяСтрока.ДокументПоступления);
	КонецЕсли;
	
	ПараметрыФормы.Вставить("МассивВыбранныхДокументов", ДокументыПартий());

	ОткрытьФорму("Документ.ЗаявлениеОВвозеТоваров.Форма.ФормаВыбораОснования", ПараметрыФормы, ЭтотОбъект,,,,,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьЗаявлениеОВвозе(Команда)
	
	
	Возврат; // В УТ не требуется
	
КонецПроцедуры

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

// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Объект);
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьДокумент(Команда)
	
	ОбщегоНазначенияУТКлиент.Записать(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПровестиДокумент(Команда)
	
	ОбщегоНазначенияУТКлиент.Провести(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПровестиИЗакрыть(Команда)
	
	ОбщегоНазначенияУТКлиент.ПровестиИЗакрыть(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура СостояниеОплатыПоСчетуФактуре(Команда)
	
	УчетНДСУПКлиент.ОткрытьФормуСостоянияОплатыНДСПоСчетуФактуре(Объект.Ссылка, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПриИзмененииРеквизитов

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ИсточникВыбора.ИмяФормы = "Документ.ЗаявлениеОВвозеТоваров.Форма.ФормаРеквизитыПечати" Тогда
		ОбработкаВыбораРеквизитыПечатиНаСервере(ВыбранноеЗначение);
	ИначеЕсли ИсточникВыбора.ИмяФормы = "Документ.ЗаявлениеОВвозеТоваров.Форма.ФормаВыбораОснования" Тогда
		ОбработкаВыбораДобавитьСтрокиИзДокументаПартии(ВыбранноеЗначение);
	КонецЕсли;
	
	УчетНДСУПКлиент.ОбработкаИзмененияСостоянияОплатыНДСПоСчетуФактуре(
		ИсточникВыбора,
		ВыбранноеЗначение,
		Элементы.СостояниеОплатыПоСчетуФактуре);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	
	УстановитьФункциональныеОпцииФормы();

	УправлениеФормой(ЭтаФорма);
	
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ОбработкаВыбораОрганизацииКонтрагента("Организация", ВыбранноеЗначение, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрагентОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ОбработкаВыбораОрганизацииКонтрагента("Контрагент", ВыбранноеЗначение, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ДоговорПриИзменении(Элемент)
	
	ДоговорПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДоговорОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ОбработкаВыбораОрганизацииКонтрагента("Договор", ВыбранноеЗначение, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ДоговорПриИзмененииНаСервере()

	РеквизитыДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект.Договор, "ВалютаВзаиморасчетов,Номер,Дата");
	
	Если ЗначениеЗаполнено(РеквизитыДоговора.Номер) Тогда
		Объект.НомерДоговора = РеквизитыДоговора.Номер;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(РеквизитыДоговора.Дата) Тогда
		Объект.ДатаДоговора = РеквизитыДоговора.Дата;
	КонецЕсли;
	
	Если Объект.Валюта <> РеквизитыДоговора.ВалютаВзаиморасчетов Тогда
		
		Объект.Валюта = РеквизитыДоговора.ВалютаВзаиморасчетов;
		НаименованиеВалютыДокумента = Объект.Валюта.Наименование;
		УправлениеФормой(ЭтаФорма);
		
		ДанныеОбъекта = Новый Структура(
			"ВалютаРегламентированногоУчета, ВалютаДолларыСША, Валюта",
			ВалютаРегламентированногоУчета, ВалютаДолларыСША, Объект.Валюта);
		
		Для Каждого СтрокаТабличнойЧасти Из Объект.Товары Цикл
			РасчитатьСуммыВТабличнойЧастиНаСервере(СтрокаТабличнойЧасти, ДанныеОбъекта);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыИспользоватьАкцизыПриИзменении(Элемент)
	
	ИспользоватьАкцизыПриИзмененииСервер();
	
КонецПроцедуры

&НаСервере
Процедура ИспользоватьАкцизыПриИзмененииСервер()
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры
	
&НаКлиенте
Процедура ТоварыКодТНВЭДПриИзменении(Элемент)
	
	ТоварыКодТНВЭДПриИзмененииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ТоварыКодТНВЭДПриИзмененииНаСервере()
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ГиперссылкиПодвалаФормы

&НаКлиенте
Процедура РеквизитыПечатиНажатие(Элемент)
	
	АдресХранилищаДопРеквизиты = ПоместитьДопРеквизитыВоВременноеХранилищеНаСервере();
	
	Если НЕ ЭтаФорма.ТолькоПросмотр Тогда
		ЭтаФорма.ЗаблокироватьДанныеФормыДляРедактирования();
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТолькоПросмотр",             ЭтаФорма.ТолькоПросмотр);
	ПараметрыФормы.Вставить("Организация",                Объект.Организация);
	ПараметрыФормы.Вставить("Контрагент",                 Объект.Контрагент);
	ПараметрыФормы.Вставить("Договор",                    Объект.Договор);
	ПараметрыФормы.Вставить("НомерДоговора",              Объект.НомерДоговора);
	ПараметрыФормы.Вставить("ДатаДоговора",               Объект.ДатаДоговора);
	ПараметрыФормы.Вставить("ОтветственноеЛицо",          Объект.ОтветственноеЛицо);
	ПараметрыФормы.Вставить("ДатаОтправки",               Объект.ДатаОтправки);
	ПараметрыФормы.Вставить("АдресХранилищаДопРеквизиты", АдресХранилищаДопРеквизиты);

	ОписаниеОповещения = Новый ОписаниеОповещения("ДопРеквизитыЗавершение", ЭтотОбъект);
	
	ОткрытьФорму("Документ.ЗаявлениеОВвозеТоваров.Форма.ФормаВыгрузки2015Кв1", ПараметрыФормы, ЭтотОбъект,,,,
		ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаСервере
Функция ПоместитьДопРеквизитыВоВременноеХранилищеНаСервере()

	КолонкиДокументовПоставки = "ДокументПоступления, ВидТранспорта, ДатаПринятияНаУчет, НомерСчетаФактуры, ДатаСчетаФактуры, СерияНомерТСД, ДатаТСД";
	ДокументыПоступления = Объект.Товары.Выгрузить(, КолонкиДокументовПоставки);
	ДокументыПоступления.Свернуть(КолонкиДокументовПоставки);
	
	СтруктураДопРеквизитов = Новый Структура;
	СтруктураДопРеквизитов.Вставить("Спецификации",                Объект.Спецификации.Выгрузить());
	СтруктураДопРеквизитов.Вставить("УчастникиСделки",             Объект.УчастникиСделки.Выгрузить());
	СтруктураДопРеквизитов.Вставить("ДатаОтправки",                Объект.ДатаОтправки);
	СтруктураДопРеквизитов.Вставить("ДокументыПоступления",        ДокументыПоступления);
	СтруктураДопРеквизитов.Вставить("СтруктураРеквизитовВыгрузки", СтруктураРеквизитовВыгрузки);
	
	Возврат ПоместитьВоВременноеХранилище(СтруктураДопРеквизитов, УникальныйИдентификатор);

КонецФункции

#КонецОбласти

#Область ОтправкаВФНС

&НаКлиенте
Процедура ОтправитьВКонтролирующийОрган(Команда)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВИнтернете(Команда)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры

#Область ПанельОтправкиВКонтролирующиеОрганы

&НаКлиенте
Процедура ПараметрыВыгрузкиЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		
		СтруктураРеквизитовВыгрузки = Результат;
		
		Модифицированность = Истина;
				
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДопРеквизитыЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		
		ПолучитьРеквизитыПечатиИзВременногоХранилища(Результат);
		
		Модифицированность = Истина;
				
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьРеквизитыПечатиИзВременногоХранилища(АдресВременногоХранилища)
	
	СтруктураДопРеквизитов = ПолучитьИзВременногоХранилища(АдресВременногоХранилища);
	
	СтруктураРеквизитовВыгрузки = СтруктураДопРеквизитов.СтруктураРеквизитовВыгрузки;
	Объект.Спецификации.Загрузить(СтруктураДопРеквизитов.Спецификации);
	Объект.УчастникиСделки.Загрузить(СтруктураДопРеквизитов.УчастникиСделки);
	Объект.Договор           = СтруктураДопРеквизитов.Договор;
	Объект.НомерДоговора     = СтруктураДопРеквизитов.НомерДоговора;
	Объект.ДатаДоговора      = СтруктураДопРеквизитов.ДатаДоговора;
	Объект.ОтветственноеЛицо = СтруктураДопРеквизитов.ОтветственноеЛицо;
	Объект.ДатаОтправки      = СтруктураДопРеквизитов.ДатаОтправки;
	
	Для каждого Строка Из Объект.Товары Цикл
		Для каждого СтрокаДопРеквизиты Из СтруктураДопРеквизитов.ДокументыПоступления Цикл
			Если Строка.ДокументПоступления = СтрокаДопРеквизиты.ДокументПоступления Тогда
				ЗаполнитьЗначенияСвойств(Строка, СтрокаДопРеквизиты);
				Строка.КодВидаТранспорта = Лев(Строка.ВидТранспорта, 2);
				
				Если Строка.ДатаПринятияНаУчет = СтрокаДопРеквизиты.ДатаПринятияНаУчет Тогда
					
					ДанныеСтрокиТаблицы = Новый Структура(
						"ДатаПринятияНаУчет, ФактурнаяСтоимость, НалоговаяБазаНДС, СтавкаНДС, 
						|СуммаНДС, СтатСтоимостьДолларыСША");
					ДанныеОбъекта = Новый Структура(
						"ВалютаРегламентированногоУчета, ВалютаДолларыСША, Валюта",
						ВалютаРегламентированногоУчета, ВалютаДолларыСША, Строка.Валюта);
						
					ЗаполнитьЗначенияСвойств(ДанныеСтрокиТаблицы, Строка);
					РасчитатьСуммыВТабличнойЧастиНаСервере(ДанныеСтрокиТаблицы, ДанныеОбъекта);
					ЗаполнитьЗначенияСвойств(Строка, ДанныеСтрокиТаблицы);
					
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры


&НаСервере
Функция ПолучитьСведенияОПредставителе(КодИФНС) Экспорт
	
	флПредставительЮрЛицо = Истина;
	НаименованиеОрганизацииПредставителя = "";
	ФИОПредставителя = "";
	ТипПредставителя = "1";
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	РегистрацииВНалоговомОргане.Код,
	|	РегистрацииВНалоговомОргане.КПП,
	|	РегистрацииВНалоговомОргане.Представитель,
	|	РегистрацииВНалоговомОргане.УполномоченноеЛицоПредставителя
	|ИЗ
	|	Справочник.РегистрацииВНалоговомОргане КАК РегистрацииВНалоговомОргане
	|ГДЕ
	|	РегистрацииВНалоговомОргане.Код = &Код
	|	И РегистрацииВНалоговомОргане.Владелец = &Владелец");
	
	Запрос.УстановитьПараметр("Код", КодИФНС);
	Запрос.УстановитьПараметр("Владелец", Объект.Организация);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() И ЗначениеЗаполнено(Выборка.Представитель) Тогда
		
		ТипПредставителя = "2";
		
		Если НЕ ПредставительЯвляетсяФизЛицом(Выборка.Представитель) Тогда
			
			флПредставительЮрЛицо = Истина;
			ФИОПредставителя = СокрЛП(Выборка.УполномоченноеЛицоПредставителя);
			ПредставительСсылка = Выборка.Представитель;
			
		Иначе
			
			флПредставительЮрЛицо = Ложь;
			ПредставительСсылка = Выборка.Представитель;
			ФИОПредставителя = СокрЛП(ПредставительСсылка);
			
		КонецЕсли;
	КонецЕсли;
	
	Структура = Новый Структура;
	Структура.Вставить("ТипПредставителя",      ТипПредставителя);
	Структура.Вставить("флПредставительЮрЛицо", флПредставительЮрЛицо);
	Структура.Вставить("ФИОПредставителя",      ФИОПредставителя);
	Структура.Вставить("ПредставительСсылка",   ПредставительСсылка);
	Возврат Структура;
	
КонецФункции

&НаСервере
Функция ПредставительЯвляетсяФизЛицом(Представитель) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Представитель) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Метаданные.Справочники.Найти("ФизическиеЛица") = Неопределено Тогда
		Возврат Представитель.ВидКонтрагента = Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо;
	Иначе
		Возврат ТипЗнч(Представитель) = Тип("СправочникСсылка.ФизическиеЛица");
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область ПодачаСтатформыВФТС

&НаКлиенте
Процедура СоздатьСтатформуВФТСНажатие(Элемент)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры


#КонецОбласти

#КонецОбласти

#Область Прочее

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	// НомерСчетаФактуры
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыНомерСчетаФактуры.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.НомерСчетаФактуры");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НезаполненноеПолеТаблицы);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = 'Номер'"));

	// ДатаСчетаФактуры
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыДатаСчетаФактуры.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.ДатаСчетаФактуры");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НезаполненноеПолеТаблицы);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = 'Дата'"));

	// отметка незаполненного "количество по ТН ВЭД"
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыКоличествоПоТНВЭД.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.КоличествоПоТНВЭД");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = 0;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.ЕдиницыРазличаются");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Истина);
	
	// КоличествоПоТНВЭД 
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыКоличествоПоТНВЭД.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.ЕдиницыРазличаются");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НезаполненноеПолеТаблицы);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '<не заполняется>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);

	// КодТНВЭДЕдиницаИзмерения 
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыКодТНВЭДЕдиницаИзмерения.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.ЕдиницыРазличаются");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НезаполненноеПолеТаблицы);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", "");
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
	
	Элементы.ТоварыГруппаАкцизы.Видимость = Объект.ИспользоватьАкцизы;
	
	// ГруппаАкцизы 
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыГруппаАкцизы.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ИспользоватьАкцизы");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);
	
КонецПроцедуры	
	
&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьИтоги(Форма)

	Объект = Форма.Объект;
	Форма.ИтогиВсегоНДС = Окр(Объект.Товары.Итог("СуммаНДС"));

КонецПроцедуры

&НаСервере
Процедура УстановитьФункциональныеОпцииФормы() Экспорт

	ПараметрыФО = Новый Структура();
	ПараметрыФО.Вставить("Организация", Объект.Организация);
	ПараметрыФО.Вставить("Период", Объект.Дата);
	
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыФО);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()

	Килограммы = Справочники.УпаковкиЕдиницыИзмерения.НайтиПоКоду("166");
	ВалютаРегламентированногоУчета = ЗначениеНастроекПовтИсп.ПолучитьВалютуРегламентированногоУчета();
	ВалютаДолларыСША = Справочники.Валюты.НайтиПоКоду("840");
	Если Не ЗначениеЗаполнено(Объект.Валюта) Тогда
		Объект.Валюта = ВалютаРегламентированногоУчета;
	КонецЕсли;
	
	НаименованиеВалютыРегУчета = ВалютаРегламентированногоУчета.Наименование;
	Элементы.ТоварыНалоговаяБазаНДС.Заголовок    = НСтр("ru = 'База НДС'")              + ", " + НаименованиеВалютыРегУчета;
	Элементы.ТоварыСуммаНДС.Заголовок            = НСтр("ru = 'НДС'")                   + ", " + НаименованиеВалютыРегУчета;
	Элементы.ТоварыТвердаяСтавкаАкциза.Заголовок = НСтр("ru = 'Твердая ставка акциза'") + ", " + НаименованиеВалютыРегУчета;
	Элементы.ТоварыСуммаАкциза.Заголовок         = НСтр("ru = 'Сумма акциза'")          + ", " + НаименованиеВалютыРегУчета;
	
	УчетНДСУП.УстановитьЗаголовокСостоянияОплатыНДСПоСчетуФактуре(
		Объект.Ссылка,
		Элементы.СостояниеОплатыПоСчетуФактуре);

	УправлениеФормой(ЭтаФорма);
	ОбновитьИтоги(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	Объект	 = Форма.Объект;
	
	Для каждого Строка Из Объект.Товары Цикл
	
		Если ПустаяСтрока(Строка.Товар) Тогда
			Строка.Товар = 	"" + Строка.Номенклатура
							+ ?(ЗначениеЗаполнено(Строка.Характеристика), ", " + Строка.Характеристика, "")
							+ ?(ЗначениеЗаполнено(Строка.Серия), ", " + Строка.Серия, "");
		КонецЕсли;
		
		ЕдиницаТНВЭД = ОбщегоНазначенияУТВызовСервера.ЗначениеРеквизитаОбъекта(Строка.КодТНВЭД, "ЕдиницаИзмерения");
		Если ЕдиницаТНВЭД = Форма.Килограммы Тогда
			Строка.КоличествоПоТНВЭД = Строка.ВесНеттоКг;
		ИначеЕсли ЕдиницаТНВЭД = Строка.ЕдиницаИзмерения Тогда
			Строка.КоличествоПоТНВЭД = Строка.Количество;
		КонецЕсли;
		Строка.ЕдиницыРазличаются = ЕдиницаТНВЭД <> Форма.Килограммы;
		
		Если Не Объект.ИспользоватьАкцизы И Строка.НалоговаяБазаАкцизы <> 0 Тогда
			Строка.НалоговаяБазаАкцизы = 0;
			Строка.СуммаАкциза = 0;
			Строка.ТвердаяСтавкаАкциза = 0;
			Строка.АдвалорнаяСтавкаАкциза = 0;
		ИначеЕсли Объект.ИспользоватьАкцизы И Строка.НалоговаяБазаАкцизы = 0 Тогда
			Строка.НалоговаяБазаАкцизы = Строка.НалоговаяБазаНДС;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ДокументыПартий()
	
	ТаблицаТовары = Объект.Товары.Выгрузить(, "ДокументПоступления");
	ТаблицаТовары.Свернуть("ДокументПоступления");
	Возврат ТаблицаТовары.ВыгрузитьКолонку("ДокументПоступления");
	
КонецФункции

&НаСервере
Процедура ОбработкаВыбораДобавитьСтрокиИзДокументаПартии(МассивДокументов)
	
	Для каждого ЭлементМассива Из МассивДокументов Цикл
		ТаблицаТовары = Документы.ЗаявлениеОВвозеТоваров.ТаблицаОстатковТоваровКОформлениюЗаявленийОВвозеТоваров(ЭлементМассива.Ссылка);
		
		Для каждого СтрокаТаблицыТовары Из ТаблицаТовары Цикл
			Если СтрокаТаблицыТовары.НалоговаяБазаНДС <> 0 Тогда
				СтрокаТаблицыТовары.СуммаНДС = УчетНДСУПКлиентСервер.РассчитатьСуммуНДС(
					СтрокаТаблицыТовары.НалоговаяБазаНДС,
					УчетНДСУПКлиентСервер.ПолучитьСтавкуНДС(СтрокаТаблицыТовары.СтавкаНДС),
					Ложь);
			КонецЕсли;
				
			Если Не Объект.ИспользоватьАкцизы Тогда
				СтрокаТаблицыТовары.НалоговаяБазаАкцизы = 0;
			КонецЕсли;
				
			НоваяСтрока = Объект.Товары.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТаблицыТовары);
			
			ДанныеОбъекта = Новый Структура(
				"ВалютаРегламентированногоУчета, ВалютаДолларыСША, Валюта",
				ВалютаРегламентированногоУчета, ВалютаДолларыСША, СтрокаТаблицыТовары.Валюта);
			РасчитатьСуммыВТабличнойЧастиНаСервере(НоваяСтрока, ДанныеОбъекта);
		КонецЦикла;
		
		Если Не ЗначениеЗаполнено(Объект.Договор) Тогда
			Объект.Договор = ЭлементМассива.Ссылка.Договор;
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Объект.Валюта) Тогда
			Объект.Валюта = ЭлементМассива.Валюта;
		КонецЕсли;
		
		Модифицированность = Истина;
	КонецЦикла;
	
	ОбновитьИтоги(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьСуммуАкцизов(ТекущаяСтрока)
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока.СуммаАкциза = ТекущаяСтрока.НалоговаяБазаАкцизы * ТекущаяСтрока.ТвердаяСтавкаАкциза 
									+ ТекущаяСтрока.НалоговаяБазаАкцизы * ТекущаяСтрока.АдвалорнаяСтавкаАкциза / 100;

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьДокумент(Ссылка, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		СтандартнаяОбработка = Ложь;
		ПоказатьЗначение(Неопределено, Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораОрганизацииКонтрагента(ИмяРеквизита, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если Объект.Товары.Количество() > 0 И ВыбранноеЗначение <> Объект[ИмяРеквизита] Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ДополнительныеПараметры = Новый Структура("ИмяРеквизита, ВыбранноеЗначение", ИмяРеквизита, ВыбранноеЗначение);
		ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаВыбораЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ТекстВопроса = НСтр("ru = 'Табличная часть документа будет очищена. Продолжить?'");
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт

	ОтветНаВопрос = РезультатВопроса;
	Если ОтветНаВопрос = КодВозвратаДиалога.Да Тогда
		Объект[ДополнительныеПараметры.ИмяРеквизита] = ДополнительныеПараметры.ВыбранноеЗначение;
		Объект.Товары.Очистить();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыгрузку(Команда)
	
	
	Возврат; // В УТ не требуется
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыАналитикаУчетаНоменклатурыОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыВидЗапасовОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЗакупкаПодДеятельностьОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

#Область ПанельОтправкиВКонтролирующиеОрганы

&НаКлиенте
Процедура ОбновитьОтправку(Команда)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПротоколНажатие(Элемент)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьНеотправленноеИзвещение(Команда)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыОтправкиНажатие(Элемент)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры

&НаКлиенте
Процедура КритическиеОшибкиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	
	Возврат; // Не требуется в УТ
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти 

#КонецОбласти
