﻿#Область JSON

// Получить из текста JSON структуру.
// 
// Параметры:
// 	ТекстJSON                    - Строка - Текст JSON.
// 	ПреобразовыватьВСоответствие - Булево - Признак преобразования в соответствие.
// Возвращаемое значение:
// 	Структура, Неопределено - Результат преобразования JSON.
Функция ТекстJSONВОбъект(ТекстJSON, ПреобразовыватьВСоответствие = Ложь) Экспорт
	
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(ТекстJSON);
	
	Попытка
		РезультатРазбора = ПрочитатьJSON(Чтение, ПреобразовыватьВСоответствие);
	Исключение
		РезультатРазбора = Неопределено;
	КонецПопытки;
	
	Возврат РезультатРазбора;
	
КонецФункции

// Формирует из структуры текст JSON
// 
// Параметры:
// 	Структура - Структура - Произвольная структура данных
// Возвращаемое значение:
// 	Строка - Текст JSON
Функция ОбъектВТекстJSON(Структура, УдалитьПробелыИПереносыСтрок = Ложь) Экспорт
	
	Если УдалитьПробелыИПереносыСтрок Тогда
		ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет, "");
	Иначе
		ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, "  ");
	КонецЕсли;
	
	ЗаписьJSON = Новый ЗаписьJSON();
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON);
	
	ЗаписатьJSON(ЗаписьJSON, Структура);
	
	ТекстJSON = ЗаписьJSON.Закрыть();
	
	Возврат ТекстJSON;
	
КонецФункции

#КонецОбласти

#Область HTTPЗапросы

// Структура результата HTTP запроса
// 
// Параметры:
// Возвращаемое значение:
// 	Структура - Результат HTTP-запроса:
// * КодСостояния - Число        - Код состояния HTTP
// * Заголовки    - Соответствие - Заголовки HTTP ответа
// * ТекстОтвета  - Строка       - Текст ответа
// * ТекстОшибки  - Строка       - Текст ошибки
Функция РезультатHTTPЗапроса() Экспорт
	
	РезультатHTTPЗапроса = Новый Структура;
	РезультатHTTPЗапроса.Вставить("КодСостояния");
	РезультатHTTPЗапроса.Вставить("Заголовки");
	РезультатHTTPЗапроса.Вставить("ТекстОтвета");
	РезультатHTTPЗапроса.Вставить("ТекстОшибки");
	
	Возврат РезультатHTTPЗапроса;
	
КонецФункции

// Инициализирует структуру результата обработки HTTP-запроса после получения ответа.
// 
// Параметры:
// 	ТекстВходящегоСообщенияJSON - Строка - Текст входящего сообщения.
// 	КодСостояния                - Число  - Код состояния.
// 
// Возвращаемое значение:
// Структура - Структура со свойствами:
//   ЗапросОтправлен             - Булево - признак того, что сообщение отправлено.
//   ОтветПолучен                - Булево - признак того, что сообщение обработано сервером.
//   КодСостояния                - Число  - Код состояния HTTP-запроса.
//   ТекстОшибки                 - Строка - текст ошибки, если таковая возникла.
//   ТекстВходящегоСообщенияJSON - Строка - текст ответа, на отправленное сообщение.
//
Функция HTTPОтветПолучен(ТекстВходящегоСообщенияJSON, КодСостояния = 200, КакФайл = Ложь, ДополнительныеПараметры = Неопределено)
	
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("ДополнительныеПараметры", ДополнительныеПараметры);
	ВозвращаемоеЗначение.Вставить("ЗапросОтправлен",         Истина);
	ВозвращаемоеЗначение.Вставить("ОтветПолучен",            Истина);
	
	ВозвращаемоеЗначение.Вставить("КодСостояния", КодСостояния);
	ВозвращаемоеЗначение.Вставить("Объект",       Неопределено);
	ВозвращаемоеЗначение.Вставить("ТекстОшибки",  "");
	
	Если КакФайл Тогда
		ВозвращаемоеЗначение.Вставить("ИмяФайла", ТекстВходящегоСообщенияJSON);
	Иначе
		Попытка
			ВозвращаемоеЗначение.Объект = ТекстJSONВОбъект(ТекстВходящегоСообщенияJSON, Ложь);
		Исключение
			ВозвращаемоеЗначение.Объект = ТекстJSONВОбъект(ТекстВходящегоСообщенияJSON, Истина);
		КонецПопытки;
		
		ВозвращаемоеЗначение.Вставить("ТекстВходящегоСообщения", ТекстВходящегоСообщенияJSON);
		Если ВозвращаемоеЗначение.Объект <> Неопределено Тогда
			ВозвращаемоеЗначение.Вставить("ТекстВходящегоСообщенияJSON", ОбъектВТекстJSON(ВозвращаемоеЗначение.Объект));
		Иначе
			ВозвращаемоеЗначение.Вставить("ТекстВходящегоСообщенияJSON", ТекстВходящегоСообщенияJSON);
		КонецЕсли;
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Инициализирует структуру результата обработки HTTP-запроса после отправки сообщения, но до получения ответа.
// 
// Возвращаемое значение:
// Структура:
//   ЗапросОтправлен             - Булево - признак того, что сообщение отправлено.
//   ОтветПолучен                - Булево - признак того, что сообщение получено.
//   КодСостояния                - Число  - Код состояния HTTP-запроса.
//   ТекстОшибки                 - Строка - текст ошибки, если таковая возникла.
//   ТекстВходящегоСообщенияJSON - Строка - текст ответа, на отправленное сообщение.
//
Функция HTTPОтветНеПолучен(Ошибка, ЗапросОтправлен, КодСостояния = Неопределено, КакФайл = Ложь, ДополнительныеПараметры = Неопределено)
	
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("ДополнительныеПараметры", ДополнительныеПараметры);
	ВозвращаемоеЗначение.Вставить("ЗапросОтправлен",         ЗапросОтправлен);
	ВозвращаемоеЗначение.Вставить("ОтветПолучен",            Ложь);
	
	ВозвращаемоеЗначение.Вставить("КодСостояния", КодСостояния);
	ВозвращаемоеЗначение.Вставить("Объект",       Неопределено);
	ВозвращаемоеЗначение.Вставить("ТекстОшибки",  Строка(Ошибка));
	
	Если КакФайл Тогда
		ВозвращаемоеЗначение.Вставить("ИмяФайла", "");
	Иначе
		ВозвращаемоеЗначение.Вставить("ТекстВходящегоСообщения",     "");
		ВозвращаемоеЗначение.Вставить("ТекстВходящегоСообщенияJSON", "");
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Обработать результат отправки HTTP-запроса к сервису ИС МОТП.
// 
// Параметры:
//  РезультатЗапроса - (См. РезультатЗапроса) - Результат запроса.
// Возвращаемое значение:
// Структура - Результат отправки HTTP-запроса:
//  * ЗапросОтправлен             - Булево - признак того, что сообщение отправлено.
//  * ОтветПолучен                - Булево - признак того, что сообщение получено.
//  * КодСостояния                - Число  - Код состояния HTTP-запроса.
//  * ТекстОшибки                 - Строка - текст ошибки, если таковая возникла.
//  * ТекстВходящегоСообщенияJSON - Строка - текст ответа, на отправленное сообщение.
Функция ОбработатьРезультатОтправкиHTTPЗапросаКакJSON(РезультатЗапроса) Экспорт
	
	ВозвращаемоеЗначение = Неопределено;
	
	РезультатОтправкиHTTPЗапроса = ИнтерфейсМОТПСлужебный.РезультатHTTPЗапроса();
	РезультатОтправкиHTTPЗапроса.ТекстОшибки = РезультатЗапроса.ТекстОшибки;
	Если РезультатЗапроса.HTTPОтвет <> Неопределено Тогда
		РезультатОтправкиHTTPЗапроса.КодСостояния = РезультатЗапроса.HTTPОтвет.КодСостояния;
		РезультатОтправкиHTTPЗапроса.Заголовки    = РезультатЗапроса.HTTPОтвет.Заголовки;
		РезультатОтправкиHTTPЗапроса.ТекстОтвета  = РезультатЗапроса.HTTPОтвет.ПолучитьТелоКакСтроку();
	КонецЕсли;
	
	КодСостояния = РезультатОтправкиHTTPЗапроса.КодСостояния;
	ТекстОтвета  = РезультатОтправкиHTTPЗапроса.ТекстОтвета;
	
	Если ЗначениеЗаполнено(ТекстОтвета) Тогда
		
		ВозвращаемоеЗначение = HTTPОтветПолучен(ТекстОтвета, КодСостояния, Ложь, РезультатЗапроса);
		
	Иначе
		
		Если Не ЗначениеЗаполнено(КодСостояния) Тогда
			ТекстСообщенияXMLОтправлен = Ложь;
			ЗаголовокОшибки = НСтр("ru = 'HTTP-запрос не отправлен.'");
		Иначе
			ТекстСообщенияXMLОтправлен = Истина;
			ЗаголовокОшибки = СтрШаблон(НСтр("ru = 'Код состояния HTTP: %1.'"), КодСостояния);
		КонецЕсли;
		
		Если ЗначениеЗаполнено(РезультатОтправкиHTTPЗапроса.ТекстОшибки) Тогда
			ТекстОшибки = ЗаголовокОшибки + Символы.ПС + РезультатОтправкиHTTPЗапроса.ТекстОшибки;
		Иначе
			ТекстОшибки = ЗаголовокОшибки;
		КонецЕсли;
		
		ВозвращаемоеЗначение = HTTPОтветНеПолучен(
			ТекстОшибки,
			ТекстСообщенияXMLОтправлен,
			КодСостояния,
			Ложь, РезультатЗапроса);
		
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Обработать результат отправки HTTP-запроса к сервису ИС МОТП.
// 
// Параметры:
//  РезультатЗапроса - (См. РезультатЗапроса) - Результат запроса.
// Возвращаемое значение:
// Структура - Результат отправки HTTP-запроса:
//  * ЗапросОтправлен - Булево - признак того, что сообщение отправлено.
//  * ОтветПолучен    - Булево - признак того, что сообщение получено.
//  * КодСостояния    - Число  - Код состояния HTTP-запроса.
//  * ТекстОшибки     - Строка - текст ошибки, если таковая возникла.
//  * ИмяФайла        - Строка - ИмяФайла.
Функция ОбработатьРезультатОтправкиHTTPЗапросаКакФайл(РезультатЗапроса) Экспорт
	
	ВозвращаемоеЗначение = Неопределено;
	
	РезультатОтправкиHTTPЗапроса = ИнтерфейсМОТПСлужебный.РезультатHTTPЗапроса();
	РезультатОтправкиHTTPЗапроса.ТекстОшибки = РезультатЗапроса.ТекстОшибки;
	Если РезультатЗапроса.HTTPОтвет <> Неопределено Тогда
		РезультатОтправкиHTTPЗапроса.КодСостояния = РезультатЗапроса.HTTPОтвет.КодСостояния;
		РезультатОтправкиHTTPЗапроса.Заголовки    = РезультатЗапроса.HTTPОтвет.Заголовки;
		РезультатОтправкиHTTPЗапроса.ТекстОтвета  = РезультатЗапроса.HTTPОтвет.ПолучитьИмяФайлаТела();
	КонецЕсли;
	
	КодСостояния = РезультатОтправкиHTTPЗапроса.КодСостояния;
	ТекстОтвета  = РезультатОтправкиHTTPЗапроса.ТекстОтвета;
	
	Если ЗначениеЗаполнено(ТекстОтвета) Тогда
		
		ВозвращаемоеЗначение = HTTPОтветПолучен(ТекстОтвета, КодСостояния, Истина, РезультатЗапроса);
		
	Иначе
		
		Если Не ЗначениеЗаполнено(КодСостояния) Тогда
			ТекстСообщенияXMLОтправлен = Ложь;
			ЗаголовокОшибки = НСтр("ru = 'HTTP-запрос не отправлен.'");
		Иначе
			ТекстСообщенияXMLОтправлен = Истина;
			ЗаголовокОшибки = СтрШаблон(НСтр("ru = 'Код состояния HTTP: %1.'"), КодСостояния);
		КонецЕсли;
		
		Если ЗначениеЗаполнено(РезультатОтправкиHTTPЗапроса.ТекстОшибки) Тогда
			ТекстОшибки = ЗаголовокОшибки + Символы.ПС + РезультатОтправкиHTTPЗапроса.ТекстОшибки;
		Иначе
			ТекстОшибки = ЗаголовокОшибки;
		КонецЕсли;
		
		ВозвращаемоеЗначение = HTTPОтветНеПолучен(
			ТекстОшибки,
			ТекстСообщенияXMLОтправлен,
			КодСостояния,
			Истина, РезультатЗапроса);
		
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

#КонецОбласти

#Область Прочее

// Сформировать текст ошибки по результату отправки запроса.
//
// Параметры:
//  Заголовок - Строка - Заголовок ошибки, например: Параметры авторизации не получены из ИС МОТП.
//  РезультатОтправкиЗапроса - Структура - Результат отправки HTTP-запроса:
//  * ЗапросОтправлен             - Булево - признак того, что сообщение отправлено.
//  * ОтветПолучен                - Булево - признак того, что сообщение получено.
//  * КодСостояния                - Число  - Код состояния HTTP-запроса.
//  * ТекстОшибки                 - Строка - текст ошибки, если таковая возникла.
//  * ТекстВходящегоСообщенияJSON - Строка - текст ответа, на отправленное сообщение.
// Возвращаемое значение:
//  Строка - Текст ошибки.
Функция ТекстОшибкиПоРезультатуОтправкиЗапроса(URLЗапроса, РезультатОтправкиЗапроса) Экспорт
	
	Если РезультатОтправкиЗапроса.ОтветПолучен Тогда

		ТекстОшибки = СтрШаблон(
			НСтр("ru='При выполнении запроса %1 возникла ошибка.
				     |Код состояния HTTP: %2.
				     |Текст ошибки: %3.'"),
			URLЗапроса,
			РезультатОтправкиЗапроса.КодСостояния,
			ПредставлениеОшибкиИзJSON(РезультатОтправкиЗапроса.ТекстВходящегоСообщенияJSON));
			
	Иначе
		
		ТекстОшибки = СтрШаблон(
			НСтр("ru='При отправке запроса %1 возникла ошибка.
				     |Текст ошибки: %2.'"),
			URLЗапроса,
			РезультатОтправкиЗапроса.ТекстОшибки);

	КонецЕсли;
	
	Возврат ТекстОшибки;

КонецФункции

// Конвертирует входящий текст JSON содержащий globalErrors в представление ошибки.
// 
// Параметры:
// 	ТекстВходящегоСообщенияJSON - Строка - Текст сообщения JSON.
// Возвращаемое значение:
// 	Строка - Представление ошибки.
Функция ПредставлениеОшибкиИзJSON(ТекстВходящегоСообщенияJSON)
	
	ДанныеJSON = ТекстJSONВОбъект(ТекстВходящегоСообщенияJSON);
	
	Если ДанныеJSON <> Неопределено
		И ДанныеJSON.Свойство("globalErrors")
		И ТипЗнч(ДанныеJSON.globalErrors) = Тип("Массив") Тогда
		
		ТекстыОшибок = Новый Массив();
		
		Для Каждого СтрокаОшибки Из ДанныеJSON.globalErrors Цикл
			
			Если Не ТипЗнч(СтрокаОшибки) = Тип("Строка") Тогда
				Возврат ТекстВходящегоСообщенияJSON;
			КонецЕсли;
			
			ТекстыОшибок.Добавить(ТекстПредставленияОшибки(СтрокаОшибки));
			
		КонецЦикла;
		
		Возврат СтрСоединить(ТекстыОшибок, Символы.ПС)
		
	Иначе
		Возврат ТекстВходящегоСообщенияJSON;
	КонецЕсли;
	
КонецФункции

// Возвращает найденое значение во внутреннем соответствии текстов ошибок.
// Если значение в соответствии не найдено, то возвращается исходное значение.
// 
// Параметры:
// 	ИсходноеСообщение - Строка - Исходный текст.
// Возвращаемое значение:
// 	Строка - Найденое значение или сходнное.
Функция ТекстПредставленияОшибки(ИсходноеСообщение)
	
	ЗначениеПоиска = СокрЛП(НРег(ИсходноеСообщение));
	
	ТекстыОшибок = Новый Соответствие();
	
	ТекстыОшибок.Вставить(
		НРег("Not enough balance"),
		НСтр("ru = 'Недостаточно средств на балансе для получения кодов маркировки из СУЗ'"));
	
	ВозвращаемоеЗначение = ТекстыОшибок.Получить(ЗначениеПоиска);
	
	Если ВозвращаемоеЗначение = Неопределено Тогда
		ВозвращаемоеЗначение = ИсходноеСообщение
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Возвращает структуру данных кода маркировки.
// 
// Возвращаемое значение:
// 	Структура - Параметры статуса кода маркировки:
// * Статус       - ПеречислениеСсылка.СтатусыКодовМаркировкиМОТП - Статус кода маркировки.
// * ИННВладельца - Строка                                        - ИНН владельца кода маркировки.
Функция ПараметрыКодаМаркировки() Экспорт
	
	СтатусКодаМаркировки = Новый Структура;
	СтатусКодаМаркировки.Вставить("Статус");
	СтатусКодаМаркировки.Вставить("ИННВладельца");
	СтатусКодаМаркировки.Вставить("ИННПроизводителя");
	СтатусКодаМаркировки.Вставить("МРЦ");
	СтатусКодаМаркировки.Вставить("Наименование");
	СтатусКодаМаркировки.Вставить("НаименованиеПроизводителя");
	
	Возврат СтатусКодаМаркировки;
	
КонецФункции

// Преобразовывает текстовое представление статуса кода маркировки МОТП в значение перечисления.
//
// Параметры:
//  ЗначениеПоиска - Строка - значение для перекодировки
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыКодовМаркировкиМОТП - статус кода маркировки.
//
Функция СтатусКодаМаркировки(Знач ЗначениеПоиска) Экспорт
	
	ЗначениеПоиска = ВРег(ЗначениеПоиска);
	
	Если ЗначениеПоиска = "EMITTED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Эмитирован;
	ИначеЕсли ЗначениеПоиска = "APPLIED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Нанесен;
	ИначеЕсли ЗначениеПоиска = "APPLIED_PAID" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.НанесенОплачен;
	ИначеЕсли ЗначениеПоиска = "APPLIED_NOT_PAID" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.НанесенНеОплачен;
	ИначеЕсли ЗначениеПоиска = "INTRODUCED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.ВведенВОборот;
	ИначеЕсли ЗначениеПоиска = "RECYCLED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Утилизирован;
	ИначеЕсли ЗначениеПоиска = "RETIRED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.ВыведенИзОборота;
	ИначеЕсли ЗначениеПоиска = "RESERVED_NOT_USED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Неопределен;
	ИначеЕсли ЗначениеПоиска = "WRITTEN_OFF" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Списан;
	ИначеЕсли ЗначениеПоиска = "WITHDRAWN" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Продан;
	ИначеЕсли ЗначениеПоиска = "INTRODUCED_RETURNED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.ВведенВОборотВозвращен;
	ИначеЕсли ЗначениеПоиска = "DISAGGREGATED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Разагрегирован;
	ИначеЕсли ЗначениеПоиска = "WAIT_SHIPMENT" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.ОжидаетДоставки;
	ИначеЕсли ЗначениеПоиска = "EXPORTED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Экспортирован;
	ИначеЕсли ЗначениеПоиска = "LOAN_RETIRED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.ВыведенИзОборотаПоДоговоруРассрочки;
	ИначеЕсли ЗначениеПоиска = "REMARK_RETIRED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.ВыведенИзОборотаПриПеремаркировке;
	ИначеЕсли ЗначениеПоиска = "UNDEFINED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.Неопределен;
	ИначеЕсли ЗначениеПоиска = "ELIMINATED" Тогда
		Возврат Перечисления.СтатусыКодовМаркировкиМОТП.НеИспользован;
	КонецЕсли;
	
	ВызватьИсключение
		СтрШаблон(
			НСтр("ru = 'Неизвестный статус кода маркировки: %1'"),
			ЗначениеПоиска);
	
КонецФункции

// Преобразовывает текстовое представление статуса участника МОТП в значение перечисления.
//
// Параметры:
//  ЗначениеПоиска - Строка - значение для перекодировки
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыУчастниковМОТП - статус участника.
//
Функция СтатусУчастника(Знач ЗначениеПоиска) Экспорт
	
	ЗначениеПоиска = ВРег(ЗначениеПоиска);
	
	Если ЗначениеПоиска = "ЗАРЕГИСТРИРОВАН" Или ЗначениеПоиска = "REGISTERED" Тогда
		Возврат Перечисления.СтатусыУчастниковМОТП.Зарегистрирован;
	КонецЕсли;
	
	ВызватьИсключение
		СтрШаблон(
			НСтр("ru = 'Неизвестный статус участника: %1'"),
			ЗначениеПоиска);
	
КонецФункции

// Преобразовывает текстовое представление типа операции движения кода маркировки МОТП в значение перечисления.
//
// Параметры:
//  ЗначениеПоиска - Строка - значение для перекодировки
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.ТипыОперацийДвиженияКодовМаркировкиМОТП - тип операции движения кода маркировки.
//
Функция ТипОперацииДвиженияКодаМаркировки(Знач ЗначениеПоиска) Экспорт
	
	ЗначениеПоиска = ВРег(ЗначениеПоиска);
	
	Если ЗначениеПоиска = "EMISSION" Тогда
		Возврат Перечисления.ТипыОперацийДвиженияКодовМаркировкиМОТП.Эмиссия;
	ИначеЕсли ЗначениеПоиска = "APPLICATION" Тогда
		Возврат Перечисления.ТипыОперацийДвиженияКодовМаркировкиМОТП.Нанесение;
	ИначеЕсли ЗначениеПоиска = "AGGREGATION" Тогда
		Возврат Перечисления.ТипыОперацийДвиженияКодовМаркировкиМОТП.Агрегация;
	ИначеЕсли ЗначениеПоиска = "OWNER_CHANGE" Тогда
		Возврат Перечисления.ТипыОперацийДвиженияКодовМаркировкиМОТП.СменаВладельца;
	КонецЕсли;
	
	ВызватьИсключение
		СтрШаблон(
			НСтр("ru = 'Неизвестный тип операции движения кода маркировки: %1'"),
			ЗначениеПоиска);
	
КонецФункции

// Преобразовывает текстовое представление типа документа ИС МОТП в значение перечисления.
//
// Параметры:
//  ЗначениеПоиска - Строка - значение для перекодировки
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.ТипыДокументовМОТП - тип документа.
//
Функция ТипДокумента(Знач ЗначениеПоиска) Экспорт
	
	ЗначениеПоиска = ВРег(ЗначениеПоиска);
	
	Если ЗначениеПоиска = "UNIVERSAL_TRANSFER_DOCUMENT" Тогда
		Возврат Перечисления.ТипыДокументовМОТП.УПД;
	ИначеЕсли ЗначениеПоиска = "AGGREGATION_DOCUMENT" Тогда
		Возврат Перечисления.ТипыДокументовМОТП.УведомлениеОбАгрегации;
	КонецЕсли;
	
	ВызватьИсключение
		СтрШаблон(
			НСтр("ru = 'Неизвестный тип документа: %1'"),
			ЗначениеПоиска);
	
КонецФункции

// Преобразовывает текстовое представление статуса документа ИС МОТП в значение перечисления.
//
// Параметры:
//  ЗначениеПоиска - Строка - значение для перекодировки
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыДокументовМОТП - статус документа МОТП.
//
Функция СтатусДокумента(Знач ЗначениеПоиска) Экспорт
	
	ЗначениеПоиска = ВРег(ЗначениеПоиска);
	
	Если ЗначениеПоиска = "CHECKED_OK" Тогда
		Возврат Перечисления.СтатусыДокументовМОТП.Проверен;
	КонецЕсли;
	
	ВызватьИсключение
		СтрШаблон(
			НСтр("ru = 'Неизвестный статус документа: %1'"),
			ЗначениеПоиска);
	
КонецФункции

#Область JWT

Функция РасшифроватьТокенJWT(Токен) Экспорт
	
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("РезультатРасшифровки", Неопределено);
	ВозвращаемоеЗначение.Вставить("ТекстОшибки", "");
	
	ЭлементыТокена = СтрРазделить(Токен, ".");
	Если ЭлементыТокена.Count() <> 3 Тогда
		ВозвращаемоеЗначение.ТекстОшибки = НСтр("ru = 'Токен не соответствует формату JWT'");
		Возврат ВозвращаемоеЗначение;
	КонецЕсли;
	
	ЭлементТокенаДанные = ЭлементыТокена[1];

	Данные = ТекстJSONВОбъект(
		ПолучитьСтрокуИзДвоичныхДанных(
			ДвоичныеДанныеЭлементаТокенаJWT(ЭлементТокенаДанные)));

	Возврат Данные;
	
КонецФункции

Функция ДвоичныеДанныеЭлементаТокенаJWT(Знач Значение)
	
	Значение = СтрЗаменить(Значение, "-", "+");
	Значение = СтрЗаменить(Значение, "_", "/");
	
	Остаток = СтрДлина(Значение) % 4;

	Если Остаток = 1 Тогда
		Возврат Неопределено;
	ИначеЕсли Остаток = 2 Тогда
		Значение = Значение + "==";
	ИначеЕсли Остаток = 3 Тогда
		Значение = Значение + "=";
	КонецЕсли;
	
	Возврат Base64Значение(Значение);
	
КонецФункции

#КонецОбласти

#КонецОбласти