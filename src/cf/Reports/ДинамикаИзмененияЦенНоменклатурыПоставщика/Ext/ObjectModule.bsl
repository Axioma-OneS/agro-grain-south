﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.Запрос.Запрос;
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
		"&ТекстЗапросаКоэффициентУпаковки",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"ЦеныНоменклатуры.Упаковка",
		"ЦеныНоменклатуры.Номенклатура"));
	СхемаКомпоновкиДанных.НаборыДанных[0].Запрос = ТекстЗапроса;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли