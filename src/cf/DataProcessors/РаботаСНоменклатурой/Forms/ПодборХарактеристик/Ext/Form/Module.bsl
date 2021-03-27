﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Параметры.Свойство("АдресДанныхНоменклатуры",     АдресДанныхНоменклатуры);
	Параметры.Свойство("ИдентификаторНоменклатуры",   ИдентификаторНоменклатуры);
	Параметры.Свойство("ИдентификаторыХарактеристик", ИдентификаторыВыбранныхХарактеристик);
	Параметры.Свойство("ЭтоРежимПросмотра",           ЭтоРежимПросмотра);
	
	Если НЕ ЗначениеЗаполнено(АдресДанныхНоменклатуры) 
		ИЛИ НЕ ЭтоАдресВременногоХранилища(АдресДанныхНоменклатуры) Тогда
		
		ВызватьИсключение НСтр("ru = 'Ошибка передачи данных номенклатуры'");
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ИдентификаторНоменклатуры) Тогда
		ВызватьИсключение НСтр("ru = 'Ошибка передачи идентификатора номенклатуры'");
	КонецЕсли;
	
	НомерСтраницыДанных = 1;
	
	ДанныеНоменклатуры = ПолучитьИзВременногоХранилища(АдресДанныхНоменклатуры);
	
	Если ДанныеНоменклатуры.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Ошибка передачи данных номенклатуры'");
	КонецЕсли;
			
	СтрокиПоИдентификатору = ДанныеНоменклатуры.
		НайтиСтроки(Новый Структура("Идентификатор", ИдентификаторНоменклатуры));
		
	Если СтрокиПоИдентификатору.Количество() > 0 Тогда
		ТекущаяНоменклатура = СтрокиПоИдентификатору[0];
	КонецЕсли;	
		
	ВывестиРеквизитыХарактеристик(ТекущаяНоменклатура.Категория.Идентификатор);
	
	НастроитьФормуПриСоздании();
	
	НастроитьФормуПриДлительнойОперации(Истина, "Заполнение");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПолучитьХарактеристикиСервиса();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыХарактеристики

&НаКлиенте
Процедура ХарактеристикиПометкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Характеристики.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	ДобавитьУдалитьИдентификаторХарактеристики(ТекущиеДанные.ИдентификаторХарактеристики, ТекущиеДанные.Пометка);
	
	ОбновитьКоличествоВыбранных(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОтборХарактеристик

&НаКлиенте
Процедура ОтборХарактеристикПометкаПриИзменении(Элемент)
	
	ПолучитьХарактеристикиСервиса(ПараметрыОтбора());
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборХарактеристикЗначениеРеквизитаПриИзменении(Элемент)
	
	ИзменитьЗначениеПометкиРеквизита(Истина);
	
	ПолучитьХарактеристикиСервиса(ПараметрыОтбора());
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборХарактеристикЗначениеРеквизитаДополнительноеПриИзменении(Элемент)
	
	ИзменитьЗначениеПометкиРеквизита(Истина);
	
	ПолучитьХарактеристикиСервиса(ПараметрыОтбора());
	
КонецПроцедуры	

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	ИзменитьФлажки(Истина);
	
	ОбновитьКоличествоВыбранных(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	
	ИзменитьФлажки(Ложь);
	
	ОбновитьКоличествоВыбранных(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОтборыНажатие(Элемент)
	
	Элементы.ОтборХарактеристик.Видимость = Не Элементы.ОтборХарактеристик.Видимость;
	
	Если Элементы.ОтборХарактеристик.Видимость Тогда
		Элементы.ПоказатьОтборы.Заголовок = НСтр("ru = 'Скрыть отборы'");
	Иначе
		Элементы.ПоказатьОтборы.Заголовок = НСтр("ru = 'Показать отборы'");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Выбрать(Команда)
	
	Закрыть(
		ИдентификаторыХарактеристик(ЭтотОбъект.ВладелецФормы.УникальныйИдентификатор));
	
КонецПроцедуры

&НаКлиенте
Процедура ТолькоВыбранные(Команда)
	
	Элементы.ХарактеристикиТолькоВыбранные.Пометка = Не Элементы.ХарактеристикиТолькоВыбранные.Пометка;
	
	Если Элементы.ХарактеристикиТолькоВыбранные.Пометка Тогда
		ОтборСтрок = Новый ФиксированнаяСтруктура(Новый Структура("Пометка", Истина));
		Элементы.Характеристики.ОтборСтрок = ОтборСтрок;
	Иначе
		Элементы.Характеристики.ОтборСтрок = Неопределено;	
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура НастроитьФормуПриДлительнойОперации(ЭтоНачалоДлительнойОперации, Режим)
	
	Элементы.Характеристики.Доступность                  = Не ЭтоНачалоДлительнойОперации;
	Элементы.Выбрать.Доступность                         = Не ЭтоНачалоДлительнойОперации;
	Элементы.ПоказатьОтборы.Доступность                  = Не ЭтоНачалоДлительнойОперации;
	
	Если Режим = "Заполнение" Тогда
		Если ЭтоНачалоДлительнойОперации Тогда
			Элементы.ГруппаСтраницДлительнойОперации.ТекущаяСтраница = Элементы.СтраницаДлительнойОперации;
		Иначе
			Элементы.ГруппаСтраницДлительнойОперации.ТекущаяСтраница = Элементы.СтраницаДанных;
		КонецЕсли;
	ИначеЕсли Режим = "Подгрузка" Тогда	
		Элементы.ГруппаДекорацииДлительнойОперации.Видимость = ЭтоНачалоДлительнойОперации;
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьЗначениеПометкиРеквизита(Пометка)
	
	ТекущиеДанные = Элементы.ОтборХарактеристик.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	Если ЗначениеЗаполнено(ТекущиеДанные.ЗначениеРеквизита)
		ИЛИ ЗначениеЗаполнено(ТекущиеДанные.ЗначениеРеквизитаДополнительное) Тогда
		
		ТекущиеДанные.Пометка = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьХарактеристикиСервиса(ПараметрыОтбора = Неопределено, ЭтоЗапросПорцииДанных = Ложь)
	
	НастроитьФормуПриДлительнойОперации(Истина, "Подгрузка");
	
	Если Не ЭтоЗапросПорцииДанных Тогда
		НомерСтраницыДанных = 1;	
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ПолучитьХарактеристикиЗавершение", ЭтотОбъект, 
		Новый Структура("ЭтоЗапросПорцииДанных", ЭтоЗапросПорцииДанных));
	
	ПараметрыМетода = РаботаСНоменклатуройСлужебныйКлиентСервер.ПараметрыЗапросаХарактеристик();
	
	ПараметрыМетода.Вставить("ИдентификаторНоменклатуры",  ИдентификаторНоменклатуры);
	ПараметрыМетода.Вставить("НаборПолей",                 "Минимальный");
	ПараметрыМетода.Вставить("ЗаполнитьПризнакЗагрузки",   Истина);
	ПараметрыМетода.Вставить("НомерСтраницыДанных",        НомерСтраницыДанных);
	ПараметрыМетода.Вставить("ИсключитьЗагруженные",       Не ЭтоРежимПросмотра);
	
	Если ПараметрыОтбора <> Неопределено Тогда
		ПараметрыМетода.Вставить("РеквизитыХарактеристик", ПараметрыОтбора);
	КонецЕсли; 
	
	РаботаСНоменклатуройКлиент.ПолучитьДанныеХарактеристикСервиса(
		Оповещение, 
		ПараметрыМетода, 
		ЭтотОбъект, 
		Неопределено, 
		Элементы.ГруппаДекорацииДлительнойОперации);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьХарактеристикиЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	ВывестиХарактеристики(Результат.АдресРезультата, ДополнительныеПараметры);
	
КонецПроцедуры

&НаСервере
Процедура ВывестиХарактеристики(АдресДанных, ДополнительныеПараметры);

	НастроитьФормуПриДлительнойОперации(Ложь, "Заполнение");
	НастроитьФормуПриДлительнойОперации(Ложь, "Подгрузка");
	
	Если Не ДополнительныеПараметры.ЭтоЗапросПорцииДанных Тогда
		Характеристики.Очистить();
	КонецЕсли;
	
	Если ЭтоАдресВременногоХранилища(АдресДанных) Тогда
		ДанныеПоХарактеристикам = ПолучитьИзВременногоХранилища(АдресДанных);
	Иначе
		Возврат;	
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ДанныеПоХарактеристикам) Тогда
		Возврат;
	КонецЕсли;
	
	Для каждого ЭлементКоллекции Из ДанныеПоХарактеристикам Цикл
		
		НоваяСтрока = Характеристики.Добавить();
		
		НоваяСтрока.ПредставлениеХарактеристики = ЭлементКоллекции.Наименование;
		НоваяСтрока.ИдентификаторХарактеристики = ЭлементКоллекции.Идентификатор;
		
		Если ЗначениеЗаполнено(ИдентификаторыВыбранныхХарактеристик) Тогда
			Если ИдентификаторыВыбранныхХарактеристик.НайтиПоЗначению(ЭлементКоллекции.Идентификатор) <> Неопределено Тогда
				НоваяСтрока.Пометка = Истина;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Если ДанныеПоХарактеристикам.Количество() = РаботаСНоменклатурой.РазмерПорцииДанныхХарактеристик() Тогда
		ДобавитьСтрокуЗапросаДанных();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ИдентификаторыХарактеристик(УникальныйИдентификатор)
	
	Возврат Новый Структура("АдресВыбранныхХарактеристик, КоличествоВыбранныхХарактеристик, ИдентификаторыВыбранныхХарактеристик",
		ПоместитьВоВременноеХранилище(ИдентификаторыВыбранныхХарактеристик.ВыгрузитьЗначения(), 
			УникальныйИдентификатор), 
		ИдентификаторыВыбранныхХарактеристик.Количество(),
		ИдентификаторыВыбранныхХарактеристик.ВыгрузитьЗначения());
	
КонецФункции

&НаСервере
Процедура ВывестиРеквизитыХарактеристик(ИдентификаторКатегории)
	
	ДанныеКатегорийСервиса = РаботаСНоменклатурой.ДанныеКатегорийСервиса(ИдентификаторКатегории);
	
	Если Не ЗначениеЗаполнено(ДанныеКатегорийСервиса) Тогда
		ВызватьИсключение НСтр("ru = 'Ошибка получения данных категории'");
	КонецЕсли;
	
	Для каждого ТекущийРеквизит Из ДанныеКатегорийСервиса[0].Характеристики.ДополнительныеРеквизиты Цикл
		
		НовыйРеквизит = ОтборХарактеристик.Добавить();
		
		НовыйРеквизит.ПредставлениеРеквизита = ТекущийРеквизит.Наименование;
		НовыйРеквизит.Тип                    = ТекущийРеквизит.Тип;
		НовыйРеквизит.Идентификатор          = ТекущийРеквизит.Идентификатор;
		
		Если ТекущийРеквизит.Тип = "Список" Тогда
			НовыйРеквизит.ЗначениеРеквизита      = "";
			НовыйРеквизит.ВидСравнения = НСтр("ru = 'В списке'");
			
			// Заполнение значений реквизита.
			
			Для каждого ТекущееЗначения Из ТекущийРеквизит.Значения Цикл
				НоваяСтрока = ЗначенияРеквизитов.Добавить();
				НоваяСтрока.ИдентификаторРеквизита = ТекущийРеквизит.Идентификатор;
				НоваяСтрока.ИдентификаторЗначения  = ТекущееЗначения.Идентификатор;
				НоваяСтрока.ПредставлениеЗначения  = ТекущееЗначения.Наименование;
			КонецЦикла;
			
		ИначеЕсли ТекущийРеквизит.Тип = "Число" Тогда	
			НовыйРеквизит.ЗначениеРеквизита               = 0;
			НовыйРеквизит.ЗначениеРеквизитаДополнительное = 0;
			НовыйРеквизит.ВидСравнения                    = НСтр("ru = 'Между'");
		ИначеЕсли ТекущийРеквизит.Тип = "Строка" Тогда	
			НовыйРеквизит.ЗначениеРеквизита = "";
			НовыйРеквизит.ВидСравнения      = НСтр("ru = 'Содержит'");
		ИначеЕсли ТекущийРеквизит.Тип = "Дата" Тогда	
			НовыйРеквизит.ЗначениеРеквизита = Дата(1, 1,1);
			НовыйРеквизит.ВидСравнения      = НСтр("ru = 'Равно'");
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьСтрокуЗапросаДанных()
	
	НоваяСтрока = Характеристики.Добавить();
	
	НоваяСтрока.ЭтоСтрокаЗапросаДанных = Истина;
	
	ИдентификаторСтрокиЗагрузкиДанных = НоваяСтрока.ПолучитьИдентификатор();
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьФлажки(ЗначениеФлажка)
	
	Для каждого ЭлементКоллекции Из Характеристики Цикл
		ЭлементКоллекции.Пометка = ЗначениеФлажка;
		ДобавитьУдалитьИдентификаторХарактеристики(ЭлементКоллекции.ИдентификаторХарактеристики, ЗначениеФлажка);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьКоличествоВыбранных(Форма)
		
	Форма.ВыбраноХарактеристик = Форма.ИдентификаторыВыбранныхХарактеристик.Количество();	
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПриСоздании()
		
	Элементы.ГруппаДекорацииДлительнойОперации.Видимость = Ложь;
	Элементы.ОтборХарактеристик.Видимость                = Ложь;
	Элементы.ХарактеристикиТолькоВыбранные.Видимость     = Не ЭтоРежимПросмотра;
	Элементы.ХарактеристикиПометка.Видимость             = Не ЭтоРежимПросмотра;
	Элементы.УстановитьФлажки.Видимость                  = Не ЭтоРежимПросмотра;
	Элементы.СнятьФлажки.Видимость                       = Не ЭтоРежимПросмотра;
	Элементы.ЗаголовокВыбраноХарактеристик.Видимость     = Не ЭтоРежимПросмотра;
	Элементы.ВыбраноХарактеристик.Видимость              = Не ЭтоРежимПросмотра;
	
	Если ЭтоРежимПросмотра Тогда
		Элементы.Выбрать.Заголовок = НСтр("ru = 'Закрыть'");
		Заголовок = НСтр("ru = 'Характеристики номенклатуры'")
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьУдалитьИдентификаторХарактеристики(Идентификатор, Пометка)
	
	СтрокаДанных = ИдентификаторыВыбранныхХарактеристик.НайтиПоЗначению(Идентификатор);	
	
	Если Пометка Тогда
		Если СтрокаДанных = Неопределено Тогда
			ИдентификаторыВыбранныхХарактеристик.Добавить(Идентификатор);
		КонецЕсли;
	Иначе
		Если СтрокаДанных <> Неопределено Тогда
			ИдентификаторыВыбранныхХарактеристик.Удалить(СтрокаДанных);
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	// Видимость колонки Ложь
	
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);	
	
	// Отбор
	
	ОтборЭлемента = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ОтборЭлемента.ЛевоеЗначение   = Новый ПолеКомпоновкиДанных("ОтборХарактеристик.Тип");
	ОтборЭлемента.ВидСравнения    = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение  = "Число";
	
	// Оформляемое поле
	
	ПолеЭлемента = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОтборХарактеристикЗначениеРеквизитаДополнительное.Имя);
	
	// Видимость колонки Истина
	
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Видимость", Истина);	
	
	// Отбор
	
	ОтборЭлемента = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ОтборЭлемента.ЛевоеЗначение   = Новый ПолеКомпоновкиДанных("ОтборХарактеристик.Тип");
	ОтборЭлемента.ВидСравнения    = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение  = "Число";
	
	// Оформляемое поле
	
	ПолеЭлемента = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОтборХарактеристикЗначениеРеквизитаДополнительное.Имя);
	
	// Представление нулей для числовых типов
	
	НастроитьПредставлениеНулей();
	
	// Гиперссылка запроса данных.
	
	РаботаСНоменклатурой.УсловноеОформлениеГиперссылкиЗапросаДанных(ЭтотОбъект, "Характеристики");
		
КонецПроцедуры

&НаСервере
Процедура НастроитьПредставлениеНулей()
	
	// Минимальное значение
	
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Текст", "От");	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);	
	
	// Отбор
	
	ГруппаЭлементовОтбораДанных = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаЭлементовОтбораДанных.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ;
	ГруппаЭлементовОтбораДанных.Использование = Истина;
	
	ОтборЭлемента = ГруппаЭлементовОтбораДанных.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ОтборЭлемента.ЛевоеЗначение   = Новый ПолеКомпоновкиДанных("ОтборХарактеристик.Тип");
	ОтборЭлемента.ВидСравнения    = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение  = "Число";
	
	ОтборЭлемента = ГруппаЭлементовОтбораДанных.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ОтборЭлемента.ЛевоеЗначение   = Новый ПолеКомпоновкиДанных("ОтборХарактеристик.ЗначениеРеквизита");
	ОтборЭлемента.ВидСравнения    = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение  = 0;
		
	// Оформляемое поле
	
	ПолеЭлемента = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОтборХарактеристикЗначениеРеквизита.Имя);
	
	// Максимальное значение
	
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Текст", "До");	
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);	
	
	// Отбор
	
	ГруппаЭлементовОтбораДанных = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаЭлементовОтбораДанных.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ;
	ГруппаЭлементовОтбораДанных.Использование = Истина;
	
	ОтборЭлемента = ГруппаЭлементовОтбораДанных.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ОтборЭлемента.ЛевоеЗначение   = Новый ПолеКомпоновкиДанных("ОтборХарактеристик.Тип");
	ОтборЭлемента.ВидСравнения    = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение  = "Число";
	
	ОтборЭлемента = ГруппаЭлементовОтбораДанных.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	
	ОтборЭлемента.ЛевоеЗначение   = Новый ПолеКомпоновкиДанных("ОтборХарактеристик.ЗначениеРеквизитаДополнительное");
	ОтборЭлемента.ВидСравнения    = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение  = 0;
		
	// Оформляемое поле
	
	ПолеЭлемента = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
	
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОтборХарактеристикЗначениеРеквизитаДополнительное.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборХарактеристикПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.ОтборХарактеристик.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	Элементы.ОтборХарактеристикЗначениеРеквизита.КнопкаВыбора = ТекущиеДанные.Тип = "Список";
		
КонецПроцедуры

&НаКлиенте
Процедура ОтборХарактеристикЗначениеРеквизитаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекущиеДанные = Элементы.ОтборХарактеристик.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	ЗначенияТекущегоРеквизита = ЗначенияРеквизитов.НайтиСтроки(
		Новый Структура("ИдентификаторРеквизита", ТекущиеДанные.Идентификатор));
		
	Значения = Новый СписокЗначений;	
	
	Для каждого ЭлементКоллекции Из ЗначенияТекущегоРеквизита Цикл
		Значения.Добавить(ЭлементКоллекции.ИдентификаторЗначения, 
			ЭлементКоллекции.ПредставлениеЗначения, ЭлементКоллекции.Пометка);	
	КонецЦикла;
	
	Оповещение = Новый ОписаниеОповещения("ПослеВыбораЗначений", ЭтотОбъект, 
		Новый Структура("ТекущаяСтрока", Элементы.ОтборХарактеристик.ТекущаяСтрока));	
	
	ОткрытьФорму("Обработка.РаботаСНоменклатурой.Форма.ВыборЗначений", Новый Структура("ЗначенияДляВыбора", Значения), ЭтотОбъект,,,,Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораЗначений(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат.ВыбранныеЗначения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаДанных = ОтборХарактеристик.НайтиПоИдентификатору(ДополнительныеПараметры.ТекущаяСтрока);
	
	СтрокаДанных.Пометка = Истина;
	
	СтрокаДанных.ЗначениеРеквизита = Строка(Результат.ВыбранныеЗначения);
	
	ЗначенияРеквизита = ЗначенияРеквизитов.НайтиСтроки(
		Новый Структура("ИдентификаторРеквизита", СтрокаДанных.Идентификатор));
	
	Для каждого ЭлементКоллекции Из ЗначенияРеквизита Цикл
		Если Результат.ВыбранныеЗначения.НайтиПоЗначению(ЭлементКоллекции.ИдентификаторЗначения) <> Неопределено Тогда
			ЭлементКоллекции.Пометка = Истина;
		Иначе
			ЭлементКоллекции.Пометка = Ложь;
		КонецЕсли;
	КонецЦикла;
	
	ПолучитьХарактеристикиСервиса(ПараметрыОтбора());
	
КонецПроцедуры

&НаСервере
Функция ПараметрыОтбора()
	
	Результат = Новый Массив;
	
	Для каждого ЭлементКоллекции Из ОтборХарактеристик Цикл
		
		Если Не ЭлементКоллекции.Пометка Тогда
			Продолжить;
		КонецЕсли;
		
		Если ЭлементКоллекции.Тип = "Список" Тогда
			
			ЗначенияТекущегоРеквизита = ЗначенияРеквизитов.НайтиСтроки(
				Новый Структура("ИдентификаторРеквизита", ЭлементКоллекции.Идентификатор));
				
			Значения = Новый Массив;	
						
			Для каждого ТекущееЗначение Из ЗначенияТекущегоРеквизита Цикл
				Если ТекущееЗначение.Пометка Тогда
					Значения.Добавить(ТекущееЗначение.ИдентификаторЗначения);	
				КонецЕсли;
			КонецЦикла;
			
			Если Не ЗначениеЗаполнено(Значения) Тогда
				Продолжить;
			КонецЕсли;
			
			Результат.Добавить(
				Новый Структура("Идентификатор, ИдентификаторыЗначений", 
					ЭлементКоллекции.Идентификатор, Значения));
		ИначеЕсли ЭлементКоллекции.Тип = "Число" Тогда
			
			Если Не ЗначениеЗаполнено(ЭлементКоллекции.ЗначениеРеквизита) 
				И Не ЗначениеЗаполнено(ЭлементКоллекции.ЗначениеРеквизитаДополнительное) Тогда
				
				Продолжить;
			КонецЕсли;
			
			Результат.Добавить(
				Новый Структура("Идентификатор, МинимальноеЗначение, МаксимальноеЗначение", 
					ЭлементКоллекции.Идентификатор, ЭлементКоллекции.ЗначениеРеквизита, ЭлементКоллекции.ЗначениеРеквизитаДополнительное));
		Иначе
			
			Если Не ЗначениеЗаполнено(ЭлементКоллекции.ЗначениеРеквизита) Тогда
				Продолжить;
			КонецЕсли;
			
			Результат.Добавить(
				Новый Структура("Идентификатор, Значение", 
					ЭлементКоллекции.Идентификатор, ЭлементКоллекции.ЗначениеРеквизита));
		КонецЕсли;
				
	КонецЦикла;
	
	Возврат Результат;
		
КонецФункции

&НаКлиенте
Процедура ХарактеристикиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле = Элементы.ХарактеристикиГиперссылкаЗапросаДанных Тогда	
		
		// Догрузка данных.
		
		СтандартнаяОбработка = Ложь;
		
		НомерСтраницыДанных = НомерСтраницыДанных + 1;
		
		Элементы.Характеристики.ТекущаяСтрока = ИдентификаторСтрокиЗагрузкиДанных - 1;
		
		СтрокаДанных = Характеристики.НайтиПоИдентификатору(ИдентификаторСтрокиЗагрузкиДанных);
		
		Если СтрокаДанных <> Неопределено Тогда
			Характеристики.Удалить(СтрокаДанных);
		КонецЕсли;
		
		ПолучитьХарактеристикиСервиса(ПараметрыОтбора(), Истина);
		
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти