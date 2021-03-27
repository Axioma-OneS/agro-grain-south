﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Формирует отчет "Состояние выполнения документов" путем выполнения пакета запросов. 
// 
// Параметры:
// ТаблицаОтчета - ТабличныйДокумент - Табличный документ отчета.
// Отчет - ОтчетОбъект - Формируемый отчет.
// СписокДокументов - СписокЗначений - Список ссылок на документы.
//
Процедура СформироватьОтчетЖурналУчетаТМЦСданныхНаХранение(ТаблицаОтчета, Отчет, СписокДокументов) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	// Зададим параметры макета
	ТаблицаОтчета.АвтоМасштаб = Истина;
	ТаблицаОтчета.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	ТаблицаОтчета.ИмяПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_МХ2";
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Отчет.ЖурналУчетаТМЦСданныхНаХранение.ПФ_MXL_МХ2");
	
	// Выводим реквизиты шапки
	ЗаполнитьРеквизитыШапкиМХ2(Отчет, Макет, ТаблицаОтчета);
	
	// Выводим таблицу
	РезультатЗапроса = ПолучитьДанныеДляПечатнойФормыМХ2(Отчет, СписокДокументов);
	ЗаполнитьРеквизитыТаблицыМХ2(РезультатЗапроса, Макет, ТаблицаОтчета);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьРеквизитыШапкиМХ2(Отчет, Макет, ТаблицаОтчета)
	
	// Выводим общие реквизиты шапки
	СведенияОПоклажедержателе = ФормированиеПечатныхФорм.СведенияОЮрФизЛице(Отчет.Организация, Отчет.ДатаОкончания);
	
	ОбластьМакета = Макет.ПолучитьОбласть("Шапка");
	
	СтруктураПараметров = Новый Структура;
	СписокПараметров = "ПолноеНаименование,ЮридическийАдрес,Телефоны";
	СтруктураПараметров.Вставить("ПредставлениеПоклажедержателя", ФормированиеПечатныхФорм.ОписаниеОрганизации(
		СведенияОПоклажедержателе,
		СписокПараметров));
	СтруктураПараметров.Вставить("ПоклажедержательПоОКПО", СведенияОПоклажедержателе.КодПоОКПО);
	СтруктураПараметров.Вставить("ВидДеятельностиПоОКДП", СведенияОПоклажедержателе.КодОКВЭД);
	
	СтруктураПараметров.Вставить("НачальнаяДата", Формат(Отчет.ДатаНачала,"ДФ=дд"));
	СтруктураПараметров.Вставить("НачальнаяДатаМесяц", Формат(Отчет.ДатаНачала,"ДФ=ММММ"));
	СтруктураПараметров.Вставить("НачальнаяДатаГод", Формат(Отчет.ДатаНачала,"ДФ=гггг"));
	СтруктураПараметров.Вставить("КонечнаяДата", Формат(Отчет.ДатаОкончания,"ДФ=дд"));
	СтруктураПараметров.Вставить("КонечнаяДатаМесяц", Формат(Отчет.ДатаОкончания,"ДФ=ММММ"));
	СтруктураПараметров.Вставить("КонечнаяДатаГод", Формат(Отчет.ДатаОкончания,"ДФ=гггг"));
	
	ОбластьМакета.Параметры.Заполнить(СтруктураПараметров);
	ТаблицаОтчета.Вывести(ОбластьМакета);
	
КонецПроцедуры

Процедура ЗаполнитьРеквизитыТаблицыМХ2(ДанныеПечати, Макет, ТаблицаОтчета)
	
	ЗаголовокТаблицы = Макет.ПолучитьОбласть("ЗаголовокТаблицы");
	ТаблицаОтчета.Вывести(ЗаголовокТаблицы);
	ОбластьМакетаСтрока = Макет.ПолучитьОбласть("Строка");
	ОбластьИтоговПоСтранице = Макет.ПолучитьОбласть("Итого");
	
	НомерСтраницы   = 1;
	НомерСтроки = 0;
	
	// Создаем массив для проверки вывода
	МассивВыводимыхОбластей = Новый Массив;
	
	СтрокаТовары = ДанныеПечати.Выбрать();
	Пока СтрокаТовары.Следующий() Цикл
		
		Если СтрокаТовары.ИсточникИнформацииОЦенахДляПечати = Перечисления.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости Тогда
			Если СтрокаТовары.ПредварительныйРасчет = Null Тогда
				ТекстСообщения = НСтр("ru = 'Не удалось получить цены по себестоимости для документа %Документ%: на %Период% не произведен расчет себестоимости.'");
				
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Документ%", СтрокаТовары.Ссылка);
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Период%", Формат(НачалоМесяца(СтрокаТовары.ДатаДокумента),"ДЛФ=DD"));
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
				
				Продолжить;
				
			ИначеЕсли СтрокаТовары.ПредварительныйРасчет Тогда
				
				ТекстСообщения = НСтр("ru = 'При печати цен документа %Документ% использовались данные предварительного расчета себестоимости.'");
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Документ%", СтрокаТовары.Ссылка);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
				
			КонецЕсли;
		КонецЕсли;
		
		НомерСтроки = НомерСтроки + 1;
		СтруктураПараметров = Новый Структура("НомерСтроки", НомерСтроки);
		
		АдресСклада = ФормированиеПечатныхФорм.ПолучитьАдресИзКонтактнойИнформации(СтрокаТовары.Склад);
		ТелефонСклада = ФормированиеПечатныхФорм.ПолучитьТелефонИзКонтактнойИнформации(СтрокаТовары.Склад);
		СтруктураПараметров.Вставить("ПредставлениеСклада", Строка(СтрокаТовары.Склад) 
			+ ?(ЗначениеЗаполнено(АдресСклада), ", " + АдресСклада, "") 
			+ ?(ЗначениеЗаполнено(ТелефонСклада), ", " + ТелефонСклада, ""));
		СтруктураПараметров.Вставить("НомерДокументаПриема", ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(СтрокаТовары.НомерДокументаПриема));
		СтруктураПараметров.Вставить("НомерДокументаВозврата", ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(СтрокаТовары.НомерДокументаВозврата));
		
		ОбластьМакетаСтрока.Параметры.Заполнить(СтрокаТовары);
		ОбластьМакетаСтрока.Параметры.Заполнить(СтруктураПараметров);
		
		МассивВыводимыхОбластей.Очистить();
		МассивВыводимыхОбластей.Добавить(ОбластьМакетаСтрока);
		МассивВыводимыхОбластей.Добавить(ОбластьИтоговПоСтранице);
		
		Если НЕ ТаблицаОтчета.ПроверитьВывод(МассивВыводимыхОбластей) Тогда
			
			НомерСтраницы = НомерСтраницы + 1;
			ТаблицаОтчета.ВывестиГоризонтальныйРазделительСтраниц();
			
			ЗаголовокТаблицы.Параметры.Заполнить(Новый Структура("НомерСтраницы","Страница " + НомерСтраницы));
			ТаблицаОтчета.Вывести(ЗаголовокТаблицы);
		КонецЕсли;
		
		ТаблицаОтчета.Вывести(ОбластьМакетаСтрока);
		
	КонецЦикла;
	
	// Выводим итоги по последней странице
	ТаблицаОтчета.Вывести(ОбластьИтоговПоСтранице);
	
КонецПроцедуры

Функция ПолучитьДанныеДляПечатнойФормыМХ2(Отчет, СписокДокументов)
	
	КолонкаКодов = ФормированиеПечатныхФорм.ИмяДополнительнойКолонки();
	Если Не ЗначениеЗаполнено(КолонкаКодов) Тогда
		КолонкаКодов = "Код";
	КонецЕсли;
		
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	РасчетСебестоимостиТоваровОрганизации.Ссылка.ПредварительныйРасчет КАК ПредварительныйРасчет,
	|	ТоварыОрганизаций.Период КАК Период,
	|	КОНЕЦПЕРИОДА(ТоварыОрганизаций.Период, ДЕНЬ) КАК ДатаПолученияЦены,
	|	ТоварыОрганизаций.Регистратор КАК Ссылка,
	|	ТоварыОрганизаций.ВидДвижения КАК ВидДвижения,
	|	ТоварыОрганизаций.ВидЗапасов КАК ВидЗапасов,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ТоварыОрганизаций.Организация КАК Организация,
	|	ТоварыОрганизаций.Количество КАК Количество,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Номенклатура КАК Номенклатура,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Характеристика КАК Характеристика,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.МестоХранения КАК Склад,
	|	Склады.ИсточникИнформацииОЦенахДляПечати КАК ИсточникИнформацииОЦенахДляПечати,
	|	Склады.УчетныйВидЦены КАК ВидЦены,
	|	Склады.УчетныйВидЦены.ВалютаЦены КАК ВалютаЦены
	|ПОМЕСТИТЬ ВтТоварыОрганизаций
	|ИЗ
	|	РегистрНакопления.ТоварыОрганизаций КАК ТоварыОрганизаций
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РасчетСебестоимостиТоваров.Организации КАК РасчетСебестоимостиТоваровОрганизации
	|		ПО (РасчетСебестоимостиТоваровОрганизации.Ссылка.Дата МЕЖДУ НАЧАЛОПЕРИОДА(ТоварыОрганизаций.Период, МЕСЯЦ) И КОНЕЦПЕРИОДА(ТоварыОрганизаций.Период, МЕСЯЦ))
	|			И (РасчетСебестоимостиТоваровОрганизации.Ссылка.Проведен)
	|			И ТоварыОрганизаций.Организация = РасчетСебестоимостиТоваровОрганизации.Организация
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Склады КАК Склады
	|		ПО ТоварыОрганизаций.АналитикаУчетаНоменклатуры.МестоХранения = Склады.Ссылка
	|ГДЕ
	|	ТоварыОрганизаций.Период МЕЖДУ &ДатаНачала И &ДатаОкончания
	|	И Склады.Поклажедержатель = &Организация
	|	И ТоварыОрганизаций.Активность
	|	И ТоварыОрганизаций.Организация <> Склады.Поклажедержатель
	|	И НЕ ТИПЗНАЧЕНИЯ(ТоварыОрганизаций.Регистратор) В (&МассивЗапрещенныхТипов)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПериодыЦенНоменклатуры.Ссылка,
	|	ПериодыЦенНоменклатуры.Склад КАК Склад,
	|	ЦеныНоменклатуры.Номенклатура КАК Номенклатура,
	|	ЦеныНоменклатуры.Характеристика КАК Характеристика,
	|	ЦеныНоменклатуры.Цена,
	|	ЦеныНоменклатуры.Упаковка
	|ПОМЕСТИТЬ ЦеныПоВидуЦен
	|ИЗ
	|	(ВЫБРАТЬ
	|		Товары.Ссылка КАК Ссылка,
	|		Товары.Склад КАК Склад,
	|		ЦеныНоменклатуры.ВидЦены КАК ВидЦены,
	|		ЦеныНоменклатуры.Номенклатура КАК Номенклатура,
	|		ЦеныНоменклатуры.Характеристика КАК Характеристика,
	|		МАКСИМУМ(ЦеныНоменклатуры.Период) КАК Период
	|	ИЗ
	|		ВтТоварыОрганизаций КАК Товары
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры КАК ЦеныНоменклатуры
	|			ПО Товары.ВидЦены = ЦеныНоменклатуры.ВидЦены
	|				И Товары.Номенклатура = ЦеныНоменклатуры.Номенклатура
	|				И Товары.Характеристика = ЦеныНоменклатуры.Характеристика
	|				И Товары.ДатаПолученияЦены >= ЦеныНоменклатуры.Период
	|				И Товары.ВалютаЦены = ЦеныНоменклатуры.Валюта
	|	ГДЕ
	|		(Товары.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоВидуЦен)
	|				ИЛИ Товары.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|					И Товары.ПредварительныйРасчет ЕСТЬ NULL )
	|	
	|	СГРУППИРОВАТЬ ПО
	|		Товары.Ссылка,
	|		Товары.Склад,
	|		ЦеныНоменклатуры.ВидЦены,
	|		ЦеныНоменклатуры.Номенклатура,
	|		ЦеныНоменклатуры.Характеристика) КАК ПериодыЦенНоменклатуры
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры КАК ЦеныНоменклатуры
	|		ПО ПериодыЦенНоменклатуры.Период = ЦеныНоменклатуры.Период
	|			И ПериодыЦенНоменклатуры.ВидЦены = ЦеныНоменклатуры.ВидЦены
	|			И ПериодыЦенНоменклатуры.Номенклатура = ЦеныНоменклатуры.Номенклатура
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПериодыСтоимостиТоваров.Ссылка,
	|	СтоимостьТоваров.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	СтоимостьТоваров.ВидЗапасов КАК ВидЗапасов,
	|	СтоимостьТоваров.Организация КАК Организация,
	|	(СтоимостьТоваров.СтоимостьРегл
	|		+ СтоимостьТоваров.ДопРасходыРегл
	|		+ СтоимостьТоваров.ТрудозатратыРегл
	|		+ СтоимостьТоваров.ПостатейныеПостоянныеРегл
	|		+ СтоимостьТоваров.ПостатейныеПеременныеРегл) КАК Стоимость
	|ПОМЕСТИТЬ ЦеныПоСебестоимостиПредварительно
	|ИЗ
	|	(ВЫБРАТЬ
	|		ВидыЗапасов.Ссылка КАК Ссылка,
	|		СтоимостьТоваров.ВидЗапасов КАК ВидЗапасов,
	|		СтоимостьТоваров.Организация КАК Организация,
	|		СтоимостьТоваров.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|		МАКСИМУМ(СтоимостьТоваров.Период) КАК Период
	|	ИЗ
	|		ВтТоварыОрганизаций КАК ВидыЗапасов
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СтоимостьТоваров КАК СтоимостьТоваров
	|			ПО ВидыЗапасов.АналитикаУчетаНоменклатуры = СтоимостьТоваров.АналитикаУчетаНоменклатуры
	|				И ВидыЗапасов.Организация = СтоимостьТоваров.Организация
	|				И ВидыЗапасов.ВидЗапасов = СтоимостьТоваров.ВидЗапасов
	|				И ВидыЗапасов.ДатаПолученияЦены >= СтоимостьТоваров.Период
	|				И (ВидыЗапасов.ПредварительныйРасчет)
	|	ГДЕ
	|		ВидыЗапасов.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|		И ВидыЗапасов.ПредварительныйРасчет
	|	
	|	СГРУППИРОВАТЬ ПО
	|		ВидыЗапасов.Ссылка,
	|		СтоимостьТоваров.ВидЗапасов,
	|		СтоимостьТоваров.Организация,
	|		СтоимостьТоваров.АналитикаУчетаНоменклатуры) КАК ПериодыСтоимостиТоваров
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СтоимостьТоваров КАК СтоимостьТоваров
	|		ПО ПериодыСтоимостиТоваров.АналитикаУчетаНоменклатуры = СтоимостьТоваров.АналитикаУчетаНоменклатуры
	|			И ПериодыСтоимостиТоваров.Организация = СтоимостьТоваров.Организация
	|			И ПериодыСтоимостиТоваров.ВидЗапасов = СтоимостьТоваров.ВидЗапасов
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СебестоимостьТоваров.ДокументДвижения КАК Ссылка,
	|	СебестоимостьТоваров.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	СебестоимостьТоваров.ВидЗапасов КАК ВидЗапасов,
	|	СебестоимостьТоваров.Организация КАК Организация,
	|	СУММА(СебестоимостьТоваров.СтоимостьРегл
	|		+ СебестоимостьТоваров.ДопРасходыРегл
	|		+ СебестоимостьТоваров.ТрудозатратыРегл
	|		+ СебестоимостьТоваров.ПостатейныеПостоянныеРегл
	|		+ СебестоимостьТоваров.ПостатейныеПеременныеРегл) КАК Стоимость
	|ПОМЕСТИТЬ ЦеныПоСебестоимости
	|ИЗ
	|	РегистрНакопления.СебестоимостьТоваров КАК СебестоимостьТоваров
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТоварыОрганизаций КАК ВидыЗапасов
	|		ПО (ВидыЗапасов.Ссылка = СебестоимостьТоваров.ДокументДвижения)
	|			И (ВидыЗапасов.АналитикаУчетаНоменклатуры = СебестоимостьТоваров.АналитикаУчетаНоменклатуры)
	|			И (ВидыЗапасов.Организация = СебестоимостьТоваров.Организация)
	|			И (ВидыЗапасов.ВидЗапасов = СебестоимостьТоваров.ВидЗапасов)
	|			И (НЕ ВидыЗапасов.ПредварительныйРасчет)
	|ГДЕ
	|	ВидыЗапасов.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|	И НЕ ВидыЗапасов.ПредварительныйРасчет
	|
	|СГРУППИРОВАТЬ ПО
	|	СебестоимостьТоваров.ДокументДвижения,
	|	СебестоимостьТоваров.АналитикаУчетаНоменклатуры,
	|	СебестоимостьТоваров.ВидЗапасов,
	|	СебестоимостьТоваров.Организация
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Товары.Ссылка КАК Ссылка,
	|	Товары.Период КАК Период,
	|	Товары.ВидДвижения КАК ВидДвижения,
	|	Товары.Организация КАК Организация,
	|	Товары.ПредварительныйРасчет КАК ПредварительныйРасчет,
	|	Товары.ИсточникИнформацииОЦенахДляПечати КАК ИсточникИнформацииОЦенахДляПечати,
	|	Товары.Склад КАК Склад,
	|	ВЫБОР
	|		КОГДА &КолонкаКодов = ""Артикул""
	|			ТОГДА Товары.Номенклатура.Артикул
	|		ИНАЧЕ Товары.Номенклатура.Код
	|	КОНЕЦ КАК НоменклатураКод,
	|	Товары.Номенклатура КАК Номенклатура,
	|	Товары.Номенклатура.НаименованиеПолное КАК ПредставлениеНоменклатуры,
	|	Товары.Характеристика.НаименованиеПолное КАК ПредставлениеХарактеристики,
	|	Товары.Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмеренияНаименование,
	|	Товары.Количество КАК Количество,
	|	ВЫРАЗИТЬ(ЕСТЬNULL(Цены.Цена, 0) / ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки, 1) * Товары.Количество КАК ЧИСЛО(31,2)) КАК Сумма,
	|	ВЫРАЗИТЬ(ЕСТЬNULL(Цены.Цена, 0) / ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки, 1) КАК ЧИСЛО(31,2)) КАК Цена
	|ПОМЕСТИТЬ ВтТоварыСЦенами
	|ИЗ
	|	ВтТоварыОрганизаций КАК Товары
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЦеныПоВидуЦен КАК Цены
	|		ПО Товары.Ссылка = Цены.Ссылка
	|			И Товары.Номенклатура = Цены.Номенклатура
	|			И Товары.Характеристика = Цены.Характеристика
	|			И Товары.Склад = Цены.Склад
	|ГДЕ
	|	(Товары.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоВидуЦен)
	|			ИЛИ Товары.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|				И Товары.ПредварительныйРасчет ЕСТЬ NULL )
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВидыЗапасов.Ссылка,
	|	ВидыЗапасов.Период,
	|	ВидыЗапасов.ВидДвижения,
	|	ВидыЗапасов.Организация,
	|	ВидыЗапасов.ПредварительныйРасчет,
	|	ВидыЗапасов.ИсточникИнформацииОЦенахДляПечати,
	|	ВидыЗапасов.Склад,
	|	ВЫБОР
	|		КОГДА &КолонкаКодов = ""Артикул""
	|			ТОГДА ВидыЗапасов.Номенклатура.Артикул
	|		ИНАЧЕ ВидыЗапасов.Номенклатура.Код
	|	КОНЕЦ,
	|	ВидыЗапасов.Номенклатура,
	|	ВидыЗапасов.Номенклатура.НаименованиеПолное,
	|	ВидыЗапасов.Характеристика.НаименованиеПолное,
	|	ВидыЗапасов.Номенклатура.ЕдиницаИзмерения,
	|	ВидыЗапасов.Количество,
	|	Цены.Стоимость,
	|	ВЫБОР
	|		КОГДА ВидыЗапасов.Количество = 0
	|			ТОГДА Цены.Стоимость
	|		ИНАЧЕ Цены.Стоимость / ВидыЗапасов.Количество
	|	КОНЕЦ
	|ИЗ
	|	ВтТоварыОрганизаций КАК ВидыЗапасов
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЦеныПоСебестоимостиПредварительно КАК Цены
	|		ПО ВидыЗапасов.Ссылка = Цены.Ссылка
	|			И ВидыЗапасов.АналитикаУчетаНоменклатуры = Цены.АналитикаУчетаНоменклатуры
	|			И ВидыЗапасов.Организация = Цены.Организация
	|			И ВидыЗапасов.ВидЗапасов = Цены.ВидЗапасов
	|ГДЕ
	|	ВидыЗапасов.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|	И ВидыЗапасов.ПредварительныйРасчет
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВидыЗапасов.Ссылка,
	|	ВидыЗапасов.Период,
	|	ВидыЗапасов.ВидДвижения,
	|	ВидыЗапасов.Организация,
	|	ВидыЗапасов.ПредварительныйРасчет,
	|	ВидыЗапасов.ИсточникИнформацииОЦенахДляПечати,
	|	ВидыЗапасов.Склад,
	|	ВЫБОР
	|		КОГДА &КолонкаКодов = ""Артикул""
	|			ТОГДА ВидыЗапасов.Номенклатура.Артикул
	|		ИНАЧЕ ВидыЗапасов.Номенклатура.Код
	|	КОНЕЦ,
	|	ВидыЗапасов.Номенклатура,
	|	ВидыЗапасов.Номенклатура.НаименованиеПолное,
	|	ВидыЗапасов.Характеристика.НаименованиеПолное,
	|	ВидыЗапасов.Номенклатура.ЕдиницаИзмерения,
	|	ВидыЗапасов.Количество,
	|	Цены.Стоимость,
	|	ВЫБОР
	|		КОГДА ВидыЗапасов.Количество = 0
	|			ТОГДА Цены.Стоимость
	|		ИНАЧЕ Цены.Стоимость / ВидыЗапасов.Количество
	|	КОНЕЦ
	|ИЗ
	|	ВтТоварыОрганизаций КАК ВидыЗапасов
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЦеныПоСебестоимости КАК Цены
	|		ПО ВидыЗапасов.Ссылка = Цены.Ссылка
	|			И ВидыЗапасов.АналитикаУчетаНоменклатуры = Цены.АналитикаУчетаНоменклатуры
	|			И ВидыЗапасов.Организация = Цены.Организация
	|			И ВидыЗапасов.ВидЗапасов = Цены.ВидЗапасов
	|ГДЕ
	|	ВидыЗапасов.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|	И НЕ ВидыЗапасов.ПредварительныйРасчет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Товары.Ссылка,
	|	Товары.Ссылка.Дата КАК ДатаДокумента,
	|	Товары.ПредварительныйРасчет,
	|	Товары.ИсточникИнформацииОЦенахДляПечати,
	|	ВЫБОР
	|		КОГДА Товары.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|			ТОГДА Товары.Период
	|		ИНАЧЕ ""--""
	|	КОНЕЦ КАК ДатаПриемаТМЦ,
	|	Товары.Организация КАК Организация,
	|	Товары.Организация.НаименованиеСокращенное КАК ПредставлениеПоклажедателя,
	|	Товары.ПредставлениеНоменклатуры КАК ПредставлениеНоменклатуры,
	|	Товары.ПредставлениеХарактеристики КАК ПредставлениеХарактеристики,
	|	Товары.ЕдиницаИзмеренияНаименование КАК ЕдиницаИзмеренияНаименование,
	|	Товары.Количество КАК Количество,
	|	Товары.Цена КАК Цена,
	|	Товары.Сумма КАК Сумма,
	|	Товары.Склад КАК Склад,
	|	ВЫБОР
	|		КОГДА Товары.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|			ТОГДА Товары.Ссылка.Дата
	|		ИНАЧЕ ""--""
	|	КОНЕЦ КАК ДатаДокументаПриема,
	|	ВЫБОР
	|		КОГДА Товары.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|			ТОГДА Товары.Ссылка.Номер
	|		ИНАЧЕ ""--""
	|	КОНЕЦ КАК НомерДокументаПриема,
	|	ВЫБОР
	|		КОГДА Товары.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|			ТОГДА Товары.Ссылка.Дата
	|		ИНАЧЕ ""--""
	|	КОНЕЦ КАК ДатаДокументаВозврата,
	|	ВЫБОР
	|		КОГДА Товары.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|			ТОГДА Товары.Ссылка.Номер
	|		ИНАЧЕ ""--""
	|	КОНЕЦ КАК НомерДокументаВозврата,
	|	Товары.Склад.ТекущийОтветственный КАК МОЛ
	|ИЗ
	|	ВтТоварыСЦенами КАК Товары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Товары.Ссылка
	|ИЗ
	|	ВтТоварыОрганизаций КАК Товары
	|;
	|";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
		"&ТекстЗапросаКоэффициентУпаковки",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"Цены.Упаковка",
		"Цены.Номенклатура"));
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация",   Отчет.Организация);
	Запрос.УстановитьПараметр("ДатаНачала",    Отчет.ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", КонецДня(Отчет.ДатаОкончания));
	Запрос.УстановитьПараметр("КолонкаКодов", КолонкаКодов);
	
	МассивЗапрещенныхТипов = Новый Массив;
	МассивЗапрещенныхТипов.Добавить(Тип("ДокументСсылка.ВозвратТоваровМеждуОрганизациями"));
	МассивЗапрещенныхТипов.Добавить(Тип("ДокументСсылка.КорректировкаНазначенияТоваров"));
	МассивЗапрещенныхТипов.Добавить(Тип("ДокументСсылка.КорректировкаНалогообложенияНДСПартийТоваров"));
	МассивЗапрещенныхТипов.Добавить(Тип("ДокументСсылка.КорректировкаОбособленногоУчетаЗапасов"));
	МассивЗапрещенныхТипов.Добавить(Тип("ДокументСсылка.КорректировкаРегистров"));
	МассивЗапрещенныхТипов.Добавить(Тип("ДокументСсылка.ПередачаТоваровМеждуОрганизациями"));
	МассивЗапрещенныхТипов.Добавить(Тип("ДокументСсылка.ТаможеннаяДекларацияИмпорт"));

	Запрос.УстановитьПараметр("МассивЗапрещенныхТипов", МассивЗапрещенныхТипов);
	Запрос.Текст = ТекстЗапроса;
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	МассивДокументов = МассивРезультатов[6].Выгрузить().ВыгрузитьКолонку("Ссылка");
	СписокДокументов.ЗагрузитьЗначения(МассивДокументов);
	
	РезультатПоСкладам = МассивРезультатов[5];
	
	Возврат РезультатПоСкладам
	
КонецФункции

#КонецОбласти

#КонецЕсли