﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

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
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Товары.Период                     КАК Период,
	|	Товары.Регистратор                КАК Регистратор,
	|	Товары.ВидЗапасов                 КАК ВидЗапасов,
	|	Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	Товары.Валюта                     КАК Валюта,
	|	Товары.НомерГТД                   КАК НомерГТД,
	|
	|	Товары.Количество                 КАК Количество,
	|	Товары.СуммаВыручки               КАК СуммаВыручки,
	|	Товары.КоличествоСписано          КАК КоличествоСписано,
	|
	|	Товары.Количество                 КАК КоличествоКОформлению,
	|	Товары.СуммаВыручки               КАК СуммаВыручкиКОформлению,
	|	Товары.КоличествоСписано          КАК КоличествоСписаноКОформлению,
	|
	|	Товары.ХозяйственнаяОперация      КАК ХозяйственнаяОперация,
	|	Товары.СуммаВознаграждения        КАК СуммаВознаграждения,
	|	Товары.ДокументРеализации         КАК ДокументРеализации,
	|	Товары.ДатаСчетаФактуры           КАК ДатаСчетаФактуры,
	|	Товары.Покупатель                 КАК Покупатель,
	|	Товары.КорВидЗапасов              КАК КорВидЗапасов,
	|	Товары.Номенклатура               КАК Номенклатура,
	|	Товары.Характеристика             КАК Характеристика,
	|	Товары.НомерСчетаФактуры          КАК НомерСчетаФактуры
	|ПОМЕСТИТЬ ТоварыКОформлениюПередЗаписью
	|ИЗ
	|	РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК Товары
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
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ) КАК МЕСЯЦ,
	|	Таблица.Организация                  КАК Организация,
	|	Таблица.Регистратор                  КАК Документ,
	|	ИСТИНА                               КАК ИзмененыДанныеДляПартионногоУчетаВерсии21
	|ПОМЕСТИТЬ ТоварыКОформлениюОтчетовКомитентуЗаданияКРасчетуСебестоимости
	|ИЗ
	|	(ВЫБРАТЬ
	|		Товары.Период                     КАК Период,
	|		Товары.Регистратор                КАК Регистратор,
	|		ВидыЗапасов.Организация           КАК Организация,
	|		Товары.ВидЗапасов                 КАК ВидЗапасов,
	|		Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|		Товары.Валюта                     КАК Валюта,
	|		Товары.НомерГТД                   КАК НомерГТД,
	|
	|		Товары.Количество        КАК Количество,
	|		Товары.СуммаВыручки      КАК СуммаВыручки,
	|		Товары.КоличествоСписано КАК КоличествоСписано,
	|
	|		Товары.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|		Товары.СуммаВознаграждения   КАК СуммаВознаграждения,
	|		Товары.ДокументРеализации    КАК ДокументРеализации,
	|		Товары.ДатаСчетаФактуры      КАК ДатаСчетаФактуры,
	|		Товары.Покупатель            КАК Покупатель,
	|		Товары.КорВидЗапасов         КАК КорВидЗапасов,
	|		Товары.Номенклатура          КАК Номенклатура,
	|		Товары.Характеристика        КАК Характеристика,
	|		Товары.НомерСчетаФактуры     КАК НомерСчетаФактуры
	|	ИЗ
	|		ТоварыКОформлениюПередЗаписью КАК Товары
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыЗапасов КАК ВидыЗапасов
	|			ПО Товары.ВидЗапасов = ВидыЗапасов.Ссылка
	|	ГДЕ
	|		&ПартионныйУчетВключен
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		Товары.Период                     КАК Период,
	|		Товары.Регистратор                КАК Регистратор,
	|		ВидыЗапасов.Организация           КАК Организация,
	|		Товары.ВидЗапасов                 КАК ВидЗапасов,
	|		Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|		Товары.Валюта                     КАК Валюта,
	|		Товары.НомерГТД                   КАК НомерГТД,
	|
	|		-Товары.Количество        КАК Количество,
	|		-Товары.СуммаВыручки      КАК СуммаВыручки,
	|		-Товары.КоличествоСписано КАК КоличествоСписано,
	|
	|		Товары.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|		Товары.СуммаВознаграждения   КАК СуммаВознаграждения,
	|		Товары.ДокументРеализации    КАК ДокументРеализации,
	|		Товары.ДатаСчетаФактуры      КАК ДатаСчетаФактуры,
	|		Товары.Покупатель            КАК Покупатель,
	|		Товары.КорВидЗапасов         КАК КорВидЗапасов,
	|		Товары.Номенклатура          КАК Номенклатура,
	|		Товары.Характеристика        КАК Характеристика,
	|		Товары.НомерСчетаФактуры     КАК НомерСчетаФактуры
	|	ИЗ
	|		РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК Товары
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыЗапасов КАК ВидыЗапасов
	|			ПО Товары.ВидЗапасов = ВидыЗапасов.Ссылка
	|	ГДЕ
	|		Товары.Регистратор = &Регистратор
	|		И &ПартионныйУчетВключен
	|	) КАК Таблица
	|
	|СГРУППИРОВАТЬ ПО
	|	НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ),
	|	Таблица.Период,
	|	Таблица.Регистратор,
	|	Таблица.Организация,
	|	Таблица.ВидЗапасов,
	|	Таблица.АналитикаУчетаНоменклатуры,
	|	Таблица.Валюта,
	|	Таблица.НомерГТД,
	|	Таблица.ХозяйственнаяОперация,
	|	Таблица.СуммаВознаграждения,
	|	Таблица.ДокументРеализации,
	|	Таблица.ДатаСчетаФактуры,
	|	Таблица.Покупатель,
	|	Таблица.КорВидЗапасов,
	|	Таблица.Номенклатура,
	|	Таблица.Характеристика,
	|	Таблица.НомерСчетаФактуры
	|ИМЕЮЩИЕ
	|	СУММА(Таблица.Количество) <> 0
	|	ИЛИ СУММА(Таблица.СуммаВыручки) <> 0
	|	ИЛИ СУММА(Таблица.КоличествоСписано) <> 0
	|");
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ПартионныйУчетВключен", ДополнительныеСвойства.ДляПроведения.ПартионныйУчетВключен);
	
	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	
	ДополнительныеСвойства.ДляПроведения.Вставить("ИзмененыДанныеДляПартионногоУчетаВерсии21", Истина);
	
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	
	Запрос.Выполнить();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли