﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Коммерческие предложения".
// ОбщийМодуль.КоммерческиеПредложенияСлужебныйКлиент.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура ОтправитьЗапросКоммерческихПредложенийСертификатыПолучены(Результат, ПараметрыОтправки) Экспорт
	
	ОтпечаткиСертификатов = Новый Массив;
	
	Если ТипЗнч(Результат) = Тип("Соответствие") Тогда
		Для Каждого Отпечаток Из Результат Цикл
			ОтпечаткиСертификатов.Добавить(Отпечаток.Ключ);
		КонецЦикла;
	КонецЕсли;
	
	ПараметрыОтправки.Вставить("ОтпечаткиСертификатов", ОтпечаткиСертификатов);
	
	Результат = КоммерческиеПредложенияСлужебныйВызовСервера.ОтправитьЗапросКоммерческихПредложений(ПараметрыОтправки);
	
	Если Результат.ДлительнаяОперация <> Неопределено Тогда
		
		ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Неопределено);
		ПараметрыОжидания.ВыводитьПрогрессВыполнения = Ложь;
		ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
		ПараметрыОжидания.ОповещениеПользователя.Показать = Ложь;
		ПараметрыОжидания.ВыводитьСообщения = Истина;
		
		ПараметрыЗавершения = Новый Структура;
		ПараметрыЗавершения.Вставить("ЗапросКоммерческихПредложений", ПараметрыОтправки.ЗапросКоммерческихПредложений);
		
		ОтправкаПродолжение = Новый ОписаниеОповещения("ОтправитьЗапросКоммерческихПредложенийПродолжение",
			КоммерческиеПредложенияСлужебныйКлиент, ПараметрыЗавершения);
		
		ДлительныеОперацииКлиент.ОжидатьЗавершение(Результат.ДлительнаяОперация, ОтправкаПродолжение, ПараметрыОжидания);
		
	ИначеЕсли Результат.СостояниеДокумента <> Неопределено Тогда
		
		ЗавершениеОтправки = Новый ОписаниеОповещения("ОтправитьЗапросКоммерческихПредложенийЗавершение", ЭтотОбъект,
			Результат.СостояниеДокумента);
		
		ВыполнитьОбработкуОповещения(ЗавершениеОтправки);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОтправитьЗапросКоммерческихПредложенийПродолжение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат.Статус = "Выполнено" Тогда
		
		РезультатОтправки = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
		
		НовыеЭлектронныеДокументы = Неопределено;
		РезультатОтправки.Свойство("НовыеЭлектронныеДокументы", НовыеЭлектронныеДокументы);
		
		ЗавершениеОтправки = Новый ОписаниеОповещения("ОтправитьЗапросКоммерческихПредложенийЗавершение", ЭтотОбъект,
			РезультатОтправки.СостояниеДокумента);
		
		Если ЗначениеЗаполнено(НовыеЭлектронныеДокументы) Тогда
			ОбменСКонтрагентамиСлужебныйКлиент.ОбработатьЭД(Неопределено, "СформироватьУтвердитьПодписатьОтправить",
				Неопределено, РезультатОтправки.НовыеЭлектронныеДокументы, ЗавершениеОтправки);
		Иначе
			ВыполнитьОбработкуОповещения(ЗавершениеОтправки);
		КонецЕсли;
		
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		
		ЗавершениеОтправки = Новый ОписаниеОповещения("ОтправитьЗапросКоммерческихПредложенийЗавершение", ЭтотОбъект,
			КоммерческиеПредложенияСлужебныйВызовСервера.СостояниеЗапросаКоммерческихПредложенийПоставщиков(
			ДополнительныеПараметры.ЗапросКоммерческихПредложений));
		
		ВыполнитьОбработкуОповещения(ЗавершениеОтправки);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОтправитьЗапросКоммерческихПредложенийЗавершение(Результат, СостояниеДокумента) Экспорт
	
	Оповестить("ОтправкаЗапросаКоммерческихПредложений", СостояниеДокумента, СостояниеДокумента.Документ);
	
КонецПроцедуры

Процедура ОтменитьЗапросКоммерческихПредложенийЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СостояниеДокумента       = Неопределено;
	СтатусДлительнойОперации = Неопределено;
	
	Результат.Свойство("СостояниеДокумента", СостояниеДокумента);
	Результат.Свойство("Статус",             СтатусДлительнойОперации);
	
	Если Не ЗначениеЗаполнено(СостояниеДокумента) Тогда
		
		Если СтатусДлительнойОперации = "Выполнено" Тогда
			
			РезультатОперации  = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
			СостояниеДокумента = РезультатОперации.СостояниеДокумента;
			
		ИначеЕсли СтатусДлительнойОперации = "Ошибка" Тогда
			
			СостояниеДокумента = 
				КоммерческиеПредложенияСлужебныйВызовСервера.СостояниеЗапросаКоммерческихПредложенийПоставщиков(
				ДополнительныеПараметры.ЗапросКоммерческихПредложений);
			
		Иначе
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
	Оповестить("ОтменаЗапросаКоммерческихПредложений", СостояниеДокумента, СостояниеДокумента.Документ);
	
КонецПроцедуры

#КонецОбласти