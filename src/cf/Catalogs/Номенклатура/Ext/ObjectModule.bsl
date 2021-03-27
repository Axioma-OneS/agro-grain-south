﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;

	МассивНепроверяемыхРеквизитов = Справочники.Номенклатура.НепроверяемыеРеквизиты(ЭтотОбъект);
	
	// Для товаров единица измерения обязательна. Для услуг и работ - настраивается в виде номенклатуры,
	// поэтому для товаров - жестная проверка, а для услуг - через форму элемента
	Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Услуга
		Или ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Работа Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ЕдиницаИзмерения");
	КонецЕсли;
		
	Если КиЗГИСМ
		И ЗначениеЗаполнено(КиЗГИСМGTIN)
		И Не МенеджерОборудованияКлиентСервер.ПроверитьКорректностьGTIN(КиЗГИСМGTIN) Тогда
		ТекстСообщения = НСтр("ru = 'Указан некорректный GTIN.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, "КиЗГИСМGTIN", "Объект", Отказ);
	КонецЕсли;
	
	
	// Защита от ошибки SQL: Переполнение поля.
	ПроверитьКратностьМеры("Вес", Отказ);
	ПроверитьКратностьМеры("Объем", Отказ);
	ПроверитьКратностьМеры("Площадь", Отказ);
	ПроверитьКратностьМеры("Длина", Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Если НЕ ЭтоГруппа Тогда
			ОбщегоНазначенияУТ.ПодготовитьДанныеДляСинхронизацииКлючей(ЭтотОбъект, ПараметрыСинхронизацииКлючей());
		КонецЕсли;
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ЭтоНовый()
		И Не ЗначениеЗаполнено(Код) Тогда
		УстановитьНовыйКод();
	КонецЕсли;
	
	КодДляПоиска = ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(Код, Истина);
	
	Если НЕ УправлениеДоступомУТ.ПроверитьДопустимостьИзмененияРеквизитовСправочника(
				ЭтотОбъект,	"Наименование,НаименованиеПолное", Отказ) Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	// Обработка смены реквизитов
	Если Не ЭтоНовый() Тогда
		
		СтарыеЗначения =  ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, "ПометкаУдаления, ВидНоменклатуры"); 
			
		Если ВидНоменклатуры <> СтарыеЗначения.ВидНоменклатуры Тогда
			Если Не ДополнительныеСвойства.Свойство("СменаВидаНоменклатурыОтработана") Тогда
				Справочники.Номенклатура.ЗаполнитьРеквизитыПоВидуНоменклатуры(ЭтотОбъект, Истина, Отказ);
				
			Иначе
			    // Если проверку и заполнение по виду уже делали, то просто выдадим предупреждения, если что не так,
				// но не будем мешать записывать.
				ЕстьОшибка = Ложь;
				Справочники.Номенклатура.ПроверитьКорректностьСменыВидаНоменклатурыЗаполнитьПоНовомуВиду(ЭтотОбъект, СтарыеЗначения.ВидНоменклатуры, ЕстьОшибка);
				
				Если ЕстьОшибка Тогда
					ДополнительныеСвойства.Вставить("ЕстьПроблемаСоСменойВидаНоменклатуры");
				КонецЕсли;	
				
			КонецЕсли;	
		КонецЕсли;
	КонецЕсли;	
				
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Справочники.Номенклатура.ОтработатьЛогикуСвязиРеквизитов(ЭтотОбъект);

	ФормироватьРабочееНаименование   = НЕ (ДополнительныеСвойства.Свойство("РабочееНаименованиеСформировано"));
	ФормироватьНаименованиеДляПечати = НЕ (ДополнительныеСвойства.Свойство("НаименованиеДляПечатиСформировано"));
	
	Если ФормироватьРабочееНаименование 
		ИЛИ ФормироватьНаименованиеДляПечати Тогда
		
		СтруктураРеквизитов = Новый Структура;
		СтруктураРеквизитов.Вставить("ШаблонРабочегоНаименованияНоменклатуры");
		СтруктураРеквизитов.Вставить("ЗапретРедактированияРабочегоНаименованияНоменклатуры");
		СтруктураРеквизитов.Вставить("ШаблонНаименованияДляПечатиНоменклатуры");
		СтруктураРеквизитов.Вставить("ЗапретРедактированияНаименованияДляПечатиНоменклатуры");
		
		РеквизитыОбъекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ВидНоменклатуры, СтруктураРеквизитов);
		
		Если ФормироватьРабочееНаименование 
			И ЗначениеЗаполнено(РеквизитыОбъекта.ШаблонРабочегоНаименованияНоменклатуры) 
			И (РеквизитыОбъекта.ЗапретРедактированияРабочегоНаименованияНоменклатуры 
			ИЛИ НЕ ЗначениеЗаполнено(Наименование)) Тогда
			
			ШаблонНаименования = РеквизитыОбъекта.ШаблонРабочегоНаименованияНоменклатуры;
			Наименование = НоменклатураСервер.НаименованиеПоШаблону(ШаблонНаименования, ЭтотОбъект);
			
		КонецЕсли;
		
		Если ФормироватьНаименованиеДляПечати 
			И ЗначениеЗаполнено(РеквизитыОбъекта.ШаблонНаименованияДляПечатиНоменклатуры) 
			И (РеквизитыОбъекта.ЗапретРедактированияНаименованияДляПечатиНоменклатуры 
			ИЛИ НЕ ЗначениеЗаполнено(НаименованиеПолное)) Тогда
			
			ШаблонНаименованияДляПечати = РеквизитыОбъекта.ШаблонНаименованияДляПечатиНоменклатуры;
			НаименованиеПолное = НоменклатураСервер.НаименованиеПоШаблону(ШаблонНаименованияДляПечати, ЭтотОбъект);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Наименование) Тогда
		
		ТекстИсключения = НСтр("ru='Поле ""Рабочее наименование"" не заполнено'");
		ВызватьИсключение ТекстИсключения; 
		Отказ = Истина;
		
	КонецЕсли;
	
	КонтролироватьРабочееНаименование =
		Константы.КонтролироватьУникальностьРабочегоНаименованияНоменклатурыИХарактеристик.Получить()
		И НЕ (ДополнительныеСвойства.Свойство("РабочееНаименованиеПроверено"));
	
	Если НЕ Отказ 
		И КонтролироватьРабочееНаименование
		И Не ПометкаУдаления Тогда
		
		НаименованиеУникально = Справочники.Номенклатура.РабочееНаименованиеУникально(ЭтотОбъект);
		
		Если НЕ НаименованиеУникально Тогда
			
			ТекстИсключения = НСтр("ru='Значение поля ""Рабочее наименование"" не уникально'");
			ВызватьИсключение ТекстИсключения; 
			Отказ = Истина;
			
		КонецЕсли;
		
	КонецЕсли;
	
	ОбщегоНазначенияУТ.ПодготовитьДанныеДляСинхронизацииКлючей(ЭтотОбъект, ПараметрыСинхронизацииКлючей());
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияУТ.СинхронизироватьКлючи(ЭтотОбъект);
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не Отказ
		И ДополнительныеСвойства.Свойство("ЕстьПроблемаСоСменойВидаНоменклатуры") Тогда
		ТекстСообщения = НСтр("ru = 'Запись элемента выполнена, но есть проблемы, связанные с изменением вида номенклатуры.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ШтрихкодыНоменклатуры.Штрихкод КАК Штрихкод
	|ИЗ
	|	РегистрСведений.ШтрихкодыНоменклатуры КАК ШтрихкодыНоменклатуры
	|ГДЕ
	|	ШтрихкодыНоменклатуры.Номенклатура = &Номенклатура";
	Запрос.УстановитьПараметр("Номенклатура", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НаборЗаписей = РегистрыСведений.ШтрихкодыНоменклатуры.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Штрихкод.Значение = Выборка.Штрихкод;
		НаборЗаписей.Отбор.Штрихкод.Использование = Истина;
		НаборЗаписей.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВидовНоменклатуры") Тогда
		Справочники.ВидыНоменклатуры.ПолучитьПредустановленныеВидыНоменклатуры();
	КонецЕсли;
	
	Справочники.Номенклатура.ЗаполнитьРеквизитыПоВидуНоменклатуры(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьКратностьМеры(Мера, Отказ)
	СообщениеКратностьБолее = НСтр("ru = 'Кратность более 10 000 000 / 1'");
	СообщениеКратностьМенее = НСтр("ru = 'Кратность менее 1 / 99 999 999'");
	Если ЭтотОбъект[Мера + "Использовать"]
		И ЗначениеЗаполнено(ЭтотОбъект[Мера + "Знаменатель"]) Тогда
		Если ЭтотОбъект[Мера + "Числитель"] / ЭтотОбъект[Мера + "Знаменатель"] < 0.0000001 Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				СообщениеКратностьБолее,
				,
				"Объект." + Мера + "Знаменатель",
				,
				Отказ);
		ИначеЕсли ЭтотОбъект[Мера + "Числитель"] / ЭтотОбъект[Мера + "Знаменатель"] > 99999999 Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				СообщениеКратностьМенее,
				,
				"Объект." + Мера + "Числитель",
				,
				Отказ);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

Функция ПараметрыСинхронизацииКлючей()
	
	Результат = Новый Соответствие;
	
	Результат.Вставить("Справочник.КлючиАналитикиУчетаНоменклатуры", "ПометкаУдаления");
	Результат.Вставить("Справочник.КлючиАналитикиУчетаНаборов", "ПометкаУдаления");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли
