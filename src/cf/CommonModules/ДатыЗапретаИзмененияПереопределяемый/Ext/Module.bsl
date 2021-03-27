﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Позволяет изменить работу интерфейса при встраивании.
//
// Параметры:
//  НастройкиРаботыИнтерфейса - Структура - содержит свойство:
//   * ИспользоватьВнешнихПользователей - Булево - начальное значение Ложь,
//     если установить Истина, тогда даты запрета можно будет настраивать для внешних пользователей.
//
Процедура НастройкаИнтерфейса(НастройкиРаботыИнтерфейса) Экспорт
	
	ДатыЗапретаИзмененияУТ.НастройкаИнтерфейса(НастройкиРаботыИнтерфейса);
	ДатыЗапретаИзмененияЛокализация.НастройкаИнтерфейса(НастройкиРаботыИнтерфейса);
	
КонецПроцедуры

// Заполняет разделы дат запрета изменения, используемые при настройке дат запрета.
// Если не указать ни одного раздела, тогда будет доступна только настройка общей даты запрета.
//
// Параметры:
//  Разделы - ТаблицаЗначений - с колонками:
//   * Имя - Строка - имя, используемое в описании источников данных в
//       процедуре ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения.
//
//   * Идентификатор - УникальныйИдентификатор - идентификатор ссылки элемента плана видов характеристик.
//       Чтобы получить идентификатор, нужно в режиме 1С:Предприятие выполнить метод платформы:
//       "ПланыВидовХарактеристик.РазделыДатЗапретаИзменения.ПолучитьСсылку().УникальныйИдентификатор()".
//       Не следует указывать идентификаторы, полученные любым другим способом,
//       так как это может нарушить их уникальность.
//
//   * Представление - Строка - представляет раздел в форме настройки дат запрета.
//
//   * ТипыОбъектов  - Массив - типы ссылок объектов, в разрезе которых можно настроить даты запрета,
//       например Тип("СправочникСсылка.Организации"); если не указано ни одного типа,
//       то даты запрета будут настраиваться только с точностью до раздела.
//
Процедура ПриЗаполненииРазделовДатЗапретаИзменения(Разделы) Экспорт
	
	Раздел = Разделы.Добавить();
	Раздел.Имя  = "АвансовыеОтчеты";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("199db5e2-c45a-4004-9e87-742579e7a749");
	Раздел.Представление = НСтр("ru = 'Авансовые отчеты'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Организации"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "Банк";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("0f558de9-37af-484b-8f46-1ba523cf01d2");
	Раздел.Представление = НСтр("ru = 'Банк'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.БанковскиеСчетаОрганизаций"));


	Раздел = Разделы.Добавить();
	Раздел.Имя  = "ВзаимозачетыСписанияЗадолженности";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("ece392ee-5209-4bfa-9f32-5b1244b1f74e");
	Раздел.Представление = НСтр("ru = 'Взаимозачеты и списания задолженности'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Организации"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "ЗакупкиВозвратыПоставщикамПеремещенияСборки";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("fc4596d4-f365-4986-b633-fe77017b938f");
	Раздел.Представление = НСтр("ru = 'Закупки, возвраты поставщикам, перемещения и сборки'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Организации"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "Касса";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("97e0cfbc-3a80-40d5-bbce-ce9c3e87e7d8");
	Раздел.Представление = НСтр("ru = 'Касса'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Кассы"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "Планирование";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("0c370df6-fb93-499d-bec3-81c4b7dcfcf2");
	Раздел.Представление = НСтр("ru = 'Планирование'");

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "ПродажиВозвратыОтКлиентов";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("f9d6852a-09c2-4505-901e-ac07fa0a73eb");
	Раздел.Представление = НСтр("ru = 'Продажи и возвраты от клиентов'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Организации"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "Производство";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("8795bd29-84ab-47b5-a59f-4fff6b242bab");
	Раздел.Представление = НСтр("ru = 'Производство'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Организации"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "РегламентныеОперации";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("49fca300-0137-4f5e-bc8d-af6cc30545a3");
	Раздел.Представление = НСтр("ru = 'Регламентные операции (интеркампани и закрытие месяца)'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Организации"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "СкладскиеОперации";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("f37d661e-6540-4890-8642-f7481ff1ee7b");
	Раздел.Представление = НСтр("ru = 'Складские операции (на ордерных складах)'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Склады"));

	Раздел = Разделы.Добавить();
	Раздел.Имя  = "СписанияОприходованияТоваров";
	Раздел.Идентификатор = Новый УникальныйИдентификатор("a7c88ae7-129c-45c5-bdcd-df587700fa2d");
	Раздел.Представление = НСтр("ru = 'Списания и оприходования товаров'");
	Раздел.ТипыОбъектов.Добавить(Тип("СправочникСсылка.Организации"));
	
	ДатыЗапретаИзмененияЛокализация.ПриЗаполненииРазделовДатЗапретаИзменения(Разделы);

КонецПроцедуры

// Позволяет задать таблицы и поля объектов для проверки запрета изменения данных.
// Для добавления нового источника в ИсточникиДанных см. ДатыЗапретаИзменения.ДобавитьСтроку.
//
// Вызывается из процедуры ИзменениеЗапрещено общего модуля ДатыЗапретаИзменения,
// используемой в подписке на событие ПередЗаписью объекта для проверки наличия
// запретов и отказа от изменений запрещенного объекта.
//
// Параметры:
//  ИсточникиДанных - ТаблицаЗначений - с колонками:
//   * Таблица     - Строка - полное имя объекта метаданных,
//                   например Метаданные.Документы.ПриходнаяНакладная.ПолноеИмя().
//   * ПолеДаты    - Строка - имя реквизита объекта или табличной части,
//                   например: "Дата", "Товары.ДатаОтгрузки".
//   * Раздел      - Строка - имя раздела дат запрета, указанного в
//                   процедуре ПриЗаполненииРазделовДатЗапретаИзменения (см. выше).
//   * ПолеОбъекта - Строка - имя реквизита объекта или реквизита табличной части,
//                   например: "Организация", "Товары.Склад".
//
Процедура ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения(ИсточникиДанных) Экспорт
	
	ДатыЗапретаИзмененияУТ.ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения(ИсточникиДанных);
	ДатыЗапретаИзмененияЛокализация.ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения(ИсточникиДанных);
	
КонецПроцедуры

// Позволяет переопределить выполнение проверки запрета изменения произвольным образом.
//
// Если проверка выполняется в процессе записи документа, то в свойстве ДополнительныеСвойства документа Объект
// имеется свойство РежимЗаписи.
//  
// Параметры:
//  Объект       - СправочникОбъект,
//                 ДокументОбъект,
//                 ПланВидовХарактеристикОбъект,
//                 ПланСчетовОбъект,
//                 ПланВидовРасчетаОбъект,
//                 БизнесПроцессОбъект,
//                 ЗадачаОбъект,
//                 ПланОбменаОбъект, 
//                 РегистрСведенийНаборЗаписей,
//                 РегистрНакопленияНаборЗаписей,
//                 РегистрБухгалтерииНаборЗаписей,
//                 РегистрРасчетаНаборЗаписей - проверяемый элемент данных или набор записей 
//                 (который передается из обработчиков ПередЗаписью и ПриЧтенииНаСервере).
//
//  ПроверкаЗапретаИзменения    - Булево - установить в Ложь, чтобы пропустить проверку запрета изменения данных.
//  УзелПроверкиЗапретаЗагрузки - ПланыОбменаСсылка, Неопределено - установить в Неопределено, чтобы 
//                                пропустить проверку запрета загрузки данных.
//  ВерсияОбъекта               - Строка - установить "СтараяВерсия" или "НоваяВерсия", чтобы
//                                выполнить проверку только старой (в базе данных) 
//                                или только новой версии объекта (в параметре Объект).
//                                По умолчанию содержит значение "" - проверяются обе версии объекта сразу.
//
Процедура ПередПроверкойЗапретаИзменения(Объект,
                                         ПроверкаЗапретаИзменения,
                                         УзелПроверкиЗапретаЗагрузки,
                                         ВерсияОбъекта) Экспорт
	
	ДатыЗапретаИзмененияУТ.ПередПроверкойЗапретаИзменения(
		Объект,
		ПроверкаЗапретаИзменения,
		УзелПроверкиЗапретаЗагрузки,
		ВерсияОбъекта);
		
	ДатыЗапретаИзмененияЛокализация.ПередПроверкойЗапретаИзменения(
		Объект,
		ПроверкаЗапретаИзменения,
		УзелПроверкиЗапретаЗагрузки,
		ВерсияОбъекта);
	
КонецПроцедуры

// Позволяет переопределить получение данных для проверки даты запрета старой (существующей) версии данных.
//
// Параметры:
//  ОбъектМетаданных - ОбъектМетаданных - объект метаданных получаемых данных.
//  ИдентификаторДанных - СправочникСсылка,
//                        ДокументСсылка,
//                        ПланВидовХарактеристикСсылка,
//                        ПланСчетовСсылка,
//                        ПланВидовРасчетаСсылка,
//                        БизнесПроцессСсылка,
//                        ЗадачаСсылка,
//                        ПланОбменаСсылка,
//                        Отбор        - ссылка на элемент данных или отбор набора записей, который нужно проверить.
//                                       При этом значение для проверки будет получено из базы данных.
//
//  УзелПроверкиЗапретаЗагрузки - Неопределено, ПланыОбменаСсылка - если Неопределено, то проверить запрет 
//                                изменения данных; иначе - загрузку данных из указанного узла плана обмена.
//
//  ДанныеДляПроверки - ТаблицаЗначений - таблица для заполнения правил проверок и последующей передачи в
//                                         функцию НайденЗапретИзмененияДанных общего модуля ДатыЗапретаИзменения.
//                                        см. ДатыЗапретаИзменения.ШаблонДанныхДляПроверки.
//
//  Пример:
//  Если ТипЗнч(ИдентификаторДанных) = Тип("ДокументСсылка.Заказ") Тогда
//  	Данные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ИдентификаторДанных, "Организация, ДатаОкончанияРабот, ЗаказНаряд");
//  	Если Данные.ЗаказНаряд Тогда
//  		Проверка = ДанныеДляПроверки.Добавить();
//  		Проверка.Раздел = "ЗаказНаряды";
//  		Проверка.Объект =  Данные.Организация;
//  		Проверка.Дата   = Данные.ДатаОкончанияРабот;
//  	КонецЕсли;
//  КонецЕсли;
//
Процедура ПередПроверкойСтаройВерсииДанных(ОбъектМетаданных, ИдентификаторДанных, УзелПроверкиЗапретаЗагрузки, ДанныеДляПроверки) Экспорт
	
КонецПроцедуры

// Позволяет переопределить получение данных для проверки даты запрета новой (будущей) версии данных.
//
// Параметры:
//  ОбъектМетаданных - ОбъектМетаданных - объект метаданных получаемых данных.
//  Данные  - СправочникОбъект,
//                        ДокументОбъект,
//                        ПланВидовХарактеристикОбъект,
//                        ПланСчетовОбъект,
//                        ПланВидовРасчетаОбъект,
//                        БизнесПроцессОбъект,
//                        ЗадачаОбъект,
//                        ПланОбменаОбъект,
//                        РегистрСведенийНаборЗаписей,
//                        РегистрНакопленияНаборЗаписей,
//                        РегистрБухгалтерииНаборЗаписей,
//                        РегистрРасчетаНаборЗаписей      - проверяемый элемент данных или набор записей.
//
//  УзелПроверкиЗапретаЗагрузки - Неопределено, ПланыОбменаСсылка - если Неопределено, то проверить запрет 
//                                изменения данных; иначе - загрузку данных из указанного узла плана обмена.
//
//  ДанныеДляПроверки - ТаблицаЗначений - таблица для заполнения правил проверок и последующей передачи в
//                                         функцию НайденЗапретИзмененияДанных общего модуля ДатыЗапретаИзменения.
//                                        см. ДатыЗапретаИзменения.ШаблонДанныхДляПроверки.
//
//  Пример:
//  Если ТипЗнч(Данные) = Тип("ДокументОбъект.Заказ") И Данные.ЗаказНаряд Тогда
//  	
//  	Проверка = ДанныеДляПроверки.Добавить();
//  	Проверка.Раздел = "ЗаказНаряды";
//  	Проверка.Объект =  Данные.Организация;
//  	Проверка.Дата   = Данные.ДатаОкончанияРабот;
//  	
//  КонецЕсли;
//
Процедура ПередПроверкойНовойВерсииДанных(ОбъектМетаданных, Данные, УзелПроверкиЗапретаЗагрузки, ДанныеДляПроверки) Экспорт
	
КонецПроцедуры

#КонецОбласти
