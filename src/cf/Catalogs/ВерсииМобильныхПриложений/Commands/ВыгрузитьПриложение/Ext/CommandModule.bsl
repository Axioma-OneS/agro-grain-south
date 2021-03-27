﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Если ПараметрКоманды.Пустая() Тогда
		ТекстСообщения = НСтр("ru='Не указана версия приложения для выгрузки'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Возврат;		
	КонецЕсли;
	
	ВыгрузитьПриложение(ПараметрКоманды);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
// Выполняет выгрузку приложения в указанный файл на диске.
//
// Параметры:
//  ВерсияМобильногоПриложения - ссылка на элемент справочника, соответствующий приложению,
//  которое требуется выгрузить.
//
Процедура ВыгрузитьПриложение(ВерсияМобильногоПриложения)
	
	#Если Не ВебКлиент Тогда
		
		СтруктураПриложения = ОписаниеПриложения(ВерсияМобильногоПриложения);
		
		Если СтруктураПриложения.ЭтоГруппа Тогда
			ТекстСообщения = НСтр("ru='Не выбрана версия приложения для выгрузки'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецЕсли;
		
		РежимДиалога = РежимДиалогаВыбораФайла.Сохранение;	
		ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалога);		
		ДиалогВыбораФайла.Заголовок = НСтр("ru='Укажите имя файла для выгрузки приложения'");
		
		ДиалогВыбораФайла.ПолноеИмяФайла = НСтр("ru='Мобильное приложение'")
		    + " "
			+ СтруктураПриложения.ИмяПриложения + НСтр("ru='_Версия'")
			+ " "
			+ СтруктураПриложения.НомерВерсии;
			
		ДиалогВыбораФайла.Расширение = "xml";
		ДиалогВыбораФайла.Фильтр = "xml";
		
		Если ДиалогВыбораФайла.Выбрать() Тогда
			
			ИмяФайла = ДиалогВыбораФайла.ПолноеИмяФайла;
			
			ЗаписьXML = Новый ЗаписьXML();
			ЗаписьXML.ОткрытьФайл(ИмяФайла,"UTF-8");
			ЗаписьXML.ЗаписатьОбъявлениеXML();
			
			ЗаписьXML.ЗаписатьНачалоЭлемента("MobileApplicationVersionData");
			
			ЗаписьXML.ЗаписатьНачалоЭлемента("ApplicationName");
			ЗаписьXML.ЗаписатьТекст(СтруктураПриложения.ИмяПриложения);
			ЗаписьXML.ЗаписатьКонецЭлемента();
			
			ЗаписьXML.ЗаписатьНачалоЭлемента("Version");
			ЗаписьXML.ЗаписатьТекст(СтруктураПриложения.НомерВерсии);
			ЗаписьXML.ЗаписатьКонецЭлемента();
			
			ЗаписьXML.ЗаписатьНачалоЭлемента("Application");
			ЗаписьXML.ЗаписатьТекст(СтруктураПриложения.Приложение);
			ЗаписьXML.ЗаписатьКонецЭлемента();
			
			ЗаписьXML.ЗаписатьНачалоЭлемента("Metadata");
			ЗаписьXML.ЗаписатьТекст(СтруктураПриложения.Метаданные);
			ЗаписьXML.ЗаписатьКонецЭлемента();
			
			ЗаписьXML.ЗаписатьКонецЭлемента();
			
			ЗаписьXML.Закрыть();
			
			ТекстСообщения = НСтр("ru='Приложение выгружено'");
			ПоказатьОповещениеПользователя("",,ТекстСообщения);
			
		КонецЕсли;
		
	#КонецЕсли
	
КонецПроцедуры

&НаСервере
// Получает структуру, содержащую данные указанного приложения.
//
// Параметры:
//  Ссылка - ссылка на элемент справочника, содержащий данные приложения.
//
// Возвращаемое значение:
//  Структура, содержащая данные приложения.
//
Функция ОписаниеПриложения(Ссылка)
	
	СтруктураПриложения = Новый Структура();
	СтруктураПриложения.Вставить("ЭтоГруппа", Ссылка.ЭтоГруппа);
	
	Если СтруктураПриложения.ЭтоГруппа Тогда
		Возврат СтруктураПриложения;
	КонецЕсли;	
	
	СтруктураПриложения.Вставить("Приложение", Ссылка.МобильноеПриложение);
	СтруктураПриложения.Вставить("ИмяПриложения", Ссылка.Родитель.Наименование);
	СтруктураПриложения.Вставить("НомерВерсии", Ссылка.Код);
	СтруктураПриложения.Вставить("Метаданные", Ссылка.ИспользуемыеМетаданные);
	
	Возврат СтруктураПриложения;
	
КонецФункции

#КонецОбласти