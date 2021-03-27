﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//                          ИСПОЛЬЗОВАНИЕ ФОРМЫ                               //
//
// Форма предназначена для выбора объектов метаданных конфигурации и передачи
// выбранных их списка в вызывающую среду.
//
// Параметры вызова:
// КоллекцииВыбираемыхОбъектовМетаданных - СписокЗначений - фактически фильтр
//				по типам объектов метаданных, которые могут быть выбраны.
//				Например:
//					ФильтрПоСсылочнымМетаданным = Новый СписокЗначений;
//					ФильтрПоСсылочнымМетаданным.Добавить("Справочники");
//					ФильтрПоСсылочнымМетаданным.Добавить("Документы");
//				Позволяет выбирать только объекты метаданных справочники и документы.
// ВыбранныеОбъектыМетаданных - СписокЗначений - уже выбранные объекты метаданных.
//				В дереве метаданных такие объекты будут отмечены флажком выбора.
//				Может быть полезным для установки объектов метаданных выбора по умолчанию
//				или переустановки уже установленного списка.
// РодительскиеПодсистемы - СписокЗначений - подсистемы, только подчиненные подсистемы которых
// 				будут отображаться в форме (спец. для помощника внедрения БСП). 
// ТолькоПодсистемыСКИ - булево - признак того, что в списке выбора будут только те подсистемы, 
//				которые включены в командный интерфейс (спец. для помощника внедрения БСП).
// ВыборЕдинственного - булево - признак того, что выбирается единственный объект метаданных.
//              При этом пометка нескольких будет невозможна, кроме того двойной клик по строке
//              с объектом метаданных осуществит выбор.
// НачальноеЗначениеВыбора - Строка - полное имя метаданных, на котором будет спозиционирован
//              список при открытии формы.
//

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВыбранныеОбъектыМетаданных.ЗагрузитьЗначения(Параметры.ВыбранныеОбъектыМетаданных.ВыгрузитьЗначения());
	
	Если Параметры.ФильтрПоОбъектамМетаданных.Количество() > 0 Тогда
		Параметры.КоллекцииВыбираемыхОбъектовМетаданных.Очистить();
		Для Каждого ОбъектМетаданныхПолноеИмя Из Параметры.ФильтрПоОбъектамМетаданных Цикл
			ИмяБазовогоТипа = ОбщегоНазначения.ИмяБазовогоТипаПоОбъектуМетаданных(Метаданные.НайтиПоПолномуИмени(ОбъектМетаданныхПолноеИмя.Значение));
			Если Параметры.КоллекцииВыбираемыхОбъектовМетаданных.НайтиПоЗначению(ИмяБазовогоТипа) = Неопределено Тогда
				Параметры.КоллекцииВыбираемыхОбъектовМетаданных.Добавить(ИмяБазовогоТипа);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если Параметры.Свойство("ТолькоПодсистемыСКИ") И Параметры.ТолькоПодсистемыСКИ Тогда
		СписокПодсистем = Метаданные.Подсистемы;
		ЗаполнитьСписокПодсистем(СписокПодсистем);
		ТолькоПодсистемыСКИ = Истина;
	КонецЕсли;
	
	Если Параметры.Свойство("ВыборЕдинственного", ВыборЕдинственного) И ВыборЕдинственного Тогда
		Элементы.Пометка.Видимость = Ложь;
	КонецЕсли;
	
	Если Параметры.Свойство("Заголовок") Тогда
		АвтоЗаголовок = Ложь;
		Заголовок = Параметры.Заголовок;
	КонецЕсли;
	
	Параметры.Свойство("НачальноеЗначениеВыбора", НачальноеЗначениеВыбора);
	Если Не ЗначениеЗаполнено(НачальноеЗначениеВыбора)
		И ВыборЕдинственного
		И Параметры.ВыбранныеОбъектыМетаданных.Количество() = 1 Тогда
		НачальноеЗначениеВыбора = Параметры.ВыбранныеОбъектыМетаданных[0].Значение;
	КонецЕсли;
	
	ДеревоОбъектовМетаданныхЗаполнить();
	
	Если Параметры.РодительскиеПодсистемы.Количество()> 0 Тогда
		Элементы.ДеревоОбъектовМетаданных.НачальноеОтображениеДерева = НачальноеОтображениеДерева.РаскрыватьВсеУровни;
	КонецЕсли;
	
	НачальнаяПометкаКоллекций(ДеревоОбъектовМетаданных);
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиФормы.Верх;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Устанавливаем начальное значение выбора.
	Если ИдентификаторТекущейСтрокиПриОткрытии > 0 Тогда
		
		Элементы.ДеревоОбъектовМетаданных.ТекущаяСтрока = ИдентификаторТекущейСтрокиПриОткрытии;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Процедура обработчик события нажатия на поле "Пометка" дерева формы.
&НаКлиенте
Процедура ПометкаПриИзменении(Элемент)

	ТекущиеДанные = ТекущийЭлемент.ТекущиеДанные;
	Если ТекущиеДанные.Пометка = 2 Тогда
		ТекущиеДанные.Пометка = 0;
	КонецЕсли;
	ПометитьВложенныеЭлементы(ТекущиеДанные);
	ПометитьЭлементыРодителей(ТекущиеДанные);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоОбъектовМетаданных

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	Если ВыборЕдинственного Тогда
		
		ВыбратьВыполнить();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьВыполнить()
	
	Если ВыборЕдинственного Тогда
		
		ТекДанные = Элементы.ДеревоОбъектовМетаданных.ТекущиеДанные;
		Если ТекДанные <> Неопределено
			И ТекДанные.ЭтоОбъектМетаданных Тогда
			
			ВыбранныеОбъектыМетаданных.Очистить();
			ВыбранныеОбъектыМетаданных.Добавить(ТекДанные.ПолноеИмя, ТекДанные.Представление);
			
		Иначе
			
			Возврат;
			
		КонецЕсли;
	Иначе
		
		ВыбранныеОбъектыМетаданных.Очистить();
		
		ПолучениеДанных();
		
	КонецЕсли;
	Если ЭтотОбъект.ОписаниеОповещенияОЗакрытии = Неопределено Тогда
		Оповестить("ВыборОбъектовМетаданных", ВыбранныеОбъектыМетаданных, Параметры.УникальныйИдентификаторИсточник);
	КонецЕсли;
	Закрыть(ВыбранныеОбъектыМетаданных);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьВыполнить()
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписокПодсистем(СписокПодсистем) 
	Для Каждого Подсистема Из СписокПодсистем Цикл
		Если Подсистема.ВключатьВКомандныйИнтерфейс Тогда
			ЭлементыПодсистемСКоманднымИнтерфейсом.Добавить(Подсистема.ПолноеИмя());
		КонецЕсли;	
		
		Если Подсистема.Подсистемы.Количество() > 0 Тогда
			ЗаполнитьСписокПодсистем(Подсистема.Подсистемы);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

// Процедура заполняет дерево значений объектов конфигурации.
// Если список значений "Параметры.КоллекцииВыбираемыхОбъектовМетаданных" не пуст, тогда
// дерево будет ограничено переданным списком коллекций объектов метаданных.
//  Если объекты метаданных в сформированном дереве будут найдены в списке значений
// "Параметры.ВыбранныеОбъектыМетаданных", тогда они будут помечены, как выбранные.
//
&НаСервере
Процедура ДеревоОбъектовМетаданныхЗаполнить()
	
	КоллекцииОбъектовМетаданных = Новый ТаблицаЗначений;
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Имя");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Синоним");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Картинка");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("КартинкаОбъекта");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("ЭтоКоллекцияОбщие");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("ПолноеИмя");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Родитель");
	
	КоллекцииОбъектовМетаданных_НоваяСтрока("Подсистемы",                   НСтр("ru = 'Подсистемы'"),                     35, 36, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ОбщиеМодули",                  НСтр("ru = 'Общие модули'"),                   37, 38, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПараметрыСеанса",              НСтр("ru = 'Параметры сеанса'"),               39, 40, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Роли",                         НСтр("ru = 'Роли'"),                           41, 42, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПланыОбмена",                  НСтр("ru = 'Планы обмена'"),                   43, 44, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("КритерииОтбора",               НСтр("ru = 'Критерии отбора'"),                45, 46, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПодпискиНаСобытия",            НСтр("ru = 'Подписки на события'"),            47, 48, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегламентныеЗадания",          НСтр("ru = 'Регламентные задания'"),           49, 50, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ФункциональныеОпции",          НСтр("ru = 'Функциональные опции'"),           51, 52, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПараметрыФункциональныхОпций", НСтр("ru = 'Параметры функциональных опций'"), 53, 54, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ХранилищаНастроек",            НСтр("ru = 'Хранилища настроек'"),             55, 56, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ОбщиеФормы",                   НСтр("ru = 'Общие формы'"),                    57, 58, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ОбщиеКоманды",                 НСтр("ru = 'Общие команды'"),                  59, 60, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ГруппыКоманд",                 НСтр("ru = 'Группы команд'"),                  61, 62, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Интерфейсы",                   НСтр("ru = 'Интерфейсы'"),                     63, 64, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ОбщиеМакеты",                  НСтр("ru = 'Общие макеты'"),                   65, 66, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ОбщиеКартинки",                НСтр("ru = 'Общие картинки'"),                 67, 68, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПакетыXDTO",                   НСтр("ru = 'XDTO-пакеты'"),                    69, 70, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("WebСервисы",                   НСтр("ru = 'Web-сервисы'"),                    71, 72, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("WSСсылки",                     НСтр("ru = 'WS-ссылки'"),                      73, 74, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Стили",                        НСтр("ru = 'Стили'"),                          75, 76, Истина, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Языки",                        НСтр("ru = 'Языки'"),                          77, 78, Истина, КоллекцииОбъектовМетаданных);
	
	КоллекцииОбъектовМетаданных_НоваяСтрока("Константы",                    НСтр("ru = 'Константы'"),                      БиблиотекаКартинок.Константа,              БиблиотекаКартинок.Константа,                    Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Справочники",                  НСтр("ru = 'Справочники'"),                    БиблиотекаКартинок.Справочник,             БиблиотекаКартинок.Справочник,                   Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Документы",                    НСтр("ru = 'Документы'"),                      БиблиотекаКартинок.Документ,               БиблиотекаКартинок.ДокументОбъект,               Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ЖурналыДокументов",            НСтр("ru = 'Журналы документов'"),             БиблиотекаКартинок.ЖурналДокументов,       БиблиотекаКартинок.ЖурналДокументов,             Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Перечисления",                 НСтр("ru = 'Перечисления'"),                   БиблиотекаКартинок.Перечисление,           БиблиотекаКартинок.Перечисление,                 Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Отчеты",                       НСтр("ru = 'Отчеты'"),                         БиблиотекаКартинок.Отчет,                  БиблиотекаКартинок.Отчет,                        Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Обработки",                    НСтр("ru = 'Обработки'"),                      БиблиотекаКартинок.Обработка,              БиблиотекаКартинок.Обработка,                    Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПланыВидовХарактеристик",      НСтр("ru = 'Планы видов характеристик'"),      БиблиотекаКартинок.ПланВидовХарактеристик, БиблиотекаКартинок.ПланВидовХарактеристикОбъект, Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПланыСчетов",                  НСтр("ru = 'Планы счетов'"),                   БиблиотекаКартинок.ПланСчетов,             БиблиотекаКартинок.ПланСчетовОбъект,             Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("ПланыВидовРасчета",            НСтр("ru = 'Планы видов характеристик'"),      БиблиотекаКартинок.ПланВидовХарактеристик, БиблиотекаКартинок.ПланВидовХарактеристикОбъект, Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегистрыСведений",             НСтр("ru = 'Регистры сведений'"),              БиблиотекаКартинок.РегистрСведений,        БиблиотекаКартинок.РегистрСведений,              Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегистрыНакопления",           НСтр("ru = 'Регистры накопления'"),            БиблиотекаКартинок.РегистрНакопления,      БиблиотекаКартинок.РегистрНакопления,            Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегистрыБухгалтерии",          НСтр("ru = 'Регистры бухгалтерии'"),           БиблиотекаКартинок.РегистрБухгалтерии,     БиблиотекаКартинок.РегистрБухгалтерии,           Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("РегистрыРасчета",              НСтр("ru = 'Регистры расчета'"),               БиблиотекаКартинок.РегистрРасчета,         БиблиотекаКартинок.РегистрРасчета,               Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("БизнесПроцессы",               НСтр("ru = 'Бизнес-процессы'"),                БиблиотекаКартинок.БизнесПроцесс,          БиблиотекаКартинок.БизнесПроцессОбъект,          Ложь, КоллекцииОбъектовМетаданных);
	КоллекцииОбъектовМетаданных_НоваяСтрока("Задачи",                       НСтр("ru = 'Задачи'"),                         БиблиотекаКартинок.Задача,                 БиблиотекаКартинок.ЗадачаОбъект,                 Ложь, КоллекцииОбъектовМетаданных);
	
	// Создание предопределенных элементов.
	ПараметрыЭлемента = ПараметрыЭлементаДереваОбъектовМетаданных();
	ПараметрыЭлемента.Имя = Метаданные.Имя;
	ПараметрыЭлемента.Синоним = Метаданные.Синоним;
	ПараметрыЭлемента.Картинка = 79;
	ПараметрыЭлемента.Родитель = ДеревоОбъектовМетаданных;
	ЭлементКонфигурация = НоваяСтрокаДерева(ПараметрыЭлемента);
	
	ПараметрыЭлемента = ПараметрыЭлементаДереваОбъектовМетаданных();
	ПараметрыЭлемента.Имя = "Общие";
	ПараметрыЭлемента.Синоним = НСтр("ru = 'Общие'");
	ПараметрыЭлемента.Картинка = 0;
	ПараметрыЭлемента.Родитель = ЭлементКонфигурация;
	ЭлементОбщие = НоваяСтрокаДерева(ПараметрыЭлемента);
	
	// Заполнение дерева объектов метаданных.
	Для Каждого Строка Из КоллекцииОбъектовМетаданных Цикл
		Если Параметры.КоллекцииВыбираемыхОбъектовМетаданных.Количество() = 0
			Или Параметры.КоллекцииВыбираемыхОбъектовМетаданных.НайтиПоЗначению(Строка.Имя) <> Неопределено Тогда
			Строка.Родитель = ?(Строка.ЭтоКоллекцияОбщие, ЭлементОбщие, ЭлементКонфигурация);
			ДобавитьЭлементДереваОбъектовМетаданных(Строка, ?(Строка.Имя = "Подсистемы", Метаданные.Подсистемы, Неопределено));
		КонецЕсли;
	КонецЦикла;
	
	Если ЭлементОбщие.ПолучитьЭлементы().Количество() = 0 Тогда
		ЭлементКонфигурация.ПолучитьЭлементы().Удалить(ЭлементОбщие);
	КонецЕсли;
	
КонецПроцедуры

// Возвращает новую структуру параметров элемента дерева объектов метаданных.
//
// Возвращаемое значение:
//   Структура с полями:
//     Имя           - Строка - имя родительского элемента.
//     Синоним       - Строка - синоним родительского элемента.
//     Пометка       - Булево - начальная пометка коллекции или объекта метаданных.
//     Картинка      - Число - код картинки родительского элемента.
//     КартинкаОбъекта - Число - код картинки подэлемента.
//     Родитель        - ссылка на элемента дерева значений, который является корнем
//                       для добавляемого элемента.
//
&НаСервере
Функция ПараметрыЭлементаДереваОбъектовМетаданных()
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Имя", "");
	СтруктураПараметров.Вставить("ПолноеИмя", "");
	СтруктураПараметров.Вставить("Синоним", "");
	СтруктураПараметров.Вставить("Пометка", 0);
	СтруктураПараметров.Вставить("Картинка", 0);
	СтруктураПараметров.Вставить("КартинкаОбъекта", Неопределено);
	СтруктураПараметров.Вставить("Родитель", Неопределено);
	
	Возврат СтруктураПараметров;
	
КонецФункции

// Добавляет новую строку в дерево значений формы (дерево),
// а также заполняет полный набор строк из метаданных по переданному параметру.
//
// Если параметр Подсистемы заполнен, то вызывается рекурсивно для всех дочерних подсистем.
//
// Параметры:
//   ПараметрыЭлемента - Структура с полями:
//     Имя           - Строка - имя родительского элемента.
//     Синоним       - Строка - синоним родительского элемента.
//     Пометка       - Булево - начальная пометка коллекции или объекта метаданных.
//     Картинка      - Число - код картинки родительского элемента.
//     КартинкаОбъекта - Число - код картинки подэлемента.
//     Родитель        - ссылка на элемента дерева значений, который является корнем
//                       для добавляемого элемента.
//   Подсистемы      - если заполнен, то содержит значение Метаданные.Подсистемы (коллекцию элементов).
//   Проверять       - Булево - признак проверки на принадлежность родительским подсистемам.
// 
// Возвращаемое значение:
// 
//   Строка дерева объектов метаданных.
//
&НаСервере
Функция ДобавитьЭлементДереваОбъектовМетаданных(ПараметрыЭлемента, Подсистемы = Неопределено, Проверять = Истина)
	
	// Проверка на наличие командного интерфейса только в листьях дерева.
	Если Подсистемы <> Неопределено  И Параметры.Свойство("ТолькоПодсистемыСКИ") 
		И Не ПустаяСтрока(ПараметрыЭлемента.ПолноеИмя) 
		И ЭлементыПодсистемСКоманднымИнтерфейсом.НайтиПоЗначению(ПараметрыЭлемента.ПолноеИмя) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если Подсистемы = Неопределено Тогда
		
		Если Метаданные[ПараметрыЭлемента.Имя].Количество() = 0 Тогда
			
			// Если нет ни одного объекта метаданных из нужной ветки. 
			// Например, нет ни одного регистра бухгалтерии,
			// то корень "Регистры бухгалтерии" добавлять не нужно.
			Возврат Неопределено;
			
		КонецЕсли;
		
		НоваяСтрока = НоваяСтрокаДерева(ПараметрыЭлемента, Подсистемы <> Неопределено И Подсистемы <> Метаданные.Подсистемы);
		
		Для Каждого ЭлементКоллекцииМетаданных Из Метаданные[ПараметрыЭлемента.Имя] Цикл
			
			Если Параметры.ФильтрПоОбъектамМетаданных.Количество() > 0
				И Параметры.ФильтрПоОбъектамМетаданных.НайтиПоЗначению(ЭлементКоллекцииМетаданных.ПолноеИмя()) = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			ПараметрыЭлемента = ПараметрыЭлементаДереваОбъектовМетаданных();
			ПараметрыЭлемента.Имя = ЭлементКоллекцииМетаданных.Имя;
			ПараметрыЭлемента.ПолноеИмя = ЭлементКоллекцииМетаданных.ПолноеИмя();
			ПараметрыЭлемента.Синоним = ЭлементКоллекцииМетаданных.Синоним;
			ПараметрыЭлемента.Родитель = НоваяСтрока;
			НоваяСтрокаДерева(ПараметрыЭлемента, Истина);
		КонецЦикла;
		
		Возврат НоваяСтрока;
		
	КонецЕсли;
		
	Если Подсистемы.Количество() = 0 И ПараметрыЭлемента.Имя = "Подсистемы" Тогда
		// Если нет ни одной подсистемы, то корень "Подсистемы" добавлять не нужно.
		Возврат Неопределено;
	КонецЕсли;
	
	НоваяСтрока = НоваяСтрокаДерева(ПараметрыЭлемента, Подсистемы <> Неопределено И Подсистемы <> Метаданные.Подсистемы);
	
	Для Каждого ЭлементКоллекцииМетаданных Из Подсистемы Цикл
		
		Если Не Проверять
			Или Параметры.РодительскиеПодсистемы.Количество() = 0
			Или Параметры.РодительскиеПодсистемы.НайтиПоЗначению(ЭлементКоллекцииМетаданных.Имя) <> Неопределено Тогда
			
			ПараметрыЭлемента = ПараметрыЭлементаДереваОбъектовМетаданных();
			ПараметрыЭлемента.Имя = ЭлементКоллекцииМетаданных.Имя;
			ПараметрыЭлемента.ПолноеИмя = ЭлементКоллекцииМетаданных.ПолноеИмя();
			ПараметрыЭлемента.Синоним = ЭлементКоллекцииМетаданных.Синоним;
			ПараметрыЭлемента.Родитель = НоваяСтрока;
			ДобавитьЭлементДереваОбъектовМетаданных(ПараметрыЭлемента, ЭлементКоллекцииМетаданных.Подсистемы, Ложь);
		КонецЕсли;
	КонецЦикла;
	
	Возврат НоваяСтрока;
	
КонецФункции

&НаСервере
Функция НоваяСтрокаДерева(ПараметрыСтроки, ЭтоОбъектМетаданных = Ложь)
	
	Коллекция = ПараметрыСтроки.Родитель.ПолучитьЭлементы();
	НоваяСтрока = Коллекция.Добавить();
	НоваяСтрока.Имя                 = ПараметрыСтроки.Имя;
	НоваяСтрока.Представление       = ?(ЗначениеЗаполнено(ПараметрыСтроки.Синоним), ПараметрыСтроки.Синоним, ПараметрыСтроки.Имя);
	НоваяСтрока.Пометка             = ?(Параметры.ВыбранныеОбъектыМетаданных.НайтиПоЗначению(ПараметрыСтроки.ПолноеИмя) = Неопределено, 0, 1);
	НоваяСтрока.Картинка            = ПараметрыСтроки.Картинка;
	НоваяСтрока.ПолноеИмя           = ПараметрыСтроки.ПолноеИмя;
	НоваяСтрока.ЭтоОбъектМетаданных = ЭтоОбъектМетаданных;
	
	Если НоваяСтрока.ЭтоОбъектМетаданных 
		И НоваяСтрока.ПолноеИмя = НачальноеЗначениеВыбора Тогда
		ИдентификаторТекущейСтрокиПриОткрытии = НоваяСтрока.ПолучитьИдентификатор();
	КонецЕсли;
	
	Возврат НоваяСтрока;
	
КонецФункции

// Добавляет новую строку в таблицу значений видов объектов метаданных
// конфигурации.
//
// Параметры:
//   Имя           - имя объекта метаданных или вида объекта метаданных.
//   Синоним       - синоним объекта метаданных.
//   Картинка      - картинка поставленная в соответствие объекту метаданных
//                 или виду объекта метаданных.
//   ЭтоКоллекцияОбщие - признак того, что текущий элемент содержит подэлементы.
//
&НаСервере
Процедура КоллекцииОбъектовМетаданных_НоваяСтрока(Имя, Синоним, Картинка, КартинкаОбъекта, ЭтоКоллекцияОбщие, Таб)
	
	НоваяСтрока = Таб.Добавить();
	НоваяСтрока.Имя               = Имя;
	НоваяСтрока.Синоним           = Синоним;
	НоваяСтрока.Картинка          = Картинка;
	НоваяСтрока.КартинкаОбъекта   = КартинкаОбъекта;
	НоваяСтрока.ЭтоКоллекцияОбщие = ЭтоКоллекцияОбщие;
	
КонецПроцедуры

// Процедура рекурсивно устанавливает/снимает пометку для родителей передаваемого элемента.
//
// Параметры:
//   Элемент      - ДанныеФормыКоллекцияЭлементовДерева.
//
&НаКлиенте
Процедура ПометитьЭлементыРодителей(Элемент)

	Родитель = Элемент.ПолучитьРодителя();
	
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЭлементыРодителя = Родитель.ПолучитьЭлементы();
	Если ЭлементыРодителя.Количество() = 0 Тогда
		Родитель.Пометка = 0;
	ИначеЕсли Элемент.Пометка = 2 Тогда
		Родитель.Пометка = 2;
	Иначе
		Родитель.Пометка = ЗначениеПометкиЭлементов(ЭлементыРодителя);
	КонецЕсли;
	
	ПометитьЭлементыРодителей(Родитель);
	
КонецПроцедуры

&НаКлиенте
Функция ЗначениеПометкиЭлементов(ЭлементыРодителя)
	
	ЕстьПомеченные    = Ложь;
	ЕстьНепомеченные = Ложь;
	
	Для каждого ЭлементРодителя Из ЭлементыРодителя Цикл
		
		Если ЭлементРодителя.Пометка = 2 ИЛИ (ЕстьПомеченные И ЕстьНепомеченные) Тогда
			ЕстьПомеченные    = Истина;
			ЕстьНепомеченные = Истина;
			Прервать;
		ИначеЕсли ЭлементРодителя.ЭтоОбъектМетаданных Тогда
			ЕстьПомеченные    = ЕстьПомеченные    ИЛИ    ЭлементРодителя.Пометка;
			ЕстьНепомеченные = ЕстьНепомеченные ИЛИ НЕ ЭлементРодителя.Пометка;
		Иначе
			ВложенныеЭлементы = ЭлементРодителя.ПолучитьЭлементы();
			Если ВложенныеЭлементы.Количество() = 0 Тогда
				Продолжить;
			КонецЕсли;
			ЗначениеПометкиВложенныхЭлементов = ЗначениеПометкиЭлементов(ВложенныеЭлементы);
			ЕстьПомеченные    = ЕстьПомеченные    ИЛИ    ЭлементРодителя.Пометка ИЛИ    ЗначениеПометкиВложенныхЭлементов;
			ЕстьНепомеченные = ЕстьНепомеченные ИЛИ НЕ ЭлементРодителя.Пометка ИЛИ НЕ ЗначениеПометкиВложенныхЭлементов;
		КонецЕсли;
	КонецЦикла;
	
	Если ЕстьПомеченные Тогда
		Если ЕстьНепомеченные Тогда
			Возврат 2;
		Иначе
			Если ТолькоПодсистемыСКИ Тогда
				Возврат 2;
			Иначе
				Возврат 1;
			КонецЕсли;
		КонецЕсли;
	Иначе
		Возврат 0;
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ПометитьЭлементыРодителейНаСервере(Элемент)

	Родитель = Элемент.ПолучитьРодителя();
	
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЭлементыРодителя = Родитель.ПолучитьЭлементы();
	Если ЭлементыРодителя.Количество() = 0 Тогда
		Родитель.Пометка = 0;
	ИначеЕсли Элемент.Пометка = 2 Тогда
		Родитель.Пометка = 2;
	Иначе
		Родитель.Пометка = ЗначениеПометкиЭлементовНаСервере(ЭлементыРодителя);
	КонецЕсли;
	
	ПометитьЭлементыРодителейНаСервере(Родитель);

КонецПроцедуры

&НаСервере
Функция ЗначениеПометкиЭлементовНаСервере(ЭлементыРодителя)
	
	ЕстьПомеченные    = Ложь;
	ЕстьНепомеченные = Ложь;
	
	Для каждого ЭлементРодителя Из ЭлементыРодителя Цикл
		
		Если ЭлементРодителя.Пометка = 2 ИЛИ (ЕстьПомеченные И ЕстьНепомеченные) Тогда
			ЕстьПомеченные    = Истина;
			ЕстьНепомеченные = Истина;
			Прервать;
		ИначеЕсли ЭлементРодителя.ЭтоОбъектМетаданных Тогда
			ЕстьПомеченные    = ЕстьПомеченные    ИЛИ    ЭлементРодителя.Пометка;
			ЕстьНепомеченные = ЕстьНепомеченные ИЛИ НЕ ЭлементРодителя.Пометка;
		Иначе
			ВложенныеЭлементы = ЭлементРодителя.ПолучитьЭлементы();
			Если ВложенныеЭлементы.Количество() = 0 Тогда
				Продолжить;
			КонецЕсли;
			ЗначениеПометкиВложенныхЭлементов = ЗначениеПометкиЭлементовНаСервере(ВложенныеЭлементы);
			ЕстьПомеченные    = ЕстьПомеченные    ИЛИ    ЭлементРодителя.Пометка ИЛИ    ЗначениеПометкиВложенныхЭлементов;
			ЕстьНепомеченные = ЕстьНепомеченные ИЛИ НЕ ЭлементРодителя.Пометка ИЛИ НЕ ЗначениеПометкиВложенныхЭлементов;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ?(ЕстьПомеченные И ЕстьНепомеченные, 2, ?(ЕстьПомеченные, 1, 0));
	
КонецФункции

// Процедура НачальнаяПометкаКоллекций устанавливает пометку для коллекций
// объектов метаданных, которые не имеют объектов метаданных (истина) и 
// которые имеют объекты метаданных с заданной пометкой.
//
// Параметры:
//   Элемент      - ДанныеФормыКоллекцияЭлементовДерева.
//
&НаСервере
Процедура НачальнаяПометкаКоллекций(Родитель)
	
	ВложенныеЭлементы = Родитель.ПолучитьЭлементы();
	
	Для Каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
		Если ВложенныйЭлемент.Пометка Тогда
			ПометитьЭлементыРодителейНаСервере(ВложенныйЭлемент);
		КонецЕсли;
		НачальнаяПометкаКоллекций(ВложенныйЭлемент);
	КонецЦикла;
	
КонецПроцедуры

// Процедура рекурсивно устанавливает/снимает пометку для вложенных элементов начиная
// с передаваемого элемента.
//
// Параметры:
//   Элемент      - ДанныеФормыКоллекцияЭлементовДерева.
//
&НаКлиенте
Процедура ПометитьВложенныеЭлементы(Элемент)

	ВложенныеЭлементы = Элемент.ПолучитьЭлементы();
	
	Если ВложенныеЭлементы.Количество() = 0 Тогда
		Если Не Элемент.ЭтоОбъектМетаданных Тогда
			Элемент.Пометка = 0;
		КонецЕсли;
	Иначе
		Для Каждого ВложенныйЭлемент Из ВложенныеЭлементы Цикл
			Если Не ТолькоПодсистемыСКИ Тогда
				ВложенныйЭлемент.Пометка = Элемент.Пометка;
			КонецЕсли;
			ПометитьВложенныеЭлементы(ВложенныйЭлемент);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// Процедура для заполнения списка выбранных элементов дерева.
// Рекурсивно просматривает все дерево элементов и в случае, если элемент
// выбран добавляет его ПолноеИмя в список выбранных.
//
// Родитель      - ДанныеФормыЭлементДерева
//
&НаСервере
Процедура ПолучениеДанных(Родитель = Неопределено)
	
	Родитель = ?(Родитель = Неопределено, ДеревоОбъектовМетаданных, Родитель);
	
	КоллекцияЭлементов = Родитель.ПолучитьЭлементы();
	
	Для Каждого Элемент Из КоллекцияЭлементов Цикл
		Если Элемент.Пометка = 1 И Не ПустаяСтрока(Элемент.ПолноеИмя) Тогда
			ВыбранныеОбъектыМетаданных.Добавить(Элемент.ПолноеИмя, Элемент.Представление);
		КонецЕсли;
		ПолучениеДанных(Элемент);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
