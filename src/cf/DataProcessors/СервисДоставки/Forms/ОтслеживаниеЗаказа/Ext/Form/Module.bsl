﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не СервисДоставки.ПравоРаботыССервисомДоставки(Истина) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	АвтоНавигационнаяСсылка = Ложь;
	НавигационнаяСсылка = "e1cib/command/" + СтрЗаменить(ЭтотОбъект.ИмяФормы, "Форма", "Команда");
	
	Параметры.Свойство("ТрекНомер", ТрекНомер);
	Параметры.Свойство("ИдентификаторЗаказа", ИдентификаторЗаказа);
	Параметры.Свойство("ОрганизацияБизнесСетиСсылка", ОрганизацияБизнесСетиСсылка);
	
	УстановитьВидимостьДоступность();
	
	СервисДоставкиСлужебный.ПроверитьОрганизациюБизнесСети(ОрганизацияБизнесСетиСсылка, Отказ);
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьУсловноеОформление();
	
	// Запуск фонового задания для загрузки доступных форм.
	Если ИдентификаторЗаказа <> "" Тогда
		ФоновоеЗаданиеПолучитьГрафикДвиженияЗаказа = ПолучитьГрафикДвиженияЗаказа();
	ИначеЕсли ТрекНомер <> "" Тогда
		ФоновоеЗаданиеПолучитьГрафикДвиженияЗаказаПоТрекНомеру = ПолучитьГрафикДвиженияЗаказаПоТрекНомеру();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЗначениеЗаполнено(ФоновоеЗаданиеПолучитьГрафикДвиженияЗаказа) Тогда
		
		ПараметрыОперации = Новый Структура("ИмяПроцедуры, НаименованиеОперации, ВыводитьОкноОжидания");
		ПараметрыОперации.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказа();
		ПараметрыОперации.НаименованиеОперации = НСтр("ru = 'Получение данных по заказу'");
		
		ОжидатьЗавершениеВыполненияЗапроса(ПараметрыОперации);
		
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ФоновоеЗаданиеПолучитьГрафикДвиженияЗаказаПоТрекНомеру) Тогда
		
		ПараметрыОперации = Новый Структура("ИмяПроцедуры, НаименованиеОперации, ВыводитьОкноОжидания");
		ПараметрыОперации.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказаПоТрекНомеру();
		ПараметрыОперации.НаименованиеОперации = НСтр("ru = 'Получение данных по заказу'");
		
		ОжидатьЗавершениеВыполненияЗапроса(ПараметрыОперации);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КарточкаЗаказаОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка, ДополнительныеПараметры)
	
	СтандартнаяОбработка = Ложь;
	
	Если Расшифровка = "Грузоперевозчик" Тогда
		
		ОткрытьФормуГрузоперевозчика();
		
	ИначеЕсли Расшифровка = "ТочкаОтправления" Тогда
		
		Если ТочкаОтправленияИдентификатор <> "" Тогда
			ОткрытьФормуТерминала(ТочкаОтправленияИдентификатор);
		КонецЕсли;
		
	ИначеЕсли Расшифровка = "ТочкаНазначения" Тогда
		
		Если ТочкаНазначенияИдентификатор <> "" Тогда
			ОткрытьФормуТерминала(ТочкаНазначенияИдентификатор);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗакрытьФорму(Команда)
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура НайтиЗаказПоТрекНомеру(Команда)
	
	ОчиститьСообщения();
	Если ЗначениеЗаполнено(ТрекНомер) Тогда
		
		Если СтрДлина(ТрекНомер) > 5 Тогда
			
			ОчиститьРеквизитыФормы();
			
			ПараметрыОперации = Новый Структура("ИмяПроцедуры, НаименованиеОперации, ВыводитьОкноОжидания");
			ПараметрыОперации.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказаПоТрекНомеру();
			ПараметрыОперации.НаименованиеОперации = НСтр("ru = 'Получение данных по заказу'");
			ПараметрыОперации.ВыводитьОкноОжидания = Ложь;
			
			ВыполнитьЗапрос(ПараметрыОперации);
		Иначе
			
			ТекстОшибки = НСтр("ru='Трек-номер должен быть больше 5 символов.'");
				
			ЕстьОшибки = Истина;
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстОшибки,,Элементы.ТрекНомер);
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ВыполнитьЗапрос

&НаКлиенте
Процедура ВыполнитьЗапрос(ПараметрыОперации)
	
	ИнтернетПоддержкаПодключена = Ложь;
	ОчиститьСообщения();
	
	ИмяФоновогоЗадания = "ФоновоеЗадание" + ПараметрыОперации.ИмяПроцедуры;
	ФоновоеЗадание = ВыполнитьЗапросВФоне(ИнтернетПоддержкаПодключена, ПараметрыОперации);
	ЭтотОбъект[ИмяФоновогоЗадания] = ФоновоеЗадание;
	
	Если ИнтернетПоддержкаПодключена = Ложь Тогда
		
		// Загрузка с проверкой подключения интернет-поддержки.
		Оповещение = Новый ОписаниеОповещения("ВыполнитьЗапросПродолжение", ЭтотОбъект, ПараметрыОперации);
		ИнтернетПоддержкаПользователейКлиент.ПодключитьИнтернетПоддержкуПользователей(Оповещение, ЭтотОбъект);
		Возврат;
		
	Иначе
		
		ПараметрыОперации.Вставить("ФоновоеЗадание", ФоновоеЗадание);
		ВыполнитьЗапросПродолжение(Истина, ПараметрыОперации);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЗапросПродолжение(Результат, ДополнительныеПараметры) Экспорт
	
	ИмяФоновогоЗадания = "ФоновоеЗадание"+ ДополнительныеПараметры.ИмяПроцедуры;
	
	Если Результат = Неопределено Тогда
		ТекстСообщения = НСтр("ru = 'Отсутствует подключение к Интернет-поддержке пользователей.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат;
	ИначеЕсли ТипЗнч(Результат) = Тип("Структура")
		И Результат.Свойство("Логин") Тогда
		// Повторный вызов метода после подключения к Интернет-поддержке.
		ИнтернетПоддержкаПодключена = Ложь;
		ЭтотОбъект[ИмяФоновогоЗадания] = ВыполнитьЗапросВФоне(ИнтернетПоддержкаПодключена, ДополнительныеПараметры);
		ДополнительныеПараметры.Добавить("ФоновоеЗадание", ЭтотОбъект[ИмяФоновогоЗадания]);
	КонецЕсли;
	
	Если ЭтотОбъект[ИмяФоновогоЗадания] = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтотОбъект[ИмяФоновогоЗадания].Статус = "Выполняется" Тогда
		
		ОжидатьЗавершениеВыполненияЗапроса(ДополнительныеПараметры);
		
	ИначеЕсли ЭтотОбъект[ИмяФоновогоЗадания].Статус = "Выполнено" Тогда
		
		ВыполнитьЗапросЗавершение(ЭтотОбъект[ИмяФоновогоЗадания], ДополнительныеПараметры);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОжидатьЗавершениеВыполненияЗапроса(ПараметрыОперации)
	
	ВыводитьОкноОжидания = ?(ЗначениеЗаполнено(ПараметрыОперации.ВыводитьОкноОжидания), 
																	ПараметрыОперации.ВыводитьОкноОжидания,
																	Ложь);
	// Установка картинки длительной операции.
	Если Не ВыводитьОкноОжидания Тогда
		
		Если ПараметрыОперации.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказа() 
			ИЛИ ПараметрыОперации.ИмяПроцедуры
			= СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказаПоТрекНомеру() Тогда
			
			Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаОжиданиеЗагрузки;
			
		КонецЕсли;
		
	КонецЕсли;
	
	// Инициализация обработчик ожидания завершения.
	ИмяФоновогоЗадания = "ФоновоеЗадание" + ПараметрыОперации.ИмяПроцедуры;
	ФоновоеЗадание = ЭтотОбъект[ИмяФоновогоЗадания];
	ПараметрыОперации.Вставить("ФоновоеЗадание", ФоновоеЗадание);
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ТекстСообщения = ПараметрыОперации.НаименованиеОперации;
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = Ложь;
	ПараметрыОжидания.ВыводитьОкноОжидания = ВыводитьОкноОжидания;
	ПараметрыОжидания.ОповещениеПользователя.Показать = Ложь;
	ПараметрыОжидания.ВыводитьСообщения = Истина;
	ПараметрыОжидания.Вставить("ИдентификаторЗадания", ФоновоеЗадание.ИдентификаторЗадания);
	
	ОбработкаЗавершения = Новый ОписаниеОповещения("ВыполнитьЗапросЗавершение",
		ЭтотОбъект, ПараметрыОперации);
		
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ФоновоеЗадание, ОбработкаЗавершения, ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЗапросЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	// Инициализация.
	Отказ = Ложь;
	ТекстСообщения = "";
	ДанныеОбновлены = Ложь;
	ИмяФоновогоЗадания = "ФоновоеЗадание" + ДополнительныеПараметры.ИмяПроцедуры;
	ФоновоеЗадание = ЭтотОбъект[ИмяФоновогоЗадания];
	
	// Скрыть элементы ожидания на форме
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаОсновная;
	
	// Вывод сообщений из фонового задания.
	СервисДоставкиКлиент.ОбработатьРезультатФоновогоЗадания(Результат, ДополнительныеПараметры, Отказ);
	Если Результат = Неопределено ИЛИ ФоновоеЗадание = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Проверка результата поиска.
	Если Не Отказ И Результат.Статус = "Выполнено" Тогда
		Если ЗначениеЗаполнено(Результат.АдресРезультата)
			И ЭтоАдресВременногоХранилища(Результат.АдресРезультата)
			И ДополнительныеПараметры.ФоновоеЗадание.ИдентификаторЗадания
			= ЭтотОбъект[ИмяФоновогоЗадания].ИдентификаторЗадания Тогда
			
			Если ДополнительныеПараметры.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказа()
				ИЛИ ДополнительныеПараметры.ИмяПроцедуры
				= СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказаПоТрекНомеру() Тогда
				
				// Загрузка результатов запроса.
				ОперацияВыполнена = Истина;
				ЗагрузитьРезультатЗапросаПолучитьГрафикДвиженияЗаказа(Результат.АдресРезультата, ОперацияВыполнена);
				ЭтотОбъект[ИмяФоновогоЗадания] = Неопределено;
				ДанныеОбновлены = Истина;
				
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ВыполнитьЗапросВФоне

&НаСервере
Функция ВыполнитьЗапросВФоне(ИнтернетПоддержкаПодключена, ПараметрыОперации)
	
	// Проверка подключения Интернет-поддержки пользователей.
	ИнтернетПоддержкаПодключена
		= ИнтернетПоддержкаПользователей.ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки();
	Если Не ИнтернетПоддержкаПодключена Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Отказ = Ложь;
	ПараметрыЗапроса = ПараметрыЗапроса(ПараметрыОперации, Отказ);
	
	Если Отказ Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ИмяФоновогоЗадания = "ФоновоеЗадание" + ПараметрыОперации.ИмяПроцедуры;
	ФоновоеЗадание = ЭтотОбъект[ИмяФоновогоЗадания];
	Если ФоновоеЗадание <> Неопределено Тогда
		ОтменитьВыполнениеЗадания(ФоновоеЗадание.ИдентификаторЗадания);
	КонецЕсли;
	
	Задание = Новый Структура("ИмяПроцедуры, Наименование, ПараметрыПроцедуры");
	Задание.Наименование = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = '1С:Доставка. %1.'"),
		ПараметрыОперации.НаименованиеОперации);
	Задание.ИмяПроцедуры = "СервисДоставки." + ПараметрыОперации.ИмяПроцедуры;
	Задание.ПараметрыПроцедуры = ПараметрыЗапроса;
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = Задание.Наименование;
	ПараметрыВыполнения.ОжидатьЗавершение = 0;
	
	Возврат ДлительныеОперации.ВыполнитьВФоне(Задание.ИмяПроцедуры,
		Задание.ПараметрыПроцедуры, ПараметрыВыполнения);
	
КонецФункции

&НаСервереБезКонтекста
Процедура ОтменитьВыполнениеЗадания(ИдентификаторЗадания)
	
	Если ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторЗадания);
		ИдентификаторЗадания = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьГрафикДвиженияЗаказа()
	
	ПараметрыОперации = Новый Структура("ИмяПроцедуры, НаименованиеОперации, ВыводитьОкноОжидания");
	ПараметрыОперации.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказа();
	ПараметрыОперации.НаименованиеОперации = НСтр("ru = 'Получение данных по заказу.'");
	
	Возврат ВыполнитьЗапросВФоне(Ложь, ПараметрыОперации);
	
КонецФункции

&НаСервере
Функция ПолучитьГрафикДвиженияЗаказаПоТрекНомеру()
	
	ПараметрыОперации = Новый Структура("ИмяПроцедуры, НаименованиеОперации, ВыводитьОкноОжидания");
	ПараметрыОперации.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказаПоТрекНомеру();
	ПараметрыОперации.НаименованиеОперации = НСтр("ru = 'Получение данных по заказу.'");
	
	Возврат ВыполнитьЗапросВФоне(Ложь, ПараметрыОперации);
	
КонецФункции

#КонецОбласти

#Область ПараметрыЗапроса

&НаСервере
Функция ПараметрыЗапроса(ПараметрыОперации, Отказ)
	
	ПараметрыЗапроса = Новый Структура();
	
	ИмяПроцедуры = ПараметрыОперации.ИмяПроцедуры;
	
	Если ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказа() Тогда
		ПараметрыЗапроса = ПараметрыЗапросаПолучитьГрафикДвиженияЗаказа(ПараметрыЗапроса, Отказ);
	ИначеЕсли ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьГрафикДвиженияЗаказаПоТрекНомеру() Тогда
		ПараметрыЗапроса = ПараметрыЗапросаПолучитьГрафикДвиженияЗаказаПоТрекНомеру(ПараметрыЗапроса, Отказ);
	КонецЕсли;
	
	ПараметрыЗапроса.Вставить("ОрганизацияБизнесСетиСсылка", ОрганизацияБизнесСетиСсылка);
	
	Возврат ПараметрыЗапроса;
	
КонецФункции

&НаСервере
Функция ПараметрыЗапросаПолучитьГрафикДвиженияЗаказа(ПараметрыЗапроса, Отказ)
	
	ПараметрыЗапроса = СервисДоставки.НовыйПараметрыЗапросаПолучитьГрафикДвиженияЗаказа();
	ПараметрыЗапроса.Вставить("ИдентификаторЗаказа", ИдентификаторЗаказа);
	
	Возврат ПараметрыЗапроса;

КонецФункции

&НаСервере
Функция ПараметрыЗапросаПолучитьГрафикДвиженияЗаказаПоТрекНомеру(ПараметрыЗапроса, Отказ)
	
	ПараметрыЗапроса = СервисДоставки.НовыйПараметрыЗапросаПолучитьГрафикДвиженияЗаказаПоТрекНомеру();
	ПараметрыЗапроса.Вставить("ТрекНомер", ТрекНомер);
	ПараметрыЗапроса.Вставить("ГрузоперевозчикИдентификатор", ГрузоперевозчикИдентификатор);
	
	Возврат ПараметрыЗапроса;

КонецФункции

#КонецОбласти

#Область ЗагрузитьРезультаты

&НаСервере
Процедура ЗагрузитьРезультатЗапросаПолучитьГрафикДвиженияЗаказа(АдресРезультата, ОперацияВыполнена)
	
	Если ЭтоАдресВременногоХранилища(АдресРезультата) Тогда
		Результат = ПолучитьИзВременногоХранилища(АдресРезультата);
		Если ЗначениеЗаполнено(Результат) 
			И ТипЗнч(Результат) = Тип("Структура") Тогда
			
			Если Результат.Свойство("Данные") Тогда
			
				ДанныеЗаказа = Результат.Данные;
				ОбработатьПараметры(ДанныеЗаказа);
				
				ЗаказПредставление = СтрШаблон(НСтр("ru='Заказ на доставку № %1 от %2'"), НомерЗаказа,
					Формат(ДатаЗаказа, "ДЛФ=D"));
				
				Если ДанныеЗаказа.Свойство("ГрафикДвиженияЗаказа") Тогда
					
					Список.Очистить();
					
					Для Каждого ТекущаяСтрока Из ДанныеЗаказа.ГрафикДвиженияЗаказа Цикл
						
						НоваяСтрока = Список.Добавить();
						ЗаполнитьЗначенияСвойств(НоваяСтрока, ТекущаяСтрока);
						
						ДатаПредставление = Формат(НоваяСтрока.Дата, "ДЛФ=D");
						
						Если НоваяСтрока.Дата < НоваяСтрока.ДатаМаксимальная Тогда
							ДатаПредставление = ДатаПредставление + " - " + Формат(НоваяСтрока.ДатаМаксимальная, "ДЛФ=D");
						КонецЕсли;
						
						НоваяСтрока.ДатаПредставление = ДатаПредставление;
						
						МестоположениеПредставление = "";
						
						Если ЗначениеЗаполнено(НоваяСтрока.МестоположениеИдентификатор) Тогда
							МестоположениеПредставление = НоваяСтрока.МестоположениеНаименование;
						ИначеЕсли ЗначениеЗаполнено(НоваяСтрока.МестоположениеНаименование) Тогда
							МестоположениеПредставление = НоваяСтрока.МестоположениеНаименование;
							МестоположениеПредставление = МестоположениеПредставление
								+ " (" + НоваяСтрока.МестоположениеАдрес + ")";
						ИначеЕсли ЗначениеЗаполнено(НоваяСтрока.МестоположениеАдрес) Тогда
							МестоположениеПредставление = НоваяСтрока.МестоположениеАдрес;
						КонецЕсли;
						
						НоваяСтрока.МестоположениеПредставление = МестоположениеПредставление;
						НоваяСтрока.ФактКартинка = ?(НоваяСтрока.ЭтоФакт, 1, 0);
						
					КонецЦикла;
					
				КонецЕсли;
				
				СформироватьКарточкуЗаказа();
				
				СервисДоставки.ОбработатьБлокОшибок(Результат, ОперацияВыполнена);
				
			КонецЕсли;
		Иначе
			ОперацияВыполнена = Ложь;
		КонецЕсли;
	Иначе
		ОперацияВыполнена = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаСервере
Процедура ОбработатьПараметры(Параметры)
	
	ПараметрыДляФормы = Новый Структура;
	СервисДоставкиКлиентСервер.ЗаполнитьЛинейныеДанныеПоСтруктуре(Параметры, ПараметрыДляФормы, "");
	ЗаполнитьЗначенияСвойств(ЭтаФорма, ПараметрыДляФормы,,"ТрекНомер");
	ТрекНомер = ?(ТрекНомер = "", ПараметрыДляФормы.ТрекНомер, ТрекНомер);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуТерминала(МестоположениеИдентификатор)
	
	Если Не ЗначениеЗаполнено(МестоположениеИдентификатор) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОткрытияФормы = Новый Структура;
	
	ПараметрыОткрытияФормы.Вставить("Идентификатор", МестоположениеИдентификатор);
	ПараметрыОткрытияФормы.Вставить("ОрганизацияБизнесСетиСсылка", ОрганизацияБизнесСетиСсылка);
	
	ОткрытьФорму(
		"Обработка.СервисДоставки.Форма.КарточкаТерминала",
		ПараметрыОткрытияФормы,
		ЭтаФорма,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
 
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуГрузоперевозчика()
	
	ПараметрыОткрытияФормы = Новый Структура();
	ПараметрыОткрытияФормы.Вставить("Идентификатор", ГрузоперевозчикИдентификатор);
	ПараметрыОткрытияФормы.Вставить("ОрганизацияБизнесСетиСсылка", ОрганизацияБизнесСетиСсылка);
	
	ОткрытьФорму("Обработка.СервисДоставки.Форма.КарточкаГрузоперевозчика", 
		ПараметрыОткрытияФормы,
		ЭтаФорма,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
							
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность()
	
	Элементы.ГруппаШапка.Видимость = (ИдентификаторЗаказа = "");
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьРеквизитыФормы()
	
	ОчиститьРеквизитыФормыНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ОчиститьРеквизитыФормыНаСервере()
	
	ПараметрыЗаказа = СервисДоставки.НовыйПараметрыОтветаПолучитьГрафикДвиженияЗаказа();
	ОбработатьПараметры(ПараметрыЗаказа);
	ЗаказПредставление = "";
	КарточкаЗаказа.Очистить();
	Список.Очистить();
	
КонецПроцедуры

&НаСервере
Процедура СформироватьКарточкуЗаказа()
	
	КарточкаЗаказа = ТабличныйДокументКарточкаЗаказа();
	
КонецПроцедуры

&НаСервере
Функция ТабличныйДокументКарточкаЗаказа()
	
	ТабличныйДокумент = Новый ТабличныйДокумент();
	
	Обработка = РеквизитФормыВЗначение("Объект");
	Макет = Обработка.ПолучитьМакет("ОтслеживаниеЗаказа");
	
	Если Заблокирован Тогда
		ОбластьМакетаЗаголовокБлокировки = Макет.ПолучитьОбласть("ЗаголовокБлокировки");
		ТабличныйДокумент.Вывести(ОбластьМакетаЗаголовокБлокировки);
	КонецЕсли;
	
	ОбластьМакетаШапка = Макет.ПолучитьОбласть("Шапка");
	
	ПараметрыОбласти = ОбластьМакетаШапка.Параметры;
	
	ПараметрыОбласти.ЗаказПредставление = ЗаказПредставление;
	ПараметрыОбласти.Состояние = Состояние;
	ПараметрыОбласти.ГрузоперевозчикНаименование = ГрузоперевозчикНаименование;
	ПараметрыОбласти.РасшифровкаГрузоперевозчик = "Грузоперевозчик";
	ПараметрыОбласти.ТарифНаименование = ?(ТарифНаименование = "",НСтр("ru='<не указан>'"),ТарифНаименование);
	ПараметрыОбласти.ТрекНомер = ТрекНомер;
	ПараметрыОбласти.ДатаИВремяОформления = Формат(ДатаСозданияЗаказа, "ДЛФ=DT");
	
	ПараметрыОбласти.ТочкаОтправленияГород = ТочкаОтправленияГород;
	ПараметрыОбласти.СпособОтгрузки = СпособОтгрузкиНаименование;
	ПараметрыОбласти.ТочкаОтправленияНаименование = ?(ТочкаОтправленияНаименование = "", НСтр("ru='<не указан>'"),
		ТочкаОтправленияНаименование);
	ПараметрыОбласти.ТочкаОтправленияТипНаименование = ?(ТочкаОтправленияТипНаименование = "", НСтр("ru='Адрес'"),
		ТочкаОтправленияТипНаименование);
	ПараметрыОбласти.РасшифровкаТочкаОтправления = "ТочкаОтправления";
	ПараметрыОбласти.ТочкаОтправленияТелефон = ?(ТочкаОтправленияТелефон = "", ГрузоперевозчикТелефон,
		ТочкаОтправленияТелефон);
	
	ПараметрыОбласти.ТочкаНазначенияГород = ТочкаНазначенияГород;
	ПараметрыОбласти.СпособДоставки = СпособДоставкиНаименование;
	ПараметрыОбласти.ТочкаНазначенияНаименование = ?(ТочкаНазначенияНаименование = "", НСтр("ru='<не указан>'"),
		ТочкаНазначенияНаименование);
	ПараметрыОбласти.ТочкаНазначенияТипНаименование = ?(ТочкаНазначенияТипНаименование = "", НСтр("ru='Адрес'"),
		ТочкаНазначенияТипНаименование);
	ПараметрыОбласти.РасшифровкаТочкаНазначения = "ТочкаНазначения";
	ПараметрыОбласти.ТочкаНазначенияТелефон = ?(ТочкаНазначенияТелефон = "", ГрузоперевозчикТелефон,
		ТочкаНазначенияТелефон);
	
	ТабличныйДокумент.Вывести(ОбластьМакетаШапка);
	
	Если ДополнительнаяИнформация <> "" Тогда
		ОбластьМакетаДополнительнаяИнформация = Макет.ПолучитьОбласть("ДополнительнаяИнформация");
		ОбластьМакетаДополнительнаяИнформация.Параметры.Комментарий = ДополнительнаяИнформация;
		ТабличныйДокумент.Вывести(ОбластьМакетаДополнительнаяИнформация);
	КонецЕсли;

	ОбластьМакетаГрафикЗаголовок = Макет.ПолучитьОбласть("ГрафикЗаголовок");
	ТабличныйДокумент.Вывести(ОбластьМакетаГрафикЗаголовок);
	
	ОбластьМакетаГрафикСтрокаФакт = Макет.ПолучитьОбласть("ГрафикСтрокаФакт");
	ОбластьМакетаГрафикСтрокаПлан = Макет.ПолучитьОбласть("ГрафикСтрокаПлан");
	
	Для Каждого ТекущаяСтрока Из Список Цикл
		
		Если ТекущаяСтрока.ЭтоФакт Тогда
			ТекущаяОбласть = ОбластьМакетаГрафикСтрокаФакт;
		Иначе
			ТекущаяОбласть = ОбластьМакетаГрафикСтрокаПлан;
		КонецЕсли;
		
		ТекущаяОбласть.Параметры.ДатаПредставление = ТекущаяСтрока.ДатаПредставление;
		ТекущаяОбласть.Параметры.Состояние = ТекущаяСтрока.СостояниеНаименование;
		ТекущаяОбласть.Параметры.МестоположениеГород = ТекущаяСтрока.МестоположениеГород;
		
		ТекущаяОбласть.Параметры.МестоположениеПредставление = ?(ТекущаяОбласть.Параметры.МестоположениеГород = "",
			НСтр("ru='<не указано>'"), "");
		
		ТекущаяОбласть.Параметры.МестоположениеТипПредставление = "";
		
		Если ТекущаяСтрока.МестоположениеПредставление <> "" Тогда
			Если ТекущаяСтрока.МестоположениеТипНаименование <> "" Тогда
				ТекущаяОбласть.Параметры.МестоположениеТипПредставление = ТекущаяСтрока.МестоположениеТипНаименование + ":";
			КонецЕсли;
			ТекущаяОбласть.Параметры.МестоположениеПредставление = ТекущаяСтрока.МестоположениеПредставление;
		КонецЕсли;
		
		ТабличныйДокумент.Вывести(ТекущаяОбласть);
			
	КонецЦикла;
	
	Возврат ТабличныйДокумент;
	
КонецФункции

#КонецОбласти

#КонецОбласти
