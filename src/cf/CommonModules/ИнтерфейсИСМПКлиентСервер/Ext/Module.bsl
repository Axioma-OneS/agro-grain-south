﻿#Область ПрограммныйИнтерфейс

// Инициализировать структуру параметров запроса в ИС МОТП (ИС МП) для получения ключа сессии.
// 
// Параметры:
// 	Организация - ОпределяемыйТип.Организация - Организация.
// Возвращаемое значение:
// 	(См. ИнтерфейсАвторизацииИСМПКлиентСервер.ПараметрыЗапросаКлючаСессии).
Функция ПараметрыЗапросаКлючаСессии(Организация = Неопределено) Экспорт
	
	ПараметрыОтправкиHTTPЗапросов = ПараметрыОтправкиHTTPЗапросов(Неопределено, Истина);
	
	ПараметрыЗапроса = ИнтерфейсАвторизацииИСМПКлиентСервер.ПараметрыЗапросаКлючаСессии();
	ПараметрыЗапроса.Организация = Организация;
	
	ПараметрыЗапроса.ПредставлениеСервиса             = ПараметрыОтправкиHTTPЗапросов.ПредставлениеСервиса;
	ПараметрыЗапроса.Сервер                           = ПараметрыОтправкиHTTPЗапросов.Сервер;
	ПараметрыЗапроса.Порт                             = ПараметрыОтправкиHTTPЗапросов.Порт;
	ПараметрыЗапроса.Таймаут                          = ПараметрыОтправкиHTTPЗапросов.Таймаут;
	ПараметрыЗапроса.ИспользоватьЗащищенноеСоединение = ПараметрыОтправкиHTTPЗапросов.ИспользоватьЗащищенноеСоединение;
	
	ПараметрыЗапроса.ИмяПараметраСеанса                = "ДанныеКлючаСессииИСМП";
	ПараметрыЗапроса.АдресЗапросаПараметровАвторизации = "api/v3/auth/cert/key";
	ПараметрыЗапроса.АдресЗапросаКлючаСессии           = "api/v3/auth/cert/";
	
	Возврат ПараметрыЗапроса;
	
КонецФункции

// Возвращает адрес сервера ИС МП.
//
// Параметры:
//   ВидПродукции - ПеречислениеСсылка.ВидыПродукцииИС - Вид продукции (В тестовом контуре адреса серверов
//                                                       могут отличаться для различных видов продукции).
//
// Возвращаемое значение:
//  Строка - адрес сервера ИС МП.
//
Функция АдресСервера(ВидПродукции = Неопределено, Авторизация = Ложь) Экспорт
	
	Возврат "ismp.crpt.ru";
	
КонецФункции

// Возвращает параметры для отправки HTTP запросов ИС МП.
//
// Параметры:
//   ВидПродукции - ПеречислениеСсылка.ВидыПродукцииИС - Вид продукции (В тестовом контуре адреса серверов
//                                                       могут отличаться для различных видов продукции).
//   Авторизация - Булево - Признак получения параметров для авторизации.
//
// Возвращаемое значение:
//  Структура - Описание:
//   * ИспользоватьЗащищенноеСоединение - Булево - Признак использования SSL.
//   * Таймаут - Число - Таймаут соединения.
//   * Порт - Число - Порт соединения.
//   * Сервер - Строка - Адрес сервера.
//   * ПредставлениеСервиса - Строка - Представления сервиса.
//
Функция ПараметрыОтправкиHTTPЗапросов(ВидПродукции = Неопределено, Авторизация = Ложь) Экспорт
	
	ПараметрыОтправкиHTTPЗапросов = Новый Структура;
	ПараметрыОтправкиHTTPЗапросов.Вставить("ПредставлениеСервиса",             НСтр("ru = 'ИС МП'"));
	ПараметрыОтправкиHTTPЗапросов.Вставить("Сервер",                           АдресСервера(ВидПродукции, Авторизация));
	ПараметрыОтправкиHTTPЗапросов.Вставить("Порт",                             443);
	ПараметрыОтправкиHTTPЗапросов.Вставить("Таймаут",                          60);
	ПараметрыОтправкиHTTPЗапросов.Вставить("ИспользоватьЗащищенноеСоединение", Истина);
	
	Возврат ПараметрыОтправкиHTTPЗапросов;
	
КонецФункции

#КонецОбласти