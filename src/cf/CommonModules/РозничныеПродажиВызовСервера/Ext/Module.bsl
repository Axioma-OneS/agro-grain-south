﻿
#Область ПрограммныйИнтерфейс

// Открывает кассовую смену для кассы ККМ.
//
// Параметры:
//  КассаККМ - СправочникСсылка.КассыККМ - Касса ККМ.
//  ОписаниеОшибки - Строка - Описание ошибки.
//
// Возвращаемое значение:
//  Булево - Истина, Если операция выполнена успешно.
//
Функция ОткрытьКассовуюСмену(КассаККМ, ОписаниеОшибки = "") Экспорт
	
	Возврат РозничныеПродажи.ОткрытьКассовуюСмену(КассаККМ, ОписаниеОшибки);
	
КонецФункции

// Закрывает кассовую смену для кассы ККМ.
//
// Параметры:
//  Объект - СправочникСсылка.КассыККМ, СправочникСсылка.ПодключаемоеОборудование - Касса ККМ.
//  ОшибкаПриСнятииZОтчета - Булево - Признак успешного снятия z-отчета.
//  ОписаниеОшибки - Строка - Выходной параметр - описание ошибки.
//
// Возвращаемое значение:
//  Массив - Массив созданных отчетов о розничных продажах.
//
Функция ЗакрытьКассовуюСмену(Объект, ОшибкаПриСнятииZОтчета, ОписаниеОшибки = "") Экспорт
	
	Возврат РозничныеПродажи.ВыполнитьОперациюЗакрытияКассовойСмены(Объект, ОшибкаПриСнятииZОтчета, ОписаниеОшибки);
	
КонецФункции

// Создать документ внесение денежных средств в кассу ККМ.
//
// Параметры:
//  ВходныеДанные - Структура - Реквизиты документа.
//  СсылкаНаДокументВнесение - Неопределено, ДокументСсылка.ВнесениеДенежныхСредсвВКассуККМ - Необязательный, ссылка на созданный документ, в случае неудачи - Неопределено.
//  ОписаниеОшибки - Строка - Необязательный, Описание ошибки.
// 
// Возвращаемое значение:
//   Булево - Истина, если создание документа выполнено успешно.
//
Функция СоздатьДокументВнесениеДенежныхСредствВКассуККМ(ВходныеДанные, СсылкаНаДокументВнесение = Неопределено, ОписаниеОшибки = Неопределено) Экспорт
	
	Результат = Истина;
	
	Попытка
		
		СсылкаНаДокументВнесение = РозничныеПродажи.СоздатьДокументВнесениеДенежныхСредствВКассуККМ(ВходныеДанные);
		
	Исключение
		
		Результат = Ложь;
		СсылкаНаДокументВнесение = Неопределено;
		ОписаниеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Розничные продажи'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
		                         УровеньЖурналаРегистрации.Ошибка, , ,
		                         НСтр("ru = 'Во время создания документа внесения денежных средств в кассу ККМ произошла ошибка.'")
		                         + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Создать документ выемка денежных средств из кассы ККМ.
//
// Параметры:
//  ВходныеДанные - Структура - Структура с реквизитами документа.
//  СсылкаНаДокументВыемка - Неопределено, ДокументСсылка.ВыемкаДенежныхСредсвИзКассыККМ - Необязательный, ссылка на созданный документ, в случае неудачи - Неопределено.
//  ОписаниеОшибки - Строка - Необязательный, Описание ошибки.
// 
// Возвращаемое значение:
//   Булево - Истина, если создание документа выполнено успешно.
//
Функция СоздатьДокументВыемкаДенежныхСредствИзКассыККМ(ВходныеДанные, СсылкаНаДокументВыемка = Неопределено, ОписаниеОшибки = Неопределено) Экспорт
	
	Результат = Истина;
	
	Попытка
		
		СсылкаНаДокументВыемка = РозничныеПродажи.СоздатьДокументВыемкаДенежныхСредствИзКассыККМ(ВходныеДанные);
		
	Исключение
		
		Результат = Ложь;
		СсылкаНаДокументВыемка = Неопределено;
		ОписаниеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Розничные продажи'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
		                         УровеньЖурналаРегистрации.Ошибка, , ,
		                         НСтр("ru = 'Во время создания документа выемки денежных средств из кассы ККМ произошла ошибка.'")
		                         + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Получает структуру описания кассовой смены для кассы ККМ.
//
// Параметры:
//  КассаККМ - СправочникСсылка.КассыККМ - Касса ККМ.
//
// Возвращаемое значение:
//  Структура - Структура описания кассовой смены, см. функцию РозничныеПродажи.ПолучитьСтруктуруОписанияКассовойСмены().
//
Функция СостояниеКассовойСмены(КассаККМ) Экспорт
	
	Возврат РозничныеПродажи.ПолучитьСостояниеКассовойСмены(КассаККМ);
	
КонецФункции

// Получает штрихкоды номенклатуры
//
// Параметры:
//  Структура	 - Структура - Структура переданных параметров.
// 
// Возвращаемое значение:
//  МассивШтрихкодов - Массив штрихкодов номенклатуры.
//
Функция ПолучитьШтрихкодыНоменклатуры(Структура) Экспорт
	
	МассивШтрихкодов = Новый Массив();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки, 1) КАК КоличествоЕдиничныхУпаковок,
	|	УпаковкиНоменклатуры.Владелец КАК Владелец,
	|	УпаковкиНоменклатуры.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ УпаковкиНоменклатуры
	|ИЗ
	|	Справочник.УпаковкиЕдиницыИзмерения КАК УпаковкиНоменклатуры
	|ГДЕ
	|	УпаковкиНоменклатуры.ПометкаУдаления = ЛОЖЬ
	|	И (УпаковкиНоменклатуры.Владелец = &Владелец
	|		ИЛИ УпаковкиНоменклатуры.Владелец = &НаборУпаковок)
	|	И УпаковкиНоменклатуры.Владелец.ЕдиницаИзмерения = УпаковкиНоменклатуры.ЕдиницаИзмерения
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	УпаковкиНоменклатуры.КоличествоЕдиничныхУпаковок КАК КоличествоЕдиничныхУпаковок,
	|	УпаковкиНоменклатуры.Владелец КАК Владелец,
	|	УпаковкиНоменклатуры.Ссылка КАК Ссылка
	|ИЗ
	|	УпаковкиНоменклатуры КАК УпаковкиНоменклатуры
	|ГДЕ
	|	УпаковкиНоменклатуры.КоличествоЕдиничныхУпаковок = 1";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТекстЗапросаКоэффициентУпаковки",
				Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки("УпаковкиНоменклатуры", Неопределено));
	НаборУпаковок = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Структура.Номенклатура,"НаборУпаковок");
	Запрос.УстановитьПараметр("НаборУпаковок", НаборУпаковок);
	Запрос.УстановитьПараметр("Владелец", Структура.Номенклатура);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЕдиничнаяУпаковка = Выборка.Ссылка;
		// Поиск штрихкодов по единичной упаковке и по единице измерения имеет смысл только тогда,
		// когда у номенклатуры 1 упаковка с коэффициентом 1 и ед. изм. 1.
		Если Не Выборка.Следующий()  Тогда
			Если ЕдиничнаяУпаковка = Структура.Упаковка Тогда
				МассивШтрихкодов = РегистрыСведений.ШтрихкодыНоменклатуры.ШтрихкодыНоменклатуры(Структура.Номенклатура,
																								Структура.Характеристика,
																								Справочники.УпаковкиЕдиницыИзмерения.ПустаяСсылка());
			Иначе
				МассивШтрихкодов = РегистрыСведений.ШтрихкодыНоменклатуры.ШтрихкодыНоменклатуры(Структура.Номенклатура,
																								Структура.Характеристика,
																								ЕдиничнаяУпаковка);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Если МассивШтрихкодов.Количество() = 0 Тогда
		
		МассивШтрихкодов = РегистрыСведений.ШтрихкодыНоменклатуры.ШтрихкодыНоменклатуры(Структура.Номенклатура,
																						Структура.Характеристика,
																						Структура.Упаковка);
					
	Иначе
		
		МассивШтрихкодовУпаковкиСтруктуры = РегистрыСведений.ШтрихкодыНоменклатуры.ШтрихкодыНоменклатуры(Структура.Номенклатура,
																										 Структура.Характеристика,
																										 Структура.Упаковка);
					
		Для Каждого Штрихкод Из МассивШтрихкодовУпаковкиСтруктуры Цикл 
			МассивШтрихкодов.Добавить(Штрихкод);
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат МассивШтрихкодов;
	
КонецФункции

// Заполнить реквизит формы "РеквизитыКассира".
//
// Параметры:
//  Кассир - Справочник.Пользователи - Кассир.
//
Функция РеквизитыКассира(Знач Кассир = Неопределено) Экспорт
	
	Если Кассир = Неопределено Тогда
		Кассир = ПользователиКлиентСервер.ТекущийПользователь();
	КонецЕсли;
	
	Возврат РозничныеПродажи.РеквизитыКассира(Кассир);
	
КонецФункции

Функция РеквизитыАдресаМестаРасчетов(Знач ФискальноеУстройство) Экспорт
	
	РеквизитыАдресаМестаРасчетов = Новый Структура;
	РеквизитыАдресаМестаРасчетов.Вставить("АдресРасчетов", "");
	РеквизитыАдресаМестаРасчетов.Вставить("МестоРасчетов", "");
	
	КассаККМ = Справочники.КассыККМ.КассаККМПоПодключаемомуОборудованияДляРМК(ФискальноеУстройство);
	
	Если КассаККМ <> Неопределено Тогда
		РеквизитыКассыККМ = Справочники.КассыККМ.РеквизитыКассыККМ(КассаККМ);
		
		Если ТипЗнч(РеквизитыКассыККМ) = Тип("Структура")
			И РеквизитыКассыККМ.Свойство("Склад") Тогда
			
			Склад = РеквизитыКассыККМ.Склад;
			Если ЗначениеЗаполнено(Склад) И ТипЗнч(Склад) = Тип("СправочникСсылка.Склады") Тогда
				РеквизитыАдресаМестаРасчетов.АдресРасчетов = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(Склад, Справочники.ВидыКонтактнойИнформации.АдресСклада);
				РеквизитыАдресаМестаРасчетов.МестоРасчетов = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Склад, "Наименование");
			КонецЕсли;
			
		КонецЕсли;
			
	КонецЕсли;
	
	Возврат РеквизитыАдресаМестаРасчетов;
	
КонецФункции

Функция ИспользуетсяККТФЗ54(КассоваяСмена) Экспорт
	
	ИспользуетсяККТФЗ54 = Ложь;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	КассоваяСмена.ФискальноеУстройство.ТипОборудования КАК ТипОборудования
	|ИЗ
	|	Документ.КассоваяСмена КАК КассоваяСмена
	|ГДЕ
	|	КассоваяСмена.Ссылка = &КассоваяСмена
	|");
	Запрос.УстановитьПараметр("КассоваяСмена", КассоваяСмена);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		
		ИспользуетсяККТФЗ54 = (Выборка.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ККТ);
		
	КонецЕсли;
	
	Возврат ИспользуетсяККТФЗ54;
	
КонецФункции

Функция НайтиПартнераПоКонтактнымДаннымЭлектронногоЧека(ВариантОтправкиЭлектронногоЧека, КонтактныеДанные) Экспорт
	
	ВозвращаемоеЗначение = Неопределено;
	
	Если ВариантОтправкиЭлектронногоЧека = Перечисления.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьSMS Тогда
		
		ПараметрПоиска = "%" + Прав(КонтактныеДанные, 10);
		ТекстЗапроса = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ПартнерыКонтактнаяИнформация.Ссылка,
		|	ПартнерыКонтактнаяИнформация.Ссылка.ВариантОтправкиЭлектронногоЧека КАК ВариантОтправкиЭлектронногоЧека,
		|	ПартнерыКонтактнаяИнформация.АдресЭП КАК АдресЭП,
		|	ПартнерыКонтактнаяИнформация.НомерТелефона КАК НомерТелефона
		|ИЗ
		|	Справочник.Партнеры.КонтактнаяИнформация КАК ПартнерыКонтактнаяИнформация
		|ГДЕ
		|	ПартнерыКонтактнаяИнформация.НомерТелефона ПОДОБНО &КонтактныеДанные";
		
	ИначеЕсли ВариантОтправкиЭлектронногоЧека = Перечисления.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьEmail Тогда
		
		ПараметрПоиска = КонтактныеДанные;
		ТекстЗапроса = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ПартнерыКонтактнаяИнформация.Ссылка,
		|	ПартнерыКонтактнаяИнформация.Ссылка.ВариантОтправкиЭлектронногоЧека КАК ВариантОтправкиЭлектронногоЧека,
		|	ПартнерыКонтактнаяИнформация.АдресЭП КАК АдресЭП,
		|	ПартнерыКонтактнаяИнформация.НомерТелефона КАК НомерТелефона
		|ИЗ
		|	Справочник.Партнеры.КонтактнаяИнформация КАК ПартнерыКонтактнаяИнформация
		|ГДЕ
		|	ПартнерыКонтактнаяИнформация.АдресЭП = &КонтактныеДанные";
		
	КонецЕсли;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("КонтактныеДанные", ПараметрПоиска);
	
	УстановитьПривилегированныйРежим(Истина);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ВозвращаемоеЗначение = Новый Структура;
		ВозвращаемоеЗначение.Вставить("Партнер",                         Выборка.Ссылка);
		ВозвращаемоеЗначение.Вставить("ВариантОтправкиЭлектронногоЧека", Выборка.ВариантОтправкиЭлектронногоЧека);
		ВозвращаемоеЗначение.Вставить("Email",                           Выборка.АдресЭП);
		ВозвращаемоеЗначение.Вставить("Телефон",                         РозничныеПродажиКлиентСервер.НомерТелефонаВФормате10Знаков(Выборка.НомерТелефона));
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьОрганизациюКассуККМ(КассоваяСмена, КассаККМ, Организация) Экспорт
	
	КассоваяСменаОбъект = КассоваяСмена.ПолучитьОбъект();
	КассоваяСменаОбъект.КассаККМ    = КассаККМ;
	КассоваяСменаОбъект.Организация = Организация;
	КассоваяСменаОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

#КонецОбласти
