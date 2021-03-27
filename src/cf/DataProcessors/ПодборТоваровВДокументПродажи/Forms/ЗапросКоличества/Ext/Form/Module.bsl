﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ВидЦены                   = Параметры.ВидЦены;
	Цена                      = Параметры.Цена;
	Дата                      = Параметры.Дата;
	ДатаОтгрузки              = Параметры.ДатаОтгрузки;
	Склад                     = Параметры.Склад;
	Номенклатура              = Параметры.Номенклатура;
	Характеристика            = Параметры.Характеристика;
	Упаковка 				  = Параметры.Упаковка;
	Валюта                    = Параметры.Валюта;
	ЦенаВключаетНДС           = Параметры.ЦенаВключаетНДС;
	
	РедактироватьВидЦены      = Параметры.РедактироватьВидЦены;
	
	БезОтбораПоВключениюНДСВЦену = Неопределено;
	Параметры.Свойство("БезОтбораПоВключениюНДСВЦену", БезОтбораПоВключениюНДСВЦену);
	
	СтруктураНоменклатуры = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Номенклатура, "ЕдиницаИзмерения, ИспользоватьУпаковки");
		
	Если Упаковка.Пустая()
		И СтруктураНоменклатуры.ИспользоватьУпаковки Тогда 
		Упаковка = ПодборТоваровВызовСервера.ПолучитьУпаковкуХранения(Номенклатура);
	КонецЕсли;
	
	Если СтруктураНоменклатуры.ИспользоватьУпаковки Тогда
		Элементы.Упаковка.ПодсказкаВвода = СтруктураНоменклатуры.ЕдиницаИзмерения;
	КонецЕсли;
		
	СтараяУпаковка            = Упаковка;
	
	НаименованиеТовара = "" + Параметры.Номенклатура + ?(ЗначениеЗаполнено(Параметры.Характеристика), " (" + Параметры.Характеристика + ")","");
	
	
	Если ЗначениеЗаполнено(ВидЦены) Тогда
		ВидЦеныПредставление  = ВидЦены;
	Иначе
		ВидЦеныПредставление  = НСтр("ru='<произвольная>'");
	КонецЕсли;
	
	Если Параметры.СкрытьЦену Тогда
		Элементы.Цена.Видимость    = Ложь;
		Элементы.ДекорацияЗаголовокЦена.Видимость  = Ложь;
		Элементы.ВидЦеныПредставление.Видимость    = Ложь;
		Элементы.Валюта.Видимость  = Ложь;
		ЭтаФорма.АвтоЗаголовок     = Ложь;
		ЭтаФорма.Заголовок         = НСтр("ru = 'Ввод количества'");
	КонецЕсли;
	
	Если Не Параметры.ИспользоватьДатыОтгрузки Тогда
		Элементы.ДатаОтгрузки.Видимость = Ложь;
	КонецЕсли;
	
	Если Параметры.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Услуга Тогда
		ДатаОтгрузки = '00010101';
		Склад = Справочники.Склады.ПустаяСсылка();
		Элементы.ДатаОтгрузки.Видимость = Ложь;
	КонецЕсли;
	
	Если Не Параметры.ИспользоватьСкладыВТабличнойЧасти
		Или Параметры.Склады.Найти(Склад) = Неопределено Тогда
		Склад = Неопределено;
	КонецЕсли;
	
	Элементы.Склад.Видимость = Не Параметры.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Услуга
		И Не Параметры.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Работа
		И Параметры.Склады.Количество() > 1
		И Параметры.ИспользоватьСкладыВТабличнойЧасти;
	Элементы.ДекорацияЗаголовокСклад.Видимость = Элементы.Склад.Видимость;
		
	ОбщегоНазначенияУТКлиентСервер.ДобавитьПараметрВыбора(Элементы.Склад, "Ссылка", Параметры.Склады);
	
	СтруктураИзмеренийУказанияВДокументах = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Номенклатура, "ПлощадьМожноУказыватьВДокументах, ОбъемМожноУказыватьВДокументах, ВесМожноУказыватьВДокументах, ДлинаМожноУказыватьВДокументах");
	Если СтруктураИзмеренийУказанияВДокументах.ПлощадьМожноУказыватьВДокументах
		Или СтруктураИзмеренийУказанияВДокументах.ВесМожноУказыватьВДокументах
		Или СтруктураИзмеренийУказанияВДокументах.ОбъемМожноУказыватьВДокументах
		Или СтруктураИзмеренийУказанияВДокументах.ДлинаМожноУказыватьВДокументах
		Или ЗначениеЗаполнено(Номенклатура.НаборУпаковок) Тогда
		
		Элементы.Упаковка.Видимость = Истина;
		Элементы.ЕдиницаИзмерения.Видимость = Ложь;
		Элементы.Упаковка.ПодсказкаВвода = СтруктураНоменклатуры.ЕдиницаИзмерения;
	Иначе
		Элементы.Упаковка.Видимость = Ложь;
		Элементы.ЕдиницаИзмерения.Видимость = Истина;
	КонецЕсли;
	
	КоличествоУпаковок = 1;
	
	Элементы.Цена.Доступность = Параметры.РедактироватьВидЦены;
	
	ЗаполнитьСписокЦен();
	
	// Настроить видимость и установить значения реквизитов для редактирования ручных скидок, наценок.
	СуммаДокумента = КоличествоУпаковок * Цена;
	
	Если Не Параметры.ИспользоватьРучныеСкидкиВПродажах Или Параметры.СкрыватьРучныеСкидки Тогда
		
		Элементы.ГруппаПараметрыСкидкиНаценки.Видимость = Ложь;
		
	Иначе
		
		// Установить свойства элементов относящихся к скидкам (наценкам).
		ИспользоватьОграниченияРучныхСкидок = (ПолучитьФункциональнуюОпцию("ИспользоватьОграниченияРучныхСкидокВПродажахПоПользователям")
		                                      Или ПолучитьФункциональнуюОпцию("ИспользоватьОграниченияРучныхСкидокВПродажахПоСоглашениям"));
		
		Если ИспользоватьОграниченияРучныхСкидок Тогда
			
			СтруктураТаблиц = ПолучитьИзВременногоХранилища(Параметры.АдресВоВременномХранилище);
			
			МаксимальныйПроцентСкидки  = СтруктураТаблиц.Ограничения[0].МаксимальныйПроцентРучнойСкидки;
			МаксимальныйПроцентНаценки = СтруктураТаблиц.Ограничения[0].МаксимальныйПроцентРучнойНаценки;
			
			Если МаксимальныйПроцентСкидки > 0 Тогда
				Элементы.ПроцентРучнойСкидкиНаценки.КнопкаСпискаВыбора = Истина;
				Элементы.ПроцентРучнойСкидкиНаценки.СписокВыбора.Добавить(МаксимальныйПроцентСкидки, Формат(МаксимальныйПроцентСкидки, "ЧДЦ=2"));
			КонецЕсли;
			
		КонецЕсли;
		
		Элементы.НадписьМаксимальнаяРучнаяСкидка.Видимость  = ИспользоватьОграниченияРучныхСкидок;
		Элементы.НадписьМаксимальнаяРучнаяСкидка.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%2 Макс. скидка: %1%2'"),
			МаксимальныйПроцентСкидки,
			"%");
		
		Элементы.НадписьМаксимальнаяРучнаяНаценка.Видимость = ИспользоватьОграниченияРучныхСкидок;
		Элементы.НадписьМаксимальнаяРучнаяНаценка.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%2 Макс. наценка: %1%2'"),
			МаксимальныйПроцентНаценки,
			"%");
		
		Элементы.НадписьМаксимальнаяСкидкаНеОграничена.Видимость   = Не ИспользоватьОграниченияРучныхСкидок;
		Элементы.НадписьМаксимальнаяНаценкаНеОграничена.Видимость  = Не ИспользоватьОграниченияРучныхСкидок;
		
		// Установить варианты выбора ручной скидки (наценки).
		Элементы.ВариантПредоставления.СписокВыбора.Добавить("Скидка", НСтр("ru = 'Скидка'"));
		Элементы.ВариантПредоставления.СписокВыбора.Добавить("Наценка", НСтр("ru = 'Наценка'"));
		
		// Установить значение варианта предоставления при открытии.
		ВариантПредоставления = "Скидка"; // Скидка
		Элементы.ВариантыПредоставления.ТекущаяСтраница = Элементы.ВариантыПредоставления.ПодчиненныеЭлементы.Скидка;
		
	КонецЕсли;
	
 	УстановитьВидимостьКоличествоЕдиницХранения();

	ОбновитьКоличетсво();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура УпаковкаПриИзменении(Элемент)
	
	УпаковкаПриИзмененииНаСервере(СтараяУпаковка);
	СтараяУпаковка = Упаковка;
	
КонецПроцедуры

&НаКлиенте
Процедура УпаковкаОчистка(Элемент, СтандартнаяОбработка)
	
	УпаковкаПриИзмененииНаСервере(СтараяУпаковка);
	СтараяУпаковка = Упаковка;
	
КонецПроцедуры

&НаКлиенте
Процедура ЦенаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Число") Тогда
		
		ВидЦеныПредставление = НСтр("ru='<произвольная>'");
		Возврат;
		
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ВидЦены = ВыбранноеЗначение;
	ВидЦеныПредставление = ВыбранноеЗначение;
		
	Для Каждого Строка Из ВидЦеныЦена Цикл
		Если Строка.ВидЦены = ВыбранноеЗначение Тогда
			Цена = Строка.Цена;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЦенаОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ВидЦены = Неопределено;
	ВидЦеныПредставление = НСтр("ru='<произвольная>'");
	Цена = Число(Текст);
КонецПроцедуры

&НаКлиенте
Процедура ВариантПредоставленияПриИзменении(Элемент)
	
	Элементы.ПроцентРучнойСкидкиНаценки.КнопкаСпискаВыбора = Ложь;
	Элементы.ПроцентРучнойСкидкиНаценки.СписокВыбора.Очистить();
	
	Если ВариантПредоставления = "Скидка" Тогда
		Элементы.ВариантыПредоставления.ТекущаяСтраница = Элементы.ВариантыПредоставления.ПодчиненныеЭлементы.Скидка;
		Если МаксимальныйПроцентСкидки > 0 Тогда
			Элементы.ПроцентРучнойСкидкиНаценки.КнопкаСпискаВыбора = Истина;
			Элементы.ПроцентРучнойСкидкиНаценки.СписокВыбора.Добавить(МаксимальныйПроцентСкидки, Формат(МаксимальныйПроцентСкидки, "ЧДЦ=2"));
		КонецЕсли;
	Иначе
		Элементы.ВариантыПредоставления.ТекущаяСтраница = Элементы.ВариантыПредоставления.ПодчиненныеЭлементы.Наценка;
		Если МаксимальныйПроцентНаценки > 0 Тогда
			Элементы.ПроцентРучнойСкидкиНаценки.КнопкаСпискаВыбора = Истина;
			Элементы.ПроцентРучнойСкидкиНаценки.СписокВыбора.Добавить(МаксимальныйПроцентНаценки, Формат(МаксимальныйПроцентНаценки, "ЧДЦ=2"));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоУпаковокПриИзменении(Элемент)
	
	ОбновитьКоличетсво();
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоПриИзменении(Элемент)
	
	ОбновитьКоличетсвоУпаковок();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Отказ = Ложь;
	ОчиститьСообщения();
	
	Если КоличествоУпаковок = 0 Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не заполнено количество'"),,"КоличествоУпаковок",,Отказ);
	КонецЕсли;
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПодобранныеТовары = Новый Массив;
	
	ПараметрыТовара = Новый Структура;
	ПараметрыТовара.Вставить("Номенклатура", Номенклатура);        
	ПараметрыТовара.Вставить("Характеристика", Характеристика);
	ПараметрыТовара.Вставить("Упаковка", Упаковка);
	ПараметрыТовара.Вставить("Цена", Цена);
	ПараметрыТовара.Вставить("ВидЦены", ВидЦены);
	ПараметрыТовара.Вставить("КоличествоУпаковок", КоличествоУпаковок);
	ПараметрыТовара.Вставить("Склад", Склад);
	ПараметрыТовара.Вставить("ДатаОтгрузки", ДатаОтгрузки);
	
	Если ВариантПредоставления = "Скидка" Тогда
		ПараметрыТовара.Вставить("ПроцентРучнойСкидки", ПроцентРучнойСкидкиНаценки);
	Иначе
		ПараметрыТовара.Вставить("ПроцентРучнойСкидки", -ПроцентРучнойСкидкиНаценки);
	КонецЕсли;
	
	ПодобранныеТовары.Добавить(ПараметрыТовара);
	
	Результат = Новый Структура("ПодобранныеТовары, МаксимальнаяДатаОтгрузки", ПодобранныеТовары, ДатаОтгрузки);

	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура Округлить(Команда)
	
	Количество = Окр(Количество, 0, РежимОкругления.Окр15как20);
	ОбновитьКоличетсвоУпаковок();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПроцентРучнойСкидкиНаценки.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПроцентРучнойСкидкиНаценки");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Больше;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("МаксимальныйПроцентСкидки");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьОграниченияРучныхСкидок");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВариантПредоставления");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = "Скидка";

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.FireBrick);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПроцентРучнойСкидкиНаценки.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПроцентРучнойСкидкиНаценки");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Больше;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("МаксимальныйПроцентНаценки");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьОграниченияРучныхСкидок");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВариантПредоставления");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = "Наценка";
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.FireBrick);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.НоменклатураЕдиницаИзмерения.Имя);
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Количество.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("УказаноДробноеКоличествоВБазовыхЕдиницах");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ПоясняющийОшибкуТекст);

КонецПроцедуры

&НаСервере
Процедура УпаковкаПриИзмененииНаСервере(СтараяУпаковка)
	
	УстановитьВидимостьКоличествоЕдиницХранения();
	ОбновитьКоличетсво();
	
	ЗаполнитьСписокЦен();
	Если Не ЗначениеЗаполнено(ВидЦены) 
		Или Не РедактироватьВидЦены Тогда
		Цена = Цена * 
			Справочники.УпаковкиЕдиницыИзмерения.КоэффициентУпаковки(Упаковка, Номенклатура) /
			Справочники.УпаковкиЕдиницыИзмерения.КоэффициентУпаковки(СтараяУпаковка, Номенклатура);
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокЦен()
	Если РедактироватьВидЦены Тогда
		// Заполнить список выбора видов цен.
		Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ВидыЦен.Ссылка КАК ВидЦены
		|ПОМЕСТИТЬ ВидыЦен
		|ИЗ
		|	Справочник.ВидыЦен КАК ВидыЦен
		|ГДЕ
		|	НЕ ВидыЦен.ПометкаУдаления
		|	И ВидыЦен.ИспользоватьПриПродаже
		|	И ВидыЦен.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыДействияВидовЦен.Действует)
		|	И (&БезОтбораПоВключениюНДСВЦену
		|			ИЛИ ВидыЦен.ЦенаВключаетНДС = &ЦенаВключаетНДС)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КурсыСрезПоследних.Валюта КАК Валюта,
		|	КурсыСрезПоследних.Курс,
		|	КурсыСрезПоследних.Кратность
		|ПОМЕСТИТЬ КурсыСрезПоследних
		|ИЗ
		|	РегистрСведений.КурсыВалют.СрезПоследних(&Дата, ) КАК КурсыСрезПоследних
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Валюта
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КурсыСрезПоследнихВалютаЦены.Валюта КАК Валюта,
		|	КурсыСрезПоследнихВалютаЦены.Курс,
		|	КурсыСрезПоследнихВалютаЦены.Кратность
		|ПОМЕСТИТЬ КурсыСрезПоследнихВалютаЦены
		|ИЗ
		|	РегистрСведений.КурсыВалют.СрезПоследних(&Дата, Валюта = &Валюта) КАК КурсыСрезПоследнихВалютаЦены
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ЦеныНоменклатурыСрезПоследних.ВидЦены КАК ВидЦены,
		|	ЦеныНоменклатурыСрезПоследних.Валюта КАК Валюта,
		|	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена,
		|	ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки1, 1) / ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки2, 1) КАК Коэффициент
		|ПОМЕСТИТЬ ЦеныНоменклатурыСрезПоследних
		|ИЗ
		|	РегистрСведений.ЦеныНоменклатуры.СрезПоследних(
		|			КОНЕЦПЕРИОДА(&Дата, ДЕНЬ),
		|			Номенклатура = &Номенклатура
		|				И Характеристика = &Характеристика
		|				И ВидЦены В
		|					(ВЫБРАТЬ
		|						ВидыЦен.ВидЦены
		|					ИЗ
		|						ВидыЦен КАК ВидыЦен)) КАК ЦеныНоменклатурыСрезПоследних
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ЦеныНоменклатурыСрезПоследних.ВидЦены КАК ВидЦены,
		|	ВЫРАЗИТЬ(ЦеныНоменклатурыСрезПоследних.Цена * КурсыСрезПоследних.Курс / КурсыСрезПоследних.Кратность / КурсыСрезПоследнихВалютаЦены.Курс * КурсыСрезПоследнихВалютаЦены.Кратность * ЦеныНоменклатурыСрезПоследних.Коэффициент КАК ЧИСЛО(31,2)) КАК Цена
		|ИЗ
		|	ЦеныНоменклатурыСрезПоследних КАК ЦеныНоменклатурыСрезПоследних
		|		ЛЕВОЕ СОЕДИНЕНИЕ КурсыСрезПоследних КАК КурсыСрезПоследних
		|		ПО (КурсыСрезПоследних.Валюта = ЦеныНоменклатурыСрезПоследних.Валюта)
		|		ЛЕВОЕ СОЕДИНЕНИЕ КурсыСрезПоследнихВалютаЦены КАК КурсыСрезПоследнихВалютаЦены
		|		ПО (ИСТИНА)");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТекстЗапросаКоэффициентУпаковки1",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
			"ВЫРАЗИТЬ(&Упаковка КАК Справочник.УпаковкиЕдиницыИзмерения)", "ЦеныНоменклатурыСрезПоследних.Номенклатура"));
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТекстЗапросаКоэффициентУпаковки2",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
			"ЦеныНоменклатурыСрезПоследних.Упаковка",
			"ЦеныНоменклатурыСрезПоследних.Номенклатура"));
		Запрос.УстановитьПараметр("ЦенаВключаетНДС", ЦенаВключаетНДС);
		Запрос.УстановитьПараметр("БезОтбораПоВключениюНДСВЦену", 
			?(БезОтбораПоВключениюНДСВЦену = Неопределено, Ложь, БезОтбораПоВключениюНДСВЦену));
		
		Запрос.УстановитьПараметр("Дата",           Дата);
		Запрос.УстановитьПараметр("Номенклатура",   Номенклатура);
		Запрос.УстановитьПараметр("Характеристика", Характеристика);
		Запрос.УстановитьПараметр("Упаковка",       Упаковка);
		Запрос.УстановитьПараметр("Валюта",         Валюта);
		
		СписокВыбораЦен = Элементы.Цена.СписокВыбора;
		СписокВыбораЦен.Очистить();
		ВидЦеныЦена.Загрузить(Запрос.Выполнить().Выгрузить());
		
		ВидЦеныСовпал = Ложь;
		Для Каждого Строка Из ВидЦеныЦена Цикл
			Представление = Формат(Строка.Цена, "ЧДЦ=2; ЧН=") + " (" + Строка.ВидЦены + ")";
			СписокВыбораЦен.Добавить(Строка.ВидЦены,Представление);
			Если Строка.ВидЦены = ВидЦены Тогда
				Цена = Строка.Цена;
				ВидЦеныСовпал = Истина;
			КонецЕсли;
		КонецЦикла;
		
		Если Не ВидЦеныСовпал Тогда
			ВидЦены = Справочники.ВидыЦен.ПустаяСсылка();
			ВидЦеныПредставление  = НСтр("ru='<произвольная>'");
		КонецЕсли;
			
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбновитьКоличетсво()
	
	Количество = КоличествоУпаковок*Справочники.УпаковкиЕдиницыИзмерения.КоэффициентУпаковки(Упаковка, Номенклатура);
	УстановитьВидимостьОкруглить();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьКоличетсвоУпаковок()
	
	КоличествоУпаковок = Количество/Справочники.УпаковкиЕдиницыИзмерения.КоэффициентУпаковки(Упаковка, Номенклатура);
	УстановитьВидимостьОкруглить();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьКоличествоЕдиницХранения()
	
	ЕдиницаИзмеренияТипИзмеряемойВеличины = "";
	УпаковкаТипИзмеряемойВеличины = "";
	
	ЕдиницаМерная = Справочники.УпаковкиЕдиницыИзмерения.ЭтоМернаяЕдиница(ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Номенклатура, "ЕдиницаИзмерения"),
																			ЕдиницаИзмеренияТипИзмеряемойВеличины);
																			
	УпаковкаМерная = Справочники.УпаковкиЕдиницыИзмерения.ЭтоМернаяЕдиница(Упаковка,
																			УпаковкаТипИзмеряемойВеличины);
	Если ЕдиницаМерная
		И УпаковкаТипИзмеряемойВеличины <> ЕдиницаИзмеренияТипИзмеряемойВеличины
		И УпаковкаТипИзмеряемойВеличины <> "Упаковка"
		И УпаковкаТипИзмеряемойВеличины <> ""
		Или ЕдиницаИзмеренияТипИзмеряемойВеличины = "КоличествоШтук" 
		И УпаковкаМерная Тогда 
		
		Элементы.Количество.Видимость = Истина;
		Элементы.НоменклатураЕдиницаИзмерения.Видимость = Истина;
		Элементы.ДекорацияКоличествоОкруглить.Видимость = Ложь;
		
	Иначе
		
		Элементы.Количество.Видимость = Ложь;
		Элементы.НоменклатураЕдиницаИзмерения.Видимость = Ложь;
		Элементы.ДекорацияКоличествоОкруглить.Видимость = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьОкруглить()
	
	Если Количество <> Цел(Количество) И Элементы.Количество.Видимость И Не ЕдиницаМерная Тогда
		УказаноДробноеКоличествоВБазовыхЕдиницах = Истина;
		Элементы.Округлить.Видимость = Истина;
	Иначе
		УказаноДробноеКоличествоВБазовыхЕдиницах = Ложь;
		Элементы.Округлить.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
