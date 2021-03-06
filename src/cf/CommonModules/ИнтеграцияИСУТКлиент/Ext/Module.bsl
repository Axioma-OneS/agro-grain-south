// Универсальные механизмы интеграции ИС (ЕГАИС, ГИСМ, ВЕТИС, ...)

#Область ПрограммныйИнтерфейс

#Область Прочие

// Обработчик команды "Разбить строку".
//
//	Параметры:
//		ТЧ - ДанныеФормыКоллекция
//		ЭлементФормы - ТаблицаФормы
//		ОповещениеПослеРазбиения - ОписаниеОповещения
//		ПараметрыРазбиенияСтроки - см. ОбщегоНазначенияУТКлиент.ПараметрыРазбиенияСтроки.
//
Процедура РазбитьСтрокуТабличнойЧасти(ТЧ, ЭлементФормы, ОповещениеПослеРазбиения, ПараметрыРазбиенияСтроки) Экспорт
	
	ОбщегоНазначенияУТКлиент.РазбитьСтрокуТЧ(ТЧ, ЭлементФормы, ОповещениеПослеРазбиения, ПараметрыРазбиенияСтроки);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПодготовитьОткрытьФормуСчитыванияАкцизнойМарки(Форма, ДополнительныеПараметры) Экспорт
	
	Если Форма.ИспользоватьАкцизныеМарки И ШтрихкодированиеНоменклатурыКлиент.НужноОткрытьФормуУказанияАкцизныхМарокПослеОбработкиШтрихкодов(Форма.ДанныеДляОбработки) Тогда
		
		ДополнительныеПараметры.СтандартнаяОбработка = Ложь;
		
		ПараметрыОповещения = ШтрихкодированиеИСКлиент.ПараметрыСканирования(Форма);
		ПараметрыОповещения.ИдентификаторСтроки = Форма.ДанныеДляОбработки.МассивСтрокСАкцизнымиМарками[0];
		ПараметрыОповещения.Вставить("Форма", Форма);
		
		Результат = Неопределено;
		ОткрытьФормуСчитыванияАкцизнойМарки(Результат, ПараметрыОповещения);
		
	КонецЕсли;

КонецПроцедуры

// Процедура - Открыть форму считывания акцизной марки
//
// Параметры:
//  Результат - Булево - Не используется
//  ДополнительныеПараметры - Структура - Параметры открытия формы считывания марки: (Форма, ИдентификаторСтроки, Редактирование, АдресВоВременномХранилище)
//
Процедура ОткрытьФормуСчитыванияАкцизнойМарки(Результат, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ДополнительныеПараметры.Форма, "Объект") Тогда
		Источник = ДополнительныеПараметры.Форма.Объект;
	Иначе
		Источник = ДополнительныеПараметры.Форма;
	КонецЕсли;
	
	ТекущиеДанные = Источник.Товары.НайтиПоИдентификатору(ДополнительныеПараметры.ИдентификаторСтроки);
	
	Если Не ТекущиеДанные.МаркируемаяПродукция Тогда
		ПоказатьПредупреждение(
			Неопределено,
			НСтр("ru = 'Для данной строки не указываются акцизные марки'"));
		Возврат;
	КонецЕсли;
	
	ПараметрыОткрытияФормы = Новый Структура;
	ПараметрыОткрытияФормы.Вставить("Номенклатура"  , ТекущиеДанные.Номенклатура);
	ПараметрыОткрытияФормы.Вставить("Характеристика", ТекущиеДанные.Характеристика);
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущиеДанные, "АлкогольнаяПродукция")
		И (ТипЗнч(ТекущиеДанные.АлкогольнаяПродукция) = Тип("СправочникСсылка.КлассификаторАлкогольнойПродукцииЕГАИС")
		Или ТекущиеДанные.АлкогольнаяПродукция) Тогда

		ОткрытьФорму(
			"Обработка.РаботаСАкцизнымиМаркамиЕГАИС.Форма.ФормаВводаАкцизнойМарки",
			ПараметрыОткрытияФормы,
			ДополнительныеПараметры.Форма,,,,
			Новый ОписаниеОповещения("ПоискПоШтрихкодуЗавершение", ДополнительныеПараметры.Форма, ДополнительныеПараметры));
		
	ИначеЕсли (ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущиеДанные, "ТабачнаяПродукция") И ТекущиеДанные.ТабачнаяПродукция)
		  Или (ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущиеДанные, "ОсобенностьУчета")
		     И ТекущиеДанные.ОсобенностьУчета = ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.ТабачнаяПродукция")) Тогда
		
		ОткрытьФорму(
			"Обработка.ПроверкаИПодборТабачнойПродукцииМОТП.Форма.ФормаВводаКодаМаркировки",
			ПараметрыОткрытияФормы,
			ДополнительныеПараметры.Форма,,,,
			Новый ОписаниеОповещения("ПоискПоШтрихкодуЗавершение", ДополнительныеПараметры.Форма, ДополнительныеПараметры));
		
	КонецЕсли;
	
КонецПроцедуры

// Открывает форму ввода кода маркировки для маркированной продукции.
// 
// Параметры:
//  Форма - Управляемая форма - Форма владелец.
//  ПараметрыСканирования - (См. ШтрихкодированиеИСКлиент.ПараметрыСканирования).
//  ИдентификаторСтроки - Число - Идентификатор строки, для которой необходимо открыть форму.
Процедура ОткрытьФормуСчитыванияКодаМаркировки(Форма, ПараметрыСканирования, ИдентификаторСтроки) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "Объект") Тогда
		Источник = Форма.Объект;
	Иначе
		Источник = Форма;
	КонецЕсли;
	
	ТекущиеДанные = Источник.Товары.НайтиПоИдентификатору(ИдентификаторСтроки);
	
	ПараметрыОткрытияФормы = ШтрихкодированиеИСКлиент.ПараметрыОткрытияФормыВводаКодаМаркировки();
	ПараметрыОткрытияФормы.Номенклатура          = ТекущиеДанные.Номенклатура;
	ПараметрыОткрытияФормы.Характеристика        = ТекущиеДанные.Характеристика;
	ПараметрыОткрытияФормы.МаркируемаяПродукция  = ТекущиеДанные.МаркируемаяПродукция;
	ПараметрыОткрытияФормы.ПараметрыСканирования = ПараметрыСканирования;
	ПараметрыОткрытияФормы.ВидПродукции          = ТекущиеДанные.ВидПродукцииИС;
	
	ШтрихкодированиеИСКлиент.ОткрытьФормуСчитыванияКодаМаркировки(Форма, ПараметрыОткрытияФормы);
	
КонецПроцедуры

Процедура ОбработатьВыборФормыСканирования(Выбор, ДополнительныеПараметры) Экспорт
	
	Если Выбор <> Неопределено Тогда
		
		ВыбранныйВидПродукции = Выбор.Значение;
		Если ВыбранныйВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Алкогольная") Тогда
			ПроверкаИПодборПродукцииЕГАИСКлиент.ОткрытьФормуСканированияАлкогольнойПродукции(ДополнительныеПараметры.Форма);
		Иначе
			ПроверкаИПодборПродукцииИСМПКлиент.ОткрытьФормуПроверкиИПодбора(ДополнительныеПараметры.Форма, ВыбранныйВидПродукции);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти