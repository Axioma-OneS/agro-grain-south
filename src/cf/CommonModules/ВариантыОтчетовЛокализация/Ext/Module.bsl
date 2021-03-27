﻿#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Настройки размещения отчетов
// см. ОбщийМодуль.ВариантыОтчетовПереопределяемый.ОпределитьРазделыСВариантамиОтчетов()
//
Процедура ОпределитьРазделыСВариантамиОтчетов(Разделы) Экспорт
	
	//++ Локализация
		
	//-- Локализация
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Настройки команд отчетов
// см. ОбщийМодуль.ВариантыОтчетовПереопределяемый.ОпределитьОбъектыСКомандамиОтчетов()
//
Процедура ОпределитьОбъектыСКомандамиОтчетов(Объекты) Экспорт
	
	//++ Локализация
	Объекты.Добавить(Метаданные.Документы.АннулированиеПодарочныхСертификатов);
	Объекты.Добавить(Метаданные.Документы.ВнесениеДенежныхСредствВКассуККМ);
	Объекты.Добавить(Метаданные.Документы.ВозвратПодарочныхСертификатов);
	Объекты.Добавить(Метаданные.Документы.ВыемкаДенежныхСредствИзКассыККМ);
	Объекты.Добавить(Метаданные.Документы.ЗапросКоммерческогоПредложенияОтКлиента);
	Объекты.Добавить(Метаданные.Документы.ЗапросКоммерческихПредложенийПоставщиков);
	Объекты.Добавить(Метаданные.Документы.КоммерческоеПредложениеПоставщика);
	Объекты.Добавить(Метаданные.Документы.ЛистКассовойКниги);
	Объекты.Добавить(Метаданные.Документы.ОперацияПоЯндексКассе);
	Объекты.Добавить(Метаданные.Документы.РеализацияПодарочныхСертификатов);
	Объекты.Добавить(Метаданные.Документы.ТранспортнаяНакладная);
	Объекты.Добавить(Метаданные.Документы.ЧекККМ);
	Объекты.Добавить(Метаданные.Документы.ЧекККМВозврат);
	Объекты.Добавить(Метаданные.Документы.ЧекККМКоррекции);
	
	
	
	// ИнтеграцияГИСМ
	Объекты.Добавить(Метаданные.Документы.ЗаявкаНаВыпускКиЗГИСМ);
	Объекты.Добавить(Метаданные.Документы.МаркировкаТоваровГИСМ);
	Объекты.Добавить(Метаданные.Документы.ЗапросАкцизныхМарокЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ПеремаркировкаТоваровГИСМ);
	Объекты.Добавить(Метаданные.Документы.УведомлениеОбИмпортеМаркированныхТоваровГИСМ);
	Объекты.Добавить(Метаданные.Документы.УведомлениеОбОтгрузкеМаркированныхТоваровГИСМ);
	Объекты.Добавить(Метаданные.Документы.УведомлениеОВвозеМаркированныхТоваровИзЕАЭСГИСМ);
	Объекты.Добавить(Метаданные.Документы.УведомлениеОПоступленииМаркированныхТоваровГИСМ);
	Объекты.Добавить(Метаданные.Документы.УведомлениеОСписанииКиЗГИСМ);
	// Конец ИнтеграцияГИСМ
	
	// ИнтеграцияЕГАИС
	Объекты.Добавить(Метаданные.Документы.АктПостановкиНаБалансЕГАИС);
	Объекты.Добавить(Метаданные.Документы.АктСписанияЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ВозвратИзРегистра2ЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ОстаткиЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ПередачаВРегистр2ЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ТТНВходящаяЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ТТНИсходящаяЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ЧекЕГАИС);
	Объекты.Добавить(Метаданные.Документы.ЧекЕГАИСВозврат);
	Объекты.Добавить(Метаданные.Документы.ОтчетЕГАИС);
	// Конец ИнтеграцияЕГАИС
	
	// ИнтеграцияВЕТИС
	Объекты.Добавить(Метаданные.Документы.ВходящаяТранспортнаяОперацияВЕТИС);
	Объекты.Добавить(Метаданные.Документы.ИсходящаяТранспортнаяОперацияВЕТИС);
	Объекты.Добавить(Метаданные.Документы.ЗапросСкладскогоЖурналаВЕТИС);
	Объекты.Добавить(Метаданные.Документы.ИнвентаризацияПродукцииВЕТИС);
	Объекты.Добавить(Метаданные.Документы.ПроизводственнаяОперацияВЕТИС);
	// Конец ИнтеграцияВЕТИС
	
	// ИнтеграцияИСМП
	Объекты.Добавить(Метаданные.Документы.МаркировкаТоваровИСМП);
	Объекты.Добавить(Метаданные.Документы.ВыводИзОборотаИСМП);
	Объекты.Добавить(Метаданные.Документы.ВозвратВОборотИСМП);
	Объекты.Добавить(Метаданные.Документы.ЗаказНаЭмиссиюКодовМаркировкиСУЗ);
	Объекты.Добавить(Метаданные.Документы.ПеремаркировкаТоваровИСМП);
	Объекты.Добавить(Метаданные.Документы.СписаниеКодовМаркировкиИСМП);
	Объекты.Добавить(Метаданные.Документы.ОтгрузкаТоваровИСМП);
	Объекты.Добавить(Метаданные.Документы.ПриемкаТоваровИСМП);
	// Конец ИнтеграцияИСМП
	
	УчетНДСУП.ОпределитьОбъектыСКомандамиОтчетов(Объекты);
	//-- Локализация

КонецПроцедуры

// Задает настройки размещения вариантов отчетов в панели отчетов.
// см. ОбщийМодуль.ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов()
// 
Процедура НастроитьВариантыОтчетов(Настройки) Экспорт
	
	//++ Локализация
	ВыводитьВариантыОтчетов = Ложь;
	
	ОтчетыЕГАИС.НастроитьВариантыОтчетов(Настройки);
	ОтчетыВЕТИСУТ.НастроитьВариантыОтчетов(Настройки);
	УчетНДСУП.НастроитьВариантыОтчетов(Настройки);
	
		
	#Область АнализРасхожденийПриПоступленииАлкогольнойПродукции
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.АнализРасхожденийПриПоступленииАлкогольнойПродукции);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "Основной");
	ОписаниеВарианта.Описание = НСтр("ru= 'Выявление и анализ расхождений между ТТН ЕГАИС и поступлением товаров.'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Алкогольная продукция
		|ЕГАИС
		|ТТН'");
	#КонецОбласти
	
	
	#Область ВыручкаИСебестоимостьРозничныхПродаж
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ВыручкаИСебестоимостьРозничныхПродаж);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Финансовый анализ розничных продаж
		|по подразделениям (магазинам), складам и поставщикам.'");
	ВариантыОтчетовУТПереопределяемый.УстановитьВажностьВариантаОтчета(ОписаниеВарианта, "Важный");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ДинамикаПродажРозницы");
	ОписаниеВарианта.Описание = НСтр("ru= 'Помесячные объемы розничных продаж за выбранный период.
		|Возможен анализ по периодам - квартал, месяц, неделя, день.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("НеИспользоватьБизнесРегионы");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ДинамикаПродажРозницыБизнесРегионы");
	ОписаниеВарианта.Описание = НСтр("ru= 'Помесячные объемы розничных продаж за выбранный период.
		|Возможен анализ по периодам - квартал, месяц, неделя, день.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("ИспользоватьБизнесРегионы");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ПродажиРозницыПоПодразделениям");
	ОписаниеВарианта.Описание = НСтр("ru= 'Какие магазины принесли более всего валовой прибыли?'");
	ВариантыОтчетовУТПереопределяемый.УстановитьВажностьВариантаОтчета(ОписаниеВарианта, "Важный");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ПродажиРозницыПоПоставщикам");
	ОписаниеВарианта.Описание = НСтр("ru= 'По товарам от каких поставщиков получена
		|наибольшая валовая прибыль при розничных продажах?'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("ФормироватьВидыЗапасовПоПоставщикам");
	#КонецОбласти
	
	
	#Область ВедомостьПоТоварамОрганизацийВЦенахНоменклатуры
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ВедомостьПоТоварамОрганизацийВЦенахНоменклатуры);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Анализ движений и оценка стоимости товаров
		|на розничных складах по выбранному виду цен.'");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ВедомостьПоТоварамОрганизацийВЦенахНоменклатуры");
	ОписаниеВарианта.Описание = НСтр("ru= 'Анализ движений и оценка стоимости товаров
		|на розничных складах по выбранному виду цен.'");	
	#КонецОбласти
	
	
	#Область ДосьеКонтрагента
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ДосьеКонтрагента);
	ОписаниеОтчета.Включен = Ложь;	
	#КонецОбласти
	
	
	#Область ЖурналУчетаРозничнойПродажиАлкогольнойПродукции
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ЖурналУчетаРозничнойПродажиАлкогольнойПродукции);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru='Журнал учета объема розничной продажи алкогольной
		|и спиртосодержащей продукции.'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Журнал учета объема розничной продажи алкогольной и спиртосодержащей продукции
		|Организация
		|Подразделение'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов = НСтр("ru= 'Период
		|Организация
		|Склад'");
	#КонецОбласти
	
	
	#Область ЖурналУчетаСчетовФактур
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ЖурналУчетаСчетовФактур);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Формирование списка счетов-фактур, исправленных счетов-фактур,
		|корректировочных счетов-фактур, полученных от поставщиков и переданных покупателям.'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Наименование налогоплательщика
		|ИНН
		|КПП
		|Выставленные счета-фактуры
		|Полученные счета-фактуры
		|Руководитель организации
		|Индивидуальный предприниматель'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов = НСтр("ru= 'Период
		|Организация'");
	#КонецОбласти
	
	
	#Область ЖурналУчетаТМЦСданныхНаХранение
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ЖурналУчетаТМЦСданныхНаХранение);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Форма по ОКУД 0335003
		|Организация
		|Организация-хранитель
		|Поклажедатель
		|Поклажедержатель
		|Структурное подразделение
		|ОКПО
		|ОКДП
		|Материально-ответственное лицо
		|МОЛ'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов = НСтр("ru= 'Период
		|Организация'");
	ОписаниеВарианта.Описание = НСтр("ru= 'Печать унифицированных форм МХ-1, МХ-2, МХ-3 по организации-хранителю за период'");
	#КонецОбласти
	
	
	#Область ЖурналФискальныхОпераций
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ЖурналФискальныхОпераций);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru='Журнал учета документов, выданных покупателю при расчетах.'");
	#КонецОбласти
	
	
	#Область ИндексыСПАРКРиски
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ИндексыСПАРКРиски);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Просмотр индексов 1СПАРК Риски по контрагентам.'");
	#КонецОбласти
	
	
	#Область ИмпортныеТоварыКОформлению
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ИмпортныеТоварыКОформлению);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ИмпортныеТоварыКОформлению");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("ИспользоватьИмпортныеЗакупки");
	ОписаниеВарианта.Описание = НСтр("ru= 'По каким товарам не оформлены таможенные декларации?'");	
	#КонецОбласти
	
	
	#Область КарточкаПартииПоВидамНалогообложения
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.КарточкаПартииПоВидамНалогообложения);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ВариантыОтчетовУТПереопределяемый.ОтключитьОтчет(ОписаниеОтчета);	
	#КонецОбласти
	
	
	#Область КнигаПокупок
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.КнигаПокупок);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Формирование книги покупок после выполнения регламентных операций закрытия периода по НДС.'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Покупатель
		|ИНН
		|КПП
		|Покупка за период
		|Дата и номер счета-фактуры
		|Номер и дата исправления счета-фактуры
		|Номер и дата корректировочного счета-фактуры
		|Наименование продавца
		|Страна происхождения товара
		|НДС'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов = НСтр("ru= 'Период
		|Организация
		|Контрагент
		|Выводить покупателей'");
	#КонецОбласти
	
	
	#Область КнигаПродаж
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.КнигаПродаж);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Формирование книги продаж после выполнения регламентных операций закрытия периода по НДС.'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Продавец
		|ИНН
		|КПП
		|Продажа за период
		|Дата и номер счета-фактуры
		|Номер и дата исправления счета-фактуры
		|Номер и дата корректировочного счета-фактуры
		|Наименование покупателя
		|Страна происхождения товара
		|НДС'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов = НСтр("ru= 'Период
		|Организация
		|Контрагент
		|Выводить продавцов'");
	#КонецОбласти
	
	
	#Область НаличиеСчетовФактур
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.НаличиеСчетовФактур);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Контроль наличия счетов-фактур, полученных от поставщиков.'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Документ-основание
		|Счет-фактура
		|Проведен'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов = НСтр("ru= 'Период
		|Организация
		|Наличие счета-фактуры
		|Документ'");
	#КонецОбласти
	
	
	#Область НастройкаСписка
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.НастройкаСписка);
	ВариантыОтчетовУТПереопределяемый.ОтключитьОтчет(ОписаниеОтчета);
	#КонецОбласти
	
	
	#Область ОборотноСальдоваяВедомостьАктивовПассивов
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ОборотноСальдоваяВедомостьАктивовПассивов);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ОСВАктивовПассивов");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Ложь;
	ОписаниеВарианта.Описание = НСтр("ru= 'Остатки активов и пассивов на начало и на конец периода и суммы оборотов за период.'");
	ВариантыОтчетовУТПереопределяемый.ОтключитьВариантОтчета(Настройки, ОписаниеОтчета, "КарточкаАктиваПассива");
	#КонецОбласти
	
	
	#Область ОстаткиИДвиженияДенежныхСредствВКассахККМ
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ОстаткиИДвиженияДенежныхСредствВКассахККМ);
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, ВыводитьВариантыОтчетов);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Контроль денежных средств в кассах ККМ.'");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ДвиженияДенежныхСредствККМ");
	ОписаниеВарианта.Описание = НСтр("ru= 'Контроль денежных средств в кассах ККМ.
		|В какой кассе ККМ, когда и сколько денежных средств приходило или уходило?'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("ИспользоватьНесколькоВалют");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ДвиженияДенежныхСредствККМОднаВалюта");
	ОписаниеВарианта.Описание = НСтр("ru= 'Контроль денежных средств в кассах ККМ.
		|В какой кассе ККМ, когда и сколько денежных средств приходило или уходило?'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("НеИспользоватьНесколькоВалют");
	#КонецОбласти
	
	
	#Область РеестрНормативноСправочнойИнформации
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.РеестрНормативноСправочнойИнформации);
	ВариантыОтчетовУТПереопределяемый.ОтключитьОтчет(ОписаниеОтчета);	
	#КонецОбласти
	
	
	#Область РеестрТорговыхДокументов
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.РеестрТорговыхДокументов);
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, ВыводитьВариантыОтчетов);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "Основной");
	ВариантыОтчетовУТПереопределяемый.УстановитьВажностьВариантаОтчета(ОписаниеВарианта, "СмТакже");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Ложь;
	ОписаниеВарианта.Описание = НСтр("ru= 'Список всех торговых документов'");
	#КонецОбласти
	
	
	#Область РеестрУчетныхДанных
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.РеестрУчетныхДанных);
	ВариантыОтчетовУТПереопределяемый.ОтключитьОтчет(ОписаниеОтчета);	
	#КонецОбласти
	
	
	#Область СправкаРасчетПереоценкиВалютныхСредств
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.СправкаРасчетПереоценкиВалютныхСредств);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("НеБазоваяВерсия");
	ОписаниеВарианта.Описание = НСтр("ru= 'Откуда возникают курсовые разницы?
		|Почему требуется переоценка?'");
	#КонецОбласти

	
	#Область СобытияМониторингаСПАРКРиски
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.СобытияМониторингаСПАРКРиски);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Просмотра событий мониторинга 1СПАРК Риски. Показываются события за последние 15 дней.'");
	#КонецОбласти
	
	
	#Область ТоварныйОтчетТОРГ29
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ТоварныйОтчетТОРГ29);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПолей = НСтр("ru= 'Форма по ОКУД 330229
		|Организация
		|Структурное подразделение
		|ОКПО
		|ОКДП
		|Материально-ответственное лицо
		|МОЛ'");
	ОписаниеВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов = НСтр("ru= 'Период
		|Организация
		|Склад
		|Номер отчета'");
	ОписаниеВарианта.Описание =  НСтр("ru= 'Товарный отчет для анализа розничных продаж. Отчет формируется по регламентированной форме Торг-29'");
	#КонецОбласти
	
	
	#Область УправленческийБаланс
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.УправленческийБаланс);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Анализ финансовых показателей на начало и конец периода и их изменения.'");
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "УправленческийБаланс");
	ОписаниеВарианта.Описание = НСтр("ru= 'Каковы финансовые показатели по статьям активов и пассивов?
		|Каковы финансовые показатели по организациям и подразделениям?
		|Есть ли нарушение баланса?'");
	ВариантыОтчетовУТПереопределяемый.УстановитьВажностьВариантаОтчета(ОписаниеВарианта, "Важный");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("НеБазоваяВерсия");
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "УпрБалансПоНаправлениям");
	ОписаниеВарианта.Описание = НСтр("ru= 'Контроль финансовых показателей по направлениям и статьям активов/пассивов.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("УправлениеПредприятием");
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "УпрБалансПоОрганизациям");
	ОписаниеВарианта.Описание = НСтр("ru= 'Контроль финансовых показателей по организациям и статьям активов/пассивов.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("УправлениеПредприятием");
	#КонецОбласти
	
	
	#Область УправленческийБалансКонтроль
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.УправленческийБалансКонтроль);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ВариантыОтчетовУТПереопределяемый.ОтключитьВариантОтчета(Настройки, ОписаниеОтчета, "КонтрольБалансаКонтекст");
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "КонтрольБаланса");
	ОписаниеВарианта.Описание = НСтр("ru= 'Контроль финансовых показателей по месяцам, статьям активов/пассивов и документам.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("НеБазоваяВерсия");
	#КонецОбласти


	#Область ФинансовоеСостояние
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ФинансовоеСостояние);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ФинансовоеСостояниеБазовая");
	ОписаниеВарианта.Описание = НСтр("ru= 'Каковы финансовые показатели по статьям активов и обязательств?'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("БазоваяВерсия");
	ВариантыОтчетовУТПереопределяемый.ОтключитьВариантОтчета(Настройки, ОписаниеОтчета, "УправленческийБалансУстаревший");
	ВариантыОтчетовУТПереопределяемый.ОтключитьВариантОтчета(Настройки, ОписаниеОтчета, "КонтрольБалансаУстаревший");
	ВариантыОтчетовУТПереопределяемый.ОтключитьВариантОтчета(Настройки, ОписаниеОтчета, "КарточкаАктиваПассиваКонтекст");
	ВариантыОтчетовУТПереопределяемый.ОтключитьВариантОтчета(Настройки, ОписаниеОтчета, "КонтрольВводаОстатковКонтекст");
	#КонецОбласти
	

	#Область МатериалыВЭксплуатации
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.МатериалыВЭксплуатации);
	ОписаниеОтчета.ОпределитьНастройкиФормы = Истина;
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("ИспользоватьВнутреннееПотребление");
	ОписаниеВарианта.Описание = НСтр("ru= 'Сколько и каких товарно-материальных ценностей передано сотрудникам в эксплуатацию?'");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ТМЦВЭксплуатации");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("ИспользоватьВнутреннееПотребление");
	ОписаниеВарианта.Описание = НСтр("ru= 'Сколько и каких товарно-материальных ценностей передано сотрудникам в эксплуатацию?'");
	ВариантыОтчетовУТПереопределяемый.ОтключитьВариантОтчета(Настройки, ОписаниеОтчета, "ТМЦВЭксплуатацииКонтекст");
	#КонецОбласти
	
		
	//-- Локализация
		
КонецПроцедуры

// Содержит описания изменений имен вариантов отчетов. Используется
//   при обновлении информационной базы, в целях контроля ссылочной целостности
//   и для сохранения настроек варианта, сделанных администратором.
//
//   (см. подробнее ВариантыОтчетовПереопределяемый.ЗарегистрироватьИзмененияКлючейВариантовОтчетов).
// 
Процедура ЗарегистрироватьИзмененияКлючейВариантовОтчетов(Изменения) Экспорт
	
	//++ Локализация
	
	ВариантыОтчетовУТПереопределяемый.ДобавитьИзменениеКлючей(Изменения, "ВедомостьПоТоварамОрганизацийВЦенахНоменклатуры", "Основной", "ВедомостьПоТоварамОрганизацийВЦенахНоменклатуры");
	ВариантыОтчетовУТПереопределяемый.ДобавитьИзменениеКлючей(Изменения, "УправленческийБаланс", "ПоОрганизациям", "УправленческийБаланс");
	
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти
