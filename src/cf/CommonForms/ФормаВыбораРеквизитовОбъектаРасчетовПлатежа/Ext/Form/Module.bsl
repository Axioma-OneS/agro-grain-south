﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ЕстьОснованиеПлатежа = ТипЗнч(Параметры.ДокументСсылка) = Тип("ДокументСсылка.ПоступлениеБезналичныхДенежныхСредств")
							ИЛИ ТипЗнч(Параметры.ДокументСсылка) = Тип("ДокументСсылка.ПриходныйКассовыйОрдер")
							ИЛИ ТипЗнч(Параметры.ДокументСсылка) = Тип("ДокументСсылка.ОперацияПоПлатежнойКарте");
	
	ГруппаФинансовогоУчета  = Параметры.ГруппаФинансовогоУчета;
	Договор                 = Параметры.Договор;
	НаправлениеДеятельности = Параметры.НаправлениеДеятельности;
	
	Если Параметры.Свойство("Подразделение") Тогда
		Подразделение           = Параметры.Подразделение;
	КонецЕсли;
	
	Если НЕ ЕстьОснованиеПлатежа Тогда
		Элементы.Подразделение.Видимость = Ложь;
		Элементы.ГруппаСтраницыРасхожденияПодразделение.Видимость = Ложь;
	КонецЕсли;
	
	Организация             = Параметры.Организация;
	Контрагент              = Параметры.Контрагент;
	ХозяйственнаяОперация   = Параметры.ХозяйственнаяОперация;
	ДокументСсылка          = Параметры.ДокументСсылка;
	
	РасшифровкаПлатежаХранилище = ПолучитьИзВременногоХранилища(Параметры.АдресВоВременномХранилище);
	
	Для Каждого СтрокаТаблицыХранилища Из РасшифровкаПлатежаХранилище Цикл
		ЗаполнитьЗначенияСвойств(РасшифровкаПлатежа.Добавить(),СтрокаТаблицыХранилища);
	КонецЦикла;
	
	ХозяйственнаяОперацияИнтеркампани = ВзаиморасчетыСервер.ХозяйственнаяОперацияИнтеркампани(ХозяйственнаяОперация);
	
	ОбновитьНаличиеРасхождений();
	
	УстановитьСвойстваПоляВводаДоговор();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	СтруктураРеквизитов = Новый Структура();
	СтруктураРеквизитов.Вставить("ГруппаФинансовогоУчета",  ГруппаФинансовогоУчета);
	СтруктураРеквизитов.Вставить("НаправлениеДеятельности", НаправлениеДеятельности);
	СтруктураРеквизитов.Вставить("Договор",                 Договор);
	СтруктураРеквизитов.Вставить("Подразделение",           Подразделение);
	
	Закрыть(СтруктураРеквизитов);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДоговорНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураОтбора = Новый Структура;
	СтруктураОтбора.Вставить("Организация", Организация);
	СтруктураОтбора.Вставить("ПометкаУдаления", Ложь);
	
	СтруктураПараметровВыбора = Новый Структура;
	СтруктураПараметровВыбора.Вставить("РежимВыбора", Истина);
	
	СписокПорядков = Новый СписокЗначений;
	СписокПорядков.Добавить(ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоЗаказамНакладным"));
	СписокПорядков.Добавить(ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоНакладным"));
	Если ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствОтПоставщика")
		ИЛИ ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствОтДругойОрганизации")
		ИЛИ ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВозвратОплатыКлиенту")
		ИЛИ ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствВДругуюОрганизацию") Тогда
		СписокПорядков.Добавить(ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоДоговорамКонтрагентов"));
	КонецЕсли;
	
	СтруктураПараметровВыбора.Вставить("ДоступныеПорядкиРасчетов", СписокПорядков);
	
	Если ХозяйственнаяОперацияИнтеркампани Тогда
		Если  ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствОтДругойОрганизации") ИЛИ
			ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВозвратДенежныхСредствВДругуюОрганизацию") Тогда
			СтруктураОтбора.Организация = Контрагент;
			СтруктураОтбора.Вставить("ОрганизацияПолучатель", Организация);
		Иначе
			СтруктураОтбора.Вставить("ОрганизацияПолучатель", Контрагент);
		КонецЕсли;
		СтруктураПараметровВыбора.Вставить("Отбор",СтруктураОтбора);
		ОткрытьФорму("Справочник.ДоговорыМеждуОрганизациями.Форма.ФормаВыбора",
			СтруктураПараметровВыбора,
			Элемент,
			Элемент,)
	Иначе
		СтруктураОтбора.Вставить("Контрагент", Контрагент);
		
		Если ФинансыКлиент.ЭтоРасчетыСКлиентами(ХозяйственнаяОперация) Тогда
			СтруктураПараметровВыбора.Вставить("ТипыДоговоров", ВзаиморасчетыКлиентСервер.ТипыДоговоровСКлиентом());
		Иначе
			СтруктураПараметровВыбора.Вставить("ТипыДоговоров", ВзаиморасчетыКлиентСервер.ТипыДоговоровСПоставщиком());
		КонецЕсли;
		
		СтруктураПараметровВыбора.Вставить("Отбор",СтруктураОтбора);
			ОткрытьФорму("Справочник.ДоговорыКонтрагентов.Форма.ФормаВыбора",
			СтруктураПараметровВыбора,
			Элемент,
			Элемент,)
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДоговорПриИзменении(Элемент)
	ОбновитьНаличиеРасхождений();
КонецПроцедуры

&НаКлиенте
Процедура ГруппаФинансовогоУчетаПриИзменении(Элемент)
	ОбновитьНаличиеРасхождений();
КонецПроцедуры

&НаКлиенте
Процедура НаправлениеДеятельностиПриИзменении(Элемент)
	ОбновитьНаличиеРасхождений();
КонецПроцедуры

&НаКлиенте
Процедура ПодразделениеПриИзменении(Элемент)
	ОбновитьНаличиеРасхождений();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьСвойстваПоляВводаДоговор()
	
	ИспользоватьДоговорыМеждуОрганизациями = ПолучитьФункциональнуюОпцию("ИспользоватьДоговорыМеждуОрганизациями");
	ИспользоватьДоговорыСКлиентами         = ПолучитьФункциональнуюОпцию("ИспользоватьДоговорыСКлиентами");
	ИспользоватьДоговорыСПоставщиками      = ПолучитьФункциональнуюОпцию("ИспользоватьДоговорыСПоставщиками");
	
	Если ХозяйственнаяОперацияИнтеркампани И ИспользоватьДоговорыМеждуОрганизациями 
		ИЛИ ВзаиморасчетыСервер.ХозяйственнаяОперацияСКлиентом(ХозяйственнаяОперация) И ИспользоватьДоговорыСКлиентами
		ИЛИ ВзаиморасчетыСервер.ХозяйственнаяОперацияСПоставщиком(ХозяйственнаяОперация) И ИспользоватьДоговорыСПоставщиками Тогда
		Элементы.Договор.Видимость = Истина;
	Иначе
		Элементы.Договор.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	МассивТипов = Новый Массив;
	
	Если НЕ ЗначениеЗаполнено(Договор) Тогда
		Если ТипЗнч(Контрагент) = Тип("СправочникСсылка.Организации") Тогда
			Договор = ПредопределенноеЗначение("Справочник.ДоговорыМеждуОрганизациями.ПустаяСсылка");
			МассивТипов.Добавить(Тип("СправочникСсылка.ДоговорыМеждуОрганизациями"));
		Иначе
			Договор = ПредопределенноеЗначение("Справочник.ДоговорыКонтрагентов.ПустаяСсылка");
			МассивТипов.Добавить(Тип("СправочникСсылка.ДоговорыКонтрагентов"));
		КонецЕсли;
	КонецЕсли;
	
	Элементы.Договор.ОграничениеТипа = Новый ОписаниеТипов(МассивТипов);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьНаличиеРасхождений()
	
	Если НЕ ЕстьОснованиеПлатежа Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураРеквизитов = Новый Структура();
	СтруктураРеквизитов.Вставить("ГруппаФинансовогоУчета  ", ГруппаФинансовогоУчета);
	СтруктураРеквизитов.Вставить("Договор                 ", Договор);
	СтруктураРеквизитов.Вставить("НаправлениеДеятельности ", НаправлениеДеятельности);
	СтруктураРеквизитов.Вставить("Подразделение           ", Подразделение);
	СтруктураРеквизитов.Вставить("ДокументСсылка          ", ДокументСсылка);
	
	РеквизитыНераспределенногоПлатежа = ВзаиморасчетыСервер.РеквизитыНераспределенногоПлатежа(РасшифровкаПлатежа, СтруктураРеквизитов);
	
	Если РеквизитыНераспределенногоПлатежа.Количество() > 0 Тогда
		Для Каждого Колонка Из РеквизитыНераспределенногоПлатежа.Колонки Цикл
			ТаблицаЗначений = РеквизитыНераспределенногоПлатежа.Скопировать(,Колонка.Имя);
			ТаблицаЗначений.Свернуть(Колонка.Имя);
			МассивЗначений = ТаблицаЗначений.ВыгрузитьКолонку(Колонка.Имя);
			Если МассивЗначений.Количество() > 1 Тогда
				Элементы["ГруппаСтраницыРасхождения" + Колонка.Имя].ТекущаяСтраница = Элементы["СтраницаЕстьРасхождения" + Колонка.Имя];
			Иначе
				Элементы["ГруппаСтраницыРасхождения" + Колонка.Имя].ТекущаяСтраница = Элементы["СтраницаНетРасхождений" + Колонка.Имя];
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
