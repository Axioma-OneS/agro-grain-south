﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Партнеры") Тогда
		
		ЗаполнитьНаОснованииПартнера(ДанныеЗаполнения, ДанныеЗаполнения);
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		ЗаполнитьПоОтбору(ДанныеЗаполнения);
		
	КонецЕсли;
	
	ИнициализироватьСправочник(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ФормаОплаты = Перечисления.ФормыОплаты.Наличная Тогда
		БанковскийСчет = Справочники.БанковскиеСчетаОрганизаций.ПустаяСсылка();
		БанковскийСчетКонтрагента = Справочники.БанковскиеСчетаКонтрагентов.ПустаяСсылка();
		БанковскийСчетПроцентов = БанковскийСчетКонтрагента;
		БанковскийСчетКомиссии = БанковскийСчетКонтрагента;
	Иначе
		Касса = Справочники.Кассы.ПустаяСсылка();
	КонецЕсли;
	
	Если ТипКомиссии = Перечисления.ТипыКомиссииКредитовИДепозитов.Нет Тогда
		СтатьяДДСКомиссии = Справочники.СтатьиДвиженияДенежныхСредств.ПустаяСсылка();
		Если ХарактерДоговора = Перечисления.ХарактерыДоговоровФинансовыхИнструментов.КредитИлиЗайм Тогда
			СтатьяДоходовРасходовКомиссии = ПланыВидовХарактеристик.СтатьиРасходов.ПустаяСсылка();
		Иначе
			СтатьяДоходовРасходовКомиссии = ПланыВидовХарактеристик.СтатьиДоходов.ПустаяСсылка();
		КонецЕсли;
	КонецЕсли;
	
	Согласован = (Статус = Перечисления.СтатусыДоговоровКонтрагентов.Действует
		Или Статус = Перечисления.СтатусыДоговоровКонтрагентов.Закрыт);
		
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Статус = Перечисления.СтатусыДоговоровКонтрагентов.НеСогласован;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Перем Ошибки;
	
	МассивНеПроверяемыхРеквизитов = Новый Массив;
	Если ФормаОплаты = Перечисления.ФормыОплаты.Наличная Тогда
		МассивНеПроверяемыхРеквизитов.Добавить("БанковскийСчет");
		МассивНеПроверяемыхРеквизитов.Добавить("БанковскийСчетКонтрагента");
	Иначе
		МассивНеПроверяемыхРеквизитов.Добавить("Касса");
	КонецЕсли;
	
	
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНеПроверяемыхРеквизитов);
	
КонецПроцедуры

// Процедура заполняет реквизиты справочника значениями "по умолчанию".
//
Процедура ИнициализироватьСправочник(ДанныеЗаполнения = Неопределено) Экспорт
	
	Ответственный = Пользователи.ТекущийПользователь();
	
	Если ТипЗнч(ДанныеЗаполнения) <> Тип("Структура") Или НЕ ДанныеЗаполнения.Свойство("Организация") Тогда
		Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	КонецЕсли;
	
	СтруктураПараметров = ДенежныеСредстваСервер.ПараметрыЗаполненияБанковскогоСчетаОрганизацииПоУмолчанию();
	СтруктураПараметров.Организация = Организация;
	СтруктураПараметров.БанковскийСчет = БанковскийСчет;
	
	ЗначениеНастроекПовтИсп.ПолучитьБанковскийСчетОрганизацииПоУмолчанию(СтруктураПараметров);
	Если ЗначениеЗаполнено(БанковскийСчет) Тогда
		ВалютаВзаиморасчетов = БанковскийСчет.ВалютаДенежныхСредств;
	Иначе
		Если ТипЗнч(ДанныеЗаполнения) <> Тип("Структура") Или НЕ ДанныеЗаполнения.Свойство("ВалютаВзаиморасчетов") Тогда
			ВалютаВзаиморасчетов = ЗначениеНастроекПовтИсп.ПолучитьВалютуРегламентированногоУчета(ВалютаВзаиморасчетов);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ЗаполнитьНаОснованииПартнера(Знач Партнер, ДанныеЗаполнения)
	
	ПроверитьВозможностьВводаНаОснованииПартнера(Партнер);
	
	ДанныеЗаполнения = Новый Структура;
	
	ДанныеЗаполнения.Вставить("Партнер", Партнер);
	ДанныеЗаполнения.Вставить("Контрагент", ПартнерыИКонтрагенты.ПолучитьКонтрагентаПартнераПоУмолчанию(Партнер));
	
КонецПроцедуры

Процедура ЗаполнитьПоОтбору(Знач ДанныеЗаполнения)
	
	Если ДанныеЗаполнения.Свойство("Партнер") Тогда
		ДанныеЗаполнения.Вставить("Партнер", ДанныеЗаполнения.Партнер);
		
	ИначеЕсли ДанныеЗаполнения.Свойство("Контрагент") Тогда
		Партнер = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеЗаполнения.Контрагент, "Партнер");
		ДанныеЗаполнения.Вставить("Партнер", Партнер);
		
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("Партнер") Тогда
		
		ПроверитьВозможностьВводаНаОснованииПартнера(ДанныеЗаполнения.Партнер);
		Если НЕ (ДанныеЗаполнения.Свойство("Контрагент") И ЗначениеЗаполнено(ДанныеЗаполнения.Контрагент)) Тогда
			ДанныеЗаполнения.Вставить("Контрагент", ПартнерыИКонтрагенты.ПолучитьКонтрагентаПартнераПоУмолчанию(ДанныеЗаполнения.Партнер));
		КонецЕсли;
		Если НЕ (ДанныеЗаполнения.Свойство("КонтактноеЛицо") И ЗначениеЗаполнено(ДанныеЗаполнения.КонтактноеЛицо)) Тогда
			ДанныеЗаполнения.Вставить("КонтактноеЛицо", ПартнерыИКонтрагенты.ПолучитьКонтактноеЛицоПартнераПоУмолчанию(ДанныеЗаполнения.Партнер));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьВозможностьВводаНаОснованииПартнера(Партнер)
	
	Если Не ЗначениеЗаполнено(Партнер) Тогда
		Возврат;
	КонецЕсли;
	
	ПрочиеОтношения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Партнер, "ПрочиеОтношения");
	
	Если Не ПрочиеОтношения Тогда
		
		ТекстОшибки = НСтр("ru='С партнером ""%Партнер%"" не разрешены прочие отношения. 
		|Ввод на основании доступен только для партнеров, с которыми разрешены прочие отношения.'");
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Партнер%", Партнер);
		
		ВызватьИсключение ТекстОшибки;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#КонецОбласти

#КонецЕсли
