﻿////////////////////////////////////////////////////////////////////////////////
// Модуль "РасхожденияВызовСервера" содержит процедуры и функции, предназначенные для взаимодействия клиентских и
// серверных процедур при работе с документами отражения расхождений после отгрузки клиентам, после возвратов
// поставщикам, после перемещения.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура ИзменитьДокументОснованиеАктаОРасхождениях(АктОРасхождениях, Основание) Экспорт

	РасхожденияСервер.ИзменитьДокументОснованиеАктаОРасхождениях(АктОРасхождениях, Основание);

КонецПроцедуры

Функция СтатусАктаКВыполнениюОтработано(АктОРасхождениях) Экспорт
	
	СтатусАкта = ОбщегоНазначенияУТВызовСервера.ЗначениеРеквизитаОбъекта(АктОРасхождениях, "Статус");
	СтатусАктаКВыполнениюОтработано = СтатусАкта = Перечисления.СтатусыАктаОРасхождениях.КВыполнению
		Или СтатусАкта = Перечисления.СтатусыАктаОРасхождениях.Отработано;
	
	Возврат СтатусАктаКВыполнениюОтработано;
		
КонецФункции

Процедура УстановитьДоступностьСоглашенийСПоставщиком(Форма) Экспорт
	
	Если ЗначениеЗаполнено(Форма.Объект.Партнер) И Форма.ИспользоватьСоглашенияСПоставщиками Тогда
		КоличествоСоглашенийСПоставщиком  = ЗакупкиВызовСервера.ПолучитьКоличествоСоглашенийСПоставщиком(Форма.Объект.Партнер);
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "Соглашение", "Видимость", КоличествоСоглашенийСПоставщиком > 0);
	Иначе
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "Соглашение", "Видимость", Ложь);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
