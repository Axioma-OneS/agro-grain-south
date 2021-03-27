﻿////////////////////////////////////////////////////////////////////////////////
// Модуль формы РегистрСведений.НоменклатураКонтрагентовБЭД.ФормаСписка
//
////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьСвойстваПереопределяемыхЭлементовФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сопоставить(Команда)
	
	НаборКлючейЗаписей = Элементы.Список.ВыделенныеСтроки;
	Если Не ЗначениеЗаполнено(НаборКлючейЗаписей) Тогда
		ТекстСообщения = НСтр("ru = 'Для сопоставления номенклатуры необходимо выбрать хотя бы одну строку.'");
		ПоказатьПредупреждение(, ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	НаборНоменклатурыКонтрагентов = НоменклатураКонтрагентовПоКлючамЗаписей(НаборКлючейЗаписей);
	
	ОбменСКонтрагентамиКлиент.ОткрытьСопоставлениеНоменклатуры(НаборНоменклатурыКонтрагентов);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьСвойстваПереопределяемыхЭлементовФормы()
	
	МетаданныеСопоставления = ОбменСКонтрагентамиСлужебный.МетаданныеСопоставленияНоменклатуры();
	
	Заголовок = МетаданныеСопоставления.НоменклатураКонтрагентаПредставлениеСписка;
	Элементы.Владелец.Заголовок = МетаданныеСопоставления.ВладелецНоменклатурыПредставлениеОбъекта;
	Элементы.Номенклатура.Заголовок = МетаданныеСопоставления.НоменклатураПредставлениеОбъекта;
	Элементы.Характеристика.Заголовок = МетаданныеСопоставления.ХарактеристикаПредставлениеОбъекта;
	Элементы.Упаковка.Заголовок = МетаданныеСопоставления.УпаковкаПредставлениеОбъекта;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НоменклатураКонтрагентовПоКлючамЗаписей(Знач НаборКлючейЗаписей)
	
	ТипСтрока300 = Новый ОписаниеТипов("Строка",,Новый КвалификаторыСтроки(300, ДопустимаяДлина.Переменная));
	
	ТаблицаКлючейЗаписей = Новый ТаблицаЗначений;
	Для каждого Измерение Из Метаданные.РегистрыСведений.НоменклатураКонтрагентовБЭД.Измерения Цикл
		ТаблицаКлючейЗаписей.Колонки.Добавить(Измерение.Имя, Измерение.Тип);
	КонецЦикла;
	Для каждого КлючЗаписи Из НаборКлючейЗаписей Цикл
		СтрокаКлючаЗаписи = ТаблицаКлючейЗаписей.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаКлючаЗаписи, КлючЗаписи);
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТаблицаКлючейЗаписей.Владелец КАК Владелец,
	|	ТаблицаКлючейЗаписей.Идентификатор КАК Идентификатор
	|ПОМЕСТИТЬ втОтбор
	|ИЗ
	|	&ТаблицаКлючейЗаписей КАК ТаблицаКлючейЗаписей
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	НоменклатураКонтрагентовБЭД.Владелец КАК Владелец,
	|	НоменклатураКонтрагентовБЭД.Идентификатор КАК Идентификатор,
	|	НоменклатураКонтрагентовБЭД.Наименование КАК Наименование,
	|	НоменклатураКонтрагентовБЭД.НаименованиеХарактеристики КАК Характеристика,
	|	НоменклатураКонтрагентовБЭД.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	НоменклатураКонтрагентовБЭД.Артикул КАК Артикул,
	|	НоменклатураКонтрагентовБЭД.Штрихкод КАК Штрихкод,
	|	НоменклатураКонтрагентовБЭД.ИдентификаторНоменклатурыСервиса КАК ИдентификаторНоменклатурыСервиса,
	|	НоменклатураКонтрагентовБЭД.ИдентификаторХарактеристикиСервиса КАК ИдентификаторХарактеристикиСервиса,
	|	НоменклатураКонтрагентовБЭД.ИдентификаторНоменклатуры КАК ИдентификаторНоменклатуры,
	|	НоменклатураКонтрагентовБЭД.ИдентификаторХарактеристики КАК ИдентификаторХарактеристики,
	|	НоменклатураКонтрагентовБЭД.ИдентификаторУпаковки КАК ИдентификаторУпаковки,
	|	НоменклатураКонтрагентовБЭД.ИспользоватьХарактеристики КАК ИспользоватьХарактеристики,
	|	НоменклатураКонтрагентовБЭД.ШтрихкодКомбинации КАК ШтрихкодКомбинации,
	|	НоменклатураКонтрагентовБЭД.ШтрихкодыНоменклатуры КАК ШтрихкодыНоменклатуры,
	|	НоменклатураКонтрагентовБЭД.ЕдиницаИзмеренияКод КАК ЕдиницаИзмеренияКод
	|ИЗ
	|	РегистрСведений.НоменклатураКонтрагентовБЭД КАК НоменклатураКонтрагентовБЭД
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ втОтбор КАК втОтбор
	|		ПО НоменклатураКонтрагентовБЭД.Владелец = втОтбор.Владелец
	|			И НоменклатураКонтрагентовБЭД.Идентификатор = втОтбор.Идентификатор";
	
	Запрос.УстановитьПараметр("ТаблицаКлючейЗаписей", ТаблицаКлючейЗаписей);
	
	УстановитьПривилегированныйРежим(Истина);
	Выборка = Запрос.Выполнить().Выбрать();
	УстановитьПривилегированныйРежим(Ложь);
	
	НаборНоменклатурыКонтрагентов = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		НоменклатураКонтрагента = ОбменСКонтрагентамиСлужебныйКлиентСервер.НоваяНоменклатураКонтрагента();
		ЗаполнитьЗначенияСвойств(НоменклатураКонтрагента, Выборка);
		НаборНоменклатурыКонтрагентов.Добавить(НоменклатураКонтрагента);
		
	КонецЦикла;
	
	Возврат НаборНоменклатурыКонтрагентов;
	
КонецФункции

#КонецОбласти
