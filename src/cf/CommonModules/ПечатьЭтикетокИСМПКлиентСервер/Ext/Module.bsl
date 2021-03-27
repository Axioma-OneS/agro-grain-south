﻿#Область ПрограммныйИнтерфейс

// Структура для заполнения данными, по которым будет производится резервирование и печать кодов
// маркировки товаров.
// 
// Возвращаемое значение:
// 	Структура - Описание:
// * Организация              - ОпределяемыйТип.Организации - Организация. 
// * ВидПродукции             - ПеречислениеСсылка.ВидыПродукциИСМП - Вид продукции.
// * СпособВводаВОборот       - ПеречислениеСсылка.СпособыВводаВОборотСУЗ - Способ ввода 
// * Шаблон                   - ПеречислениеСсылка.ШаблоныКодовМаркировкиСУЗ - Шаблон кода маркировки
// * ШтрихкодУпаковки         - СправочникСсылка.ШтрихкодыУпаковокТоваров - Источник получения серии и типа штрихкода,
//                              если эти параметры не заполнены в соответствующих ключах.
// * ЭтоКодМаркировки         - Булево - Признак принадлежности структуры к маркируемой продукции,
//                              так же, могут печататься логистические упаковки.
// * СодержимоеКоличество     - Число - Количество элементов внутри (для логистической упаковки)
// * НомерВГруппе             - Число - Номер по порядку (для логистической упаковки)
// * Количество               - Число - Количество этикеток для печати
// * ШаблонЭтикетки           - СправочникСсылка.ШаблоныЭтикетокИЦенников - Шаблон для печати
// * ТипШтрихкода             - ПеречислениеСсылка.ТипыШтрихкодов - Тип штрихкода для печати
// * Штрихкод                 - Строка - Значение штрихкода (используется дла печати и отметки о печати известного кода)
// * Серия                    - СправочникСсылка.СерииНоменклатуры - Серия, устанавливается в новый элемент 
//                              ШтрикодУпаковкиТоваров
// * Номенклатура             - СправочникСсылка.Номенклатура - Номенклатура для заполнения шаблона
// * Характеристика           - СправочникСсылка.ХарактеристикиНоменклатуры - Характеристика для заполнения шаблона
Функция СтруктураПечатиЭтикетки() Экспорт
	
	ПараметрыШтрихкода = Новый Структура;
	ПараметрыШтрихкода.Вставить("Организация");
	ПараметрыШтрихкода.Вставить("ВидПродукции");
	ПараметрыШтрихкода.Вставить("Номенклатура");
	ПараметрыШтрихкода.Вставить("Характеристика");
	ПараметрыШтрихкода.Вставить("Серия");
	ПараметрыШтрихкода.Вставить("Штрихкод");
	ПараметрыШтрихкода.Вставить("ТипШтрихкода");
	ПараметрыШтрихкода.Вставить("ШаблонЭтикетки");
	ПараметрыШтрихкода.Вставить("Количество", 0);
	ПараметрыШтрихкода.Вставить("НомерВГруппе", 0);
	ПараметрыШтрихкода.Вставить("СодержимоеКоличество", 0);
	ПараметрыШтрихкода.Вставить("ЭтоКодМаркировки", Истина);
	ПараметрыШтрихкода.Вставить("ШтрихкодУпаковки",
		ПредопределенноеЗначение("Справочник.ШтрихкодыУпаковокТоваров.ПустаяСсылка"));
	ПараметрыШтрихкода.Вставить("Шаблон");
	ПараметрыШтрихкода.Вставить("СпособВводаВОборот");
	ПараметрыШтрихкода.Вставить("СрокГодности");
	ПараметрыШтрихкода.Вставить("КодМаркировки");
	ПараметрыШтрихкода.Вставить("ХешСуммаКодаМаркировки");
	ПараметрыШтрихкода.Вставить("МаркировкаОстатков");
	ПараметрыШтрихкода.Вставить("GTIN");
	
	Возврат ПараметрыШтрихкода;
	
КонецФункции

// Подготавливает структуру исходных данных для передачи в функцию печати
// У формы вдалельцем должна выступать форма с основным реквизитом Объект. 
// Для резервирования необходима ссылка,поэтому для новых объектов будет предпринята попытка записать
// Во входящей структуре могут быть заполнены не все поля. Обязательными являются Номенклатура [, Характеристика]
// Если не заполнено поле ШаблонЭтикетки - шаблон будет запрошен у пользователя.
// 
// Параметры:
// 	ПараметрыПечати - Струткрура - (См. ШтрихкодированиеИСМПКлиентСервер.СтруктураПечатиЭтикетки)
// 	Форма - УправляемаяФорм - Источник событий
// 	Документ - ДокументСсылка - Документ, к которому будут относиться коды маркировок 
// Возвращаемое значение:
// 	Структура - Описание:
// * КаждаяЭтикеткаНаНовомЛисте - Булево - для данной функции не актульно, потому что печатается одна этикетка
// * Документ - Документ-основание, на который необходимо перерезервировать свободный код маркировки
// * АдресВХранилище - Строка - адрес объектов печати
Функция ДанныеДляПечатиЭтикеток(ПараметрыПечати, Форма, Документ) Экспорт
	
	Если Не ЗначениеЗаполнено(Документ) Тогда
		ВызватьИсключение НСтр("ru = 'Внутренняя ошибка. Пустая ссылка на документ'");
	КонецЕсли;
	
	ПараметрыПечати.Количество = 1;

	ОбъектыПечати = Новый Массив;
	ОбъектыПечати.Добавить(ПараметрыПечати);
	
	СтруктураОбъектовПечати = Новый Структура();
	СтруктураОбъектовПечати.Вставить("РежимПечати", "НеРаспечатанныеКодыПоДокументуСРезервированием");
	СтруктураОбъектовПечати.Вставить("ОбъектыПечати", ОбъектыПечати);
	
	ДанныеДляПечати = Новый Структура;
	ДанныеДляПечати.Вставить("АдресВХранилище",
		ПоместитьВоВременноеХранилище(СтруктураОбъектовПечати, Форма.УникальныйИдентификатор));
	ДанныеДляПечати.Вставить("Документ", Документ);
	ДанныеДляПечати.Вставить("КаждаяЭтикеткаНаНовомЛисте", Истина);

	Возврат ДанныеДляПечати;
	
КонецФункции

#КонецОбласти