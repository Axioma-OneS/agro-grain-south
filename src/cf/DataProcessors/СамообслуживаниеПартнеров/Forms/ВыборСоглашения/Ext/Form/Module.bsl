﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("Партнер") Тогда
		
		Партнер = Параметры.Партнер;
		СоглашенияСписок.Параметры.УстановитьЗначениеПараметра("Партнер",Параметры.Партнер);
		СоглашенияСписок.Параметры.УстановитьЗначениеПараметра("ТекущаяДата",НачалоДня(ТекущаяДатаСеанса()));
		СоглашенияСписок.Параметры.УстановитьЗначениеПараметра("УказаныРеквизитыПланирования",Параметры.Свойство("УказаныРеквизитыПланирования"));
		
		Если Параметры.Свойство("Соглашение") Тогда
			Элементы.СоглашенияСписок.ТекущаяСтрока = Параметры.Соглашение;
		КонецЕсли;
		
		Если Параметры.Свойство("ХозяйственнаяОперация") Тогда
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			             СоглашенияСписок, "ХозяйственнаяОперация",
			             Параметры.ХозяйственнаяОперация, ВидСравненияКомпоновкиДанных.Равно);
		КонецЕсли;
	Иначе
		
		Отказ = Истина;
		Возврат;
		
	КонецЕсли;
	
	ИспользоватьНесколькоВалют                      = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют");
	Если Не ИспользоватьНесколькоВалют Тогда
		ВалютаИБ = Константы.ВалютаРегламентированногоУчета.Получить();
	КонецЕсли;
	
	ИспользоватьТиповыеСоглашенияСКлиентами         = ПолучитьФункциональнуюОпцию("ИспользоватьТиповыеСоглашенияСКлиентами");
	ИспользоватьИндивидуальныеСоглашенияСКлиентами  = ПолучитьФункциональнуюОпцию("ИспользоватьИндивидуальныеСоглашенияСКлиентами");
	ТолькоТиповые = ИспользоватьТиповыеСоглашенияСКлиентами И НЕ ИспользоватьИндивидуальныеСоглашенияСКлиентами;
	ТолькоИндивидуальные = НЕ ИспользоватьТиповыеСоглашенияСКлиентами И ИспользоватьИндивидуальныеСоглашенияСКлиентами;
	
	СоглашенияСписок.Параметры.УстановитьЗначениеПараметра("ТолькоТиповые",ТолькоТиповые);
	СоглашенияСписок.Параметры.УстановитьЗначениеПараметра("ТолькоИндивидуальные",ТолькоИндивидуальные);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	СписокТипов = СоглашенияСписок.КомпоновщикНастроек.Настройки.Выбор.ДоступныеПоляВыбора.НайтиПоле(Новый ПолеКомпоновкиДанных("Ссылка")).Тип;
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.Источники = СписокТипов;
	ПараметрыРазмещения.КоманднаяПанель = Элементы.ФормаКоманднаяПанель;
	
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСоглашенияСписок

&НаКлиенте
Процедура СоглашенияСписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбработатьВыбор();
	
КонецПроцедуры

&НаКлиенте
Процедура СоглашенияСписокПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработатьВыбор();
	
	ТекущиеДанные = Элементы.СоглашенияСписок.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Закрыть();
	Иначе
		
		СтруктураВозврата = Новый Структура;
		СтруктураВозврата.Вставить("Соглашение", ТекущиеДанные.Ссылка);
		СтруктураВозврата.Вставить("СоглашениеСтрока", ТекущиеДанные.Наименование);
		СтруктураВозврата.Вставить("Валюта", ?(ЗначениеЗаполнено(ВалютаИБ), ВалютаИБ, ТекущиеДанные.Валюта));
		СтруктураВозврата.Вставить("Склад", ТекущиеДанные.Склад);
		СтруктураВозврата.Вставить("ЦенаВключаетНДС", ТекущиеДанные.ЦенаВключаетНДС);
		СтруктураВозврата.Вставить("ГрафикОплаты", ТекущиеДанные.ГрафикОплаты);
		СтруктураВозврата.Вставить("Контрагент", ТекущиеДанные.Контрагент);
		СтруктураВозврата.Вставить("Организация", ТекущиеДанные.Организация);
		СтруктураВозврата.Вставить("ХозяйственнаяОперация", ТекущиеДанные.ХозяйственнаяОперация);
		СтруктураВозврата.Вставить("ПорядокРасчетов", ТекущиеДанные.ПорядокРасчетов);
		СтруктураВозврата.Вставить("ЭтоГруппаСкладов", ТекущиеДанные.ЭтоГруппаСкладов);
		СтруктураВозврата.Вставить("ИспользуютсяДоговорыКонтрагентов", ТекущиеДанные.ИспользуютсяДоговорыКонтрагентов);
		СтруктураВозврата.Вставить("СегментНоменклатуры", ТекущиеДанные.СегментНоменклатуры);
		СтруктураВозврата.Вставить("Сценарий", ТекущиеДанные.Сценарий);
		СтруктураВозврата.Вставить("ВидПлана", ТекущиеДанные.ВидПлана);
		СтруктураВозврата.Вставить("Периодичность", ТекущиеДанные.Периодичность);
		СтруктураВозврата.Вставить("ПланироватьПоСумме", ТекущиеДанные.ПланироватьПоСумме);
		СтруктураВозврата.Вставить("Партнер",Партнер);
		Если Не ЗначениеЗаполнено(ТекущиеДанные.ГрафикОплаты) Тогда
			ФормаОплаты = ТекущиеДанные.ФормаОплаты;
		Иначе
			ФормаОплаты = ПолучитьФормуОплаты(ТекущиеДанные.ГрафикОплаты);
		КонецЕсли;
		
		Закрыть(СтруктураВозврата);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьФормуОплаты(ГрафикОплаты)
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ГрафикОплаты, "ФормаОплаты");
КонецФункции

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.СоглашенияСписок);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.СоглашенияСписок, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.СоглашенияСписок);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти
