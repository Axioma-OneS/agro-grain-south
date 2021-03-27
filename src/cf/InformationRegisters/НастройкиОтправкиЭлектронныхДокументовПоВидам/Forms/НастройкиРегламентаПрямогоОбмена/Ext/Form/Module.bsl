﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("Организация"               , Организация);
	Параметры.Свойство("УчетнаяЗаписьПредставление", УчетнаяЗаписьПредставление);
	Параметры.Свойство("ИдентификаторОтправителя"  , ИдентификаторОтправителя);
	Параметры.Свойство("ИдентификаторПолучателя"   , ИдентификаторПолучателя);
	Параметры.Свойство("СпособОбмена"              , СпособОбмена);
	Параметры.Свойство("ВидДокумента"              , ВидДокумента);
	Параметры.Свойство("ПрикладнойВидЭД"           , ПрикладнойВидЭД);
	Параметры.Свойство("ВерсияФормата"             , ВерсияФормата);
	Параметры.Свойство("АдресПолучателя"           , АдресПолучателя);
	Параметры.Свойство("АдресОтправителя"          , АдресОтправителя);
	Параметры.Свойство("ИспользоватьПодпись"       , ИспользоватьПодпись);
	Параметры.Свойство("МаршрутПодписания"         , МаршрутПодписания);
	Параметры.Свойство("ОжидатьОтветнуюПодпись"    , ОжидатьОтветнуюПодпись);
	Параметры.Свойство("ОжидатьИзвещение"          , ОжидатьИзвещение);
	Параметры.Свойство("ЗаполнениеКодаТовара"      , ЗаполнениеКодаТовара);
	Параметры.Свойство("РасширенныйРежим"          , РасширенныйРежим);
	Параметры.Свойство("ВерсияФорматаУстановленаВручную", ВерсияФорматаУстановленаВручную);
	
	ЗаполнитьДанныеФормы();
	
	НастроитьОтображениеЭлементовФормы();
	
	СброситьРазмерыИПоложениеОкна();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура УчетнаяЗаписьПриИзменении(Элемент)
	ПриИзмененииУчетнойЗаписи();
КонецПроцедуры

&НаКлиенте
Процедура УчетнаяЗаписьОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура УчетнаяЗаписьОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОбменСКонтрагентамиСлужебныйКлиент.ОткрытьФормуУчетнойЗаписиЭДО(ИдентификаторОтправителя);
КонецПроцедуры

&НаКлиенте
Процедура УчетнаяЗаписьОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ВыбранноеЗначение <> Идентификатор_Создать() Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	Оповещение = Новый ОписаниеОповещения("ОбновитьПараметрыУчетнойЗаписиПослеСоздания", ЭтотОбъект);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Организация", Организация);
	
	ОткрытьФорму("РегистрСведений.УчетныеЗаписиЭДО.Форма.УчетнаяЗаписьПрямогоОбмена",
		ПараметрыФормы, ЭтотОбъект,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ВерсияФорматаОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ВерсияФорматаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ВерсияФорматаУстановленаВручную Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	Оповещение = Новый ОписаниеОповещения("УстановитьВерсиюФорматаПослеВопроса", ЭтотОбъект, ВыбранноеЗначение);
	ТекстВопроса = НСтр("ru = 'В случае ручной корректировки будет отключен автоматический подбор формата, наиболее оптимального для обмена с выбранным контрагентом.
		|Продолжить?'");
	ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьПодписьПриИзменении(Элемент)
	
	Если Не ВидДокументаБезТитула Тогда
	ИначеЕсли ИспользоватьПодпись Тогда
		ОжидатьОтветнуюПодпись = ОжидатьОтветнуюПодписьПоУмолчанию(ВидДокумента);
	Иначе
		ОжидатьОтветнуюПодпись = Ложь;
	КонецЕсли;
	
	УстановитьДоступностьНастроекПодписания(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОжидатьОтветнуюПодписьПриИзменении(Элемент)
	
	Если ОжидатьОтветнуюПодпись Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ИзменитьОжиданиеОтветнойПодписиПослеПодтверждения", ЭтотОбъект);
	ОбменСКонтрагентамиСлужебныйКлиент.ЗапроситьПодтверждениеОтключенияОжиданияОтветнойПодписи(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнениеКодаТовараОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПринятьИЗакрыть(Команда)
	
	Если ЕстьОшибкиЗаполнениеРеквизитов() Тогда
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Организация"               , Организация);
	Результат.Вставить("СпособОбмена"              , СпособОбмена);
	Результат.Вставить("ВерсияФормата"             , ВерсияФормата);
	Результат.Вставить("УчетнаяЗаписьПредставление", УчетнаяЗаписьПредставление);
	Результат.Вставить("ИдентификаторОтправителя"  , ИдентификаторОтправителя);
	Результат.Вставить("ИдентификаторПолучателя"   , ИдентификаторПолучателя);
	Результат.Вставить("АдресПолучателя"           , АдресПолучателя);
	Результат.Вставить("АдресОтправителя"          , АдресОтправителя);
	Результат.Вставить("ИспользоватьПодпись"       , ИспользоватьПодпись);
	Результат.Вставить("МаршрутПодписания"         , МаршрутПодписания);
	Результат.Вставить("ОжидатьОтветнуюПодпись"    , ОжидатьОтветнуюПодпись);
	Результат.Вставить("ОжидатьИзвещение"          , ОжидатьИзвещение);
	Результат.Вставить("ЗаполнениеКодаТовара"      , ЗаполнениеКодаТовара);
	Результат.Вставить("ВерсияФорматаУстановленаВручную",
		ВерсияФорматаУстановленаВручную);
	
	Закрыть(Результат);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьДанныеФормы();
	
	Если Не ЗначениеЗаполнено(МаршрутПодписания) Тогда
		МаршрутПодписания = Справочники.МаршрутыПодписания.ОднойДоступнойПодписью;
	КонецЕсли;
	
	ВидДокументаБезТитула = ОбменСКонтрагентамиСлужебный.ЭтоВидЭДБезТитула(ВидДокумента);
	
	НастройкиРегламентаЭДО = ОбменСКонтрагентамиСлужебный.НастройкиРегламентаЭДО(
		ВидДокумента, ВерсияФормата, СпособОбмена);
	РедактироватьОтветнуюПодпись = НастройкиРегламентаЭДО.РедактироватьОтветнуюПодпись;
	
	ЗаполнитьСписокУчетныхЗаписей();
	
	ЗаполнитьСписокФорматовПоВидуДокумента();
	
	ИнициализироватьВариантыЗаполненияПолей();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокУчетныхЗаписей()
	
	Если Не РасширенныйРежим Тогда
		Возврат;
	КонецЕсли;
	
	СписокВыбора = Элементы.УчетнаяЗапись.СписокВыбора;
	СписокВыбора.Очистить();
	
	ОбменСКонтрагентамиСлужебный.ЗаполнитьСписокУчетныхЗаписейПрямогоОбмена(СписокВыбора, Организация);
	
	Если ПустаяСтрока(ИдентификаторОтправителя)
		И СписокВыбора.Количество() = 1 Тогда
		ИдентификаторОтправителя = СписокВыбора[0].Значение;
	КонецЕсли;
	
	СписокВыбора.Добавить(Идентификатор_Создать(), НСтр("ru = 'Создать новую учетную запись'"),,
		БиблиотекаКартинок.СоздатьЭлементСписка);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокФорматовПоВидуДокумента()
	
	СписокВыбора = Элементы.ВерсияФормата.СписокВыбора;
	СписокВыбора.Очистить();
	
	Если Не ЗначениеЗаполнено(ВидДокумента) Тогда
		Возврат;
	КонецЕсли;
	
	ФорматыЭлектронныхДокументов = ОбменСКонтрагентамиСлужебный.ФорматыЭлектронныхДокументов();
	
	Отбор = Новый Структура("Действует", Истина);
	Если ВидДокумента = Перечисления.ВидыЭД.ПрикладнойЭД Тогда
		Отбор.Вставить("ПрикладнойВидЭД", ПрикладнойВидЭД);
	Иначе
		Отбор.Вставить("ВидЭлектронногоДокумента", ВидДокумента);
	КонецЕсли;
	
	НайденныеСтроки = ФорматыЭлектронныхДокументов.НайтиСтроки(Отбор);
	Для Каждого СтрокаФормата Из НайденныеСтроки Цикл
		СписокВыбора.Добавить(СтрокаФормата.ИдентификаторФормата, СтрокаФормата.ПредставлениеФормата);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьОтображениеЭлементовФормы()
	
	Элементы.ГруппаРасширенныйРежим.Видимость = РасширенныйРежим;
	
	Элементы.ГруппаВерсияФормата.Видимость = ВидДокумента <> Перечисления.ВидыЭД.ПроизвольныйЭД;
	
	Если Не ВидДокументаБезТитула Тогда
		Элементы.ОжидатьОтветнуюПодпись.Заголовок = НСтр("ru = 'Ожидать ответный титул'");
	КонецЕсли;
	
	УстановитьОтображениеТранспортныхНастроек();
	
	УстановитьДоступностьНастроекПодписания(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтображениеТранспортныхНастроек()
	
	Если Не РасширенныйРежим Тогда
		Элементы.АдресОтправителя.Видимость = Ложь;
		Элементы.АдресПолучателя.Видимость  = Ложь;
	ИначеЕсли СпособОбмена = Перечисления.СпособыОбменаЭД.ЧерезЭлектроннуюПочту Тогда
		Элементы.АдресОтправителя.Видимость = Ложь;
		Элементы.АдресПолучателя.Заголовок  = НСтр("ru = 'Электронная почта получателя'");
	Иначе
		Элементы.АдресОтправителя.Видимость = Истина;
		Элементы.АдресОтправителя.Заголовок = НСтр("ru = 'Каталог отправителя'");
		Элементы.АдресПолучателя.Заголовок  = НСтр("ru = 'Каталог получателя'");;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьНастроекПодписания(Форма)
	Элементы = Форма.Элементы;
	Элементы.МаршрутПодписания.Доступность = Форма.ИспользоватьПодпись;
	Если Форма.ВидДокументаБезТитула Тогда
		Элементы.ОжидатьОтветнуюПодпись.Доступность = Форма.ИспользоватьПодпись
			И Форма.РедактироватьОтветнуюПодпись;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПараметрыУчетнойЗаписиПослеСоздания(УчетнаяЗапись, Контекст) Экспорт
	
	Если Не ЗначениеЗаполнено(УчетнаяЗапись) Тогда
		Возврат;
	КонецЕсли;
	
	ИдентификаторОтправителя = УчетнаяЗапись.ИдентификаторЭДО;
	СпособОбмена = УчетнаяЗапись.СпособОбмена;
	
	НастроитьОтображениеЭлементовФормы();
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьВариантыЗаполненияПолей()
	
	ВариантыЗаполненияПолей = ОбменСКонтрагентамиВнутренний.ВариантыЗаполненияПолейЭлектронныхДокументов(
		ВидДокумента, ВерсияФормата);
	
	ЗначениеСвойства = Неопределено;
	Если ВариантыЗаполненияПолей.Свойство("ТоварКод", ЗначениеСвойства) Тогда
		Для Каждого Вариант Из ЗначениеСвойства Цикл
			ЗаполнитьЗначенияСвойств(Элементы.ЗаполнениеКодаТовара.СписокВыбора.Добавить(), Вариант);
		КонецЦикла;
	Иначе
		Элементы.ЗаполнениеКодаТовара.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииУчетнойЗаписи()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	УчетныеЗаписиЭДО.НаименованиеУчетнойЗаписи КАК НаименованиеУчетнойЗаписи,
		|	УчетныеЗаписиЭДО.Организация КАК Организация,
		|	УчетныеЗаписиЭДО.СпособОбменаЭД КАК СпособОбмена
		|ИЗ
		|	РегистрСведений.УчетныеЗаписиЭДО КАК УчетныеЗаписиЭДО
		|ГДЕ
		|	УчетныеЗаписиЭДО.ИдентификаторЭДО = &ИдентификаторЭДО";
	Запрос.УстановитьПараметр("ИдентификаторЭДО", ИдентификаторОтправителя);
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	УчетнаяЗаписьПредставление = Выборка.НаименованиеУчетнойЗаписи;
	Организация = Выборка.Организация;
	
	Если Выборка.СпособОбмена = СпособОбмена Тогда
		Возврат;
	КонецЕсли;
	
	СпособОбмена = Выборка.СпособОбмена;
	АдресОтправителя = "";
	АдресПолучателя  = "";
	
	УстановитьОтображениеТранспортныхНастроек();
	
КонецПроцедуры

&НаСервере
Функция ОжидатьОтветнуюПодписьПоУмолчанию(Знач ВидДокумента)
	
	НастройкаПоУмолчанию = Новый Структура("Формировать, ДокументУчета, ВидДокумента, ПрикладнойВидЭД, ВерсияФормата,
		|ТребуетсяИзвещениеОПолучении, ТребуетсяОтветнаяПодпись, МаршрутПодписания, Приоритет");
	Если ВидДокумента = Перечисления.ВидыЭД.ПрикладнойЭД Тогда
		ОбменСКонтрагентамиСлужебный.ЗаполнитьНастройкуПоПрикладномуВидуЭлектронногоДокумента(
			НастройкаПоУмолчанию, ВидДокумента);
	Иначе
		ОбменСКонтрагентамиСлужебный.ЗаполнитьНастройкуПоВидуЭлектронногоДокумента(НастройкаПоУмолчанию,ВидДокумента);
	КонецЕсли;
	
	Возврат НастройкаПоУмолчанию.ТребуетсяОтветнаяПодпись;
	
КонецФункции

&НаКлиенте
Процедура УстановитьВерсиюФорматаПослеВопроса(Ответ, Значение) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ВерсияФормата = Значение;
		ВерсияФорматаУстановленаВручную = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьОжиданиеОтветнойПодписиПослеПодтверждения(Ответ, Контекст) Экспорт
	
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		ОжидатьОтветнуюПодпись = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЕстьОшибкиЗаполнениеРеквизитов(Выводить = Истина)
	
	ЕстьОшибки = Ложь;
	
	Если Не РасширенныйРежим Тогда
		Возврат ЕстьОшибки;
	КонецЕсли;
	
	ПроверитьЗначениеЗаполнено(Элементы.ИдентификаторОтправителя, Выводить, ЕстьОшибки);
	
	ПроверитьЗначениеЗаполнено(Элементы.ИдентификаторПолучателя, Выводить, ЕстьОшибки);
	
	ПроверитьЗначениеЗаполнено(Элементы.АдресПолучателя, Выводить, ЕстьОшибки);
	
	Если СпособОбмена = Перечисления.СпособыОбменаЭД.ЧерезЭлектроннуюПочту Тогда
		ПроверитьКорректностьЭлектроннойПочты(Элементы.АдресПолучателя, Выводить, ЕстьОшибки);
	Иначе
		ПроверитьНедопустимыеСимволыВИмениФайла(Элементы.АдресПолучателя, Выводить, ЕстьОшибки);
		
		ПроверитьЗначениеЗаполнено(Элементы.АдресОтправителя, Выводить, ЕстьОшибки);
		ПроверитьНедопустимыеСимволыВИмениФайла(Элементы.АдресОтправителя, Выводить, ЕстьОшибки);
	КонецЕсли;
	
	Возврат ЕстьОшибки;
	
КонецФункции

&НаСервере
Процедура ПроверитьЗначениеЗаполнено(Элемент, Выводить, Отказ)
	
	ЗначениеРеквизита = ЭтотОбъект[Элемент.ПутьКДанным];
	Если ЗначениеЗаполнено(ЗначениеРеквизита) Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	
	Если Выводить Тогда
		ТекстСообщения = СтрШаблон(НСтр("ru = 'Поле ""%1"" не заполнено.'"), Элемент.Заголовок);
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,Элемент.ПутьКДанным);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьНедопустимыеСимволыВИмениФайла(Элемент, Выводить, Отказ)
	
	ЗначениеРеквизита = ЭтотОбъект[Элемент.ПутьКДанным];
	Если Не ЗначениеЗаполнено(ЗначениеРеквизита) Тогда
		Возврат;
	КонецЕсли;
	
	НедопустимыеСимволы = ОбщегоНазначенияКлиентСервер.НайтиНедопустимыеСимволыВИмениФайла(ЗначениеРеквизита);
	Если НедопустимыеСимволы.Количество() Тогда
		Отказ = Истина;
		Если Выводить Тогда
			ШаблонТекста = НСтр("ru = 'Наименование папки содержит запрещенные символы (%1)'");
			ТекстСообщения = СтрШаблон(ШаблонТекста, СтрСоединить(НедопустимыеСимволы, " "));
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,Элемент.ПутьКДанным);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьКорректностьЭлектроннойПочты(Элемент, Выводить, Отказ)
	
	ЗначениеРеквизита = ЭтотОбъект[Элемент.ПутьКДанным];
	Если Не ЗначениеЗаполнено(ЗначениеРеквизита) Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ОбщегоНазначенияКлиентСервер.АдресЭлектроннойПочтыСоответствуетТребованиям(ЗначениеРеквизита) Тогда
		Отказ = Истина;
		Если Выводить Тогда
			ТекстСообщения = НСтр("ru = 'Электронная почта указана не верно'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,, Элемент.ПутьКДанным);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СброситьРазмерыИПоложениеОкна()
	
	ИмяПользователя = ПользователиИнформационнойБазы.ТекущийПользователь().Имя;
	
	Если ПравоДоступа("СохранениеДанныхПользователя", Метаданные) Тогда
		ХранилищеСистемныхНастроек.Удалить("ОбщаяФорма.НастройкаРегламентаЭДО", "", ИмяПользователя);
	КонецЕсли;
	
	КлючСохраненияПоложенияОкна = Строка(Новый УникальныйИдентификатор);
	
КонецПроцедуры

#Область ТипыИдентификаторовУчетныхЗаписей

&НаКлиентеНаСервереБезКонтекста
Функция Идентификатор_Создать()
	Возврат "Создать";
КонецФункции

#КонецОбласти

#КонецОбласти