﻿
#Область ПрограммныйИнтерфейс

// Обновляет статистику по номенклатуре, продаваемой совместно
//
Процедура ОбновитьДанныеОНоменклатуреПродаваемойСовместно() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(Метаданные.РегламентныеЗадания.ОбновлениеНоменклатурыПродаваемойСовместно);
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОбновитьЗаписиРегистра(
		Перечисления.ВариантыАнализаНоменклатурыПродаваемойСовместно.ОптоваяТорговля,
		ВыполнитьПоискАссоциаций(ИсточникДанныхДляАнализаОптовойТорговли()));
	
	ОбновитьЗаписиРегистра(
		Перечисления.ВариантыАнализаНоменклатурыПродаваемойСовместно.РозничнаяТорговля,
		ВыполнитьПоискАссоциаций(ИсточникДанныхДляАнализаРозничнойТорговли()));
	
КонецПроцедуры

// Возвращает таблицу статистики по номенклатуре, продаваемой совместно.
//
// Параметры:
//  Товары - ТаблицаЗначений - таблица с колонками:
//   * Номенклатура - СправочникСсылка.Номенклатура - Номенклатура.
//   * Характеристика - СправочникСсылка.ХарактеристикиНоменклатуры - Характеристика номенклатуры.
//  ВариантАнализа - ПеречислениеСсылка.ВариантыАнализаНоменклатурыПродаваемойСовместно - Вариант анализа.
//
// Возвращаемое значение:
//  ТаблицаЗначений - Таблица с колонками:
//   * Номенклатура - СправочникСсылка.Номенклатура - Номенклатура.
//   * Характеристика - СправочникСсылка.ХарактеристикиНоменклатуры - Характеристика номенклатуры.
//   * ПроцентСлучаев - Число - Процент случаев.
//   * КоличествоСлучаев - Число - Количество случаев.
//
Функция ПолучитьДанныеОНоменклатуреПродаваемойСовместно(Товары, ВариантАнализа) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Товары.Номенклатура   КАК Номенклатура,
	|	Товары.Характеристика КАК Характеристика
	|ПОМЕСТИТЬ Товары
	|ИЗ
	|	&Товары КАК Товары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	НоменклатураПродаваемаяСовместно.НоменклатураСледствие   КАК Номенклатура,
	|	НоменклатураПродаваемаяСовместно.ХарактеристикаСледствие КАК Характеристика,
	|	НоменклатураПродаваемаяСовместно.ПроцентСлучаев          КАК ПроцентСлучаев,
	|	НоменклатураПродаваемаяСовместно.КоличествоСлучаев       КАК КоличествоСлучаев
	|ИЗ
	|	РегистрСведений.НоменклатураПродаваемаяСовместно КАК НоменклатураПродаваемаяСовместно
	|ГДЕ
	|	НоменклатураПродаваемаяСовместно.ВариантАнализа = &ВариантАнализа
	|	И (НоменклатураПродаваемаяСовместно.НоменклатураПредпосылка, НоменклатураПродаваемаяСовместно.ХарактеристикаПредпосылка) В
	|			(ВЫБРАТЬ
	|				Товары.Номенклатура,
	|				Товары.Характеристика
	|			ИЗ
	|				Товары КАК Товары)";
	
	Запрос.УстановитьПараметр("Товары", Товары);
	Запрос.УстановитьПараметр("ВариантАнализа", ВариантАнализа);
	
	Результат = Запрос.Выполнить().Выгрузить();
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИсточникДанныхДляАнализаОптовойТорговли()
	
	ПериодичностьДляАнализаНоменклатурыПродаваемойСовместно = Константы.ПериодичностьДляАнализаНоменклатурыПродаваемойСовместно.Получить();
	КоличествоПериодовДляАнализаНоменклатурыПродаваемойСовместно = Константы.КоличествоПериодовДляАнализаНоменклатурыПродаваемойСовместно.Получить();
	
	ДатаНачала    = ОбщегоНазначенияУТКлиентСервер.РассчитатьДатуОкончанияПериода(ТекущаяДатаСеанса(), ПериодичностьДляАнализаНоменклатурыПродаваемойСовместно, -КоличествоПериодовДляАнализаНоменклатурыПродаваемойСовместно) + 1;
	ДатаОкончания = КонецДня(ТекущаяДатаСеанса());
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Товары.Ссылка         КАК Документ,
	|	Товары.Номенклатура   КАК Номенклатура,
	|	Товары.Характеристика КАК Характеристика
	|ИЗ
	|	Документ.РеализацияТоваровУслуг.Товары КАК Товары
	|ГДЕ
	|	Товары.Номенклатура.ТипНоменклатуры <> ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара)
	|	И Товары.Ссылка.Проведен
	|	И Товары.Ссылка.Дата МЕЖДУ &ДатаНачала И &ДатаОкончания
	|");
	
	Запрос.Параметры.Вставить("ДатаНачала", ДатаНачала);
	Запрос.Параметры.Вставить("ДатаОкончания", ДатаОкончания);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция ИсточникДанныхДляАнализаРозничнойТорговли()
	
	ПериодичностьДляАнализаНоменклатурыПродаваемойСовместно = Константы.ПериодичностьДляАнализаНоменклатурыПродаваемойСовместно.Получить();
	КоличествоПериодовДляАнализаНоменклатурыПродаваемойСовместно = Константы.КоличествоПериодовДляАнализаНоменклатурыПродаваемойСовместно.Получить();
	
	ДатаНачала    = ОбщегоНазначенияУТКлиентСервер.РассчитатьДатуОкончанияПериода(ТекущаяДатаСеанса(), ПериодичностьДляАнализаНоменклатурыПродаваемойСовместно, -КоличествоПериодовДляАнализаНоменклатурыПродаваемойСовместно);
	ДатаОкончания = КонецДня(ТекущаяДатаСеанса());
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Товары.Ссылка         КАК Документ,
	|	Товары.Номенклатура   КАК Номенклатура,
	|	Товары.Характеристика КАК Характеристика
	|ИЗ
	|	Документ.ЧекККМ.Товары КАК Товары
	|ГДЕ
	|	Товары.Номенклатура.ТипНоменклатуры <> ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара)
	|	И Товары.Ссылка.Проведен
	|	И Товары.Ссылка.Дата МЕЖДУ &ДатаНачала И &ДатаОкончания
	|");
	
	Запрос.Параметры.Вставить("ДатаНачала", ДатаНачала);
	Запрос.Параметры.Вставить("ДатаОкончания", ДатаОкончания);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция ВыполнитьПоискАссоциаций(ИсточникДанных)
	
	Анализ = Новый АнализДанных;
	Анализ.ТипАнализа = Тип("АнализДанныхПоискАссоциаций");
	Анализ.ИсточникДанных = ИсточникДанных;
	
	Анализ.НастройкаКолонок.Документ.ТипКолонки       = ТипКолонкиАнализаДанныхПоискАссоциаций.Объект;
	Анализ.НастройкаКолонок.Номенклатура.ТипКолонки   = ТипКолонкиАнализаДанныхПоискАссоциаций.Элемент;
	Анализ.НастройкаКолонок.Характеристика.ТипКолонки = ТипКолонкиАнализаДанныхПоискАссоциаций.Элемент;
	
	Анализ.Параметры.МинимальныйПроцентСлучаев.Значение = Константы.МинимальныйПроцентСлучаевНоменклатурыПродаваемойСовместно.Получить();
	Анализ.Параметры.МинимальнаяЗначимость.Значение     = Константы.МинимальнаяЗначимостьНоменклатурыПродаваемойСовместно.Получить();
	Анализ.Параметры.МинимальнаяДостоверность.Значение  = Константы.МинимальнаяДостоверностьНоменклатурыПродаваемойСовместно.Получить();
	Анализ.Параметры.ТипОтсеченияПравил.Значение = ТипОтсеченияПравилАссоциации.Покрытые;
	
	РезультатАнализа = Анализ.Выполнить();
	
	Возврат РезультатАнализа;
	
КонецФункции

Функция ОбновитьЗаписиРегистра(ВариантАнализа, РезультатАнализа)
	
	Набор = РегистрыСведений.НоменклатураПродаваемаяСовместно.СоздатьНаборЗаписей();
	Набор.Отбор.ДобавленоАвтоматически.Значение = Истина;
	Набор.Отбор.ДобавленоАвтоматически.Использование = Истина;
	Набор.Отбор.ВариантАнализа.Значение = ВариантАнализа;
	Набор.Отбор.ВариантАнализа.Использование = Истина;
	
	ТаблицаНабора = Набор.ВыгрузитьКолонки();
	ТаблицаНабора.Индексы.Добавить(
		"НоменклатураПредпосылка,
		|ХарактеристикаПредпосылка,
		|НоменклатураСледствие,
		|ХарактеристикаСледствие");
	
	Для Каждого Правило Из РезультатАнализа.Правила Цикл
		
		Если Правило.Предпосылка.Количество() = 1 Тогда
		
			Для Каждого Предпосылка Из Правило.Предпосылка Цикл
				
				Для Каждого Следствие Из Правило.Следствие Цикл
					
					Отбор = Новый Структура;
					Отбор.Вставить("НоменклатураПредпосылка", Предпосылка.Номенклатура.Значение);
					Отбор.Вставить("ХарактеристикаПредпосылка", Предпосылка.Характеристика.Значение);
					Отбор.Вставить("НоменклатураСледствие", Следствие.Номенклатура.Значение);
					Отбор.Вставить("ХарактеристикаСледствие", Следствие.Характеристика.Значение);
					
					Если ТаблицаНабора.НайтиСтроки(Отбор).Количество() = 0 Тогда
					
						Запись = ТаблицаНабора.Добавить();
						
						Запись.ВариантАнализа            = ВариантАнализа;
						Запись.ДобавленоАвтоматически    = Истина;
						
						Запись.НоменклатураПредпосылка   = Предпосылка.Номенклатура.Значение;
						Запись.ХарактеристикаПредпосылка = Предпосылка.Характеристика.Значение;
						Запись.НоменклатураСледствие     = Следствие.Номенклатура.Значение;
						Запись.ХарактеристикаСледствие   = Следствие.Характеристика.Значение;
						
						Запись.ПроцентСлучаев            = Правило.ПроцентСлучаев;
						Запись.КоличествоСлучаев         = Правило.КоличествоСлучаев;
					
					КонецЕсли;
					
				КонецЦикла;
				
			КонецЦикла;
		
		КонецЕсли;
		
	КонецЦикла;
	
	Набор.Загрузить(ТаблицаНабора);
	Набор.Записать();
	
КонецФункции

#КонецОбласти
