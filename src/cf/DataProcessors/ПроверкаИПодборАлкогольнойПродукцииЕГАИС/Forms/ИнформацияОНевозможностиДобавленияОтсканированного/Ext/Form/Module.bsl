﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ИдентификаторСтрокиПозиционирования = - 1;
	ЭтоУпаковка                         = Ложь;
	
	Если ЭтоАдресВременногоХранилища(Параметры.АдресДереваУпаковок) Тогда
		
		ИнформацияВДереве = Истина;
		
		ДеревоУпаковки = ПолучитьИзВременногоХранилища(Параметры.АдресДереваУпаковок);
		
		Для Каждого СтрокаДерева Из ДеревоУпаковки.Строки Цикл
			
			ДобавитьСтрокуВДерево(ДеревоОтсканированнойУпаковки.ПолучитьЭлементы(), СтрокаДерева);
			
			ЭтоУпаковка = ИнтеграцияИСКлиентСервер.ЭтоУпаковка(СтрокаДерева.ТипУпаковки)
			              Или ДеревоУпаковки.Строки.Количество() > 0;
			
		КонецЦикла;
		
	Иначе
		
		ИнформацияВДереве = Ложь;
		ЭтоУпаковка       = Ложь;
		
	КонецЕсли;
	
	СброситьРазмерыИПоложениеОкна();
	
	Если ЭтоУпаковка Тогда
		
		ПоказатьИнформациюОПроблемахСУпаковкой();
		
	Иначе
		
		ПоказатьИнформациюОПроблемахСАлкогольнойПродукцией(ИнформацияВДереве);
		
	КонецЕсли;
	
	СобытияФормИСПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДекорацияОшибкаДобавленияАлкогольнойПродукцииОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "СкопироватьШтриховойКодВБуферОбмена" Тогда
		
		ИнтеграцияИСКлиент.СкопироватьШтрихКодВБуферОбмена(Элементы.БуферОбмена, Штрихкод);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоОтсканированнойУпаковки

&НаКлиенте
Процедура ДеревоОтсканированнойУпаковкиПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоОтсканированнойУпаковки.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено 
		И ТекущиеДанные.ЕстьОшибки Тогда
		
		ТекстОшибки = ТекущиеДанные.ТекстОшибки;
		
	Иначе
		
		ТекстОшибки = "";
		
	КонецЕсли;
	
	Элементы.ДекорацияПредставлениеОшибкиТекущейСтроки.Заголовок = ТекстОшибки;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СкрытьСтрокиБезПроблем(Команда)
	
	СкрытьБезПроблем = Не СкрытьБезПроблем;
	Элементы.ФормаСкрытьСтрокиБезПроблем.Пометка = СкрытьБезПроблем;
	
	Если СкрытьБезПроблем Тогда
		СкрытьСтрокиБезПроблемНаСервере();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ДобавитьСтрокуВДерево(КоллекцияСтрокПриемника, СтрокаИсточник);
	
	НоваяСтрока = КоллекцияСтрокПриемника.Добавить();
	ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаИсточник);
	ПроверкаИПодборПродукцииЕГАИСКлиентСервер.УстановитьИндексКартинкиТипаУпаковки(НоваяСтрока);
	
	Если НоваяСтрока.ТипУпаковки = Перечисления.ТипыУпаковок.МаркированныйТовар
		Или Не ЗначениеЗаполнено(НоваяСтрока.ТипУпаковки) Тогда
		КоличествоСтрокСАлкогольнойПродукцией = КоличествоСтрокСАлкогольнойПродукцией + 1;
	КонецЕсли;
	
	Если НоваяСтрока.ЕстьОшибки Тогда
		
		Если НоваяСтрока.ТипУпаковки = Перечисления.ТипыУпаковок.МаркированныйТовар
			Или Не ЗначениеЗаполнено(НоваяСтрока.ТипУпаковки) Тогда
			КоличествоСтрокСПроблемами = КоличествоСтрокСПроблемами + 1;
		КонецЕсли;
		
		СтрокаРодитель = НоваяСтрока.ПолучитьРодителя();
		
		Если СтрокаРодитель <> Неопределено Тогда
			
			ИдентификаторСтрокиРодителя = СтрокаРодитель.ПолучитьИдентификатор();
			Если ИдентификаторыРаскрываемыхСтрок.НайтиПоЗначению(ИдентификаторСтрокиРодителя) = Неопределено Тогда
				ИдентификаторыРаскрываемыхСтрок.Добавить(ИдентификаторСтрокиРодителя);
			КонецЕсли;
			
		КонецЕсли;
		
		Если ИдентификаторСтрокиПозиционирования = - 1 Тогда
			ИдентификаторСтрокиПозиционирования = НоваяСтрока.ПолучитьИдентификатор();
		КонецЕсли;
		
	КонецЕсли;
	
	Для Каждого ПодчиненнаяСтрока Из СтрокаИсточник.Строки Цикл
		
		ДобавитьСтрокуВДерево(НоваяСтрока.ПолучитьЭлементы(), ПодчиненнаяСтрока);
		
		Если ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ПодчиненнаяСтрока.ТипУпаковки) Тогда
			
			НоваяСтрока.СодержитУпаковок = НоваяСтрока.СодержитУпаковок + 1;
			
		Иначе 
			
			НоваяСтрока.СодержитБутылок = НоваяСтрока.СодержитБутылок + 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если ИнтеграцияИСКлиентСервер.ЭтоУпаковка(НоваяСтрока.ТипУпаковки) Тогда
		
		Для Каждого ПодчиненнаяСтрока Из НоваяСтрока.ПолучитьЭлементы() Цикл
			
			НоваяСтрока.СодержитУпаковок = НоваяСтрока.СодержитУпаковок + ПодчиненнаяСтрока.СодержитУпаковок;
			НоваяСтрока.СодержитБутылок  = НоваяСтрока.СодержитБутылок + ПодчиненнаяСтрока.СодержитБутылок;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если ИнтеграцияИСКлиентСервер.ЭтоУпаковка(НоваяСтрока.ТипУпаковки) Тогда
		
		Если НоваяСтрока.СодержитУпаковок > 0 
			И НоваяСтрока.СодержитБутылок > 0 Тогда
			
			НоваяСтрока.Представление = СтрШаблон(НСтр("ru = 'Упаковок - %1, Бутылок - %2.'"),
			                                      НоваяСтрока.СодержитУпаковок,
			                                      НоваяСтрока.СодержитБутылок);
			
		ИначеЕсли НоваяСтрока.СодержитУпаковок > 0 Тогда
			
			НоваяСтрока.Представление = СтрШаблон(НСтр("ru = 'Упаковок - %1.'"),
			                                      НоваяСтрока.СодержитУпаковок);
			
		ИначеЕсли НоваяСтрока.СодержитБутылок > 0 Тогда
			
			НоваяСтрока.Представление = СтрШаблон(НСтр("ru = 'Бутылок - %1.'"),
			                                      НоваяСтрока.СодержитБутылок);
			
		Иначе
			
			НоваяСтрока.Представление = НСтр("ru = '<пустая упаковка>'");
			
		КонецЕсли;
		
	Иначе
		
		Если ЗначениеЗаполнено(СтрокаИсточник.АлкогольнаяПродукция) Тогда
			НоваяСтрока.Представление = НоваяСтрока.АлкогольнаяПродукция;
		ИначеЕсли ЗначениеЗаполнено(СтрокаИсточник.Номенклатура) Тогда
			НоваяСтрока.Представление = ИнтеграцияИС.ПредставлениеНоменклатуры(
				СтрокаИсточник.Номенклатура,
				СтрокаИсточник.Характеристика,
				Неопределено,
				СтрокаИсточник.Серия);
		Иначе
			НоваяСтрока.Представление = НСтр("ru = '<не определена>'");
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
#Область ЕстьОшибки
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоОтсканированнойУпаковкиТекстОшибки.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоОтсканированнойУпаковки.ЕстьОшибки");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаПроблемаГосИС);

#КонецОбласти

#Область Отбор

	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоОтсканированнойУпаковки.Имя);
	
	ГруппаОтбора = Элемент.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаОтбора.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ;

	ОтборЭлемента = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("СкрытьБезПроблем");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	ОтборЭлемента = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоОтсканированнойУпаковки.НеСоответствуетОтбору");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветФона" , ЦветаСтиля.ЦветТекстаНеТребуетВниманияГосИС);

#КонецОбласти

#Область Представление

	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоОтсканированнойУпаковкиПредставление.Имя);
	
	ГруппаОтбора = Элемент.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаОтбора.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ;

	ОтборЭлемента = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоОтсканированнойУпаковки.ТипУпаковки");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыУпаковок.МаркированныйТовар;
	
	ОтборЭлемента = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоОтсканированнойУпаковки.АлкогольнаяПродукция");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаНеТребуетВниманияГосИС);

#КонецОбласти
	
КонецПроцедуры

&НаСервере
Процедура СкрытьСтрокиБезПроблемНаСервере()

	Если СкрытьБезПроблем Тогда
	
		СтрокиДерева = ДеревоОтсканированнойУпаковки.ПолучитьЭлементы();
		
		Для Каждого СтрокаДерева Из СтрокиДерева Цикл
			
			СоответствуетОтбору = Ложь;
			СкрытьБезОшибокВСтрокеДерева(СтрокаДерева, СоответствуетОтбору);
			
		КонецЦикла;
		
		Элементы.ФормаСкрытьСтрокиБезПроблем.Пометка = СкрытьБезПроблем;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СкрытьБезОшибокВСтрокеДерева(Знач СтрокаДерева, СоответствуетОтбору)

	Если ТипЗнч(СтрокаДерева) = Тип("Число") Тогда
		СтрокаДерева = ДеревоОтсканированнойУпаковки.НайтиПоИдентификатору(СтрокаДерева);
	КонецЕсли;
	
	ПодчиненныеСтроки = СтрокаДерева.ПолучитьЭлементы();

	ТекущаяСтрокаСоответствуетОтбору = Ложь;
	
	Для Каждого ПодчиненнаяСтрока Из ПодчиненныеСтроки Цикл
		
		СоответствуетОтбору = Ложь;
		
		СкрытьБезОшибокВСтрокеДерева(ПодчиненнаяСтрока, СоответствуетОтбору);
		
		Если СоответствуетОтбору Тогда
			ТекущаяСтрокаСоответствуетОтбору = Истина;
		КонецЕсли;
		
	КонецЦикла;

	Если Не ТекущаяСтрокаСоответствуетОтбору Тогда
		
		ТекущаяСтрокаСоответствуетОтбору = СтрокаДерева.ЕстьОшибки;
		
	КонецЕсли;
	
	СоответствуетОтбору = ТекущаяСтрокаСоответствуетОтбору;
	СтрокаДерева.НеСоответствуетОтбору = Не СоответствуетОтбору;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Для Каждого ЭлементСписка Из ИдентификаторыРаскрываемыхСтрок Цикл
		
		Элементы.ДеревоОтсканированнойУпаковки.Развернуть(ЭлементСписка.Значение, Ложь);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СформироватьИнформациюОПроблемах();
	
	ШаблонСообщения = НСтр("ru = 'Добавление отсканированной упаковки невозможно. Невозможно добавить единиц алкогольной продукции %1 из %2.'");
	Элементы.ДекорацияИнформацияОПроблемах.Заголовок = СтрШаблон(ШаблонСообщения, КоличествоСтрокСПроблемами, КоличествоСтрокСАлкогольнойПродукцией);
	
КонецПроцедуры

&НаСервере
Процедура СброситьРазмерыИПоложениеОкна()
	
	ИмяПользователя = ПользователиИнформационнойБазы.ТекущийПользователь().Имя;
	Если ПравоДоступа("СохранениеДанныхПользователя", Метаданные) Тогда
		ХранилищеСистемныхНастроек.Удалить("Обработка.ПроверкаИПодборАлкогольнойПродукцииЕГАИС.Форма.ИнформацияОНевозможностиДобавленияОтсканированного", "", ИмяПользователя);
	КонецЕсли;
	КлючСохраненияПоложенияОкна = Строка(Новый УникальныйИдентификатор);
	
КонецПроцедуры

&НаСервере
Процедура ПоказатьИнформациюОПроблемахСАлкогольнойПродукцией(ИнформацияВДереве)

	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаАлкогольнаяПродукция;
	Элементы.СтраницаУпаковка.Видимость    = Ложь;
	ЭтотОбъект.Ширина = 50;
	ЭтотОбъект.Высота = 10;
	Элементы.ЗакрытьАлкогольнаяПродукция.КнопкаПоУмолчанию = Истина;
	
	ПрефиксАлкогольнаяПродукцияИдентифицирована  = НСтр("ru = 'Невозможно добавить алкогольную продукцию ""%1"" с акцизной маркой'");
	ПрефиксАлкогольнаяПродукцияНеИдентифицирована = НСтр("ru = 'Невозможно добавить неопознанную алкогольную продукцию с акцизной маркой'");
	
	Если ИнформацияВДереве Тогда
	
		СтрокиВерхнегоУровня = ДеревоОтсканированнойУпаковки.ПолучитьЭлементы();
		
		Если СтрокиВерхнегоУровня.Количество() = 0 Тогда
			
			Элементы.ДекорацияОшибкаДобавленияАлкогольнойПродукции.Заголовок = НСтр("ru = 'Нет информации по отсканированному штрихкоду'");
			Возврат;
			
		Иначе
			
			ДанныеАлкогольнойПродукции = СтрокиВерхнегоУровня[0];
			
			Штрихкод               = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеАлкогольнойПродукции.ШтрихкодУпаковки, "ЗначениеШтрихкода");
			ТипШтрихкода           = Перечисления.ТипыШтрихкодов.Code128;
			ВидУпаковки            = Перечисления.ВидыУпаковокИС.Логистическая;
			АлкогольнаяПродукция   = ДанныеАлкогольнойПродукции.АлкогольнаяПродукция;
			ТекстОшибки            = ДанныеАлкогольнойПродукции.ТекстОшибки;
			
		КонецЕсли;
		
	Иначе
		
		Штрихкод             = Параметры.Штрихкод;
		ТипШтрихкода         = Параметры.ТипШтрихкода;
		ВидУпаковки          = Параметры.ВидУпаковки;
		АлкогольнаяПродукция = Параметры.АлкогольнаяПродукция;
		ТекстОшибки          = Параметры.ТекстОшибки;
		
		Если ТипШтрихкода = Перечисления.ТипыШтрихкодов.DataMatrix Тогда
			
			ПрефиксАлкогольнаяПродукцияИдентифицирована  = НСтр("ru = 'Невозможно добавить алкогольную продукцию ""%1"" с data matrix'");
			ПрефиксАлкогольнаяПродукцияНеИдентифицирована = НСтр("ru = 'Невозможно добавить неопознанную алкогольную продукцию с data matrix'");
			
		КонецЕсли;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(АлкогольнаяПродукция) Тогда
		Префикс = СтрШаблон(ПрефиксАлкогольнаяПродукцияИдентифицирована, АлкогольнаяПродукция);
	Иначе
		Префикс = ПрефиксАлкогольнаяПродукцияНеИдентифицирована;
	КонецЕсли;
	
	СтрокаШтриховойКод = Новый ФорматированнаяСтрока(
		ШтрихкодированиеЕГАИС.ПредставлениеШтрихкода(Штрихкод, ТипШтрихкода, ВидУпаковки),
		Новый Шрифт(,,,,Истина),
		ЦветаСтиля.ЦветГиперссылкиГосИС,,
		"СкопироватьШтриховойКодВБуферОбмена");
	
	ТекстСОшибкой = НСтр("ru = 'по причине:'") + Символы.ПС + ТекстОшибки;
	
	Элементы.ДекорацияОшибкаДобавленияАлкогольнойПродукции.Заголовок = 
		Новый ФорматированнаяСтрока(Префикс, " ", СтрокаШтриховойКод, " ", ТекстСОшибкой);

КонецПроцедуры

&НаСервере
Процедура ПоказатьИнформациюОПроблемахСУпаковкой()
	
	Элементы.СтраницыФормы.ТекущаяСтраница          = Элементы.СтраницаУпаковка;
	Элементы.СтраницаАлкогольнаяПродукция.Видимость = Ложь;
	
	ЭтотОбъект.Ширина = 200;
	ЭтотОбъект.Высота = 40;
	
	СкрытьСтрокиБезПроблемНаСервере();
	СформироватьИнформациюОПроблемах();
	
	Элементы.ДеревоОтсканированнойУпаковки.ТекущаяСтрока = ИдентификаторСтрокиПозиционирования;
	
КонецПроцедуры

#КонецОбласти
