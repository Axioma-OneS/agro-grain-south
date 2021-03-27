﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоКассККМ") Тогда
		КассаККМ = Справочники.КассыККМ.КассаККМПоУмолчанию();
	КонецЕсли;
	
	ОбщегоНазначенияУТ.НастроитьПодключаемоеОборудование(ЭтаФорма);
	
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма, Элементы.ГруппаКомандыСписка);
	// Конец ИнтеграцияС1СДокументооборотом

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	СтандартныеПодсистемыСервер.УстановитьУсловноеОформлениеПоляДата(ЭтотОбъект, "ОтчетыОРозничныхПродажах", "Дата");
	
	// ИнтеграцияГИСМ
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(ОтчетыОРозничныхПродажах, "ЕстьМаркируемаяПродукцияГИСМ", Истина, ВидСравненияКомпоновкиДанных.Равно,, Истина);
	
	СтруктураБыстрогоОтбора = Неопределено;
	Параметры.Свойство("СтруктураБыстрогоОтбора", СтруктураБыстрогоОтбора);
	
	ИнтеграцияГИСМКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(ОтчетыОРозничныхПродажах, "СтатусГИСМ", СтатусГИСМ, СтруктураБыстрогоОтбора);
	ИнтеграцияГИСМКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(ОтчетыОРозничныхПродажах, "Ответственный", Ответственный, СтруктураБыстрогоОтбора);
	ИнтеграцияГИСМКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(ОтчетыОРозничныхПродажах, "Организация", Организация, СтруктураБыстрогоОтбора);

	Если ИнтеграцияГИСМКлиентСервер.НеобходимОтборПоДальнейшемуДействиюГИСМПриСозданииНаСервере(ДальнейшееДействиеГИСМ, СтруктураБыстрогоОтбора) Тогда
		УстановитьОтборПоДальнейшемуДействиюСервер();
	КонецЕсли;
	ИнтеграцияГИСМ.ЗаполнитьСписокВыбораДальнейшееДействие(
		Элементы.ДальнейшееДействиеГИСМОтбор.СписокВыбора,
		ИнтеграцияГИСМ.ВсеТребующиеДействияСтатусыИнформирования(), 
		ИнтеграцияГИСМ.ВсеТребующиеОжиданияСтатусыИнформирования());
	// Конец ИнтеграцияГИСМ

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПриОткрытииФормы(Неопределено, ЭтаФорма, "СканерШтрихкода");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПриЗакрытииФормы(Неопределено, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" И МенеджерОборудованияУТКлиент.ЕстьНеобработанноеСобытие() Тогда
			Данные = СобытияФормИСКлиент.ПреобразоватьДанныеСоСканераВСтруктуру(Параметр);
			ОбработатьШтрихкоды(Данные);
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
	Если ИмяСобытия = "Запись_ОтчетОРозничныхПродажах" Тогда
		
		Элементы.ОтчетыОРозничныхПродажах.Обновить();
		
	КонецЕсли;
	
	// ИнтеграцияГИСМ
	Если ИмяСобытия = "ИзменениеСостоянияГИСМ"
		И ТипЗнч(Параметр.Ссылка) = Тип("ДокументСсылка.ОтчетОРозничныхПродажах") Тогда
		
		Элементы.ОтчетыОРозничныхПродажах.Обновить();
		
	КонецЕсли;
	
	Если ИмяСобытия = "ВыполненОбменГИСМ"
		И (Параметр = Неопределено
		Или (ТипЗнч(Параметр) = Тип("Структура") И Параметр.ОбновлятьСтатусГИСМФормахВДокументах)) Тогда
		
		Элементы.ОтчетыОРозничныхПродажах.Обновить();
		
	КонецЕсли;
	// Конец ИнтеграцияГИСМ
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	КассаККМ = Настройки.Получить("КассаККМ");
	УстановитьОтборДинамическихСписков();
	
	ЗапрещеноДобавлятьНовыеДокументы = ЗапрещеноДобавлятьНовыеДокументы(КассаККМ);
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	
	// ИнтеграцияГИСМ
	ИнтеграцияГИСМКлиентСервер.ОтборПоЗначениюСпискаПриЗагрузкеИзНастроек(ОтчетыОРозничныхПродажах,
	                                                                     "СтатусГИСМ",
	                                                                     СтатусГИСМ,
	                                                                     СтруктураБыстрогоОтбора,
	                                                                     Настройки);
	
	Если ИнтеграцияГИСМКлиентСервер.НеобходимОтборПоДальнейшемуДействиюГИСМПередЗагрузкойИзНастроек(ДальнейшееДействиеГИСМ, СтруктураБыстрогоОтбора, Настройки) Тогда
		УстановитьОтборПоДальнейшемуДействиюСервер();
	КонецЕсли;
	
	ИнтеграцияГИСМКлиентСервер.ОтборПоЗначениюСпискаПриЗагрузкеИзНастроек(ОтчетыОРозничныхПродажах,
	                                                                     "Ответственный",
	                                                                     Ответственный,
	                                                                     СтруктураБыстрогоОтбора,
	                                                                     Настройки);
	
	ИнтеграцияГИСМКлиентСервер.ОтборПоЗначениюСпискаПриЗагрузкеИзНастроек(ОтчетыОРозничныхПродажах,
	                                                                     "Организация",
	                                                                     Организация,
	                                                                     СтруктураБыстрогоОтбора,
	                                                                     Настройки);
	// Конец ИнтеграцияГИСМ
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КассаОтборПриИзменении(Элемент)
	
	УстановитьОтборДинамическихСписковНаКлиенте();
	УстановитьДоступностьКнопокСозданияНовыхДокументов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОтчетыорозничныхпродажах

&НаКлиенте
Процедура ОтчетыОРозничныхПродажахПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	
	Если Не(Не ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена) Тогда
		Отказ = Истина;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтчетыОРозничныхПродажахПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.ОтчетыОРозничныхПродажах);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.ОтчетыОРозничныхПродажах, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.ОтчетыОРозничныхПродажах);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Элементы.ОтчетыОРозничныхПродажах);
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ШтрихкодыИТорговоеОборудование

&НаКлиенте
Процедура ОбработатьШтрихкоды(Данные)
	
	МассивСсылок = СсылкаНаЭлементСпискаПоШтрихкоду(Данные.Штрихкод);
	Если НЕ МассивСсылок.Количество() > 0 Тогда
		ШтрихкодированиеПечатныхФормКлиент.ОбъектНеНайден(Данные.Штрихкод);
	Иначе
		Элементы.ОтчетыОРозничныхПродажах.ТекущаяСтрока = МассивСсылок[0];
		ПоказатьЗначение(Неопределено, МассивСсылок[0]);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция СсылкаНаЭлементСпискаПоШтрихкоду(Штрихкод)
	
	Менеджеры = Новый Массив();
	Менеджеры.Добавить(ПредопределенноеЗначение("Документ.ОтчетОРозничныхПродажах.ПустаяСсылка"));
	Возврат ШтрихкодированиеПечатныхФормКлиент.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод, Менеджеры);
	
КонецФункции

#КонецОбласти

#Область Прочее

&НаСервереБезКонтекста
Функция ЗапрещеноДобавлятьНовыеДокументы(КассаККМ)
	
	Реквизиты = Справочники.КассыККМ.РеквизитыКассыККМ(КассаККМ);
	Возврат Реквизиты.ТипКассы = Перечисления.ТипыКассККМ.ФискальныйРегистратор
	    ИЛИ Реквизиты.ТипКассы = Перечисления.ТипыКассККМ.ККМOffline;
	
КонецФункции

// Так же вызывается ПриЗагрузкеДанныхИзНастроекНаСервере
&НаКлиенте
Процедура УстановитьДоступностьКнопокСозданияНовыхДокументов()
	
	ЗапрещеноДобавлятьНовыеДокументы = ЗапрещеноДобавлятьНовыеДокументы(КассаККМ);
	
	КассаККМЗаполнена = ЗначениеЗаполнено(КассаККМ);
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСоздать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "КонтекстноеМенюОтчетыОРозничныхПродажахСкопировать", "Доступность", НЕ ЗапрещеноДобавлятьНовыеДокументы И КассаККМЗаполнена);
	
КонецПроцедуры

// Процедура устанавливает отбор динамических списков формы.
//
&НаСервере
Процедура УстановитьОтборДинамическихСписков()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(ОтчетыОРозничныхПродажах, 
		"КассаККМ",
		КассаККМ,
		ВидСравненияКомпоновкиДанных.Равно,,
		ЗначениеЗаполнено(КассаККМ));
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(ОтчетыОРозничныхПродажах,
		"СтатусГИСМ",
		СтатусГИСМ,
		ВидСравненияКомпоновкиДанных.Равно,,
		ЗначениеЗаполнено(СтатусГИСМ));
	
КонецПроцедуры

// Процедура устанавливает отбор динамических списков формы.
//
&НаКлиенте
Процедура УстановитьОтборДинамическихСписковНаКлиенте()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(ОтчетыОРозничныхПродажах, "КассаККМ", КассаККМ, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(КассаККМ));
	
КонецПроцедуры

// ИнтеграцияГИСМ
&НаКлиенте
Процедура СтатусГИСМОтборПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(ОтчетыОРозничныхПродажах,
		"СтатусГИСМ",
		СтатусГИСМ,
		ВидСравненияКомпоновкиДанных.Равно,,
		ЗначениеЗаполнено(СтатусГИСМ));
	
КонецПроцедуры

&НаКлиенте
Процедура ДальнейшееДействиеГИСМОтборПриИзменении(Элемент)
	
	УстановитьОтборПоДальнейшемуДействиюСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтветственныйОтборПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ОтчетыОРозничныхПродажах,
		"Ответственный",
		Ответственный,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ЗначениеЗаполнено(Ответственный));
		
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияОтборПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(ОтчетыОРозничныхПродажах,
	                                                                        "Организация",
	                                                                        Организация,
	                                                                        ВидСравненияКомпоновкиДанных.Равно,
	                                                                        ,
	                                                                        ЗначениеЗаполнено(Организация));
	
КонецПроцедуры

// Конец ИнтеграцияГИСМ

&НаКлиенте
Процедура ОтчетыОРозничныхПродажахВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле = Элементы.ДальнейшееДействиеГИСМ Тогда
		
		СтандартнаяОбработка = Ложь;
		ТекущиеДанные = Элемент.ДанныеСтроки(ВыбраннаяСтрока);
		
		ИнтеграцияГИСМКлиент.ВыполнитьДальнейшееДействиеДляДокументовИзСписка(
			Элементы.ОтчетыОРозничныхПродажах,
			Элемент.ДанныеСтроки(ВыбраннаяСтрока).ДальнейшееДействиеГИСМ);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередатьДанные(Команда)
	
	ИнтеграцияГИСМКлиент.ВыполнитьДальнейшееДействиеДляДокументовИзСписка(
		Элементы.ОтчетыОРозничныхПродажах,
		ПредопределенноеЗначение("Перечисление.ДальнейшиеДействияПоВзаимодействиюГИСМ.ПередайтеДанные"));
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбмен(Команда)
	
	ИнтеграцияГИСМКлиент.ВыполнитьОбмен();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	// Условное оформление динамического списка "СписокРаспоряженияНаОформление"
	СписокУсловноеОформление = ОтчетыОРозничныхПродажах.КомпоновщикНастроек.Настройки.УсловноеОформление;
	СписокУсловноеОформление.Элементы.Очистить();
	
	// ИнтеграцияГИСМ
	ИнтеграцияГИСМ.УстановитьУсловноеОформлениеСтатусДальнейшееДействиеГИСМ(
		СписокУсловноеОформление,
		Элементы,
		Элементы.СтатусГИСМ.Имя,
		Элементы.ДальнейшееДействиеГИСМ.Имя,
		"СтатусГИСМ",
		"ДальнейшееДействиеГИСМ");
		
	ИнтеграцияГИСМ.УстановитьУсловноеОформлениеСтатусИнформированияГИСМ(
		СписокУсловноеОформление,
		Элементы,
		Элементы.СтатусГИСМ.Имя,
		"СтатусГИСМ");
	// Конец ИнтеграцияГИСМ

КонецПроцедуры


// ИнтеграцияГИСМ
#Область ОтборДальнейшиеДействия

&НаСервере
Процедура УстановитьОтборПоДальнейшемуДействиюСервер()
	
	ИнтеграцияГИСМ.УстановитьОтборПоДальнейшемуДействию(ОтчетыОРозничныхПродажах,
	                                                    ДальнейшееДействиеГИСМ,
	                                                    ИнтеграцияГИСМ.ВсеТребующиеДействияСтатусыИнформирования(), 
	                                                    ИнтеграцияГИСМ.ВсеТребующиеОжиданияСтатусыИнформирования());
	
КонецПроцедуры

#КонецОбласти
// Конец ИнтеграцияГИСМ

#КонецОбласти

#КонецОбласти
