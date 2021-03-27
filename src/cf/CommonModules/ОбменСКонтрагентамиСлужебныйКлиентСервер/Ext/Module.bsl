﻿////////////////////////////////////////////////////////////////////////////////
// ЭлектронноеВзаимодействиеКлиентСервер: общий механизм обмена электронными документами.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область СопоставлениеНоменклатуры

// См. ОбменСКонтрагентамиКлиентСервер.НоваяНоменклатураИнформационнойБазы.
Функция НоваяНоменклатураИнформационнойБазы(Знач Номенклатура = Неопределено, Знач Характеристика = Неопределено, Знач Упаковка = Неопределено) Экспорт
	
	НоменклатураИБ = Новый Структура;
	НоменклатураИБ.Вставить("Номенклатура"  , Номенклатура);
	НоменклатураИБ.Вставить("Характеристика", Характеристика);
	НоменклатураИБ.Вставить("Упаковка"      , Упаковка);
	
	Возврат НоменклатураИБ;
	
КонецФункции

// См. ОбменСКонтрагентамиКлиентСервер.НоваяНоменклатураКонтрагента.
Функция НоваяНоменклатураКонтрагента(Знач Владелец = Неопределено, Знач Идентификатор = Неопределено) Экспорт
	
	НоменклатураКонтрагента = Новый Структура;
	НоменклатураКонтрагента.Вставить("Владелец"           , Владелец);
	НоменклатураКонтрагента.Вставить("Идентификатор"      , ?(ЗначениеЗаполнено(Идентификатор), Идентификатор, ""));
	НоменклатураКонтрагента.Вставить("Наименование"       , "");
	НоменклатураКонтрагента.Вставить("Характеристика"     , "");
	НоменклатураКонтрагента.Вставить("ЕдиницаИзмерения"   , "");
	НоменклатураКонтрагента.Вставить("ЕдиницаИзмеренияКод", "");
	НоменклатураКонтрагента.Вставить("Артикул"            , "");
	НоменклатураКонтрагента.Вставить("СтавкаНДС"          , "");
	НоменклатураКонтрагента.Вставить("ШтрихкодКомбинации"                , "");
	НоменклатураКонтрагента.Вставить("ШтрихкодыНоменклатуры"             , "");
	НоменклатураКонтрагента.Вставить("ИдентификаторНоменклатурыСервиса"  , "");
	НоменклатураКонтрагента.Вставить("ИдентификаторХарактеристикиСервиса", "");
	НоменклатураКонтрагента.Вставить("ИдентификаторНоменклатуры"         , "");
	НоменклатураКонтрагента.Вставить("ИдентификаторХарактеристики"       , "");
	НоменклатураКонтрагента.Вставить("ИдентификаторУпаковки"             , "");
	НоменклатураКонтрагента.Вставить("ИсторияИдентификаторов", Новый Массив);
	
	Возврат НоменклатураКонтрагента;
	
КонецФункции

// Разделяет идентификатор на части по разделителю #.
//
// Параметры:
//  Идентификатор           - Строка    - идентификатор, который необходимо разбить на части по разделителю #.
//  НоменклатураКонтрагента - Структура - содержит:
//    *ИдентификаторНоменклатуры   - Строка - идентификатор номенклатуры.
//    *ИдентификаторХарактеристики - Строка - идентификатор характеристики.
//    *ИдентификаторУпаковки       - Строка - идентификатор упаковки.
//
Процедура РазделитьИдентификаторНаЧасти(Идентификатор, НоменклатураКонтрагента) Экспорт
	
	ЧастиИдентификаторов = СтрРазделить(Идентификатор, "#", Истина);
	ВсегоЧастей = ЧастиИдентификаторов.Количество();
	
	Если ВсегоЧастей = 3 Тогда
		НоменклатураКонтрагента.ИдентификаторНоменклатуры   = ЧастиИдентификаторов[0];
		НоменклатураКонтрагента.ИдентификаторХарактеристики = ЧастиИдентификаторов[1];
		НоменклатураКонтрагента.ИдентификаторУпаковки       = ЧастиИдентификаторов[2];
	ИначеЕсли ВсегоЧастей > 3 Тогда
		НоменклатураКонтрагента.ИдентификаторНоменклатуры   = ЧастиИдентификаторов[0];
		НоменклатураКонтрагента.ИдентификаторХарактеристики = ЧастиИдентификаторов[1];
		
		ДлинаИдентификатора = СтрДлина(Идентификатор);
		ДлинаЧастиИдентификатора = СтрДлина(ЧастиИдентификаторов[0] + "#" + ЧастиИдентификаторов[1] + "#");
		
		ПоследняяЧастьИдентификатора = Сред(Идентификатор, ДлинаЧастиИдентификатора + 1, ДлинаИдентификатора);
		
		НоменклатураКонтрагента.ИдентификаторУпаковки       = ПоследняяЧастьИдентификатора;
	Иначе
		НоменклатураКонтрагента.ИдентификаторНоменклатуры   = Идентификатор;
		НоменклатураКонтрагента.ИдентификаторХарактеристики = Идентификатор;
		НоменклатураКонтрагента.ИдентификаторУпаковки       = Идентификатор;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбщегоНазначения

Процедура УстановитьСвойствоСтруктуры(Структура, Знач ИерархияСвойств, Знач Значение) Экспорт
	
	Если ТипЗнч(ИерархияСвойств) = Тип("Строка") Тогда
		ИерархияСвойств = СтрРазделить(ИерархияСвойств, ".");
	КонецЕсли;
	
	ТекущееСвойство = ИерархияСвойств[0];
	
	Если ИерархияСвойств.Количество() = 1 Тогда
		
		Структура.Вставить(ТекущееСвойство, Значение);
		
	Иначе
		
		ТекущееЗначение = Неопределено;
		Если Не Структура.Свойство(ТекущееСвойство, ТекущееЗначение) Тогда
			ТекущееЗначение = Новый Структура;
		КонецЕсли;
		ИерархияСвойств.Удалить(0);
		УстановитьСвойствоСтруктуры(ТекущееЗначение, ИерархияСвойств, Значение);
		Структура.Вставить(ТекущееСвойство, ТекущееЗначение);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область НастройкиФормированияДокумента

Функция ТипРазделаДополнительныхПолейШапка() Экспорт
	Возврат "Шапка";
КонецФункции

Функция ТипРазделаДополнительныхПолейТаблица() Экспорт
	Возврат "Таблица";
КонецФункции

#КонецОбласти

#Область РаботаСУчетнымиЗаписямиЭДО

Функция НовыйДанныеЗаполненияУчетнойЗаписиЭДО() Экспорт
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("Организация"                                  , Неопределено);
	ДанныеЗаполнения.Вставить("НаименованиеУчетнойЗаписи"                    , Неопределено);
	ДанныеЗаполнения.Вставить("ВерсияКонфигурации"                           , Неопределено);
	ДанныеЗаполнения.Вставить("ОператорЭДО"                                  , Неопределено);
	ДанныеЗаполнения.Вставить("СпособОбменаЭД"                               , Неопределено);
	ДанныеЗаполнения.Вставить("ЭлектроннаяПочтаДляУведомлений"               , Неопределено);
	ДанныеЗаполнения.Вставить("ОжидатьИзвещениеОПолучении"                   , Ложь);
	ДанныеЗаполнения.Вставить("УведомлятьОНовыхПриглашениях"                 , Ложь);
	ДанныеЗаполнения.Вставить("УведомлятьОбОтветахНаПриглашения"             , Ложь);
	ДанныеЗаполнения.Вставить("УведомлятьОНовыхДокументах"                   , Ложь);
	ДанныеЗаполнения.Вставить("УведомлятьОНеОбработанныхДокументах"          , Ложь);
	ДанныеЗаполнения.Вставить("УведомлятьОбОкончанииСрокаДействияСертификата", Ложь);
	ДанныеЗаполнения.Вставить("КодНалоговогоОргана"                          , Неопределено);
	ДанныеЗаполнения.Вставить("ДатаПолученияЭД"                              , Неопределено);
	ДанныеЗаполнения.Вставить("ДатаПоследнегоПолученияПриглашений"           , Неопределено);
	ДанныеЗаполнения.Вставить("НазначениеУчетнойЗаписи"                      , Неопределено);
	ДанныеЗаполнения.Вставить("ПодробноеОписаниеУчетнойЗаписи"               , Неопределено);
	ДанныеЗаполнения.Вставить("ИдентификаторЭДО"                             , Неопределено);
	ДанныеЗаполнения.Вставить("АдресОрганизации"                             , Неопределено);
	ДанныеЗаполнения.Вставить("ПринятыУсловияИспользования"                  , Ложь);
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

Функция ИдентификаторУчастникаЭДОКорректный(ИдентификаторЭДО) Экспорт
	
	ДлинаИдентификатора = СтрДлина(ИдентификаторЭДО);
	Если ДлинаИдентификатора < 4 ИЛИ ДлинаИдентификатора > 46 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Индекс = 1 По ДлинаИдентификатора Цикл
		КодСимвола = КодСимвола(Сред(ИдентификаторЭДО, Индекс, 1));
		Если    (КодСимвола < 48 И КодСимвола <> 45 И КодСимвола <> 46)
			Или (КодСимвола > 57 И КодСимвола < 65)
			Или (КодСимвола > 90 И КодСимвола < 97)
			Или КодСимвола > 122 Тогда
			
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#Область РаботаСОперациямиЭДО

// Возвращает описание операции подключения ЭДО.
//
// Параметры:
//  Параметры - Структура,Неопределено - см. ОбменСКонтрагентамиСлужебныйКлиентСервер.НовыеПараметрыПодключенияЭДО. 
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - описание операции ЭДО. См. ОбменСКонтрагентамиСлужебныйКлиентСервер.НоваяОперацияЭДО.
//
Функция НоваяОперацияПодключенияЭДО(Знач Параметры = Неопределено) Экспорт
	
	НовыеПараметры = НовыеПараметрыПодключенияЭДО();
	Если ТипЗнч(Параметры) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(НовыеПараметры, Параметры);
	КонецЕсли;
	
	НовыеСлужебныеПараметры = НовыеСлужебныеПараметрыПодключенияЭДО();
	
	Результат = Новый Структура;
	Результат.Вставить("НомерЗаявки"                   , "");
	Результат.Вставить("ИдентификаторЭДО"              , "");
	Результат.Вставить("УчетнаяЗапись"                 , "");
	Результат.Вставить("ОбновленыПараметрыУведомлений" , Ложь);
	Результат.Вставить("ОбновленыДанныеАбонента"       , Ложь);
	
	Операция = НоваяОперацияЭДО("ПодключениеЭДО", НовыеПараметры, Результат, НовыеСлужебныеПараметры);
	
	Возврат Операция;
	
КонецФункции

// Возвращает структуру для определения параметров подключения ЭДО.
//
// Параметры:
//
// Возвращаемое значение:
//  Структура - параметры операции подключения ЭДО:
//   * Организация - ОпределяемыйТип.Организация - организация, которую следует подключить к ЭДО.
//   * АдресОрганизации - Строка - адрес организации.
//   * КодНалоговогоОргана - Строка - код налоговой инспекции, в которой зарегистрирована организация.
//   * Сертификат - СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования - сертификат для регистрации у оператора ЭДО.
//   * ОператорЭДО - Строка - код оператора ЭДО.
//   * СпособОбменаЭД - ПеречислениеСсылка.СпособыОбменаЭД - способ обмена электронными документам.
//   * НаименованиеУчетнойЗаписи - Строка - наименование учетной записи.
//   * НазначениеУчетнойЗаписи - Строка - назначение учетной записи.
//   * ОписаниеУчетнойЗаписи - Строка - описание учетной записи.
//   * ПринятыУсловияИспользования - Булево - признак принятия условий использования сервиса.
//   * УведомлятьОСобытиях - Булево - признак необходимости отправки уведомлений на электронную почту.
//   * ЭлектроннаяПочтаДляУведомлений - Строка - электронная почта для уведомлений.
//   * УведомлятьОНовыхПриглашениях - Булево - признак необходимости отправки уведомлений о новых приглашениях.
//   * УведомлятьОбОтветахНаПриглашения - Булево - признак необходимости отправки уведомлений об ответах на приглашения.
//   * УведомлятьОНовыхДокументах - Булево - признак необходимости отправки уведомлений о новых документах.
//   * УведомлятьОНеОбработанныхДокументах - Булево - признак необходимости отправки уведомлений о не обработанных документах.
//   * УведомлятьОбОкончанииСрокаДействияСертификата - Булево - признак необходимости отправки уведомлений об окончании действия сертификата.
//
Функция НовыеПараметрыПодключенияЭДО() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Организация");
	Параметры.Вставить("АдресОрганизации", "");
	Параметры.Вставить("АдресОрганизацииЗначение", "");
	Параметры.Вставить("КодНалоговогоОргана", "");
	Параметры.Вставить("Сертификат");
	Параметры.Вставить("ОператорЭДО", "");
	Параметры.Вставить("СпособОбменаЭД");
	Параметры.Вставить("НаименованиеУчетнойЗаписи", "");
	Параметры.Вставить("НазначениеУчетнойЗаписи", "");
	Параметры.Вставить("ОписаниеУчетнойЗаписи", "");
	Параметры.Вставить("ПринятыУсловияИспользования", Ложь);
	Параметры.Вставить("УведомлятьОСобытиях", Ложь);
	Параметры.Вставить("ЭлектроннаяПочтаДляУведомлений", "");
	Параметры.Вставить("УведомлятьОНовыхПриглашениях", Ложь);
	Параметры.Вставить("УведомлятьОбОтветахНаПриглашения", Ложь);
	Параметры.Вставить("УведомлятьОНовыхДокументах", Ложь);
	Параметры.Вставить("УведомлятьОНеОбработанныхДокументах", Ложь);
	Параметры.Вставить("УведомлятьОбОкончанииСрокаДействияСертификата", Ложь);
	
	Возврат Параметры;
	
КонецФункции

// Возвращает описание операции обновления сертификата.
//
// Параметры:
//  Параметры - Структура,Неопределено - см. ОбменСКонтрагентамиСлужебныйКлиентСервер.НовыеПараметрыОбновленияСертификата. 
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - описание операции ЭДО. См. ОбменСКонтрагентамиСлужебныйКлиентСервер.НоваяОперацияЭДО.
//
Функция НоваяОперацияОбновленияСертификата(Знач Параметры = Неопределено) Экспорт
	
	НовыеПараметры = НовыеПараметрыОбновленияСертификата();
	Если ТипЗнч(Параметры) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(НовыеПараметры, Параметры);
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("НовыйСертификат");
	
	Операция = НоваяОперацияЭДО("ОбновлениеСертификата", НовыеПараметры, Результат);
	
	Возврат Операция;
	
КонецФункции

// Возвращает структуру для определения параметров обновления сертификата.
//
// Параметры:
//
// Возвращаемое значение:
//  Структура - параметры операции подключения ЭДО:
//   * Организация - ОпределяемыйТип.Организация - организация, для которой выполняется обновление сертификата.
//   * Сертификат - СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования - сертификат, который будет обновлен (заменен).
//   * НовыйСертификат - СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования - сертификат, который будет добавлен в учетные записи ЭДО.
//
Функция НовыеПараметрыОбновленияСертификата() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Организация");
	Параметры.Вставить("Сертификат");
	Параметры.Вставить("НовыйСертификат");
	
	Возврат Параметры;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает сертификат подписавшей стороны из коллекции сертификатов, извлеченной из данных подписи. 
// Поиск происходит с учетом того, что CN Субъекта и Издателя могут быть равны.
//
// Параметры:
//  СертификатыПодписи - Массив - Сертификаты, извлеченные из данных подписи, см. метод платформы ПолучитьСертификатыИзПодписи.
// 
// Возвращаемое значение:
// СертификатКриптографии, Неопределено - Сертификат, с помощью которого была произведена подпись.
//
Функция СертификатПодписавшейСтороны(Знач СертификатыПодписи) Экспорт
	
	Возврат НайтиСертификатПодписавшейСтороныРекурсивно(СертификатыПодписи);
	
КонецФункции

Функция НайтиСертификатПодписавшейСтороныРекурсивно(СертификатыПодписи) 
	
	КоличествоСертификатовПодписи = СертификатыПодписи.Количество();
	Если КоличествоСертификатовПодписи = 1 Тогда
		Возврат СертификатыПодписи[0];
	ИначеЕсли КоличествоСертификатовПодписи = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Пока СертификатыПодписи.Количество() Цикл
		ТекущийСертификат = СертификатыПодписи[0];
		ДочернийСертификат = ДочернийСертификат(СертификатыПодписи, ТекущийСертификат.Субъект.CN);
		Если ДочернийСертификат = Неопределено Тогда
			Возврат ТекущийСертификат;
		Иначе 
			СертификатыПодписи.Удалить(0);
			Возврат НайтиСертификатПодписавшейСтороныРекурсивно(СертификатыПодписи);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции 

Функция ДочернийСертификат(МассивСертификатов, Субъект) 
	
	Для каждого Сертификат Из МассивСертификатов Цикл
		Если Сертификат.Издатель.CN = Субъект Тогда
			Возврат Сертификат; 
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

Функция ТекстСообщенияВидЭДНеПоддерживается(ВидЭД, ДетализацияОперации = "") Экспорт
	
	Если ДетализацияОперации <> "" Тогда
		ДетализацияОперации = Символы.ПС + ДетализацияОперации;
	КонецЕсли;
	
	ШаблонСообщения = НСтр("ru = 'Вид электронного документа ""%1"" не поддерживается в текущей версии программы.%2'");
	Возврат СтрШаблон(ШаблонСообщения, ВидЭД, ДетализацияОперации);
	
КонецФункции

Функция ПодсказкаЭлектроннаяПочтаДляУведомленияОСтатусеЗаявкиНаРоуминг() Экспорт
	
	Возврат НСтр("ru = 'На данный адрес электронной почты будут отправляться оповещения о статусе выполнения заявки по настройке роуминга'");
	
КонецФункции

#Область РаботаСОперациямиЭДО

// Возвращает новую операцию ЭДО.
//
// Параметры:
//  Действие           - Строка - действие выполняемое операцией.
//  Параметры          - Произвольный - параметры операции. См. НовыеПараметрыПодключенияЭДО
//  Результат          - Произвольный - результат выполнения операции.
//  СлужебныеПараметры - Произвольный - служебные параметры операции.См. НовыеСлужебныеПараметрыПодключенияЭДО
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - описание операции ЭДО:
//   * Действие           - Строка - действие выполняемое операцией.
//   * Параметры          - Произвольный - параметры операции.
//   * Результат          - Произвольный - результат выполнения операции.
//   * СлужебныеПараметры - Произвольный - служебные параметры операции.
//
Функция НоваяОперацияЭДО(Знач Действие, Знач Параметры = Неопределено, Знач Результат = Неопределено,
		Знач СлужебныеПараметры = Неопределено)
	
	Операция = Новый Структура;
	Операция.Вставить("Действие"           , Действие);
	Операция.Вставить("Параметры"          , Параметры);
	Операция.Вставить("Результат"          , Результат);
	Операция.Вставить("СлужебныеПараметры" , СлужебныеПараметры);
	
	Возврат Новый ФиксированнаяСтруктура(Операция);
	
КонецФункции

// Возвращает структуру для определения служебных параметров при подключении ЭДО.
//
// Параметры:
//
// Возвращаемое значение:
//  Структура - параметры операции подключения ЭДО:
//   * КонтекстОперации                 - Строка - контекст ошибки во время подключения.
//   * ОткрыватьФормуДлительнойОперации - Булево - признак открытия формы "Обработка.ОбменСКонтрагентами.Форма.ДлительнаяОперация".
//
Функция НовыеСлужебныеПараметрыПодключенияЭДО()
	
	Параметры = Новый Структура;
	Параметры.Вставить("КонтекстОперации"                 , "");
	Параметры.Вставить("ОткрыватьФормуДлительнойОперации" , Истина);
	
	Возврат Параметры;
	
КонецФункции

#КонецОбласти

#КонецОбласти
