﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	АдресноеХранение = СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, Дата);
	ИспользоватьУпаковочныеЛисты = ПолучитьФункциональнуюОпцию("ИспользоватьУпаковочныеЛисты");
	
	Если АдресноеХранение И Не ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры") Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
		ТекстСообщения = НСтр("ru='В настройках программы не включено использование упаковок номенклатуры, 
		|поэтому нельзя оформить документ по складу с адресным хранением остатков. Обратитесь к администратору'");
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,,Отказ);
	КонецЕсли;
	
	Если (Не АдресноеХранение
		Или Статус = Перечисления.СтатусыПриходныхОрдеров.КПоступлению)Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
	Иначе
		ПараметрыПроверки = НоменклатураСервер.ПараметрыПроверкиЗаполненияУпаковок();
		ПараметрыПроверки.ВыводитьНомераСтрок = Не ИспользоватьУпаковочныеЛисты;
		ПараметрыПроверки.ОтборПроверяемыхСтрок.Вставить("ЭтоУпаковочныйЛист", Ложь);
		НоменклатураСервер.ПроверитьЗаполнениеУпаковок(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ,ПараметрыПроверки);
	КонецЕсли;
	
	Если Статус = Перечисления.СтатусыПриходныхОрдеров.КПоступлению 
		ИЛИ Статус = Перечисления.СтатусыПриходныхОрдеров.ВРаботе Тогда
	
		МассивНепроверяемыхРеквизитов.Добавить("Товары");
		
	КонецЕсли;
	
	Если Статус = Перечисления.СтатусыПриходныхОрдеров.КПоступлению Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Товары.КоличествоУпаковок");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Количество");
		
	КонецЕсли;
	
	ПараметрыПроверки = НоменклатураСервер.ПараметрыПроверкиЗаполненияХарактеристик();
	ПараметрыПроверки.ВыводитьНомераСтрок = Не ИспользоватьУпаковочныеЛисты;
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ,ПараметрыПроверки);
	
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект,
												НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Обработки.ПроверкаКоличестваТоваровВПриходномОрдере),
												Отказ);
	
	УпаковочныеЛистыСервер.ПроверитьЗаполнениеТЧСУпаковочнымиЛистами(ЭтотОбъект, ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов, Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли