﻿
#Область ОписаниеПеременных

// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
&НаКлиенте
Перем ПроверкаКонтрагентовПараметрыОбработчикаОжидания Экспорт;
// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами

&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьЗначенияСвойств(Отчет, Параметры);
	
	Отчет.СформироватьОтчетПоСтандартнойФорме = ?(СформироватьОтчетПоПравилам = 1, Ложь, Истина);
	
	ЗаполнитьРеквизитыИзПараметровФормы(ЭтаФорма);
	
	УчетНДСПереопределяемый.ФормаОтчетаПриСозданииНаСервере(ЭтотОбъект);
	
	ОбщегоНазначенияБПВызовСервера.ЗаполнитьСписокОрганизаций(Элементы.ПолеОрганизация, СоответствиеОрганизаций);
	
	УправлениеФормой(ЭтаФорма);
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентов.ПриСозданииНаСервереОтчет(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	БухгалтерскиеОтчетыКлиент.ПриОткрытии(ЭтаФорма, Отказ);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиент.ОтчетПриОткрытии(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	БухгалтерскиеОтчетыКлиент.ПередЗакрытием(ЭтаФорма, Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	БухгалтерскиеОтчетыКлиент.ПриЗакрытии(ЭтаФорма, ЗавершениеРаботы);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если ПолеОрганизация <> "" Тогда
		Если НЕ СоответствиеОрганизаций.Свойство(ПолеОрганизация) Тогда
			ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
				"Поле", "Заполнение", НСтр("ru = 'Организация'"), , ,);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "ПолеОрганизация", , Отказ);
		КонецЕсли; 
	КонецЕсли; 

КонецПроцедуры

&НаСервере
Процедура ПриСохраненииПользовательскихНастроекНаСервере(Настройки)
	
	БухгалтерскиеОтчетыВызовСервера.ПриСохраненииПользовательскихНастроекНаСервере(ЭтаФорма, Настройки, Истина);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеПользовательскихНастроекНаСервере(Настройки)
	
	БухгалтерскиеОтчетыВызовСервера.ПриЗагрузкеПользовательскихНастроекНаСервере(ЭтаФорма, Настройки, Истина);
	
	ЗаполнитьРеквизитыИзПараметровФормы(ЭтаФорма);

	УчетНДСКлиентСервер.ОтобразитьПоясненияКПериодуОтчета(ЭтотОбъект);
	ОбновитьТекстЗаголовка(ЭтаФорма);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НачалоПериодаПриИзменении(Элемент)
	
	ОбновитьТекстЗаголовка(ЭтотОбъект);
	УчетНДСКлиентСервер.ОтобразитьПоясненияКПериодуОтчета(ЭтотОбъект);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура КонецПериодаПриИзменении(Элемент)
	
	ОбновитьТекстЗаголовка(ЭтотОбъект);
	УчетНДСКлиентСервер.ОтобразитьПоясненияКПериодуОтчета(ЭтотОбъект);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеОрганизацияПриИзменении(Элемент)
	
	ОбщегоНазначенияБПКлиент.ПолеОрганизацияПриИзменении(Элемент, ПолеОрганизация,
		Отчет.Организация, Отчет.ВключатьОбособленныеПодразделения);
	
	ОбновитьТекстЗаголовка(ЭтотОбъект);
	УчетНДСКлиентСервер.ОтобразитьПоясненияКПериодуОтчета(ЭтотОбъект);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура ГруппироватьПоКонтрагентамПриИзменении(Элемент)
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура ОтбиратьПоКонтрагентуПриИзменении(Элемент)
	
	УправлениеФормой(ЭтаФорма);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрагентДляОтбораПриИзменении(Элемент)
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьОтчетПоСтандартнойФормеПриИзменении(Элемент)
	
	Отчет.СформироватьОтчетПоСтандартнойФорме = ?(СформироватьОтчетПоПравилам = 1, Ложь, Истина);
	
	Если Отчет.СформироватьОтчетПоСтандартнойФорме Тогда
		Если Отчет.ОтбиратьПоКонтрагенту Тогда
			Отчет.ОтбиратьПоКонтрагенту = Ложь;
		КонецЕсли;
		Если Отчет.ГруппироватьПоКонтрагентам Тогда
			Отчет.ГруппироватьПоКонтрагентам = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	УправлениеФормой(ЭтаФорма);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеОрганизацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ОбщегоНазначенияБПКлиент.ПолеОрганизацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка, 
		СоответствиеОрганизаций, Отчет.Организация, Отчет.ВключатьОбособленныеПодразделения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеОрганизацияОткрытие(Элемент, СтандартнаяОбработка)
	
	ОбщегоНазначенияБПКлиент.ПолеОрганизацияОткрытие(Элемент, СтандартнаяОбработка,
		ПолеОрганизация, СоответствиеОрганизаций);
		
КонецПроцедуры

&НаКлиенте
Процедура РезультатПриАктивизации(Элемент)
	
	Если ТипЗнч(Результат.ВыделенныеОбласти) = Тип("ВыделенныеОбластиТабличногоДокумента") Тогда
		ИнтервалОжидания = ?(ПолучитьСкоростьКлиентскогоСоединения() = СкоростьКлиентскогоСоединения.Низкая, 1, 0.2);
		ПодключитьОбработчикОжидания("Подключаемый_РезультатПриАктивизацииПодключаемый", ИнтервалОжидания, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатВыбор(Элемент, Область, СтандартнаяОбработка)
	
	Если Результат.Области.Найти("ПерейтиКПомощнику")<>Неопределено Тогда
		Если Область.Верх = Результат.Области.ПерейтиКПомощнику.Верх Тогда
			СтандартнаяОбработка = Ложь;
			УчетНДСКлиентПереопределяемый.ОткрытьФормуПомощникаПоУчетуНДС(Область.Расшифровка);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СформироватьОтчет(Команда)
	
	ОчиститьСообщения();
	
	ОтключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания");
	
	РезультатВыполнения = СформироватьОтчетНаСервере();
	Если Не РезультатВыполнения.ЗаданиеВыполнено Тогда
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "ФормированиеОтчета");
	Иначе
		// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
		ПроверкаКонтрагентовКлиент.ЗапуститьПроверкуКонтрагентовВОтчете(ЭтотОбъект);
		// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	КонецЕсли;
	
	СкрытьНастройки();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьНастройки(Команда)
	Элементы.ПрименитьНастройки.КнопкаПоУмолчанию = Истина;
	ОткрытьНастройки();	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьНастройки(Команда)
	Элементы.Сформировать.КнопкаПоУмолчанию = Истина;
	СкрытьНастройки();
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПериод(Команда)
	
	ПараметрыВыбора = Новый Структура("НачалоПериода,КонецПериода,ВыборКварталов",
		Отчет.НачалоПериода, Отчет.КонецПериода, Истина);
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыбратьПериодЗавершение", ЭтотОбъект);
	ОткрытьФорму("ОбщаяФорма.ВыборСтандартногоПериодаМесяц",
		ПараметрыВыбора, Элементы.ВыбратьПериод, , , , ОписаниеОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьТекстЗаголовка(Форма)
	
	Отчет = Форма.Отчет;
	
	ЗаголовокОтчета = НСтр("ru='Журнал учета полученных и выданных счетов-фактур'")
		+ БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(Отчет.НачалоПериода,
		Отчет.КонецПериода);
	
	Если ЗначениеЗаполнено(Отчет.Организация) И Форма.ИспользуетсяНесколькоОрганизаций Тогда
		ЗаголовокОтчета = ЗаголовокОтчета + " " + БухгалтерскиеОтчетыВызовСервера.ПолучитьТекстОрганизация(Отчет.Организация, Отчет.ВключатьОбособленныеПодразделения);
	КонецЕсли;
	
	Форма.Заголовок = ЗаголовокОтчета;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Отчет    = Форма.Отчет;
	Элементы = Форма.Элементы;
	
	Элементы.КонтрагентДляОтбора.Доступность = Отчет.ОтбиратьПоКонтрагенту;
	Элементы.ГруппаДополнительныеНастройкиКонтрагенты.Доступность = НЕ Отчет.СформироватьОтчетПоСтандартнойФорме;
	
КонецПроцедуры

&НаСервере
Функция ПодготовитьПараметрыОтчета(ЭтоФормированиеОтчетаДоПроверкиКонтрагентов)
	
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("Организация",                         Отчет.Организация);
	ПараметрыОтчета.Вставить("НалоговыйПериод",                     Отчет.НачалоПериода);
	ПараметрыОтчета.Вставить("КонецПериодаОтчета",                  Отчет.КонецПериода);
	ПараметрыОтчета.Вставить("ГруппироватьПоКонтрагентам",          Отчет.ГруппироватьПоКонтрагентам);
	ПараметрыОтчета.Вставить("СформироватьОтчетПоСтандартнойФорме", Отчет.СформироватьОтчетПоСтандартнойФорме);
	ПараметрыОтчета.Вставить("КонтрагентДляОтбора",                 Отчет.КонтрагентДляОтбора);
	ПараметрыОтчета.Вставить("ОтбиратьПоКонтрагенту",               Отчет.ОтбиратьПоКонтрагенту);
	ПараметрыОтчета.Вставить("ВключатьОбособленныеПодразделения",   Отчет.ВключатьОбособленныеПодразделения);
	ПараметрыОтчета.Вставить("ЗаполнениеДекларации",                Ложь);
	ПараметрыОтчета.Вставить("ФормироватьТабличныйДокумент",        Истина);
	ПараметрыОтчета.Вставить("ЭтоЖурналУчетаСчетовФактур",          Истина);
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентов.ДобавитьПараметрыДляПроверкиКонтрагентов(ЭтотОбъект, ПараметрыОтчета, ЭтоФормированиеОтчетаДоПроверкиКонтрагентов, ЖурналУчетаСчетовФактур);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
	Возврат ПараметрыОтчета;
	
КонецФункции

&НаСервере
Функция СформироватьОтчетНаСервере()
	
	Если Не ПроверитьЗаполнение() Тогда 
		Возврат Новый Структура("ЗаданиеВыполнено", Истина);
	КонецЕсли;
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентов.ПередФормированиемОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
	ИБФайловая = ОбщегоНазначения.ИнформационнаяБазаФайловая();
	
	ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторЗадания);
	
	ИдентификаторЗадания = Неопределено;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
	
	ПараметрыОтчета = ПодготовитьПараметрыОтчета(Истина);
	
	Если ИБФайловая Тогда
		АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
		УчетНДСПереопределяемый.ПодготовитьПараметрыЖурналаУчетаСчетовФактур(ПараметрыОтчета, АдресХранилища);
		РезультатВыполнения = Новый Структура("ЗаданиеВыполнено", Истина);
	Иначе
		РезультатВыполнения = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
			УникальныйИдентификатор, 
			"УчетНДСПереопределяемый.ПодготовитьПараметрыЖурналаУчетаСчетовФактур", 
			ПараметрыОтчета, 
			БухгалтерскиеОтчетыКлиентСервер.ПолучитьНаименованиеЗаданияВыполненияОтчета(ЭтаФорма));
		
		ИдентификаторЗадания = РезультатВыполнения.ИдентификаторЗадания;
		АдресХранилища       = РезультатВыполнения.АдресХранилища;
	КонецЕсли;
	
	Если РезультатВыполнения.ЗаданиеВыполнено Тогда
		ЗагрузитьПодготовленныеДанные();
	КонецЕсли;
	
	Элементы.Сформировать.КнопкаПоУмолчанию = Истина;
	
	Возврат РезультатВыполнения;
	
КонецФункции

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()

	Попытка
		Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда
			ЗагрузитьПодготовленныеДанные();
			ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
			// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
			ПроверкаКонтрагентовКлиент.ЗапуститьПроверкуКонтрагентовВОтчете(ЭтотОбъект);
			// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
		Иначе
			ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
			ПодключитьОбработчикОжидания(
				"Подключаемый_ПроверитьВыполнениеЗадания",
				ПараметрыОбработчикаОжидания.ТекущийИнтервал,
				Истина);
		КонецЕсли;
	Исключение
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьПодготовленныеДанные()

	РезультатВыполнения = ПолучитьИзВременногоХранилища(АдресХранилища);

	Если РезультатВыполнения.Свойство("СформированныйЖурнал") Тогда
		
		РезультатВыполнения.Свойство("ОткрыватьПомощникИзМакета", ОткрыватьПомощникИзМакета);
		ЖурналУчетаСчетовФактур = РезультатВыполнения.СформированныйЖурнал;
		ПоказатьВыбранныйЛист();
		
	КонецЕсли;
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентов.ЗапомнитьРезультатФормированияОтчета(ЭтотОбъект, РезультатВыполнения, АдресХранилища);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	 
КонецПроцедуры

&НаСервере
Процедура ПоказатьВыбранныйЛист()

	Результат.Очистить();
	Результат.АвтоМасштаб = Истина;
	Результат.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;
	Результат.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_ЖурналУчетаСчетовФактур";
	Результат.ЧерноБелаяПечать = Истина;
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентов.ВывестиОтчет(ЭтотОбъект, Результат, ЖурналУчетаСчетовФактур);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
	РассчитатьОбластьПечати();
	
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");

КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

&НаСервере
Процедура ВычислитьСуммуВыделенныхЯчеекТабличногоДокументаВКонтекстеНаСервере()
	
	ПолеСумма = БухгалтерскиеОтчетыВызовСервера.ВычислитьСуммуВыделенныхЯчеекТабличногоДокумента(
		Результат, КэшВыделеннойОбласти);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РезультатПриАктивизацииПодключаемый()
	
	НеобходимоВычислятьНаСервере = Ложь;
	БухгалтерскиеОтчетыКлиент.ВычислитьСуммуВыделенныхЯчеекТабличногоДокумента(
		ПолеСумма, Результат, Элементы.Результат, КэшВыделеннойОбласти, НеобходимоВычислятьНаСервере);
	
	Если НеобходимоВычислятьНаСервере Тогда
		ВычислитьСуммуВыделенныхЯчеекТабличногоДокументаВКонтекстеНаСервере();
	КонецЕсли;
	
	ОтключитьОбработчикОжидания("Подключаемый_РезультатПриАктивизацииПодключаемый");
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаполнитьРеквизитыИзПараметровФормы(Форма)
	
	ПараметрыЗаполненияФормы = Неопределено;
	
	Если Форма.Параметры.Свойство("ПараметрыЗаполненияФормы",ПараметрыЗаполненияФормы) Тогда
		ЗаполнитьЗначенияСвойств(Форма.Отчет,ПараметрыЗаполненияФормы);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНастройки()
    Элементы.РазделыОтчета.ТекущаяСтраница = Элементы.НастройкиОтчета;
КонецПроцедуры

&НаКлиенте
Процедура СкрытьНастройки()
	Элементы.РазделыОтчета.ТекущаяСтраница = Элементы.Отчет;	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПериодЗавершение(РезультатВыбора, ДопПараметры) Экспорт
	
	Если РезультатВыбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(Отчет, РезультатВыбора, "НачалоПериода,КонецПериода");
	
	ОбработатьВыборПериодаНаСервере();
	ОбновитьТекстЗаголовка(ЭтаФорма); 
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентовКлиентСервер.СброситьАктуальностьОтчета(ЭтотОбъект);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьВыборПериодаНаСервере()
	
	УчетНДСПереопределяемый.ФормаОтчетаОбработатьВыборПериода(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура РассчитатьОбластьПечати()

	ПерваяСтрока = 1;
	
	Если ОткрыватьПомощникИзМакета Тогда
		ПерваяСтрока = ПерваяСтрока + 1;
	КонецЕсли;
	
	Результат.ОбластьПечати = Результат.Область(ПерваяСтрока,1,Результат.ВысотаТаблицы, Результат.ШиринаТаблицы);

КонецПроцедуры

#Область ПроверкаКонтрагентов

// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
&НаКлиенте
Процедура Подключаемый_ПоказатьПредложениеИспользоватьПроверкуКонтрагентов()
	ПроверкаКонтрагентовКлиент.ПредложитьВключитьПроверкуКонтрагентов(ЭтотОбъект);
КонецПроцедуры
// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами

// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
&НаСервере
Процедура ПроверитьКонтрагентов() Экспорт
	
	ПараметрыОтчета = ПодготовитьПараметрыОтчета(Ложь);
	ПроверкаКонтрагентов.ПроверитьКонтрагентовВОтчете(ЭтотОбъект, ПараметрыОтчета);
	
КонецПроцедуры
// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами

// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
&НаСервере
Процедура ОтобразитьРезультатПроверкиКонтрагента() Экспорт
	ПроверкаКонтрагентов.ОтобразитьРезультатПроверкиКонтрагентаВОтчете(ЭтотОбъект, Результат, ЖурналУчетаСчетовФактур);
КонецПроцедуры
// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами

// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
&НаКлиенте
Процедура ПереключательРежимаОтображенияПриИзменении(Элемент)
	ПереключитьРежимОтображенияОтчета();
КонецПроцедуры
// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами

&НаСервере
Процедура ПереключитьРежимОтображенияОтчета()
	
	// ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	ПроверкаКонтрагентов.ПереключитьРежимОтображенияОтчета(ЭтотОбъект, Результат, ЖурналУчетаСчетовФактур);
	// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами
	
КонецПроцедуры
// Конец ИнтернетПоддержкаПользователей.РаботаСКонтрагентами

#КонецОбласти

#КонецОбласти
