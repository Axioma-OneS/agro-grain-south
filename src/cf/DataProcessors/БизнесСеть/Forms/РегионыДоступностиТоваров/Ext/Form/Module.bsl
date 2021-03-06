
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаголовокФормы = "";
	
	Параметры.Свойство("ЗаголовокФормы",             ЗаголовокФормы);
	Параметры.Свойство("Организация",                Организация);
	Параметры.Свойство("АдресДанныхАдресовРегионов", АдресДанныхАдресовРегионов);
	Параметры.Свойство("ЭтоПокупатель",              ЭтоПокупатель);
	Параметры.Свойство("ТолькоРегионы",              ТолькоРегионы);
	Параметры.Свойство("КлючХраненияНастроек",       КлючХраненияНастроек);

	Если ЗначениеЗаполнено(ЗаголовокФормы) Тогда
		Заголовок = ЗаголовокФормы;
	КонецЕсли;
	
	ВидКонтактнойИнформации = ВидКонтактнойИнформацииАдреса();
	
	ИспользоватьХранилищеНастроек = Не ЗначениеЗаполнено(АдресДанныхАдресовРегионов);
	
	ПеречитатьДанныеФормы();
	
	НастроитьЭлементыФормыПриСоздании();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПрограммноеЗакрытие И Модифицированность Тогда
		
		Отказ = Истина;
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ПриОтветеНаВопросОСохраненииИзмененныхДанных", ЭтотОбъект);
		
		ТекстВопроса = НСтр("ru = 'Данные модифицированы. Сохранить изменения?'");
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВозможенСамовывозПриИзменении(Элемент)
	
	Элементы.АдресаПродажи.Доступность = ИспользоватьАдреса;
	
КонецПроцедуры

&НаКлиенте
Процедура ВозможнаДоставкаПриИзменении(Элемент)
	
	Элементы.РегионыПродажи.Доступность = ИспользоватьРегионы;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРегионыПродажи

&НаКлиенте
Процедура РегионыПродажиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.РегионыПродажи.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗаголовокВвода = НСтр("ru = 'Введите регион абонента'");
	ОткрытьФормуКонтактнойИнформации(ТекущиеДанные, ЗаголовокВвода);
	
КонецПроцедуры

&НаКлиенте
Процедура РегионыПродажиПриИзменении(Элемент)
	
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура РегионыПродажиПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	ЗаголовокВвода = НСтр("ru = 'Введите регион абонента'");
	ДополнительныеПараметры = Новый Структура("Представление, ЗначенияПолей");
	ДополнительныеПараметры.Вставить("НоваяСтрока", Истина);
	ДополнительныеПараметры.Вставить("ИмяСписка", "РегионыПродажи");
	ОткрытьФормуКонтактнойИнформации(ДополнительныеПараметры, ЗаголовокВвода);
	
КонецПроцедуры

&НаКлиенте
Процедура РегионыПродажиПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	ЗаголовокВвода = НСтр("ru = 'Регион абонента'");
	ОткрытьФормуКонтактнойИнформации(Элементы.РегионыПродажи.ТекущиеДанные, ЗаголовокВвода);
	
КонецПроцедуры

&НаКлиенте
Процедура РегионыПродажиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЗаголовокВвода = НСтр("ru = 'Регион абонента'");
	ОткрытьФормуКонтактнойИнформации(Элементы.РегионыПродажи.ТекущиеДанные, ЗаголовокВвода);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыАдресаПродажи

&НаКлиенте
Процедура АдресаПродажиПредставлениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.АдресаПродажи.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗаголовокВвода = НСтр("ru = 'Введите адрес склада самовывоза'");
	ОткрытьФормуКонтактнойИнформации(ТекущиеДанные, ЗаголовокВвода);

КонецПроцедуры

&НаКлиенте
Процедура АдресаПродажиПриИзменении(Элемент)
	
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура АдресаПродажиПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	ЗаголовокВвода = НСтр("ru = 'Введите адрес склада самовывоза'");
	ДополнительныеПараметры = Новый Структура("Представление, ЗначенияПолей, НоваяСтрока");
	ДополнительныеПараметры.Вставить("ИмяСписка", "АдресаПродажи");
	ОткрытьФормуКонтактнойИнформации(ДополнительныеПараметры, ЗаголовокВвода);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресаПродажиПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	ЗаголовокВвода = НСтр("ru = 'Адрес склада самовывоза'");
	ОткрытьФормуКонтактнойИнформации(Элементы.АдресаПродажи.ТекущиеДанные, ЗаголовокВвода);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресаПродажиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЗаголовокВвода = НСтр("ru = 'Адрес склада самовывоза'");
	ОткрытьФормуКонтактнойИнформации(Элементы.АдресаПродажи.ТекущиеДанные, ЗаголовокВвода);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьРегионыПродажи(Команда)
	
	ОткрытьПодборРегионов("РегионыПродажи");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьАдресаПродажи(Команда)
	
	ОткрытьПодборРегионов("АдресаПродажи");

КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьЗакрыть(Команда)
	
	ЗаписатьДанныеИЗакрыть(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	
	ЗаписатьДанныеИЗакрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Перечитать(Команда)
	
	Оповещение = Новый ОписаниеОповещения("ПеречитатьПродолжение", ЭтотОбъект);
	ПоказатьВопрос(Оповещение, НСтр("ru = 'Данные изменены. Перечитать данные?'"), РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ВидКонтактнойИнформацииАдреса()
	
	ВидКонтактнойИнформации = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Адрес);
	
	ВидКонтактнойИнформации.НастройкиПроверки.ВключатьСтрануВПредставление = Истина;
	
	Возврат ВидКонтактнойИнформации;
	
КонецФункции

&НаКлиенте
Процедура ЗаписатьДанныеИЗакрыть(ЗакрытьФорму = Ложь)
	
	Отказ = Ложь;
	
	ЗаписатьДанныеАдресовРегионов();
	
	Если Не Отказ Тогда
		ПоказатьОповещениеПользователя(НСтр("ru = 'Регионы и адреса 1С:Бизнес-сеть'"),,
			НСтр("ru = 'Регионы и адреса успешно сохранены в сервисе 1С:Бизнес-сеть'"),
			БиблиотекаКартинок.БизнесСеть);
		ПрограммноеЗакрытие = Истина;
		Модифицированность = Ложь;
		Если ЗакрытьФорму Тогда
			Закрыть(АдресДанныхАдресовРегионов);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция АдресХранилищДанныхСписка(ИмяСписка)
	
	Возврат ПоместитьВоВременноеХранилище(ЭтотОбъект[ИмяСписка].Выгрузить());
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуКонтактнойИнформации(ТекущиеДанные, ЗаголовокВвода)
	
	ПараметрыОткрытия = УправлениеКонтактнойИнформациейКлиент.ПараметрыФормыКонтактнойИнформации(
		ВидКонтактнойИнформации, ТекущиеДанные.ЗначенияПолей,
		ТекущиеДанные.Представление,, ПредопределенноеЗначение("Перечисление.ТипыКонтактнойИнформации.Адрес"));
		
	ПараметрыОткрытия.Вставить("Заголовок",          ЗаголовокВвода);
	ПараметрыОткрытия.Вставить("Модифицированность", Истина);
		
	Оповещение = Новый ОписаниеОповещения("ОткрытьФормуКонтактнойИнформацииЗавершение", ЭтотОбъект, ТекущиеДанные);
		
	УправлениеКонтактнойИнформациейКлиент.ОткрытьФормуКонтактнойИнформации(ПараметрыОткрытия, ЭтотОбъект, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуКонтактнойИнформацииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено И ДополнительныеПараметры <> Неопределено Тогда
		
		Если ДополнительныеПараметры.Свойство("НоваяСтрока") Тогда
			ТекущиеДанные = Элементы[ДополнительныеПараметры.ИмяСписка].ТекущиеДанные;
			Если ДополнительныеПараметры = Неопределено Тогда
				Возврат;
			КонецЕсли;
		Иначе
			ТекущиеДанные = ДополнительныеПараметры;
		КонецЕсли;
		
		Если ПустаяСтрока(Результат.Представление) И ПустаяСтрока(Результат.КонтактнаяИнформация) Тогда
			
			// Пустая страна, по умолчанию.
			ТекущиеДанные.Представление = ПредопределенноеЗначение("Справочник.СтраныМира.Россия");
			ТекущиеДанные.ЗначенияПолей = "";
			
		Иначе
			
			Если СтрНайти("РегионыПродажи, РегионыЗакупки", ЭтотОбъект.ТекущийЭлемент.Имя) Тогда
				
				Если Результат.ВведеноВСвободнойФорме Тогда
					ПоказатьПредупреждение(, НСтр("ru = 'Ввод региона в свободной форме запрещен.'"));
					Если ДополнительныеПараметры.Свойство("НоваяСтрока") Тогда
						УдалитьСтрокуСписка(ДополнительныеПараметры.ИмяСписка);
					КонецЕсли;
					Возврат;
				КонецЕсли;
				СжатьАдресКонтактнойИнформации(Результат.КонтактнаяИнформация, Результат.Представление);
			КонецЕсли;
			
			Модифицированность = Истина;
			ТекущиеДанные.Представление = Результат.Представление;
			ТекущиеДанные.ЗначенияПолей = Результат.КонтактнаяИнформация;
			
		КонецЕсли;
		
		
	ИначеЕсли ТипЗнч(ДополнительныеПараметры) = Тип("Структура")
		И ДополнительныеПараметры.Свойство("НоваяСтрока") Тогда
		
		УдалитьСтрокуСписка(ДополнительныеПараметры.ИмяСписка);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьСтрокуСписка(ИмяСписка, СтрокаСписка = Неопределено)
	
	Если СтрокаСписка = Неопределено Тогда
		СтрокаСписка = Элементы[ИмяСписка].ТекущиеДанные;
		Если СтрокаСписка = Неопределено Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	// Удаление текущей строки, если была отмена ввода адреса.
	ЭтотОбъект[ИмяСписка].Удалить(СтрокаСписка);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СжатьАдресКонтактнойИнформации(ЗначенияПолей, Представление)
	
	БизнесСеть.ПолучитьРегионыКонтактнойИнформации(ЗначенияПолей, Представление);

КонецПроцедуры

&НаСервере
Процедура ЗаписатьДанныеАдресовРегионов()
	
	Регионы = РегионыПродажи.Выгрузить();
	Регионы.Свернуть("Представление, ЗначенияПолей");
	
	Адреса = АдресаПродажи.Выгрузить();
	Адреса.Свернуть("Представление, ЗначенияПолей");
	
	ДанныеРегионы = АдресаДляСохранения(Регионы);
	ДанныеАдреса = АдресаДляСохранения(Адреса);
	
	Если ИспользоватьХранилищеНастроек Тогда
		ЗаписатьДанныеВНастройки(ДанныеРегионы, ДанныеАдреса);
	Иначе
		ЗаписатьДанныеВоВременноеХранилище(ДанныеРегионы, ДанныеАдреса);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьДанныеВоВременноеХранилище(ДанныеРегионы, ДанныеАдреса)
	
	ДанныеДляЗаписи = Новый Структура;
	
	ДанныеДляЗаписи.Вставить("Регионы", ДанныеРегионы);
	ДанныеДляЗаписи.Вставить("Адреса", ДанныеАдреса);
	
	АдресДанныхАдресовРегионов = ПоместитьВоВременноеХранилище(ДанныеДляЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьДанныеВНастройки(РегионыДоставки, РегионыСамовывоза)
	
	НастройкиРегионов = БизнесСеть.НастройкиАдресовИРегионовПоиска(КлючХраненияНастроек, Организация);
	
	НастройкиРегионов.ИспользоватьАдреса  = ИспользоватьАдреса;
	НастройкиРегионов.ИспользоватьРегионы = ИспользоватьРегионы;
	НастройкиРегионов.Регионы             = РегионыДоставки;
	НастройкиРегионов.Адреса              = РегионыСамовывоза;
	
	БизнесСеть.СохранитьНастройкиАдресовИРегионовПоиска(КлючХраненияНастроек, Организация, НастройкиРегионов);
	
КонецПроцедуры

&НаСервере
Функция АдресаДляСохранения(ДанныеАдресов)
	
	Результат = Новый Массив;
	
	Если Не ЗначениеЗаполнено(ДанныеАдресов) Тогда
		Возврат Результат;
	КонецЕсли;
	
	Для каждого СтрокаТаблицы Из ДанныеАдресов Цикл
		
		ЗаписьАдреса = БизнесСеть.ОписаниеЗаписиАдреса();
		
		СведенияОбАдресе = РаботаСАдресами.СведенияОбАдресе(СтрокаТаблицы.ЗначенияПолей, Новый Структура("КодыАдреса", Истина));
		
		ИдентификаторАдреса = ?(
			ЗначениеЗаполнено(СведенияОбАдресе.ИдентификаторДома),
			Строка(СведенияОбАдресе.ИдентификаторДома),
			Строка(СведенияОбАдресе.ИдентификаторАдресногоОбъекта));

		КодСтраны = Строка(СведенияОбАдресе.КодСтраны);
		
		ЗаписьАдреса.Представление = СтрокаТаблицы.Представление;
		ЗаписьАдреса.ЗначенияПолей = СтрокаТаблицы.ЗначенияПолей;
		ЗаписьАдреса.Идентификатор = ИдентификаторАдреса;
		ЗаписьАдреса.КодСтраны     = КодСтраны;
		
		Результат.Добавить(ЗаписьАдреса);
		
	КонецЦикла;	
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ПриОтветеНаВопросОСохраненииИзмененныхДанных(РезультатВопроса, ДопПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		
		ЗаписатьДанныеИЗакрыть(Истина);
		
	ИначеЕсли РезультатВопроса = КодВозвратаДиалога.Нет Тогда
		
		Модифицированность = Ложь;
		Закрыть(АдресДанныхАдресовРегионов);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПеречитатьДанныеФормы()

	ОчиститьДанныеФормы();
	
	Если ИспользоватьХранилищеНастроек Тогда
		ЗаполнитьФормуПоДаннымХранилищаНастроек();
	Иначе
		ЗаполнитьФормуПоДаннымВременногоХранилища();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ОчиститьДанныеФормы()
	
	РегионыПродажи.Очистить();
	АдресаПродажи.Очистить();
	
	ИспользоватьРегионы = Ложь;
	ИспользоватьАдреса  = Ложь;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьФормуПоДаннымХранилищаНастроек()
	
	Настройки = БизнесСеть.НастройкиАдресовИРегионовПоиска(КлючХраненияНастроек, Организация);
	
	Для каждого ЭлементКоллекции Из Настройки.Регионы Цикл
		ЗаполнитьЗначенияСвойств(РегионыПродажи.Добавить(), ЭлементКоллекции);
	КонецЦикла;
	
	Для каждого ЭлементКоллекции Из Настройки.Адреса Цикл
		ЗаполнитьЗначенияСвойств(АдресаПродажи.Добавить(), ЭлементКоллекции);
	КонецЦикла;	
	
	ИспользоватьАдреса  = Настройки.ИспользоватьАдреса;
	ИспользоватьРегионы = Настройки.ИспользоватьРегионы;
	
	Если ТолькоРегионы Тогда
		ИспользоватьРегионы = Истина;
		ИспользоватьАдреса  = Ложь;
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьФормуПоДаннымВременногоХранилища()
	
	Если Не ЭтоАдресВременногоХранилища(АдресДанныхАдресовРегионов) Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеАдресовРегионов = ПолучитьИзВременногоХранилища(АдресДанныхАдресовРегионов);
	
	Для каждого ЭлементКоллекции Из ДанныеАдресовРегионов.Регионы Цикл
		ЗаполнитьЗначенияСвойств(РегионыПродажи.Добавить(), ЭлементКоллекции);
	КонецЦикла;
	
	Для каждого ЭлементКоллекции Из ДанныеАдресовРегионов.Адреса Цикл
		ЗаполнитьЗначенияСвойств(АдресаПродажи.Добавить(), ЭлементКоллекции);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПодборРегионов(ИмяСписка)

	ПараметрыОткрытия = Новый Структура;
	
	Если СтрНайти("РегионыПродажи, РегионыЗакупки", ИмяСписка) Тогда
		ПараметрыОткрытия.Вставить("РежимВыбора", "Регионы");
	КонецЕсли;
	
	ПараметрыОткрытия.Вставить("Организация",         Организация);
	ПараметрыОткрытия.Вставить("АдресТаблицыАдресов", АдресХранилищДанныхСписка(ИмяСписка));
	
	ДополнительныеПараметры = Новый Структура("ИмяСписка", ИмяСписка);
	Оповещение = Новый ОписаниеОповещения("ОткрытьПодборРегионовЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ОчиститьСообщения();
	
	ОткрытьФорму("Обработка.БизнесСеть.Форма.ПодборРегионов",
		ПараметрыОткрытия, ЭтотОбъект,,,, Оповещение);

КонецПроцедуры
	
&НаКлиенте
Процедура ОткрытьПодборРегионовЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") И Результат.Свойство("АдресТаблицыАдресов") Тогда
		Модифицированность = Истина;
		ОбновитьДанныеНаСервере(Результат.АдресТаблицыАдресов, ДополнительныеПараметры.ИмяСписка);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДанныеНаСервере(АдресТаблицыАдресов, ИмяСписка)
	
	// Необходимо обновить таблицу, с учетом существующих свойств.
	ТаблицаРезультата = ПолучитьИзВременногоХранилища(АдресТаблицыАдресов);
	Список = ЭтотОбъект[ИмяСписка]; // Регионы или Адреса.
	
	Для каждого СтрокаРезультата Из ТаблицаРезультата Цикл
		
		СтрокиСписка = Список.НайтиСтроки(Новый Структура("Представление", СтрокаРезультата.Представление));
		Если СтрокиСписка.Количество() = 0 И СтрокаРезультата.Пометка Тогда
			// Добавление новой строки
			НоваяСтрока = Список.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаРезультата);
		Иначе
			Если Не СтрокаРезультата.Пометка Тогда
				// Удаление не помеченной строки.
				Для каждого УдаляемаяСтрокаСписка Из СтрокиСписка Цикл
					Список.Удалить(УдаляемаяСтрокаСписка);
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЭлементыФормыПриСоздании()
	
	Элементы.ИспользоватьРегионы.Видимость = ИспользоватьХранилищеНастроек;
	Элементы.ИспользоватьАдреса.Видимость  = ИспользоватьХранилищеНастроек;
	
	Элементы.РегионыПродажи.Доступность = НЕ ИспользоватьХранилищеНастроек ИЛИ ИспользоватьРегионы;
	Элементы.АдресаПродажи.Доступность  = НЕ ИспользоватьХранилищеНастроек ИЛИ ИспользоватьАдреса;
	
	Если ЭтоПокупатель Тогда
		Элементы.ГруппаРегионыПродажи.Заголовок = НСтр("ru = 'Регионы закупок (для самовывоза)'");
		Элементы.ГруппаАдресаПродажи.Заголовок  = НСтр("ru = 'Адреса складов (для доставки)'");
		Элементы.ИспользоватьРегионы.Заголовок    = НСтр("ru = 'Возможен самовывоз'");
		Элементы.ИспользоватьАдреса.Заголовок     = НСтр("ru = 'Возможна доставка'");
	КонецЕсли;
	
	Если ТолькоРегионы Тогда
		Элементы.ГруппаАдресаПродажи.Видимость = Ложь;
		Элементы.ИспользоватьРегионы.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПеречитатьПродолжение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ПеречитатьДанныеФормы();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
