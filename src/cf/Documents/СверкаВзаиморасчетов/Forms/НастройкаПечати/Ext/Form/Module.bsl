﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ИспользоватьКредитыДепозиты = ПолучитьФункциональнуюОпцию("ИспользоватьДоговорыКредитовИДепозитов");
	ИспользоватьЛизинг = ПолучитьФункциональнуюОпцию("ИспользоватьЛизинг");
	Если ИспользоватьКредитыДепозиты И НЕ ИспользоватьЛизинг Тогда
		Элементы.ДетализацияФинансовыхИнструментов.Заголовок = НСтр("ru = 'по кредитам, депозитам'");
		
	ИначеЕсли НЕ ИспользоватьКредитыДепозиты И ИспользоватьЛизинг Тогда
		Элементы.ДетализацияФинансовыхИнструментов.Заголовок = НСтр("ru = 'по лизингу'");
		
	ИначеЕсли НЕ ИспользоватьКредитыДепозиты И НЕ ИспользоватьЛизинг Тогда
		Элементы.ДетализацияФинансовыхИнструментов.Видимость = Ложь;
		
	КонецЕсли;
	
	Если Параметры.Свойство("Печать") Тогда
		Элементы.Сохранить.Заголовок = НСтр("ru = 'Печать'");
	КонецЕсли;
	
	Если Параметры.Свойство("НастройкиПечати") Тогда
		НастройкиПечати = Параметры.НастройкиПечати;
		
	Иначе
		НастройкиПечати = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
								Документы.СверкаВзаиморасчетов.КлючОбъектаПользовательскихНастроек(),
								"НастройкиПечати");
		Если НастройкиПечати = Неопределено Тогда
			НастройкиПечати = НастройкиПечатиПоУмолчанию();
		КонецЕсли;
		
	КонецЕсли;
	Если НЕ НастройкиПечати.Свойство("ОбъединитьКлиентовПоставщиков") Тогда
		НастройкиПечати.Вставить("ОбъединитьКлиентовПоставщиков", Истина);
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, НастройкиПечати);
	Если НастройкиПечати.ОбъединитьКлиентовПоставщиков Тогда
		ДолгКакДебет = Истина;
		ВыводитьАвансРегл = Ложь;
	КонецЕсли;
	Элементы.ДолгКакДебет.Доступность = НЕ НастройкиПечати.ОбъединитьКлиентовПоставщиков;
	Элементы.ВыводитьАвансРегл.Доступность = НЕ НастройкиПечати.ДолгКакДебет;
	
	Если НастройкиПечати.ДолгКакДебет ИЛИ ДолгКакДебет Тогда
		ВыводитьАвансРегл = Ложь;
	КонецЕсли;
	Элементы.ВыводитьАвансРегл.Доступность = НЕ (НастройкиПечати.ДолгКакДебет ИЛИ ДолгКакДебет);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиРеквизитовФормы

&НаКлиенте
Процедура ДолгКакДебетПриИзменении(Элемент)

	Если ДолгКакДебет Тогда
		ВыводитьАвансРегл = Ложь;
	КонецЕсли;
	Элементы.ВыводитьАвансРегл.Доступность = НЕ ДолгКакДебет;

КонецПроцедуры

&НаКлиенте
Процедура ОбъединитьКлиентовПоставщиковПриИзменении(Элемент)
	
	Если ОбъединитьКлиентовПоставщиков Тогда
		ДолгКакДебет = Истина;
		ВыводитьАвансРегл = Ложь;
	КонецЕсли;
	Элементы.ДолгКакДебет.Доступность = НЕ ОбъединитьКлиентовПоставщиков;
	Элементы.ВыводитьАвансРегл.Доступность = НЕ ДолгКакДебет;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сохранить(Команда)

	НастройкиПечати = НастройкиПечатиПоУмолчанию();
	ЗаполнитьЗначенияСвойств(НастройкиПечати, ЭтотОбъект);
	СохранитьНастройкиНаСервере(НастройкиПечати); 
	Закрыть(НастройкиПечати);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СохранитьНастройкиНаСервере(НастройкиПечати)

	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(
		Документы.СверкаВзаиморасчетов.КлючОбъектаПользовательскихНастроек(),
		"НастройкиПечати",
		НастройкиПечати);
	
КонецПроцедуры

&НаСервере
Функция НастройкиПечатиПоУмолчанию()
	
	Возврат Документы.СверкаВзаиморасчетов.НастройкиПечатиПоУмолчанию();
	
КонецФункции

#КонецОбласти
