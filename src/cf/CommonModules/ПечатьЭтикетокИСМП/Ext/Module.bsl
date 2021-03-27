﻿#Область ПрограммныйИнтерфейс

// Подготавливает структуру дополнительных параметров для печати этикеток.
// 
// Возвращаемое значение:
// 	Структура - Описание:
// * КаждаяЭтикеткаНаНовомЛисте - Булево - Признак вывода разделителя страниц после каждой этикетки.
//
Функция СтруктураНастроекЭтикеткаИСМП() Экспорт
	
	СтруктураНастроек = Новый Структура;
	СтруктураНастроек.Вставить("КаждаяЭтикеткаНаНовомЛисте", Ложь);
	
	ПечатьЭтикетокИСМППереопределяемый.СтруктураНастроекЭтикеткаИСМП(СтруктураНастроек);
	
	Возврат СтруктураНастроек;
	
КонецФункции

// Дополняет массив документов-оснований для выбора кодов маркировки из пула.
// Использутеся для определения связанных документов оснований, например:
// 	Формируем заказ поставщику, на основании Заказа на эмиссию, заказываем коды.
// 	На основании заказа поставщику вводим документ Приобритение товара.
// 	На основании Приобритения товара вводим документ Маркировка товаров и печатем новый код маркировки.
// 	Так как основания у документов Заказ на эмиссию и Маркировка товаров разные, - то определение связи между документами
// 	Заказ поставщику и Приобритение товаров происходит в переданном параметре.
// 	Запрос содержит установленный параметр Документ.
// 	Результат должен содержать одно поле, значение которого присутсвует в определяемом типе ОснованиеЗаказНаЭмиссиюКодовМаркировкиИСМП
//
// Параметры:
// 	Документ - ДокументСсылка.МаркировкаТоваровИСМП, ДокументСсылка.ПеремаркировкаТоваровИСМП - Исходный документ для выбора кодов.
//Возвращаемое значение:
//  Массив из ДокументСсылка - Документы-основания.
Функция МассивСвязанныхДокументовОснований(Документ) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	
	ТекстЗапроса =
		"ВЫБРАТЬ
		|	&Документ КАК ДокументОснование
		|ПОМЕСТИТЬ ДокументыОснования
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МаркировкаТоваровИСМП.ДокументОснование КАК Ссылка
		|ПОМЕСТИТЬ ОснованияДляПоискаСвязи
		|ИЗ
		|	Документ.МаркировкаТоваровИСМП КАК МаркировкаТоваровИСМП
		|ГДЕ
		|	МаркировкаТоваровИСМП.Ссылка = &Документ
		|	И НЕ МаркировкаТоваровИСМП.ДокументОснование В (&НезаполненныеЗначенияОснования)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПеремаркировкаТоваровИСМП.ДокументОснование
		|ИЗ
		|	Документ.ПеремаркировкаТоваровИСМП КАК ПеремаркировкаТоваровИСМП
		|ГДЕ
		|	ПеремаркировкаТоваровИСМП.Ссылка = &Документ
		|	И НЕ ПеремаркировкаТоваровИСМП.ДокументОснование В (&НезаполненныеЗначенияОснования)
		|;
		|////////////
		|";
	
	Запрос.УстановитьПараметр("Документ",                       Документ);
	Запрос.УстановитьПараметр("НезаполненныеЗначенияОснования", ИнтеграцияИС.НезаполненныеЗначенияОпределяемогоТипа("ОснованиеЗаказНаЭмиссиюКодовМаркировкиИСМП"));
	
	СтандартнаяОбработка = Истина;
	ПечатьЭтикетокИСМППереопределяемый.ДополнитьТекстЗапросаСвязанныхДокументовОснований(ТекстЗапроса, СтандартнаяОбработка);
	
	Если СтандартнаяОбработка Тогда
		
		ТекстЗапроса = ТекстЗапроса +
		"
		|ВЫБРАТЬ
		|	НЕОПРЕДЕЛЕНО КАК ДокументОснование
		|ПОМЕСТИТЬ СвязанныеОснования
		|ГДЕ
		|	ЛОЖЬ
		|";
		
	КонецЕсли;
	
	ТекстЗапроса = ТекстЗапроса +
	"
	|;
	|
	|ВЫБРАТЬ
	|	Основания.ДокументОснование КАК ДокументОснование
	|ИЗ
	|	ДокументыОснования КАК Основания
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	СвязанныеОснования.ДокументОснование
	|ИЗ
	|	СвязанныеОснования КАК СвязанныеОснования";
	
	Запрос.Текст     = ТекстЗапроса;
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	Возврат РезультатЗапроса.ВыгрузитьКолонку("ДокументОснование");
	
КонецФункции

#КонецОбласти