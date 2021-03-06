#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если НЕ ДополнительныеСвойства.Свойство("ДляПроведения") ИЛИ ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	БлокироватьДляИзменения = Истина;
	
	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Товары.Период                     КАК Период,
	|	Товары.Регистратор                КАК Регистратор,
	|	Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	Товары.Соглашение                 КАК Соглашение,
	|	Товары.Организация                КАК Организация,
	|	Товары.ВидЗапасов                 КАК ВидЗапасов,
	|	Товары.НомерГТД                   КАК НомерГТД,
	|
	|	Товары.Количество          КАК Количество,
	|	Товары.СуммаВыручки        КАК СуммаВыручки,
	|	Товары.СуммаВознаграждения КАК СуммаВознаграждения,
	|
	|	Товары.КорАналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|	Товары.ДокументРеализации            КАК ДокументРеализации,
	|	Товары.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|	Товары.НалогообложениеНДС            КАК НалогообложениеНДС,
	|	Товары.Номенклатура                  КАК Номенклатура,
	|	Товары.Характеристика                КАК Характеристика
	|ПОМЕСТИТЬ ТоварыПереданныеПередЗаписью
	|ИЗ
	|	РегистрНакопления.ТоварыПереданныеНаКомиссию КАК Товары
	|ГДЕ
	|	Товары.Регистратор = &Регистратор
	|	И &ПартионныйУчетВключен
	|");
	
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ПартионныйУчетВключен", ДополнительныеСвойства.ДляПроведения.ПартионныйУчетВключен);
	
	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Выполнить();
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ДополнительныеСвойства.Свойство("ДляПроведения") ИЛИ ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ) КАК МЕСЯЦ,
	|	Таблица.Организация                  КАК Организация,
	|	Таблица.Регистратор                  КАК Документ,
	|	ИСТИНА                               КАК ИзмененыДанныеДляПартионногоУчетаВерсии21
	|ПОМЕСТИТЬ ТоварыПереданныеНаКомиссиюЗаданияКРасчетуСебестоимости
	|ИЗ
	|	(ВЫБРАТЬ
	|		Товары.Период                     КАК Период,
	|		Товары.Регистратор                КАК Регистратор,
	|		Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|		Товары.Соглашение                 КАК Соглашение,
	|		Товары.Организация                КАК Организация,
	|		Товары.ВидЗапасов                 КАК ВидЗапасов,
	|		Товары.НомерГТД                   КАК НомерГТД,
	|
	|		Товары.Количество          КАК Количество,
	|		Товары.СуммаВыручки        КАК СуммаВыручки,
	|		Товары.СуммаВознаграждения КАК СуммаВознаграждения,
	|
	|		Товары.КорАналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|		Товары.ДокументРеализации            КАК ДокументРеализации,
	|		Товары.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|		Товары.НалогообложениеНДС            КАК НалогообложениеНДС,
	|		Товары.Номенклатура                  КАК Номенклатура,
	|		Товары.Характеристика                КАК Характеристика
	|	ИЗ
	|		ТоварыПереданныеПередЗаписью КАК Товары
	|	ГДЕ
	|		&ПартионныйУчетВключен
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		Товары.Период                     КАК Период,
	|		Товары.Регистратор                КАК Регистратор,
	|		Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|		Товары.Соглашение                 КАК Соглашение,
	|		Товары.Организация                КАК Организация,
	|		Товары.ВидЗапасов                 КАК ВидЗапасов,
	|		Товары.НомерГТД                   КАК НомерГТД,
	|
	|		-Товары.Количество          КАК Количество,
	|		-Товары.СуммаВыручки        КАК СуммаВыручки,
	|		-Товары.СуммаВознаграждения КАК СуммаВознаграждения,
	|
	|		Товары.КорАналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|		Товары.ДокументРеализации            КАК ДокументРеализации,
	|		Товары.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|		Товары.НалогообложениеНДС            КАК НалогообложениеНДС,
	|		Товары.Номенклатура                  КАК Номенклатура,
	|		Товары.Характеристика                КАК Характеристика
	|	ИЗ
	|		РегистрНакопления.ТоварыПереданныеНаКомиссию КАК Товары
	|	ГДЕ
	|		Товары.Регистратор = &Регистратор
	|		И &ПартионныйУчетВключен
	|	) КАК Таблица
	|
	|СГРУППИРОВАТЬ ПО
	|	НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ),
	|	Таблица.Период,
	|	Таблица.Регистратор,
	|	Таблица.АналитикаУчетаНоменклатуры,
	|	Таблица.Соглашение,
	|	Таблица.Организация,
	|	Таблица.ВидЗапасов,
	|	Таблица.НомерГТД,
	|	Таблица.КорАналитикаУчетаНоменклатуры,
	|	Таблица.ДокументРеализации,
	|	Таблица.ХозяйственнаяОперация,
	|	Таблица.НалогообложениеНДС,
	|	Таблица.Номенклатура,
	|	Таблица.Характеристика
	|ИМЕЮЩИЕ
	|	СУММА(Таблица.Количество) <> 0
	|	ИЛИ СУММА(Таблица.СуммаВыручки) <> 0
	|	ИЛИ СУММА(Таблица.СуммаВознаграждения) <> 0
	|");
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ПартионныйУчетВключен", ДополнительныеСвойства.ДляПроведения.ПартионныйУчетВключен);
	
	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	
	Запрос.Выполнить();
	
	ДополнительныеСвойства.ДляПроведения.Вставить("ИзмененыДанныеДляПартионногоУчетаВерсии21", Истина);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли