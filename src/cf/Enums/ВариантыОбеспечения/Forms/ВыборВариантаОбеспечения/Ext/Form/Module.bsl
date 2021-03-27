﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Элементы.Обеспечивать.Доступность = Не Параметры.ТолькоОбособленно;

	ЗаполнитьСписокДоступныхВариантовОбеспечения();

	СтрокаОбособлена = Параметры.ТекущийВариант.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Обособленно")
		Или Параметры.ТекущийВариант.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.ОтгрузитьОбособленно");
	
	КоличествоОтгружено = Параметры.КоличествоОформлено;
	КоличествоТребуется = Параметры.ТекущийВариант.Количество - КоличествоОтгружено;

	ФорматЧислоНоль = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = '%1 (Все)'"),
		Формат(КоличествоТребуется, "ЧДЦ=3; ЧН=0.000"));
	Элементы.Количество.Формат = "ЧН=" + "'" + ФорматЧислоНоль + "'";
	Элементы.КоличествоОбособленно.Формат = "ЧН=" + "'" + ФорматЧислоНоль + "'";
	
	Если Не ЗначениеЗаполнено(Упаковка) Тогда
		ЕдиницаИзмерения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Отбор.Номенклатура, "ЕдиницаИзмерения");
		ПредставлениеЕдиницыИзмерения = Строка(ЕдиницаИзмерения);
	Иначе
		ПредставлениеЕдиницыИзмерения = Строка(Упаковка);
	КонецЕсли;

	// Заполнение таблицы отборов по параметрам, переданным в форму.
	Отбор = ТаблицаАналитикиПотребности(Параметры);

	// Корректировочная таблица календаря обеспечения.
	Корректировка = ПолучитьИзВременногоХранилища(Параметры.АдресКорректировки);
	УдалитьИзВременногоХранилища(Параметры.АдресКорректировки);

	ДоступныеОстатки = ОбеспечениеСервер.ДоступныеОстатки(Отбор, Корректировка);
	ПлановыеПоставки = ОбеспечениеСервер.ПлановыеПоставки(Отбор);

	ТипНоменклатуры = Параметры.Отбор.ТипНоменклатуры;
	КоличествоОтгрузитьОбособленно = 0;
	ОбеспечениеСверхДопустимо = ПолучитьФункциональнуюОпцию("РазрешитьОбособлениеТоваровСверхПотребности");
	Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Услуга И КоличествоТребуется > 0 Тогда

		ЗагрузитьДействияУслуг(СписокВариантов, Действия);

	ИначеЕсли КоличествоТребуется > 0 Тогда

		// Заполнение обособленных действий
		Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Работа Тогда

			КоличествоПодНазначение = ЗагрузитьДействияРабот(СписокВариантов,
				ДействияОбособленные, ДоступныеОстатки.Работы, КоличествоТребуется);

				ЗагрузитьПлановыеПоставки(СписокВариантов,
					ДействияОбособленные, ПлановыеПоставки, Перечисления.ВариантыОбеспечения.Обособленно);

		ИначеЕсли ТипНоменклатуры <> Перечисления.ТипыНоменклатуры.МногооборотнаяТара Тогда

			Если Параметры.ОтгружатьЕслиПоступилоПодНазначениеПолностью Тогда
				ЭлементОтгрузить = СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно);
				Если ЭлементОтгрузить <> Неопределено 
					И ДоступныеОстатки.ТоварыОбособленные.Итог("Количество") < КоличествоТребуется Тогда
					СписокВариантов.Удалить(ЭлементОтгрузить);
				КонецЕсли;
			КонецЕсли;
			
			КоличествоПодНазначение = ЗагрузитьДействияОбособленные(СписокВариантов,
				ДействияОбособленные, ДоступныеОстатки.ТоварыОбособленные, КоличествоОтгрузитьОбособленно);

			Если НЕ Параметры.ОтгружатьЕслиПоступилоПодНазначениеПолностью
				ИЛИ КоличествоОтгружено = 0 Тогда
				
				ЗагрузитьПлановыеПоставки(СписокВариантов,
					ДействияОбособленные, ПлановыеПоставки, Перечисления.ВариантыОбеспечения.Обособленно);
				
			КонецЕсли; 

		Иначе
			КоличествоПодНазначение = 0;
		КонецЕсли;

		// Заполнение необособленных действий
		Если КоличествоПодНазначение < КоличествоТребуется Или ОбеспечениеСверхДопустимо Тогда

			Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Работа Тогда

				Если СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.Отгрузить) <> Неопределено Тогда
					НоваяСтрока = Действия.Добавить();
					НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Отгрузить;
					НоваяСтрока.Количество = КоличествоТребуется - КоличествоПодНазначение;
				КонецЕсли;

			Иначе

				ЗагрузитьДействия(СписокВариантов, Действия, ДоступныеОстатки.Товары);

			КонецЕсли;

			ЗагрузитьПлановыеПоставки(СписокВариантов, Действия, ПлановыеПоставки, Перечисления.ВариантыОбеспечения.Требуется);

			Если КоличествоПодНазначение > 0 И Не ОбеспечениеСверхДопустимо Тогда
				Для Каждого Строка Из Действия Цикл
					Если Строка.Количество = 0 Или Строка.Количество > КоличествоТребуется - КоличествоПодНазначение Тогда
						Строка.КоличествоДоступно = Строка.Количество;
						Строка.Количество = КоличествоТребуется - КоличествоПодНазначение;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;

			Если СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.НеТребуется) <> Неопределено Тогда

				НоваяСтрока = Действия.Добавить();
				НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.НеТребуется;
				НоваяСтрока.Количество = КоличествоТребуется - ?(ОбеспечениеСверхДопустимо, 0, КоличествоПодНазначение);

				НоваяСтрока.Склад = Параметры.ТекущийВариант.Склад;

			КонецЕсли;

		КонецЕсли;

	КонецЕсли;

	Если СтрокаОбособлена Или (КоличествоПодНазначение > 0 И Не ОбеспечениеСверхДопустимо) Тогда

		ВариантПоУмолчанию = Перечисления.ВариантыОбеспечения.Обособленно;

	ИначеЕсли СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.Требуется) <> Неопределено Тогда

		ВариантПоУмолчанию = Перечисления.ВариантыОбеспечения.Требуется;

	Иначе

		ВариантПоУмолчанию = Перечисления.ВариантыОбеспечения.НеТребуется;

	КонецЕсли;

	ТекущийВариант = Параметры.ТекущийВариант;
	ИсходнаяСтрокаОбособлена = ТекущийВариант.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Обособленно
		Или ТекущийВариант.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно;

	Таблица = ?(ИсходнаяСтрокаОбособлена, ДействияОбособленные, Действия);
	ИдентификаторСтроки = НайтиИдентификаторСтроки(Таблица, ТекущийВариант.ВариантОбеспечения, ТекущийВариант.ДатаДоступности);
	Если ИдентификаторСтроки = Неопределено И Таблица.Количество() > 0 Тогда
		ИдентификаторСтроки = Таблица[0].ПолучитьИдентификатор();
	КонецЕсли;

	Для Каждого Строка Из Действия Цикл
		ОформитьСтроку(Строка, КоличествоТребуется, СписокВариантов);
	КонецЦикла;

	Для Каждого Строка Из ДействияОбособленные Цикл
		ОформитьСтроку(Строка, КоличествоТребуется, СписокВариантов);
	КонецЦикла;

	Действия.Сортировать("ПорядокСортировки, ДатаДоступности, Склад");
	ДействияОбособленные.Сортировать("ПорядокСортировки, ДатаДоступности, Склад");

	ТаблицаФормы = Элементы[?(ИсходнаяСтрокаОбособлена, "ДействияОбособленные", "Действия")];
	ТаблицаФормы.ТекущаяСтрока = ИдентификаторСтроки;

	Обеспечивать = ?(ИсходнаяСтрокаОбособлена Или КоличествоПодНазначение > 0,
		НСтр("ru = 'Обособленно'"), НСтр("ru = 'Не обособленно'"));

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьОбособленноеОбеспечениеЗаказов") Тогда
		Элементы.Обеспечивать.Видимость = Ложь;
	ИначеЕсли ДействияОбособленные.Количество() = 0 Тогда
		Элементы.Обеспечивать.Доступность = Ложь;
	КонецЕсли;

	Если КоличествоПодНазначение >= КоличествоТребуется И Не ОбеспечениеСверхДопустимо Тогда
		Элементы.Обеспечивать.Доступность = Ложь;
	КонецЕсли;

	СкладВидимость = Справочники.Склады.ЭтоГруппа(Параметры.ГруппаСкладов);
	Элементы.Склад.Видимость = СкладВидимость;
	Элементы.СкладОбособленно.Видимость = СкладВидимость;

	Элементы.СтраницыДействия.ТекущаяСтраница = ?(Обеспечивать = "Обособленно",
		Элементы.СтраницаДействияОбособленные, Элементы.СтраницаДействия);

	ХарактеристикаТекст = ?(ЗначениеЗаполнено(Параметры.Отбор.Характеристика), ", " + Параметры.Отбор.Характеристика, "");
	ШаблонЗаголовка = НСтр("ru = 'Выбор действия (%1%2)'");
	Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонЗаголовка,
		Параметры.Отбор.Номенклатура, ХарактеристикаТекст);

	Элементы.НадписьЗаказаноОтгружено.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Всего заказано - %1 %2. Отгружено - %3 %4.'"),
		КоличествоТребуется + КоличествоОтгружено, ЕдиницаИзмерения,
		КоличествоОтгружено, ЕдиницаИзмерения);
	

	Если КоличествоТребуется <= 0 Тогда
		Элементы.ГруппаВыбранноеДействие.Видимость = Ложь;
		Элементы.Выбрать.Доступность = Ложь;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПриПереключенииОбеспечивать();
	ОбновитьНадписьОбеспечено();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОбеспечиватьПриИзменении(Элемент)

	ПриПереключенииОбеспечивать();
	ОбновитьНадписьОбеспечено();
	Если Обеспечивать <> "Обособленно" Тогда

		ВыбраннаяСтрока = Элементы.Действия.ТекущиеДанные;
	
		Если ВыбраннаяСтрока = Неопределено Тогда
			Элементы.Действия.ТекущаяСтрока = Действия[Действия.Количество() - 1].ПолучитьИдентификатор();
			ВыбраннаяСтрока = Элементы.Действия.ТекущиеДанные;
		Иначе
			ОбновитьИнформациюПоСтроке();
		КонецЕсли;

	Иначе
		ОбновитьИнформациюПоСтроке();
	КонецЕсли;


КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормыТовары

&НаКлиенте
Процедура ДействияПриАктивизацииСтроки(Элемент)

	ОбновитьИнформациюПоСтроке();
	ОбновитьНадписьОбеспечено();

КонецПроцедуры

&НаКлиенте
Процедура ДействияВыборЗначения(Элемент, Значение, СтандартнаяОбработка)

	СтрокаТаблицы = Действия.НайтиПоИдентификатору(Значение);
	ВыбратьНаКлиенте(СтрокаТаблицы);

КонецПроцедуры

&НаКлиенте
Процедура ДействияОбособленныеПриАктивизацииСтроки(Элемент)

	ОбновитьИнформациюПоСтроке();
	ОбновитьНадписьОбеспечено();

КонецПроцедуры

&НаКлиенте
Процедура ДействияОбособленныеВыборЗначения(Элемент, Значение, СтандартнаяОбработка)

	СтрокаТаблицы = ДействияОбособленные.НайтиПоИдентификатору(Значение);
	ВыбратьНаКлиенте(СтрокаТаблицы);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)

	ТаблицаФормы = ?(Обеспечивать = "Обособленно", ЭтаФорма.Элементы.ДействияОбособленные, ЭтаФорма.Элементы.Действия);
	СтрокаТаблицы = ТаблицаФормы.ТекущиеДанные;
	ВыбратьНаКлиенте(СтрокаТаблицы);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьНадписьОбеспечено()
	
	Если Элементы.СтраницыДействия.ТекущаяСтраница <> Элементы.СтраницаДействия Тогда
		
		Если ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Работа") Тогда
			
			Шаблон = НСтр("ru = 'Обеспечено - %1 %2, не обеспечено - %3 %4.'");
			НадписьОбеспечено = СтрШаблон(Шаблон,
				КоличествоПодНазначение, ЕдиницаИзмерения,
				Макс(КоличествоТребуется - КоличествоПодНазначение, 0), ЕдиницаИзмерения);
				
		Иначе
			
			Шаблон = НСтр("ru = 'Поступило - %1 %2, ожидается - %3 %4, не обеспечено - %5 %6.'");
			
			НадписьОбеспечено = СтрШаблон(Шаблон,
				КоличествоОтгрузитьОбособленно, ЕдиницаИзмерения,
				КоличествоПодНазначение - КоличествоОтгрузитьОбособленно, ЕдиницаИзмерения,
				Макс(КоличествоТребуется - КоличествоПодНазначение, 0), ЕдиницаИзмерения);
				
		КонецЕсли;
		
	Иначе
		
		ТекущаяСтрока = Элементы.Действия.ТекущиеДанные;
		
		Если ТекущаяСтрока = Неопределено
			Или ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Работа")
			Или ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Услуга") Тогда
				
				НадписьОбеспечено = "";
				
			Иначе
				
				КоличествоОтгрузить = 0;
				КоличествоОжидается = 0;
				Для каждого СтрокаТаблицы Из Действия Цикл
					
					Если СтрокаТаблицы.Склад = ТекущаяСтрока.Склад Тогда
						
						Если СтрокаТаблицы.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Отгрузить")
							Или СтрокаТаблицы.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.СоСклада") Тогда
							КоличествоОтгрузить = СтрокаТаблицы.КоличествоДоступно;
						КонецЕсли;
						
						Если СтрокаТаблицы.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.ИзЗаказов") Тогда
							КоличествоОжидается = Макс(КоличествоОжидается, СтрокаТаблицы.КоличествоДоступно);
						КонецЕсли;
						
					КонецЕсли;
					
				КонецЦикла;
				КоличествоОжидается = Макс(КоличествоОжидается - КоличествоОтгрузить, 0);
				
				НадписьОбеспечено = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Доступно сейчас - %1 %2, ожидается - %3 %4.'"),
					КоличествоОтгрузить, ЕдиницаИзмерения,
					КоличествоОжидается, ЕдиницаИзмерения);
				
			КонецЕсли;
			
	КонецЕсли;
	
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ТаблицаАналитикиПотребности(Параметры)

	Аналитики = Новый Структура();

	Таблица = ОбеспечениеСервер.ТаблицаПоОписаниюПолей(ОбеспечениеКлиентСервер.КлючиПотребностей("Товар"));
	Аналитики.Вставить("Товары", Таблица);
	Таблица = ОбеспечениеСервер.ТаблицаПоОписаниюПолей(ОбеспечениеКлиентСервер.КлючиПотребностей("Работа"));
	Аналитики.Вставить("Работы", Таблица);
	Таблица = ОбеспечениеСервер.ТаблицаПоОписаниюПолей(ОбеспечениеКлиентСервер.КлючиПотребностей("ТоварОбособленный"));
	Аналитики.Вставить("ТоварыОбособленные", Таблица);

	ТипНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Отбор.Номенклатура, "ТипНоменклатуры");

	Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Работа Тогда

		НоваяСтрока = Аналитики.Работы.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Параметры.Отбор);

	Иначе

		// Определение склада, для которого необходимо получать календарь обеспечения.
		Если Справочники.Склады.ЭтоГруппа(Параметры.ГруппаСкладов) Тогда

			МассивСкладов = ОбеспечениеСервер.СкладыГруппы(Параметры.ГруппаСкладов);

		Иначе

			МассивСкладов = Новый Массив();
			МассивСкладов.Добавить(Параметры.Отбор.Склад);

		КонецЕсли;

		Для Каждого Склад Из МассивСкладов Цикл

			// Необходимо получать остатки обеспечения обособленным товаром/тарой для данного склада.
			Если ЗначениеЗаполнено(Параметры.Отбор.Назначение) Тогда

				НоваяСтрока = Аналитики.ТоварыОбособленные.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, Параметры.Отбор);
				НоваяСтрока.Склад = Склад;

			КонецЕсли;

			// Необходимо получать остатки обеспечения для выбранной позиции номенклатуры для данного склада.
			НоваяСтрока = Аналитики.Товары.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Параметры.Отбор);
			НоваяСтрока.Склад = Склад;

		КонецЦикла;

	КонецЕсли;

	Возврат Аналитики;

КонецФункции

&НаСервереБезКонтекста
Процедура ЗагрузитьДействия(СписокВариантов, Таблица, ДоступныеОстатки)

	ДобавлятьОтгрузить = СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.Отгрузить) <> Неопределено;
	ДобавлятьСоСклада  = СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.СоСклада) <> Неопределено;
	ДобавлятьИзЗаказов = СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.ИзЗаказов) <> Неопределено;

	Если Не ДобавлятьСоСклада И Не ДобавлятьИзЗаказов И Не ДобавлятьОтгрузить Тогда
		Возврат;
	КонецЕсли;

	Для Каждого Строка Из ДоступныеОстатки Цикл

		Если ДобавлятьОтгрузить И Не ЗначениеЗаполнено(Строка.ДатаДоступности) Тогда

			НоваяСтрока = Таблица.Добавить();
			НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Отгрузить;
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка, "Количество, Склад");

		КонецЕсли;

		Если ДобавлятьСоСклада И Не ЗначениеЗаполнено(Строка.ДатаДоступности) Тогда

			НоваяСтрока = Таблица.Добавить();
			НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.СоСклада;
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка, "Количество, Склад");

		КонецЕсли;

		Если ДобавлятьИзЗаказов И ЗначениеЗаполнено(Строка.ДатаДоступности) Тогда

			НоваяСтрока = Таблица.Добавить();
			НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.ИзЗаказов;
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка, "Количество, Склад, ДатаДоступности");

		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗагрузитьДействияОбособленные(СписокВариантов, Таблица, ДоступныеОстатки, КоличествоОтгрузитьОбособленно)

	КоличествоПодНазначение = 0;
	ДобавлятьОтгрузить = СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно) <> Неопределено;

	Для Каждого Строка Из ДоступныеОстатки Цикл

		Если Не ЗначениеЗаполнено(Строка.ДатаДоступности) Тогда
			КоличествоОтгрузитьОбособленно = Строка.Количество;
		КонецЕсли;

		Если Не ЗначениеЗаполнено(Строка.ДатаДоступности) И ДобавлятьОтгрузить Тогда

			НоваяСтрока = Таблица.Добавить();
			НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно;
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка, "Количество, Склад");

		КонецЕсли;

		КоличествоПодНазначение = Макс(КоличествоПодНазначение, Строка.Количество);

	КонецЦикла;

	Возврат КоличествоПодНазначение;

КонецФункции

&НаСервереБезКонтекста
Процедура ЗагрузитьПлановыеПоставки(СписокВариантов, Таблица, ПлановыеПоставки, Вариант)

	ДобавлятьОбеспечить = СписокВариантов.НайтиПоЗначению(Вариант) <> Неопределено;

	Если Не ДобавлятьОбеспечить Тогда
		Возврат;
	КонецЕсли;

	Для Каждого Строка Из ПлановыеПоставки Цикл

		НоваяСтрока = Таблица.Добавить();
		НоваяСтрока.ВариантОбеспечения = Вариант;
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка, "Склад, ДатаДоступности");

	КонецЦикла;

КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗагрузитьДействияРабот(СписокВариантов, Таблица, ДоступныеОстатки, Количество)

	КоличествоПодНазначение = 0;
	ДобавлятьОтгрузить = СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно) <> Неопределено;

	Для Каждого Строка Из ДоступныеОстатки Цикл
		КоличествоПодНазначение = Макс(КоличествоПодНазначение, Строка.Количество);
	КонецЦикла;

	Если ДобавлятьОтгрузить Тогда
		НоваяСтрока = Таблица.Добавить();
		НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно;
		НоваяСтрока.Количество = Количество;
		НоваяСтрока.ДатаДоступности = '00010101';
	КонецЕсли;

	Возврат КоличествоПодНазначение;

КонецФункции

&НаСервереБезКонтекста
Процедура ЗагрузитьДействияУслуг(СписокВариантов, Таблица)

	Если СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.НеТребуется) <> Неопределено Тогда
		НоваяСтрока = Таблица.Добавить();
		НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.НеТребуется;
	КонецЕсли;

	Если СписокВариантов.НайтиПоЗначению(Перечисления.ВариантыОбеспечения.Отгрузить) <> Неопределено Тогда
		НоваяСтрока = Таблица.Добавить();
		НоваяСтрока.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Отгрузить;
	КонецЕсли;

КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОформитьСтроку(Строка, КоличествоВсего, СписокВариантов)

	Строка.КоличествоДоступно = Макс(Строка.Количество, Строка.КоличествоДоступно);
	
	Если Строка.Количество >= КоличествоВсего Тогда
		Строка.Количество = 0;
	КонецЕсли;
	
	Строка.Действие = ДействиеСтрокой(Строка, СписокВариантов);

	Если Строка.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно Тогда
		Строка.ПорядокСортировки = 0;
	ИначеЕсли Строка.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Обособленно Тогда
		Строка.ПорядокСортировки = 1;
	ИначеЕсли Строка.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Отгрузить Тогда
		Строка.ПорядокСортировки = 2;
	ИначеЕсли Строка.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.СоСклада Тогда
		Строка.ПорядокСортировки = 3;
	ИначеЕсли Строка.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.ИзЗаказов Тогда
		Строка.ПорядокСортировки = 4;
	ИначеЕсли Строка.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.Требуется Тогда
		Строка.ПорядокСортировки = 5;
	ИначеЕсли Строка.ВариантОбеспечения = Перечисления.ВариантыОбеспечения.НеТребуется Тогда
		Строка.ПорядокСортировки = 6;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнформациюПоСтроке()

	ВыбранныеДействия.Очистить();
	ВыбраннаяСтрока = ?(Обеспечивать = "Обособленно",
		Элементы.ДействияОбособленные.ТекущиеДанные, Элементы.Действия.ТекущиеДанные);

	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;

	СтарыйВариант    = Параметры.ТекущийВариант.ВариантОбеспечения;
	ВыбранныйВариант = ВыбраннаяСтрока.ВариантОбеспечения;

	СтароеКоличество = Параметры.ТекущийВариант.Количество - КоличествоОтгружено;
	НовоеКоличество  = ?(ВыбраннаяСтрока.Количество = 0, СтароеКоличество, ВыбраннаяСтрока.Количество);
	
	Если СтароеКоличество > НовоеКоличество Тогда

		НоваяСтрока = ВыбранныеДействия.Вставить(0);
		НоваяСтрока.Склад = Параметры.ТекущийВариант.Склад;
		НоваяСтрока.Количество = СтароеКоличество - НовоеКоличество;
		
		// Заполнение варианта обеспечения для недостающего количества.
		Если СтарыйВариант = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Обособленно") Тогда
			Таблица = ДействияОбособленные;
		Иначе
			Таблица = Действия;
		КонецЕсли;

		НоваяСтрока.ВариантОбеспечения = ВариантПоУмолчанию;

		// Заполнение даты доступности датой плановой поставки.
		Если ВариантПоУмолчанию = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Требуется")
			Или ВариантПоУмолчанию = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Обособленно") Тогда

			Если Таблица <> Неопределено Тогда

				Для Каждого Строка Из Таблица Цикл

					Если Строка.Склад = Параметры.ТекущийВариант.Склад
						И (Строка.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Требуется")
							Или Строка.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Обособленно")) Тогда

							НоваяСтрока.ДатаДоступности = Строка.ДатаДоступности;
							Прервать;

					КонецЕсли;

				КонецЦикла;

			КонецЕсли;

		КонецЕсли;

	КонецЕсли;

	НоваяСтрока = ВыбранныеДействия.Вставить(0);
	ЗаполнитьЗначенияСвойств(НоваяСтрока, ВыбраннаяСтрока, "ВариантОбеспечения, Склад, ДатаДоступности");
	НоваяСтрока.Количество = НовоеКоличество;

	Действие1 = ПодсказкаДействие(1);

	Элементы.СтраницыДействие1.ТекущаяСтраница = Элементы.СтраницаДействие1;
	Если ВыбранныеДействия.Количество() > 1 Тогда

		Элементы.ГруппаДействие2.ТекущаяСтраница = Элементы.СтраницаЕстьДействие2;
		Действие2 = ПодсказкаДействие(2);
		Элементы.СтраницыРазбитьСтроку.ТекущаяСтраница = Элементы.СтраницаРазбитьСтроку;

	Иначе

		Элементы.ГруппаДействие2.ТекущаяСтраница = Элементы.СтраницаНетДействия2;
		Элементы.СтраницыРазбитьСтроку.ТекущаяСтраница = Элементы.СтраницаНеРазбиватьСтроку;

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Функция ПодсказкаДействие(Номер)

	ВыбранноеДействие = ВыбранныеДействия[Номер - 1];

	ДействиеСтрокой = ДействиеСтрокой(ВыбранноеДействие, СписокВариантов);
	Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = '%1 %2, %3'"),
		ВыбранноеДействие.Количество,
		ПредставлениеЕдиницыИзмерения,
		ДействиеСтрокой);

	Возврат Текст;

КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ДействиеСтрокой(Строка, СписокВариантов)
	
	НайденныйВариант = СписокВариантов.НайтиПоЗначению(Строка.ВариантОбеспечения);
	
	ДатаСтрокой = Формат(Строка.ДатаДоступности, "ДЛФ=D");
	ЗаполненаДатаОтгрузки = (Строка.ДатаДоступности <> Дата(1, 1, 1, 0, 0, 0));
	
	Если Строка.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Требуется") И ЗаполненаДатаОтгрузки Тогда
		
		ДействиеСтрокой = ?(
			ЗначениеЗаполнено(НайденныйВариант.Представление),
			НайденныйВариант.Представление,
			СтрШаблон(НСтр("ru = 'К обеспечению (срок %1)'"), ДатаСтрокой));
		
	ИначеЕсли Строка.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Обособленно") И ЗаполненаДатаОтгрузки Тогда
		
		ДействиеСтрокой = ?(
			ЗначениеЗаполнено(НайденныйВариант.Представление),
			НайденныйВариант.Представление,
			СтрШаблон(НСтр("ru = 'Обеспечивать обособленно (срок %1)'"), ДатаСтрокой));
		
	ИначеЕсли Строка.ВариантОбеспечения = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.ИзЗаказов") Тогда
		
		Шаблон = НСтр("ru = 'Резервировать к %1'");
		ДействиеСтрокой = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Шаблон, ДатаСтрокой);
		
	Иначе
		
		ДействиеСтрокой = ?(ЗначениеЗаполнено(НайденныйВариант.Представление), НайденныйВариант.Представление, Строка(Строка.ВариантОбеспечения));
		
	КонецЕсли;
	
	Возврат ДействиеСтрокой;
	
КонецФункции

&НаКлиенте
Процедура ВыбратьНаКлиенте(СтрокаТаблицы)

	Обособленно = ПредопределенноеЗначение("Перечисление.ВариантыОбеспечения.Обособленно");
	МассивВыбора = Новый Массив();

	МассивВыбора = Новый Массив();
	Если КоличествоОтгружено > 0 Тогда
		ЗначениеВыбора = ОбеспечениеКлиентСервер.СтруктураВариантаОбеспечения();
		ЗначениеВыбора.ВариантОбеспечения   = Параметры.ТекущийВариант.ВариантОбеспечения;
		ЗначениеВыбора.ДатаОтгрузки         = Параметры.ТекущийВариант.ДатаДоступности;
		ЗначениеВыбора.Склад                = Параметры.ТекущийВариант.Склад;
		ЗначениеВыбора.Серия                = ПредопределенноеЗначение("Справочник.СерииНоменклатуры.ПустаяСсылка");
		ЗначениеВыбора.Количество           = КоличествоОтгружено;
		ЗначениеВыбора.Вставить("Отгружено", 1);
		МассивВыбора.Добавить(ЗначениеВыбора);
	КонецЕсли;

	Для Каждого СтрокаТаблицы Из ВыбранныеДействия Цикл

		ЗначениеВыбора = ОбеспечениеКлиентСервер.СтруктураВариантаОбеспечения();
		ЗначениеВыбора.ВариантОбеспечения   = СтрокаТаблицы.ВариантОбеспечения;
		ЗначениеВыбора.ДатаОтгрузки         = СтрокаТаблицы.ДатаДоступности;
		ЗначениеВыбора.Склад                = СтрокаТаблицы.Склад;
		ЗначениеВыбора.Серия                = ПредопределенноеЗначение("Справочник.СерииНоменклатуры.ПустаяСсылка");
		ЗначениеВыбора.Количество           = СтрокаТаблицы.Количество;
		ЗначениеВыбора.Вставить("Отгружено", 0);

		Если КоличествоОтгружено > 0 И ЗначениеВыбора.ВариантОбеспечения = МассивВыбора[0].ВариантОбеспечения
			И ЗначениеВыбора.Склад = МассивВыбора[0].Склад Тогда

			МассивВыбора[0].Количество = МассивВыбора[0].Количество + ЗначениеВыбора.Количество;

		Иначе

			МассивВыбора.Добавить(ЗначениеВыбора);

		КонецЕсли;

	КонецЦикла;

	ОповеститьОВыборе(МассивВыбора);

КонецПроцедуры

&НаКлиенте
Процедура ПриПереключенииОбеспечивать()

	Элементы.СтраницыДействия.ТекущаяСтраница = ?(Обеспечивать = "Обособленно",
		Элементы.СтраницаДействияОбособленные, Элементы.СтраницаДействия);

КонецПроцедуры

&НаСервере
Функция НайтиИдентификаторСтроки(Таблица, ВариантОбеспечения, ДатаДоступности)

	ПараметрыОтбора = Новый Структура("ВариантОбеспечения", ВариантОбеспечения);
	Строки = Таблица.НайтиСтроки(ПараметрыОтбора);
	Если Строки.Количество() > 0 Тогда

		Если Строки.Количество() = 1 Тогда
			НайденнаяСтрока = Строки[0];
		Иначе

			НайденнаяСтрока = Строки[0];
			Для каждого Строка Из Строки Цикл

				РазностьДат = НайденнаяСтрока.ДатаДоступности - ДатаДоступности;
				РазностьДат = ?(РазностьДат < 0, -РазностьДат, РазностьДат);
				РазностьДатНовая = Строка.ДатаДоступности - ДатаДоступности;
				РазностьДатНовая = ?(РазностьДатНовая < 0, -РазностьДатНовая, РазностьДатНовая);
				Если РазностьДат > РазностьДатНовая Тогда
					НайденнаяСтрока = Строка;
				КонецЕсли;

			КонецЦикла;

		КонецЕсли;

		Возврат НайденнаяСтрока.ПолучитьИдентификатор();

	Иначе
		Возврат Неопределено;
	КонецЕсли;

КонецФункции

&НаСервере
Процедура ЗаполнитьСписокДоступныхВариантовОбеспечения()

	ДоступныеВарианты = ОбеспечениеКлиентСервер.ПереченьВариантовОбеспечения(Параметры.Отбор.ТипНоменклатуры, Параметры.СписокВыбора);

	ИсключаемыеВарианты = Новый Соответствие();

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьОбособленноеОбеспечениеЗаказов") Тогда
		ИсключаемыеВарианты.Вставить(Перечисления.ВариантыОбеспечения.Обособленно, Истина);
		ИсключаемыеВарианты.Вставить(Перечисления.ВариантыОбеспечения.ОтгрузитьОбособленно, Истина);
	КонецЕсли;

	Вграница = ДоступныеВарианты.Количество()-1;
	Для Индекс = 0 По ВГраница Цикл

		Если ИсключаемыеВарианты.Получить(ДоступныеВарианты[ВГраница - Индекс].Значение) <> Неопределено Тогда
			ДоступныеВарианты.Удалить(ВГраница - Индекс);
		КонецЕсли;

	КонецЦикла;

	Для каждого ЭлементКоллекции Из ДоступныеВарианты Цикл
		СписокВариантов.Добавить(ЭлементКоллекции.Значение, ЭлементКоллекции.Представление);
	КонецЦикла; 

КонецПроцедуры

#КонецОбласти
