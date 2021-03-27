﻿// Общие механизмы интеграции ГосИС-ERP

#Область ПрограммныйИнтерфейс

// Получает массив GTIN для переданного товара и характеристики
//
// Параметры:
//  Номенклатура   - СправочникСсылка.Номенклатура - номенклатура (маркируемый товар).
//  Характеристика - СправочникСсылка.ХарактеристикиНоменклатуры - характеристика номенклатуры (маркируемого товара).
// 
// Возвращаемое значение:
//  Массив - массив GTIN
//
Функция МассивGTINМаркированногоТовара(Номенклатура, Характеристика) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	ШтрихкодыНоменклатуры.Штрихкод
	|ИЗ
	|	РегистрСведений.ШтрихкодыНоменклатуры КАК ШтрихкодыНоменклатуры
	|ГДЕ
	|	ШтрихкодыНоменклатуры.Номенклатура = &Номенклатура
	|	И ШтрихкодыНоменклатуры.Характеристика = &Характеристика");
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.УстановитьПараметр("Характеристика", Характеристика);
	
	МассивШтрихкодов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Штрихкод");
	СписокGTIN =  Новый Массив;
	
	Для Каждого Штрихкод Из МассивШтрихкодов Цикл
		
		Если МенеджерОборудованияКлиентСервер.ПроверитьКорректностьGTIN(Штрихкод) Тогда
			СписокGTIN.Добавить(Штрихкод);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат СписокGTIN;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ВидыПродукцииВТоварах(Знач Товары) Экспорт
	
	Возврат ИнтеграцияИСУТ.ВидыПродукцииВТоварах(Товары);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
