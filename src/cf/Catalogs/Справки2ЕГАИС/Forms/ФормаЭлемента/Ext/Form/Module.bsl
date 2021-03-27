﻿
&НаКлиенте
Перем КэшированныеЗначения; //используется механизмом обработки изменения реквизитов ТЧ

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриСозданииЧтенииНаСервере();
	КонецЕсли;
	
	РежимОтладки = ОбщегоНазначения.РежимОтладки();
	
	Элементы.РегистрационныйНомер.ТолькоПросмотр = Не РежимОтладки;
	Элементы.АлкогольнаяПродукция.ТолькоПросмотр = Не РежимОтладки;
	Элементы.НомерСправки1.ТолькоПросмотр        = Не РежимОтладки;
	Элементы.Справка1.ТолькоПросмотр             = Не РежимОтладки;
	Элементы.Количество.ТолькоПросмотр           = Не РежимОтладки;
	
	СобытияФормИСПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// ПодключаемоеОборудование
	МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПриОткрытииФормы(Неопределено, ЭтаФорма, "СканерШтрихкода");
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	// ПодключаемоеОборудование
	МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПриЗакрытииФормы(Неопределено, ЭтаФорма);
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	СобытияФормИСКлиентПереопределяемый.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриСозданииЧтенииНаСервере();
	
	СобытияФормИСПереопределяемый.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	СобытияФормИСКлиентПереопределяемый.ПередЗаписью(ЭтотОбъект, Отказ, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ВнешнееСобытие(Источник, Событие, Данные)
	
	ОповещениеПриЗавершении = Новый ОписаниеОповещения("ПоискПоШтрихкодуЗавершение", ЭтотОбъект);
	
	СобытияФормИСКлиент.ВнешнееСобытиеПолученыШтрихкоды(
		ОповещениеПриЗавершении, ЭтотОбъект, Источник, Событие, Данные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗапроситьСправку1(Команда)
	
	ОчиститьСообщения();
	
	Справка1 = Справка1ПоРегистрационномуНомеру();
	Если ЗначениеЗаполнено(Справка1) Тогда
		
		Объект.Справка1 = Справка1;
		
		УправлениеДоступностью(ЭтотОбъект);
		
	Иначе
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Операция",          ПредопределенноеЗначение("Перечисление.ВидыДокументовЕГАИС.ЗапросСправки1"));
		ПараметрыФормы.Вставить("ЗначениеПараметра", Объект.НомерСправки1);
		
		ОткрытьФорму(
			"ОбщаяФорма.ФормированиеИсходящегоЗапросаЕГАИС",
			ПараметрыФормы,
			ЭтотОбъект,,,,Новый ОписаниеОповещения("ПослеВыполненияЗапросаСправки1", ЭтотОбъект),
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормИСКлиентПереопределяемый.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоискПоШтрихкодуВыполнить(Команда)
	
	ОчиститьСообщения();
	
	ШтрихкодированиеИСКлиентПереопределяемый.ПоказатьВводШтрихкода(
		Новый ОписаниеОповещения("ОбработатьВводШтрихкода", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьДанныеИзТСД(Команда)
	
	ОчиститьСообщения();
	
	МенеджерОборудованияКлиент.НачатьЗагрузкуДанныеИзТСД(
		Новый ОписаниеОповещения("ЗагрузитьИзТСДЗавершение", ЭтотОбъект),
		УникальныйИдентификатор);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ДиапазоныНомеровАкцизныхМарокТипМаркиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура;
	
	ТекущиеДанные = Элементы.ДиапазоныНомеровАкцизныхМарок.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ПараметрыФормы.Вставить("ТипМарки", ТекущиеДанные.ТипМарки);
	КонецЕсли;
	
	ОткрытьФорму("ОбщаяФорма.ФормаВыбораТипаАкцизнойМаркиЕГАИС", ПараметрыФормы, Элемент,,,,, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ДиапазоныНомеровАкцизныхМарокТипМаркиОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	Если ПустаяСтрока(Текст) Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ДанныеВыбора = АкцизныеМаркиВызовСервера.ДанныеВыбораТипаМарки(Текст);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриСозданииЧтенииНаСервере()
	
	ИнтеграцияИСПереопределяемый.НастроитьПодключаемоеОборудование(ЭтаФорма);
	
	УправлениеДоступностью(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеДоступностью(Форма)
	
	Форма.Элементы.ГруппаСправка1.Видимость = ЗначениеЗаполнено(Форма.Объект.Справка1);
	
	Форма.Элементы.ГруппаНомерСправки1.Видимость = Не ЗначениеЗаполнено(Форма.Объект.Справка1);
	
	Если Форма.Элементы.ГруппаНомерСправки1.Видимость Тогда
		Форма.Элементы.ЗапроситьСправку1.Видимость = Не Форма.ТолькоПросмотр;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыполненияЗапросаСправки1(Результат, ДополнительныеПараметры) Экспорт
	
	Прочитать();
	
КонецПроцедуры

&НаСервере
Функция Справка1ПоРегистрационномуНомеру()
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ Первые 1
	|	Справки1ЕГАИС.Ссылка
	|ИЗ
	|	Справочник.Справки1ЕГАИС КАК Справки1ЕГАИС
	|ГДЕ
	|	Справки1ЕГАИС.РегистрационныйНомер = &РегистрационныйНомер");
	
	Запрос.УстановитьПараметр("РегистрационныйНомер", Объект.НомерСправки1);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		
		Справка1 = Выборка.Ссылка;
		
	Иначе
		
		Справка1 = Неопределено;
		
	КонецЕсли;
	
	Возврат Справка1;
	
КонецФункции

#Область Штрихкоды

&НаКлиенте
Процедура ПоискПоШтрихкодуЗавершение(ДанныеШтрихкода, ДополнительныеПараметры) Экспорт
	
	Если ДанныеШтрихкода = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РезультатОбработки = Новый Структура;
	РезультатОбработки.Вставить("НовыеДиапазоны"       , Новый Массив);
	РезультатОбработки.Вставить("НайденныеДиапазоны"   , Новый Массив);
	РезультатОбработки.Вставить("НекорректныеШтрихкоды", Новый Массив);
	
	Если ДанныеШтрихкода.ТипШтрихкода = ПредопределенноеЗначение("Перечисление.ТипыШтрихкодов.DataMatrix") Тогда
		
		СтруктураШтрихкода = Новый Структура;
		СтруктураШтрихкода.Вставить("ТипМарки"  , ДанныеШтрихкода.ТипМарки);
		СтруктураШтрихкода.Вставить("СерияМарки", ДанныеШтрихкода.СерияМарки);
		СтруктураШтрихкода.Вставить("НомерМарки", ДанныеШтрихкода.НомерМарки);
		
		ОбработатьШтрихкод(РезультатОбработки, ДанныеШтрихкода.Штрихкод, СтруктураШтрихкода, ДанныеШтрихкода.ТекстОшибки);
		
	Иначе
		
		ОбработатьШтрихкод(
			РезультатОбработки,
			ДанныеШтрихкода.Штрихкод,
			Неопределено,
			СтрШаблон(
				НСтр("ru = 'Штрихкод %1 не является кодом Data Matrix.
					       |Для проверки вхождения номера марки в диапазон отсканируйте штрихкод формата Data Matrix'"),
				ДанныеШтрихкода.Штрихкод));
		
	КонецЕсли;
	
	ПослеОбработкиМассиваШтрихкодов(РезультатОбработки);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВводШтрихкода(ДанныеШтрихкода, ДополнительныеПараметры) Экспорт
	
	ПараметрыСканирования = ШтрихкодированиеИСКлиент.ПараметрыСканирования(ЭтотОбъект);
	ПараметрыСканирования.ЗапрашиватьНоменклатуру = Ложь;
	
	ШтрихкодированиеИСКлиент.ОбработатьДанныеШтрихкода(
		Новый ОписаниеОповещения("ПоискПоШтрихкодуЗавершение", ЭтотОбъект),
		ЭтотОбъект, ДанныеШтрихкода, ПараметрыСканирования);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзТСДЗавершение(РезультатВыполнения, ДополнительныеПараметры) Экспорт
	
	СобытияФормЕГАИСКлиентПереопределяемый.ПриПолученииДанныхИзТСД(
		Новый ОписаниеОповещения("Подключаемый_ПолученыДанныеИзТСД", ЭтотОбъект),
		ЭтотОбъект, РезультатВыполнения);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьМассивШтрихкодов(ДанныеШтрихкодов)
	
	РезультатОбработки = Новый Структура;
	РезультатОбработки.Вставить("НовыеДиапазоны"       , Новый Массив);
	РезультатОбработки.Вставить("НайденныеДиапазоны"   , Новый Массив);
	РезультатОбработки.Вставить("НекорректныеШтрихкоды", Новый Массив);
	
	Для Каждого ДанныеШтрихкода Из ДанныеШтрихкодов Цикл
		
		ТекстОшибки = "";
		СтруктураШтрихкода = АкцизныеМаркиКлиентСервер.РазложитьШтрихкодСНомеромИСерией(ДанныеШтрихкода.Штрихкод, ТекстОшибки);
		
		ОбработатьШтрихкод(РезультатОбработки, ДанныеШтрихкода.Штрихкод, СтруктураШтрихкода, ТекстОшибки);
		
	КонецЦикла;
	
	ПослеОбработкиМассиваШтрихкодов(РезультатОбработки);
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьШтрихкод(РезультатОбработки, Штрихкод, СтруктураШтрихкода, ТекстОшибки)
	
	Если НЕ ПустаяСтрока(ТекстОшибки) Тогда
		НекорректныйШтрихкод = Новый Структура;
		НекорректныйШтрихкод.Вставить("Штрихкод", Штрихкод);
		НекорректныйШтрихкод.Вставить("ТекстОшибки", ТекстОшибки);
		
		РезультатОбработки.НекорректныеШтрихкоды.Добавить(НекорректныйШтрихкод);
	Иначе
		
		НомерМарки = СтроковыеФункцииКлиентСервер.СтрокаВЧисло(СтруктураШтрихкода.НомерМарки);
		
		ПараметрыОтбора = Новый Структура;
		ПараметрыОтбора.Вставить("ТипМарки", СтруктураШтрихкода.ТипМарки);
		ПараметрыОтбора.Вставить("СерияМарки", СтруктураШтрихкода.СерияМарки);
		
		ДиапазонНайден = Ложь;
		
		МассивСтрок = Объект.ДиапазоныНомеровАкцизныхМарок.НайтиСтроки(ПараметрыОтбора);
		Для Каждого СтрокаДиапазона Из МассивСтрок Цикл
			НачальныйНомер = СтроковыеФункцииКлиентСервер.СтрокаВЧисло(СтрокаДиапазона.НачальныйНомер);
			КонечныйНомер = СтроковыеФункцииКлиентСервер.СтрокаВЧисло(СтрокаДиапазона.КонечныйНомер);
			
			Если НомерМарки >= НачальныйНомер И НомерМарки <= КонечныйНомер Тогда
				Если РезультатОбработки.НайденныеДиапазоны.Найти(СтрокаДиапазона.ПолучитьИдентификатор()) = Неопределено Тогда
					РезультатОбработки.НайденныеДиапазоны.Добавить(СтрокаДиапазона.ПолучитьИдентификатор());
				КонецЕсли;
				
				ДиапазонНайден = Истина;
			КонецЕсли;
		КонецЦикла;
		
		Если НЕ ДиапазонНайден Тогда
			РезультатОбработки.НовыеДиапазоны.Добавить(СтруктураШтрихкода);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОбработкиМассиваШтрихкодов(РезультатОбработки)
	
	Если РезультатОбработки.НайденныеДиапазоны.Количество() > 0 Тогда
		Элементы.ДиапазоныНомеровАкцизныхМарок.ВыделенныеСтроки.Очистить();
		
		Для Каждого ИдентификаторСтроки Из РезультатОбработки.НайденныеДиапазоны Цикл
			Элементы.ДиапазоныНомеровАкцизныхМарок.ВыделенныеСтроки.Добавить(ИдентификаторСтроки);
		КонецЦикла;
	КонецЕсли;
	
	Если РезультатОбработки.НекорректныеШтрихкоды.Количество() > 0 Тогда
		ОчиститьСообщения();
		
		Для Каждого НекорректныйШтрихкод Из РезультатОбработки.НекорректныеШтрихкоды Цикл
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НекорректныйШтрихкод.ТекстОшибки);
		КонецЦикла;
	КонецЕсли;
	
	Если РезультатОбработки.НовыеДиапазоны.Количество() > 0 Тогда
		
		ТекстСообщения = НСтр("ru='Считанный штрихкод не входит ни в один из диапазонов справки 2.'");
		
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить(КодВозвратаДиалога.Да, НСтр("ru='Добавить диапазон'"));
		Кнопки.Добавить(КодВозвратаДиалога.Отмена);
		
		ПоказатьВопрос(Новый ОписаниеОповещения("ДобавитьДиапазоны_Подтверждение", ЭтотОбъект, РезультатОбработки), ТекстСообщения, Кнопки);
	КонецЕсли;

	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолученыДанныеИзТСД(ТаблицаТоваров, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(ТаблицаТоваров) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	ОбработатьМассивШтрихкодов(ТаблицаТоваров);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьДиапазоны_Подтверждение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Модифицированность = Истина;
	
	Для Каждого СтруктураШтрихкода Из ДополнительныеПараметры.НовыеДиапазоны Цикл
		
		СтрокаДиапазона = Объект.ДиапазоныНомеровАкцизныхМарок.Добавить();
		СтрокаДиапазона.ТипМарки       = СтруктураШтрихкода.ТипМарки;
		СтрокаДиапазона.СерияМарки     = СтруктураШтрихкода.СерияМарки;
		СтрокаДиапазона.НачальныйНомер = СтруктураШтрихкода.НомерМарки;
		СтрокаДиапазона.КонечныйНомер  = СтруктураШтрихкода.НомерМарки;
		
	КонецЦикла;
	
	ИдентификаторСтроки = Объект.ДиапазоныНомеровАкцизныхМарок[Объект.ДиапазоныНомеровАкцизныхМарок.Количество() - 1].ПолучитьИдентификатор();
	
	Элементы.ДиапазоныНомеровАкцизныхМарок.ВыделенныеСтроки.Очистить();
	
	Элементы.ДиапазоныНомеровАкцизныхМарок.ВыделенныеСтроки.Добавить(ИдентификаторСтроки);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
