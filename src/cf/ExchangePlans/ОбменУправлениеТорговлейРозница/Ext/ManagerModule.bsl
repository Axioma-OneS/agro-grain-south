﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Заполняет настройки, влияющие на использование плана обмена.
// 
// Параметры:
//  Настройки - Структура - настройки плана обмена по умолчанию, см. ОбменДаннымиСервер.НастройкиПланаОбменаПоУмолчанию,
//                          описание возвращаемого значения функции.
//
Процедура ПриПолученииНастроек(Настройки) Экспорт
	
	Настройки.ПредупреждатьОНесоответствииВерсийПравилОбмена 	= Ложь;
	Настройки.ПланОбменаИспользуетсяВМоделиСервиса			 	= Ложь;
	Настройки.Алгоритмы.ПриПолученииОписанияВариантаНастройки	= Истина;
	
КонецПроцедуры

// Заполняет набор параметров, определяющих вариант настройки обмена.
// 
// Параметры:
//  ОписаниеВарианта       - Структура - набор варианта настройки по умолчанию,
//                                       см. ОбменДаннымиСервер.ОписаниеВариантаНастройкиОбменаПоУмолчанию,
//                                       описание возвращаемого значения.
//  ИдентификаторНастройки - Строка    - идентификатор варианта настройки обмена.
//  ПараметрыКонтекста     - Структура - см. ОбменДаннымиСервер.ПараметрыКонтекстаПолученияОписанияВариантаНастройки,
//                                       описание возвращаемого значения функции.
//
Процедура ПриПолученииОписанияВариантаНастройки(ОписаниеВарианта, ИдентификаторНастройки, ПараметрыКонтекста) Экспорт
	
	ОписаниеВарианта.ПутьКФайлуКомплектаПравилНаПользовательскомСайте = "https://users.v8.1c.ru/distribution/project/Retail22";
	ОписаниеВарианта.ПутьКФайлуКомплектаПравилВКаталогеШаблонов = "\1c\Retail";
	
	ОписаниеВарианта.ИмяФайлаНастроекДляПриемника 				= "Настройки обмена УТ11.4-РТ2.2";
	ОписаниеВарианта.ИспользоватьПомощникСозданияОбменаДанными	= Истина;
	ОписаниеВарианта.ИспользуемыеТранспортыСообщенийОбмена		= ИспользуемыеТранспортыСообщенийОбмена();
	ОписаниеВарианта.КраткаяИнформацияПоОбмену					= КраткаяИнформацияПоОбмену();
	ОписаниеВарианта.ПодробнаяИнформацияПоОбмену				= "ПланОбмена.ОбменУправлениеТорговлейРозница.Форма.ПодробнаяИнформация";
	ОписаниеВарианта.НаименованиеКонфигурацииКорреспондента 	= НСтр("ru = 'Розница, ред. 2.2'");
	ОписаниеВарианта.ИмяКонфигурацииКорреспондента 				= "Розница";

КонецПроцедуры

#Область ПроцедурыИФункцииБсп

// Определяет несколько вариантов настройки расписания выполнения обмена данными;
// Рекомендуется указывать не более 3 вариантов;
// Эти варианты должны быть одинаковым в плане обмена источника и приемника.
// 
// Параметры:
//  Нет.
// 
// Возвращаемое значение:
//  ВариантыНастройки - СписокЗначений - список расписаний обмена данными
//
Функция ВариантыНастройкиРасписания() Экспорт
	
	Месяцы = Новый Массив;
	Месяцы.Добавить(1);
	Месяцы.Добавить(2);
	Месяцы.Добавить(3);
	Месяцы.Добавить(4);
	Месяцы.Добавить(5);
	Месяцы.Добавить(6);
	Месяцы.Добавить(7);
	Месяцы.Добавить(8);
	Месяцы.Добавить(9);
	Месяцы.Добавить(10);
	Месяцы.Добавить(11);
	Месяцы.Добавить(12);
	
	// Расписание №1
	ДниНедели = Новый Массив;
	ДниНедели.Добавить(1);
	ДниНедели.Добавить(2);
	ДниНедели.Добавить(3);
	ДниНедели.Добавить(4);
	ДниНедели.Добавить(5);
	
	Расписание1 = Новый РасписаниеРегламентногоЗадания;
	Расписание1.ДниНедели                = ДниНедели;
	Расписание1.ПериодПовтораВТечениеДня = 900; // 15 минут
	Расписание1.ПериодПовтораДней        = 1; // каждый день
	Расписание1.Месяцы                   = Месяцы;
	
	// Расписание №2
	ДниНедели = Новый Массив;
	ДниНедели.Добавить(1);
	ДниНедели.Добавить(2);
	ДниНедели.Добавить(3);
	ДниНедели.Добавить(4);
	ДниНедели.Добавить(5);
	ДниНедели.Добавить(6);
	ДниНедели.Добавить(7);
	
	Расписание2 = Новый РасписаниеРегламентногоЗадания;
	Расписание2.ВремяНачала              = Дата('00010101080000');
	Расписание2.ВремяКонца               = Дата('00010101200000');
	Расписание2.ПериодПовтораВТечениеДня = 3600; // каждый час
	Расписание2.ПериодПовтораДней        = 1; // каждый день
	Расписание2.ДниНедели                = ДниНедели;
	Расписание2.Месяцы                   = Месяцы;
	
	// Расписание №3
	ДниНедели = Новый Массив;
	ДниНедели.Добавить(2);
	ДниНедели.Добавить(3);
	ДниНедели.Добавить(4);
	ДниНедели.Добавить(5);
	ДниНедели.Добавить(6);
	
	Расписание3 = Новый РасписаниеРегламентногоЗадания;
	Расписание3.ДниНедели         = ДниНедели;
	Расписание3.ВремяНачала       = Дата('00010101020000');
	Расписание3.ПериодПовтораДней = 1; // каждый день
	Расписание3.Месяцы            = Месяцы;
	
	// возвращаемое значение функции
	ВариантыНастройки = Новый СписокЗначений;
	
	ВариантыНастройки.Добавить(Расписание1, "Один раз в 15 минут, кроме субботы и воскресенья");
	ВариантыНастройки.Добавить(Расписание2, "Каждый час с 8:00 до 20:00, ежедневно");
	ВариантыНастройки.Добавить(Расписание3, "Каждую ночь в 2:00, кроме субботы и воскресенья");
	
	Возврат ВариантыНастройки;
КонецФункции

// Возвращает массив используемых транспортов сообщений для этого плана обмена
//
// 1. Например, если план обмена поддерживает только два транспорта сообщений FILE и FTP,
// то тело функции следует определить следующим образом:
//
//	Результат = Новый Массив;
//	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.FILE);
//	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.FTP);
//	Возврат Результат;
//
// 2. Например, если план обмена поддерживает все транспорты сообщений, определенных в конфигурации,
// то тело функции следует определить следующим образом:
//
//	Возврат ОбменДаннымиСервер.ВсеТранспортыСообщенийОбменаКонфигурации();
//
// Возвращаемое значение:
//  Массив - массив содержит значения перечисления ВидыТранспортаСообщенийОбмена
//
Функция ИспользуемыеТранспортыСообщенийОбмена()
	
	Результат = Новый Массив;
	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.FILE);
	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.FTP);
	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.EMAIL);
	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.COM);
	
	Возврат Результат;
	
КонецФункции

// Возвращает краткую информацию по обмену, выводимую при настройке синхронизации данных.
//
Функция КраткаяИнформацияПоОбмену()
	
	ПоясняющийТекст = НСтр("ru = 'Позволяет синхронизировать данные между конфигурацией Розница ред. 2 и Управление Торговлей ред. 11. 
	|В синхронизации участвуют следующие типы данных: справочники (например, Организации), документы (например, 
	|Реализация товаров), регистры сведений (например, Фамилия, имя, отчество физического лица), план видов характеристик Дополнительные реквизиты и сведения.
	|
	|Синхронизация является двухсторонней и позволяет иметь актуальные данные в каждой из информационных баз.'");

	Возврат ПоясняющийТекст;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли