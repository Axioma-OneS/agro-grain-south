﻿
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьПоУказанным(Команда)
	ТекстВопроса = НСтр("ru='По данным первичных движений будут перезаполнены регистры:
	|	РасчетыСКлиентамиПоСрокам
	|	РасчетыСКлиентамиПлановыеОплаты
	|	РасчетыСКлиентамиПлановыеОтгрузки
	|	РасчетыСПоставщикамиПоСрокам
	|	РасчетыСПоставщикамиПлановыеОплаты
	|	РасчетыСПоставщикамиПлановыеПоставки
	|Задания к переотражению в БУ, МФУ, НДС и к закрытию месяца созданы не будут. Продолжить?'");
	ПоказатьВопрос(Новый ОписаниеОповещения("ЗаполнитьПоУказаннымЗавершение", ЭтотОбъект), ТекстВопроса,РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоУказаннымЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ЗаполнитьПоУказаннымНаСервере();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Очистить(Команда)
	ОчиститьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьВсё(Команда)
	ТекстВопроса = НСтр("ru='По данным первичных движений будут перезаполнены регистры:
	|	РасчетыСКлиентамиПоСрокам
	|	РасчетыСКлиентамиПлановыеОплаты
	|	РасчетыСКлиентамиПлановыеОтгрузки
	|	РасчетыСПоставщикамиПоСрокам
	|	РасчетыСПоставщикамиПлановыеОплаты
	|	РасчетыСПоставщикамиПлановыеПоставки
	|Задания к переотражению в БУ, МФУ, НДС и к закрытию месяца созданы не будут. Продолжить?'");
	ПоказатьВопрос(Новый ОписаниеОповещения("ЗаполнитьВсёЗавершение", ЭтотОбъект), ТекстВопроса,РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьВсёЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ЗаполнитьВсёСервер();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПлановые(Команда)
	ТекстВопроса = НСтр("ru='По данным первичных движений будут перезаполнены регистры:
	|	РасчетыСКлиентамиПлановыеОплаты
	|	РасчетыСКлиентамиПлановыеОтгрузки
	|	РасчетыСПоставщикамиПлановыеОплаты
	|	РасчетыСПоставщикамиПлановыеПоставки
	|Продолжить?'");
	ПоказатьВопрос(Новый ОписаниеОповещения("ЗаполнитьПлановыеЗавершение", ЭтотОбъект), ТекстВопроса,РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПлановыеЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ЗаполнитьПлановыеНаСервере();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если  не ЗначениеЗаполнено(ОбъектРасчетов) Тогда
		ОбъектРасчетов = ПредопределенноеЗначение("Справочник.ДоговорыКонтрагентов.ПустаяСсылка");
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьПоУказаннымНаСервере(Порядок = "")
	
	Если Не ЗначениеЗаполнено(ОбъектРасчетов) ИЛИ Не ЗначениеЗаполнено(КлючАналитикиУчетаПоПартнерам) Тогда
		ТекстИсключения = НСтр("ru='Для частичного заполнения указжите Объект расчетов и Ключ аналитики учета по партнерам.'");
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	ОсновныеПараметры = ОперативныеВзаиморасчетыСервер.СтруктураПараметровЗаполненияВзаиморасчетов();
	ОсновныеПараметры.ОбъектРасчетов = ОбъектРасчетов;
	ОсновныеПараметры.АналитикаУчетаПоПартнерам = КлючАналитикиУчетаПоПартнерам;
	Если ЗначениеЗаполнено(ДатаНачалаПересчета) Тогда
		ОсновныеПараметры.ПорядокФакт = ОперативныеВзаиморасчетыСервер.Порядок(ДатаНачалаПересчета,"",,Тип("ДокументСсылка.РегистраторРасчетов"));
		ОсновныеПараметры.ПорядокПлан = ОперативныеВзаиморасчетыСервер.Порядок(ДатаНачалаПересчета,"",,Тип("ДокументСсылка.РегистраторРасчетов"));
	КонецЕсли;
	Если ОбщегоНазначения.ЕстьРеквизитОбъекта("ВалютаВзаиморасчетов",ОбъектРасчетов.Метаданные()) Тогда
		ОсновныеПараметры.ВалютаРасчетов = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОбъектРасчетов, "ВалютаВзаиморасчетов");
		
		ОсновныеПараметры.ЭтоРасчетыСКлиентами = Истина;
		ОперативныеВзаиморасчетыСервер.ЗаполнитьОперативныеВзаиморасчеты(ОсновныеПараметры);
		
		ОсновныеПараметры.ЭтоРасчетыСКлиентами = Ложь;
		ОперативныеВзаиморасчетыСервер.ЗаполнитьОперативныеВзаиморасчеты(ОсновныеПараметры);
	ИначеЕсли ТипЗнч(ОбъектРасчетов) = Тип("ДокументСсылка.ПоступлениеБезналичныхДенежныхСредств") 
		ИЛИ ТипЗнч(ОбъектРасчетов) = Тип("ДокументСсылка.СписаниеБезналичныхДенежныхСредств")
		ИЛИ ТипЗнч(ОбъектРасчетов) = Тип("ДокументСсылка.ПриходныйКассовыйОрдер")
		ИЛИ ТипЗнч(ОбъектРасчетов) = Тип("ДокументСсылка.РасходныйКассовыйОрдер")
		ИЛИ ТипЗнч(ОбъектРасчетов) = Тип("ДокументСсылка.АвансовыйОтчет")
		ИЛИ ТипЗнч(ОбъектРасчетов) = Тип("ДокументСсылка.ОперацияПоПлатежнойКарте") Тогда
		ВалютаРасшифровки = ОбъектРасчетов.РасшифровкаПлатежа[0].ВалютаВзаиморасчетов;
		
		ОсновныеПараметры.ВалютаРасчетов = ВалютаРасшифровки;
		ОсновныеПараметры.ЭтоРасчетыСКлиентами = Истина;
		ОперативныеВзаиморасчетыСервер.ЗаполнитьОперативныеВзаиморасчеты(ОсновныеПараметры);
		
		ОсновныеПараметры.ЭтоРасчетыСКлиентами = Ложь;
		ОперативныеВзаиморасчетыСервер.ЗаполнитьОперативныеВзаиморасчеты(ОсновныеПараметры);
	Иначе
		
		ОсновныеПараметры.ВалютаРасчетов = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОбъектРасчетов, "Валюта");
		
		ОсновныеПараметры.ЭтоРасчетыСКлиентами = Истина;
		ОперативныеВзаиморасчетыСервер.ЗаполнитьОперативныеВзаиморасчеты(ОсновныеПараметры);
		
		ОсновныеПараметры.ЭтоРасчетыСКлиентами = Ложь;
		ОперативныеВзаиморасчетыСервер.ЗаполнитьОперативныеВзаиморасчеты(ОсновныеПараметры);
		
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОчиститьНаСервере()
	ОперативныеВзаиморасчетыСервер.ОчиститьРегистрыВзаиморасчетов();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВсёСервер()
	ОперативныеВзаиморасчетыСервер.ЗаполнитьПоВсемРасчетам();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПлановыеНаСервере()
	
	ОперативныеВзаиморасчетыСервер.ОчиститьРегистр("РасчетыСКлиентамиПланОплат");
	ОперативныеВзаиморасчетыСервер.ОчиститьРегистр("РасчетыСКлиентамиПланОтгрузок");
	ОперативныеВзаиморасчетыСервер.ОчиститьРегистр("РасчетыСПоставщикамиПланОплат");
	ОперативныеВзаиморасчетыСервер.ОчиститьРегистр("РасчетыСПоставщикамиПланПоставок");
	
	ТаблицаОбъектов = ОперативныеВзаиморасчетыСервер.ПолучитьВсеОбъекты();
	Для Каждого Стр из ТаблицаОбъектов Цикл
		ОсновныеПараметры = ОперативныеВзаиморасчетыСервер.СтруктураПараметровЗаполненияВзаиморасчетов();
		ЗаполнитьЗначенияСвойств(ОсновныеПараметры,Стр);
		ОсновныеПараметры.НачальноеЗаполнение = Истина;
		ОперативныеВзаиморасчетыСервер.ЗаполнитьОперативныеВзаиморасчеты(ОсновныеПараметры);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

