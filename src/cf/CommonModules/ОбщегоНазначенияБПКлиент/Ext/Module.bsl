﻿
#Область ПрограммныйИнтерфейс

// Вызывает из обработчика события "НачалоВыбора" поля субконто.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - Форма объекта.
//	Элемент - ПолеФормы - Поле формы.
//	СтандартнаяОбработка - Булево - Признак стандартной обработки.
//	СписокПараметров - Структура - Дополнительные параметры.
//
Процедура НачалоВыбораЗначенияСубконто(Форма, Элемент, СтандартнаяОбработка, СписокПараметров) Экспорт

	// Совместимость с БП.
	СтандартнаяОбработка = Истина;

КонецПроцедуры

// Функция возвращает Истина, если при изменении даты документа требуется перечитать 
// настройки из базы данных на сервере.
//
// Параметры:
//	НоваяДата - Дата - Новая дата документа.
//	ПредыдущаяДата - Дата - Предыдущая дата документа.
//	ВалютаДокумента - СправочникСсылка.Валюты - Валюта документа.
//	ВалютаРегламентированногоУчета - СправочникСсылка.Валюты - Валюта регламентированного учета.
//
// Возвращаемое значение:
//	Булево - Истина, если необходим вызов сервера при смене даты документа.
//
Функция ТребуетсяВызовСервераПриИзмененииДатыДокумента(НоваяДата, ПредыдущаяДата,
			ВалютаДокумента = Неопределено, ВалютаРегламентированногоУчета = Неопределено) Экспорт

	Результат = Ложь;
	
	Если НачалоДня(НоваяДата) = НачалоДня(ПредыдущаяДата) Тогда
		// Ничего не изменилось либо изменилось только время, от которого ничего не зависит
		Возврат Ложь;
	КонецЕсли;
	
	Если НачалоМесяца(НоваяДата) <> НачалоМесяца(ПредыдущаяДата) Тогда
		// Учетная политика задается с периодичностью до месяца,
		// поэтому в пределах месяца изменения даты не учитываем.
		Результат = Истина;
	КонецЕсли;
	
	Если НЕ Результат
		И ЗначениеЗаполнено(ВалютаДокумента) 
		И ЗначениеЗаполнено(ВалютаРегламентированногоУчета) Тогда
		
		Если ВалютаРегламентированногоУчета <> ВалютаДокумента Тогда
			// Для валютных документов необходимо получение курсов валют на новую дату
			Результат = Истина;
		КонецЕсли;

	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МЕХАНИЗМА УСТАНОВКИ ОСНОВНОЙ ОРГАНИЗАЦИИ
//

// Изменяет значение отбора в динамическом списке.
// Поиск производится по представлению в элементах отборов верхнего уровня.
//
// Надо анализировать возвращаемое значение - и если вернется
//  Неопределено (т.е. отбор не установлен по причине того, что в списке
//  нет отбора по основной организации (он исправлен вручную и т.п.)), то не надо
//  присваивать Неопределено специальному полю "ОтборПоОрганизации" в форме списка.
//
// Параметры:
//  Список         - ДинамическийСписок - список, в котором необходимо изменить значение отбора.
//  ИмяРеквизита   - Строка - имя поля-организации в динамическом списке.
//  ЗначениеОтбора - СправочникСсылка.Организации, СписокЗначений, Массив - значение отбора.
//                   Если значение не задано, то будет подставлена основная организация из
//                   настроек пользователя.
//
// Возвращаемое значение:
//   СправочникСсылка.Организации - Если отбор установлен, то вернет значение отбора.
//
Функция ИзменитьОтборПоОсновнойОрганизации(Список, ИмяРеквизита = "Организация", Знач ЗначениеОтбора = Неопределено) Экспорт

	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Список.КомпоновщикНастроек.Настройки.Отбор, ИмяРеквизита);
	
	Если ЗначениеЗаполнено(ЗначениеОтбора) Тогда
		Если ТипЗнч(ЗначениеОтбора) <> Тип("СправочникСсылка.Организации")
			И ТипЗнч(ЗначениеОтбора) <> Тип("Массив")
			И ТипЗнч(ЗначениеОтбора) <> Тип("СписокЗначений") Тогда
			ЗначениеОтбора = ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка");
		КонецЕсли;
	КонецЕсли;
	
	Если ТипЗнч(ЗначениеОтбора) = Тип("Массив")
		ИЛИ ТипЗнч(ЗначениеОтбора) = Тип("СписокЗначений") Тогда
		ВидСравненияОтбора = ВидСравненияКомпоновкиДанных.ВСписке;
	Иначе
		ВидСравненияОтбора = ВидСравненияКомпоновкиДанных.Равно;
	КонецЕсли;
	
	ИспользованиеОтбора = ЗначениеЗаполнено(ЗначениеОтбора);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, ИмяРеквизита, ЗначениеОтбора, ВидСравненияОтбора, , ИспользованиеОтбора, 
		РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ);
		
	Возврат ЗначениеОтбора;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС ПОЛЯ ВЫБОРА ОРГАНИЗАЦИИ С ОБОСОБЛЕННЫМИ ПОДРАЗДЕЛЕНИЯМИ
//

// Вызывается из обработчика события "ПриИзменении" поля организации.
//
// Параметры:
//	Элемент - ПолеФормы - Поле организации.
//	ПолеОрганизация - Строка - Значение в поле организации.
//	Организация - СправочникаСсылка.Организации - Ссылка на организацию.
//	ВключатьОбособленныеПодразделения - Булево - Признак включения обособленных подразделений.
//
Процедура ПолеОрганизацияПриИзменении(Элемент, ПолеОрганизация, Организация, ВключатьОбособленныеПодразделения) Экспорт
	
	Если Не ЗначениеЗаполнено(ПолеОрганизация) Тогда 
		Организация                       = Неопределено;
		ВключатьОбособленныеПодразделения = Ложь;
	КонецЕсли;
	
КонецПроцедуры

// Вызывается из обработчика события "ОбработкаВыбора" поля организации.
//
// Параметры:
//	Элемент - ПолеФормы - Поле организации.
//	ВыбранноеЗначение - Произвольный - Выбранное значение.
//	СтандартнаяОбработка - Булево - Признак стандартной обработки.
//	СоответствиеОрганизаций - Соответствие - Соответствие организаций.
//	Организация - СправочникСсылка.Организации - Организация.
//	ВключатьОбособленныеПодразделения - Булево - Признак включения обособленных подразделений.
//
Процедура ПолеОрганизацияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка, СоответствиеОрганизаций,
	Организация, ВключатьОбособленныеПодразделения) Экспорт 
	
	Если ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
		Значение = СоответствиеОрганизаций[ВыбранноеЗначение];
		Если ТипЗнч(Значение) = Тип("Структура") Тогда 
			Организация = Значение.Организация;
			ВключатьОбособленныеПодразделения = Значение.ВключатьОбособленныеПодразделения;
		Иначе
			Организация = Неопределено;
			ВключатьОбособленныеПодразделения = Неопределено;
		КонецЕсли;
	Иначе
		Организация = Неопределено;
		ВключатьОбособленныеПодразделения = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

// Вызывается из обработчика события "Открытие" поля организации.
//
// Параметры:
//	Элемент - ПолеФормы - Поле организации.
//	СтандартнаяОбработка - Булево - Признак стандартной обработки.
//	ПолеОрганизация - Строка - Значение в поле организации.
//	СоответствиеОрганизаций - Соответствие - Соответствие организаций.
//
Процедура ПолеОрганизацияОткрытие(Элемент, СтандартнаяОбработка, ПолеОрганизация, СоответствиеОрганизаций) Экспорт
	
	СтандартнаяОбработка = Ложь;
	Если ЗначениеЗаполнено(ПолеОрганизация) Тогда
		Если СоответствиеОрганизаций.Свойство(ПолеОрганизация) Тогда
			Значение = СоответствиеОрганизаций[ПолеОрганизация];
			Если ТипЗнч(Значение) = Тип("Структура") Тогда				
				ПоказатьЗначение( , Значение.Организация);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Процедуры для команд печати

// Возвращает заголовок для печатной формы.
//
// Параметры:
//	ПараметрКоманды - Массив - Массив объектов печати.
//
// Возвращаемое значение:
//	Структура, Неопределено - Структура с ключом "ЗаголовокФормы" или неопределено,
//								если параметров печати несколько.
//
Функция ПолучитьЗаголовокПечатнойФормы(ПараметрКоманды) Экспорт 
	
	Если ТипЗнч(ПараметрКоманды) = Тип("Массив") И ПараметрКоманды.Количество() = 1 Тогда 
		Возврат Новый Структура("ЗаголовокФормы", ПараметрКоманды[0]);
	Иначе
		Возврат Неопределено;
	КонецЕсли;

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Проверка наличия организаций

// Возвращает признак наличия организаций.
//
// Возвращаемое значение:
//	Булево - Признак наличия организаций.
//
Функция ПроверитьНаличиеОрганизаций() Экспорт
	
	// Совместимость с БП.

	Возврат Истина;
	
КонецФункции

// Открывает страницу проверки "Проверьте, относится ли ваша деятельность к пострадавшим от коронавируса"
//
// Параметры:
//  ОсновнойКодОКВЭД - Строка - основной код ОКВЭД, передаваемый сервису в качестве параметра
//
Процедура ОткрытьПроверкуДеятельностиНаКоронавирус(ОсновнойКодОКВЭД) Экспорт
	
	URL = "https://its.1c.ru/anticrisis/affected";
	
	ПараметрыURL = Новый Массив;
	Если ЗначениеЗаполнено(ОсновнойКодОКВЭД) Тогда
		ПараметрыURL.Добавить(СтрШаблон("code=%1", ОсновнойКодОКВЭД));
	КонецЕсли;
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ПараметрыURL, ОбщегоНазначенияБПКлиентСервер.ИТС_ПараметрыUTM());
	
	АдресСервиса = ОбщегоНазначенияБПКлиентСервер.ДополнитьURLПараметрами(URL, ПараметрыURL);
	
	ФайловаяСистемаКлиент.ОткрытьНавигационнуюСсылку(АдресСервиса);
	
КонецПроцедуры

// Открывает страницу проверки включения организации в Реестр СМП
//
// Параметры:
//  ИНН - Строка - ИНН организации
//
Процедура ОткрытьПроверкуРеестрМСП(ИНН) Экспорт
	
	URL = "https://its.1c.ru/bmk/bp30/rmsp";
	
	ПараметрыURL = Новый Массив;
	Если ЗначениеЗаполнено(ИНН) Тогда
		ПараметрыURL.Добавить(СтрШаблон("inn=%1", ИНН));
	КонецЕсли;
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ПараметрыURL, ОбщегоНазначенияБПКлиентСервер.ИТС_ПараметрыUTM());
	
	АдресСервиса = ОбщегоНазначенияБПКлиентСервер.ДополнитьURLПараметрами(URL, ПараметрыURL);
	
	ФайловаяСистемаКлиент.ОткрытьНавигационнуюСсылку(АдресСервиса);
	
КонецПроцедуры


#КонецОбласти