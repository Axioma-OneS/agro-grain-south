﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриСозданииЧтенииНаСервере();
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	СобытияФормИСПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриСозданииЧтенииНаСервере();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НадписьПроизводителиНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФормуТабличнойЧасти(
		"Производители",
		"ОбщаяФорма.ПроизводителиВЕТИС");
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьПроизводственныеПартииНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФормуТабличнойЧасти(
		"ПроизводственныеПартии",
		"ОбщаяФорма.ПроизводственныеПартииВЕТИС");
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьУпаковкиШтрихкодыНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура;
	Параметрыформы.Вставить("Упаковки",          Объект.УпаковкиВЕТИС);
	Параметрыформы.Вставить("ШтрихкодыУпаковок", Объект.ШтрихкодыУпаковок);
	ПараметрыФормы.Вставить("ТолькоПросмотр",    ТолькоПросмотр);
	
	ОткрытьФорму("ОбщаяФорма.УпаковкиШтрихкодыВЕТИС",
		ПараметрыФормы,
		ЭтаФорма,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьВетеринарноСопроводительныеДокументыНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	КоличествоСтрок = Объект.ВетеринарноСопроводительныеДокументы.Количество();
	Если КоличествоСтрок <> 1 Тогда
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ВетеринарноСопроводительныеДокументы", Объект.ВетеринарноСопроводительныеДокументы);
		
		ОткрытьФорму("Справочник.ЗаписиСкладскогоЖурналаВЕТИС.Форма.ВетеринарноСопроводительныеДокументы",
			ПараметрыФормы,
			ЭтаФорма,,,,,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	Иначе
		
		ПоказатьЗначение(,Объект.ВетеринарноСопроводительныеДокументы[КоличествоСтрок - 1].ВетеринарноСопроводительныйДокумент);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьСрокГодностиНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОбработатьВводПериода("СрокГодности");
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьДатаПроизводстваНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОбработатьВводПериода("ДатаПроизводства");
	
КонецПроцедуры

&НаКлиенте
Процедура ПродукцияПриИзменении(Элемент)

	ДоступныеФорматы = ОбновитьДоступныеФорматыДат(Объект.Продукция);
	ДатаПроизводстваДоступнаяТочностьЗаполнения.ЗагрузитьЗначения(
		ДоступныеФорматы.ДатаПроизводстваДоступнаяТочностьЗаполнения);
		
	СрокГодностиДоступнаяТочностьЗаполнения.ЗагрузитьЗначения(ДоступныеФорматы.СрокГодностиДоступнаяТочностьЗаполнения);

	ТекущаяТочностьДоступна =
		ДатаПроизводстваДоступнаяТочностьЗаполнения.НайтиПоЗначению(Объект.ДатаПроизводстваТочностьЗаполнения);
	Если ТекущаяТочностьДоступна = Неопределено Тогда
		Объект.ДатаПроизводстваСтрока             = "";
		Объект.ДатаПроизводстваТочностьЗаполнения = Неопределено;
		Объект.ДатаПроизводстваНачалоПериода      = Неопределено;
		Объект.ДатаПроизводстваКонецПериода       = Неопределено;
	КонецЕсли;

	ТекущаяТочностьДоступна =
		СрокГодностиДоступнаяТочностьЗаполнения.НайтиПоЗначению(Объект.СрокГодностиТочностьЗаполнения);
		
	Если ТекущаяТочностьДоступна = Неопределено Тогда
		Объект.СрокГодностиСтрока             = "";
		Объект.СрокГодностиТочностьЗаполнения = Неопределено;
		Объект.СрокГодностиНачалоПериода      = Неопределено;
		Объект.СрокГодностиКонецПериода       = Неопределено;
	КонецЕсли;

	Если (ДатаПроизводстваДоступнаяТочностьЗаполнения.Количество() = 1 
		И ИнтеграцияВЕТИСКлиентСервер.ТочностьЗаполненияБезДаты(ДатаПроизводстваДоступнаяТочностьЗаполнения[0].Значение))
		Или ИнтеграцияВЕТИСКлиентСервер.ТочностьЗаполненияБезДаты(Объект.ДатаПроизводстваТочностьЗаполнения) Тогда
		Объект.ДатаПроизводстваСтрока             = "";
		Объект.ДатаПроизводстваТочностьЗаполнения = ДатаПроизводстваДоступнаяТочностьЗаполнения[0].Значение;
		Объект.ДатаПроизводстваНачалоПериода      = Неопределено;
		Объект.ДатаПроизводстваКонецПериода       = Неопределено;
	КонецЕсли;

	Если (СрокГодностиДоступнаяТочностьЗаполнения.Количество() = 1 
		И ИнтеграцияВЕТИСКлиентСервер.ТочностьЗаполненияБезДаты(СрокГодностиДоступнаяТочностьЗаполнения[0].Значение))
		Или ИнтеграцияВЕТИСКлиентСервер.ТочностьЗаполненияБезДаты(Объект.СрокГодностиТочностьЗаполнения) Тогда
		Объект.СрокГодностиСтрока             = "";
		Объект.СрокГодностиТочностьЗаполнения = СрокГодностиДоступнаяТочностьЗаполнения[0].Значение;
		Объект.СрокГодностиНачалоПериода      = Неопределено;
		Объект.СрокГодностиКонецПериода       = Неопределено;
	КонецЕсли;

	НастроитьЭлементыФормы();

КонецПроцедуры

&НаКлиенте
Процедура СкоропортящаясяПродукцияПриИзменении(Элемент)
	
	ПродукцияПриИзменении(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВетеринарныеМероприятия(Команда)
	
	ПараметрыОткрытияФормы = Новый Структура;
	ПараметрыОткрытияФормы.Вставить("ЗаписьСкладскогоЖурнала", Объект.Ссылка);
	
	ОткрытьФорму(
		"Справочник.ЗаписиСкладскогоЖурналаВЕТИС.Форма.ВетеринарныеМероприятия",
		ПараметрыОткрытияФормы,
		ЭтотОбъект);
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

//@skip-warning
&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаКлиенте
Процедура ОбработатьВводПериодаЗавершение(Результат, ДополнительныеПараметры) Экспорт 
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		
		НастроитьЭлементыФормы();
		
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры
 
&НаКлиенте
Процедура ОбработатьВводПериода(ВидПериода)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ВидПериода", ВидПериода);
	
	ОбработчикОповещения = Новый ОписаниеОповещения("ОбработатьВводПериодаЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	Если ВидПериода = "СрокГодности" Тогда
		ИнтеграцияВЕТИСКлиент.ОткрытьФормуРедактированияСрокаГодности(ЭтаФорма,
		Объект,
		ОбработчикОповещения,
		ТолькоПросмотр,
		СрокГодностиДоступнаяТочностьЗаполнения);
	Иначе
		ИнтеграцияВЕТИСКлиент.ОткрытьФормуРедактированияДатыПроизводства(ЭтаФорма,
		Объект,
		ОбработчикОповещения,
		ТолькоПросмотр,
		ДатаПроизводстваДоступнаяТочностьЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииЧтенииНаСервере()
	
	ЗаполнитьСлужебныеРеквизиты();
	
	НастроитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСлужебныеРеквизиты()
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ЗаписьСкладскогоЖурнала", Объект.Ссылка);
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	ОстаткиПродукцииВЕТИС.КоличествоВЕТИС КАК КоличествоВЕТИС,
	               |	ОстаткиПродукцииВЕТИС.ЕдиницаИзмеренияВЕТИС КАК ЕдиницаИзмеренияВЕТИС
	               |ИЗ
	               |	РегистрСведений.ОстаткиПродукцииВЕТИС КАК ОстаткиПродукцииВЕТИС
	               |ГДЕ
	               |	ОстаткиПродукцииВЕТИС.ЗаписьСкладскогоЖурнала = &ЗаписьСкладскогоЖурнала";
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, Выборка, "КоличествоВЕТИС, ЕдиницаИзмеренияВЕТИС");
	ИначеЕсли ЗначениеЗаполнено(Объект.Продукция) Тогда
		ДоступныеЕдиницыИзмерения = ИнтеграцияВЕТИСПовтИсп.ДоступныеЕдиницыИзменения(Объект.Продукция);
		Если ДоступныеЕдиницыИзмерения.Количество() > 0 Тогда
			ЕдиницаИзмеренияВЕТИС = ДоступныеЕдиницыИзмерения[0];
		КонецЕсли;
	КонецЕсли;
	
	ДоступныеФорматы = ОбновитьДоступныеФорматыДат(Объект.Продукция);
	ДатаПроизводстваДоступнаяТочностьЗаполнения.ЗагрузитьЗначения(ДоступныеФорматы.ДатаПроизводстваДоступнаяТочностьЗаполнения);
	СрокГодностиДоступнаяТочностьЗаполнения.ЗагрузитьЗначения(ДоступныеФорматы.СрокГодностиДоступнаяТочностьЗаполнения);
	Справочники.ПредприятияВЕТИС.ЗаполнитьНомера(Объект.Производители);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЭлементыФормы()
	
	Для каждого ВидПериода Из СтрРазделить("ДатаПроизводства,СрокГодности",",") Цикл
		
		ПредставлениеПериода = ИнтеграцияВЕТИСКлиентСервер.ПредставлениеПериодаВЕТИС(
			Объект[ВидПериода+"ТочностьЗаполнения"],
			Объект[ВидПериода+"НачалоПериода"],
			Объект[ВидПериода+"КонецПериода"],
			Объект[ВидПериода+"Строка"]);
			
		Если ПустаяСтрока(ПредставлениеПериода) Тогда
			ЭтаФорма["Надпись"+ВидПериода] = Новый ФорматированнаяСтрока(НСтр("ru = 'указать'"),,,,ВидПериода);
		Иначе
			ЭтаФорма["Надпись"+ВидПериода] = Новый ФорматированнаяСтрока(ПредставлениеПериода,,,,ВидПериода);
		КонецЕсли;
		
	КонецЦикла;
	
	НадписьПроизводители = ИнтеграцияВЕТИСКлиентСервер.СформироватьНадписьПоДаннымТабличнойЧасти(
		Объект.Производители,
		ИнтеграцияВЕТИСКлиентСервер.ПараметрыПредставленияТабличнойЧастиПроизводителей());
	
	НадписьПроизводственныеПартии = ИнтеграцияВЕТИСКлиентСервер.СформироватьНадписьПоДаннымТабличнойЧасти(
		Объект.ПроизводственныеПартии,
		ИнтеграцияВЕТИСКлиентСервер.ПараметрыПредставленияТабличнойЧастиПартий());
	
	НадписьВетеринарноСопроводительныеДокументы = ИнтеграцияВЕТИСКлиентСервер.СформироватьНадписьПоДаннымТабличнойЧасти(
		Объект.ВетеринарноСопроводительныеДокументы,
		"ВетеринарноСопроводительныйДокумент");
	
	НадписьУпаковкиШтрихкоды = ИнтеграцияВЕТИСКлиентСервер.СформироватьНадписьПоДаннымТабличнойЧасти(
		Объект.УпаковкиВЕТИС,
		ИнтеграцияВЕТИСКлиентСервер.ПараметрыПредставленияТабличнойЧастиУпаковок(2));
	
	ТипЖивыеЖивотные = ИнтеграцияВЕТИСВызовСервера.ПродукцияПринадлежитТипуЖивыеЖивотные(Объект.Продукция);
	ОтображатьСрокГодностиПоТочностиДаты = Истина;
	Если СрокГодностиДоступнаяТочностьЗаполнения.Количество() = 1 
		И ИнтеграцияВЕТИСКлиентСервер.ТочностьЗаполненияБезДаты(СрокГодностиДоступнаяТочностьЗаполнения[0].Значение) Тогда
		
		ОтображатьСрокГодностиПоТочностиДаты = Ложь;
	КонецЕсли;
	Элементы.НадписьСрокГодности.Видимость = НЕ ТипЖивыеЖивотные И ОтображатьСрокГодностиПоТочностиДаты;
	Элементы.НадписьУпаковкиШтрихкоды.Видимость = НЕ ТипЖивыеЖивотные;
	Элементы.НадписьДатаПроизводства.Заголовок = ИнтеграцияВЕТИСКлиентСервер.ПредставлениеПоляДатаПроизводства(ТипЖивыеЖивотные);
	
	ТолькоПросмотр = НЕ ОбщегоНазначения.РежимОтладки();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуТабличнойЧасти(ИмяТЧ, ИмяФормы, Оповещение = Неопределено)
	
	ПараметрыФормы = Новый Структура(ИмяТЧ, Объект[ИмяТЧ]);
	ПараметрыФормы.Вставить("ТолькоПросмотр", ТолькоПросмотр);
	
	ОткрытьФорму(
			ИмяФормы, 
			ПараметрыФормы, 
			ЭтаФорма,,,,, 
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОбновитьДоступныеФорматыДат(Продукция)

	ДоступныеФорматыДат = ИнтеграцияВЕТИСВызовСервера.СпецификаПродукции(Продукция);
	Возврат Новый Структура("ДатаПроизводстваДоступнаяТочностьЗаполнения, СрокГодностиДоступнаяТочностьЗаполнения",
		ДоступныеФорматыДат.ФорматДатыВыработкиМассивом, ДоступныеФорматыДат.ФорматСрокаГодностиМассивом);

КонецФункции
#КонецОбласти