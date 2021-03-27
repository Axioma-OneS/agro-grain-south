﻿
#Область ПрограммныйИнтерфейс

#Область ЭтикеткиИЦенники

// Получает данные для печати и открывает форму Обработка.ПечатьЭтикетокИЦенников.Форма.ФормаТовары.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьЭтикетокИЦенников(ОписаниеКоманды) Экспорт
	
	ДополнительныеПараметры = Новый Структура("МенеджерПечати", ОписаниеКоманды.МенеджерПечати);
	
	АдресВХранилище =
		УправлениеПечатьюУТВызовСервера.ДанныеДляПечатиЦенниковИЭтикеток(
			ОписаниеКоманды.Идентификатор,
			ОписаниеКоманды.ОбъектыПечати,
			ДополнительныеПараметры);
	
	ОткрытьФорму(
		"Обработка.ПечатьЭтикетокИЦенников.Форма.ФормаТовары",
		Новый Структура("АдресВХранилище, НазначениеШаблона", АдресВХранилище, Неопределено),
		ОписаниеКоманды.Форма,
		Новый УникальныйИдентификатор);
	
КонецФункции

// Получает данные для печати и открывает форму Обработка.ПечатьЭтикетокИЦенников.Форма.ФормаСкладскиеЯчейки.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьЭтикетокСкладскиеЯчейки(ОписаниеКоманды) Экспорт
	
	АдресВХранилище =
		УправлениеПечатьюУТВызовСервера.ДанныеДляПечатиЭтикетокСкладскиеЯчейки(
			ОписаниеКоманды.Идентификатор,
			ОписаниеКоманды.ОбъектыПечати);
	
	ОткрытьФорму(
		"Обработка.ПечатьЭтикетокИЦенников.Форма.ФормаСкладскиеЯчейки",
		Новый Структура("АдресВХранилище, НазначениеШаблона", АдресВХранилище, Неопределено),
		ОписаниеКоманды.Форма,
		Новый УникальныйИдентификатор);
	
КонецФункции

// Печать этикеток доставки.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьЭтикетокДоставки(ОписаниеКоманды) Экспорт
	
	ОчиститьСообщения();
	
	СтруктураВозврата = УправлениеПечатьюУТВызовСервера.ДанныеДляПечатиЭтикетокДоставки(ОписаниеКоманды.Идентификатор,
		ОписаниеКоманды.ОбъектыПечати);
	
	Если СтруктураВозврата.ЕстьЭтикеткиДляПечати Тогда
		
		ПараметрКоманды = Новый Массив;
		ПараметрКоманды.Добавить(ПредопределенноеЗначение("Справочник.Номенклатура.ПустаяСсылка"));
		
		ПараметрыПечати = Новый Структура("АдресВХранилище, СтруктураМакетаШаблона",
			СтруктураВозврата.АдресВХранилище, Неопределено);
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати("Обработка.ПечатьЭтикетокИЦенников", "ЭтикеткаДоставки",
			ПараметрКоманды, Неопределено, ПараметрыПечати);
		
	ИначеЕсли СтруктураВозврата.ДоставкаНаНашСклад Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Печать этикетки доступна только для доставки с нашего склада.'"));	
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Печатная форма недоступна.'"));
	КонецЕсли;
	
	Если СтруктураВозврата.МассивСсылокСОшибками.Количество() > 0 Тогда
		ТекстСообщения = НСтр("ru = 'Не настроен общий шаблон этикетки доставки. Обратитесь к администратору.'");
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
	Для Каждого СсылкаПеревозчик Из СтруктураВозврата.МассивПеревозчиковБезШаблоновЭтикетки Цикл
		Если ЗначениеЗаполнено(СсылкаПеревозчик) Тогда
			ТекстСообщения = НСтр("ru = 'Для перевозчика ""%Перевозчик%"" не заполнен шаблон этикетки доставки.'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Перевозчик%", СсылкаПеревозчик);
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого СсылкаРаспоряжение Из СтруктураВозврата.МассивСсылокСОшибками Цикл
		ТекстСообщения = НСтр("ru = 'Не удалось напечатать этикетку доставки для документа ""%Распоряжение%"".'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Распоряжение%", СсылкаРаспоряжение);
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЦикла;
	
	Если СтруктураВозврата.Свойство("МассивЗаданийБезРаспоряжений") Тогда
		Для Каждого ЗаданиеНаПеревозку Из СтруктураВозврата.МассивЗаданийБезРаспоряжений Цикл
			ТекстСообщения = НСтр("ru = 'В документе ""%ЗаданиеНаПеревозку%"" отсутствуют распоряжения, для которых можно распечатать этикетки доставки.'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ЗаданиеНаПеревозку%", ЗаданиеНаПеревозку);
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		КонецЦикла;
	КонецЕсли;
	
КонецФункции

// Печать этикеток упаковочных листов.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьЭтикетокУпаковочныхЛистов(ОписаниеКоманды) Экспорт
	
	СтруктураВозврата = УправлениеПечатьюУТВызовСервера.ДанныеДляПечатиЭтикетокУпаковочныеЛисты(ОписаниеКоманды.ОбъектыПечати);
		
	Если Не СтруктураВозврата.ЕстьШаблонЭтикетки Тогда
		ТекстСообщения = НСтр("ru = 'Не настроен общий шаблон этикетки упаковочного листа. Обратитесь к администратору.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
	Если НЕ СтруктураВозврата.ЕстьЭтикеткиДляПечати Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Печатная форма недоступна.'"));
	КонецЕсли;
	
	Если СтруктураВозврата.ЕстьЭтикеткиДляПечати И СтруктураВозврата.ЕстьШаблонЭтикетки Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаУпаковочныеЛисты",
			ОписаниеКоманды.ОбъектыПечати,
			Неопределено,
			Новый Структура(
				"АдресВХранилище, ШаблонЭтикетки, КоличествоЭкземпляров",
				СтруктураВозврата.АдресВХранилище, СтруктураВозврата.ШаблонЭтикетки, 1));
		
	КонецЕсли;
		
КонецФункции

// Печать этикеток упаковочных листов сразу на принтер.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьЭтикетокУпаковочныхЛистовНаПринтер(ОписаниеКоманды) Экспорт
	
	СтруктураВозврата = УправлениеПечатьюУТВызовСервера.ДанныеДляПечатиЭтикетокУпаковочныеЛисты(ОписаниеКоманды.ОбъектыПечати);
		
	Если Не СтруктураВозврата.ЕстьШаблонЭтикетки Тогда
		ТекстСообщения = НСтр("ru = 'Не настроен общий шаблон этикетки упаковочного листа. Обратитесь к администратору.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
	Если НЕ СтруктураВозврата.ЕстьЭтикеткиДляПечати Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Печатная форма недоступна.'"));
	КонецЕсли;
	
	Если СтруктураВозврата.ЕстьЭтикеткиДляПечати И СтруктураВозврата.ЕстьШаблонЭтикетки Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечатиНаПринтер(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаУпаковочныеЛисты",
			ОписаниеКоманды.ОбъектыПечати,
			Новый Структура(
				"АдресВХранилище, ШаблонЭтикетки, КоличествоЭкземпляров",
				СтруктураВозврата.АдресВХранилище, СтруктураВозврата.ШаблонЭтикетки, 1));
		
	КонецЕсли;
		
КонецФункции

// Получает данные для печати и открывает форму обработки печати этикеток и ценников.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьАкцизныхМарок(ОписаниеКоманды) Экспорт
	
	ДанныеДляПечати = УправлениеПечатьюУТВызовСервераЛокализация.ДанныеДляПечатиАкцизныхМарок(ОписаниеКоманды.Идентификатор, ОписаниеКоманды.ОбъектыПечати);
	
	Если НЕ ДанныеДляПечати.ЕстьЭтикеткиДляПечати Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Нет данных для печати акцизных марок.'"));
		Возврат Неопределено;
	КонецЕсли;
	
	Если ДанныеДляПечати.ЕстьШаблонЭтикетки Тогда
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаАкцизныеМарки",
			ОписаниеКоманды.ОбъектыПечати,
			Неопределено,
			Новый Структура(
				"АдресВХранилище, ШаблонЭтикетки, КоличествоЭкземпляров",
				ДанныеДляПечати.АдресВХранилище, ДанныеДляПечати.ШаблонЭтикетки, 1));
	Иначе
		ОткрытьФорму(
			"Обработка.ПечатьЭтикетокИЦенников.Форма.ФормаАкцизныеМарки",
			Новый Структура("АдресВХранилище", ДанныеДляПечати.АдресВХранилище),
			ОписаниеКоманды.Форма,
			Новый УникальныйИдентификатор);
	КонецЕсли;
		
КонецФункции

#КонецОбласти

#Область КомплектыДокументов

// Отправляет на печать комплект документов
//
// Параметры:
//  ОписаниеКоманды - Структура - сведения о выполняемой команде.
//
Функция ПечатьКомплектаДокументов(ОписаниеКоманды) Экспорт
	
	ЗапрашиватьПодтверждение = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить("ОбщиеНастройкиПользователя", "ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов");
	Если ЗапрашиватьПодтверждение <> Неопределено Тогда
		ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов = ЗапрашиватьПодтверждение;
	Иначе
		ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов = Истина;
	КонецЕсли; 
	
	Если ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов Тогда
		
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить("КодВозвратаДиалога.Да",	НСтр("ru = 'Распечатать'"));
		Кнопки.Добавить("КодВозвратаДиалога.Нет",	НСтр("ru = 'Не печатать'"));
		
		Параметры = СтандартныеПодсистемыКлиент.ПараметрыВопросаПользователю();
		Параметры.КнопкаПоУмолчанию = КодВозвратаДиалога.Да;
		Параметры.Заголовок = НСтр("ru = 'Печать комплекта документов'");
		Параметры.КнопкаТаймаута = КодВозвратаДиалога.Нет;
		Параметры.БольшеНеЗадаватьЭтотВопрос = ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов;
		
		СтандартныеПодсистемыКлиент.ПоказатьВопросПользователю(
			Новый ОписаниеОповещения("ПечатьКомплектаДокументовЗавершение", ЭтотОбъект, Новый Структура("ОписаниеКоманды", ОписаниеКоманды)),
			НСтр("ru = 'Распечатать комплект документов на принтере?'"), 
			Кнопки,
			Параметры);
		Возврат Ложь;
		
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(
		НСтр("ru = 'Документы отправлены на печать'"),
		,
		,
		БиблиотекаКартинок.Информация32);
	
	УправлениеПечатьюКлиент.ВыполнитьКомандуПечатиНаПринтер(
		"РегистрСведений.НастройкиПечатиОбъектов",
		"КомплектДокументов",
		ОписаниеКоманды.ОбъектыПечати,
		Новый Структура);
	
КонецФункции

// Служебная процедура, обработка оповещения.
//
// Параметры:
//  Результат				 - Структура - результат после вопроса пользователю.
//  ДополнительныеПараметры	 - Структура - дополнительные параметры оповещения.
//
Процедура ПечатьКомплектаДокументовЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	ОписаниеКоманды = ДополнительныеПараметры.ОписаниеКоманды;
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекСохранить("ОбщиеНастройкиПользователя", "ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов", Не Результат.БольшеНеЗадаватьЭтотВопрос);
	
	Если Результат.Значение <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(
		НСтр("ru = 'Документы отправлены на печать'"),
		,
		,
		БиблиотекаКартинок.Информация32);
	
	УправлениеПечатьюКлиент.ВыполнитьКомандуПечатиНаПринтер(
		"РегистрСведений.НастройкиПечатиОбъектов",
		"КомплектДокументов",
		ОписаниеКоманды.ОбъектыПечати,
		Новый Структура);
	
КонецПроцедуры

// Отправляет на печать комплект документов с настройкой
//
// Параметры:
//  ОписаниеКоманды - Структура - сведения о выполняемой команде.
Функция ПечатьКомплектаДокументовСНастройкой(ОписаниеКоманды) Экспорт
	
	ОткрытьФорму(
		"РегистрСведений.НастройкиПечатиОбъектов.Форма.НастройкаПечатиКомплекта",
		Новый Структура("Объекты", ОписаниеКоманды.ОбъектыПечати));
	
КонецФункции

#КонецОбласти

#Область ДокументАктвыполненныхработ

// Выводит печатную форму акта выполненных работ в word.
//
// Параметры:
//  ОписаниеКоманды	 - Структура - структура с описанием команды.
// 
// Возвращаемое значение:
//  Неопределено - ничего не возвращается.
//
Функция ПечатьАктВыполненныхРаботMicrosoftWord(ОписаниеКоманды) Экспорт
	
	Состояние(НСтр("ru = 'Выполняется формирование печатных форм'"));
	
	ИмяМакета = "ПФ_DOC_Акт";
	ТипМакета = "doc";
	
	МакетИДанныеОбъекта = УправлениеПечатьюВызовСервера.МакетыИДанныеОбъектовДляПечати("Документ.АктВыполненныхРабот",
		ИмяМакета,
		ОписаниеКоманды.ОбъектыПечати);
		
	ДвоичныеДанныеМакетов = МакетИДанныеОбъекта.Макеты.ДвоичныеДанныеМакетов;
	
	Секции = МакетИДанныеОбъекта.Макеты.ОписаниеСекций;
	
	Для Каждого ДокументСсылка Из ОписаниеКоманды.ОбъектыПечати Цикл
		
		ДанныеОбъекта = МакетИДанныеОбъекта.Данные[ДокументСсылка][ИмяМакета];
		
		Попытка
			
			ПечатнаяФорма = УправлениеПечатьюКлиент.ИнициализироватьПечатнуюФорму(ТипМакета);
			Макет = УправлениеПечатьюКлиент.ИнициализироватьМакетОфисногоДокумента(
				ДвоичныеДанныеМакетов[ИмяМакета], ТипМакета);
				
			// Вывод колонтитулов документа.
			Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["ВерхнийКолонтитул"]);
			УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
		
			Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["НижнийКолонтитул"]);
			УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			
			Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].Заголовок);
			УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			
			Если ЗначениеЗаполнено(ДанныеОбъекта.ДополнительнаяИнформацияШапки) Тогда
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].ДополнительнаяИнформацияШапки);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			КонецЕсли;
			
			Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].ЗаголовокШапки);
			УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, Область, Ложь);
			
			ЕстьНДС       = ДанныеОбъекта.УчитыватьНДС;
			ЕстьСкидки    = ДанныеОбъекта.ЕстьСкидки;
			ПоказыватьНДС = ДанныеОбъекта.ПоказыватьНДС;
			
			СуффиксОбласти = ?(ЕстьСкидки, "СоСкидкой", "") + ?(ЕстьНДС И ПоказыватьНДС, "СНДС", "");
			
			ОбластьШапки = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета]["ШапкаТаблицы" + СуффиксОбласти]);
			УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, ОбластьШапки, Ложь);

			ОбластьСтрокиСтандарт = Секции[ИмяМакета]["Строка" + СуффиксОбласти];
			Если ДанныеОбъекта.ИспользоватьНаборы Тогда
				ОбластьСтрокиНабор              = Секции[ИмяМакета]["Строка"  + СуффиксОбласти + "Набор"];
				ОбластьСтрокиКомплектующие      = Секции[ИмяМакета]["Строка"  + СуффиксОбласти + "Комплектующие"];
				ОбластьСтрокиКомплектующиеКонец = Секции[ИмяМакета]["Строка"  + СуффиксОбласти + "КомплектующиеКонец"];
			КонецЕсли;
			
			Индекс = 0;
			ВсегоСтрок = ДанныеОбъекта.Услуги.Количество();
			Для Каждого СтрокаТЧ Из ДанныеОбъекта.Услуги Цикл
				
				Индекс = Индекс + 1;
				
				Если НаборыКлиентСервер.ИспользоватьОбластьНабор(СтрокаТЧ, ДанныеОбъекта.ИспользоватьНаборы) Тогда
					ОбластьСтроки = ОбластьСтрокиНабор;
				ИначеЕсли НаборыКлиентСервер.ИспользоватьОбластьКомплектующие(СтрокаТЧ, ДанныеОбъекта.ИспользоватьНаборы) И Индекс < ВсегоСтрок Тогда
					ОбластьСтроки = ОбластьСтрокиКомплектующие;
				ИначеЕсли НаборыКлиентСервер.ИспользоватьОбластьКомплектующие(СтрокаТЧ, ДанныеОбъекта.ИспользоватьНаборы) Тогда
					ОбластьСтроки = ОбластьСтрокиКомплектующиеКонец;
				Иначе
					ОбластьСтроки = ОбластьСтрокиСтандарт;
				КонецЕсли;
				
				Масс = Новый Массив;
				Масс.Добавить(СтрокаТЧ);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, ОбластьСтроки);
				УправлениеПечатьюКлиент.ПрисоединитьИЗаполнитьКоллекцию(ПечатнаяФорма, Область, Масс, Ложь);
				
			КонецЦикла;
			
			Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].Итого);
			УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			
			Если ЕстьНДС Тогда
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].ИтогоНДС);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			КонецЕсли;
			
			Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].СуммаПрописью);
			УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			
			Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].Подписи);
			УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			
			Если ЗначениеЗаполнено(ДанныеОбъекта.ДополнительнаяИнформация) Тогда
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет,Секции[ИмяМакета].ДополнительнаяИнформация);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			КонецЕсли;

			УправлениеПечатьюКлиент.ПоказатьДокумент(ПечатнаяФорма);
			
		Исключение
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
			
			УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма);
			УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
			
			Возврат Ложь;
			
		КонецПопытки;
		
		УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма, Ложь);
		УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
		
	КонецЦикла;
	
	Состояние(НСтр("ru = 'Формирование печатных форм завершено'"));
	
КонецФункции

#КонецОбласти

#Область ДокументВзаимозачетзадолженности

// Печатает акт взаимозачета задолженности
//
// Параметры:
//	ОписаниеКоманды - Структура
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьАктаВзаимозачетаЗадолженностиMicrosoftWord(ОписаниеКоманды) Экспорт
	
	ОчиститьСообщения();
	
	Состояние(НСтр("ru = 'Выполняется формирование печатных форм'"));
	
	ИмяМакета = "ПФ_DOC_АктВзаимозачета_ru";
	ТипМакета = "doc";
	
	МакетИДанныеОбъекта = УправлениеПечатьюВызовСервера.МакетыИДанныеОбъектовДляПечати("Документ.ВзаимозачетЗадолженности",
		ИмяМакета,
		ОписаниеКоманды.ОбъектыПечати);
		
	ДвоичныеДанныеМакетов = МакетИДанныеОбъекта.Макеты.ДвоичныеДанныеМакетов;
	
	Секции = МакетИДанныеОбъекта.Макеты.ОписаниеСекций;
	
	Для Каждого ДокументСсылка Из ОписаниеКоманды.ОбъектыПечати Цикл
		
		ДанныеОбъекта = МакетИДанныеОбъекта.Данные[ДокументСсылка][ИмяМакета];
		
		Если Не ДанныеОбъекта.Взаимозачет Тогда
			
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не требуется печатать акт взаимозачета для документа %1'"),
				ДокументСсылка);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				Текст,
				ДокументСсылка);
			
		Иначе
		
			Попытка
					
				ПечатнаяФорма = УправлениеПечатьюКлиент.ИнициализироватьПечатнуюФорму(ТипМакета);
				Макет = УправлениеПечатьюКлиент.ИнициализироватьМакетОфисногоДокумента(
					ДвоичныеДанныеМакетов[ИмяМакета], ТипМакета);
					
				// Вывод колонтитулов документа.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["ВерхнийКолонтитул"]);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
			
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["НижнийКолонтитул"]);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
				
				// Выводим заголовок документа.	
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Заголовок);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				// Выводим данные дебиторской задолженности;
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ДебиторскаяЗадолженность);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ШапкаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, Область, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].СтрокаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьИЗаполнитьКоллекцию(ПечатнаяФорма,Область, ДанныеОбъекта.ДебиторскаяЗадолженность, Ложь);
				
				// Выводим данные кредиторской задолженности.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].КредиторскаяЗадолженность);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ШапкаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, Область, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].СтрокаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьИЗаполнитьКоллекцию(ПечатнаяФорма,Область, ДанныеОбъекта.КредиторскаяЗадолженность, Ложь);
				
				// Выводим подвал документа.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Подвал);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);

				УправлениеПечатьюКлиент.ПоказатьДокумент(ПечатнаяФорма);
				
			Исключение
			
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				
				УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма);
				УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
						
				Возврат Ложь;
				
			КонецПопытки;

			УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма, Ложь);
			УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Состояние(НСтр("ru = 'Формирование печатных форм завершено'"));
	
КонецФункции

// Печатает акт переуступки долга.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьАктаПереуступкиДолгаMicrosoftWord(ОписаниеКоманды) Экспорт
	
	ОчиститьСообщения();
	
	Состояние(НСтр("ru = 'Выполняется формирование печатных форм'"));
	
	ИмяМакета = "ПФ_DOC_АктПереуступкиДолга_ru";
	ТипМакета = "doc";
	
	МакетИДанныеОбъекта = УправлениеПечатьюВызовСервера.МакетыИДанныеОбъектовДляПечати("Документ.ВзаимозачетЗадолженности",
		ИмяМакета,
		ОписаниеКоманды.ОбъектыПечати);
		
	ДвоичныеДанныеМакетов = МакетИДанныеОбъекта.Макеты.ДвоичныеДанныеМакетов;
	
	Секции = МакетИДанныеОбъекта.Макеты.ОписаниеСекций;
	
	Для Каждого ДокументСсылка Из ОписаниеКоманды.ОбъектыПечати Цикл
		
		ДанныеОбъекта = МакетИДанныеОбъекта.Данные[ДокументСсылка][ИмяМакета];
		
		Если ДанныеОбъекта.Взаимозачет Тогда
			
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не требуется печатать акт переуступки долга для документа %1'"),
				ДокументСсылка);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				Текст,
				ДокументСсылка);
			
		Иначе

			Попытка
					
				ПечатнаяФорма = УправлениеПечатьюКлиент.ИнициализироватьПечатнуюФорму(ТипМакета);
				Макет = УправлениеПечатьюКлиент.ИнициализироватьМакетОфисногоДокумента(
					ДвоичныеДанныеМакетов[ИмяМакета], ТипМакета);
					
				// Вывод колонтитулов документа.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["ВерхнийКолонтитул"]);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["НижнийКолонтитул"]);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
				
				// Выводим заголовок документа.	
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Заголовок);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				// Выводим данные дебиторской задолженности;
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ДебиторскаяЗадолженность);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ШапкаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, Область, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].СтрокаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьИЗаполнитьКоллекцию(ПечатнаяФорма,Область, ДанныеОбъекта.ДебиторскаяЗадолженность, Ложь);
				
				// Выводим данные кредиторской задолженности.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].КредиторскаяЗадолженность);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ШапкаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, Область, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].СтрокаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьИЗаполнитьКоллекцию(ПечатнаяФорма,Область, ДанныеОбъекта.КредиторскаяЗадолженность, Ложь);
				
				// Выводим подвал документа.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Итог);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Подвал);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				УправлениеПечатьюКлиент.ПоказатьДокумент(ПечатнаяФорма);
				
			Исключение
			
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				
				УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма);
				УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
						
				Возврат Ложь;
				
			КонецПопытки;

			УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма, Ложь);
			УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Состояние(НСтр("ru = 'Формирование печатных форм завершено'"));
	
КонецФункции

// Печатает акт переуступки долга между организациями.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьАктаПереуступкиДолгаМеждуОрганизациямиMicrosoftWord(ОписаниеКоманды) Экспорт
	
	ОчиститьСообщения();
	
	Состояние(НСтр("ru = 'Выполняется формирование печатных форм'"));
	
	ИмяМакета = "ПФ_DOC_АктПереуступкиДолгаМеждуОрганизациями_ru";
	ТипМакета = "doc";
	
	МакетИДанныеОбъекта = УправлениеПечатьюВызовСервера.МакетыИДанныеОбъектовДляПечати("Документ.ВзаимозачетЗадолженности",
		ИмяМакета,
		ОписаниеКоманды.ОбъектыПечати);
		
	ДвоичныеДанныеМакетов = МакетИДанныеОбъекта.Макеты.ДвоичныеДанныеМакетов;
	
	Секции = МакетИДанныеОбъекта.Макеты.ОписаниеСекций;
	
	Для Каждого ДокументСсылка Из ОписаниеКоманды.ОбъектыПечати Цикл
		
		ДанныеОбъекта = МакетИДанныеОбъекта.Данные[ДокументСсылка][ИмяМакета];
		
		Если ДанныеОбъекта.Взаимозачет Тогда
			
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не требуется печатать акт переуступки долга для документа %1'"),
				ДокументСсылка);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				Текст,
				ДокументСсылка);
			
		Иначе

			Попытка
					
				ПечатнаяФорма = УправлениеПечатьюКлиент.ИнициализироватьПечатнуюФорму(ТипМакета);
				Макет = УправлениеПечатьюКлиент.ИнициализироватьМакетОфисногоДокумента(
					ДвоичныеДанныеМакетов[ИмяМакета], ТипМакета);
					
				// Вывод колонтитулов документа.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["ВерхнийКолонтитул"]);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета]["НижнийКолонтитул"]);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Ложь);
				
				// Выводим заголовок документа.	
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Заголовок);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				// Выводим данные дебиторской задолженности;
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ДебиторскаяЗадолженность);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ШапкаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, Область, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].СтрокаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьИЗаполнитьКоллекцию(ПечатнаяФорма,Область, ДанныеОбъекта.ДебиторскаяЗадолженность, Ложь);
				
				// Выводим данные кредиторской задолженности.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].КредиторскаяЗадолженность);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].ШапкаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьОбласть(ПечатнаяФорма, Область, Ложь);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].СтрокаТаблицы);
				УправлениеПечатьюКлиент.ПрисоединитьИЗаполнитьКоллекцию(ПечатнаяФорма,Область, ДанныеОбъекта.КредиторскаяЗадолженность, Ложь);
				
				// Выводим подвал документа.
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Итог);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				Область = УправлениеПечатьюКлиент.ОбластьМакета(Макет, Секции[ИмяМакета].Подвал);
				УправлениеПечатьюКлиент.ПрисоединитьОбластьИЗаполнитьПараметры(ПечатнаяФорма, Область, ДанныеОбъекта, Истина);
				
				УправлениеПечатьюКлиент.ПоказатьДокумент(ПечатнаяФорма);
				
			Исключение
			
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				
				УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма);
				УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
						
				Возврат Ложь;
				
			КонецПопытки;

			УправлениеПечатьюКлиент.ОчиститьСсылки(ПечатнаяФорма, Ложь);
			УправлениеПечатьюКлиент.ОчиститьСсылки(Макет);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Состояние(НСтр("ru = 'Формирование печатных форм завершено'"));
	
КонецФункции

#КонецОбласти

#Область ДокументЗаданиеТорговомуПредставителю

// Открывает форму для настройки печати бланков задания торговому представителю.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция НастройкаПечатиБланковЗаданияТорговомуПредставителю(ОписаниеКоманды) Экспорт
	
	ОткрытьФорму(
		"Документ.ЗаданиеТорговомуПредставителю.Форма.НастройкаПечатиБланковЗадания",
		,
		ОписаниеКоманды.Форма,
		ОписаниеКоманды.Форма.УникальныйИдентификатор);
	
КонецФункции

#КонецОбласти

#Область ДокументСверкаВзаиморасчетов

Функция ПечатьАктаСверкиВзаиморасчетов(ОписаниеКоманды) Экспорт
	
	ПараметрыФормы = Новый Структура("Печать", Истина);
	ДополнительныеПараметры = Новый Структура("ОписаниеКоманды", ОписаниеКоманды);
	
	ОткрытьФорму(
		"Документ.СверкаВзаиморасчетов.Форма.НастройкаПечати",
		ПараметрыФормы,
		ОписаниеКоманды.Форма,
		ОписаниеКоманды.Форма.УникальныйИдентификатор,
		,
		,
		Новый ОписаниеОповещения(
			"ПечатьАктаСверкиВзаиморасчетовЗавершение", 
			ЭтотОбъект, 
			ДополнительныеПараметры)); 
	
КонецФункции

Процедура ПечатьАктаСверкиВзаиморасчетовЗавершение(ПараметрыПечати, ДополнительныеПараметры) Экспорт
	
	ОписаниеКоманды = ДополнительныеПараметры.ОписаниеКоманды;
	
	Если ПараметрыПечати <> Неопределено Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			ОписаниеКоманды.МенеджерПечати,
			ОписаниеКоманды.Идентификатор,
			ОписаниеКоманды.ОбъектыПечати,
			ОписаниеКоманды.Форма,
			ПараметрыПечати);
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ДокументУстановкаЦенНоменклатуры

// Выводит печатную форму переоценки товаров в рознице.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьПереоценкаВРознице(ОписаниеКоманды, АдресДанныеДляПечатиВоВременномХранилище = Неопределено) Экспорт
	
	ДополнительныеПараметры = Новый Структура("АдресДанныеДляПечатиВоВременномХранилище, ОписаниеКоманды", 
		АдресДанныеДляПечатиВоВременномХранилище, ОписаниеКоманды);
	
	ОткрытьФорму(
		"Документ.УстановкаЦенНоменклатуры.Форма.ФормаВыбораРозничногоМагазинаИОрганизацииДляПереоценки",
		,
		,
		,
		,
		,
		Новый ОписаниеОповещения(
			"ПечатьПереоценкаВРозницеЗавершение", 
			ЭтотОбъект, 
			ДополнительныеПараметры), 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецФункции

// Обработчик оповещения
//
// Параметры:
//  КодВозврата				 - 	КодВозвратаДиалога - КодВозвратаДиалога.ОК или другое значение
//  ДополнительныеПараметры	 - 	Структура - структура дополнительных параметров оповещения.
//
Процедура ПечатьПереоценкаВРозницеЗавершение(ПараметрыПечати, ДополнительныеПараметры) Экспорт
	
	АдресДанныеДляПечатиВоВременномХранилище = ДополнительныеПараметры.АдресДанныеДляПечатиВоВременномХранилище;
	ОписаниеКоманды = ДополнительныеПараметры.ОписаниеКоманды;
	
	Если ПараметрыПечати <> Неопределено Тогда
		
		ПараметрыПечати.Вставить("АдресДанныеДляПечатиВоВременномХранилище", АдресДанныеДляПечатиВоВременномХранилище);
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
		"Документ.УстановкаЦенНоменклатуры",
		"ПереоценкаТоваровВРознице",
		ОписаниеКоманды.ОбъектыПечати,
		ОписаниеКоманды.Форма,
		ПараметрыПечати);
		
	КонецЕсли;

КонецПроцедуры

// Выводит печатную форму установки цен номенклатуры.
//
// Параметры:
//	ОписаниеКоманды - Структура - структура с описанием команды.
//
// Возвращаемое значение:
//	Неопределено
//
Функция ПечатьУстановкаЦенНоменклатуры(ОписаниеКоманды, АдресДанныеДляПечатиВоВременномХранилище = Неопределено) Экспорт
	
	ПараметрыФормыНастройки = Новый Структура(
		"МассивДокументов, УникальныйИдентификатор, АдресДанныеДляПечатиВоВременномХранилище",
		ОписаниеКоманды.ОбъектыПечати,
		ОписаниеКоманды.Форма.УникальныйИдентификатор,
		АдресДанныеДляПечатиВоВременномХранилище);
	
	ПараметрыПечати = Неопределено;

	
	ОткрытьФорму(
		"Документ.УстановкаЦенНоменклатуры.Форма.ФормаНастройкиПечатнойФормыУстановкиЦенНоменклатуры",
		ПараметрыФормыНастройки,
		,
		,
		,
		,
		Новый ОписаниеОповещения("ПечатьУстановкаЦенНоменклатурыЗавершение", ЭтотОбъект, Новый Структура("ОписаниеКоманды", ОписаниеКоманды)), 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецФункции

// Обработчик оповещения
//
// Параметры:
//  КодВозврата				 - 	КодВозвратаДиалога - КодВозвратаДиалога.ОК или другое значение
//  ДополнительныеПараметры	 - 	Структура - структура дополнительных параметров оповещения.
//
Процедура ПечатьУстановкаЦенНоменклатурыЗавершение(ПараметрыПечати, ДополнительныеПараметры) Экспорт
	
	ОписаниеКоманды = ДополнительныеПараметры.ОписаниеКоманды;
	
	Если ПараметрыПечати <> Неопределено Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
		"Документ.УстановкаЦенНоменклатуры",
		"УстановкаЦенНоменклатуры",
		ОписаниеКоманды.ОбъектыПечати,
		Неопределено,
		ПараметрыПечати);
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
