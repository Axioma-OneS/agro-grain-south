﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

// см. ОбновлениеИнформационнойБазыБСП.ПриДобавленииОбработчиковОбновления
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "РегистрыНакопления.МатериалыИРаботыВПроизводстве.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "11.4.10.64";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("900efe57-66f8-4f2b-a8f1-5fd384b170d3");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.МатериалыИРаботыВПроизводстве.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru = 'Переформировывает движения по регистраторам ""Акт выполненных работ"", в которых некорректно заполнено поле ""Назначение"" в ТЧ ""Услуги"".'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Документы.АктВыполненныхРабот.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЗаказКлиента.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.МатериалыИРаботыВПроизводстве.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.АктВыполненныхРабот.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДвиженияРабот.Регистратор КАК Регистратор
		|ИЗ
		|	РегистрНакопления.МатериалыИРаботыВПроизводстве КАК ДвиженияРабот
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.АктВыполненныхРабот.Услуги КАК УслугиАкта
		|		ПО ДвиженияРабот.Регистратор = УслугиАкта.Ссылка
		|			И ДвиженияРабот.Номенклатура = УслугиАкта.Номенклатура
		|			И ДвиженияРабот.Характеристика = УслугиАкта.Характеристика
		|			И ДвиженияРабот.Назначение = УслугиАкта.Назначение
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказКлиента.Товары КАК ЗаказТовары
		|		ПО УслугиАкта.Номенклатура = ЗаказТовары.Номенклатура
		|			И УслугиАкта.Характеристика = ЗаказТовары.Характеристика
		|			И УслугиАкта.КодСтроки = ЗаказТовары.КодСтроки
		|			И УслугиАкта.ЗаказКлиента = ЗаказТовары.Ссылка
		|ГДЕ
		|	НЕ ДвиженияРабот.Назначение = ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
		|	И ДвиженияРабот.Номенклатура.ТипНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Работа)
		|	И ТИПЗНАЧЕНИЯ(ДвиженияРабот.Регистратор) = ТИП(Документ.АктВыполненныхРабот)
		|	И НЕ ЗаказТовары.ВариантОбеспечения В (ЗНАЧЕНИЕ(Перечисление.ВариантыОбеспечения.Обособленно),
		|											ЗНАЧЕНИЕ(Перечисление.ВариантыОбеспечения.ОтгрузитьОбособленно))";
	
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Регистратор"),
		"РегистрНакопления.МатериалыИРаботыВПроизводстве");
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.АктВыполненныхРабот");
	
	ПолноеИмяРегистра = "РегистрНакопления.МатериалыИРаботыВПроизводстве";
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(Регистраторы,
																						ПолноеИмяРегистра,
																						Параметры.Очередь);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли