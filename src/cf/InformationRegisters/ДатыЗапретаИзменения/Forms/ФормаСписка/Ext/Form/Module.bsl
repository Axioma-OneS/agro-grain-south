﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	УстановитьПорядок();
	
	ТолькоПросмотр = Истина;
	
	ДатыЗапретаИзмененияСлужебный.ОбновитьРазделыДатЗапретаИзменения();
	
	// Настройка команды.
	СвойстваРазделов = ДатыЗапретаИзмененияСлужебный.СвойстваРазделов();
	Элементы.ФормаДатыЗапретаЗагрузкиДанных.Видимость = СвойстваРазделов.ДатыЗапретаЗагрузкиВнедрены;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Отказ = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДатыЗапретаИзмененияДанных(Команда)
	
	ОткрытьФорму("РегистрСведений.ДатыЗапретаИзменения.Форма.ДатыЗапретаИзменения");
	
КонецПроцедуры

&НаКлиенте
Процедура ДатыЗапретаЗагрузкиДанных(Команда)
	
	ПараметрыФормы = Новый Структура("ДатыЗапретаЗагрузкиДанных", Истина);
	ОткрытьФорму("РегистрСведений.ДатыЗапретаИзменения.Форма.ДатыЗапретаИзменения", ПараметрыФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьВозможностьРедактирования(Команда)
	
	ТолькоПросмотр = Ложь;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	Список.КомпоновщикНастроек.Настройки.УсловноеОформление.Элементы.Очистить();
	
	Для Каждого ТипПользователя Из Метаданные.РегистрыСведений.ДатыЗапретаИзменения.Измерения.Пользователь.Тип.Типы() Цикл
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипПользователя);
		Если НЕ Метаданные.ПланыОбмена.Содержит(ОбъектМетаданных) Тогда
			Продолжить;
		КонецЕсли;
		
		ОформитьЗначение(ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ОбъектМетаданных.ПолноеИмя()).ПустаяСсылка(),
			ОбъектМетаданных.Представление() + ": " + НСтр("ru = '<Все информационные базы>'"));
	КонецЦикла;
	
	ОформитьЗначение(Неопределено,
		НСтр("ru = 'Неопределено'"));
	
	ОформитьЗначение(Справочники.Пользователи.ПустаяСсылка(),
		НСтр("ru = 'Пустой пользователь'"));
	
	ОформитьЗначение(Справочники.ГруппыПользователей.ПустаяСсылка(),
		НСтр("ru = 'Пустая группа пользователей'"));
	
	ОформитьЗначение(Справочники.ВнешниеПользователи.ПустаяСсылка(),
		НСтр("ru = 'Пустой внешний пользователь'"));
	
	ОформитьЗначение(Справочники.ГруппыВнешнихПользователей.ПустаяСсылка(),
		НСтр("ru = 'Пустая группа внешних пользователей'"));
	
	ОформитьЗначение(Перечисления.ВидыНазначенияДатЗапрета.ДляВсехПользователей,
		"<" + Перечисления.ВидыНазначенияДатЗапрета.ДляВсехПользователей + ">");
	
	ОформитьЗначение(Перечисления.ВидыНазначенияДатЗапрета.ДляВсехИнформационныхБаз,
		"<" + Перечисления.ВидыНазначенияДатЗапрета.ДляВсехИнформационныхБаз + ">");
	
КонецПроцедуры

&НаСервере
Процедура ОформитьЗначение(Значение, Текст)
	
	ЭлементОформления = Список.КомпоновщикНастроек.Настройки.УсловноеОформление.Элементы.Добавить();
	ЭлементОформления.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("Текст", Текст);
	
	ЭлементОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Пользователь");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = Значение;
	
	ЭлементПоля = ЭлементОформления.Поля.Элементы.Добавить();
	ЭлементПоля.Поле = Новый ПолеКомпоновкиДанных("Пользователь");
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПорядок()
	
	Порядок = Список.КомпоновщикНастроек.Настройки.Порядок;
	Порядок.Элементы.Очистить();
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("Пользователь");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.Использование = Истина;
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("Раздел");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.Использование = Истина;
	
	ЭлементПорядка = Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
	ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ЭлементПорядка.Поле = Новый ПолеКомпоновкиДанных("Объект");
	ЭлементПорядка.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Возр;
	ЭлементПорядка.Использование = Истина;
	
КонецПроцедуры

#КонецОбласти
