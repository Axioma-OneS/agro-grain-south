﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("ТипОбъектаДО", ТипОбъектаДО);
	Параметры.Свойство("ТипОбъектаИС", ТипОбъектаИС);
	Параметры.Свойство("Вариант", Вариант);
	Параметры.Свойство("ПредставлениеРеквизитаОбъектаИС", ПредставлениеРеквизитаОбъектаИС);
	Параметры.Свойство("ИмяРеквизитаОбъектаДО", ИмяРеквизитаОбъектаДО);
	Параметры.Свойство("ПредставлениеРеквизитаОбъектаДО", ПредставлениеРеквизитаОбъектаДО);
	Параметры.Свойство("ВычисляемоеВыражение", ВычисляемоеВыражение);
	Параметры.Свойство("РеквизитыОбъектаДО", РеквизитыОбъектаДО);
	Параметры.Свойство("Обновлять", Обновлять);
	Параметры.Свойство("РежимИзмененияДанныхПроведенногоДокумента", РежимИзмененияДанныхПроведенногоДокумента);
	Если Не ЗначениеЗаполнено(РежимИзмененияДанныхПроведенногоДокумента) Тогда
		РежимИзмененияДанныхПроведенногоДокумента = 
			Перечисления.РежимИзмененияПроведенногоДокументаДанными1СДокументооборота.Запрещено;
	КонецЕсли;
	
	РеквизитОбъекта = ПредопределенноеЗначение("Перечисление.ВариантыПравилЗаполненияРеквизитов.РеквизитОбъекта");
	ВыражениеНаВстроенномЯзыке = ПредопределенноеЗначение("Перечисление.ВариантыПравилЗаполненияРеквизитов.ВыражениеНаВстроенномЯзыке");
	НеЗаполнять = ПредопределенноеЗначение("Перечисление.ВариантыПравилЗаполненияРеквизитов.ПустаяСсылка");
	
	// Выберем вариант по умолчанию.
	НетТаблиц = Истина;
	Для Каждого РеквизитОбъектаДО Из РеквизитыОбъектаДО Цикл
		Если РеквизитОбъектаДО.ЭтоТаблица Тогда
			НетТаблиц = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Если НетТаблиц Тогда
		Элементы.ПредставлениеРеквизитаОбъектаДО.Видимость = Ложь;
		Элементы.Вариант.СписокВыбора.Удалить(0);
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Вариант) Тогда
		Вариант = ?(НетТаблиц, НеЗаполнять, РеквизитОбъекта);
	КонецЕсли;
	
	СокращенноеНаименованиеКонфигурации = ИнтеграцияС1СДокументооборот.СокращенноеНаименованиеКонфигурации();
	Если ЗначениеЗаполнено(СокращенноеНаименованиеКонфигурации) Тогда
		Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Правило заполнения таблицы %1'"), СокращенноеНаименованиеКонфигурации);
	КонецЕсли;
	
	Элементы.РежимИзмененияДанныхПроведенногоДокумента.Видимость = Параметры.ЗаполняетсяДокумент;
	
	// Установим доступные режимы изменения в проведенном документе.
	Элементы.РежимИзмененияДанныхПроведенногоДокумента.СписокВыбора.Добавить(
		Перечисления.РежимИзмененияПроведенногоДокументаДанными1СДокументооборота.РазрешеноСПерепроведением);
	Элементы.РежимИзмененияДанныхПроведенногоДокумента.СписокВыбора.Добавить(
		Перечисления.РежимИзмененияПроведенногоДокументаДанными1СДокументооборота.РазрешеноБезПерепроведения);
	Элементы.РежимИзмененияДанныхПроведенногоДокумента.СписокВыбора.Добавить(
		Перечисления.РежимИзмененияПроведенногоДокументаДанными1СДокументооборота.Запрещено);
	ИнтеграцияС1СДокументооборотПереопределяемый.УстановитьРежимыИзмененияВПроведенномДокументе(
		ТипОбъектаИС, ПредставлениеРеквизитаОбъектаИС, Элементы.РежимИзмененияДанныхПроведенногоДокумента.СписокВыбора);
	
	Элементы.Обновлять.Видимость = ИнтеграцияС1СДокументооборотПовтИсп.ДоступенФункционалВерсииСервиса("1.3.2.3.CORP");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьДоступность();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ВариантПриИзменении(Элемент)
	
	УстановитьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеРеквизитаОбъектаДОНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьРеквизитОбъектаДокументооборота();
	
КонецПроцедуры

&НаКлиенте
Процедура ВычисляемоеВыражениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ВыбратьВычисляемоеВыражение();
	
КонецПроцедуры
 
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Если Не ПроверитьЗаполнение() Тогда 
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("ИмяРеквизитаОбъектаДО");
	Результат.Вставить("ПредставлениеРеквизитаОбъектаДО");
	Результат.Вставить("ВычисляемоеВыражение");
	Результат.Вставить("Картинка");
	Результат.Вставить("Обновлять", Обновлять);
	
	Если Вариант = РеквизитОбъекта Тогда 
		Результат.ИмяРеквизитаОбъектаДО = ИмяРеквизитаОбъектаДО;
		Результат.ПредставлениеРеквизитаОбъектаДО = ПредставлениеРеквизитаОбъектаДО;
		Результат.Картинка = 1;
		
	ИначеЕсли Вариант = ВыражениеНаВстроенномЯзыке Тогда 
		Результат.ВычисляемоеВыражение = ВычисляемоеВыражение;
		Результат.Картинка = 3;
		
	КонецЕсли;
	
	Результат.Вставить("Вариант", Вариант);
	Результат.Вставить("РежимИзмененияДанныхПроведенногоДокумента", РежимИзмененияДанныхПроведенногоДокумента);
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьРеквизитОбъектаДокументооборота()
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТипОбъектаДО", ТипОбъектаДО);
	ПараметрыФормы.Вставить("РеквизитыОбъектаДО", РеквизитыОбъектаДО);
	ПараметрыФормы.Вставить("ИмяРеквизитаОбъектаДО", ИмяРеквизитаОбъектаДО);
	ПараметрыФормы.Вставить("ПредставлениеРеквизитаОбъектаИС", ПредставлениеРеквизитаОбъектаИС);
	ПараметрыФормы.Вставить("ЭтоТаблица", Истина);
	
	Оповещение = Новый ОписаниеОповещения("ВыбратьРеквизитОбъектаДокументооборотаЗавершение", ЭтаФорма);
	
	ОткрытьФорму("Справочник.ПравилаИнтеграцииС1СДокументооборотом.Форма.ВыборРеквизитаДокументооборота",
		ПараметрыФормы, ЭтаФорма,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьРеквизитОбъектаДокументооборотаЗавершение(Результат, ПараметрыОповещения) Экспорт

	Если ТипЗнч(Результат) = Тип("Структура") Тогда 
		Результат.Свойство("Имя", ИмяРеквизитаОбъектаДО);
		Результат.Свойство("Представление", ПредставлениеРеквизитаОбъектаДО);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьВычисляемоеВыражение();
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ВычисляемоеВыражение", ВычисляемоеВыражение);
	ПараметрыФормы.Вставить("ТипВыражения", "ПравилоЗагрузки");
	ПараметрыФормы.Вставить("ТипОбъектаДО", ТипОбъектаДО);
	ПараметрыФормы.Вставить("ЭтоТаблица", Истина);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыбратьВычисляемоеВыражениеЗавершение", ЭтаФорма);
	
	ОткрытьФорму("Справочник.ПравилаИнтеграцииС1СДокументооборотом.Форма.ВыражениеНаВстроенномЯзыке",
		ПараметрыФормы, ЭтаФорма,,,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьВычисляемоеВыражениеЗавершение(Результат, ПараметрыОповещения) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Строка") Тогда 
		ВычисляемоеВыражение = Результат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступность()
	
	Элементы.ПредставлениеРеквизитаОбъектаДО.Доступность = (Вариант = РеквизитОбъекта);
	Элементы.ПредставлениеРеквизитаОбъектаДО.АвтоОтметкаНезаполненного = 
		(Вариант = РеквизитОбъекта);
	Элементы.ПредставлениеРеквизитаОбъектаДО.ОтметкаНезаполненного = 
		(Вариант = РеквизитОбъекта) И Не ЗначениеЗаполнено(ПредставлениеРеквизитаОбъектаДО);
	
	Элементы.ВычисляемоеВыражение.Доступность = (Вариант = ВыражениеНаВстроенномЯзыке);
	Элементы.ВычисляемоеВыражение.АвтоОтметкаНезаполненного = (Вариант = ВыражениеНаВстроенномЯзыке);
	Элементы.ВычисляемоеВыражение.ОтметкаНезаполненного = 
		(Вариант = ВыражениеНаВстроенномЯзыке) И Не ЗначениеЗаполнено(ВычисляемоеВыражение);
	
	Элементы.РежимИзмененияДанныхПроведенногоДокумента.Доступность =
		(Вариант = РеквизитОбъекта)
		Или (Вариант = ВыражениеНаВстроенномЯзыке);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Вариант = Перечисления.ВариантыПравилЗаполненияРеквизитов.РеквизитОбъекта Тогда 
		ПроверяемыеРеквизиты.Добавить("ПредставлениеРеквизитаОбъектаДО");
		Если Параметры.ЗаполняетсяДокумент Тогда
			ПроверяемыеРеквизиты.Добавить("РежимИзмененияДанныхПроведенногоДокумента");
		КонецЕсли;
		
	ИначеЕсли Вариант = Перечисления.ВариантыПравилЗаполненияРеквизитов.ВыражениеНаВстроенномЯзыке Тогда 
		ПроверяемыеРеквизиты.Добавить("ВычисляемоеВыражение");
		Если Параметры.ЗаполняетсяДокумент Тогда
			ПроверяемыеРеквизиты.Добавить("РежимИзмененияДанныхПроведенногоДокумента");
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
