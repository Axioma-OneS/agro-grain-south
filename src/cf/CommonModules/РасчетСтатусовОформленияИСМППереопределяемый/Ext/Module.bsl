﻿// Механизм расчета статусов оформления документов ИС МП.
//

#Область СлужебныйПрограммныйИнтерфейс

// Позволяет переопределить имена реквизитов документа-основания для документа ИСМП.
//
// Параметры:
//  МетаданныеДокументаОснования - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.Основание<Имя документа ИСМП>
//  МетаданныеДокументаИСМП - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.ДокументыИСМППоддерживающиеСтатусыОформления
//  Реквизиты  - Структура - имена реквизитов:
//  * Ключ  - служебное имя реквизита в ИСМП
//  * Значение - имя реквизита документа-основания, которое при необходимости надо переопределить
//  (см. РасчетСтатусовОформленияИСМП.СтруктураРеквизитовДляРасчетаСтатусаОформленияДокументов).
Процедура ПриОпределенииИменРеквизитовДляРасчетаСтатусаОформления(
			Знач МетаданныеДокументаОснования, Знач МетаданныеДокументаИСМП, Реквизиты) Экспорт
	//++ НЕ ГОСИС
	РасчетСтатусовОформленияГосИСУТ.ПриОпределенииИменРеквизитовДокументаДляРасчетаСтатусаОформленияДокументаИСМП(
		МетаданныеДокументаОснования,
		МетаданныеДокументаИСМП,
		Реквизиты);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

// Позволяет переопределить текст запроса выборки данных из документов-основания для расчета статуса оформления.
//   Требования к тексту запроса:
//     Если данные из документа выбирать не требуется, то данному параметру надо присвоить значение "" (пустая строка).
//     Результат запроса обязательно должен содержать следующие поля:
//      * Ссылка - ОпределяемыйТип.Основание<Имя документа ИСМП> - ссылка на документ-основание
//      * ЭтоДвижениеПриход - Булево - вид движения ТМЦ (Истина - приход, Ложь - расход)
//      * Номенклатура - ОпределяемыйТип.Номенклатура - номенклатура
//      * Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры - характеристика номенклатуры
//      * Серия - ОпределяемыйТип.СерияНоменклатуры - серия номенклатуры
//      * Количество - Число - количество номенклатуры в ее основной единице измерения
//     В результат запроса нужно включать только подконтрольную номенклатуру ИСМП (табак, обувь)
//     Для отбора документов-основания в запросе нужно использовать отбор "В (&МассивДокументов)"
//     Выбранные данные необходимо поместить во временную таблицу (См. РасчетСтатусовОформленияИСМП.ИмяВременнойТаблицыДляВыборкиДанныхДокумента).
//
//Параметры:
//   МетаданныеДокументаОснования - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.Основание<Имя документа ИСМП>
//   МетаданныеДокументаИСМП - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.ДокументыИСМППоддерживающиеСтатусыОформления
//   ТекстЗапроса - Строка - текст запроса выборки данных, который надо переопределить
//   ДополнительныеПараметрыЗапроса - Структура - дополнительные параметры запроса, требуемые для выполнения запроса 
//       конкретного документа; при необходимости можно дополнить данную структуру
//     Ключ     - имя параметры
//     Значение - значение параметра.
//
Процедура ПриОпределенииТекстаЗапросаДляРасчетаСтатусаОформления(
			Знач МетаданныеДокументаОснования, Знач МетаданныеДокументаИСМП, ТекстЗапроса, ДополнительныеПараметрыЗапроса) Экспорт
	
	//++ НЕ ГОСИС
	РасчетСтатусовОформленияГосИСУТ.ПриОпределенииТекстаЗапросаРасчетаСтатусаОформленияДокументаИСМП(
		МетаданныеДокументаОснования,
		МетаданныеДокументаИСМП,
		ТекстЗапроса,
		ДополнительныеПараметрыЗапроса);
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры

#КонецОбласти