﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКопировании(ОбъектКопирования)
	ИдентификаторПлатежа   = Неопределено;
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		Если ДанныеЗаполнения.Свойство("Исправление") И ДанныеЗаполнения.Исправление Тогда
			
			Если ДанныеЗаполнения.Свойство("СводнаяСправкаОснование") Тогда
				СводнаяСправкаОснование = ДанныеЗаполнения.СводнаяСправкаОснование;
			ИначеЕсли ДанныеЗаполнения.Свойство("ДокументОснование") Тогда
				СводнаяСправкаОснование = ДанныеЗаполнения.ДокументОснование;
			КонецЕсли;
			
		ИначеЕсли ДанныеЗаполнения.Свойство("Корректировочная") И ДанныеЗаполнения.Корректировочная
			И ДанныеЗаполнения.Свойство("ДокументОснование") Тогда
			
			ЗаполнитьКорректировкуПоДокументуОснованию(ДанныеЗаполнения);
			
		КонецЕсли;
		
	КонецЕсли;
	
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	ПроведениеСерверУТ.УстановитьРежимПроведения(ЭтотОбъект, РежимЗаписи, РежимПроведения);
	
	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
	
	Если ПериодичностьОформления = Перечисления.Периодичность.Месяц Тогда
		Дата = КонецМесяца(Дата);
	ИначеЕсли ПериодичностьОформления = Перечисления.Периодичность.Квартал Тогда
		Дата = КонецКвартала(Дата);
	КонецЕсли;
	
	Если Не Исправление Тогда
		НомерИсправления = "";
		СводнаяСправкаОснование = Неопределено;
	КонецЕсли;
	
	Если Не ПометкаУдаления Тогда
		ПроверитьДублиСправки(Отказ);
	КонецЕсли;
	
	Если ЭтоНовый() И Не ЗначениеЗаполнено(Номер) Тогда
		УстановитьНовыйНомер();
	КонецЕсли;
	
	Если РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда
		РучнаяКорректировкаЖурналаСФ = Ложь;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Отказ Тогда
		МассивДокументов= Новый Массив;
		МассивДокументов.Добавить(Ссылка);
		УчетНДСУП.СформироватьЗаданияПоДокументам(МассивДокументов);
	КонецЕсли;
	
	Если Не Отказ
		И Не ДополнительныеСвойства.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		РегистрыСведений.РеестрДокументов.ИнициализироватьИЗаписатьДанныеДокумента(Ссылка, ДополнительныеСвойства, Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);

	Документы.СводнаяСправкаНДС.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);

	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	УчетНДСУП.СформироватьДвиженияВРегистры(ДополнительныеСвойства, Движения, Отказ);
	РегистрыСведений.РеестрДокументов.ЗаписатьДанныеДокумента(Ссылка, ДополнительныеСвойства, Отказ);

	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСерверУТ.СформироватьЗаписиРегистровЗаданий(ЭтотОбъект);
	
	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если НЕ ЗначениеЗаполнено(Ссылка) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("НомерИсправления");
	КонецЕсли;
	
	Если НЕ Исправление Тогда
		МассивНепроверяемыхРеквизитов.Добавить("СводнаяСправкаОснование");
		МассивНепроверяемыхРеквизитов.Добавить("НомерИсправления");
	КонецЕсли;
	
	Если НЕ Корректировочная Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ПервичныйДокумент");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ПриУстановкеНовогоНомера(СтандартнаяОбработка, Префикс)
	
	Если Исправление Тогда
		
		// Установка номера по исходному документу.
		
		УстановитьПривилегированныйРежим(Истина);
		
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	ВЫБОР
		|		КОГДА СводнаяСправкаНДС.Исправление
		|			ТОГДА СводнаяСправкаНДС.СводнаяСправкаОснование
		|		ИНАЧЕ СводнаяСправкаНДС.Ссылка
		|	КОНЕЦ                     КАК Ссылка,
		|	СводнаяСправкаНДС.Номер КАК Номер
		|ПОМЕСТИТЬ ИсходныеДокументы
		|ИЗ Документ.СводнаяСправкаНДС КАК СводнаяСправкаНДС
		|ГДЕ
		|	СводнаяСправкаНДС.Ссылка = &СводнаяСправкаОснование
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	ИсходныеДокументы.Номер КАК Номер,
		|	ЕСТЬNULL(Исправления.НомерИсправления, 0) КАК НомерИсправления
		|ИЗ
		|	ИсходныеДокументы КАК ИсходныеДокументы
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СводнаяСправкаНДС КАК Исправления
		|		ПО ИсходныеДокументы.Ссылка = Исправления.СводнаяСправкаОснование
		|			И ИсходныеДокументы.Ссылка <> Исправления.Ссылка
		|			И Исправления.Исправление
		|			И НЕ Исправления.Корректировочная
		|			И НЕ Исправления.ПометкаУдаления
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерИсправления УБЫВ");
		
		Запрос.УстановитьПараметр("СводнаяСправкаОснование", СводнаяСправкаОснование);
		
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			
			СтандартнаяОбработка = Ложь;
			
			// Установка номера и переопределение префикса информационной базы.
			Префикс = "И";
			ПрефиксацияОбъектовСобытия.УстановитьПрефиксИнформационнойБазыИОрганизации(ЭтотОбъект, СтандартнаяОбработка, Префикс);
			
			НомерБезПрефикса = ПрефиксацияОбъектовКлиентСервер.УдалитьПрефиксыИзНомераОбъекта(Выборка.Номер, Истина, Истина);
			Если СтрДлина(СокрП(НомерБезПрефикса)) = 7 Тогда
				НомерБезПрефикса = Прав(НомерБезПрефикса, СтрДлина(НомерБезПрефикса)-1);
			КонецЕсли;
			Номер = Префикс + НомерБезПрефикса;
			
			НомерИсправления = Формат(Число(Выборка.НомерИсправления)+1, "ЧЦ=10; ЧДЦ=0; ЧГ=0");
			
		КонецЕсли;
		
	Иначе
		
		Префикс = "0";
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	// Инициализация дополнительных свойств для проведения документа
	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);
	
	// Подготовка наборов записей
	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	// Запись наборов записей
	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);
	
	ПроведениеСерверУТ.СформироватьЗаписиРегистровЗаданий(ЭтотОбъект);
	
	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)
	
	Если ТипЗнч(ДанныеЗаполнения) <> Тип("Структура") Или Не ДанныеЗаполнения.Свойство("Организация") Тогда
		Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьКорректировкуПоДокументуОснованию(ДанныеЗаполнения)
	
	
	
КонецПроцедуры

Процедура ДополнитьДаннымиПредыдущегоИсправления() Экспорт

	Если Исправление Тогда
		ПредыдущееИсправление = Документы.СводнаяСправкаНДС.СводнаяСправкаПредыдущееИсправление(СводнаяСправкаОснование, НомерИсправления);
		ИсточникЗаполнения = ?(ПредыдущееИсправление = Неопределено, СводнаяСправкаОснование, ПредыдущееИсправление);
		Для Каждого СтрокаТЧ Из ИсточникЗаполнения.Продажи Цикл
			ЗаполнитьЗначенияСвойств(Продажи.Добавить(), СтрокаТЧ);
		КонецЦикла;
		Продажи.Свернуть("ВидЦенности,СтавкаНДС", "СуммаБезНДС,НДС");
	КонецЕсли;

КонецПроцедуры
 

#КонецОбласти

#Область Прочее

Процедура ПроверитьДублиСправки(Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ПредставлениеПериода = ?(
		ПериодичностьОформления = Перечисления.Периодичность.Месяц,
		ПредставлениеПериода(НачалоМесяца(Дата), КонецМесяца(Дата), "ФП = Истина"),
		ПредставлениеПериода(НачалоКвартала(Дата), КонецКвартала(Дата), "ФП = Истина"));
	
	Если Корректировочная Тогда
			
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	ДанныеДокумента.Ссылка КАК Ссылка,
		|	ДанныеДокумента.Организация КАК Организация,
		|	ДанныеДокумента.Дата КАК Период
		|ИЗ
		|	Документ.СводнаяСправкаНДС КАК ДанныеДокумента
		|ГДЕ
		|	ДанныеДокумента.Ссылка <> &Ссылка
		|	И ДанныеДокумента.Проведен
		|	И ДанныеДокумента.Корректировочная
		|	И КОНЕЦПЕРИОДА(ДанныеДокумента.Дата) = &Дата
		|	И ДанныеДокумента.Организация = &Организация
		|	И ДанныеДокумента.ПериодичностьОформления = &ПериодичностьОформления
		|	И ДанныеДокумента.ПервичныйДокумент = &ПервичныйДокумент
		|");
		
		Запрос.УстановитьПараметр("Ссылка",                  Ссылка);
		Запрос.УстановитьПараметр("Организация",             Организация);
		Запрос.УстановитьПараметр("Дата",                    Дата);
		Запрос.УстановитьПараметр("ПериодичностьОформления", ПериодичностьОформления);
		Запрос.УстановитьПараметр("ПервичныйДокумент",       ПервичныйДокумент);
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Для периода %1 по документу %2 уже введена сводная справка %3'"),
				ПредставлениеПериода,
				ПервичныйДокумент,
				Выборка.Ссылка);
			ОбщегоНазначения.СообщитьПользователю(
				Текст,
				ЭтотОбъект,
				,
				,
				Отказ);
			
		КонецЦикла;
		
	ИначеЕсли НЕ Исправление Тогда
		
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	ДанныеДокумента.Ссылка КАК Ссылка,
		|	ДанныеДокумента.Организация КАК Организация,
		|	ДанныеДокумента.Дата КАК Период
		|ИЗ
		|	Документ.СводнаяСправкаНДС КАК ДанныеДокумента
		|ГДЕ
		|	ДанныеДокумента.Ссылка <> &Ссылка
		|	И ДанныеДокумента.Проведен
		|	И НЕ ДанныеДокумента.Корректировочная
		|	И НЕ ДанныеДокумента.Исправление
		|	И КОНЕЦПЕРИОДА(ДанныеДокумента.Дата) = &Дата
		|	И ДанныеДокумента.Организация = &Организация
		|	И ДанныеДокумента.ПериодичностьОформления = &ПериодичностьОформления
		|");
		
		Запрос.УстановитьПараметр("Ссылка",                  Ссылка);
		Запрос.УстановитьПараметр("Организация",             Организация);
		Запрос.УстановитьПараметр("Дата",                    Дата);
		Запрос.УстановитьПараметр("ПериодичностьОформления", ПериодичностьОформления);
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Для периода %1 по организации %2 уже введена сводная справка %3'"),
				ПредставлениеПериода,
				Организация,
				Выборка.Ссылка);
			ОбщегоНазначения.СообщитьПользователю(
				Текст,
				ЭтотОбъект,
				,
				,
				Отказ);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
