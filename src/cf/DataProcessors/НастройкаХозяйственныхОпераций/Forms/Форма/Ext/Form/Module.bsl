﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Автотест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ОбщегоНазначенияКлиентСервер.РежимОтладки() Тогда
		ТекстСообщения = НСтр("ru = 'Запуск обработки возможен только при использовании параметра запуска ""РежимОтладки"".'");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	// Заполним имена колонок
	Колонки = Новый Соответствие;
	Колонки.Вставить("НастройкиПредопределенныхЭлементов", 
					"ID,Описание,ИсточникДанных,ПредставлениеИсточникаДанных,Приход,Расход,ХозяйственнаяОперация,"+
					"ИспользоватьВБюджетировании,ИспользоватьВМеждународномУчете,ИспользоватьДляВыбора,ИспользоватьВРеестреДокументов,ИспользоватьДляОграниченийДоступа");
	Колонки.Вставить("СвязанныеДокументы", "OwnerID,ИмяДокумента,ПредставлениеДокумента");
	Колонки.Вставить("ФункциональныеОпции", "OwnerID,ИмяФункциональнойОпции");
	КолонкиТаблиц = Новый ФиксированноеСоответствие(Колонки);
	
	// Соответствие значений перечисления строковым именам значений
	СоответствиеТипов = Новый Соответствие;
	ЗначенияПеречисления = Метаданные.Перечисления.ТипыДанныхУчета.ЗначенияПеречисления;
	СоответствиеТипов.Вставить(Перечисления.ТипыДанныхУчета.ПустаяСсылка(), "");
	Для Каждого Значение Из ЗначенияПеречисления Цикл
		Имя = Значение.Имя;
		СоответствиеТипов.Вставить(Перечисления.ТипыДанныхУчета[Имя], Имя);
	КонецЦикла;
	ТипДанныхУчетаСтрокой = Новый ФиксированноеСоответствие(СоответствиеТипов);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормыЭлемента = Новый Структура;
	ПараметрыФормыЭлемента.Вставить("РучнаяНастройка");
	ПараметрыФормыЭлемента.Вставить("Ключ", ВыбраннаяСтрока);
	
	ОткрытьФорму("Справочник.НастройкиХозяйственныхОпераций.ФормаОбъекта", ПараметрыФормыЭлемента, ЭтотОбъект); 
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СформироватьМакеты(Команда)
	
	НовыеМакеты = СформироватьМакетыНаСервере();
	Для Каждого Макет Из НовыеМакеты Цикл
		
		ТекстДок = Новый ТекстовыйДокумент;
		ТекстДок.УстановитьТекст(Макет.Значение);
		ТекстДок.Показать(Макет.Ключ);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПредопределенныеЭлементы(Команда)
	
	ЗаполнитьНастройкиНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция СформироватьМакетыНаСервере(ИмяТаблицы = "")
	
	Данные = Новый Структура;
	Если ПустаяСтрока(ИмяТаблицы) Тогда
		ИмяТаблицы = "НастройкиПредопределенныхЭлементов";
		Данные.Вставить(ИмяТаблицы,ЗаписатьВXML(ИмяТаблицы));
		
		ИмяТаблицы = "СвязанныеДокументы";
		Данные.Вставить(ИмяТаблицы,ЗаписатьВXML(ИмяТаблицы));
		
		ИмяТаблицы = "ФункциональныеОпции";
		Данные.Вставить(ИмяТаблицы,ЗаписатьВXML(ИмяТаблицы));
		
	Иначе
		Данные.Вставить(ИмяТаблицы,ЗаписатьВXML(ИмяТаблицы));
		
	КонецЕсли;
	
	Возврат Данные;
	
КонецФункции

&НаСервере
Функция ЗаписатьВXML(ИмяТаблицы)
	
	Если ИмяТаблицы = "НастройкиПредопределенныхЭлементов" Тогда
		ДанныеМакета = НастройкиПредопределенныхЭлементов();
		Сортировка = "ID";
	ИначеЕсли ИмяТаблицы = "СвязанныеДокументы" Тогда
		ДанныеМакета = СвязанныеДокументы();
		Сортировка = "OwnerID,ИмяДокумента";
	ИначеЕсли ИмяТаблицы = "ФункциональныеОпции" Тогда
		ДанныеМакета = ФункциональныеОпции();
		Сортировка = "OwnerID,ИмяФункциональнойОпции";
	КонецЕсли;
	ДанныеМакета.Сортировать(Сортировка);
	
	ИменаКолонокСтр = КолонкиТаблиц[ИмяТаблицы];
	ИменаКолонок = СтрРазделить(ИменаКолонокСтр,",");
	
	Запись = Новый ЗаписьXML;
	Запись.УстановитьСтроку("UTF-8");
	Запись.ЗаписатьНачалоЭлемента("Items");
	Запись.ЗаписатьАтрибут("Description", ИмяТаблицы);
	Запись.ЗаписатьАтрибут("Columns",     ИменаКолонокСтр);
	
	Для Каждого Данные Из ДанныеМакета Цикл
		Запись.ЗаписатьНачалоЭлемента("Item");
		Для Каждого Колонка Из ИменаКолонок Цикл
				
			Если Колонка = "Приход" ИЛИ Колонка = "Расход" Тогда
				Запись.ЗаписатьАтрибут(Колонка, ТипДанныхУчетаСтрокой[Данные[Колонка]]);
			Иначе
				Запись.ЗаписатьАтрибут(Колонка, Данные[Колонка]);
			КонецЕсли;
			
		КонецЦикла;
		Запись.ЗаписатьКонецЭлемента();
	КонецЦикла;
	
	Запись.ЗаписатьКонецЭлемента();
	Текст = Запись.Закрыть();
	Возврат Текст;
	
КонецФункции

&НаСервере
Функция НастройкиПредопределенныхЭлементов()
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Настройки.Ссылка КАК Ссылка,
	|	Настройки.ИмяПредопределенныхДанных КАК ID,
	|	Настройки.Описание КАК Описание,
	|	Настройки.ИсточникДанных КАК ИсточникДанных,
	|	Настройки.ПредставлениеИсточникаДанных КАК ПредставлениеИсточникаДанных,
	|	Настройки.Приход КАК Приход,
	|	Настройки.Расход КАК Расход,
	|	Настройки.ИмяПредопределенныхДанных КАК ХозяйственнаяОперация,
	|	ВЫБОР
	|		КОГДА Настройки.ИспользоватьВБюджетировании
	|			ТОГДА ""Да""
	|		ИНАЧЕ ""Нет""
	|	КОНЕЦ КАК ИспользоватьВБюджетировании,
	|	ВЫБОР
	|		КОГДА Настройки.ИспользоватьВМеждународномУчете
	|			ТОГДА ""Да""
	|		ИНАЧЕ ""Нет""
	|	КОНЕЦ КАК ИспользоватьВМеждународномУчете,
	|	ВЫБОР
	|		КОГДА Настройки.ИспользоватьДляВыбора
	|			ТОГДА ""Да""
	|		ИНАЧЕ ""Нет""
	|	КОНЕЦ КАК ИспользоватьДляВыбора,
	|	ВЫБОР
	|		КОГДА Настройки.ИспользоватьВРеестреДокументов
	|			ТОГДА ""Да""
	|		ИНАЧЕ ""Нет""
	|	КОНЕЦ КАК ИспользоватьВРеестреДокументов,
	|	ВЫБОР
	|		КОГДА Настройки.ИспользоватьДляОграниченийДоступа
	|			ТОГДА ""Да""
	|		ИНАЧЕ ""Нет""
	|	КОНЕЦ КАК ИспользоватьДляОграниченийДоступа
	|ИЗ
	|	Справочник.НастройкиХозяйственныхОпераций КАК Настройки
	|ГДЕ
	|	НЕ Настройки.ЭтоГруппа
	|	И Настройки.Предопределенный");
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

&НаСервере
Функция СвязанныеДокументы()
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	СвязанныеДокументы.Ссылка.ИмяПредопределенныхДанных КАК OwnerID,
	|	ЕСТЬNULL(ИдентификаторыМетаданных.Имя, """") КАК ИмяДокумента,
	|	ЕСТЬNULL(ИдентификаторыМетаданных.Синоним, """") КАК ПредставлениеДокумента
	|ИЗ
	|	Справочник.НастройкиХозяйственныхОпераций.Документы КАК СвязанныеДокументы
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ИдентификаторыОбъектовМетаданных КАК ИдентификаторыМетаданных
	|		ПО (СвязанныеДокументы.ИдентификаторОбъектаМетаданных = ИдентификаторыМетаданных.Ссылка)
	|ГДЕ
	|	НЕ СвязанныеДокументы.Ссылка.ЭтоГруппа
	|	И СвязанныеДокументы.Ссылка.Предопределенный");
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

&НаСервере
Функция ФункциональныеОпции()
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ФО.Ссылка.ИмяПредопределенныхДанных КАК OwnerID,
	|	ФО.ИмяФункциональнойОпции КАК ИмяФункциональнойОпции
	|ИЗ
	|	Справочник.НастройкиХозяйственныхОпераций.ФункциональныеОпции КАК ФО
	|ГДЕ
	|	НЕ ФО.Ссылка.ЭтоГруппа
	|	И ФО.Ссылка.Предопределенный");
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

&НаСервере
Процедура ЗаполнитьНастройкиНаСервере()
	
	Справочники.НастройкиХозяйственныхОпераций.ЗаполнитьПредопределенныеНастройкиХозяйственныхОпераций();
	
КонецПроцедуры

#КонецОбласти