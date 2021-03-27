﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Настройки размещения в панели отчетов.
//
// Параметры:
//   Настройки - Коллекция - Используется для описания настроек отчетов и вариантов
//       см. описание к ВариантыОтчетов.ДеревоНастроекВариантовОтчетовКонфигурации().
//   НастройкиОтчета - СтрокаДереваЗначений - Настройки размещения всех вариантов отчета.
//       См. "Реквизиты для изменения" функции ВариантыОтчетов.ДеревоНастроекВариантовОтчетовКонфигурации().
//
// Описание:
//   См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
// Вспомогательные методы:
//   НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//   ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Истина/Ложь); 
// Отчет
//   поддерживает только этот режим.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Основной");
	
	НастройкиВарианта.ФункциональныеОпции.Добавить("ВестиСведенияДляДекларацийПоАлкогольнойПродукции");
	НастройкиВарианта.ВидимостьПоУмолчанию = Истина;
	НастройкиВарианта.Описание = НСтр("ru='Реквизиты организации в системе ЕГАИС на произвольную дату.'");
	
	НастройкиВарианта.Размещение.Вставить(Метаданные.Подсистемы.ГосИС.Подсистемы.ЕГАИС.Подсистемы.ОтчетыЕГАИС);
	
КонецПроцедуры

// Возвращает внешний набор данных для построения отчета.
//
// Параметры:
//  СписокОтчетов - Массив - массив документов ОтчетЕГАИС.
//
// Возвращаемое значение:
//  ТаблицаЗначений - внешний набор данных.
//
Функция ДанныеИнформационнойБазы(СписокОтчетов) Экспорт
	
	Результат = Новый ТаблицаЗначений;
	Результат.Колонки.Добавить("ОрганизацияЕГАИС", Новый ОписаниеТипов("СправочникСсылка.КлассификаторОрганизацийЕГАИС"));
	Результат.Колонки.Добавить("КодФСРАР"        , Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("Период"          , Новый ОписаниеТипов("Дата"));
	Результат.Колонки.Добавить("Реквизит"        , Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("ЗначениеИБ");
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ОтчетЕГАИС", СписокОтчетов);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	КлассификаторОрганизацийЕГАИС.Контрагент КАК Контрагент,
	|	ВЫБОР
	|		КОГДА ТИПЗНАЧЕНИЯ(ОтчетЕГАИС.КодФСРАР) = ТИП(СТРОКА)
	|			ТОГДА ОтчетЕГАИС.КодФСРАР
	|		ИНАЧЕ ОтчетЕГАИС.КодФСРАР.Код
	|	КОНЕЦ КАК КодФСРАР,
	|	ОтчетЕГАИС.Период КАК Период,
	|	ЕСТЬNULL(КлассификаторОрганизацийЕГАИС.Ссылка, ЗНАЧЕНИЕ(Справочник.КлассификаторОрганизацийЕГАИС.ПустаяСсылка)) КАК ОрганизацияЕГАИС
	|ИЗ
	|	Документ.ОтчетЕГАИС КАК ОтчетЕГАИС
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КлассификаторОрганизацийЕГАИС КАК КлассификаторОрганизацийЕГАИС
	|		ПО (ВЫБОР
	|				КОГДА ТИПЗНАЧЕНИЯ(ОтчетЕГАИС.КодФСРАР) = ТИП(СТРОКА)
	|					ТОГДА ОтчетЕГАИС.КодФСРАР = КлассификаторОрганизацийЕГАИС.Код
	|				ИНАЧЕ ОтчетЕГАИС.КодФСРАР = КлассификаторОрганизацийЕГАИС.Ссылка
	|			КОНЕЦ)
	|ГДЕ
	|	ОтчетЕГАИС.Ссылка В(&ОтчетЕГАИС)
	|	И ЕСТЬNULL(КлассификаторОрганизацийЕГАИС.Сопоставлено, ЛОЖЬ)";
	
	ТаблицаЗапроса = Запрос.Выполнить().Выгрузить();
	
	Контрагенты = ТаблицаЗапроса.ВыгрузитьКолонку("Контрагент");
	
	НаборРеквизитов = СтруктураРеквизитовКонтрагента();
	
	РеквизитыКонтрагентов = Новый Соответствие;
	ОтчетыЕГАИСПереопределяемый.ЗаполнитьРеквизитыКонтрагентов(РеквизитыКонтрагентов, Контрагенты, НаборРеквизитов);
	
	Отчет = Отчеты.ИнформацияОбОрганизацииЕГАИС.Создать();
	
	Для Каждого СтрокаЗапроса Из ТаблицаЗапроса Цикл
		
		РеквизитыКонтрагента = РеквизитыКонтрагентов[СтрокаЗапроса.Контрагент];
		Если РеквизитыКонтрагента <> Неопределено Тогда
			Для Каждого КлючЗначение Из РеквизитыКонтрагента Цикл
				СтрокаТаблицы = Результат.Добавить();
				СтрокаТаблицы.ОрганизацияЕГАИС = СтрокаЗапроса.ОрганизацияЕГАИС;
				СтрокаТаблицы.КодФСРАР         = СтрокаЗапроса.КодФСРАР;
				СтрокаТаблицы.Период           = СтрокаЗапроса.Период;
				СтрокаТаблицы.Реквизит         = ОтчетыЕГАИС.ЗначениеПараметраКомпоновкиДанных(Отчет.КомпоновщикНастроек.ПолучитьНастройки(), КлючЗначение.Ключ + "Представление");
				СтрокаТаблицы.ЗначениеИБ       = КлючЗначение.Значение;
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Возвращает Истина в случае наличия расхождений между полученными данными и данными ИБ. Ложь - в противном случае.
//
Функция ЕстьРасхожденияВПолученныхДанных(ДокументСсылка) Экспорт
	
	Возврат ОтчетыЕГАИС.ЕстьРасхожденияВПолученныхДанных(ДокументСсылка, Метаданные.Отчеты.ИнформацияОбОрганизацииЕГАИС.Имя);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Инициализирует структуру реквизитов контрагента для дальнейшего заполнения.
//
Функция СтруктураРеквизитовКонтрагента()
	
	Результат = Новый Структура;
	Результат.Вставить("ТипОрганизации");
	Результат.Вставить("Наименование");
	Результат.Вставить("НаименованиеПолное");
	Результат.Вставить("ИНН");
	Результат.Вставить("КПП");
	Результат.Вставить("КодСтраны");
	Результат.Вставить("КодРегиона");
	Результат.Вставить("ПочтовыйИндекс");
	Результат.Вставить("Адрес");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли