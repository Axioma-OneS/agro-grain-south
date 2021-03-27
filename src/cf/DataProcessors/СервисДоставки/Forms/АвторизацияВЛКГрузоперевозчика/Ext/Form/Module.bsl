﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не СервисДоставки.ПравоРаботыССервисомДоставки(Истина) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	ДоступнаОтправкаЗаказовНаДоставку = СервисДоставки.ПравоОтправкиЗаказовНаДоставкуПеревозчику();
	
	Если Не ДоступнаОтправкаЗаказовНаДоставку Тогда
		Отказ = Истина;
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Недостаточно прав для настройки авторизации.
			|Должна быть доступна роль ""Отправка заказов на доставку перевозчику сервиса 1С:Доставка""'"));
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("Заголовок", Заголовок);
	Параметры.Свойство("Организация", Организация);
	Параметры.Свойство("Перевозчик", Перевозчик);
	Параметры.Свойство("ИдентификаторСервиса", ИдентификаторСервиса);
	
	Элементы.ГруппаАвторизация.ТолькоПросмотр = Истина;
	Элементы.Изменить.Видимость = Ложь;
	Элементы.Записать.Видимость = Ложь;
	
	ФоновоеЗаданиеПолучитьНастройкиАвторизации = ПолучитьНастройкиАвторизацииВФоне();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЗначениеЗаполнено(ФоновоеЗаданиеПолучитьНастройкиАвторизации) Тогда
		
		ПараметрыОперации = Новый Структура("ВыводитьОкноОжидания");
		ПараметрыОперации.Вставить("ИмяПроцедуры", СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьНастройкиАвторизации());
		ПараметрыОперации.Вставить("НаименованиеОперации", НСтр("ru = 'Получение настроек авторизации.'"));
		
		ОжидатьЗавершениеВыполненияЗапроса(ПараметрыОперации);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Записать(Команда)
	
	ПараметрыОперации = Новый Структура("ИмяПроцедуры, НаименованиеОперации, ВыводитьОкноОжидания");
	ПараметрыОперации.ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыЗаписатьНастройкиАвторизации();
	ПараметрыОперации.НаименованиеОперации = НСтр("ru = 'Запись настроек авторизации.'");
	
	ВыполнитьЗапрос(ПараметрыОперации);
КонецПроцедуры

&НаКлиенте
Процедура Изменить(Команда)
	
	Элементы.ГруппаАвторизация.ТолькоПросмотр = Истина;
	Элементы.Изменить.Видимость = Ложь;
	Элементы.Записать.Видимость = Истина;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ВыполнитьЗапросВФоне

&НаСервере
Функция ВыполнитьЗапросВФоне(ИнтернетПоддержкаПодключена, ПараметрыОперации)
	
	// Проверка подключения Интернет-поддержки пользователей.
	ИнтернетПоддержкаПодключена =
		ИнтернетПоддержкаПользователей.ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки();
	Если Не ИнтернетПоддержкаПодключена Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Отказ = Ложь;
	ПараметрыЗапроса = ПараметрыЗапроса(ПараметрыОперации, Отказ);
	
	Если ПараметрыЗапроса.Свойство("ОрганизацияБизнесСетиСсылка") Тогда
		СервисДоставкиСлужебный.ПроверитьОрганизациюБизнесСети(ПараметрыЗапроса.ОрганизацияБизнесСетиСсылка, Отказ);
	Иначе
		Отказ = Истина;
	КонецЕсли;
	
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
Функция ПолучитьНастройкиАвторизацииВФоне()
	
	ПараметрыОперации = Новый Структура("ВыводитьОкноОжидания");
	ПараметрыОперации.Вставить("ИмяПроцедуры", СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьНастройкиАвторизации());
	ПараметрыОперации.Вставить("НаименованиеОперации", НСтр("ru = 'Получение настроек авторизации.'"));
	
	Возврат ВыполнитьЗапросВФоне(Ложь, ПараметрыОперации);
	
КонецФункции

#КонецОбласти

#Область ПараметрыЗапроса

&НаСервере
Функция ПараметрыЗапроса(ПараметрыОперации, Отказ)
	
	ПараметрыЗапроса = Новый Структура();
	
	ИмяПроцедуры = ПараметрыОперации.ИмяПроцедуры;
	
	Если ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьНастройкиАвторизации() Тогда
		ПараметрыЗапроса = ПараметрыЗапросаПолучитьНастройкиАвторизации(ПараметрыОперации, Отказ);
	ИначеЕсли ИмяПроцедуры = СервисДоставкиКлиентСервер.ИмяПроцедурыЗаписатьНастройкиАвторизации() Тогда
		ПараметрыЗапроса = ПараметрыЗапросаЗаписатьНастройкиАвторизации(ПараметрыОперации, Отказ);
	КонецЕсли;
	
	ПараметрыЗапроса.Вставить("ОрганизацияБизнесСетиСсылка", Организация);
	
	Возврат ПараметрыЗапроса;
	
КонецФункции

&НаСервере
Функция ПараметрыЗапросаПолучитьНастройкиАвторизации(ПараметрыОперации, Отказ)
	
	ПараметрыЗапроса = СервисДоставки.НовыйПараметрыЗапросаПолучитьНастройкиАвторизации();
	ПараметрыЗапроса.Вставить("ИдентификаторСервиса", ИдентификаторСервиса);
	
	Возврат ПараметрыЗапроса;
КонецФункции

&НаСервере
Функция ПараметрыЗапросаЗаписатьНастройкиАвторизации(ПараметрыОперации, Отказ)
	
	ПараметрыЗапроса = СервисДоставки.НовыйПараметрыЗапросаЗаписатьНастройкиАвторизации();
	ПараметрыЗапроса.Вставить("Логин", Логин);
	ПараметрыЗапроса.Вставить("Пароль", Пароль);
	ПараметрыЗапроса.Вставить("Токен", Токен);
	ПараметрыЗапроса.Вставить("ПравоДоступа", ПравоДоступа);
	ПараметрыЗапроса.Вставить("ИдентификаторСервиса", ИдентификаторСервиса);
	
	Возврат ПараметрыЗапроса;
КонецФункции

#КонецОбласти

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
	ИначеЕсли ТипЗнч(Результат) = Тип("Структура") И Результат.Свойство("Логин") Тогда
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
	
	ИмяФоновогоЗадания = "ФоновоеЗадание" + ПараметрыОперации.ИмяПроцедуры;
	ФоновоеЗадание = ЭтотОбъект[ИмяФоновогоЗадания];
	ПараметрыОперации.Вставить("ФоновоеЗадание", ФоновоеЗадание);
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ТекстСообщения = ПараметрыОперации.НаименованиеОперации;
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = Ложь;
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ПараметрыОжидания.ОповещениеПользователя.Показать = Ложь;
	ПараметрыОжидания.ВыводитьСообщения = Истина;
	ПараметрыОжидания.Вставить("ИдентификаторЗадания", ФоновоеЗадание.ИдентификаторЗадания);
	
	ОбработкаЗавершения = Новый ОписаниеОповещения("ВыполнитьЗапросЗавершение",
		ЭтотОбъект, ПараметрыОперации);
		
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ФоновоеЗадание, ОбработкаЗавершения, ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЗапросЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Отказ = Ложь;
	ТекстСообщения = "";
	ДанныеОбновлены = Ложь;
	
	ИмяФоновогоЗадания = "ФоновоеЗадание" + ДополнительныеПараметры.ИмяПроцедуры;
	ФоновоеЗадание = ЭтотОбъект[ИмяФоновогоЗадания];
	
	СервисДоставкиКлиент.ОбработатьРезультатФоновогоЗадания(Результат, ДополнительныеПараметры, Отказ);
	Если Результат = Неопределено ИЛИ ФоновоеЗадание = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не Отказ И Результат.Статус = "Выполнено" Тогда
		Если ЗначениеЗаполнено(Результат.АдресРезультата)
			И ЭтоАдресВременногоХранилища(Результат.АдресРезультата) 
			И ДополнительныеПараметры.ФоновоеЗадание.ИдентификаторЗадания =
				ЭтотОбъект[ИмяФоновогоЗадания].ИдентификаторЗадания Тогда
			
			Если ДополнительныеПараметры.ИмяПроцедуры =
					СервисДоставкиКлиентСервер.ИмяПроцедурыПолучитьНастройкиАвторизации() Тогда
				
				ЗагрузитьРезультатПолученияНастроекАвторизации(Результат.АдресРезультата);
				ЭтотОбъект[ИмяФоновогоЗадания] = Неопределено;
				ДанныеОбновлены = Истина;
				
			ИначеЕсли ДополнительныеПараметры.ИмяПроцедуры =
					СервисДоставкиКлиентСервер.ИмяПроцедурыЗаписатьНастройкиАвторизации() Тогда
				
				ЗагрузитьРезультатЗаписиНастроекАвторизации(Результат.АдресРезультата);
				ЭтотОбъект[ИмяФоновогоЗадания] = Неопределено;
				ДанныеОбновлены = Истина;
				
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ЗагрузитьРезультатПолученияНастроекАвторизации(АдресРезультата)
	
	ОперацияВыполнена = Ложь;
	
	Если ЭтоАдресВременногоХранилища(АдресРезультата) Тогда
		
		Результат = ПолучитьИзВременногоХранилища(АдресРезультата);
		
		Если ЗначениеЗаполнено(Результат) И ТипЗнч(Результат) = Тип("Структура") Тогда
			
			Результат.Свойство("Авторизован", Авторизован);
			
			ПравоДоступа = "";
			Элементы.ПравоДоступа.СписокВыбора.Очистить();
			Для Каждого Элемент Из Результат.ПраваДоступа Цикл
				ПравоДоступа = Элемент;
				Элементы.ПравоДоступа.СписокВыбора.Добавить(ПравоДоступа);
			КонецЦикла;
			
			ОперацияВыполнена = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Если ОперацияВыполнена Тогда
		
		Элементы.ГруппаАвторизация.ТолькоПросмотр = Авторизован;
		Элементы.Изменить.Видимость = Авторизован;
		Элементы.Записать.Видимость = Не Авторизован;
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьРезультатЗаписиНастроекАвторизации(АдресРезультата)
	
	ОперацияВыполнена = Ложь;
	
	Если ЭтоАдресВременногоХранилища(АдресРезультата) Тогда
		
		Результат = ПолучитьИзВременногоХранилища(АдресРезультата);
		
		Если ЗначениеЗаполнено(Результат) И ТипЗнч(Результат) = Тип("Структура") Тогда
			
			Если Результат.Свойство("Записано") Тогда
				
				ОперацияВыполнена = Истина
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
	Если ОперацияВыполнена Тогда
		
		Элементы.ГруппаАвторизация.ТолькоПросмотр = Истина;
		Элементы.Изменить.Видимость = Истина;
		Элементы.Записать.Видимость = Ложь;
		
	КонецЕсли;
КонецПроцедуры


#КонецОбласти
