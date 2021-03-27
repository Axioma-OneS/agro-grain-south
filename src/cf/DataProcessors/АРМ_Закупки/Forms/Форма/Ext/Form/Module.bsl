﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, Карло Иван
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
/////////////////////////////////////////////////////////////////////////////////////////////////////// 

#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.ОсновноеМеню.Пометка = Истина;
	УстановитьНадписьТекущейСтраницы();
	Элементы.ПоказатьСообщения.Видимость 			= Ложь;
	Элементы.ГруппаИзменитьНастройка.Доступность 	= Ложь;
	Элементы.УдалитьИЗакрыть.Доступность			= Ложь;
	Элементы.ГруппаСохранить.Видимость 				= Ложь;
	Элементы.ГруппаСохранитьИПерейти.Видимость 		= Ложь;	

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Отказ = Истина;	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	ИнициализироватьСтраницы();
	
	Элементы.ГруппаИзменитьНастройка.Доступность 	= Ложь;
	Элементы.УдалитьИЗакрыть.Доступность			= Ложь;
		
	Если ТекущаяСтраница = Элементы.СтраницаОсновноеМеню Тогда 
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;		
		
	ИначеЕсли ТекущаяСтраница = Элементы.СтраницаРеестрДоговоров Тогда
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;
		
	ИначеЕсли ТекущаяСтраница = Элементы.СтраницаКонтрагент Тогда
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;
		
	ИначеЕсли ТекущаяСтраница = Элементы.СтраницаРеестрКонтрагентов Тогда
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;
		
	ИначеЕсли ТекущаяСтраница = Элементы.СтраницаДоговор Тогда
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;		
		
	ИначеЕсли ТекущаяСтраница = Элементы.СтраницаСпецификация Тогда
		Элементы.ГруппаСохранить.Видимость 			= Истина;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Истина;
		
	ИначеЕсли ТекущаяСтраница = Элементы.СтраницаПеревозка Тогда
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;	
		
	ИначеЕсли ТекущаяСтраница = Элементы.СтраницаДопУслуги Тогда
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;	
		
	Иначе 
		Элементы.ГруппаСохранить.Видимость 			= Ложь;
		Элементы.ГруппаСохранитьИПерейти.Видимость 	= Ложь;
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПартнерПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(Объект.Партнер) Тогда 
		ПартнерПриИзмененииНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура БазисПоставкиПриИзменении(Элемент)
	
	Если БазисПоставки = "CPT" Тогда 
		Объект.БазисПоставки = ПредопределенноеЗначение("Перечисление.СпособыДоставки.СиламиПоставщикаДоНашегоСклада");		
	ИначеЕсли БазисПоставки = "EXW" Тогда 	
		Объект.БазисПоставки = ПредопределенноеЗначение("Перечисление.СпособыДоставки.СиламиПеревозчикаДоНашегоСклада");
	Иначе 
		Объект.БазисПоставки = ПредопределенноеЗначение("Перечисление.СпособыДоставки.Самовывоз");
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ГородАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	ДанныеВыбора = Новый СписокЗначений;
	
	ТекстДляАвтоПодбора = СокрЛП(Текст);
	Если СтрДлина(ТекстДляАвтоПодбора) < 3 Тогда
		// Нет вариантов, список пуст, стандартную обработку не надо трогать.
		Возврат;
	КонецЕсли;
	
	Результат = СписокАвтоподбораНаселенногоПункта(ТекстДляАвтоПодбора);
	Если Результат.Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеВыбора = Результат.Данные;
	// Стандартную обработку отключаем, только если есть наши варианты.
	Если ДанныеВыбора.Количество() > 0 Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ГородОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если ВыбранноеЗначение = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	Если ТипЗнч(ВыбранноеЗначение) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	Объект.Город = ВыбранноеЗначение.Представление;

КонецПроцедуры

&НаКлиенте
Процедура СкладГрузополучателя1НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДанныеВыбора = Новый СписокЗначений;
	
	Если Не ПустаяСтрока(Объект.Город) Тогда 
		Результат = СписокПодбораСклады(Объект.Город);
		Если Результат.Отказ Тогда
			Возврат;
		КонецЕсли;

		ДанныеВыбора = Результат.Данные;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ВидПродукцииОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтавкаНДС_ИзНоменклатуры = ОбщегоНазначенияУТВызовСервера.ЗначениеРеквизитаОбъекта(ВыбранноеЗначение, "СтавкаНДС");
	Если СтавкаНДС_ИзНоменклатуры = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС20") Тогда 
		СтавкаНДС_Товара = "20%";	
	ИначеЕсли СтавкаНДС_ИзНоменклатуры = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС10") Тогда 
		СтавкаНДС_Товара = "10%";
	Иначе 	
		СтавкаНДС_Товара = "0%";
	КонецЕсли;
	
	ПересчитатьСумму();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбъемТовараПриИзменении(Элемент)
	ПересчитатьСумму();
КонецПроцедуры

&НаКлиенте
Процедура ЦенаТовараСНДСПриИзменении(Элемент)
	ПересчитатьСумму();
КонецПроцедуры

&НаКлиенте
Процедура СтавкаНДС_ТовараПриИзменении(Элемент)
	
	Если СтавкаНДС_Товара = "20%" Тогда 
		Объект.СтавкаНДСТовара = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС20");		
	ИначеЕсли СтавкаНДС_Товара = "10%" Тогда 	
		Объект.СтавкаНДСТовара = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС10");
	Иначе 
		Объект.СтавкаНДСТовара = ПредопределенноеЗначение("Перечисление.СтавкиНДС.БезНДС");
	КонецЕсли;	
	
	ПересчитатьСумму();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область СтраницаОсновноеМеню

&НаКлиенте
Процедура ОсновноеМеню(Команда)
	
	Если Модифицированность Тогда
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ПередОсновноеМенюЗавершение", ЭтотОбъект);
		ТекстВопроса       = НСтр("ru = 'Данные не сохранены и будут удалены после выхода. Продолжить?'");
		
		СписокКнопок = Новый СписокЗначений;
		СписокКнопок.Добавить("Да"		, НСтр("ru = 'Да'"));
		СписокКнопок.Добавить("Остаться", НСтр("ru = 'Остаться'"));
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, СписокКнопок);
		
	Иначе 
		ПередОсновноеМенюЗавершение("Да", "");
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередОсновноеМенюЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт

	ОтветНаВопрос = РезультатВопроса;
	
	Если ОтветНаВопрос = "Да" Тогда
		СброситьПометкиКомандШапки(Элементы);
	
		Элементы.ОсновноеМеню.Пометка = Не Элементы.ОсновноеМеню.Пометка;
		Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаОсновноеМеню;
		УстановитьНадписьТекущейСтраницы();
		СтраницыПриСменеСтраницы("", Элементы.СтраницаОсновноеМеню);
		Модифицированность = Ложь;
	КонецЕсли;

КонецПроцедуры	
	
&НаКлиенте
Процедура ПерейтиРеестрКонтрагентов(Команда)
	
	СброситьПометкиКомандШапки(Элементы);
	
	Элементы.ПерейтиРеестрКонтрагентов.Пометка = Истина;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаРеестрКонтрагентов;
	УстановитьНадписьТекущейСтраницы();
	СтраницыПриСменеСтраницы("", Элементы.СтраницаРеестрКонтрагентов);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиКонтрагент(Команда)
	
	СброситьПометкиКомандШапки(Элементы);
	
	Элементы.ПерейтиКонтрагент.Пометка = Истина;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаКонтрагент;
	УстановитьНадписьТекущейСтраницы();
	СтраницыПриСменеСтраницы("", Элементы.СтраницаКонтрагент);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиРеестрДоговоров(Команда)
	
	СброситьПометкиКомандШапки(Элементы);
	
	Элементы.ПерейтиРеестрДоговоров.Пометка = Истина;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаРеестрДоговоров;
	УстановитьНадписьТекущейСтраницы();
	СтраницыПриСменеСтраницы("", Элементы.СтраницаРеестрДоговоров);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиДоговор(Команда)
	
	СброситьПометкиКомандШапки(Элементы);
	
	Элементы.ПерейтиДоговор.Пометка = Истина;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаДоговор;
	УстановитьНадписьТекущейСтраницы();
	СтраницыПриСменеСтраницы("", Элементы.СтраницаДоговор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиСпецификация(Команда)
	
	СброситьПометкиКомандШапки(Элементы);
	
	Элементы.ПерейтиСпецификация.Пометка = Истина;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСпецификация;
	УстановитьНадписьТекущейСтраницы();
	СтраницыПриСменеСтраницы("", Элементы.СтраницаСпецификация);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиПеревозка(Команда)
	
	СброситьПометкиКомандШапки(Элементы);
	
	Элементы.ПерейтиПеревозка.Пометка = Истина;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаПеревозка;
	УстановитьНадписьТекущейСтраницы();
	СтраницыПриСменеСтраницы("", Элементы.СтраницаПеревозка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиДопУслуги(Команда)
	
	СброситьПометкиКомандШапки(Элементы);
	
	Элементы.ПерейтиДопУслуги.Пометка = Истина;
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаДопУслуги;
	УстановитьНадписьТекущейСтраницы();
	СтраницыПриСменеСтраницы("", Элементы.СтраницаДопУслуги);
	
КонецПроцедуры

&НаКлиенте
Процедура Выйти(Команда)
	
	ЗавершитьРаботуСистемы(Ложь);
	
КонецПроцедуры

#КонецОбласти


#Область СтраницаСпецификация

&НаКлиенте
Процедура СоздатьПартнера(Команда)
	
	ПерейтиКонтрагент(ЭтаФорма.Команды.Найти("ПерейтиКонтрагент"));	
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьДоговор(Команда)
	
	ПерейтиДоговор(ЭтаФорма.Команды.Найти("ПерейтиДоговор"));
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьПрисоединенныйФайл(Команда)
	
	ПриЗавершении 	= Новый ОписаниеОповещения("СоздатьПрисоединенныйФайлКомандаЗавершение", ЭтотОбъект);
    ПередПомещением = Новый ОписаниеОповещения("СоздатьПрисоединенныйФайлКомандаПередПомещением", ЭтотОбъект);
    ДиалогВыбораФайлов = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
    ДиалогВыбораФайлов.Заголовок 			= "Выбор файла для помещения";
	ДиалогВыбораФайлов.МножественныйВыбор 	= Ложь;
    НачатьПомещениеФайла(ПриЗавершении, , ДиалогВыбораФайлов, Истина, , ПередПомещением);
		
КонецПроцедуры

&НаКлиенте
Процедура СоздатьПрисоединенныйФайлКомандаЗавершение(Результат, Адрес, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
	
	Если Результат Тогда 
		ВыбранныйФайл = Новый Файл(ВыбранноеИмяФайла);
		СписокПрисоединенныхФайлов.Добавить( Новый Структура("Имя, Расширение, Адрес", ВыбранныйФайл.ИмяБезРасширения, ВыбранныйФайл.Расширение, Адрес), ВыбранныйФайл.Имя);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьПрисоединенныйФайлКомандаПередПомещением(ПомещаемыйФайл, ОтказОтПомещенияФайла, ДополнительныеПараметры) Экспорт
	
	Если ПомещаемыйФайл.Размер() > 5*1024*1024 Тогда
        ПоказатьПредупреждение(, "Превышен максимальный размер файла");
        ОтказОтПомещенияФайла = Истина;
    КонецЕсли;
    Файл = ПомещаемыйФайл.Файл.ПолноеИмя;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПрисоединенныйФайл(Команда)
	
	ТекДанные = Элементы.СписокПрисоединенныхФайлов.ТекущиеДанные;	
	Если ТекДанные <> Неопределено Тогда 
		
		ДиалогВыбораФайлов = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
   		ДиалогВыбораФайлов.Заголовок 			= "Выбор каталога для сохранения файла";
		ДиалогВыбораФайлов.МножественныйВыбор 	= Ложь;
		
		Контекст = Новый Структура("ДиалогВыбораФайлов, Адрес, Представление", 
				ДиалогВыбораФайлов, ТекДанные.Значение.Адрес, ТекДанные.Представление);
	
		Оповещение = Новый ОписаниеОповещения("СохранитьПрисоединенныйФайлЗавершение", 
				ЭтотОбъект, Контекст);
		ДиалогВыбораФайлов.Показать(Оповещение);
				
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПрисоединенныйФайлЗавершение(ВыбранныеФайлы, Контекст) Экспорт
	
	ДиалогВыбораФайлов = Контекст.ДиалогВыбораФайлов;
	
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(Контекст.Адрес);
		ДвоичныеДанные.ЗаписатьАсинх(СтрШаблон("%1\%2", 
				ДиалогВыбораФайлов.Каталог, Контекст.Представление));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ГруппаПодвал 

&НаКлиенте
Процедура Сохранить(Команда)
	
	СохранитьДокумент();	
		
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИВернутьсяВОсновноеМеню(Команда)
	
	Успешно = СохранитьДокумент();
	Если Успешно Тогда 
		ОсновноеМеню(ЭтаФорма.Команды.Найти("ОсновноеМеню"));
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СохранитьИПерейтиКСозданиюДопУслуг(Команда)
	
	Успешно = СохранитьДокумент();
	Если Успешно Тогда
		ПерейтиДопУслуги(ЭтаФорма.Команды.Найти("ПерейтиДопУслуги"));
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИПерейтиКСозданиюПеревозки(Команда)
	
	Успешно = СохранитьДокумент();
	Если Успешно Тогда 
		ПерейтиПеревозка(ЭтаФорма.Команды.Найти("ПерейтиПеревозка"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ГруппаОсновнаяКоманднаяПанель

&НаКлиенте
Процедура Изменить(Команда)
	
	Элементы.Страницы.ТекущаяСтраница.ТолькоПросмотр 	= Элементы.Изменить.Пометка;
	Элементы.УдалитьИЗакрыть.Доступность 				= Не Элементы.Изменить.Пометка;
	Модифицированность 									= Не Элементы.Изменить.Пометка;
	
	Элементы.Изменить.Пометка = Не Элементы.Изменить.Пометка;
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьИЗакрыть(Команда)
	
	Если Модифицированность Тогда
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ПередУдалитьИЗакрытьЗавершение", ЭтотОбъект);
		ТекстВопроса       = НСтр("ru = 'Данные не сохранены и будут удалены после выхода. Продолжить?'");
		
		СписокКнопок = Новый СписокЗначений;
		СписокКнопок.Добавить("Да"		, НСтр("ru = 'Да'"));
		СписокКнопок.Добавить("Остаться", НСтр("ru = 'Остаться'"));
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, СписокКнопок);
		
	Иначе 
		ПередОсновноеМенюЗавершение("Да", "");
		
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПередУдалитьИЗакрытьЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт

	ОтветНаВопрос = РезультатВопроса;
	
	Если ОтветНаВопрос = "Да" Тогда
		Если Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСпецификация Тогда 
			УстановитьПометкуУдаления(Объект.ЗаказПоставщикуСсылка);
		КонецЕсли;
		ОсновноеМеню(ЭтаФорма.Команды.Найти("ОсновноеМеню"));

		СброситьПометкиКомандШапки(Элементы);
	
		Элементы.ОсновноеМеню.Пометка = Не Элементы.ОсновноеМеню.Пометка;
		Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаОсновноеМеню;
		УстановитьНадписьТекущейСтраницы();
		СтраницыПриСменеСтраницы("", Элементы.СтраницаОсновноеМеню);
		Модифицированность = Ложь;
	КонецЕсли;

КонецПроцедуры	

#КонецОбласти


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПартнерПриИзмененииНаСервере()

	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	ДоговорыКонтрагентов.Ссылка КАК Ссылка
	                      |ИЗ
	                      |	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	                      |ГДЕ
	                      |	НЕ ДоговорыКонтрагентов.ПометкаУдаления
	                      |	И ДоговорыКонтрагентов.Партнер = &Партнер
	                      |	И ДоговорыКонтрагентов.ТипДоговора = ЗНАЧЕНИЕ(Перечисление.ТипыДоговоров.СПоставщиком)
	                      |	И ДоговорыКонтрагентов.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыДоговоровКонтрагентов.Действует)");
	Запрос.УстановитьПараметр("Партнер", Объект.Партнер);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда 
		Объект.Договор = Выборка.Ссылка;	
	КонецЕсли;	
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СписокАвтоподбораНаселенногоПункта(Текст)
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |	СкладыКонтактнаяИнформация.Город КАК Регион
	                      |ИЗ
	                      |	Справочник.Склады.КонтактнаяИнформация КАК СкладыКонтактнаяИнформация
	                      |ГДЕ
	                      |	СкладыКонтактнаяИнформация.Город <> """"
	                      |	И СкладыКонтактнаяИнформация.Город ПОДОБНО &Город");
	Запрос.УстановитьПараметр("Город", СтрЗаменить("%Замена%", "Замена", Текст));
	Выборка = Запрос.Выполнить().Выбрать();	
	Данные = Новый СписокЗначений;
	Пока Выборка.Следующий() Цикл  
		СтруктураЗначения = Новый Структура(
				"Адрес, ЗагруженныеДанные, Идентификатор, Муниципальный, Отказ, ПредлагатьЗагрузкуКлассификатора, Представление",
		        "", Истина, Новый УникальныйИдентификатор, Истина, Ложь, Ложь, Выборка.Регион 
				);
		Данные.Добавить(СтруктураЗначения, Выборка.Регион);			
	КонецЦикла;
	Результат = Новый Структура("Данные, КраткоеПредставлениеОшибки, Отказ, ПодробноеПредставлениеОшибки", Данные, Неопределено, Ложь, Неопределено);
	
	УправлениеКонтактнойИнформациейСлужебный.ФорматированиеРезультатовАвтоподбора(Результат.Данные, Текст);
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Функция СписокПодбораСклады(Текст)
	
	Результат = Новый Структура("Данные, КраткоеПредставлениеОшибки, Отказ, ПодробноеПредставлениеОшибки", 
								Новый СписокЗначений, "", Ложь, "");	
								
	МассивПоиска = Новый Массив;
	МассивПоиска.Добавить("%");
	МассивПоиска.Добавить(СтрШаблон("%1", Текст));
	МассивПоиска.Добавить("%");
	СтрокаПоиска = СтрСоединить(МассивПоиска);							
								
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	СкладыКонтактнаяИнформация.Ссылка КАК Ссылка
	                      |ИЗ
	                      |	Справочник.Склады.КонтактнаяИнформация КАК СкладыКонтактнаяИнформация
	                      |ГДЕ
	                      |	СкладыКонтактнаяИнформация.Представление ПОДОБНО &НаселенныйПункт");
	Запрос.УстановитьПараметр("НаселенныйПункт", СтрокаПоиска);
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл 
		Результат.Данные.Добавить(Выборка.Ссылка);			
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ПересчитатьСумму()

	Объект.Сумма = Объект.ОбъемТовара * Объект.ЦенаТовараСНДС;	
	
	Если СтавкаНДС_Товара = "20%" Тогда 
		Объект.СтавкаНДСТовара = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС20");
		СтавкаНДС_Число	= 20;
	ИначеЕсли СтавкаНДС_Товара = "10%" Тогда	
		Объект.СтавкаНДСТовара = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС10");
		СтавкаНДС_Число	= 10;
	Иначе 	
		Объект.СтавкаНДСТовара = ПредопределенноеЗначение("Перечисление.СтавкиНДС.БезНДС");
		СтавкаНДС_Число = 0;	
	КонецЕсли;
	
	Объект.СуммаНДС = Объект.Сумма / (100 + СтавкаНДС_Число) * СтавкаНДС_Число;
	
КонецПроцедуры

&НаСервере
Функция СохранитьДокумент()	
	 
	Успешно = Ложь;
		
	Если Не ПроверитьЗаполнение() Тогда	
		Возврат Успешно;
	КонецЕсли;	
	
	Если СписокПрисоединенныхФайлов.Количество() = 0 Тогда 
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = "Присоедините хотя бы один файл";
		СообщениеПользователю.Сообщить();	
		Возврат Успешно;
	КонецЕсли;
	
	ВыборкаОрганизации = Справочники.Организации.Выбрать();
	ВыборкаОрганизации.Следующий();
	
	НайденнаяВалютаRUB = Справочники.Валюты.НайтиПоНаименованию("RUB", Истина);
		
	Если Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСпецификация Тогда
		
		НайденныйКонтрагент = Справочники.Контрагенты.НайтиПоРеквизиту("Партнер", Объект.Партнер);
		
		Если ЗначениеЗаполнено(Объект.ЗаказПоставщикуСсылка) Тогда 
			ЗаказПоставщику = Объект.ЗаказПоставщикуСсылка.ПолучитьОбъект();
		Иначе 
			ЗаказПоставщику = Документы.ЗаказПоставщику.СоздатьДокумент();
		КонецЕсли;
			
		ЗаказПоставщику.Контрагент 					= НайденныйКонтрагент;
		ЗаказПоставщику.Партнер 					= Объект.Партнер;
		ЗаказПоставщику.Договор 					= Объект.Договор;
		ЗаказПоставщику.НомерПоДаннымПоставщика 	= Объект.СпецификацияНомер;
		ЗаказПоставщику.ДатаПоДаннымПоставщика 		= Объект.ДатаЗаключения;
		ЗаказПоставщику.ДатаОкончанияСпецификации 	= Объект.ДатаОкончанияСпецификации;
		ЗаказПоставщику.СпособДоставки 				= Объект.БазисПоставки;
		ЗаказПоставщику.ТипПеревозки 				= Объект.ТипПеревозки;
		ЗаказПоставщику.Склад 						= Объект.СкладГрузополучателя;
		ЗаказПоставщику.Комментарий 				= Объект.Комментарий;
		ЗаказПоставщику.Дата 						= ТекущаяДатаСеанса();
		ЗаказПоставщику.ХозяйственнаяОперация 		= Перечисления.ХозяйственныеОперации.ЗакупкаУПоставщикаФактуровкаПоставки;
		ЗаказПоставщику.Организация 				= ВыборкаОрганизации.Ссылка;
		ЗаказПоставщику.ЖелаемаяДатаПоступления 	= ТекущаяДатаСеанса();
		ЗаказПоставщику.Менеджер 					= Пользователи.ТекущийПользователь();
		ЗаказПоставщику.Автор 						= Пользователи.ТекущийПользователь();
		ЗаказПоставщику.Подразделение 				= ЗаказПоставщику.Менеджер.Подразделение;
		ЗаказПоставщику.ДатаСогласования 			= ТекущаяДатаСеанса();
		ЗаказПоставщику.Валюта 						= НайденнаяВалютаRUB;
		ЗаказПоставщику.НалогообложениеНДС 			= Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
		ЗаказПоставщику.ЦенаВключаетНДС 			= Истина;
		ЗаказПоставщику.ЗакупкаПодДеятельность 		= Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
		ЗаказПоставщику.Согласован 					= Истина;
		ЗаказПоставщику.Статус 						= Перечисления.СтатусыЗаказовПоставщикам.Согласован;
		ЗаказПоставщику.СуммаДокумента				= Объект.Сумма;
		ЗаказПоставщику.Приоритет					= Справочники.Приоритеты.НайтиПоНаименованию("Средний", Истина);		
		ЗаказПоставщику.ПорядокРасчетов				= Перечисления.ПорядокРасчетов.ПоЗаказамНакладным;
		ЗаказПоставщику.ПорядокОплаты               = Перечисления.ПорядокОплатыПоСоглашениям.РасчетыВРубляхОплатаВРублях;
		ЗаказПоставщику.ВариантПриемкиТоваров       = Перечисления.ВариантыПриемкиТоваров.РазделенаПоЗаказамИНакладным;
		
		ЗаказПоставщику.Товары.Очистить();
		СтрокаТовары = ЗаказПоставщику.Товары.Добавить();
		СтрокаТовары.Номенклатура 		= Объект.ВидПродукции;
		СтрокаТовары.Количество 		= Объект.ОбъемТовара;
		СтрокаТовары.КоличествоУпаковок = Объект.ОбъемТовара;
		СтрокаТовары.Цена 				= Объект.ЦенаТовараСНДС;
		СтрокаТовары.Сумма 				= Объект.Сумма;
		СтрокаТовары.СтавкаНДС 			= Объект.СтавкаНДСТовара;
		СтрокаТовары.СуммаНДС 			= Объект.СуммаНДС;	
		СтрокаТовары.СуммаСНДС 			= Объект.Сумма;
		СтрокаТовары.Склад				= ЗаказПоставщику.Склад;
		
		ЗаказПоставщику.ЭтапыГрафикаОплаты.Очистить();
		ЭтапыОплатыСервер.ЗаполнитьЭтапыОплатыДокументаЗакупки(
				ЗаказПоставщику,
				Ложь,
				Объект.Сумма,
				0);
				
		СтрокаОплаты = ЗаказПоставщику.ЭтапыГрафикаОплаты.Добавить();		
		СтрокаОплаты.ВариантОплаты	= Перечисления.ВариантыОплатыПоставщику.КредитПослеПоступления;
		СтрокаОплаты.ДатаПлатежа	= ТекущаяДатаСеанса();
		СтрокаОплаты.ПроцентПлатежа	= 100;
		СтрокаОплаты.СуммаПлатежа	= Объект.Сумма;		
		
		Попытка
			ЗаказПоставщику.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
			
			Для Каждого ПрисоединенныйФайл Из СписокПрисоединенныхФайлов Цикл 
				ПараметрыФайла = Новый Структура();
				ПараметрыФайла.Вставить("Автор", Пользователи.АвторизованныйПользователь());
				ПараметрыФайла.Вставить("ВладелецФайлов", ЗаказПоставщику.Ссылка);
				ПараметрыФайла.Вставить("ИмяБезРасширения", ПрисоединенныйФайл.Представление);
				ПараметрыФайла.Вставить("РасширениеБезТочки", ПрисоединенныйФайл.Значение.Расширение);
				ПараметрыФайла.Вставить("ВремяИзмененияУниверсальное");
				ПараметрыФайла.Вставить("Служебный", Ложь);
				
				ПрисоединенныйФайл = РаботаСФайлами.ДобавитьФайл(
					ПараметрыФайла, ПрисоединенныйФайл.Значение.Адрес);

			КонецЦикла;
			
			Объект.ЗаказПоставщикуСсылка = ЗаказПоставщику.Ссылка;
			Элементы.СоздатьПрисоединенныйФайл.Доступность 	= Истина;
			Успешно = Истина;
		Исключение
			ТекстСообщения = СтрШаблон("Описание ошибки: %1", ОписаниеОшибки());
			ЗаписьЖурналаРегистрации("АРМ_Закупки.Форма.АРМ_Закупки", УровеньЖурналаРегистрации.Ошибка, Метаданные.Документы.ЗаказПоставщику, ЗаказПоставщику.Ссылка, ТекстСообщения);
			СообщениеПользователю = Новый СообщениеПользователю;
			СообщениеПользователю.Текст = ТекстСообщения;
			СообщениеПользователю.Сообщить();
		КонецПопытки;			
		
	КонецЕсли;
	
	Если Успешно Тогда 
		Модифицированность 									= Ложь;
		Элементы.Страницы.ТекущаяСтраница.ТолькоПросмотр 	= Истина;
		Элементы.ГруппаИзменитьНастройка.Доступность 		= Истина;
		Элементы.УдалитьИЗакрыть.Доступность				= Ложь;
	КонецЕсли;	
		
	Возврат Успешно;
	
КонецФункции

&НаСервере
Процедура УстановитьПометкуУдаления(Ссылка)
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		ПолученныйОбъект = Ссылка.ПолучитьОбъект();
		ПолученныйОбъект.ПометкаУдаления = Истина;
		ОбновлениеИнформационнойБазы.ЗаписатьОбъект(ПолученныйОбъект);
	КонецЕсли;
	
КонецПроцедуры

#Область Прочее

&НаКлиентеНаСервереБезКонтекста
Процедура СброситьПометкиКомандШапки(Элементы)	
	
	Элементы.ОсновноеМеню.Пометка 				= Ложь;
	Элементы.ПерейтиРеестрКонтрагентов.Пометка 	= Ложь;
	Элементы.ПерейтиКонтрагент.Пометка 			= Ложь;
	Элементы.ПерейтиРеестрДоговоров.Пометка 	= Ложь;
	Элементы.ПерейтиДоговор.Пометка 			= Ложь;
	Элементы.ПерейтиСпецификация.Пометка 		= Ложь;
	Элементы.ПерейтиПеревозка.Пометка			= Ложь;
	Элементы.ПерейтиДопУслуги.Пометка           = Ложь;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНадписьТекущейСтраницы()
	
	ЭтаФорма.Заголовок = СтрШаблон("%1", Элементы.Страницы.ТекущаяСтраница.Заголовок);
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьСтраницы()

	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	Для Каждого Реквизит Из ОбработкаОбъект.Метаданные().Реквизиты Цикл
		Объект[Реквизит.Имя] = Неопределено;		
	КонецЦикла;
	БазисПоставки 		= Неопределено;
	СтавкаНДС_Товара 	= Неопределено;
	СписокПрисоединенныхФайлов.Очистить();
	
	Для Каждого ПодчиненнаяСтраница Из Элементы.Страницы.ПодчиненныеЭлементы Цикл 
		ПодчиненнаяСтраница.ТолькоПросмотр = Ложь;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти