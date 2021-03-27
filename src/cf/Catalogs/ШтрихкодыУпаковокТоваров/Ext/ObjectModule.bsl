﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	ИнтеграцияЕГАИСПереопределяемый.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	Если ЗначениеЗаполнено(ЗначениеШтрихкода) И ЭтоНовый() Тогда
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("ЗначениеШтрихкода", ЗначениеШтрихкода);
		Запрос.УстановитьПараметр("ХешСуммаЗначенияШтрихкода", ИнтеграцияИС.ХешированиеДанныхSHA256(ЗначениеШтрихкода));
		Запрос.Текст ="ВЫБРАТЬ ПЕРВЫЕ 1
		|	ШтрихкодыУпаковокТоваров.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ШтрихкодыУпаковокТоваров КАК ШтрихкодыУпаковокТоваров
		|ГДЕ
		|	ШтрихкодыУпаковокТоваров.ЗначениеШтрихкода = &ЗначениеШтрихкода
		|	И ШтрихкодыУпаковокТоваров.ХешСуммаЗначенияШтрихкода = &ХешСуммаЗначенияШтрихкода";
		
		РезультатЗапроса = Запрос.Выполнить();
		Если НЕ РезультатЗапроса.Пустой() Тогда
			ТекстСообщения = НСтр("ru = 'Данное значение штрихкода уже присвоено другому элементу'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"ЗначениеШтрихкода", "Объект", Отказ);
		КонецЕсли;
	КонецЕсли;
	
	ПараметрыНоменклатуры = Справочники.ШтрихкодыУпаковокТоваров.ПараметрыНоменклатурыВложенныхШтрихкодов(ЭтотОбъект);
	Если ТипУпаковки <> ПараметрыНоменклатуры.ТипУпаковки Тогда
		ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа упаковки: по данным вложенных упаковок должно быть значение %1'");
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ПараметрыНоменклатуры.ТипУпаковки);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"ТипУпаковки","Объект", Отказ);
	КонецЕсли;
	
	Если Номенклатура <> ПараметрыНоменклатуры.Номенклатура Тогда
		Если ЗначениеЗаполнено(ПараметрыНоменклатуры.Номенклатура) Тогда
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа номенклатуры: по данным вложенных упаковок должно быть значение %1'");
		Иначе
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа номенклатуры: по данным вложенных упаковок значение не должно быть заполнено'");
		КонецЕсли;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ПараметрыНоменклатуры.Номенклатура);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"Номенклатура","Объект", Отказ);
	КонецЕсли;
	
	Если Характеристика <> ПараметрыНоменклатуры.Характеристика Тогда
		Если ЗначениеЗаполнено(ПараметрыНоменклатуры.Характеристика) Тогда
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа характеристики: по данным вложенных упаковок должно быть значение %1'");
		Иначе
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа характеристики: по данным вложенных упаковок значение не должно быть заполнено'");
		КонецЕсли;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ПараметрыНоменклатуры.Характеристика);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"Характеристика","Объект", Отказ);
	КонецЕсли;
	
	Если Упаковка <> ПараметрыНоменклатуры.Упаковка Тогда
		Если ЗначениеЗаполнено(ПараметрыНоменклатуры.Упаковка) Тогда
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа упаковки: по данным вложенных упаковок должно быть значение %1'");
		Иначе
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа упаковки: по данным вложенных упаковок значение не должно быть заполнено'");
		КонецЕсли;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ПараметрыНоменклатуры.Упаковка);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"Упаковка","Объект", Отказ);
	КонецЕсли;
	
	Если Серия <> ПараметрыНоменклатуры.Серия Тогда
		Если ЗначениеЗаполнено(ПараметрыНоменклатуры.Серия) Тогда
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа серии: по данным вложенных упаковок должно быть значение %1'");
		Иначе
			ТекстСообщения = НСтр("ru = 'Не правильно указано значение типа серии: по данным вложенных упаковок значение не должно быть заполнено'");
		КонецЕсли;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ПараметрыНоменклатуры.Упаковка);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"Серия","Объект", Отказ);
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипУпаковки = Перечисления.ТипыУпаковок.МаркированныйТовар Тогда
		ВложенныеШтрихкоды.Очистить();
	КонецЕсли;
	
	Если Не (ДополнительныеСвойства.Свойство("НеРассчитыватьКоличествоВложенныхШтрихкодов")
		И ДополнительныеСвойства.НеРассчитыватьКоличествоВложенныхШтрихкодов) Тогда
	
		РассчитатьКоличествоВложенныхШтрихкодов();
		
	КонецЕсли;
	
	Если Не (ДополнительныеСвойства.Свойство("НеРассчитыватьХешСумму")
		И ДополнительныеСвойства.НеРассчитыватьХешСумму) Тогда
		
		Если ТипУпаковки = Перечисления.ТипыУпаковок.МаркированныйТовар Тогда
			ХешСумма = "";
		Иначе
			ДанныеДляВычисления = Справочники.ШтрихкодыУпаковокТоваров.ДанныеДляВычисленияХешСуммы(ЭтотОбъект);
			ХешСумма = Справочники.ШтрихкодыУпаковокТоваров.ХешСуммаСодержимогоУпаковки(ДанныеДляВычисления);
		КонецЕсли;
		
	КонецЕсли;
	
	ХешСуммаЗначенияШтрихкода = Справочники.ШтрихкодыУпаковокТоваров.ХэшСуммаСтроки(ЗначениеШтрихкода);
	
	ЗаполнениеСлужебныхПолейДляGS1();
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ЗначениеШтрихкода            = "";
	ХешСумма                     = "";
	ХешСуммаЗначенияШтрихкодаGS1 = "";
	ХешСуммаЗначенияШтрихкода    = "";
	
	// Служебные поля GS1
	НомерПартии   = "";
	СерийныйНомер = 0;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура РассчитатьКоличествоВложенныхШтрихкодов() Экспорт
	
	Если ТипУпаковки = Перечисления.ТипыУпаковок.МонотоварнаяУпаковка Тогда
		МассивВложенныхШтрихкодов = ВложенныеШтрихкоды.Выгрузить(,"Штрихкод").ВыгрузитьКолонку("Штрихкод");
		Результат = ШтрихкодированиеИС.ВложенныеШтрихкодыУпаковок(МассивВложенныхШтрихкодов);
		Количество = Результат.МаркированныеТовары.Количество();
	Иначе
		Количество = 0;
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнениеСлужебныхПолейДляGS1()
	
	// Только для типов штрихкодов GS1_128 и GS1_DataBarExpandedStacked, для SSCC и Code-128 в ЕГАИС формат штрихкода жестко установлен
	Если ТипШтрихкода = Перечисления.ТипыШтрихкодов.GS1_128
		Или ТипШтрихкода = Перечисления.ТипыШтрихкодов.GS1_DataBarExpandedStacked
		Или ТипШтрихкода = Перечисления.ТипыШтрихкодов.GS1_DataMatrix Тогда
		
		Если ЭтоНовый() Тогда
			ОбновитьРеквизитыGS1 = ЗначениеЗаполнено(ЗначениеШтрихкода);
		Иначе
			ОбновитьРеквизитыGS1 = ЗначениеШтрихкода <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "ЗначениеШтрихкода");
		КонецЕсли;
		
		Если ОбновитьРеквизитыGS1 Тогда
			
			ПараметрыШтрихкода = ШтрихкодыУпаковокКлиентСервер.ПараметрыШтрихкода(ЗначениеШтрихкода);
			Результат          = ПараметрыШтрихкода.Результат;
			
			ХешСуммаЗначенияШтрихкодаGS1 = "";
			
			Если Результат <> Неопределено Тогда
				
				НомерПартии   = "";
				СерийныйНомер = 0;
				
				Для Каждого СвойствоШтрихкода Из Результат Цикл
					Если СвойствоШтрихкода.ИмяИдентификатора = ВРег("НомерПартии") Тогда
						НомерПартии = СвойствоШтрихкода.Значение;
					ИначеЕсли СвойствоШтрихкода.ИмяИдентификатора = ВРег("СерийныйНомер") Тогда
						СерийныйНомер = СвойствоШтрихкода.Значение;
					КонецЕсли;
					Если ЗначениеЗаполнено(НомерПартии) И ЗначениеЗаполнено(СерийныйНомер) Тогда
						Прервать;
					КонецЕсли;
				КонецЦикла;
				
				Справочники.ШтрихкодыУпаковокТоваров.ЗаполнитьСвойствоХешСуммаЗначенияШтрихкодаGS1(ЭтотОбъект, ПараметрыШтрихкода);
				
			КонецЕсли;
			
		КонецЕсли;
	
	Иначе
		
		НомерПартии   = "";
		СерийныйНомер = 0;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли