﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает полные данные классификатора видов меха.
//
// Возвращаемое значение:
//     ТаблицаЗначений - данные классификатора с колонками:
//         * Код          - Строка - Код элемента классификатора
//         * Наименование - Строка - Наименование вида меха
//         * Код ТНВЭД    - Строка - Код ТНВЭД.
//
// Таблица значений проиндексирована по полям "Код", "Наименование".
//
Функция ТаблицаКлассификатора() Экспорт
	
	Макет = Справочники.ВидыМехаГИСМ.ПолучитьМакет("ДанныеКлассификатора");
	
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(Макет.ПолучитьТекст());
	
	Возврат СериализаторXDTO.ПрочитатьXML(Чтение);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ТаблицаСоответствийВидовМехаПриПереходеНаФорматОбмена2_41() Экспорт
	
	ОписаниеТипаСтрока2 = Новый ОписаниеТипов("Строка",,Новый КвалификаторыСтроки(2, ДопустимаяДлина.Переменная));
	ОписаниеТипаСтрока150 = Новый ОписаниеТипов("Строка",,Новый КвалификаторыСтроки(150, ДопустимаяДлина.Переменная));
	
	ТаблицаСоответствий = Новый ТаблицаЗначений;
	ТаблицаСоответствий.Колонки.Добавить("КодНовый", ОписаниеТипаСтрока2);
	ТаблицаСоответствий.Колонки.Добавить("НаименованиеНовый", ОписаниеТипаСтрока150);
	ТаблицаСоответствий.Колонки.Добавить("КодСтарый", ОписаниеТипаСтрока2);
	ТаблицаСоответствий.Колонки.Добавить("НаименованиеСтарый", ОписаниеТипаСтрока150);
	
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "1",  НСтр("ru = 'ондатра'"), "74", НСтр("ru = 'ондатра'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "2",  НСтр("ru = 'шкура молодого теленка до 3-х месяцев (опойка)'"), "37", НСтр("ru = 'опоек (теленок)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "3",  НСтр("ru = 'соболь'"), "10", НСтр("ru = 'соболь'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "4",  НСтр("ru = 'шиншила'"), "77", НСтр("ru = 'шиншилла (вискача)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "5",  НСтр("ru = 'бобр, бобер'"), "73", НСтр("ru = 'бобр'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "6",  НСтр("ru = 'рысь'"), "19", НСтр("ru = 'рысь, рысевидная кошка'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "7",  НСтр("ru = 'козлик, козел, козленок'"), "43", НСтр("ru = 'козлик'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "9",  НСтр("ru = 'морской котик'"), "61", НСтр("ru = 'морской котик'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "10", НСтр("ru = 'кенгуру'") , "54", НСтр("ru = 'кенгуру, валлаби'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "11", НСтр("ru = 'олень'") , "45", НСтр("ru = 'олень'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "12", НСтр("ru = 'овчина'"), "08", НСтр("ru = 'овчина (любых пород)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "13", НСтр("ru = 'лисица'"), "03", НСтр("ru = 'лисица (в том числе красная, крестовка, корсак, серебристо-черная, черно-бурая, снежная, фенек)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "14", НСтр("ru = 'хорек'"), "72", НСтр("ru = 'хорь'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "16", НСтр("ru = 'ласка'"), "17", НСтр("ru = 'ласка'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "17", НСтр("ru = 'лама'"), "39", НСтр("ru = 'лама, гуанако, альпака, викунья'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "18", НСтр("ru = 'койот'"), "32", НСтр("ru = 'койот'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "19", НСтр("ru = 'скунс'"), "80", НСтр("ru = 'скунс'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "20", НСтр("ru = 'куница'"), "11", НСтр("ru = 'куница'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "21", НСтр("ru = 'волк'"), "30", НСтр("ru = 'волк'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "22", НСтр("ru = 'сурок'"), "65", НСтр("ru = 'сурок (тарбаган и прочие)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "23", НСтр("ru = 'орилаг (кролик)'"), "06", НСтр("ru = 'кролик (в том числе рекс-реббит, орилаг и прочие)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "24", НСтр("ru = 'белка'"), "63", НСтр("ru = 'белка'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "25", НСтр("ru = 'ягненок'"), "09", НСтр("ru = 'каракуль, каракульча, ягненок (любых пород)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "27", НСтр("ru = 'мех пекана'"), "18", НСтр("ru = 'фишер (илка, пекан)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "28", НСтр("ru = 'бычья шкура'"), "36", НСтр("ru = 'КРС (крупный рогатый скот: коровы, быки, буйволы, волы и т.д)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "29", НСтр("ru = 'енотовидная собака'"), "07", НСтр("ru = 'енот (енот полоскун, енотовидная собака)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "32", НСтр("ru = 'каракуль'"), "09", НСтр("ru = 'каракуль, каракульча, ягненок (любых пород)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "33", НСтр("ru = 'опоссум'"), "79", НСтр("ru = 'опоссум'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "34", НСтр("ru = 'альпака'"), "39", НСтр("ru = 'лама, гуанако, альпака, викунья'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "35", НСтр("ru = 'оцелот'"), "21", НСтр("ru = 'оцелот'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "36", НСтр("ru = 'хомяк'"), "70", НСтр("ru = 'хомяк'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "37", НСтр("ru = 'нерпа'"), "60", НСтр("ru = 'нерпа (тюленевые)'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "38", НСтр("ru = 'мех пони'"), "42", НСтр("ru = 'пони'"));
	ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, "39", НСтр("ru = 'мех кошки домашней'"), "28", НСтр("ru = 'домашняя кошка'"));
	
	Возврат ТаблицаСоответствий;
	
КонецФункции

Процедура ДобавитьСтрокуВТаблицуСоответствийВидовМехаПриПереходеНаФорматОбмена2_41(ТаблицаСоответствий, КодНовый, НаименованиеНовый, КодСтарый, НаименованиеСтарый)
	
	НоваяСтрока = ТаблицаСоответствий.Добавить();
	НоваяСтрока.КодНовый           = КодНовый;
	НоваяСтрока.НаименованиеНовый  = НаименованиеНовый;
	НоваяСтрока.КодСтарый          = КодСтарый;
	НоваяСтрока.НаименованиеСтарый = НаименованиеСтарый;
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Обработчик обновления библиотеки ГИСМ 1.0.2
// Заменяет созданные элементы справочника "Виды меха" на данные нового классификатора
// Если элемент справочника отсутствует в новом классификаторе, то такой элемент помечается на удаление.
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ТаблицаСоответствий = Справочники.ВидыМехаГИСМ.ТаблицаСоответствийВидовМехаПриПереходеНаФорматОбмена2_41();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ТаблицаСоответствий.КодНовый КАК КодНовый,
	|	ТаблицаСоответствий.НаименованиеНовый КАК НаименованиеНовый,
	|	ТаблицаСоответствий.КодСтарый КАК КодСтарый,
	|	ТаблицаСоответствий.НаименованиеСтарый КАК НаименованиеСтарый
	|ПОМЕСТИТЬ ТаблицаСоответствий
	|ИЗ
	|	&ТаблицаСоответствий КАК ТаблицаСоответствий
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВидыМехаГИСМ.Ссылка
	|ПОМЕСТИТЬ ЭлементыСтарогоКлассификатора
	|ИЗ
	|	Справочник.ВидыМехаГИСМ КАК ВидыМехаГИСМ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТаблицаСоответствий КАК ТаблицаСоответствий
	|		ПО ВидыМехаГИСМ.Наименование = ТаблицаСоответствий.НаименованиеСтарый
	|			И ВидыМехаГИСМ.Код = ТаблицаСоответствий.КодСтарый
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВидыМехаГИСМ.Ссылка
	|ИЗ
	|	Справочник.ВидыМехаГИСМ КАК ВидыМехаГИСМ
	|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаСоответствий КАК ТаблицаСоответствий
	|		ПО (ВидыМехаГИСМ.Код = ТаблицаСоответствий.КодНовый
	|				И ВидыМехаГИСМ.Наименование = ТаблицаСоответствий.НаименованиеНовый)
	|ГДЕ
	|	НЕ ВидыМехаГИСМ.Ссылка В
	|				(ВЫБРАТЬ
	|					ЭлементыСтарогоКлассификатора.Ссылка
	|				ИЗ
	|					ЭлементыСтарогоКлассификатора КАК ЭлементыСтарогоКлассификатора)
	|	И ТаблицаСоответствий.КодНовый ЕСТЬ NULL
	|	И (НЕ ВидыМехаГИСМ.ПометкаУдаления
	|			ИЛИ ВидыМехаГИСМ.Код = """")
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЭлементыСтарогоКлассификатора.Ссылка
	|ИЗ
	|	ЭлементыСтарогоКлассификатора КАК ЭлементыСтарогоКлассификатора";
	
	Запрос.УстановитьПараметр("ТаблицаСоответствий", ТаблицаСоответствий);

	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяОбъекта = "Справочник.ВидыМехаГИСМ";
	МетаданныеОбъекта = Метаданные.Справочники.ВидыМехаГИСМ;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Результат = ОбновлениеИнформационнойБазы.СоздатьВременнуюТаблицуСсылокДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта, МенеджерВременныхТаблиц);
	
	Если НЕ Результат.ЕстьДанныеДляОбработки Тогда
		Параметры.ОбработкаЗавершена = Истина;
		Возврат;
	КонецЕсли;
	Если НЕ Результат.ЕстьЗаписиВоВременнойТаблице Тогда
		Параметры.ОбработкаЗавершена = Ложь;
		Возврат;
	КонецЕсли;
	
	ТаблицаСоответствий = Справочники.ВидыМехаГИСМ.ТаблицаСоответствийВидовМехаПриПереходеНаФорматОбмена2_41();
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ТаблицаСоответствий.КодНовый КАК КодНовый,
	|	ТаблицаСоответствий.НаименованиеНовый КАК НаименованиеНовый,
	|	ТаблицаСоответствий.КодСтарый КАК КодСтарый,
	|	ТаблицаСоответствий.НаименованиеСтарый КАК НаименованиеСтарый
	|ПОМЕСТИТЬ ТаблицаСоответствий
	|ИЗ
	|	&ТаблицаСоответствий КАК ТаблицаСоответствий
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////1
	|ВЫБРАТЬ
	|	ВидыМехаГИСМ.Ссылка,
	|	ВидыМехаГИСМ.ВерсияДанных,
	|	ТаблицаСоответствий.КодНовый,
	|	ТаблицаСоответствий.НаименованиеНовый
	|ПОМЕСТИТЬ ЭлементыСтарогоКлассификатора
	|ИЗ
	|	&ВТДокументыДляОбработки КАК СсылкиДляОбработки
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыМехаГИСМ КАК ВидыМехаГИСМ
	|		ПО СсылкиДляОбработки.Ссылка = ВидыМехаГИСМ.Ссылка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТаблицаСоответствий КАК ТаблицаСоответствий
	|		ПО (ВидыМехаГИСМ.Наименование = ТаблицаСоответствий.НаименованиеСтарый)
	|			И (ВидыМехаГИСМ.Код = ТаблицаСоответствий.КодСтарый)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////2
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВидыМехаГИСМ.Ссылка,
	|	ВидыМехаГИСМ.ВерсияДанных,
	|	ЛОЖЬ КАК БудетЗаменен,
	|	"""" КАК КодНовый,
	|	"""" КАК НаименованиеНовый
	|
	|ИЗ
	|	&ВТДокументыДляОбработки КАК СсылкиДляОбработки
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыМехаГИСМ КАК ВидыМехаГИСМ
	|		ПО СсылкиДляОбработки.Ссылка = ВидыМехаГИСМ.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаСоответствий КАК ТаблицаСоответствий
	|		ПО ВидыМехаГИСМ.Код = ТаблицаСоответствий.КодНовый
	|			И ВидыМехаГИСМ.Наименование = ТаблицаСоответствий.НаименованиеНовый
	|ГДЕ
	|	НЕ ВидыМехаГИСМ.Ссылка В
	|				(ВЫБРАТЬ
	|					ЭлементыСтарогоКлассификатора.Ссылка
	|				ИЗ
	|					ЭлементыСтарогоКлассификатора КАК ЭлементыСтарогоКлассификатора)
	|	И ТаблицаСоответствий.КодНовый ЕСТЬ NULL
	|	И (НЕ ВидыМехаГИСМ.ПометкаУдаления
	|			ИЛИ ВидыМехаГИСМ.Код = """")
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЭлементыСтарогоКлассификатора.Ссылка,
	|	ЭлементыСтарогоКлассификатора.ВерсияДанных,
	|	ИСТИНА,
	|	ЭлементыСтарогоКлассификатора.КодНовый,
	|	ЭлементыСтарогоКлассификатора.НаименованиеНовый
	|ИЗ
	|	ЭлементыСтарогоКлассификатора КАК ЭлементыСтарогоКлассификатора
	|";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ВТДокументыДляОбработки", Результат.ИмяВременнойТаблицы);
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("ТаблицаСоответствий", ТаблицаСоответствий);
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			Блокировка.Заблокировать();
			
			ВидМехаОбъект = ОбновлениеИнформационнойБазыГИСМ.ПроверитьПолучитьОбъект(Выборка.Ссылка,
			                                                                         Выборка.ВерсияДанных,
			                                                                         Параметры.Очередь);
			
			Если ВидМехаОбъект = Неопределено Тогда
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Выборка.Ссылка,, Параметры.Очередь);
				ЗафиксироватьТранзакцию();
				Продолжить;
			КонецЕсли;
			
			Если Выборка.БудетЗаменен Тогда
				
				ВидМехаОбъект.Наименование = Выборка.НаименованиеНовый;
				ВидМехаОбъект.Код          = Выборка.КодНовый;
				ВидМехаОбъект.КодТНВЭД     = "4303109080";
				
			Иначе
				
				ВидМехаОбъект.Наименование    = НСтр("ru = 'Не действителен'");
				ВидМехаОбъект.Код             = "00";
				ВидМехаОбъект.КодТНВЭД        = "0000000000";
				ВидМехаОбъект.ПометкаУдаления = Истина;
				
			КонецЕсли;
			
			ОбновлениеИнформационнойБазы.ЗаписатьОбъект(ВидМехаОбъект, Истина);
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ТекстСообщения = НСтр("ru = 'Не удалось обработать справочник: %Справочник% по причине: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Справочник%", Выборка.Ссылка);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			                         УровеньЖурналаРегистрации.Предупреждение,
			                         МетаданныеОбъекта,
			                         Выборка.Ссылка,
			                         ТекстСообщения);
			Продолжить;
			
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли