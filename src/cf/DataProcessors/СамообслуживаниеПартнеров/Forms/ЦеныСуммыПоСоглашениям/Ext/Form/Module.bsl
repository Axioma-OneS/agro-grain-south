﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("Партнер") Тогда
		Партнер = Параметры.Партнер;
	КонецЕсли;
	
	Если Параметры.Свойство("ДанныеКорзины") Тогда
		КорзинаПокупателя.Загрузить(Параметры.ДанныеКорзины.Выгрузить(,"Номенклатура,Характеристика,Упаковка,КоличествоУпаковок"));
	КонецЕсли;
	
	Если Параметры.Свойство("Валюта") Тогда
		Валюта = Параметры.Валюта;
	КонецЕсли;
	
	Если Параметры.Свойство(ЦенаВключаетНДС) Тогда
		ЦенаВключаетНДС = Параметры.ЦенаВключаетНДС;
	КонецЕсли;
	
	Если Параметры.Свойство(НалогообложениеНДС) Тогда
		НалогообложениеНДС = Параметры.НалогообложениеНДС;
	КонецЕсли;
	
	Валюта = ЗначениеНастроекПовтИсп.ПолучитьВалютуРегламентированногоУчета(Валюта);
	
	СформироватьНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сформировать(Команда)
	
	СформироватьНаСервере();
	
КонецПроцедуры 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ДокументСоглашениеСКлиентом.Ссылка,
	|	ДокументСоглашениеСКлиентом.Валюта,
	|	ДокументСоглашениеСКлиентом.Наименование,
	|	ДокументСоглашениеСКлиентом.Склад,
	|	ДокументСоглашениеСКлиентом.ЦенаВключаетНДС,
	|	ДокументСоглашениеСКлиентом.Контрагент,
	|	ЕСТЬNULL(ГрафикиОплаты.Наименование, """") КАК ГрафикОплатыНаименование,
	|	ГрафикиОплаты.Ссылка КАК ГрафикОплаты,
	|	ЕСТЬNULL(Склады.Наименование, &СтрокаБезОграничений) КАК СкладНаименование,
	|	ЕСТЬNULL(Контрагенты.Наименование, &СтрокаБезОграничений) КАК КонтрагентНаименование,
	|	ДокументСоглашениеСКлиентом.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	Валюты.Наименование КАК ВалютаНаименование
	|ПОМЕСТИТЬ ДоступныеСоглашенияПартнера
	|ИЗ
	|	Справочник.СоглашенияСКлиентами КАК ДокументСоглашениеСКлиентом
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ГрафикиОплаты КАК ГрафикиОплаты
	|		ПО ДокументСоглашениеСКлиентом.ГрафикОплаты = ГрафикиОплаты.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Склады КАК Склады
	|		ПО ДокументСоглашениеСКлиентом.Склад = Склады.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Контрагенты КАК Контрагенты
	|		ПО ДокументСоглашениеСКлиентом.Контрагент = Контрагенты.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Валюты КАК Валюты
	|		ПО ДокументСоглашениеСКлиентом.Валюта = Валюты.Ссылка
	|ГДЕ
	|	ДокументСоглашениеСКлиентом.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыСоглашенийСКлиентами.Действует)
	|	И (ДокументСоглашениеСКлиентом.Партнер = &Партнер
	|			ИЛИ ДокументСоглашениеСКлиентом.СегментПартнеров В
	|				(ВЫБРАТЬ
	|					ПартнерыСегмента.Сегмент
	|				ИЗ
	|					РегистрСведений.ПартнерыСегмента КАК ПартнерыСегмента
	|				ГДЕ
	|					ПартнерыСегмента.Партнер = &Партнер) ИЛИ (ДокументСоглашениеСКлиентом.Типовое
	|					И ДокументСоглашениеСКлиентом.СегментПартнеров = ЗНАЧЕНИЕ(Справочник.СегментыПартнеров.ПустаяСсылка)))
	|	И (ДокументСоглашениеСКлиентом.ДатаНачалаДействия = ДАТАВРЕМЯ(1, 1, 1)
	|			ИЛИ НАЧАЛОПЕРИОДА(&ТекущаяДата, ДЕНЬ) >= ДокументСоглашениеСКлиентом.ДатаНачалаДействия)
	|	И (ДокументСоглашениеСКлиентом.ДатаОкончанияДействия = ДАТАВРЕМЯ(1, 1, 1)
	|			ИЛИ НАЧАЛОПЕРИОДА(&ТекущаяДата, ДЕНЬ) <= ДокументСоглашениеСКлиентом.ДатаОкончанияДействия)
	|	И НЕ ДокументСоглашениеСКлиентом.ПометкаУдаления И ДокументСоглашениеСКлиентом.ДоступноВнешнимПользователям
	|	И ВЫБОР
	|		КОГДА &ТолькоТиповые = ИСТИНА
	|				И &ТолькоИндивидуальные = ЛОЖЬ
	|				И ДокументСоглашениеСКлиентом.Типовое
	|			ТОГДА ИСТИНА
	|		КОГДА &ТолькоИндивидуальные = ИСТИНА
	|				И НЕ &ТолькоТиповые = ИСТИНА
	|				И НЕ ДокументСоглашениеСКлиентом.Типовое
	|			ТОГДА ИСТИНА
	|		КОГДА &ТолькоТиповые = ЛОЖЬ
	|				И &ТолькоИндивидуальные = ЛОЖЬ
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫРАЗИТЬ (КорзинаПокупателя.Номенклатура КАК Справочник.Номенклатура) КАК Номенклатура,
	|	КорзинаПокупателя.Характеристика,
	|	КорзинаПокупателя.Упаковка,
	|	КорзинаПокупателя.ДатаПомещения,
	|	КорзинаПокупателя.КоличествоУпаковок
	|ПОМЕСТИТЬ КорзинаПокупателя
	|ИЗ
	|	&КорзинаПокупателя КАК КорзинаПокупателя
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КорзинаПокупателя.Номенклатура,
	|	КорзинаПокупателя.Характеристика,
	|	КорзинаПокупателя.Упаковка,
	|	КорзинаПокупателя.КоличествоУпаковок,
	|	КорзинаПокупателя.ДатаПомещения,
	|	ВЫБОР
	|		КОГДА СпрНоменклатура.СтавкаНДС = ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.НДС20)
	|			ТОГДА 0.20
	|		КОГДА СпрНоменклатура.СтавкаНДС = ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.НДС18)
	|			ТОГДА 0.18
	|		КОГДА СпрНоменклатура.СтавкаНДС = ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.НДС10)
	|			ТОГДА 0.1
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК ЗначениеСтавкиНДС,
	|	СпрНоменклатура.ЦеноваяГруппа,
	|	СпрНоменклатура.СтавкаНДС,
	|	ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки1, 0) КАК КоэффициентУпаковки
	|ПОМЕСТИТЬ ДанныеКорзины
	|ИЗ
	|	КорзинаПокупателя КАК КорзинаПокупателя
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СпрНоменклатура
	|		ПО КорзинаПокупателя.Номенклатура = СпрНоменклатура.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.УпаковкиЕдиницыИзмерения КАК УпаковкиНоменклатуры
	|		ПО КорзинаПокупателя.Упаковка = УпаковкиНоменклатуры.Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СоглашениеСКлиентом.Ссылка КАК Соглашение,
	|	СоглашениеСКлиентомТовары.Номенклатура,
	|	СоглашениеСКлиентомТовары.Характеристика,
	|	СоглашениеСКлиентомТовары.Упаковка,
	|	СоглашениеСКлиентомТовары.Цена,
	|	ЗНАЧЕНИЕ(Справочник.ВидыЦен.ПустаяСсылка) КАК ВидЦены,
	|	СоглашениеСКлиентом.Валюта КАК Валюта,
	|	СоглашениеСКлиентом.ЦенаВключаетНДС
	|ПОМЕСТИТЬ ЦенаПоТоваруСоглашение
	|ИЗ
	|	ДанныеКорзины КАК ДанныеКорзины
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СоглашенияСКлиентами.Товары КАК СоглашениеСКлиентомТовары
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СоглашенияСКлиентами КАК СоглашениеСКлиентом
	|			ПО СоглашениеСКлиентомТовары.Ссылка = СоглашениеСКлиентом.Ссылка
	|		ПО ДанныеКорзины.Номенклатура = СоглашениеСКлиентомТовары.Номенклатура
	|			И ДанныеКорзины.Характеристика = СоглашениеСКлиентомТовары.Характеристика
	|ГДЕ
	|	СоглашениеСКлиентомТовары.Ссылка В
	|			(ВЫБРАТЬ
	|				ДоступныеСоглашенияПартнера.Ссылка
	|			ИЗ
	|				ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера)
	|	И СоглашениеСКлиентомТовары.Цена > 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ДанныеКорзины.Номенклатура,
	|	ДанныеКорзины.Характеристика,
	|	СоглашениеСКлиентомТовары.ВидЦены,
	|	СоглашениеСКлиентом.Ссылка
	|ПОМЕСТИТЬ ВидЦеныУсловияСоглашения
	|ИЗ
	|	ДанныеКорзины КАК ДанныеКорзины
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СоглашенияСКлиентами.Товары КАК СоглашениеСКлиентомТовары
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СоглашенияСКлиентами КАК СоглашениеСКлиентом
	|			ПО СоглашениеСКлиентомТовары.Ссылка = СоглашениеСКлиентом.Ссылка
	|		ПО ДанныеКорзины.Номенклатура = СоглашениеСКлиентомТовары.Номенклатура
	|			И ДанныеКорзины.Характеристика = СоглашениеСКлиентомТовары.Характеристика
	|ГДЕ
	|	СоглашениеСКлиентомТовары.Цена = 0
	|	И СоглашениеСКлиентомТовары.Ссылка В
	|			(ВЫБРАТЬ
	|				ДоступныеСоглашенияПартнера.Ссылка
	|			ИЗ
	|				ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СоглашениеСКлиентомЦеновыеГруппы.Ссылка КАК ДокументСоглашение,
	|	ДанныеКорзины.Номенклатура,
	|	ДанныеКорзины.Характеристика,
	|	СоглашениеСКлиентомЦеновыеГруппы.ВидЦен
	|ПОМЕСТИТЬ ДанныеПоЦеновымГруппам
	|ИЗ
	|	ДанныеКорзины КАК ДанныеКорзины
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СоглашенияСКлиентами.ЦеновыеГруппы КАК СоглашениеСКлиентомЦеновыеГруппы
	|		ПО ДанныеКорзины.ЦеноваяГруппа = СоглашениеСКлиентомЦеновыеГруппы.ЦеноваяГруппа
	|ГДЕ
	|	СоглашениеСКлиентомЦеновыеГруппы.Ссылка В
	|			(ВЫБРАТЬ
	|				ДоступныеСоглашенияПартнера.Ссылка
	|			ИЗ
	|				ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ДанныеПоЦеновымГруппам.ДокументСоглашение,
	|	ДанныеПоЦеновымГруппам.Номенклатура,
	|	ДанныеПоЦеновымГруппам.Характеристика,
	|	ДанныеПоЦеновымГруппам.ВидЦен
	|ПОМЕСТИТЬ ВидЦеныПоЦеновойГруппе
	|ИЗ
	|	ДанныеПоЦеновымГруппам КАК ДанныеПоЦеновымГруппам
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЦенаПоТоваруСоглашение КАК ЦенаПоТовару
	|		ПО ДанныеПоЦеновымГруппам.ДокументСоглашение = ЦенаПоТовару.Соглашение
	|			И ДанныеПоЦеновымГруппам.Номенклатура = ЦенаПоТовару.Номенклатура
	|			И ДанныеПоЦеновымГруппам.Характеристика = ЦенаПоТовару.Характеристика
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВидЦеныУсловияСоглашения КАК ВидЦеныУсловияСоглашения
	|		ПО ДанныеПоЦеновымГруппам.Номенклатура = ВидЦеныУсловияСоглашения.Номенклатура
	|			И ДанныеПоЦеновымГруппам.Характеристика = ВидЦеныУсловияСоглашения.Характеристика
	|			И ДанныеПоЦеновымГруппам.ДокументСоглашение = ВидЦеныУсловияСоглашения.Ссылка
	|ГДЕ
	|	ДанныеПоЦеновымГруппам.ДокументСоглашение В
	|			(ВЫБРАТЬ
	|				ДоступныеСоглашенияПартнера.Ссылка
	|			ИЗ
	|				ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера)
	|	И ВидЦеныУсловияСоглашения.Номенклатура ЕСТЬ NULL 
	|	И ЦенаПоТовару.Номенклатура ЕСТЬ NULL 
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КурсыВалютСрезПоследних.Валюта,
	|	КурсыВалютСрезПоследних.Курс,
	|	КурсыВалютСрезПоследних.Кратность
	|ПОМЕСТИТЬ КурсыВалют
	|ИЗ
	|	РегистрСведений.КурсыВалют.СрезПоследних КАК КурсыВалютСрезПоследних
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ РАЗРЕШЕННЫЕ
	|	ДанныеКорзины.Номенклатура,
	|	ДанныеКорзины.Характеристика,
	|	СоглашениеСКлиентом.Ссылка,
	|	СоглашениеСКлиентом.ВидЦен
	|ПОМЕСТИТЬ ДанныеВидЦеныСоглашение
	|ИЗ
	|	ДанныеКорзины КАК ДанныеКорзины,
	|	Справочник.СоглашенияСКлиентами КАК СоглашениеСКлиентом
	|ГДЕ
	|	СоглашениеСКлиентом.Ссылка В
	|			(ВЫБРАТЬ
	|				ДоступныеСоглашенияПартнера.Ссылка
	|			ИЗ
	|				ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеВидЦеныСоглашение.Номенклатура,
	|	ДанныеВидЦеныСоглашение.Характеристика,
	|	ДанныеВидЦеныСоглашение.Ссылка,
	|	ДанныеВидЦеныСоглашение.ВидЦен
	|ПОМЕСТИТЬ ВидЦеныПоСоглашению
	|ИЗ
	|	ДанныеВидЦеныСоглашение КАК ДанныеВидЦеныСоглашение
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВидЦеныПоЦеновойГруппе КАК ВидЦеныПоЦеновойГруппе
	|		ПО ДанныеВидЦеныСоглашение.Номенклатура = ВидЦеныПоЦеновойГруппе.Номенклатура
	|			И ДанныеВидЦеныСоглашение.Характеристика = ВидЦеныПоЦеновойГруппе.Характеристика
	|			И ДанныеВидЦеныСоглашение.Ссылка = ВидЦеныПоЦеновойГруппе.ДокументСоглашение
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЦенаПоТоваруСоглашение КАК ЦенаПоТовару
	|		ПО ДанныеВидЦеныСоглашение.Номенклатура = ЦенаПоТовару.Номенклатура
	|			И ДанныеВидЦеныСоглашение.Характеристика = ЦенаПоТовару.Характеристика
	|			И ДанныеВидЦеныСоглашение.Ссылка = ЦенаПоТовару.Соглашение
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВидЦеныУсловияСоглашения КАК ВидЦеныУсловияСоглашения
	|		ПО ДанныеВидЦеныСоглашение.Номенклатура = ВидЦеныУсловияСоглашения.Номенклатура
	|			И ДанныеВидЦеныСоглашение.Характеристика = ВидЦеныУсловияСоглашения.Характеристика
	|			И ДанныеВидЦеныСоглашение.Ссылка = ВидЦеныУсловияСоглашения.Ссылка
	|ГДЕ
	|	ЦенаПоТовару.Номенклатура ЕСТЬ NULL 
	|	И ВидЦеныПоЦеновойГруппе.Номенклатура ЕСТЬ NULL 
	|	И ВидЦеныУсловияСоглашения.Номенклатура ЕСТЬ NULL 
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВидЦеныУсловияСоглашения.Ссылка КАК Соглашение,
	|	ВидЦеныУсловияСоглашения.Номенклатура,
	|	ВидЦеныУсловияСоглашения.Характеристика,
	|	ВидЦеныУсловияСоглашения.ВидЦены КАК ВидЦены
	|ПОМЕСТИТЬ ТоварыПоВидамЦен
	|ИЗ
	|	ВидЦеныУсловияСоглашения КАК ВидЦеныУсловияСоглашения
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВидЦеныПоЦеновойГруппе.ДокументСоглашение,
	|	ВидЦеныПоЦеновойГруппе.Номенклатура,
	|	ВидЦеныПоЦеновойГруппе.Характеристика,
	|	ВидЦеныПоЦеновойГруппе.ВидЦен
	|ИЗ
	|	ВидЦеныПоЦеновойГруппе КАК ВидЦеныПоЦеновойГруппе
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВидЦеныПоСоглашению.Ссылка,
	|	ВидЦеныПоСоглашению.Номенклатура,
	|	ВидЦеныПоСоглашению.Характеристика,
	|	ВидЦеныПоСоглашению.ВидЦен
	|ИЗ
	|	ВидЦеныПоСоглашению КАК ВидЦеныПоСоглашению
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ТоварыПоВидамЦен.Соглашение,
	|	ТоварыПоВидамЦен.Номенклатура,
	|	ТоварыПоВидамЦен.Характеристика,
	|	ТоварыПоВидамЦен.ВидЦены,
	|	МАКСИМУМ(ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Цена, 0)) КАК Цена,
	|	МАКСИМУМ(ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Валюта, ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка))) КАК Валюта,
	|	МАКСИМУМ(ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Упаковка, ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка))) КАК Упаковка
	|ПОМЕСТИТЬ ТоварыЦеныВВалютеЦен
	|ИЗ
	|	ТоварыПоВидамЦен КАК ТоварыПоВидамЦен
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера
	|		ПО ТоварыПоВидамЦен.Соглашение = ДоступныеСоглашенияПартнера.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(
	|				КОНЕЦПЕРИОДА(&ТекущаяДата, ДЕНЬ),
	|				Номенклатура В
	|						(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|							ТоварыПоВидамЦен.Номенклатура
	|						ИЗ
	|							ТоварыПоВидамЦен КАК ТоварыПоВидамЦен)
	|					И Характеристика В
	|						(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|							ТоварыПоВидамЦен.Характеристика
	|						ИЗ
	|							ТоварыПоВидамЦен КАК ТоварыПоВидамЦен)
	|					И ВидЦены В
	|						(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|							ТоварыПоВидамЦен.ВидЦены
	|						ИЗ
	|							ТоварыПоВидамЦен КАК ТоварыПоВидамЦен)) КАК ЦеныНоменклатурыСрезПоследних
	|		ПО ТоварыПоВидамЦен.Номенклатура = ЦеныНоменклатурыСрезПоследних.Номенклатура
	|			И ТоварыПоВидамЦен.Характеристика = ЦеныНоменклатурыСрезПоследних.Характеристика
	|			И ТоварыПоВидамЦен.ВидЦены = ЦеныНоменклатурыСрезПоследних.ВидЦены
	|
	|СГРУППИРОВАТЬ ПО
	|	ТоварыПоВидамЦен.Соглашение,
	|	ТоварыПоВидамЦен.Номенклатура,
	|	ТоварыПоВидамЦен.Характеристика,
	|	ТоварыПоВидамЦен.ВидЦены
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЦенаПоТоваруСоглашение.Соглашение,
	|	ЦенаПоТоваруСоглашение.Номенклатура,
	|	ЦенаПоТоваруСоглашение.Характеристика,
	|	ЦенаПоТоваруСоглашение.ВидЦены,
	|	ЦенаПоТоваруСоглашение.Цена,
	|	ЦенаПоТоваруСоглашение.Валюта,
	|	ЦенаПоТоваруСоглашение.Упаковка
	|ИЗ
	|	ЦенаПоТоваруСоглашение КАК ЦенаПоТоваруСоглашение
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ТоварыЦеныВВалютеЦен.Соглашение КАК Соглашение,
	|	ТоварыЦеныВВалютеЦен.Номенклатура КАК Номенклатура,
	|	ТоварыЦеныВВалютеЦен.Характеристика,
	|	ТоварыЦеныВВалютеЦен.Упаковка,
	|	ВЫБОР
	|		КОГДА &Валюта = ТоварыЦеныВВалютеЦен.Валюта
	|			ТОГДА ТоварыЦеныВВалютеЦен.Цена
	|		КОГДА ТоварыЦеныВВалютеЦен.Цена = 0
	|			ТОГДА 0
	|		ИНАЧЕ ТоварыЦеныВВалютеЦен.Цена * ВЫБОР
	|				КОГДА ЕСТЬNULL(КурсыВалют.Кратность, 0) > 0
	|						И ЕСТЬNULL(КурсыВалют.Курс, 0) > 0
	|						И ЕСТЬNULL(КурсыВалютВидЦены.Кратность, 0) > 0
	|						И ЕСТЬNULL(КурсыВалютВидЦены.Курс, 0) > 0
	|					ТОГДА КурсыВалютВидЦены.Курс * КурсыВалют.Кратность / (КурсыВалют.Курс * КурсыВалютВидЦены.Кратность)
	|				ИНАЧЕ 0
	|			КОНЕЦ
	|	КОНЕЦ КАК Цена,
	|	ТоварыЦеныВВалютеЦен.ВидЦены,
	|	ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки2, 0) КАК Коэффициент
	|ПОМЕСТИТЬ ВсеЦеныВВалютеОтчета
	|ИЗ
	|	ТоварыЦеныВВалютеЦен КАК ТоварыЦеныВВалютеЦен
	|		ЛЕВОЕ СОЕДИНЕНИЕ КурсыВалют КАК КурсыВалют
	|		ПО (&Валюта = КурсыВалют.Валюта)
	|		ЛЕВОЕ СОЕДИНЕНИЕ КурсыВалют КАК КурсыВалютВидЦены
	|		ПО ТоварыЦеныВВалютеЦен.Валюта = КурсыВалютВидЦены.Валюта
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.УпаковкиЕдиницыИзмерения КАК УпаковкиНоменклатуры
	|		ПО ТоварыЦеныВВалютеЦен.Упаковка = УпаковкиНоменклатуры.Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВсеЦеныВВалютеОтчета.Соглашение,
	|	ВсеЦеныВВалютеОтчета.Номенклатура,
	|	ВсеЦеныВВалютеОтчета.Характеристика,
	|	ВсеЦеныВВалютеОтчета.ВидЦены,
	|	ВЫБОР
	|		КОГДА ДанныеКорзины.КоэффициентУпаковки = ВсеЦеныВВалютеОтчета.Коэффициент
	|			ТОГДА ВсеЦеныВВалютеОтчета.Цена
	|		КОГДА ДанныеКорзины.КоэффициентУпаковки = 0
	|				И ВсеЦеныВВалютеОтчета.Коэффициент <> 0
	|			ТОГДА ВсеЦеныВВалютеОтчета.Цена / ВсеЦеныВВалютеОтчета.Коэффициент
	|		КОГДА ДанныеКорзины.КоэффициентУпаковки <> 0
	|				И ВсеЦеныВВалютеОтчета.Коэффициент = 0
	|			ТОГДА ВсеЦеныВВалютеОтчета.Цена * ДанныеКорзины.КоэффициентУпаковки
	|		ИНАЧЕ ВсеЦеныВВалютеОтчета.Цена / ВсеЦеныВВалютеОтчета.Коэффициент * ДанныеКорзины.КоэффициентУпаковки
	|	КОНЕЦ КАК Цена,
	|	ДанныеКорзины.Упаковка
	|ПОМЕСТИТЬ ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам
	|ИЗ
	|	ВсеЦеныВВалютеОтчета КАК ВсеЦеныВВалютеОтчета
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ДанныеКорзины КАК ДанныеКорзины
	|		ПО (ДанныеКорзины.Характеристика = ВсеЦеныВВалютеОтчета.Характеристика)
	|			И (ДанныеКорзины.Номенклатура = ВсеЦеныВВалютеОтчета.Номенклатура)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Соглашение КАК Соглашение,
	|	ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Номенклатура КАК Номенклатура,
	|	ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Характеристика КАК Характеристика,
	|	ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Упаковка КАК Упаковка,
	|	ВЫБОР
	|		КОГДА ДоступныеСоглашенияПартнера.ЦенаВключаетНДС = &ЦенаВключаетНДС
	|			ТОГДА ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена
	|		ИНАЧЕ ВЫБОР
	|				КОГДА ДоступныеСоглашенияПартнера.ЦенаВключаетНДС
	|						И (НЕ &ЦенаВключаетНДС)
	|					ТОГДА ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена * (1 / (1 + ДанныеКорзины.ЗначениеСтавкиНДС))
	|				ИНАЧЕ ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена * (1 + ДанныеКорзины.ЗначениеСтавкиНДС)
	|			КОНЕЦ
	|	КОНЕЦ КАК Цена,
	|	ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.ВидЦены,
	|	ДанныеКорзины.КоличествоУпаковок КАК КоличествоУпаковок,
	|	ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена * ДанныеКорзины.КоличествоУпаковок КАК Сумма,
	|	ВЫБОР
	|		КОГДА &НалогообложениеНДС = ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС)
	|			ТОГДА ДанныеКорзины.СтавкаНДС
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.БезНДС)
	|	КОНЕЦ КАК СтавкаНДС,
	|	ВЫБОР
	|		КОГДА &НалогообложениеНДС = ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС)
	|			ТОГДА ВЫБОР
	|					КОГДА ДоступныеСоглашенияПартнера.ЦенаВключаетНДС
	|						ТОГДА ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена * ДанныеКорзины.КоличествоУпаковок * ДанныеКорзины.ЗначениеСтавкиНДС / (1 + ДанныеКорзины.ЗначениеСтавкиНДС)
	|					ИНАЧЕ ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена * ДанныеКорзины.КоличествоУпаковок * ДанныеКорзины.ЗначениеСтавкиНДС
	|				КОНЕЦ
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК СуммаНДС,
	|	ДанныеКорзины.КоличествоУпаковок * ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена + ВЫБОР
	|		КОГДА &НалогообложениеНДС = ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС)
	|			ТОГДА ВЫБОР
	|					КОГДА ДоступныеСоглашенияПартнера.ЦенаВключаетНДС
	|						ТОГДА 0
	|					ИНАЧЕ ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Цена * ДанныеКорзины.КоличествоУпаковок * ДанныеКорзины.ЗначениеСтавкиНДС
	|				КОНЕЦ
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК СуммаВсего,
	|	ДанныеКорзины.Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения
	|ИЗ
	|	ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам КАК ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ДанныеКорзины КАК ДанныеКорзины
	|		ПО ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Номенклатура = ДанныеКорзины.Номенклатура
	|			И ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Характеристика = ДанныеКорзины.Характеристика
	|			И ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Упаковка = ДанныеКорзины.Упаковка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера
	|		ПО ТоварыКорзиныЦеныВалютаОтчетаПоУпаковкам.Соглашение = ДоступныеСоглашенияПартнера.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДоступныеСоглашенияПартнера.Наименование,
	|	ДанныеКорзины.ДатаПомещения
	|ИТОГИ ПО
	|	Номенклатура,
	|	Характеристика,
	|	Упаковка,
	|	ЕдиницаИзмерения,
	|	КоличествоУпаковок,
	|	Соглашение
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДоступныеСоглашенияПартнера.Ссылка КАК Ссылка,
	|	ДоступныеСоглашенияПартнера.Наименование КАК Наименование,
	|	ДоступныеСоглашенияПартнера.ХозяйственнаяОперация КАК ВидСоглашения,
	|	ДоступныеСоглашенияПартнера.ВалютаНаименование КАК Валюта,
	|	ДоступныеСоглашенияПартнера.СкладНаименование КАК Склад,
	|	ДоступныеСоглашенияПартнера.ГрафикОплатыНаименование КАК ГрафикОплаты,
	|	ДоступныеСоглашенияПартнера.ЦенаВключаетНДС,
	|	ДоступныеСоглашенияПартнера.КонтрагентНаименование КАК Контрагент,
	|	0 КАК Всего
	|ИЗ
	|	ДоступныеСоглашенияПартнера КАК ДоступныеСоглашенияПартнера
	|
	|УПОРЯДОЧИТЬ ПО
	|	Наименование";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТекстЗапросаКоэффициентУпаковки1",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
			"УпаковкиНоменклатуры",
			"СпрНоменклатура"));
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТекстЗапросаКоэффициентУпаковки2",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
			"УпаковкиНоменклатуры",
			"ТоварыЦеныВВалютеЦен.Номенклатура"));
		
	Таблица = КорзинаПокупателя.Выгрузить();
	Таблица.Свернуть("Номенклатура, Характеристика, Упаковка, ДатаПомещения", "КоличествоУпаковок");
	
	Запрос.УстановитьПараметр("Партнер",Партнер);
	Запрос.УстановитьПараметр("КорзинаПокупателя", Таблица);
	Запрос.УстановитьПараметр("ТекущаяДата",ТекущаяДатаСеанса());
	Запрос.УстановитьПараметр("Валюта",Валюта);
	Запрос.УстановитьПараметр("ЦенаВключаетНДС",ЦенаВключаетНДС);
	Запрос.УстановитьПараметр("НалогообложениеНДС",НалогообложениеНДС);
	Запрос.УстановитьПараметр("СтрокаБезОграничений",НСтр("ru = 'Без ограничений'"));
	
	ИспользоватьТиповыеСоглашенияСКлиентами			= ПолучитьФункциональнуюОпцию("ИспользоватьТиповыеСоглашенияСКлиентами");
	ИспользоватьИндивидуальныеСоглашенияСКлиентами	= ПолучитьФункциональнуюОпцию("ИспользоватьИндивидуальныеСоглашенияСКлиентами");
	ТолькоТиповые = ИспользоватьТиповыеСоглашенияСКлиентами И НЕ ИспользоватьИндивидуальныеСоглашенияСКлиентами;
	ТолькоИндивидуальные = НЕ ИспользоватьТиповыеСоглашенияСКлиентами И ИспользоватьИндивидуальныеСоглашенияСКлиентами;
	Запрос.УстановитьПараметр("ТолькоТиповые",ТолькоТиповые);
	Запрос.УстановитьПараметр("ТолькоИндивидуальные",ТолькоИндивидуальные);
	
	МассивРезультатовЗапросов = Запрос.ВыполнитьПакет();
	
	Если МассивРезультатовЗапросов[15].Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Если Не МассивРезультатовЗапросов[14].Пустой() Тогда
		ВывестиВТабличныйДокумент(МассивРезультатовЗапросов[14], МассивРезультатовЗапросов[15]);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ИмяУсловия(Имя)
	
	Если Имя = "ГрафикОплаты" Тогда
		Возврат НСтр("ru = 'График оплаты'");
	ИначеЕсли Имя = "НалогообложениеНДС" Тогда
		Возврат НСтр("ru = 'Налогообложение'");
	ИначеЕсли Имя = "ВидСоглашения" Тогда
		Возврат НСтр("ru = 'Вид соглашения'");
	ИначеЕсли Имя = "ЦенаВключаетНДС" Тогда
		Возврат НСтр("ru = 'Цена включает НДС'");
	Иначе
		Возврат Имя;
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ВывестиВТабличныйДокумент(РезультатЗапроса,РезультатЗапросаСоглашения)
	
	ТабличныйДокумент.Очистить();
	
	Макет = Обработки.СамообслуживаниеПартнеров.ПолучитьМакет("ЦеныИСуммыПоСоглашениям");
	
	ОбластьПустаяСтрока = Макет.ПолучитьОбласть("ПустаяСтрока");
	ОбластьПодзаголовок = Макет.ПолучитьОбласть("Подзаголовок|Заголовок");
	
	ТабличныйДокумент.Вывести(ОбластьПустаяСтрока);
	ОбластьПодзаголовок.Параметры.Текст = НСтр("ru='Условия, зависящие от соглашения'");
	ТабличныйДокумент.Вывести(ОбластьПодзаголовок);
	ТабличныйДокумент.Вывести(ОбластьПустаяСтрока);
	
	//УсловияСоглашения
	ОбластьШапкаУсловие     = Макет.ПолучитьОбласть("ШапкаУсловие|Условие");
	ОбластьШапкаСоглашение  = Макет.ПолучитьОбласть("ШапкаУсловие|СоглашениеУсловие");
	
	ОбластьСтрокаУсловие    = Макет.ПолучитьОбласть("СтрокаУсловие|Условие");
	ОбластьСтрокаСоглашение = Макет.ПолучитьОбласть("СтрокаУсловие|СоглашениеУсловие"); 
	
	ТабличныйДокумент.Вывести(ОбластьШапкаУсловие);
	ВыборкаСоглашения = РезультатЗапросаСоглашения.Выбрать();
	Пока ВыборкаСоглашения.Следующий() Цикл
		
		ОбластьШапкаСоглашение.Параметры.Соглашение = ВыборкаСоглашения.Наименование;
		ТабличныйДокумент.Присоединить(ОбластьШапкаСоглашение);
		
	КонецЦикла; 
	
	ТаблицаСоглашения = РезультатЗапросаСоглашения.Выгрузить();
	Для инд = 2 По ТаблицаСоглашения.Колонки.Количество()-2 Цикл
		
		ОбластьСтрокаУсловие.Параметры.Условие = ИмяУсловия(ТаблицаСоглашения.Колонки[инд].Имя);
		ТабличныйДокумент.Вывести(ОбластьСтрокаУсловие);
		
		Для индСоглашений = 0 По ТаблицаСоглашения.Количество() - 1 Цикл
			ОбластьСтрокаСоглашение.Параметры.ЗначениеУсловие = ТаблицаСоглашения[индСоглашений][инд];
			ТабличныйДокумент.Присоединить(ОбластьСтрокаСоглашение);
		КонецЦикла;
		
	КонецЦикла;
	
	ТабличныйДокумент.Вывести(ОбластьПустаяСтрока); 
	ОбластьПодзаголовок.Параметры.Текст = НСтр("ru='Цены и суммы в зависимости от соглашения'");
	ТабличныйДокумент.Вывести(ОбластьПодзаголовок);
	ТабличныйДокумент.Вывести(ОбластьПустаяСтрока);
	
	// Цены и суммы
	ИспользованиеХарактеристикНоменклатуры = ПолучитьФункциональнуюОпцию("ИспользоватьХарактеристикиНоменклатуры");
	
	ОбластьШапкаНоменклатура              = Макет.ПолучитьОбласть("Шапка|Номенклатура");
	ОбластьШапкаХарактеристика            = Макет.ПолучитьОбласть("Шапка|Характеристика");
	ОбластьШапкаУпаковкаКоличество        = Макет.ПолучитьОбласть("Шапка|УпаковкаКоличество");
	ОбластьШапкаСоглашение                = Макет.ПолучитьОбласть("Шапка|Соглашение");
	
	ОбластьСтрокаНоменклатура             = Макет.ПолучитьОбласть("Строка|Номенклатура");
	ОбластьСтрокаХарактеристика           = Макет.ПолучитьОбласть("Строка|Характеристика");
	ОбластьСтрокаУпаковкаКоличество       = Макет.ПолучитьОбласть("Строка|УпаковкаКоличество");
	ОбластьСтрокаСоглашение               = Макет.ПолучитьОбласть("Строка|Соглашение");
	
	ТабличныйДокумент.Вывести(ОбластьШапкаНоменклатура);
	Если ИспользованиеХарактеристикНоменклатуры Тогда
		ТабличныйДокумент.Присоединить(ОбластьШапкаХарактеристика);
	КонецЕсли;
	
	ТабличныйДокумент.Присоединить(ОбластьШапкаУпаковкаКоличество);
	ВыборкаСоглашения = РезультатЗапросаСоглашения.Выбрать();
	Пока ВыборкаСоглашения.Следующий() Цикл
		
		ОбластьШапкаСоглашение.Параметры.Соглашение = ВыборкаСоглашения.Наименование;
		ТабличныйДокумент.Присоединить(ОбластьШапкаСоглашение);
		
	КонецЦикла;
	
	НомерСтроки = 0;
	
	ВыборкаНоменклатура = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаНоменклатура.Следующий() Цикл
		ВыборкаХарактеристика = ВыборкаНоменклатура.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока ВыборкаХарактеристика.Следующий() Цикл
			ВыборкаУпаковка = ВыборкаХарактеристика.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
			Пока ВыборкаУпаковка.Следующий() Цикл
				ВыборкаЕдИзм = ВыборкаУпаковка.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
				Пока ВыборкаЕдИзм.Следующий() Цикл
					ВыборкаКоличество = ВыборкаЕдИзм.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
					Пока ВыборкаКоличество.Следующий() Цикл
						НомерСтроки = НомерСтроки + 1;
						ОбластьСтрокаНоменклатура.Параметры.НомерСтроки  = НомерСтроки;
						ОбластьСтрокаНоменклатура.Параметры.Номенклатура = ВыборкаНоменклатура.Номенклатура;
						ТабличныйДокумент.Вывести(ОбластьСтрокаНоменклатура);
						Если ИспользованиеХарактеристикНоменклатуры Тогда
							ОбластьСтрокаХарактеристика.Параметры.Характеристика = ВыборкаХарактеристика.Характеристика;
							ТабличныйДокумент.Присоединить(ОбластьСтрокаХарактеристика);
						КонецЕсли;
						ОбластьСтрокаУпаковкаКоличество.Параметры.Упаковка = ?(ВыборкаКоличество.Упаковка = Справочники.УпаковкиЕдиницыИзмерения.ПустаяСсылка(),
						                                                       ВыборкаКоличество.ЕдиницаИзмерения,
						                                                       Строка(ВыборкаКоличество.Упаковка)+ ","+ Строка(ВыборкаКоличество.ЕдиницаИзмерения));
						ОбластьСтрокаУпаковкаКоличество.Параметры.Количество = ВыборкаКоличество.КоличествоУпаковок;
						ТабличныйДокумент.Присоединить(ОбластьСтрокаУпаковкаКоличество);
						ВыборкаСоглашение = ВыборкаКоличество.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
						Пока ВыборкаСоглашение.Следующий() Цикл
							ТекущаяСтрокаТаблицаСоглашений = ТаблицаСоглашения.Найти(ВыборкаСоглашение.Соглашение,"Ссылка");
							ВыборкаДетали = ВыборкаСоглашение.Выбрать();
							Пока ВыборкаДетали.Следующий() Цикл 
								ОбластьСтрокаСоглашение.Параметры.Цена 	= ВыборкаДетали.Цена;
								ОбластьСтрокаСоглашение.Параметры.Всего = ВыборкаДетали.СуммаВсего;
								ТекущаяСтрокаТаблицаСоглашений.Всего	= ТекущаяСтрокаТаблицаСоглашений.Всего + ВыборкаДетали.СуммаВсего;
								ТабличныйДокумент.Присоединить(ОбластьСтрокаСоглашение);
							КонецЦикла;
						КонецЦикла;
					КонецЦикла;
				КонецЦикла;
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
	
	ОбластьИтогоНоменклатура              = Макет.ПолучитьОбласть("Итого|Номенклатура");
	ОбластьИтогоХарактеристика            = Макет.ПолучитьОбласть("Итого|Характеристика");
	ОбластьИтогоУпаковкаКоличество        = Макет.ПолучитьОбласть("Итого|УпаковкаКоличество");
	ОбластьИтогоСоглашение                = Макет.ПолучитьОбласть("Итого|Соглашение");
	
	ТабличныйДокумент.Вывести(ОбластьИтогоНоменклатура);
	Если ИспользованиеХарактеристикНоменклатуры Тогда
		ТабличныйДокумент.Присоединить(ОбластьИтогоХарактеристика);
	КонецЕсли;
	
	ТабличныйДокумент.Присоединить(ОбластьИтогоУпаковкаКоличество);
	Для каждого СтрокаТаблицыСоглашения Из ТаблицаСоглашения Цикл
	
		ОбластьИтогоСоглашение.Параметры.Всего = СтрокаТаблицыСоглашения.Всего;
		ТабличныйДокумент.Присоединить(ОбластьИтогоСоглашение);
	
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
