﻿
#Область СлужебныйПрограммныйИнтерфейс

#Область ПересчетИтогов

Процедура ПересчитатьИтогиПоПроверкеСодержимогоУпаковок(ДеревоМаркированнойПродукции, Контекст) Экспорт
	
	Для Каждого СтрокаДерева Из ДеревоМаркированнойПродукции.ПолучитьЭлементы() Цикл
		
		Контекст.ПересчитатьИтогиПоПроверкеСодержимогоУпаковки(СтрокаДерева, Истина);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПересчитатьИтогиПоПроверкеСодержимогоУпаковкиПриИзмененииСтроки(СтрокаДерева, Контекст) Экспорт
	
	РодительскаяСтрока = СтрокаДерева.ПолучитьРодителя();
	
	Пока РодительскаяСтрока <> Неопределено Цикл
		Контекст.ПересчитатьИтогиПоПроверкеСодержимогоУпаковки(РодительскаяСтрока, Ложь);
		РодительскаяСтрока = РодительскаяСтрока.ПолучитьРодителя();
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ПредставлениеПолейДереваМаркированнойПродукции

Процедура УстановитьИндексКартинкиСтатусаПроверки(ТекущаяСтрока, Контекст) Экспорт
	
	Если ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.ВНаличии") Тогда
		
		ТекущаяСтрока.ИндексКартинкиСтатусПроверки = 0;
		
	ИначеЕсли ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.Отсутствует") Тогда

		ТекущаяСтрока.ИндексКартинкиСтатусПроверки = 1;
		
	ИначеЕсли ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.НеПроверялась") Тогда
		
		ТекущаяСтрока.ИндексКартинкиСтатусПроверки = 2;
		
	ИначеЕсли ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.Отложена") Тогда
		
		ТекущаяСтрока.ИндексКартинкиСтатусПроверки = 3;
		
	ИначеЕсли ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.НеЧислилась") Тогда
		
		ТекущаяСтрока.ИндексКартинкиСтатусПроверки = 4;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура СформироватьПредставлениеДляСтрокиДереваМаркированнойПродукции(ТекущаяСтрока, Контекст) Экспорт
	
	Если ПустаяСтрока(ТекущаяСтрока.Штрихкод)
		И ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ТекущаяСтрока.ТипУпаковки) Тогда
		
		ТекущаяСтрока.Представление = НСтр("ru = '<не маркирована>'");
		
	Иначе
		
		ТекущаяСтрока.Представление = ТекущаяСтрока.Штрихкод;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбновитьВыводимоеПредставлениеПроверкиСодержимого(Форма, ТекущаяСтрока, Контекст) Экспорт

	Элементы = Форма.Элементы;
	
	Если ТекущаяСтрока = Неопределено
		Или Не ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ТекущаяСтрока.ТипУпаковки) Тогда
		
		Форма.ВыводимоеПредставлениеПроверкиСодержимого = "";
		Элементы.СтраницыПредставлениеПроверкиПодчиненных.ТекущаяСтраница = Элементы.СтраницаПредставлениеПроверкиПодчиненныхАвто;
		
	Иначе
		
		Форма.ВыводимоеПредставлениеПроверкиСодержимого = ТекущаяСтрока.ПредставлениеПроверкиПодчиненных;
		
		Если ТекущаяСтрока.КоличествоПодчиненныхОтсутствует > 0 Тогда
			
			Элементы.СтраницыПредставлениеПроверкиПодчиненных.ТекущаяСтраница = Элементы.СтраницаПредставлениеПроверкиПодчиненныхКрасный;
			
		ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхОтложено > 0 Тогда
		
			Элементы.СтраницыПредставлениеПроверкиПодчиненных.ТекущаяСтраница = Элементы.СтраницаПредставлениеПроверкиПодчиненныхЖелтый;
			
		Иначе
			
			Элементы.СтраницыПредставлениеПроверкиПодчиненных.ТекущаяСтраница = Элементы.СтраницаПредставлениеПроверкиПодчиненныхАвто;
			
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОпределениеТипаУпаковки

Процедура УстановитьЗначениеДляУпаковки(СтрокаДерева,
	ИмяКолонкиЗначения, ИмяКолонкиЕстьРазличные,
	МассивЗначений, ЕстьРазличныеБезусловно) Экспорт
	
	Если ЕстьРазличныеБезусловно Тогда
		
		СтрокаДерева[ИмяКолонкиЗначения]      = Неопределено;
		СтрокаДерева[ИмяКолонкиЕстьРазличные] = Истина;
		
	ИначеЕсли МассивЗначений.Количество() = 0 Тогда
		
		СтрокаДерева[ИмяКолонкиЗначения]      = Неопределено;
		СтрокаДерева[ИмяКолонкиЕстьРазличные] = Ложь;
		
	ИначеЕсли МассивЗначений.Количество() = 1 Тогда
		
		Значение = Неопределено;
		Для Каждого КлючИЗначение Из МассивЗначений Цикл
			Значение = КлючИЗначение.Ключ;
		КонецЦикла;
		
		СтрокаДерева[ИмяКолонкиЗначения]      = Значение;
		СтрокаДерева[ИмяКолонкиЕстьРазличные] = Ложь;
		
	Иначе
		
		СтрокаДерева[ИмяКолонкиЗначения]      = Неопределено;
		СтрокаДерева[ИмяКолонкиЕстьРазличные] = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Перемаркировка

Процедура ОтобразитьИнформациюОНеобходимостиПеремаркировки(Форма, Контекст) Экспорт
	
	Если Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать > 0 Тогда
		Форма.Элементы.ДекорацияИнформацияТребуетсяПеремаркировка.Заголовок = Контекст.ЗаголовокТребуетсяПеремаркировка(Форма);
		Форма.Элементы.ГруппаТребуетсяПеремаркировка.Видимость = Истина;
	Иначе
		Форма.Элементы.ГруппаТребуетсяПеремаркировка.Видимость = Ложь;
	КонецЕсли;
	
	Форма.ТребуетсяОбновитьИнформациюОНеобходимостиПеремаркировки = Ложь;
	
КонецПроцедуры

Процедура ПроверитьНеобходимостьПеремаркировки(Форма, ТаблицаПеремаркировки, ЭтоВыборочнаяПроверка, Контекст) Экспорт
	
	Если ТаблицаПеремаркировки.Количество() = 0 Тогда
		Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать = 0;
		Контекст.ОтобразитьИнформациюОНеобходимостиПеремаркировки(Форма);
		Возврат;
	КонецЕсли;
	
	Если Не ЭтоВыборочнаяПроверка Тогда
		Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать = 0;
	КонецЕсли;
	
	Для Каждого СтрокаПеремаркировки Из ТаблицаПеремаркировки Цикл
		СтрокаДерева = Форма.ДеревоМаркированнойПродукции.НайтиПоИдентификатору(СтрокаПеремаркировки.ИдентификаторВДереве);
		
		Если СтрокаДерева <> Неопределено Тогда
			ТребуетсяПеремаркировка = СтрокаПеремаркировки.ТребуетсяПеремаркировка 
				И Не СтрокаДерева.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.Отсутствует");
				
			Если ЭтоВыборочнаяПроверка Тогда
				Если СтрокаДерева.ТребуетсяПеремаркировка И Не ТребуетсяПеремаркировка Тогда
					Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать = Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать - 1; 
				ИначеЕсли Не СтрокаДерева.ТребуетсяПеремаркировка И ТребуетсяПеремаркировка Тогда
					Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать = Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать + 1;
				КонецЕсли;
			ИначеЕсли ТребуетсяПеремаркировка Тогда
				Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать = Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать + 1;
			КонецЕсли;
			
			СтрокаДерева.ТребуетсяПеремаркировка = ТребуетсяПеремаркировка;
			Контекст.СформироватьПредставлениеСодержимогоУпаковки(СтрокаДерева);
			
			Если ЭтоВыборочнаяПроверка И Форма.УстановленОтборТребуетсяПеремаркировать Тогда
				ПроверитьСоответствиеОтборуТребуетсяПеремаркировка(СтрокаДерева, Контекст);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Контекст.ОтобразитьИнформациюОНеобходимостиПеремаркировки(Форма);
	
КонецПроцедуры

Процедура ПроверитьСоответствиеОтборуТребуетсяПеремаркировка(СтрокаДерева, Контекст) Экспорт
	
	СоответствуетОтбору = Ложь;
	УстановитьОтборТребуетсяПеремаркировкаВСтрокеДерева(СтрокаДерева, СоответствуетОтбору, Контекст);
	СтрокаДерева.НеСоответствуетОтбору = Не СоответствуетОтбору;
	
	РодительскаяСтрока = СтрокаДерева.ПолучитьРодителя();
	
	Пока РодительскаяСтрока <> Неопределено Цикл
		Для Каждого ПодчиненнаяСтрока Из РодительскаяСтрока.ПолучитьЭлементы() Цикл
			РодительскаяСтрока.НеСоответствуетОтбору = Истина;

			Если Не ПодчиненнаяСтрока.НеСоответствуетОтбору Тогда
				РодительскаяСтрока.НеСоответствуетОтбору = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		РодительскаяСтрока = РодительскаяСтрока.ПолучитьРодителя();
	КонецЦикла;
	
КонецПроцедуры

Процедура УстановитьОтборТребуетсяПеремаркировкаВСтрокеДерева(СтрокаДерева, СоответствуетОтбору, Контекст) Экспорт
	
	ТекущаяСтрокаСоответствуетОтбору = Ложь;
	
	ПодчиненныеСтроки = СтрокаДерева.ПолучитьЭлементы();
	
	Для Каждого ПодчиненнаяСтрока Из ПодчиненныеСтроки Цикл
		СоответствуетОтбору = Ложь;
		
		УстановитьОтборТребуетсяПеремаркировкаВСтрокеДерева(ПодчиненнаяСтрока, СоответствуетОтбору, Контекст);
		
		Если СоответствуетОтбору Тогда
			ТекущаяСтрокаСоответствуетОтбору = Истина;
		КонецЕсли;
	КонецЦикла;

	Если Не ТекущаяСтрокаСоответствуетОтбору Тогда
		ТекущаяСтрокаСоответствуетОтбору = СтрокаДерева.ТребуетсяПеремаркировка;
	КонецЕсли;
	
	СоответствуетОтбору = ТекущаяСтрокаСоответствуетОтбору;
	СтрокаДерева.НеСоответствуетОтбору = Не СоответствуетОтбору;
	
КонецПроцедуры

#КонецОбласти

Процедура УстановитьДоступностьУпаковкиДляПроверки(ТекущаяСтрока, ДоступныеДляПроверкиУпаковки, Контекст) Экспорт

	Если НЕ ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ТекущаяСтрока.ТипУпаковки) Тогда
		Возврат;
	КонецЕсли;
	
	ЭлементСписка = ДоступныеДляПроверкиУпаковки.НайтиПоЗначению(ТекущаяСтрока.Штрихкод);
	
	Если ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.ВНаличии")
		Или ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.Отложена")
		Или ТекущаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.НеЧислилась") Тогда
		
		Если ЭлементСписка = Неопределено Тогда
			ДоступныеДляПроверкиУпаковки.Добавить(ТекущаяСтрока.Штрихкод);
		КонецЕсли;
		
	Иначе
		
		Если ЭлементСписка <> Неопределено Тогда
			ДоступныеДляПроверкиУпаковки.Удалить(ЭлементСписка);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
