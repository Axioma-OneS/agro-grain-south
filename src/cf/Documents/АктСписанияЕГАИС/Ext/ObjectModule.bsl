﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ИнтеграцияЕГАИСПереопределяемый.ОбработкаЗаполненияДокумента(ЭтотОбъект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	// Инициализация дополнительных свойств для проведения документа
	ИнтеграцияИС.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);
	
	// Инициализация данных документа
	Документы.АктСписанияЕГАИС.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);
	
	// Подготовка наборов записей
	ИнтеграцияИС.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	РегистрыНакопления.ОстаткиАлкогольнойПродукцииЕГАИС.ОтразитьДвижения(ДополнительныеСвойства, Движения, Отказ);
	ИнтеграцияИСПереопределяемый.ОтразитьДвиженияСерийТоваров(ДополнительныеСвойства, Движения, Отказ);
	
	ИнтеграцияИС.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	ИнтеграцияЕГАИСПереопределяемый.ОбработкаПроведения(ЭтотОбъект, Отказ, РежимПроведения);
	
	ИнтеграцияИС.ОчиститьДополнительныеСвойстваДляПроведения(ЭтотОбъект.ДополнительныеСвойства);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если ВидДокумента = Перечисления.ВидыДокументовЕГАИС.АктСписанияИзРегистра2
		Или ВидДокумента = Перечисления.ВидыДокументовЕГАИС.АктСписанияИзРегистра3 Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Справка2");
	КонецЕсли;
	
	Если ВидДокумента = Перечисления.ВидыДокументовЕГАИС.АктСписанияИзРегистра3 Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ПричинаСписания");
	КонецЕсли;
	
	Ключ = Новый Структура("ВидДокумента", ВидДокумента);
	
	ПроверятьТолькоЕслиЗаполнены = Ложь;
	Если Дата < '20180101' И ВидДокумента <> Перечисления.ВидыДокументовЕГАИС.АктСписанияИзРегистра3 Тогда
		ПроверятьТолькоЕслиЗаполнены = Истина;
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументовЕГАИС.АктСписанияИзРегистра1 Тогда
		Если ПричиныСписанияТребующиеУказанияМарки().Найти(ПричинаСписания) = Неопределено Тогда
			Ключ.Вставить("РазрешеноНеУказыватьПартионныеМаркиВСтроке");
		КонецЕсли;
	КонецЕсли;
	
	АкцизныеМаркиЕГАИС.ПроверитьЗаполнениеАкцизныхМарок(ЭтотОбъект, Отказ, ПроверятьТолькоЕслиЗаполнены, Ключ);
	
	ИнтеграцияЕГАИСПереопределяемый.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ПустаяСтрока(Идентификатор) Тогда
		Идентификатор = ИнтеграцияЕГАИС.НовыйИдентификаторДокумента();
	КонецЕсли;
	
	Если СтатусПроверкиИПодбора <> Перечисления.СтатусыПроверкиИПодбораИС.Выполняется Тогда
		ДанныеПроверкиИПодбора = Неопределено;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
	
	ИнтеграцияЕГАИС.СопоставитьАлкогольнуюПродукциюСНоменклатурой(ЭтотОбъект);
	
	ИнтеграцияЕГАИСПереопределяемый.ПередЗаписью(ЭтотОбъект, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ВидДокумента = Перечисления.ВидыДокументовЕГАИС.АктСписанияИзРегистра3 Тогда
		ПричинаСписания = Неопределено;
	КонецЕсли;
	
	ИнтеграцияЕГАИС.ЗаписатьСтатусДокументаЕГАИСПоУмолчанию(ЭтотОбъект);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ДокументОснование       = Неопределено;
	Идентификатор           = "";
	ИдентификаторЕГАИС      = "";
	ДатаРегистрацииДвижений = '00010101';
	
	Если Товары.Количество() > 0 Тогда
		Товары.ЗагрузитьКолонку(Новый Массив(Товары.Количество()), "Справка2");
	КонецЕсли;
	
	СтатусПроверкиИПодбора = Перечисления.СтатусыПроверкиИПодбораИС.НеВыполнялось;
	ДанныеПроверкиИПодбора = Неопределено;
	АкцизныеМарки.Очистить();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПричиныСписанияТребующиеУказанияМарки()
	
	Результат = Новый Массив;
	Результат.Добавить(Перечисления.ПричиныСписанийЕГАИС.Арест);
	Результат.Добавить(Перечисления.ПричиныСписанийЕГАИС.Реализация);
	Результат.Добавить(Перечисления.ПричиныСписанийЕГАИС.Проверки);
	Возврат Результат;

КонецФункции

#КонецОбласти

#КонецЕсли
