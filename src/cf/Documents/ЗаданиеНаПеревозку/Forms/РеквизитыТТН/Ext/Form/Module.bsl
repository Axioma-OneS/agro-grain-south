﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	НужноЗадаватьВопросПередЗакрытием = Истина;
	
	ЗаполнитьЗначенияСвойств(МакетДокумента, Параметры);
	МакетДокумента.Водитель = Параметры.ВодительФИО;
	
	Партнер = Параметры.Партнер;
	
	Документы.ТранспортнаяНакладная.УстановитьСписокВыбораФИОВодителей(Элементы.Водитель, , Параметры.ЗаданиеНаПеревозку);
	Документы.ТранспортнаяНакладная.УстановитьСписокВыбораТранспортныхСредств(Элементы.АвтомобильГосударственныйНомер, ,
		Параметры.ЗаданиеНаПеревозку);
	Документы.ТранспортнаяНакладная.УстановитьСписокВыбораТиповТранспортныхСредств(Элементы.АвтомобильТип, ,
		Параметры.ЗаданиеНаПеревозку);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если Модифицированность
		И НужноЗадаватьВопросПередЗакрытием Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ОповещениеЗакрытия = Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект);
		ТекстВопроса       = НСтр("ru = 'Данные были изменены. Сохранить изменения?'");
		
		ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(ОповещениеЗакрытия, Отказ, ЗавершениеРаботы, ТекстВопроса,
			ТекстПредупреждения);
		
		Возврат;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	НужноЗадаватьВопросПередЗакрытием = Ложь;
	ЗавершитьРедактированиеРеквизитовТТН();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПеревозчикПриИзменении(Элемент)
	
	ПеревозчикПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ВодительОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ВыбранноеЗначение.Свойство("Водитель", 				МакетДокумента.Водитель);
	ВыбранноеЗначение.Свойство("УдостоверениеСерия", 	МакетДокумента.УдостоверениеСерия);
	ВыбранноеЗначение.Свойство("УдостоверениеНомер",	МакетДокумента.УдостоверениеНомер);
КонецПроцедуры

&НаКлиенте
Процедура ВодительОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)
	ВодительЗаписан = Ложь;	
	Для Каждого ИнформацияВодителя Из Элемент.СписокВыбора Цикл
		Если ИнформацияВодителя.Значение.Водитель = Текст Тогда 
			ВодительЗаписан = Истина
		КонецЕсли;
	КонецЦикла;
	Если Не ВодительЗаписан Тогда
		МакетДокумента.УдостоверениеНомер = "";
		МакетДокумента.УдостоверениеСерия  = "";
		МакетДокумента.Водитель			  = Текст;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура АвтомобильГосударственныйНомерОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ВыбранноеЗначение.Свойство("АвтомобильМарка",							МакетДокумента.АвтомобильМарка);
	ВыбранноеЗначение.Свойство("АвтомобильГосударственныйНомер",			МакетДокумента.АвтомобильГосударственныйНомер);
	ВыбранноеЗначение.Свойство("ЛицензионнаяКарточкаВид",					МакетДокумента.ЛицензионнаяКарточкаВид);
	ВыбранноеЗначение.Свойство("ЛицензионнаяКарточкаНомер",					МакетДокумента.ЛицензионнаяКарточкаНомер);
	ВыбранноеЗначение.Свойство("ЛицензионнаяКарточкаРегистрационныйНомер",	МакетДокумента.ЛицензионнаяКарточкаРегистрационныйНомер);
	ВыбранноеЗначение.Свойство("ЛицензионнаяКарточкаСерия",					МакетДокумента.ЛицензионнаяКарточкаСерия);
	ВыбранноеЗначение.Свойство("Прицеп",									МакетДокумента.Прицеп);
	ВыбранноеЗначение.Свойство("ГосударственныйНомерПрицепа",				МакетДокумента.ГосударственныйНомерПрицепа);
	ВыбранноеЗначение.Свойство("ВидПеревозки",								МакетДокумента.ВидПеревозки);
	ВыбранноеЗначение.Свойство("АвтомобильВместимостьВКубическихМетрах",	МакетДокумента.АвтомобильВместимостьВКубическихМетрах);
	ВыбранноеЗначение.Свойство("АвтомобильГрузоподъемностьВТоннах",			МакетДокумента.АвтомобильГрузоподъемностьВТоннах);
	ВыбранноеЗначение.Свойство("АвтомобильТип",								МакетДокумента.АвтомобильТип);
КонецПроцедуры

&НаКлиенте
Процедура АвтомобильТипОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ВыбранноеЗначение.Свойство("АвтомобильВместимостьВКубическихМетрах",	МакетДокумента.АвтомобильВместимостьВКубическихМетрах);
	ВыбранноеЗначение.Свойство("АвтомобильГрузоподъемностьВТоннах",			МакетДокумента.АвтомобильГрузоподъемностьВТоннах);
	ВыбранноеЗначение.Свойство("АвтомобильТип",								МакетДокумента.АвтомобильТип);
КонецПроцедуры

&НаКлиенте
Процедура АвтомобильТипОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)
	ТранспортноеСредствоЗаписано = Ложь;	
	Для Каждого ИнформацияТранспорногоСредства Из Элемент.СписокВыбора Цикл
		Если ИнформацияТранспорногоСредства.Значение.АвтомобильТип = Текст Тогда 
			ТранспортноеСредствоЗаписано = Истина
		КонецЕсли;
	КонецЦикла;
	Если Не ТранспортноеСредствоЗаписано Тогда
		МакетДокумента.АвтомобильГрузоподъемностьВТоннах  		= "";
		МакетДокумента.АвтомобильВместимостьВКубическихМетрах  	= "";
		МакетДокумента.АвтомобильТип							= Текст;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	НужноЗадаватьВопросПередЗакрытием = Ложь;
	ЗавершитьРедактированиеРеквизитовТТН();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПеревозчикПриИзмененииСервер()
	
	МакетДокумента.БанковскийСчетПеревозчика = Справочники.БанковскиеСчетаКонтрагентов.ПолучитьБанковскийСчетПоУмолчанию(
		МакетДокумента.Перевозчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьРедактированиеРеквизитовТТН()
	
	ПараметрыЗакрытия = Новый Структура;
	ПараметрыЗакрытия.Вставить("Контрагент", МакетДокумента.Перевозчик);
	ПараметрыЗакрытия.Вставить("БанковскийСчетПеревозчика");
	ПараметрыЗакрытия.Вставить("УдостоверениеСерия");
	ПараметрыЗакрытия.Вставить("УдостоверениеНомер");
	ПараметрыЗакрытия.Вставить("АвтомобильГосударственныйНомер");
	ПараметрыЗакрытия.Вставить("АвтомобильМарка");
	ПараметрыЗакрытия.Вставить("ВидПеревозки");
	ПараметрыЗакрытия.Вставить("АвтомобильТип");
	ПараметрыЗакрытия.Вставить("АвтомобильВместимостьВКубическихМетрах");
	ПараметрыЗакрытия.Вставить("АвтомобильГрузоподъемностьВТоннах");
	ПараметрыЗакрытия.Вставить("ЛицензионнаяКарточкаСерия");
	ПараметрыЗакрытия.Вставить("ЛицензионнаяКарточкаНомер");
	ПараметрыЗакрытия.Вставить("ЛицензионнаяКарточкаВид");
	ПараметрыЗакрытия.Вставить("ЛицензионнаяКарточкаРегистрационныйНомер");
	ПараметрыЗакрытия.Вставить("Прицеп");
	ПараметрыЗакрытия.Вставить("ГосударственныйНомерПрицепа");
	
	ЗаполнитьЗначенияСвойств(ПараметрыЗакрытия, МакетДокумента);
	
	ПараметрыЗакрытия.Вставить("ВодительФИО", МакетДокумента.Водитель);
	
	Закрыть(ПараметрыЗакрытия);
	
КонецПроцедуры

#КонецОбласти