﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

#Область Статусы

// Возвращает конечные статусы.
//
// Возвращаемое значение:
//  Массив - Конечные статусы.
//
Функция КонечныеСтатусы(ТребуетсяПовторноеОформление = Истина) Экспорт
	
	Статусы = Новый Массив;
	
	Если Не ТребуетсяПовторноеОформление Тогда
		Статусы.Добавить(Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаВыполнена);
	КонецЕсли;
	
	Возврат Статусы;
	
КонецФункции

// Возвращает статусы ошибок.
//
// Возвращаемое значение:
//  Массив - Статусы ошибок.
//
Функция СтатусыОшибок() Экспорт
	
	Статусы = Новый Массив;
	
	Статусы.Добавить(Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.БлокировкаКодовМаркировкиОшибкаПередачи);
	Статусы.Добавить(Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаОшибкаПередачи);
	
	Возврат Статусы;
	
КонецФункции

// Возвращает статус по умолчанию.
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП- Статус по-умолчанию.
//
Функция СтатусПоУмолчанию() Экспорт
	
	Возврат Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.Черновик;
	
КонецФункции

// Возвращает дальнейшее действие по умолчанию.
//
// Возвращаемое значение:
//  ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие по-умолчанию.
//
Функция ДальнейшееДействиеПоУмолчанию(СтруктураПараметров=Неопределено) Экспорт
	
	ДальнейшиеДействия = Новый Массив;
	ДальнейшиеДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ЗаблокируйтеКодыМаркировки);
	ДальнейшиеДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ВыполнитеПеремаркировку);
	
	Возврат ДальнейшиеДействия;
	
КонецФункции

#КонецОбласти

#Область ДействияПриОбменеИСМП

// Статус после подготовки к передаче данных
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Ссылка на документ
//  Операция - ПеречислениеСсылка.ВидыОперацийИСМП - Операция ИСМП
//  ДополнительныеПараметры - Структура - Дополнительные параметры
//
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * НовыйСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Новый статус.
//   * ДальнейшееДействие1 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 1.
//   * ДальнейшееДействие2 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 2.
//   * ДальнейшееДействие3 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 3.
//
Функция СтатусПослеПодготовкиКПередачеДанных(ДокументСсылка, Операция, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если Операция = Перечисления.ВидыОперацийИСМП.СписаниеВведенныхВОборотКодовМаркировки Тогда
		
		ПараметрыОбновления = РегистрыСведений.СтатусыДокументовИСМП.РассчитатьСтатусыКПередаче(
			ДокументСсылка,
			Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.БлокировкаКодовМаркировкиКПередаче);
		
	ИначеЕсли Операция = Перечисления.ВидыОперацийИСМП.Перемаркировка Тогда
		
		ПараметрыОбновления = РегистрыСведений.СтатусыДокументовИСМП.РассчитатьСтатусыКПередаче(
			ДокументСсылка,
			Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаКПередаче);
		
	Иначе
		ВызватьИсключение ИнтеграцияИС.ТекстИсключенияОбработкиСтатуса(ДокументСсылка, Операция);
	КонецЕсли;
	
	Возврат ПараметрыОбновления;
	
КонецФункции

// Статус после передачи данных
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Ссылка на документ
//  Операция - ПеречислениеСсылка.ВидыОперацийИСМП - Операция ИСМП
//  СтатусОбработки - ПеречислениеСсылка.СтатусыОбработкиСообщенийИСМП - Статус обработки сообщения
//
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * НовыйСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Новый статус.
//   * ДальнейшееДействие1 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 1.
//   * ДальнейшееДействие2 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 2.
//   * ДальнейшееДействие3 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 3.
//
Функция СтатусПослеПередачиДанных(ДокументСсылка, Операция, СтатусОбработки) Экспорт
	
	Если СтатусОбработки = Неопределено Тогда
		СтатусОбработки = Перечисления.СтатусыОбработкиСообщенийИСМП.ЗаявкаПринята;
	КонецЕсли;
	
	Если Операция = Перечисления.ВидыОперацийИСМП.СписаниеВведенныхВОборотКодовМаркировки Тогда
		
		СтатусыБазовыйПроцесс = РегистрыСведений.СтатусыДокументовИСМП.СтруктураСтатусы();
		
		СтатусыБазовыйПроцесс.Принят = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.БлокировкаКодовМаркировкиОбрабатывается;
		СтатусыБазовыйПроцесс.ПринятДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОжидайтеЗавершенияОбработкиДанныхИСМП);
		
		СтатусыБазовыйПроцесс.Ошибка = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.БлокировкаКодовМаркировкиОшибкаПередачи;
		СтатусыБазовыйПроцесс.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ЗаблокируйтеКодыМаркировки);
		СтатусыБазовыйПроцесс.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОтменитеОперацию);
		
		ПараметрыОбновления = РегистрыСведений.СтатусыДокументовИСМП.РассчитатьСтатусы(ДокументСсылка, СтатусОбработки, СтатусыБазовыйПроцесс);
		
	ИначеЕсли Операция = Перечисления.ВидыОперацийИСМП.Перемаркировка Тогда
		
		СтатусыБазовыйПроцесс = РегистрыСведений.СтатусыДокументовИСМП.СтруктураСтатусы();
		
		СтатусыБазовыйПроцесс.Принят = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаОбрабатывается;
		СтатусыБазовыйПроцесс.ПринятДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОжидайтеЗавершенияОбработкиДанныхИСМП);
		
		СтатусыБазовыйПроцесс.Ошибка = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаОшибкаПередачи;
		СтатусыБазовыйПроцесс.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ВыполнитеПеремаркировку);
		СтатусыБазовыйПроцесс.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОтменитеОперацию);
		
		ПараметрыОбновления = РегистрыСведений.СтатусыДокументовИСМП.РассчитатьСтатусы(ДокументСсылка, СтатусОбработки, СтатусыБазовыйПроцесс);
		
	Иначе
		ВызватьИсключение ИнтеграцияИС.ТекстИсключенияОбработкиСтатуса(ДокументСсылка, Операция);
	КонецЕсли;
	
	Возврат ПараметрыОбновления;
	
КонецФункции

// Статус после получения данных из ИСМП.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Документ, для которого требуется обновить статус.
//  Операция - ПеречислениеСсылка.ВидыОперацийИСМП - Операция обмена с ИСМП.
//  ДополнительныеПараметры - Неопределено, Структура - Свойства:
//   * СтатусОбработки - ПеречислениеСсылка.СтатусыОбработкиСообщенийИСМП - Статус обработки сообщения.
//   * ОперацияКвитанции - ПеречислениеСсылка.ВидыОперацийИСМП - Операция, на которую получена квитанция.
//
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * НовыйСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Новый статус.
//   * ДальнейшееДействие1 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 1.
//   * ДальнейшееДействие2 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 2.
//   * ДальнейшееДействие3 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 3.
//
Функция СтатусПослеПолученияДанных(ДокументСсылка, Операция, ДополнительныеПараметры) Экспорт
	
	Если Операция = Перечисления.ВидыОперацийИСМП.ПолучениеРезультатаОбработкиДокумента
		И ДополнительныеПараметры.ОперацияКвитанции = Перечисления.ВидыОперацийИСМП.СписаниеВведенныхВОборотКодовМаркировки Тогда
		
		Статусы = РегистрыСведений.СтатусыДокументовИСМП.СтруктураСтатусы();
		Статусы.Принят = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.КодыМаркировкиЗаблокированыДляПродажи;
		Статусы.ПринятДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ВыполнитеПеремаркировку);
		
		Статусы.Ошибка = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаОшибкаПередачи;
		Статусы.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ЗаблокируйтеКодыМаркировки);
		Статусы.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОтменитеОперацию);
		
		ПараметрыОбновления = РегистрыСведений.СтатусыДокументовИСМП.РассчитатьСтатусы(
			ДокументСсылка,
			ДополнительныеПараметры.СтатусОбработки,
			Статусы);
		
	ИначеЕсли Операция = Перечисления.ВидыОперацийИСМП.ПолучениеРезультатаОбработкиДокумента
		И ДополнительныеПараметры.ОперацияКвитанции = Перечисления.ВидыОперацийИСМП.Перемаркировка Тогда
		
		Статусы = РегистрыСведений.СтатусыДокументовИСМП.СтруктураСтатусы();
		Статусы.Принят = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаВыполнена;
		
		Статусы.Ошибка = Перечисления.СтатусыОбработкиПеремаркировкиТоваровИСМП.ПеремаркировкаОшибкаПередачи;
		Статусы.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ВыполнитеПеремаркировку);
		Статусы.ОшибкаДействия.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОтменитеОперацию);
		
		ПараметрыОбновления = РегистрыСведений.СтатусыДокументовИСМП.РассчитатьСтатусы(
			ДокументСсылка,
			ДополнительныеПараметры.СтатусОбработки,
			Статусы);
		
	Иначе
		ВызватьИсключение ИнтеграцияИС.ТекстИсключенияОбработкиСтатуса(ДокументСсылка, Операция);
	КонецЕсли;
	
	Возврат ПараметрыОбновления;
	
КонецФункции

// Обновить статус после подготовки к передаче данных
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Ссылка на документ
//  Операция - ПеречислениеСсылка.ВидыОперацийИСМП - Операция ИСМП
//  ДополнительныеПараметры - Неопределено, Структура - дополнительные параметры обновления статуса
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Новый статус.
//
Функция ОбновитьСтатусПослеПодготовкиКПередачеДанных(ДокументСсылка, Операция, ДополнительныеПараметры = Неопределено) Экспорт
	
	ПараметрыОбновления = СтатусПослеПодготовкиКПередачеДанных(
		ДокументСсылка, Операция, ДополнительныеПараметры);
	
	Если ПараметрыОбновления = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НовыйСтатусПослеОбновления = РегистрыСведений.СтатусыДокументовИСМП.ОбновитьСтатус(
		ДокументСсылка,
		ПараметрыОбновления, ДополнительныеПараметры);
	
	Возврат НовыйСтатусПослеОбновления;
	
КонецФункции

// Обновить статус после передачи данных
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Ссылка на документ
//  Операция - ПеречислениеСсылка.ВидыОперацийИСМП - Операция ИСМП
//  СтатусОбработки - ПеречислениеСсылка.СтатусыОбработкиСообщенийИСМП - Статус обработки сообщения
//  ДополнительныеПараметры - Неопределено, Структура - дополнительные параметры обновления статуса
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Новый статус.
//
Функция ОбновитьСтатусПослеПередачиДанных(ДокументСсылка, Операция, СтатусОбработки, ДополнительныеПараметры = Неопределено) Экспорт
	
	ПараметрыОбновления = СтатусПослеПередачиДанных(ДокументСсылка, Операция, СтатусОбработки);
	
	Если ПараметрыОбновления = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НовыйСтатусПослеОбновления = РегистрыСведений.СтатусыДокументовИСМП.ОбновитьСтатус(
		ДокументСсылка,
		ПараметрыОбновления, ДополнительныеПараметры);
	
	Возврат НовыйСтатусПослеОбновления;
	
КонецФункции

// Обновить статус после получения данных из ИСМП.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Документ, для которого требуется обновить статус.
//  Операция - ПеречислениеСсылка.ВидыОперацийИСМП - Операция обмена с ИСМП.
//  ДополнительныеПараметры - Структура - Свойства:
//   * СтатусОбработки - ПеречислениеСсылка.СтатусыОбработкиСообщенийИСМП - Статус обработки сообщения.
//   * ОперацияКвитанции - ПеречислениеСсылка.ВидыОперацийИСМП - Операция, на которую получена квитанция.
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Новый статус.
//
Функция ОбновитьСтатусПослеПолученияДанных(ДокументСсылка, Операция, ДополнительныеПараметры = Неопределено) Экспорт
	
	ПараметрыОбновления = СтатусПослеПолученияДанных(ДокументСсылка, Операция, ДополнительныеПараметры);
	
	Если ПараметрыОбновления = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НовыйСтатусПослеОбновления = РегистрыСведений.СтатусыДокументовИСМП.ОбновитьСтатус(
		ДокументСсылка,
		ПараметрыОбновления, ДополнительныеПараметры);
	
	Возврат НовыйСтатусПослеОбновления;
	
КонецФункции

// Изменяет и возвращает статус документа ИС МП.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка - Документ ИС МП.
//  ПараметрыОбновления - Структура - Структура со свойствами:
//   * НовыйСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Новый статус.
//   * ДальнейшееДействие1 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 1.
//   * ДальнейшееДействие2 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 2.
//   * ДальнейшееДействие3 - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие 3.
//  ДополнительныеПараметры - Структура - Дополнительные параметры.
// Возвращаемое значение:
//  ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - новый статус документа ИС МП.
Функция ОбновитьСтатус(ДокументСсылка, ПараметрыОбновления, ДополнительныеПараметры) Экспорт
	
	НовыйСтатусПослеОбновления = РегистрыСведений.СтатусыДокументовИСМП.ОбновитьСтатус(
		ДокументСсылка,
		ПараметрыОбновления, ДополнительныеПараметры);
	
	Возврат НовыйСтатусПослеОбновления;
	
КонецФункции

// Получить последовательность операций в течении жизненного цикла документа.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Документ, для которого требуется обновить статус.
//
// Возвращаемое значение:
//  ТаблицаЗначений - см. функцию ИнтеграцияИСМП.ПустаяТаблицаПоследовательностьОпераций().
//
Функция ПоследовательностьОпераций(ДокументСсылка, ЛинейныйСписок = Ложь) Экспорт
	
	Таблица = ИнтеграцияИС.ПустаяТаблицаПоследовательностьОпераций();
	
	Исходящий = Перечисления.ТипыЗапросовИС.Исходящий;
	Входящий  = Перечисления.ТипыЗапросовИС.Входящий;
	
	ИнтеграцияИС.ДобавитьОперациюВПоследовательность(Таблица, 0,
		Исходящий,
		Перечисления.ВидыОперацийИСМП.СписаниеВведенныхВОборотКодовМаркировки);
	
	ИнтеграцияИС.ДобавитьОперациюВПоследовательность(Таблица, 01,
		Входящий,
		Перечисления.ВидыОперацийИСМП.ПолучениеРезультатаОбработкиДокумента);
	
	ИнтеграцияИС.ДобавитьОперациюВПоследовательность(Таблица, 0,
		Исходящий,
		Перечисления.ВидыОперацийИСМП.Перемаркировка);
	
	ИнтеграцияИС.ДобавитьОперациюВПоследовательность(Таблица, 02,
		Входящий,
		Перечисления.ВидыОперацийИСМП.ПолучениеРезультатаОбработкиДокумента);
	
	ИнтеграцияИС.ДобавитьОперациюВПоследовательность(Таблица, 1,
		Исходящий,
		Перечисления.ВидыОперацийИСМП.Перемаркировка);
	
	Возврат Таблица;
	
КонецФункции

// Перерасчитать статус оформления документов.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Документ, по которому требуется рассчитать статус оформления.
//  ПредыдущийСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Предыдущий статус.
//  НовыйСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Предыдущий статус.
//
Процедура РассчитатьСтатусОформления(ДокументСсылка, ПредыдущийСтатус, НовыйСтатус) Экспорт
	
	Если КонечныеСтатусы().Найти(НовыйСтатус) <> Неопределено Тогда
		РасчетСтатусовОформленияИСМП.РассчитатьСтатусОформления(ДокументСсылка);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик изменения статуса документа.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Документ.
//  ПредыдущийСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Предыдущий статус.
//  НовыйСтатус - ПеречислениеСсылка.СтатусыОбработкиПеремаркировкиТоваровИСМП - Предыдущий статус.
//  ПараметрыОбновленияСтатуса - Структура - см. функцию ИнтеграцияИСМП.ПараметрыОбновленияСтатуса().
//
Процедура ПриИзмененииСтатусаДокумента(ДокументСсылка, ПредыдущийСтатус, НовыйСтатус, ПараметрыОбновленияСтатуса) Экспорт
	
	ИнтеграцияИСМППереопределяемый.ПриИзмененииСтатусаДокумента(ДокументСсылка, ПредыдущийСтатус, НовыйСтатус, ПараметрыОбновленияСтатуса);
	
	РассчитатьСтатусОформления(ДокументСсылка, ПредыдущийСтатус, НовыйСтатус);
	
КонецПроцедуры

#КонецОбласти

#Область ПанельОбменИСМП

// Возвращает массив дальнейших действий с документом, требующих участия пользователя
// 
// Возвращаемое значение:
// 	Массив из ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - дальшейшие действия
//
Функция ВсеТребующиеДействия() Экспорт
	
	МассивДействий = Новый Массив;
	МассивДействий.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ВыполнитеОбмен);
	МассивДействий.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОтменитеОперацию);
	МассивДействий.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ЗаблокируйтеКодыМаркировки);
	МассивДействий.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ВыполнитеПеремаркировку);
	
	Возврат МассивДействий;
	
КонецФункции

// Возвращает массив дальнейших действий с документом, требующих ожидания пользователем
// 
// Возвращаемое значение:
// 	Массив из ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - дальшейшие действия
//
Функция ВсеТребующиеОжидания() Экспорт
	
	МассивДействий = Новый Массив;
	МассивДействий.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОжидайтеПередачуДанныхРегламентнымЗаданием);
	МассивДействий.Добавить(Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ОжидайтеЗавершенияОбработкиДанныхИСМП);
	
	Возврат МассивДействий;
	
КонецФункции

#КонецОбласти

#Область Сообщения

// Сообщение к передаче JSON
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Перемаркировка ИС МП.
//  ДальнейшееДействие - ПеречислениеСсылка.ДальнейшиеДействияПоВзаимодействиюИСМП - Дальнейшее действие.
//  ДополнительныеПараметры - Структура, Неопределено - Дополнительные параметры
//
// Возвращаемое значение:
//  Массив Из См. ИнтеграцияИСМПСлужебный.СтруктураСообщенияJSON - Сообщения к передаче
//
Функция СообщениеКПередачеJSON(ДокументСсылка, ДальнейшееДействие, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если ДальнейшееДействие = Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ВыполнитеПеремаркировку Тогда
		
		Возврат ПеремаркировкаJSON(ДокументСсылка, ДополнительныеПараметры);
		
	ИначеЕсли ДальнейшееДействие = Перечисления.ДальнейшиеДействияПоВзаимодействиюИСМП.ЗаблокируйтеКодыМаркировки Тогда
		
		Возврат БлокировкаКодовМаркировкиJSON(ДокументСсылка, ДополнительныеПараметры);
		
	КонецЕсли;
	
КонецФункции

// Формирует JSON сообщения для перемаркировки товаров
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Документ Перемаркировка товаров ИСМП
//  ДополнительныеПараметры - Структура, Неопределено - Дополнительные параметры
//
// Возвращаемое значение:
//  Массив Из См. ИнтеграцияИСМПСлужебный.СтруктураСообщенияJSON - Сообщения к передаче
Функция ПеремаркировкаJSON(ДокументСсылка, ДополнительныеПараметры = Неопределено)
	
	Операция = Перечисления.ВидыОперацийИСМП.Перемаркировка;
	
	СообщенияJSON = Новый Массив;
	
	СписокЗапросов = Новый СписокЗначений;
	
	СписокЗапросов.Добавить(
	"ВЫБРАТЬ
	|	ИСМППрисоединенныеФайлы.ВладелецФайла КАК Ссылка,
	|	КОЛИЧЕСТВО(ИСМППрисоединенныеФайлы.Ссылка) КАК ПоследнийНомерВерсии
	|ПОМЕСТИТЬ Версии
	|ИЗ
	|	Справочник.ИСМППрисоединенныеФайлы КАК ИСМППрисоединенныеФайлы
	|ГДЕ
	|	ИСМППрисоединенныеФайлы.ВладелецФайла = &Ссылка
	|	И ИСМППрисоединенныеФайлы.ТипСообщения = ЗНАЧЕНИЕ(Перечисление.ТипыЗапросовИС.Исходящий)
	|СГРУППИРОВАТЬ ПО
	|	ИСМППрисоединенныеФайлы.ВладелецФайла
	|");
	
	СписокЗапросов.Добавить(
	"ВЫБРАТЬ
	|	Шапка.Номер                              КАК Номер,
	|	Шапка.Дата                               КАК Дата,
	|	ЕСТЬNULL(Версии.ПоследнийНомерВерсии, 0) КАК ПоследнийНомерВерсии,
	|	Шапка.ДокументОснование                  КАК ДокументОснование,
	|
	|	Шапка.Организация                КАК Организация,
	|	Шапка.ВидПродукции               КАК ВидПродукции,
	|	Представление(Шапка.Организация) КАК ОрганизацияПредставление,
	|
	|	Шапка.Ответственный                КАК Ответственный,
	|	Представление(Шапка.Ответственный) КАК ОтветственныйПредставление
	|ИЗ
	|	Документ.ПеремаркировкаТоваровИСМП КАК Шапка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Версии КАК Версии
	|		ПО Шапка.Ссылка = Версии.Ссылка
	|ГДЕ
	|	Шапка.Ссылка = &Ссылка",
	"Шапка");
	
	СписокЗапросов.Добавить(
	"ВЫБРАТЬ
	|	// Универсальные реквизиты
	|	Товары.Номенклатура   КАК Номенклатура,
	|	Товары.Характеристика КАК Характеристика,
	|
	|	// Дополнительные реквизиты
	|	ЕСТЬNULL(Товары.КодМаркировки.ЗначениеШтрихкода, """")      КАК КодМаркировки,
	|	ЕСТЬNULL(Товары.НовыйКодМаркировки.ЗначениеШтрихкода, """") КАК НовыйКодМаркировки,
	|	Товары.ПричинаПеремаркировки                                КАК ПричинаПеремаркировки,
	|	
	|	Товары.ВидДокументаСертификации   КАК ВидДокументаСертификации,
	|	Товары.НомерДокументаСертификации КАК НомерДокументаСертификации,
	|	Товары.ДатаДокументаСертификации  КАК ДатаДокументаСертификации
	|ИЗ
	|	Документ.ПеремаркировкаТоваровИСМП.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка = &Ссылка
	|",
	"Товары");
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
	РезультатЗапроса = ИнтеграцияИС.ВыполнитьПакетЗапросов(Запрос, СписокЗапросов);
	
	//@skip-warning
	Шапка  = РезультатЗапроса["Шапка"].Выбрать();
	//@skip-warning
	Товары = РезультатЗапроса["Товары"].Выгрузить();
	
	Если Не Шапка.Следующий()
		Или Товары.Количество() = 0 Тогда
		
		СообщениеJSON = ИнтеграцияИСМПСлужебный.СтруктураСообщенияJSON();
		СообщениеJSON.Организация = Шапка.Организация;
		СообщениеJSON.Документ    = ДокументСсылка;
		СообщениеJSON.Описание = ИнтеграцияИСМПСлужебный.ОписаниеОперацииПередачиДанных(
			Операция, ДокументСсылка);
		СообщениеJSON.ТекстОшибки = НСтр("ru = 'Нет данных для выгрузки.'");
		СообщениеJSON.ТребуетсяПодписание = Ложь;
		СообщенияJSON.Добавить(СообщениеJSON);
		
		Возврат СообщенияJSON;
		
	КонецЕсли;
	
	НомерВерсии = Шапка.ПоследнийНомерВерсии + 1;
	
	СообщениеJSON = ИнтеграцияИСМПСлужебный.СтруктураСообщенияJSON();
	СообщениеJSON.Организация       = Шапка.Организация;
	СообщениеJSON.Документ          = ДокументСсылка;
	СообщениеJSON.ДокументОснование = Шапка.ДокументОснование;
	СообщениеJSON.ВидПродукции      = Шапка.ВидПродукции;
	
	СообщениеJSON.Описание = ИнтеграцияИСМПСлужебный.ОписаниеОперацииПередачиДанных(
		Операция, ДокументСсылка, НомерВерсии);
	
	РеквизитыОрганизации = ИнтеграцияИСВызовСервера.ИННКПППоОрганизацииКонтрагенту(Шапка.Организация);
	
	Если Не ЗначениеЗаполнено(РеквизитыОрганизации.ИНН) Тогда
		ИнтеграцияИСКлиентСервер.ДобавитьТекстОшибки(
			СообщениеJSON,
			СтрШаблон(
				НСтр("ru = 'Не заполнено поле ""ИНН"" для организации %1'"), Шапка.Организация));
	КонецЕсли;
	
	ПараметрыНормализацииПрочее = ШтрихкодированиеИССлужебный.ПараметрыНормализацииКодаМаркировки();
	ПараметрыНормализацииПрочее.ИмяСвойстваКодМаркировки = "Штрихкод";
	ПараметрыНормализацииПрочее.НачинаетсяСоСкобки       = Ложь;
	
	ТелоЗапроса = Новый Структура;
	ТелоЗапроса.Вставить("participant_inn", РеквизитыОрганизации.ИНН);
	ТелоЗапроса.Вставить("remarking_date",  ИнтеграцияИС.ДатаUTC(Шапка.Дата));
	ТелоЗапроса.Вставить("products",        Новый Массив);
	
	Для Каждого СтрокаТЧТовары Из Товары Цикл
		
		СтрокаТЧ = Новый Структура;
		
		РезультатРазбора = ШтрихкодированиеИС.НоваяСтруктураОбработкиШтрихкода(
			СтрокаТЧТовары.КодМаркировки, Шапка.ВидПродукции);
		СтрокаТЧ.Вставить(
			"last_uin",
			ШтрихкодированиеИСМП.КодМаркировкиДляПередачиИСМП(РезультатРазбора, ПараметрыНормализацииПрочее));
			
		РезультатРазбора = ШтрихкодированиеИС.НоваяСтруктураОбработкиШтрихкода(
			СтрокаТЧТовары.НовыйКодМаркировки, Шапка.ВидПродукции);
		СтрокаТЧ.Вставить(
			"new_uin",
			ШтрихкодированиеИСМП.КодМаркировкиДляПередачиИСМП(РезультатРазбора, ПараметрыНормализацииПрочее));

		СтрокаТЧ.Вставить("remarking_cause", ИнтерфейсИСМПСлужебный.ПричинаПеремаркировки(СтрокаТЧТовары.ПричинаПеремаркировки));
		СтрокаТЧ.Вставить("remarking_date",  ИнтеграцияИС.ДатаUTC(Шапка.Дата));
		ТелоЗапроса.Вставить("remarking_cause", СтрокаТЧ.remarking_cause);
		
		Если СтрокаТЧТовары.ПричинаПеремаркировки = Перечисления.ПричиныПеремаркировкиТоваровИСМП.ОшибкиОписанияТовара Тогда
			// Сертификация
			СтрокаТЧ.Вставить("certificate_document",        ИнтерфейсИСМПСлужебный.ВидДокументаСертификации(СтрокаТЧТовары.ВидДокументаСертификации));
			СтрокаТЧ.Вставить("certificate_document_number", СтрокаТЧТовары.НомерДокументаСертификации);
			СтрокаТЧ.Вставить("certificate_document_date",   ИнтеграцияИС.ДатаUTC(СтрокаТЧТовары.ДатаДокументаСертификации));
		КонецЕсли;
		
		ТелоЗапроса.products.Добавить(СтрокаТЧ);
		
	КонецЦикла;
	
	ТекстСообщенияJSON = ИнтерфейсМОТПСлужебный.ОбъектВТекстJSON(ТелоЗапроса, Истина);
	
	СообщениеJSON.ТекстСообщенияJSON  = ТекстСообщенияJSON;
	СообщениеJSON.ТипСообщения        = Перечисления.ТипыЗапросовИС.Исходящий;
	СообщениеJSON.Версия              = НомерВерсии;
	СообщениеJSON.ТребуетсяПодписание = Истина;
	
	СообщениеJSON.Операция                  = Операция;
	СообщениеJSON.Назначение                = Перечисления.НазначениеСообщенийИСМП.ИСМП;
	СообщениеJSON.СтанцияУправленияЗаказами = Неопределено;
	
	СообщенияJSON.Добавить(СообщениеJSON);
	
	Возврат СообщенияJSON;
	
КонецФункции

// Формирует JSON сообщения для блокировки продажи кодов маркировки
//
// Параметры:
//  ДокументСсылка - ДокументСсылка.ПеремаркировкаТоваровИСМП - Документ Перемаркировка товаров ИСМП
//  ДополнительныеПараметры - Структура, Неопределено - Дополнительные параметры
//
// Возвращаемое значение:
//  Массив Из См. ИнтеграцияИСМПСлужебный.СтруктураСообщенияJSON - Сообщения к передаче
Функция БлокировкаКодовМаркировкиJSON(ДокументСсылка, ДополнительныеПараметры = Неопределено)
	
	СообщенияJSON = Новый Массив;
	
	СписокЗапросов = Новый СписокЗначений;
	
	СписокЗапросов.Добавить(
	"ВЫБРАТЬ
	|	ИСМППрисоединенныеФайлы.Документ           КАК Ссылка,
	|	КОЛИЧЕСТВО(ИСМППрисоединенныеФайлы.Ссылка) КАК ПоследнийНомерВерсии
	|ПОМЕСТИТЬ Версии
	|ИЗ
	|	Справочник.ИСМППрисоединенныеФайлы КАК ИСМППрисоединенныеФайлы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПеремаркировкаТоваровИСМП КАК Шапка
	|		ПО Шапка.Ссылка = &Ссылка
	|		И &Операция     = ИСМППрисоединенныеФайлы.Операция
	|		И Шапка.Ссылка  = ИСМППрисоединенныеФайлы.Документ
	|ГДЕ
	|	ИСМППрисоединенныеФайлы.ТипСообщения = ЗНАЧЕНИЕ(Перечисление.ТипыЗапросовИС.Исходящий)
	|СГРУППИРОВАТЬ ПО
	|	ИСМППрисоединенныеФайлы.Документ
	|");
	
	СписокЗапросов.Добавить(
	"ВЫБРАТЬ
	|	Шапка.Номер                              КАК Номер,
	|	Шапка.Дата                               КАК Дата,
	|	ЕСТЬNULL(Версии.ПоследнийНомерВерсии, 0) КАК ПоследнийНомерВерсии,
	|	Шапка.ДокументОснование                  КАК ДокументОснование,
	|	Шапка.Организация                        КАК Организация,
	|	Представление(Шапка.Организация)         КАК ОрганизацияПредставление,
	|	Шапка.ВидПродукции                       КАК ВидПродукции,
	|	&Операция                                КАК Операция,
	|	Шапка.Ответственный                      КАК Ответственный,
	|	Представление(Шапка.Ответственный)       КАК ОтветственныйПредставление
	|ИЗ
	|	Документ.ПеремаркировкаТоваровИСМП КАК Шапка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Версии КАК Версии
	|		ПО Шапка.Ссылка = Версии.Ссылка
	|ГДЕ
	|	Шапка.Ссылка = &Ссылка",
	"Шапка");
	
	СписокЗапросов.Добавить(
	"ВЫБРАТЬ
	|	// Универсальные реквизиты
	|	Товары.Номенклатура             КАК Номенклатура,
	|	Товары.Характеристика           КАК Характеристика,
	|	КодМаркировки.ЗначениеШтрихкода КАК Штрихкод,
	|
	|	// Дополнительные реквизиты
	|	Товары.ПричинаПеремаркировки КАК ПричинаПеремаркировки
	|ИЗ
	|	Документ.ПеремаркировкаТоваровИСМП.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка = &Ссылка
	|",
	"Товары");
	
	Операция = Перечисления.ВидыОперацийИСМП.СписаниеВведенныхВОборотКодовМаркировки;
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка",   ДокументСсылка);
	Запрос.УстановитьПараметр("Операция", Операция);
	
	РезультатЗапроса = ИнтеграцияИС.ВыполнитьПакетЗапросов(Запрос, СписокЗапросов);
	
	//@skip-warning
	Шапка  = РезультатЗапроса["Шапка"].Выбрать();
	//@skip-warning
	Товары = РезультатЗапроса["Товары"].Выгрузить();
	
	Если Не Шапка.Следующий()
		Или Товары.Количество() = 0 Тогда
		
		СообщениеJSON = ИнтеграцияИСМПСлужебный.СтруктураСообщенияJSON();
		СообщениеJSON.Организация = Шапка.Организация;
		СообщениеJSON.Документ    = ДокументСсылка;
		СообщениеJSON.Описание = ИнтеграцияИСМПСлужебный.ОписаниеОперацииПередачиДанных(
			Операция, ДокументСсылка);
		СообщениеJSON.ТекстОшибки = НСтр("ru = 'Нет данных для выгрузки.'");
		СообщениеJSON.ТребуетсяПодписание = Ложь;
		СообщенияJSON.Добавить(СообщениеJSON);
		
		Возврат СообщенияJSON;
		
	КонецЕсли;
	
	НомерВерсии = Шапка.ПоследнийНомерВерсии + 1;
	
	Если ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(Шапка.ВидПродукции) Тогда
		
		СообщениеJSON = ИнтеграцияИСМПСлужебный.СтруктураСообщенияJSON();
		СообщениеJSON.Организация       = Шапка.Организация;
		СообщениеJSON.Документ          = ДокументСсылка;
		СообщениеJSON.ДокументОснование = Шапка.ДокументОснование;
		СообщениеJSON.ВидПродукции      = Шапка.ВидПродукции;
		
		СообщениеJSON.Описание = ИнтеграцияИСМПСлужебный.ОписаниеОперацииПередачиДанных(
			Операция, ДокументСсылка, НомерВерсии);
		
		РеквизитыОрганизации = ИнтеграцияИСВызовСервера.ИННКПППоОрганизацииКонтрагенту(Шапка.Организация);
		
		Если Не ЗначениеЗаполнено(РеквизитыОрганизации.ИНН) Тогда
			ИнтеграцияИСКлиентСервер.ДобавитьТекстОшибки(
				СообщениеJSON,
				СтрШаблон(
					НСтр("ru = 'Не заполнено поле ""ИНН"" для организации %1'"), Шапка.Организация));
		КонецЕсли;
		
		ПараметрыНормализацииПрочее = ШтрихкодированиеИССлужебный.ПараметрыНормализацииКодаМаркировки();
		ПараметрыНормализацииПрочее.ИмяСвойстваКодМаркировки = "Штрихкод";
		ПараметрыНормализацииПрочее.НачинаетсяСоСкобки       = Ложь;
	
		ТелоЗапроса = Новый Структура;
		ТелоЗапроса.Вставить("trade_participant_inn",   РеквизитыОрганизации.ИНН);
		ТелоЗапроса.Вставить("cancellation_doc_date",   ИнтеграцияИС.ДатаUTC(Шапка.Дата));
		ТелоЗапроса.Вставить("cancellation_doc_number", Шапка.Номер);
		ТелоЗапроса.Вставить("km_list", Новый Массив);
		
		Для Каждого СтрокаТЧТовары Из Товары Цикл
			
			СтрокаТЧ = Новый Структура;
			РезультатРазбора = ШтрихкодированиеИС.НоваяСтруктураОбработкиШтрихкода(
				СтрокаТЧТовары.Штрихкод, Шапка.ВидПродукции);
			
			СтрокаТЧ.Вставить(
				"uit",
				ШтрихкодированиеИСМП.КодМаркировкиДляПередачиИСМП(РезультатРазбора, ПараметрыНормализацииПрочее));
			СтрокаТЧ.Вставить("cancellation_reason", ИнтерфейсИСМПСлужебный.ПричинаСписанияКодаМаркировкиДляПеремаркировки(СтрокаТЧТовары.ПричинаПеремаркировки));
			
			ТелоЗапроса.km_list.Добавить(СтрокаТЧ);
			
		КонецЦикла;
		
		ТекстСообщенияJSON = ИнтерфейсМОТПСлужебный.ОбъектВТекстJSON(ТелоЗапроса, Истина);
		
		СообщениеJSON.ТекстСообщенияJSON  = ТекстСообщенияJSON;
		СообщениеJSON.ТипСообщения        = Перечисления.ТипыЗапросовИС.Исходящий;
		СообщениеJSON.Версия              = НомерВерсии;
		СообщениеJSON.ТребуетсяПодписание = Истина;
		
		СообщениеJSON.Операция                  = Операция;
		СообщениеJSON.Назначение                = Перечисления.НазначениеСообщенийИСМП.ИСМП;
		СообщениеJSON.СтанцияУправленияЗаказами = Неопределено;
		
		СообщенияJSON.Добавить(СообщениеJSON);
		
	Иначе
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Вид продукции ""%1"" не поддерживается.'"),
			Шапка.ВидПродукции);
	КонецЕсли;
	
	Возврат СообщенияJSON;
	
КонецФункции

#КонецОбласти

#Область ОбработкаКодовМаркировки

Функция ОбработатьДанныеШтрихкода(Форма, ДанныеШтрихкода, ПараметрыСканирования, ВложенныеШтрихкоды = Неопределено) Экспорт
	
	Если ДанныеШтрихкода.ОбработатьБезМаркировки Тогда
		
		Возврат ОбработатьДанныеШтрихкодаБезМарки(Форма, ДанныеШтрихкода, ПараметрыСканирования);
		
	ИначеЕсли ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ДанныеШтрихкода.ТипУпаковки) Тогда
		
		Возврат ОбработатьДанныеШтрихкодаБезМарки(Форма, ДанныеШтрихкода, ПараметрыСканирования);
		
	ИначеЕсли ИнтеграцияИСПовтИсп.ЭтоПродукцияИСМП(ДанныеШтрихкода.ВидПродукции, Истина) Тогда
		
		Возврат ОбработатьДанныеШтрихкодаПотребительскойУпаковки(Форма, ДанныеШтрихкода, ПараметрыСканирования);
		
	КонецЕсли;
	
КонецФункции

Функция ОбработатьДанныеШтрихкодаБезМарки(Форма, ДанныеШтрихкода, ПараметрыСканирования)
	
	РезультатОбработки = ШтрихкодированиеИС.ИнициализироватьРезультатОбработкиШтрихкода(Неопределено, ДанныеШтрихкода);
	РезультатОбработки.ОбработкаШтрихкодаБезМарки = Истина;
	РезультатОбработки.ВидыПродукции = ДанныеШтрихкода.ВидыПродукции;
	РезультатОбработки.Вставить("Номенклатура",       ДанныеШтрихкода.Номенклатура);
	РезультатОбработки.Вставить("Характеристика",     ДанныеШтрихкода.Характеристика);
	РезультатОбработки.Вставить("КодМаркировки",      ДанныеШтрихкода.ШтрихКодУпаковки);
	РезультатОбработки.ИспользоватьОбработкуНаКлиенте = Истина;
	
	Возврат РезультатОбработки;
	
КонецФункции

Функция ОбработатьДанныеШтрихкодаПотребительскойУпаковки(Форма, ДанныеШтрихкода, ПараметрыСканирования)
	
	РезультатОбработки = ШтрихкодированиеИС.ИнициализироватьРезультатОбработкиШтрихкода(Неопределено, ДанныеШтрихкода);
	РезультатОбработки.ВидыПродукции = ДанныеШтрихкода.ВидыПродукцииКодаМаркировки;
	РезультатОбработки.Вставить("Номенклатура",       ДанныеШтрихкода.Номенклатура);
	РезультатОбработки.Вставить("Характеристика",     ДанныеШтрихкода.Характеристика);
	РезультатОбработки.Вставить("КодМаркировки",      ДанныеШтрихкода.ШтрихКодУпаковки);
	Если ДанныеШтрихкода.ЭтоКодВводаОстатков Тогда
		РезультатОбработки.Вставить("МаркировкаОстатков", Истина);
		РезультатОбработки.Вставить("СпособВводаВОборот", Перечисления.СпособыВводаВОборотСУЗ.МаркировкаОстатков);
	Иначе
		РезультатОбработки.Вставить("МаркировкаОстатков", Ложь);
		РезультатОбработки.Вставить("СпособВводаВОборот", ДанныеШтрихкода.СпособВводаВОборот);
	КонецЕсли;
	
	РезультатОбработки.ИспользоватьОбработкуНаКлиенте = Истина;
	
	Возврат РезультатОбработки;
	
КонецФункции

#КонецОбласти

#Область ДляВызоваИзДругихПодсистем

#Область Отчеты

// Заполняет список команд отчетов.
// 
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - состав полей см. в функции МенюОтчеты.СоздатьКоллекциюКомандОтчетов
//   Параметры - Структура - Вспомогательные параметры. См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры.
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	ИнтеграцияИСПереопределяемый.ДобавитьКомандуСтруктураПодчиненности(КомандыОтчетов);
	
	ИнтеграцияИСПереопределяемый.ДобавитьКомандуДвиженияДокумента(КомандыОтчетов);
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Сформировать печатные формы объектов.
//
// ВХОДЯЩИЕ:
//   ИменаМакетов    - Строка    - Имена макетов, перечисленные через запятую.
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать.
//   ПараметрыПечати - Структура - Структура дополнительных параметров печати.
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы.
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

// СтандартныеПодсистемы.ВерсионированиеОбъектов
// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
//
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
	
	Возврат;
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	УправлениеДоступомИСПереопределяемый.ПриЗаполненииОграниченияДоступа(
		Метаданные.Документы.ПеремаркировкаТоваровИСМП, Ограничение);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

#КонецЕсли