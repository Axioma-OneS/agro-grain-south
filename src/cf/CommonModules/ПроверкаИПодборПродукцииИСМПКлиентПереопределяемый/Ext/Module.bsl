﻿#Область СлужебныйПрограммныйИнтерфейс

#Область СерииНоменклатуры

// Добавляет зависящие от владельца формы проверки и подбора значения в параметры указания серий номенклатуры.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма с товарами, для которой необходимо определить параметры указания серий.
//  ПараметрыУказанияСерий - Структура - дополняемые параметры указания серий.
Процедура ДополнитьПараметрыУказанияСерий(Форма, ПараметрыУказанияСерий) Экспорт
	
	//++ НЕ ГОСИС
	ПроверкаИПодборПродукцииИСМПУТКлиент.ДополнитьПараметрыУказанияСерий(Форма, ПараметрыУказанияСерий);
	//-- НЕ ГОСИС
	
	Возврат;
	
КонецПроцедуры

// Формирует структуру, массив которых в дальнейшем будет передан в процедуру генерации серий.
//
// Параметры:
//  * ДанныеДляГенерацииСерии - Структура - Описание:
//  ** Номенклатура - ОпределяемыйТип.Номенклатура - Номенклатура, для которой будет генерироваться серия.
//  ** Серия        - ОпределяемыйТип.СерияНоменклатуры - В данное значение будет записана сгенерированная серия.
//  ** ЕстьОшибка   - Булево - Будет установлено в Истина, если по каким то причинам серия сгенерирована не будет.
//  ** ТекстОшибки  - Строка - причина, по которой серия не генерировалась.
//  ** МРЦ          - Число - только для табачной продукции, максимальная розничная цена.
//  * ВидМаркируемойПродукции - ПеречислениеСсылка.ВидыПродукцииИС - вид маркируемой продукции, для которой получается структура данных
Процедура ПолучитьДанныеДляГенерацииСерии(ДанныеДляГенерацииСерии, ВидМаркируемойПродукции) Экспорт
	
	//++ НЕ ГОСИС
	ДанныеДляГенерацииСерии = ИнтеграцияИСМПУТКлиентСервер.СтруктураДанныхДляГенерацииСерии(ВидМаркируемойПродукции);
	//-- НЕ ГОСИС
	
	Возврат;

КонецПроцедуры

#КонецОбласти

#Область ОткрытиеФормыПроверкиИПодбора

// Заполняет специфичные параметры открытия форм проверки и подбора маркируемой продукции в зависимости от точки вызова
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма из которой происходит открытие формы проверки и подбора
//  Параметры - (См. ПроверкаИПодборПродукцииИСМПКлиент.ПараметрыОткрытияФормыПроверкиИПодбора)
//
Процедура ПриУстановкеПараметровОткрытияФормыПроверкиИПодбора(Форма, Параметры) Экспорт

	//++ НЕ ГОСИС
	Если ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "РеализацияТоваровУслуг")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "КорректировкаРеализации")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ВозвратТоваровПоставщику")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ВозвратТоваровОтКлиента")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ПриобретениеТоваровУслуг") Тогда

		Параметры.ИмяРеквизитаДокументОснование = "";

	ИначеЕсли ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ЧекККМ")
		ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ЧекККМВозврат") Тогда

		Параметры.ИмяРеквизитаДокументОснование = "";
		Параметры.ПроверятьМодифицированность   = Ложь;
		
		ПараметрыОповещенияПриЗакрытии = Новый Структура;
		ПараметрыОповещенияПриЗакрытии.Вставить("Форма", Форма);
		ПараметрыОповещенияПриЗакрытии.Вставить("ВидПродукции", Параметры.ВидМаркируемойПродукции);
		
		Параметры.ОписаниеОповещенияПриЗакрытии = Новый ОписаниеОповещения(
			"ПриЗакрытииФормыПроверкиИПодбора",
			ПроверкаИПодборПродукцииИСМПУТКлиент,
			ПараметрыОповещенияПриЗакрытии);

		Параметры.АдресПроверяемыхДанных = ПроверкаИПодборПродукцииИСМПУТВызовСервера.АдресДанныхПроверкиМаркируемойПродукцииЧекККМ(
			ШтрихкодированиеИСКлиент.ПараметрыСканирования(Форма,, Параметры.ВидМаркируемойПродукции),
			Форма.Объект,
			Форма.УникальныйИдентификатор,
			Параметры.ВидМаркируемойПродукции);

	КонецЕсли;
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма,"ПараметрыИнтеграцииГосИС") Тогда
		
		НастройкиИнтеграции = Форма.ПараметрыИнтеграцииГосИС.Получить(Параметры.ВидМаркируемойПродукции);
		Если Не(НастройкиИнтеграции = Неопределено) Тогда
			Параметры.ПроверкаЭлектронногоДокумента = НастройкиИнтеграции.ЕстьЭлектронныйДокумент;
		КонецЕсли;
		
	КонецЕсли;
	//-- НЕ ГОСИС
	Возврат;

КонецПроцедуры

// Выполняет специфичные действия после закрытия форм проверки и подбора маркируемой продукции в зависимости от точки вызова
//
// Параметры:
//  РезультатЗакрытия - Произвольный - результат закрытия формы проверки и подбора
//  ДополнительныеПараметры - Структура с реквизитом Форма (управляемая форма из которой происходил вызов)
//
Процедура ПриЗакрытииФормыПроверкиИПодбора(РезультатЗакрытия, ДополнительныеПараметры) Экспорт

	//++ НЕ ГОСИС
	ДополнительныеПараметры.Форма.Прочитать();
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// Выполняет специфичные действия перед открытием форм проверки и подбора маркируемой продукции в зависимости от точки вызова
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения       - форма из которой происходит открытие формы проверки и подбора
//  ПараметрыОткрытияФормыПроверки - Структура - параметры открытия формы проверки и подбора для формы-источника
//  ПараметрыФормыПроверки         - Структура - подготовленные параметры открытия формы проверки и подбора
//  Отказ                          - Булево    - отказ от открытия формы
//
Процедура ПередОткрытиемФормыПроверкиПодбора(Форма, ПараметрыОткрытияФормыПроверки, ПараметрыФормыПроверки, Отказ) Экспорт
	
	//++ НЕ ГОСИС
	Если ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "РеализацияТоваровУслуг")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "КорректировкаРеализации")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ВозвратТоваровПоставщику")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ВозвратТоваровОтКлиента")
	 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ПриобретениеТоваровУслуг") Тогда
		
		ПараметрыИнтеграцииФормыПроверки = Форма.ПараметрыИнтеграцииГосИС.Получить(ПараметрыОткрытияФормыПроверки.ВидМаркируемойПродукции);
		
		СерииИспользуются = ПараметрыИнтеграцииФормыПроверки.СерииИспользуются;
			
		Если СерииИспользуются И (НЕ ЗначениеЗаполнено(ПараметрыФормыПроверки.Склад)
		 ИЛИ ТипЗнч(ПараметрыФормыПроверки.Склад) <> Тип("СправочникСсылка.Склады")) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				НСтр("ru = 'Для проверки и подбора маркируемой продукции укажите склад'"),,
				ПараметрыОткрытияФормыПроверки.ИмяРеквизитаСклад,
				ПараметрыОткрытияФормыПроверки.ИмяРеквизитаФормыОбъект,
				Отказ);
		КонецЕсли;
	
		Если ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "РеализацияТоваровУслуг")
		 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "КорректировкаРеализации")
		 ИЛИ ИнтеграцияИСУТКлиентСервер.ЭтоДокументПоНаименованию(Форма, "ПриобретениеТоваровУслуг") Тогда
			Если СерииИспользуются И Форма.СкладГруппа Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					НСтр("ru = 'Для проверки и подбора маркируемой продукции укажите склад, а не группу'"),,
					ПараметрыОткрытияФормыПроверки.ИмяРеквизитаСклад,
					ПараметрыОткрытияФормыПроверки.ИмяРеквизитаФормыОбъект,
					Отказ);
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	//-- НЕ ГОСИС
	
КонецПроцедуры

#КонецОбласти

#Область ОткрытиеФормПрикладныхОбъектов

Процедура ОткрытьФормуАктаОРасхождениях(ДокументСсылка, ВладелецФормы) Экспорт
	
	//++ НЕ ГОСИС
	ПроверкаИПодборПродукцииИСМПУТКлиент.ОткрытьФормуАктаОРасхождениях(ДокументСсылка, ВладелецФормы);
	//-- НЕ ГОСИС
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти