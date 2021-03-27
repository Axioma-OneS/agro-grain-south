﻿
#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	СписокИспользуемыхРегистров.ЗагрузитьЗначения(Параметры.СписокИспользуемыхРегистров.ВыгрузитьЗначения());
	Для Каждого Регистр Из Метаданные.Документы.КорректировкаРегистров.Движения Цикл

		Если Метаданные.РегистрыНакопления.Содержит(Регистр) Тогда

			Пометка = СписокИспользуемыхРегистров.НайтиПоЗначению(Регистр.Имя) <> Неопределено;
			СписокРегистровНакопления.Добавить(Регистр.Имя, Регистр.Синоним, Пометка);

		КонецЕсли;

	КонецЦикла;

	СписокРегистровНакопления.СортироватьПоЗначению(НаправлениеСортировки.Возр);

	Для Каждого Регистр Из Метаданные.Документы.КорректировкаРегистров.Движения Цикл

		Если Метаданные.РегистрыСведений.Содержит(Регистр) Тогда

			Пометка = СписокИспользуемыхРегистров.НайтиПоЗначению(Регистр.Имя) <> Неопределено;
			СписокРегистровСведений.Добавить(Регистр.Имя, Регистр.Синоним, Пометка);

		КонецЕсли;

	КонецЦикла;

	СписокРегистровСведений.СортироватьПоЗначению(НаправлениеСортировки.Возр);

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбновитьЗаголовокСтраницыРегистра(ЗаголовокСтраницыРегистрыНакопления, СписокРегистровНакопления);

	ОбновитьЗаголовокСтраницыРегистра(ЗаголовокСтраницыРегистрыСведений, СписокРегистровСведений);

КонецПроцедуры

#Область ПрочиеПроцедуры

&НаКлиенте
Процедура ОбновитьЗаголовокСтраницыРегистра(РеквизитЗаголовка, СписокРегистров)

	РеквизитЗаголовка = Строка(ПолучитьКоличествоПомеченных(СписокРегистров)) + "/" + Строка(СписокРегистров.Количество());

КонецПроцедуры

&НаКлиенте
Процедура СоздатьСписокРегистровДляКорректировки(РезультатСписок, СписокРегистров)

	Для Каждого Элемент Из СписокРегистров Цикл

		РегистрИспользуется = СписокИспользуемыхРегистров.НайтиПоЗначению(Элемент.Значение) <> Неопределено;
		// Необходимо отключить регистр.
		Если Элемент.Пометка И Не РегистрИспользуется Тогда

			РезультатСписок.Добавить(Элемент.Значение, Элемент.Представление, Истина);

		// Необходимо добавить регистр.
		ИначеЕсли Не Элемент.Пометка И РегистрИспользуется Тогда

			РезультатСписок.Добавить(Элемент.Значение, Элемент.Представление, Ложь);

		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьКоличествоПомеченных(СписокЗначений)

	Результат = 0;
	Для Каждого Элемент Из СписокЗначений Цикл
		Если Элемент.Пометка Тогда
			Результат = Результат + 1;
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;

КонецФункции

#КонецОбласти

#Область ОбработчикиКоманд

&НаКлиенте
Процедура ОК(Команда)

	Результат = Новый СписокЗначений;

	СоздатьСписокРегистровДляКорректировки(Результат, СписокРегистровНакопления);
	СоздатьСписокРегистровДляКорректировки(Результат, СписокРегистровСведений);

	Закрыть(Результат);

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

&НаКлиенте
Процедура СписокРегистровНакопленияПриИзменении(Элемент)

	ОбновитьЗаголовокСтраницыРегистра(ЗаголовокСтраницыРегистрыНакопления, СписокРегистровНакопления);

КонецПроцедуры

&НаКлиенте
Процедура СписокРегистровСведенийПриИзменении(Элемент)

	ОбновитьЗаголовокСтраницыРегистра(ЗаголовокСтраницыРегистрыСведений, СписокРегистровСведений);

КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

