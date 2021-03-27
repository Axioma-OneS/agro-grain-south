﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Элементы.Назначение.СписокВыбора.Добавить(Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляТоваров);
	Элементы.Назначение.СписокВыбора.Добавить(Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЦенникДляТоваров);
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьАдресноеХранение", Новый Структура)
		 ИЛИ ПолучитьФункциональнуюОпцию("ИспользоватьАдресноеХранениеСправочно", Новый Структура) Тогда
		Элементы.Назначение.СписокВыбора.Добавить(Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляСкладскихЯчеек);
	КонецЕсли;
	Если ПолучитьФункциональнуюОпцию("ИспользоватьУправлениеДоставкой") Тогда
		Элементы.Назначение.СписокВыбора.Добавить(Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляДоставки);
	КонецЕсли;
	Если ПолучитьФункциональнуюОпцию("ИспользоватьСерииНоменклатуры") Тогда
		Элементы.Назначение.СписокВыбора.Добавить(Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаСерииНоменклатуры);
	КонецЕсли;
	Если ПолучитьФункциональнуюОпцию("ИспользоватьУпаковочныеЛисты") Тогда
		Элементы.Назначение.СписокВыбора.Добавить(Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаУпаковочныхЛистов);
	КонецЕсли;

	
	Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(Параметры, "ЗначенияЗаполнения")
		И ТипЗнч(Параметры.ЗначенияЗаполнения) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, Параметры.ЗначенияЗаполнения);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Назначение) Тогда
		Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляТоваров;
	КонецЕсли;
	
	ПриИзмененииНазначенияСервер();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	Элементы.Назначение.СписокВыбора.СортироватьПоПредставлению();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НазначениеПриИзменении(Элемент)
	ПриИзмененииНазначенияСервер();
КонецПроцедуры

&НаКлиенте
Процедура РазмерЛентыПриИзменении(Элемент)
	
	РазмерЛентыПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура РазмерЛентыОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура НазначениеОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИзменитьВРедакторе(Команда)
	
	Размеры = ПолучитьРазмеры(ЭтаФорма);
	
	Закрыть(Неопределено);
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ОткрытьРедактор", Истина);
	ПараметрыОткрытия.Вставить("ИмяМакета", ИмяВыбранногоМакета);
	ПараметрыОткрытия.Вставить("Ширина", Размеры.Ширина);
	ПараметрыОткрытия.Вставить("Высота", Размеры.Высота);
	ПараметрыОткрытия.Вставить("Наименование", Наименование);
	ПараметрыОткрытия.Вставить("Назначение", Назначение);
	
	ОткрытьФорму("Справочник.ШаблоныЭтикетокИЦенников.ФормаОбъекта", ПараметрыОткрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСледующийШаблон(Команда)
	ТекущийИндексШаблона = ТекущийИндексШаблона + 1;
	ОбновитьВсе();
КонецПроцедуры

&НаКлиенте
Процедура КомандаПредыдущийШаблон(Команда)
	ТекущийИндексШаблона = ТекущийИндексШаблона - 1;
	ОбновитьВсе();
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииНазначенияСервер()
	РазмерЛенты = "";
	
	Если Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляТоваров
		ИЛИ Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляДоставки
		ИЛИ Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаСерииНоменклатуры
		ИЛИ Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляСкладскихЯчеек
		ИЛИ Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаУпаковочныхЛистов
		ИЛИ Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаОбъектаЭксплуатации Тогда
		Заголовок = НСтр("ru = 'Помощник создания этикетки'");
		СтрокаПоискаТипа = "Этикетки";
		Элементы.РазмерЛенты.Заголовок = НСтр("ru = 'Размер ленты'");
		Элементы.ОписаниеКоличестваЦенников.Видимость = Ложь;
	Иначе
		Заголовок = НСтр("ru = 'Помощник создания ценника'");
		СтрокаПоискаТипа = "Ценника";
		Элементы.РазмерЛенты.Заголовок = НСтр("ru = 'Размер бумаги'");
		Элементы.ОписаниеКоличестваЦенников.Видимость = Истина;
	КонецЕсли;
	
	Шаблоны = Новый Структура;
	Если Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляСкладскихЯчеек Тогда
		ПризнакМакетаДляТоваров = "СкладскиеЯчейки";
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЦенникДляТоваров Тогда
		ПризнакМакетаДляТоваров = "Товары";
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляТоваров Тогда
		ПризнакМакетаДляТоваров = "Товары";
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляДоставки Тогда
		ПризнакМакетаДляТоваров = "Доставки";
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаСерииНоменклатуры Тогда
		ПризнакМакетаДляТоваров = "СерииНоменклатуры";
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаУпаковочныхЛистов Тогда
		ПризнакМакетаДляТоваров = "УпаковочныеЛисты";
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаОбъектаЭксплуатации Тогда
		ПризнакМакетаДляТоваров = "ОбъектыЭксплуатации";
	КонецЕсли;
	
	МассивТипов = Новый Массив;
	Элементы.ДляЧего.ВыбиратьТип = Ложь;
	Если Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляТоваров
		ИЛИ Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЦенникДляТоваров Тогда
		ДляЧего = Справочники.Номенклатура.ПустаяСсылка();
		МассивТипов.Добавить(Тип("СправочникСсылка.Номенклатура"));
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляСкладскихЯчеек Тогда
		ДляЧего = Справочники.СкладскиеЯчейки.ПустаяСсылка();
		МассивТипов.Добавить(Тип("СправочникСсылка.СкладскиеЯчейки"));
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляДоставки Тогда
		Элементы.ДляЧего.ВыбиратьТип = Истина;
		ДляЧего = Неопределено;
		МассивТипов.Добавить(Тип("ДокументСсылка.РеализацияТоваровУслуг"));
		МассивТипов.Добавить(Тип("ДокументСсылка.ПеремещениеТоваров"));
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаСерииНоменклатуры Тогда
		ДляЧего = Справочники.СерииНоменклатуры.ПустаяСсылка();
		МассивТипов.Добавить(Тип("СправочникСсылка.СерииНоменклатуры"));
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаУпаковочныхЛистов Тогда
		ДляЧего = Документы.УпаковочныйЛист.ПустаяСсылка();
		МассивТипов.Добавить(Тип("ДокументСсылка.УпаковочныйЛист"));
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляАкцизныхМарок Тогда
		ДляЧего = Документы.ЗапросАкцизныхМарокЕГАИС.ПустаяСсылка();
		МассивТипов.Добавить(Тип("ДокументСсылка.ЗапросАкцизныхМарокЕГАИС"));
	ИначеЕсли Назначение = Перечисления.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляШтрихкодовУпаковок Тогда
		ДляЧего = Справочники.ШтрихкодыУпаковокТоваров.ПустаяСсылка();
		МассивТипов.Добавить(Тип("СправочникСсылка.ШтрихкодыУпаковокТоваров"));
	КонецЕсли;
	
	ШаблоныЭтикетокИЦенниковЛокализация.ПриИзмененииНазначенияПомощникНового(
		ЭтотОбъект, СтрокаПоискаТипа, ПризнакМакетаДляТоваров, МассивТипов);
		
	Если МассивТипов.Количество() <> 0 Тогда
		Элементы.ДляЧего.ОграничениеТипа = Новый ОписаниеТипов(МассивТипов);
		Элементы.ДляЧего.Видимость = Истина;
	Иначе
		Элементы.ДляЧего.Видимость = Ложь;
		ДляЧего = Неопределено;
	КонецЕсли; 
	
	Элементы.РазмерЛенты.СписокВыбора.Очистить();
	ДлинаПризнака = СтрДлина(ПризнакМакетаДляТоваров);
	Для Каждого Макет Из Метаданные.Справочники.ШаблоныЭтикетокИЦенников.Макеты Цикл
		Если Макет.ТипМакета = Метаданные.СвойстваОбъектов.ТипМакета.ТабличныйДокумент Тогда
			Если ВРег(Прав(Макет.Имя, ДлинаПризнака)) = ВРег(ПризнакМакетаДляТоваров) Тогда
				
				Если СтрНайти(Макет.Имя, СтрокаПоискаТипа) > 0 Тогда
				
					Размер = СтрЗаменить(Макет.Имя, Лев(Макет.Имя, СтрНайти(Макет.Имя, "_")), "");
					Размер = СтрЗаменить(Размер, "_"+ПризнакМакетаДляТоваров, "");
					
					Если СтрНайти(Макет.Имя, "х") > 0 Тогда
						
						Ключ = "Размер"+Размер;
						Если Не Шаблоны.Свойство(Ключ) Тогда
							Шаблоны.Вставить(Ключ, Новый Массив);
						КонецЕсли;
						Шаблоны[Ключ].Добавить(Макет.Имя);
						
						Если Не ЗначениеЗаполнено(РазмерЛенты) Тогда
							РазмерЛенты = Размер;
						КонецЕсли;
						
						Если Элементы.РазмерЛенты.СписокВыбора.НайтиПоЗначению(Размер) = Неопределено Тогда
							Элементы.РазмерЛенты.СписокВыбора.Добавить(Размер, Размер);
						КонецЕсли;
						
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	РазмерЛентыПриИзмененииНаСервере();
	
	СобытияФорм.ПриИзмененииЭлемента(ЭтотОбъект, "Назначение");
	
КонецПроцедуры

&НаКлиенте
Процедура НапечататьОбразец(Команда)
	
	ОчиститьСообщения();
	
	Если Не ЗначениеЗаполнено(ДляЧего) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не заполнено поле ""Для чего""'"),,"ДляЧего");
		Возврат;
	КонецЕсли;
	
	ПараметрКоманды = Новый Массив;
	ПараметрКоманды.Добавить(ПредопределенноеЗначение("Справочник.Номенклатура.ПустаяСсылка"));
	
	Если Назначение = ПредопределенноеЗначение("Перечисление.НазначенияШаблоновЭтикетокИЦенников.ЦенникДляТоваров") Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЦенникТовары",
			ПараметрКоманды,
			Неопределено,
			ПолучитьПараметрыДляПечатиОбразцаЦенникаТовара());
		
	ИначеЕсли Назначение = ПредопределенноеЗначение("Перечисление.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляТоваров") Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаТовары",
			ПараметрКоманды,
			Неопределено, 
			ПолучитьПараметрыДляПечатиОбразцаЭтикеткиТовара());
		
	ИначеЕсли Назначение = ПредопределенноеЗначение("Перечисление.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляСкладскихЯчеек") Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаСкладскиеЯчейки",
			ПараметрКоманды,
			Неопределено,
			ПолучитьПараметрыДляПечатиОбразцаЭтикеткиСкладскойЯчейки());
		
	ИначеЕсли Назначение = ПредопределенноеЗначение("Перечисление.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаДляДоставки") Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаДоставки",
			ПараметрКоманды,
			Неопределено,
			ПолучитьПараметрыДляПечатиОбразцаЭтикеткиДоставки());
		
	ИначеЕсли Назначение = ПредопределенноеЗначение("Перечисление.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаСерииНоменклатуры") Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаСерииНоменклатуры",
			ПараметрКоманды,
			Неопределено,
			ПолучитьПараметрыДляПечатиОбразцаЭтикеткиСерииНоменклатуры());
			
	ИначеЕсли Назначение = ПредопределенноеЗначение("Перечисление.НазначенияШаблоновЭтикетокИЦенников.ЭтикеткаУпаковочныхЛистов") Тогда
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
			"Обработка.ПечатьЭтикетокИЦенников",
			"ЭтикеткаУпаковочныеЛисты",
			ПараметрКоманды,
			Неопределено, 
			ПолучитьПараметрыДляПечатиОбразцаЭтикеткиУпаковочныеЛисты());
		
	Иначе
		ПараметрыДляПечатиОбразца = ПараметрыДляПечатиОбразца();
		ПечатьЭтикетокИЦенниковЛокализацияКлиент.НапечататьОбразец(
			ПараметрыДляПечатиОбразца, ПараметрКоманды, ЭтотОбъект);
	КонецЕсли;
	
	
КонецПроцедуры

&НаСервере
Функция СохранитьНаСервере()
	
	Размер = ПолучитьРазмеры(ЭтаФорма);
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	
	НовыйЭлемент = Справочники.ШаблоныЭтикетокИЦенников.СоздатьЭлемент();
	НовыйЭлемент.Высота       = Размер.Высота;
	НовыйЭлемент.Ширина       = Размер.Ширина;
	НовыйЭлемент.РазмерЯчейки = 5;
	НовыйЭлемент.Назначение   = Назначение;
	НовыйЭлемент.Наименование = Наименование;
	НовыйЭлемент.ДляЧего      = ДляЧего;
	НовыйЭлемент.Шаблон       = Новый ХранилищеЗначения(ПараметрыМакета);
	НовыйЭлемент.Записать();
	
	Возврат НовыйЭлемент.Ссылка;
	
КонецФункции

&НаКлиенте
Процедура Сохранить(Команда)
	
	ОчиститьСообщения();
	Если ПроверитьЗаполнение() Тогда
	
		Шаблон = СохранитьНаСервере();
		Оповестить("Запись_ШаблоныЭтикетокИЦенников", Новый Структура, Шаблон);
		Закрыть();
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПриИзменении

&НаСервере
Процедура РазмерЛентыПриИзмененииНаСервере()
	
	Ключ = "Размер"+РазмерЛенты;
	
	ТекущийИндексШаблона  = 1;
	ВсегоШаблонов = Шаблоны[Ключ].Количество();
	
	ОбновитьВсе();
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьРазмеры(Форма)
	
	Высота = Число(СтрЗаменить(Форма.РазмерЛенты, Лев(Форма.РазмерЛенты, СтрНайти(Форма.РазмерЛенты, "х")), ""));
	Ширина = (СтрЗаменить(Форма.РазмерЛенты, "х"+Высота, ""));
	
	Возврат Новый Структура("Ширина,Высота",Ширина,Высота);
	
КонецФункции

&НаСервере
Функция МакетКартинкиШаблона(ИмяМакета)
	
	ТекущийЯзык = ТекущийЯзык();
	Если ТипЗнч(ТекущийЯзык) = Тип("ОбъектМетаданных") Тогда
		ТекущийЯзык = ТекущийЯзык.КодЯзыка;
	КонецЕсли;
	
	ПолноеИмяМакета = ИмяМакета + "_" + ТекущийЯзык;
	Если Метаданные.Справочники.ШаблоныЭтикетокИЦенников.Макеты.Найти(ПолноеИмяМакета) <> Неопределено Тогда
		МакетКартинки = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ПолноеИмяМакета);
		Возврат МакетКартинки;
	КонецЕсли;
	
	ПолноеИмяМакета = ИмяМакета + "_" + ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка();
	Если Метаданные.Справочники.ШаблоныЭтикетокИЦенников.Макеты.Найти(ПолноеИмяМакета) <> Неопределено Тогда
		МакетКартинки = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ПолноеИмяМакета);
		Возврат МакетКартинки;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

&НаСервере
Процедура ОбновитьВсе()
	
	Ключ = "Размер" + РазмерЛенты;
	
	Элементы.КомандаСледующийШаблон.Доступность = Не (ТекущийИндексШаблона = ВсегоШаблонов);
	Элементы.КомандаПредыдущийШаблон.Доступность = Не (ТекущийИндексШаблона = 1);
	
	//Элементы.ДекорацияКомандаСледующийШаблон.Видимость = (ТекущийИндексШаблона = ВсегоШаблонов);
	//Элементы.ДекорацияКомандаПредыдущийШаблон.Видимость = (ТекущийИндексШаблона = 1);
	
	Элементы.ТекущийНомер.Заголовок = Строка(ТекущийИндексШаблона) + " из " + ВсегоШаблонов;
	
	ИмяМакета = Шаблоны[Ключ][ТекущийИндексШаблона - 1];
	ИмяВыбранногоМакета = ИмяМакета;
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	
	МакетКартинки = МакетКартинкиШаблона(ИмяМакета + "Картинка");
	АдресКартинки = "";
	Если Не(МакетКартинки = Неопределено) Тогда
		АдресКартинки = ПоместитьВоВременноеХранилище(МакетКартинки, УникальныйИдентификатор);
	КонецЕсли;
	
	КоличествоНаСтранице = Справочники.ШаблоныЭтикетокИЦенников.МаксимальноеКоличествоНаСтранице(Макет, Назначение);
	Элементы.ОписаниеКоличестваЦенников.Заголовок = КоличествоНаСтранице.Описание;
	
	Если ПараметрыМакета.ПараметрыШаблона.Количество() > 0 Тогда
		ИменаПараметров = Новый Массив;
		Для Каждого КлючИЗначение Из ПараметрыМакета.ПараметрыШаблона Цикл
			ИменаПараметров.Добавить(КлючИЗначение.Ключ);
		КонецЦикла;
		Описание = Новый ФорматированнаяСтрока(СтрСоединить(ИменаПараметров, ", "));
	Иначе
		Описание = Новый ФорматированнаяСтрока(НСтр("ru = 'Нет параметров'"));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета)
	
	ПараметрыПечати.Вставить("СтруктураМакетаШаблона", ПараметрыМакета);
	
	Возврат ПараметрыПечати;
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыДляПечатиОбразцаЭтикеткиТовара()
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	ТипКода = ПараметрыМакета.ТипКода;
	
	ПараметрыПечати = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьПараметрыДляПечатиОбразцаЭтикеткиТовара(ДляЧего, ТипКода, УникальныйИдентификатор);
	Возврат ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета);
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыДляПечатиОбразцаЦенникаТовара()
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	ТипКода = ПараметрыМакета.ТипКода;
	
	ПараметрыПечати = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьПараметрыДляПечатиОбразцаЦенникаТовара(ДляЧего, ТипКода, УникальныйИдентификатор);
	Возврат ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета);
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыДляПечатиОбразцаЭтикеткиСкладскойЯчейки()
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	ТипКода = ПараметрыМакета.ТипКода;
	
	ПараметрыПечати = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьПараметрыДляПечатиОбразцаЭтикеткиСкладскойЯчейки(ДляЧего, ТипКода, УникальныйИдентификатор);
	Возврат ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета);
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыДляПечатиОбразцаЭтикеткиДоставки()
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	
	МассивОбъектов = Новый Массив;
	МассивОбъектов.Добавить(ДляЧего);
	
	ПараметрыПечати = Обработки.ПечатьЭтикетокИЦенников.ДанныеДляПечатиЭтикетокДоставки(МассивОбъектов);
	Возврат ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета);
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыДляПечатиОбразцаЭтикеткиСерииНоменклатуры()
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	ТипКода = ПараметрыМакета.ТипКода;
	
	ПараметрыПечати = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьПараметрыДляПечатиОбразцаЭтикеткиСерииНоменклатуры(ДляЧего, ТипКода, УникальныйИдентификатор);
	Возврат ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета);
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыДляПечатиОбразцаЭтикеткиУпаковочныеЛисты()
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	ТипКода = ПараметрыМакета.ТипКода;
	
	ПараметрыПечати = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьПараметрыДляПечатиОбразцаЭтикеткиУпаковочныеЛисты(ДляЧего, ТипКода, УникальныйИдентификатор);
	Возврат ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета);
		
КонецФункции

&НаСервере
Функция ПараметрыДляПечатиОбразца()
	
	Макет = Справочники.ШаблоныЭтикетокИЦенников.ПолучитьМакет(ИмяМакета);
	ПараметрыМакета = Справочники.ШаблоныЭтикетокИЦенников.ПодготовитьСтруктуруМакетаШаблона(Макет, Назначение);
	ТипКода = ПараметрыМакета.ТипКода;
	ПараметрыПечати = ПечатьЭтикетокИЦенниковЛокализация.ПолучитьПараметрыДляПечатиОбразца(
		ЭтотОбъект, Назначение, ТипКода, ЭтотОбъект);
	Возврат ДополнитьПараметрыДляПечатиОбразца(ПараметрыПечати, ПараметрыМакета);
	
КонецФункции

#КонецОбласти

#КонецОбласти
