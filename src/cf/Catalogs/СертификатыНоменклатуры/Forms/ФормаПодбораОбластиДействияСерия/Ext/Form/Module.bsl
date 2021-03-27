﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	РежимОтображенияСерий = "ВсеСерии";
	Элементы.СкладОтбор.Доступность = Ложь;
	Элементы.ПомещениеОтбор.Доступность  = Ложь;
	
	Параметры.Свойство("Номенклатура", НоменклатураОтборСерии);
	ХарактеристикаОтбор = Параметры.Характеристика;
	ВидНоменклатуры = Параметры.ВидНоменклатуры;	
	Если Не Параметры.ХарактеристикиИспользуются Тогда
		ХарактеристикаОтборНадпись = НСтр("ru='<не используется>'");
	ИначеЕсли ЗначениеЗаполнено(ХарактеристикаОтбор) Тогда
		ХарактеристикаОтборНадпись = ХарактеристикаОтбор;
	КонецЕсли;
	
	УстановитьСписокСкладовССериями(ВидНоменклатуры);	
	
	ПараметрыШаблона = Новый ФиксированнаяСтруктура(ЗначениеНастроекПовтИсп.НастройкиИспользованияСерий(ВидНоменклатуры));
	
	Элементы.СписокСерийГоденДоВсеСерии.Видимость         = ПараметрыШаблона.ИспользоватьСрокГодностиСерии;
	Элементы.СписокСерийГоденДоТолькоСОстатками.Видимость = ПараметрыШаблона.ИспользоватьСрокГодностиСерии;
	Элементы.СписокСерийНомерВсеСерии.Видимость 		  = ПараметрыШаблона.ИспользоватьНомерСерии;
	Элементы.СписокСерийНомерТолькоСОстатками.Видимость   = ПараметрыШаблона.ИспользоватьНомерСерии;
	
	ВыполнитьЗапросЗаполненияТаблицыСерий();
	
	ЗаголовокСвободногоОстатка = НСтр("ru = 'Свободный остаток, %ЕдиницаИзмерения%'");
	ЕдиницаИзмеренияПредставление = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НоменклатураОтборСерии,"ЕдиницаИзмерения");
	ЗаголовокСвободногоОстатка = СтрЗаменить(ЗаголовокСвободногоОстатка,
		"%ЕдиницаИзмерения%",
		ЕдиницаИзмеренияПредставление);
	Элементы.СписокСерийСвободныйОстатокТолькоСОстатками.Заголовок = ЗаголовокСвободногоОстатка;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РежимОтображенияСерийПриИзменении(Элемент)
	
	УстановитьДоступностьЭлементовОтРежимаОтображенияСерий();
	
	Если РежимОтображенияСерий = "ВсеСерии" Тогда
		Элементы.СтраницыСписка.ТекущаяСтраница = Элементы.СтраницаСписокСерийВсеСерии;
	Иначе
		Элементы.СтраницыСписка.ТекущаяСтраница = Элементы.СтраницаСписокСерийТолькоСОстатками;
	КонецЕсли;

	РежимОтображенияСерийПриИзмененииНаСервере();	
		
КонецПроцедуры

&НаКлиенте
Процедура СкладОтборПриИзменении(Элемент)
	СкладОтборПриИзмененииНаСервере();	
КонецПроцедуры

&НаКлиенте
Процедура ПомещениеОтборПриИзменении(Элемент)
	
	ВыполнитьЗапросЗаполненияТаблицыСерий();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокСерий
 
&НаКлиенте
Процедура СписокСерийВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьЗначение();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ВыбратьЗначение();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура РежимОтображенияСерийПриИзмененииНаСервере()	
	УстановитьВидимостьПомещений();	
	ВыполнитьЗапросЗаполненияТаблицыСерий();
КонецПроцедуры

&НаСервере
Процедура СкладОтборПриИзмененииНаСервере()	
	УстановитьВидимостьПомещений();
	ВыполнитьЗапросЗаполненияТаблицыСерий();
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьЗначение()
	
	Если РежимОтображенияСерий = "ВсеСерии" Тогда
		Если Элементы.СписокСерийВсеСерии.ТекущиеДанные <> Неопределено Тогда
			ОповеститьОВыборе(Элементы.СписокСерийВсеСерии.ТекущиеДанные.Серия);
		КонецЕсли;	
	Иначе
		 Если Элементы.СписокСерийТолькоСОстатками.ТекущиеДанные <> Неопределено Тогда
			ОповеститьОВыборе(Элементы.СписокСерийТолькоСОстатками.ТекущиеДанные.Серия);
		КонецЕсли;	
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура УстановитьСписокСкладовССериями(ВидНоменклатуры)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыНоменклатурыПолитикиУчетаСерий.Склад
	|ИЗ
	|	Справочник.ВидыНоменклатуры.ПолитикиУчетаСерий КАК ВидыНоменклатурыПолитикиУчетаСерий
	|ГДЕ
	|	ВидыНоменклатурыПолитикиУчетаСерий.Ссылка = &ВидНоменклатуры";
	Запрос.УстановитьПараметр("ВидНоменклатуры", ВидНоменклатуры);
	
	МассивСкладов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Склад");
	Элементы.СкладОтбор.СписокВыбора.ЗагрузитьЗначения(МассивСкладов);
	
	Если МассивСкладов.Количество() = 1 Тогда
		СкладОтбор = МассивСкладов[0];
	КонецЕсли;
	
	УстановитьВидимостьПомещений();
	
КонецПроцедуры

&НаСервере
Процедура ВыполнитьЗапросЗаполненияТаблицыСерий()
					
	Если РежимОтображенияСерий = "ТолькоОстатки" Тогда
		ВариантПолучениеДанныхИзРегистров = "ТоварыНаСкладахБезУчетаНазначений";
		
		Если ЗначениеЗаполнено(СкладОтбор) Тогда
			Если ИспользоватьСкладскиеПомещения	
				И Не ЗначениеЗаполнено(ПомещениеОтбор) Тогда
				СписокСерий.Очистить();
				Возврат;	
			КонецЕсли;	
		Иначе
			СписокСерий.Очистить();
			Возврат;
		КонецЕсли;

	Иначе
		ВариантПолучениеДанныхИзРегистров = "ВсеСерииНоменклатуры";
	КонецЕсли;
	
	ТекстЗапроса = Обработки.ПодборСерийВДокументы.ТекстЗапросаФормированияТаблицыДанныеРегистров(ВариантПолучениеДанныхИзРегистров);
	
	ТекстЗапроса = ТекстЗапроса + "
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|";
		
	ТекстЗапроса = ТекстЗапроса + 
	"ВЫБРАТЬ
	|	ДанныеРегистров.Серия,
	|	ДанныеРегистров.СвободныйОстаток КАК СвободныйОстаток,
	|	0 КАК Количество,
	|	0 КАК КоличествоУпаковок,
	|	ВЫРАЗИТЬ(ДанныеРегистров.Серия КАК Справочник.СерииНоменклатуры).Номер КАК Номер,
	|	ВЫРАЗИТЬ(ДанныеРегистров.Серия КАК Справочник.СерииНоменклатуры).ГоденДо КАК ГоденДо
	|ИЗ
	|		ДанныеРегистров КАК ДанныеРегистров
	|ГДЕ
	|	ДанныеРегистров.Серия <> ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка)
	|	И (&ВсеСерии
	|		ИЛИ ДанныеРегистров.СвободныйОстаток > 0)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ГоденДо,
	|	Номер";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	Запрос.УстановитьПараметр("Номенклатура", НоменклатураОтборСерии);
	Запрос.УстановитьПараметр("Характеристика", ХарактеристикаОтбор);
	Запрос.УстановитьПараметр("Склад", СкладОтбор);
	Запрос.УстановитьПараметр("Помещение", ПомещениеОтбор);
	Запрос.УстановитьПараметр("КоэффициентУпаковки", 1);
	Запрос.УстановитьПараметр("ВсеСерии", РежимОтображенияСерий = "ВсеСерии");
	Запрос.УстановитьПараметр("ЗнакОстатка", 1);
	
	СписокСерий.Загрузить(Запрос.Выполнить().Выгрузить());
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьЭлементовОтРежимаОтображенияСерий()
	
	Если РежимОтображенияСерий = "ВсеСерии" Тогда
		Элементы.СкладОтбор.Доступность = Ложь;
		Элементы.ПомещениеОтбор.Доступность  = Ложь;
	Иначе
		Элементы.СкладОтбор.Доступность = Истина;
		Элементы.ПомещениеОтбор.Доступность  = Истина;	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьПомещений()
	
	ИспользоватьСкладскиеПомещения = СкладыСервер.ИспользоватьСкладскиеПомещения(СкладОтбор,,Ложь);
	Элементы.ПомещениеОтбор.Видимость = ИспользоватьСкладскиеПомещения;
	
КонецПроцедуры

#КонецОбласти

