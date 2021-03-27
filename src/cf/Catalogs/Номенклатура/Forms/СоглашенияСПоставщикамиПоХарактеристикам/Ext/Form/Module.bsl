﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("Номенклатура", Номенклатура);
	
	ЗаполнитьСписок();
	
	МожноДобавлятьСоглашения = ПравоДоступа("Добавление", Метаданные.Справочники.СоглашенияСПоставщиками);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_СоглашенияСПоставщиками" Тогда
		ЗаполнитьСписок()
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Поле = Элементы.СписокДействиеПредставление Тогда
		
		ТекущиеДанные	= Элементы.Список.ТекущиеДанные;
		Гиперссылка		= ТекущиеДанные.Действие;
		
		ЗначенияЗаполненияСоглашений = Новый Структура;
		ЗначенияЗаполненияСоглашений.Вставить("Партнер",				ТекущиеДанные.Принципал);
		ЗначенияЗаполненияСоглашений.Вставить("Контрагент",				ТекущиеДанные.Контрагент);
		ЗначенияЗаполненияСоглашений.Вставить("Статус",					ПредопределенноеЗначение("Перечисление.СтатусыСоглашенийСПоставщиками.Действует"));
		ЗначенияЗаполненияСоглашений.Вставить("ХозяйственнаяОперация",	ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ОказаниеАгентскихУслуг"));
		
		ПараметрыПереходаПоГиперссылке = Новый Структура("ИмяФормы, ПараметрыФормы");
		
		Если Гиперссылка = "СоглашенияВыбрать"
			Или Гиперссылка = "СписокСоглашенийПоХарактеристикам" Тогда
			
			ПартнерыДляОтбора = Новый Массив;
			ПартнерыДляОтбора.Добавить(ПредопределенноеЗначение("Справочник.Партнеры.ПустаяСсылка"));
			ПартнерыДляОтбора.Добавить(ТекущиеДанные.Принципал);
			
			КонтрагентыДляОтбора = Новый Массив;
			КонтрагентыДляОтбора.Добавить(ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка"));
			КонтрагентыДляОтбора.Добавить(ТекущиеДанные.Контрагент);
			
			ОтборСоглашений = Новый Структура;
			ОтборСоглашений.Вставить("Партнер",					Новый ФиксированныйМассив(ПартнерыДляОтбора));
			ОтборСоглашений.Вставить("Контрагент",				Новый ФиксированныйМассив(КонтрагентыДляОтбора));
			ОтборСоглашений.Вставить("ХозяйственнаяОперация",	ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ОказаниеАгентскихУслуг"));
			
			ОтборПользовательский = Новый Структура;
			ОтборПользовательский.Вставить("Состояние", ПредопределенноеЗначение("Перечисление.СостоянияСоглашенийСПоставщиками.Действует"));
			
			ПараметрыСозданияСоглашения = Новый Структура;
			Если Гиперссылка = "СоглашенияВыбрать" Тогда
				ЗначенияЗаполненияСоглашений.Вставить("АгентскаяУслугаНоменклатура",	Номенклатура);
				ЗначенияЗаполненияСоглашений.Вставить("АгентскаяУслугаХарактеристика",	ТекущиеДанные.Характеристика);
				
				ПараметрыСозданияСоглашения.Вставить("ДанныеУслуги", ЗначенияЗаполненияСоглашений);
			КонецЕсли;
			
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("Отбор",							ОтборСоглашений);
			ПараметрыФормы.Вставить("СтруктураБыстрогоОтбора",			ОтборПользовательский);
			ПараметрыФормы.Вставить("ВключитьОтборПоАгентскойУслуге",	Гиперссылка = "СписокСоглашенийПоХарактеристикам");
			ПараметрыФормы.Вставить("АгентскаяУслугаНоменклатура",		Номенклатура);
			ПараметрыФормы.Вставить("АгентскаяУслугаХарактеристика",	ТекущиеДанные.Характеристика);
			ПараметрыФормы.Вставить("ДополнительныеПараметры",			ПараметрыСозданияСоглашения);
			
			ПараметрыПереходаПоГиперссылке.ИмяФормы			= "Справочник.СоглашенияСПоставщиками.ФормаСписка";
			ПараметрыПереходаПоГиперссылке.ПараметрыФормы	= ПараметрыФормы;
			
		ИначеЕсли Гиперссылка = "СоглашенияСоздать" Тогда
			
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("ЗначенияЗаполнения",				ЗначенияЗаполненияСоглашений);
			ПараметрыФормы.Вставить("АгентскаяУслугаНоменклатура",		Номенклатура);
			ПараметрыФормы.Вставить("АгентскаяУслугаХарактеристика",	ТекущиеДанные.Характеристика);
			
			ПараметрыПереходаПоГиперссылке.ИмяФормы			= "Справочник.СоглашенияСПоставщиками.ФормаОбъекта";
			ПараметрыПереходаПоГиперссылке.ПараметрыФормы	= ПараметрыФормы;
			
		Иначе
			
			ТекстИсключения = НСтр("ru = 'Неопределено действие перехода по гиперссылке.'");
			
			ВызватьИсключение ТекстИсключения;
			
		КонецЕсли;
		
		ОткрытьФорму(ПараметрыПереходаПоГиперссылке.ИмяФормы,
					ПараметрыПереходаПоГиперссылке.ПараметрыФормы,
					,
					УникальныйИдентификатор,
					,
					,
					,
					РежимОткрытияОкна);
		
	ИначеЕсли Поле = Элементы.СписокПринципал Тогда
		ПоказатьЗначение(, Элементы.Список.ТекущиеДанные.Принципал);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СписокДействиеПредставление.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.ЕстьСоглашениеПоХарактеристике");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("МожноДобавлятьСоглашения");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста",		ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст",				НСтр("ru = 'Не выбрана в соглашениях'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("Доступность",		Ложь);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписок()
	
	Список.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА СпрНоменклатура.ИспользованиеХарактеристик = ЗНАЧЕНИЕ(Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ИндивидуальныеДляНоменклатуры)
	|			ТОГДА СпрНоменклатура.Ссылка
	|		КОГДА СпрНоменклатура.ИспользованиеХарактеристик = ЗНАЧЕНИЕ(Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеДляВидаНоменклатуры)
	|			ТОГДА СпрНоменклатура.ВидНоменклатуры
	|		КОГДА СпрНоменклатура.ИспользованиеХарактеристик = ЗНАЧЕНИЕ(Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеСДругимВидомНоменклатуры)
	|			ТОГДА СпрНоменклатура.ВладелецХарактеристик
	|	КОНЕЦ КАК Ссылка
	|ПОМЕСТИТЬ ВладелецХарактеристик
	|ИЗ
	|	Справочник.Номенклатура КАК СпрНоменклатура
	|ГДЕ
	|	СпрНоменклатура.Ссылка = &Номенклатура
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ХарактеристикиНоменклатуры.Ссылка						КАК Характеристика,
	|	ХарактеристикиНоменклатуры.Принципал					КАК Принципал,
	|	ХарактеристикиНоменклатуры.Контрагент					КАК Контрагент,
	|	МАКСИМУМ(НЕ СоглашенияСПоставщиками.Ссылка ЕСТЬ NULL)	КАК ЕстьСоглашения,
	|	СУММА(ВЫБОР
	|			КОГДА НЕ ТЧАгентскиеУслуги.Ссылка ЕСТЬ NULL
	|					ИЛИ НЕ СоглашенияСПоставщиками.ИспользоватьУказанныеАгентскиеУслуги
	|				ТОГДА 1
	|			ИНАЧЕ 0
	|		КОНЕЦ)												КАК КоличествоСоглашений,
	|	МАКСИМУМ(НЕ ТЧАгентскиеУслуги.Ссылка ЕСТЬ NULL
	|		ИЛИ НЕ ЕСТЬNULL(СоглашенияСПоставщиками.ИспользоватьУказанныеАгентскиеУслуги, ИСТИНА)) КАК ЕстьСоглашениеПоХарактеристике
	|ИЗ
	|	Справочник.ХарактеристикиНоменклатуры КАК ХарактеристикиНоменклатуры
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.СоглашенияСПоставщиками КАК СоглашенияСПоставщиками
	|		ПО ХарактеристикиНоменклатуры.Принципал = СоглашенияСПоставщиками.Партнер
	|			И (ХарактеристикиНоменклатуры.Контрагент = СоглашенияСПоставщиками.Контрагент
	|				ИЛИ СоглашенияСПоставщиками.Контрагент = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка))
	|			И СоглашенияСПоставщиками.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыСоглашенийСПоставщиками.Действует)
	|			И СоглашенияСПоставщиками.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ОказаниеАгентскихУслуг)
	|			И (СоглашенияСПоставщиками.ДатаНачалаДействия = ДАТАВРЕМЯ(1, 1, 1)
	|				ИЛИ СоглашенияСПоставщиками.ДатаНачалаДействия  <= &ТекущаяДата)
	|			И (СоглашенияСПоставщиками.ДатаОкончанияДействия = ДАТАВРЕМЯ(1, 1, 1)
	|				ИЛИ СоглашенияСПоставщиками.ДатаОкончанияДействия >= &ТекущаяДата)
	|		
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.СоглашенияСПоставщиками.АгентскиеУслуги КАК ТЧАгентскиеУслуги
	|		ПО СоглашенияСПоставщиками.Ссылка = ТЧАгентскиеУслуги.Ссылка
	|			И ТЧАгентскиеУслуги.Номенклатура = &Номенклатура
	|			И ТЧАгентскиеУслуги.Характеристика = ХарактеристикиНоменклатуры.Ссылка
	|ГДЕ
	|	ХарактеристикиНоменклатуры.Владелец В
	|			(ВЫБРАТЬ
	|				ВладелецХарактеристик.Ссылка
	|			ИЗ
	|				ВладелецХарактеристик)
	|	И НЕ ХарактеристикиНоменклатуры.ПометкаУдаления
	|
	|СГРУППИРОВАТЬ ПО
	|	ХарактеристикиНоменклатуры.Ссылка,
	|	ХарактеристикиНоменклатуры.Принципал,
	|	ХарактеристикиНоменклатуры.Контрагент
	|
	|УПОРЯДОЧИТЬ ПО
	|	ХарактеристикиНоменклатуры.Представление";
	
	Запрос.УстановитьПараметр("Номенклатура",	Номенклатура);
	Запрос.УстановитьПараметр("ТекущаяДата",	ТекущаяДатаСеанса());
	
	Соглашения = Запрос.Выполнить().Выгрузить();
	
	Для Каждого СтрТабл Из Соглашения Цикл
		
		НоваяСтрока = Список.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрТабл);
		
		Если Не СтрТабл.ЕстьСоглашения Тогда
			ГиперссылкаСоглашения = "СоглашенияСоздать";
			ЗаголовокГиперссылки = НСтр("ru = 'Создать соглашение'");
		ИначеЕсли Не СтрТабл.ЕстьСоглашениеПоХарактеристике Тогда
			ГиперссылкаСоглашения = "СоглашенияВыбрать";
			ЗаголовокГиперссылки = НСтр("ru = 'Выбрать в существующем соглашении'");
		Иначе
			ГиперссылкаСоглашения = "СписокСоглашенийПоХарактеристикам";
			
			СтрокаСоглашений = СтрокаСЧислом(";%1 соглашении;;%1 соглашениях;%1 соглашениях;%1 соглашениях",
											СтрТабл.КоличествоСоглашений,
											ВидЧисловогоЗначения.Количественное,
											"L=ru");
			
			ЗаголовокГиперссылки = НСтр("ru = 'Выбрано в %КоличествоСоглашений%'");
			ЗаголовокГиперссылки = СтрЗаменить(ЗаголовокГиперссылки, "%КоличествоСоглашений%", СтрокаСоглашений);
		КонецЕсли;
		
		НоваяСтрока.Действие				= ГиперссылкаСоглашения;
		НоваяСтрока.ДействиеПредставление	= ЗаголовокГиперссылки;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
