﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияУТ.НастроитьПодключаемоеОборудование(ЭтаФорма);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПриОткрытииФормы(Неопределено, ЭтаФорма, "СканерШтрихкода,СчитывательМагнитныхКарт");
	Активизировать();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПриЗакрытииФормы(Неопределено, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" И МенеджерОборудованияУТКлиент.ЕстьНеобработанноеСобытие() Тогда
			ОбработатьШтрихкоды(МенеджерОборудованияУТКлиент.ПреобразоватьДанныеСоСканераВМассив(Параметр));
		ИначеЕсли ИмяСобытия ="TracksData" Тогда
			ОбработатьДанныеСчитывателяМагнитныхКарт(Параметр);
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ВыбратьПродавца();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьПродавца()
	
	Закрыть(Пользователь);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПользователяПоШтрихкоду(Штрихкод)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИдентификационныеДанныеПользователей.Пользователь КАК Пользователь
	|ИЗ
	|	РегистрСведений.ИдентификационныеДанныеПользователей КАК ИдентификационныеДанныеПользователей
	|ГДЕ
	|	ИдентификационныеДанныеПользователей.Штрихкод = &Штрихкод");
	
	Запрос.УстановитьПараметр("Штрихкод", Штрихкод);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Пользователь;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция ПолучитьПользователяПоМагнитномуКоду(МагнитныйКод)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИдентификационныеДанныеПользователей.Пользователь КАК Пользователь
	|ИЗ
	|	РегистрСведений.ИдентификационныеДанныеПользователей КАК ИдентификационныеДанныеПользователей
	|ГДЕ
	|	ИдентификационныеДанныеПользователей.МагнитныйКод = &МагнитныйКод");
	
	Запрос.УстановитьПараметр("МагнитныйКод", МагнитныйКод);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Пользователь;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

#Область ШтрихкодыИТорговоеОборудование

// МеханизмВнешнегоОборудования
&НаКлиенте
Процедура ОбработатьШтрихкоды(ДанныеШтрихкода)
	
	Пользователь = ПолучитьПользователяПоШтрихкоду(ДанныеШтрихкода[0].Штрихкод);
	Если ЗначениеЗаполнено(Пользователь) Тогда
		ПодключитьОбработчикОжидания("ВыбратьПродавца", 0.1, Истина);
	Иначе
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Пользователь не обнаружен.'"));
	КонецЕсли;
	
КонецПроцедуры
// Конец МеханизмВнешнегоОборудования

&НаКлиенте
Процедура ОбработатьДанныеСчитывателяМагнитныхКарт(Данные)
	
	СписокКодов = Новый СписокЗначений;
	
	РасшифрованныеДанные = Данные[1][3];
	Если РасшифрованныеДанные <> Неопределено Тогда
		Для Каждого Структура Из РасшифрованныеДанные Цикл
			
			ШаблонМагнитнойКарты = Структура.Шаблон;
			КодКарты             = Неопределено;
			Для Каждого ДанныеПоля Из Структура.ДанныеДорожек Цикл
				Если ДанныеПоля.Поле = ПредопределенноеЗначение("Перечисление.ПоляШаблоновМагнитныхКарт.Код") Тогда
					СписокКодов.Добавить(ДанныеПоля.ЗначениеПоля);
				КонецЕсли;
			КонецЦикла;
			
		КонецЦикла;
	КонецЕсли;
	
	Если СписокКодов.Количество() = 1 Тогда
		МагнитныйКод = СписокКодов.Получить(0).Значение;
	ИначеЕсли СписокКодов.Количество() = 0 Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Код карты не соответствует ни одному из шаблонов магнитных карт.'"));
		Возврат;
	Иначе
		ВыбранноеЗначение = Неопределено;
		СписокКодов.ПоказатьВыборЭлемента(Новый ОписаниеОповещения("ОбработатьДанныеСчитывателяМагнитныхКартЗавершение", ЭтотОбъект), НСтр("ru = 'Выбор кода магнитной карты'"));
		Возврат;
	КонецЕсли;
	
	ОбработатьДанныеСчитывателяМагнитныхКартФрагмент(МагнитныйКод);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьДанныеСчитывателяМагнитныхКартЗавершение(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	
	ВыбранноеЗначение = ВыбранныйЭлемент;
	Если ВыбранноеЗначение <> Неопределено Тогда
		МагнитныйКод = ВыбранноеЗначение.Значение;
	КонецЕсли;
	
	ОбработатьДанныеСчитывателяМагнитныхКартФрагмент(МагнитныйКод);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьДанныеСчитывателяМагнитныхКартФрагмент(Знач МагнитныйКод)
	
	Пользователь = ПолучитьПользователяПоМагнитномуКоду(МагнитныйКод);
	Если ЗначениеЗаполнено(Пользователь) Тогда
		ПодключитьОбработчикОжидания("ВыбратьПродавца", 0.1, Истина);
	Иначе
		ПоказатьПредупреждение(Неопределено, НСтр("ru = 'Пользователь не обнаружен.'"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
