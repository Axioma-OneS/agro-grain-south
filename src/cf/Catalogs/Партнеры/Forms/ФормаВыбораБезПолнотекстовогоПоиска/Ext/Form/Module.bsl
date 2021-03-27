﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ПартнерыИКонтрагенты.ПартнерыФормаВыбораСпискаПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	Если Не Параметры.Контрагент.Пустая() Тогда
		Элементы.ПоКонтрагенту.Видимость = Истина;
		Элементы.Список.Отображение = ОтображениеТаблицы.Список;
		Партнер = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Параметры.Контрагент, Новый Структура("Партнер")).Партнер;
		СписокПартнеров.ЗагрузитьЗначения(ПартнерыИКонтрагенты.ПолучитьНижестоящихПартнеров(Партнер));
		Элементы.ПоКонтрагенту.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='По контрагенту ""%1""'"), Параметры.Контрагент);
	КонецЕсли;
	
	Если Параметры.Свойство("Основание") Тогда
		Основание = Параметры.Основание;
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	ПартнерыИКонтрагенты.СкрытьКомандыПриОтсутствииПравНаИзменение(ЭтотОбъект);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	ТребуетсяОбновлениеПанелиИнформации = Ложь;
	
	ПартнерыИКонтрагентыКлиент.ПартнерыФормаСпискаВыбораОбработкаОповещения(ЭтаФорма, ИмяСобытия, Параметр, Источник, ТребуетсяОбновлениеПанелиИнформации);
	
	Если ТребуетсяОбновлениеПанелиИнформации Тогда
		ИгнорироватьСохранениеТекущейПозиции = Истина;
		ОбработатьАктивизациюСтрокиСписка();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если Не ЗавершениеРаботы И Не Параметры.Контрагент.Пустая() Тогда
		СохранитьНастройки();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	ПартнерыИКонтрагенты.ПередЗагрузкойДанныхИзНастроекНаСервере(ЭтаФорма, Настройки);
	
	Если Не Параметры.Контрагент.Пустая() Тогда
		
		ЗагрузитьНастройки();
		Элементы.ВключаяНижестоящих.Видимость = ПоКонтрагенту И СписокПартнеров.Количество() > 1;
		Если ПоКонтрагенту Тогда
			УстановитьОтборПартнеров(ЭтаФорма, ВключаяНижестоящих);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПартнерыИКонтрагентыКлиент.ПанельНавигацииУправлениеДоступностью(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТолькоМоиПриИзменении(Элемент)
	
	ИзменитьОтборСписок();
	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	
	ВыполнитьПоиск(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура ОснованиеВыбораНажатие(Элемент, СтандартнаяОбработка)
	
	ПартнерыИКонтрагентыКлиент.ПартнерыФормаСпискаВыбораОснованиеВыбораНажатие(ЭтаФорма, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура СегментПриИзменении(Элемент)
	
	ПартнерыИКонтрагентыКлиент.ПартнерыФормаСпискаВыбораСегментПриИзменении(ЭтаФорма, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаАвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	
	СпискиВыбораКлиентСервер.АвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоКонтрагентуПриИзменении(Элемент)
	
	ВключаяНижестоящих = ПоКонтрагенту;
	Элементы.ВключаяНижестоящих.Видимость = (СписокПартнеров.Количество() > 1 И ПоКонтрагенту);
	Если ПоКонтрагенту Тогда
		УстановитьОтборПартнеров(ЭтаФорма, Истина);
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Список, "Ссылка");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВключаяНижестоящихПриИзменении(Элемент)
	
	УстановитьОтборПартнеров(ЭтаФорма, ВключаяНижестоящих);
	
КонецПроцедуры

&НаКлиенте
Процедура ТипФильтраОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьФильтрПриИзменении(Элемент)
	
	ПартнерыИКонтрагентыКлиент.ПанельНавигацииУправлениеДоступностью(ЭтаФорма);
	ОбработатьАктивизациюСтрокиДинамическогоСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ДинамическийСписокФильтрыПриАктивизацииСтроки(Элемент)
	
	Если Элемент.Имя = "БизнесРегионы" И Элементы.СтраницыТипФильтра.ТекущаяСтраница <> Элементы.СтраницаБизнесРегионы Тогда
		Возврат;
	ИначеЕсли Элемент.Имя = "ГруппыДоступаПартнеров" И Элементы.СтраницыТипФильтра.ТекущаяСтраница <> Элементы.СтраницаГруппыДоступа Тогда
		Возврат;
	ИначеЕсли Элемент.Имя = "Менеджеры" И Элементы.СтраницыТипФильтра.ТекущаяСтраница <> Элементы.СтраницаМенеджеры Тогда
		Возврат;
	ИначеЕсли Элемент.Имя = "Свойства" И Элементы.СтраницыТипФильтра.ТекущаяСтраница <> Элементы.СтраницаСвойства Тогда
		Возврат;
	ИначеЕсли Элемент.Имя = "Категории" И Элементы.СтраницыТипФильтра.ТекущаяСтраница <> Элементы.СтраницаКатегории Тогда
		Возврат;
	КонецЕсли;
	
	Если НеОтрабатыватьАктивизациюПанелиНавигации Тогда
		НеОтрабатыватьАктивизациюПанелиНавигации = Ложь;
	Иначе
		Если Элемент.Имя = "БизнесРегионы" И ТекущееЗначениеФильтра = Элементы.БизнесРегионы.ТекущаяСтрока Тогда
			Возврат;
		ИначеЕсли Элемент.Имя = "ГруппыДоступаПартнеров" И ТекущееЗначениеФильтра = Элементы.ГруппыДоступаПартнеров.ТекущаяСтрока Тогда
			Возврат;
		ИначеЕсли Элемент.Имя = "Менеджеры" И ТекущееЗначениеФильтра = Элементы.Менеджеры.ТекущаяСтрока Тогда
			Возврат;
		ИначеЕсли Элемент.Имя = "Свойства" И ТекущееЗначениеФильтра = Свойства.НайтиПоИдентификатору(Элементы.Свойства.ТекущаяСтрока) Тогда
			Возврат;
		ИначеЕсли Элемент.Имя = "Категории" И ТекущееЗначениеФильтра = Категории.НайтиПоИдентификатору(Элементы.Категории.ТекущаяСтрока) Тогда
			Возврат;
		КонецЕсли;
		
		ПодключитьОбработчикОжидания("ОбработатьАктивизациюСтрокиДинамическогоСписка",0.2,Истина);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрагентыПартнераНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПартнерыИКонтрагентыКлиент.КонтрагентыПартнераНажатие(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактныеЛицаПартнераНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПартнерыИКонтрагентыКлиент.КонтактныеЛицаПартнераНажатие(ЭтаФорма);
	
КонецПроцедуры 

&НаКлиенте
Процедура ПоВсемПриИзменении(Элемент)

	ИзменитьОтборСписок(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ТипФильтраПриИзменении(Элемент)
	
	ТребуетсяЗаполнениеСтраницыСвойств = ЛОЖЬ;
	ПартнерыИКонтрагентыКлиент.ФильтрыПанельНавигацииТипФильтраПриИзменении(ЭтаФорма, Элемент, ТребуетсяЗаполнениеСтраницыСвойств);
	ИзменитьОтборСписок(Истина, ТребуетсяЗаполнениеСтраницыСвойств);
	Если ТребуетсяЗаполнениеСтраницыСвойств Тогда
		Для каждого СтрокаДерева Из Свойства.ПолучитьЭлементы() Цикл
			Элементы.Свойства.Развернуть(СтрокаДерева.ПолучитьИдентификатор());
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ФильтрыПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	ПартнерыИКонтрагентыКлиент.ФильтрыПанельНавигацииПроверкаПеретаскивания(ЭтаФорма, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле) 
	
КонецПроцедуры

&НаКлиенте
Процедура ФильтрыПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	КоличествоЗаписанных = 0;
	ПартнерыИКонтрагентыКлиент.ФильтрыПанельНавигацииПеретаскивание(КоличествоЗаписанных, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле);
	
	Если КоличествоЗаписанных > 0 Тогда
		ИзменитьОтборСписок();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле = Элементы.Найти("ГоловнойКонтрагент") Тогда
		
		ТекущиеДанные = Элемент.ТекущиеДанные;
		Если ТекущиеДанные.ОбособленноеПодразделение И Не ЗначениеЗаполнено(ТекущиеДанные.ГоловнойКонтрагент) Тогда
			
			СтандартнаяОбработка = Ложь;
			
			ПараметрыЗаполнения = Новый Структура;
			ПараметрыЗаполнения.Вставить("Контрагент", ТекущиеДанные.Контрагент);
			ПараметрыЗаполнения.Вставить("ИНН",        ТекущиеДанные.ИНН);
			ПараметрыЗаполнения.Вставить("Партнер",    ТекущиеДанные.Ссылка);
			ПараметрыЗаполнения.Вставить("ИспользоватьПартнеровКакКонтрагентов", Истина);
			
			Оповещение = Новый ОписаниеОповещения("ЗаполнитьГоловногоКонтрагентаЗавершение", ЭтотОбъект);
			ПартнерыИКонтрагентыКлиент.ЗаполнитьГоловногоКонтрагента(ЭтотОбъект, ПараметрыЗаполнения, Истина, Оповещение);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ОбработатьАктивизациюСтрокиСписка",0.2,Истина);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	ПартнерыИКонтрагентыКлиент.ПартнерыФормаСпискаВыбораСписокПередНачаломДобавления(ЭтаФорма, Элемент, Отказ, Копирование, Родитель, Группа, Основание);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьНового(Команда)
	
	ПартнерыИКонтрагентыКлиент.ПартнерыФормаСпискаВыбораСоздатьНового(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиПП(Команда)
	
	ВыполнитьПоиск(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	ПартнерыИКонтрагенты.ПартнерыФормаВыбораСпискаУсловноеОформление(ЭтаФорма);
	ПартнерыИКонтрагенты.УстановитьОформлениеГоловногоКонтрагентаВСписке(ЭтаФорма);

КонецПроцедуры

#Область ПолнотекстовыйПоиск

&НаКлиенте
Процедура ПроверитьИндексПолнотекстовогоПоиска(Знач Оповещение)
	
	Если Не ИндексПолнотекстовогоПоискаАктуален И ИнформационнаяБазаФайловая Тогда
		
		ПоказатьВопрос(Новый ОписаниеОповещения("ПроверитьИндексПолнотекстовогоПоискаЗавершение", ЭтотОбъект, Новый Структура("Оповещение", Оповещение)), 
			НСтр("ru='Индекс полнотекстового поиска неактуален. Обновить индекс?'"), РежимДиалогаВопрос.ДаНет);
        Возврат;
		
	КонецЕсли;
	
	ПроверитьИндексПолнотекстовогоПоискаФрагмент(Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьИндексПолнотекстовогоПоискаЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
    
    Оповещение = ДополнительныеПараметры.Оповещение;
    
    
    Результат = РезультатВопроса; 
    
    Если Результат = КодВозвратаДиалога.Да Тогда
        ПодключитьОбработчикОжидания("ОбновитьИндексПолнотекстовогоПоиска",0.2,Истина);
        ВыполнитьОбработкуОповещения(Оповещение);
        Возврат;
    КонецЕсли;
    
    
    ПроверитьИндексПолнотекстовогоПоискаФрагмент(Оповещение);

КонецПроцедуры

&НаКлиенте
Процедура ПроверитьИндексПолнотекстовогоПоискаФрагмент(Знач Оповещение)
    
    ВыполнитьПолнотекстовыйПоиск();
    
    ВыполнитьОбработкуОповещения(Оповещение);

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИндексПолнотекстовогоПоиска()
	
	Состояние(НСтр("ru = 'Идет обновление индекса полнотекстового поиска ...'"));
	ОбновитьИндексПолнотекстовогоПоискаСервер();
	ИндексПолнотекстовогоПоискаАктуален = Истина;
	Состояние(НСтр("ru = 'Обновление индекса полнотекстового поиска завершено...'"));
	
	ВыполнитьПолнотекстовыйПоиск();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьИндексПолнотекстовогоПоискаСервер()
	
	ПартнерыИКонтрагенты.ОбновитьИндексПолнотекстовогоПоиска();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПолнотекстовыйПоиск()
	
	ТекстОшибки = НайтиПартнеровПолнотекстовыйПоиск();
	Если ТекстОшибки = Неопределено Тогда
		РасширенныйПоиск = Истина;
		ПартнерыИКонтрагентыКлиент.ЗаполнитьСтрокуОснования(ЭтаФорма);
	Иначе
		Если НЕ ТекстОшибки = НСтр("ru = 'Ничего не найдено'") Тогда
			ПоказатьОповещениеПользователя(ТекстОшибки);
		Иначе
			ПартнерыИКонтрагентыКлиент.ВосстановитьОтображениеСпискаПослеПолнотекстовогоПоиска(ЭтаФорма);
			РасширенныйПоиск = Ложь;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры 

&НаСервере
Функция НайтиПартнеровПолнотекстовыйПоиск()
	
	Возврат ПартнерыИКонтрагенты.НайтиПартнеровПолнотекстовыйПоиск(ЭтаФорма)
	
КонецФункции

&НаКлиенте
Процедура ВыполнитьПоиск(Знач Оповещение)
	
	Если СтрокаПоиска <> "" Тогда
		
		ПроверитьИндексПолнотекстовогоПоиска(Новый ОписаниеОповещения("ВыполнитьПоискЗавершение", ЭтотОбъект, Новый Структура("Оповещение", Оповещение)));
        Возврат;
		
	Иначе
		
		ПартнерыИКонтрагентыКлиент.ВосстановитьОтображениеСпискаПослеПолнотекстовогоПоиска(ЭтаФорма);
		РасширенныйПоиск = Ложь;
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список,
		                                                                   "ОтборПоПолнотекстовомуПоискуУстановлен",
		                                                                   Ложь);
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список,
		                                                                   "ОтборПоПолнотекстовомуПоиску",
		                                                                   Неопределено);
		ОснованиеВыбора = "";
		
	КонецЕсли;
	
	ВыполнитьПоискФрагмент(Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоискЗавершение(Результат, ДополнительныеПараметры) Экспорт
    
    Оповещение = ДополнительныеПараметры.Оповещение;
    
    
    ЭтаФорма.ТекущийЭлемент = ?(НЕ РасширенныйПоиск, Элементы.СтрокаПоиска, Элементы.Список);
    
    
    ВыполнитьПоискФрагмент(Оповещение);

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоискФрагмент(Знач Оповещение)
    
    ВыполнитьОбработкуОповещения(Оповещение);

КонецПроцедуры

#КонецОбласти

#Область Отборы

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборПартнеров(Форма, ВключаяНижестоящих = Истина)
	
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Форма.Список, "Ссылка");
	Если ВключаяНижестоящих Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Форма.Список, "Ссылка", Форма.СписокПартнеров, ВидСравненияКомпоновкиДанных.ВСписке,,Истина);
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Форма.Список, "Ссылка", Форма.Партнер, ВидСравненияКомпоновкиДанных.Равно,,Истина);
	КонецЕсли;
	
КонецПроцедуры 

#КонецОбласти

#Область Настройки

&НаСервере
Процедура СохранитьНастройки()

	Перем Настройки;
	
	Настройки = Новый Соответствие;
	Настройки.Вставить("ВключаяНижестоящих",ВключаяНижестоящих);
	Настройки.Вставить("ПоКонтрагенту",ПоКонтрагенту);
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("Справочники.Партнеры",КлючНастроек, Настройки);
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьНастройки()
	
	ЗначениеНастроек = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("Справочники.Партнеры", КлючНастроек);
	Если ТипЗнч(ЗначениеНастроек) = Тип("Соответствие") Тогда
		ВключаяНижестоящих = ЗначениеНастроек.Получить("ВключаяНижестоящих");
		ПоКонтрагенту      = ЗначениеНастроек.Получить("ПоКонтрагенту");
	Иначе
		ПоКонтрагенту      = Истина;
		ВключаяНижестоящих = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаКлиенте
Процедура ОбработатьАктивизациюСтрокиСписка()
	
	Если Не ПартнерыИКонтрагентыКлиент.ПозиционированиеКорректно("Список",ЭтаФорма) Тогда
		
		Если ТекущийАктивныйПартнер <> ПредопределенноеЗначение("Справочник.Партнеры.ПустаяСсылка") Тогда
			ЗаполнитьПанельИнформацииПоДаннымПартнера( Неопределено);
		КонецЕсли;
		ОснованиеВыбора = "";
		
	Иначе
		
		Если ТекущийАктивныйПартнер <> Элементы.Список.ТекущаяСтрока ИЛИ ИгнорироватьСохранениеТекущейПозиции Тогда
			ЗаполнитьПанельИнформацииПоДаннымПартнера(Элементы.Список.ТекущаяСтрока);
		КонецЕсли;
		
		Если РасширенныйПоиск Тогда
			ПартнерыИКонтрагентыКлиент.ЗаполнитьСтрокуОснования(ЭтаФорма);
		Иначе
			ОснованиеВыбора = "";
		КонецЕсли;
		
	КонецЕсли;
	
	ИгнорироватьСохранениеТекущейПозиции = Ложь;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПанельИнформацииПоДаннымПартнера(Партнер)

	ПартнерыИКонтрагенты.ЗаполнитьПанельИнформацииПоДаннымПартнера(ЭтаФорма, Партнер);

КонецПроцедуры

&НаКлиенте
Процедура ОбработатьАктивизациюСтрокиДинамическогоСписка()

	ИзменитьОтборСписок();

КонецПроцедуры

&НаСервере
Процедура ИзменитьОтборСписок(ПереформированиеПанелиНавигации = Ложь, ТребуетсяЗаполнениеСтраницыСвойств = Ложь)

	ПартнерыИКонтрагенты.ИзменитьОтборСписок(ЭтаФорма, ПереформированиеПанелиНавигации, ТребуетсяЗаполнениеСтраницыСвойств);

КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура ЗаполнитьГоловногоКонтрагентаЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	
	Если ВыбранноеЗначение <> Неопределено Тогда
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
