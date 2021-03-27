﻿// Одноименная процедура для заполнения текста органичения подсистемы БСП Управление доступом
// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
//  
// Параметры:
// 	МетаданныеОбъекта - Метаданные - метаданные вызывающего объекта.
// 	Ограничение - Структура - Структура ограничения:
// 	 * Текст - Строка - Текст ограничения.
//
Процедура ПриЗаполненииОграниченияДоступа(МетаданныеОбъекта, Ограничение) Экспорт
	
	//++ НЕ ГОСИС
	Если Метаданные.Документы.МаркировкаТоваровИСМП = МетаданныеОбъекта
		Или Метаданные.Документы.ОтгрузкаТоваровИСМП = МетаданныеОбъекта
		Или Метаданные.Документы.ПриемкаТоваровИСМП = МетаданныеОбъекта
		Или Метаданные.Документы.ВыводИзОборотаИСМП = МетаданныеОбъекта
		Или Метаданные.Документы.ВозвратВОборотИСМП = МетаданныеОбъекта
		Или Метаданные.Документы.ЗаказНаЭмиссиюКодовМаркировкиСУЗ = МетаданныеОбъекта
		Или Метаданные.Документы.ПеремаркировкаТоваровИСМП = МетаданныеОбъекта
		Или Метаданные.Документы.СписаниеКодовМаркировкиИСМП = МетаданныеОбъекта Тогда
		
		Ограничение.Текст =
		"РазрешитьЧтениеИзменение
		|ГДЕ
		|	ЗначениеРазрешено(Организация)";
		
	ИначеЕсли Метаданные.РегистрыСведений.ПулКодовМаркировкиСУЗ = МетаданныеОбъекта
		Или Метаданные.РегистрыСведений.НастройкиОбменаСУЗ = МетаданныеОбъекта
		Или Метаданные.РегистрыСведений.ОчередьСообщенийИСМП = МетаданныеОбъекта Тогда
		
		Ограничение.Текст =
		"РазрешитьЧтениеИзменение
		|ГДЕ
		|	ЗначениеРазрешено(Организация)";
		
	КонецЕсли;
	//-- НЕ ГОСИС
	Возврат;
	
КонецПроцедуры