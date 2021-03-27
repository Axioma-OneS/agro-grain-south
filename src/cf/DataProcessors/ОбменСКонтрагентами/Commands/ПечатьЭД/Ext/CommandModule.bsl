﻿
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ИмяМенеджераПечати = "Справочник.ЭДПрисоединенныеФайлы";
	ПараметрыПечати = Новый Структура;
	
	ДокументДляПечати = ПараметрыВыполненияКоманды.Источник.ПрисоединенныйФайлСсылка;
	
	Если Не ЗначениеЗаполнено(ДокументДляПечати) Тогда
		ВидОперации = НСтр("ru = 'Печать электронного документа'");
		ТекстСообщения = НСтр("ru = 'Не указан электронный документ для печати'");
		ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ОбработатьОшибку(ВидОперации, ТекстСообщения, ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	ИменаМакетов = ИменаМакетовДляВыводаНаПечать(ДокументДляПечати);
	
	ПараметрыПечати.Вставить("Идентификатор",  ИменаМакетов);
	ПараметрыПечати.Вставить("Представление",  НСтр("ru = 'Печать электронного документа'"));
	ПараметрыПечати.Вставить("ЗаголовокФормы", НСтр("ru = 'Печать электронного документа'"));
	
	Если ТипЗнч(ПараметрыВыполненияКоманды.Источник) = Тип("ФормаКлиентскогоПриложения") Тогда
		
		ДопПараметрыПечати = Новый Структура;
		ДопПараметрыПечати.Вставить("ОтключитьВыводДопДанных",     Истина);
		ДопПараметрыПечати.Вставить("ОтключитьВыводКопияВерна",    Истина);
		ДопПараметрыПечати.Вставить("ВыводитьБанковскиеРеквизиты", Ложь);
		
		ЗаполнитьЗначенияСвойств(ДопПараметрыПечати, ПараметрыВыполненияКоманды.Источник);
		
		ПараметрыПечати.Вставить("СкрыватьИдентификаторДокумента", Ложь);
		ПараметрыПечати.Вставить("СкрыватьДопДанные",              ДопПараметрыПечати.ОтключитьВыводДопДанных);
		ПараметрыПечати.Вставить("СкрыватьКопияВерна",             ДопПараметрыПечати.ОтключитьВыводКопияВерна);
		ПараметрыПечати.Вставить("ВыводитьБанковскиеРеквизиты",    ДопПараметрыПечати.ВыводитьБанковскиеРеквизиты);
		
	КонецЕсли;
	
	УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(ИмяМенеджераПечати, ИменаМакетов,
		ДокументДляПечати, ПараметрыВыполненияКоманды.Источник, ПараметрыПечати);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ИменаМакетовДляВыводаНаПечать(Знач ФайлЭлектронногоДокумента)
	
	Если ОбменСКонтрагентамиСлужебный.ЭтоСлужебныйДокумент(ФайлЭлектронногоДокумента)
		И ОбменСКонтрагентамиСлужебный.ВходящийТитул(ФайлЭлектронногоДокумента) = Неопределено Тогда
		ИменаМакетов = "ЭД";
		
	ИначеЕсли ЭтоПроизвольныйДокумент(ФайлЭлектронногоДокумента) Тогда
		ИменаМакетов = "КарточкаЭД";
		
	Иначе
		ИменаМакетов = "ЭД,КарточкаЭД";
		
	КонецЕсли;
	
	Возврат ИменаМакетов
	
КонецФункции

&НаСервере
Функция ЭтоПроизвольныйДокумент(ФайлЭлектронногоДокумента)
	
	ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
		ФайлЭлектронногоДокумента, "ВладелецФайла.ВидЭД,Расширение");
	
	Если ЗначенияРеквизитов.ВладелецФайлаВидЭД <> Перечисления.ВидыЭД.ПроизвольныйЭД Тогда
		Возврат Ложь;
	ИначеЕсли ЗначенияРеквизитов.Расширение <> "xml" Тогда
		Возврат Истина;
	КонецЕсли;
	
	ДанныеФайлаXML = РаботаСФайлами.ДвоичныеДанныеФайла(ФайлЭлектронногоДокумента);
	Если ДанныеФайлаXML = Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	ПараметрыФайлаXML = ОбменСКонтрагентамиСлужебный.ПараметрыФайлаПроизвольногоДокумента(
		ДанныеФайлаXML, Ложь);
	
	Возврат ПараметрыФайлаXML = Неопределено;
	
КонецФункции

#КонецОбласти