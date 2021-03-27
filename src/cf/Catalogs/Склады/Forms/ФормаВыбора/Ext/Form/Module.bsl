﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ГруппаСкладов = Неопределено;
	Если Параметры.Свойство("ГруппаСкладов", ГруппаСкладов) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Ссылка", ГруппаСкладов, ВидСравненияКомпоновкиДанных.ВИерархии,,Истина);
		Элементы.Список.Отображение = ОтображениеТаблицы.Список;
	КонецЕсли;

	Если Параметры.Отбор.Свойство("ДатаНачалаОрдернойСхемыПриОтгрузке") Тогда
		ДатаНачалаОрдернойСхемыПриОтгрузке = Параметры.Отбор.ДатаНачалаОрдернойСхемыПриОтгрузке;
		Параметры.Отбор.Удалить("ДатаНачалаОрдернойСхемыПриОтгрузке");
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
				"ДатаНачалаОрдернойСхемыПриОтгрузке",
				ДатаНачалаОрдернойСхемыПриОтгрузке,
				ВидСравненияКомпоновкиДанных.МеньшеИлиРавно);
		
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("ДатаНачалаОрдернойСхемыПриПоступлении") Тогда
		ДатаНачалаОрдернойСхемыПриПоступлении = Параметры.Отбор.ДатаНачалаОрдернойСхемыПриПоступлении;
		Параметры.Отбор.Удалить("ДатаНачалаОрдернойСхемыПриПоступлении");
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
				"ДатаНачалаОрдернойСхемыПриПоступлении",
				ДатаНачалаОрдернойСхемыПриПоступлении,
				ВидСравненияКомпоновкиДанных.МеньшеИлиРавно);
		
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач") Тогда
		ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач = Параметры.Отбор.ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач;
		Параметры.Отбор.Удалить("ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач");
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
				"ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач",
				ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач,
				ВидСравненияКомпоновкиДанных.МеньшеИлиРавно);
		
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("СкладОтветственногоХранения") Тогда
		СкладОтветственногоХранения = Параметры.Отбор.СкладОтветственногоХранения;
		Параметры.Отбор.Удалить("СкладОтветственногоХранения");
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
				"СкладОтветственногоХранения",
				СкладОтветственногоХранения,
				ВидСравненияКомпоновкиДанных.Равно);
		
	КонецЕсли;
	
	Если Параметры.Свойство("СсылкаНеВСписке") Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Ссылка", Параметры.СсылкаНеВСписке, ВидСравненияКомпоновкиДанных.НеВСписке, "СсылкаНеВСписке", Истина);
	КонецЕсли;
	
	ВыборГруппыСкладов = Неопределено;
	
	ЗапретитьИзменятьСоставСтрок = Ложь;
	Если Не Параметры.Свойство("ВыборГруппыСкладов", ВыборГруппыСкладов) Или
		(Не ПолучитьФункциональнуюОпцию("ИспользоватьСкладыВТабличнойЧастиДокументовПродажи") И Параметры.Свойство("ДокументПродажи"))
		Или (Не ПолучитьФункциональнуюОпцию("ИспользоватьСкладыВТабличнойЧастиДокументовЗакупки") И Параметры.Свойство("ДокументЗакупки")) Тогда
		
		МассивОтбора = Новый Массив();
		МассивОтбора.Добавить(Перечисления.ВыборГруппыСкладов.Запретить);
		МассивОтбора.Добавить(Перечисления.ВыборГруппыСкладов.РазрешитьВЗаказах);
		МассивОтбора.Добавить(Перечисления.ВыборГруппыСкладов.РазрешитьВЗаказахИНакладных);
		ВыборГруппыСкладов = Новый ФиксированныйМассив(МассивОтбора);
		ЗапретитьИзменятьСоставСтрок = Истина;
		
	КонецЕсли;
	
	Список.Параметры.УстановитьЗначениеПараметра("ВыборГруппыСкладов", ВыборГруппыСкладов);
	
	Элементы.Список.ИзменятьСоставСтрок = 
		ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоСкладов") И Не ЗапретитьИзменятьСоставСтрок;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(ВыборГруппыСкладов) И ЗначениеЗаполнено(Значение) И Элементы.Список.ТекущиеДанные <> Неопределено Тогда
		
		ТекущиеДанные = Элементы.Список.ТекущиеДанные;
		ВыборЗапрещен = ТекущиеДанные.ЭтоГруппа;
		
		Если ВыборЗапрещен Тогда
			Если ТипЗнч(ВыборГруппыСкладов) = Тип("ФиксированныйМассив") Тогда
				Для Каждого ТекЭлемент Из ВыборГруппыСкладов Цикл
					Если ТекЭлемент = ТекущиеДанные.ВыборГруппы Тогда
						ВыборЗапрещен = Ложь;
						Прервать;
					КонецЕсли;
				КонецЦикла;
			Иначе
				Если ВыборГруппыСкладов = ТекущиеДанные.ВыборГруппы Тогда
					ВыборЗапрещен = Ложь;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Если ВыборЗапрещен Тогда
			
			СтандартнаяОбработка = Ложь;
			Отказ = Истина;
			ТекстПредупреждения = НСтр("ru='Группу ""%ГруппаСкладов%"" нельзя выбирать в документ.'");
			ТекстПредупреждения = СтрЗаменить(ТекстПредупреждения, "%ГруппаСкладов%", ТекущиеДанные.Наименование);
			ПоказатьПредупреждение(Неопределено, ТекстПредупреждения);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

