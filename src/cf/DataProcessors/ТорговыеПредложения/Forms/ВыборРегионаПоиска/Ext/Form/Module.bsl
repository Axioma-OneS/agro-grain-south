
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("РегионРежимОтбора",   РегионРежимОтбора);
	Параметры.Свойство("РегионПредставление", РегионПредставление);
	Параметры.Свойство("РегионЗначенияПолей", РегионЗначенияПолей);
	Параметры.Свойство("Организация",         Организация);
	
	ПроверитьРегистрациюОрганизаций();
	
	Если ПустаяСтрока(РегионРежимОтбора) Тогда
		РегионРежимОтбора = 0;
	КонецЕсли;
		
	УстановитьВидимостьДоступность(РегионРежимОтбора, Элементы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "БизнесСеть_РегистрацияОрганизаций" Тогда
		
		ПроверитьРегистрациюОрганизаций();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РежимВыбораПриИзменении(Элемент)
	
	УстановитьВидимостьДоступность(РегионРежимОтбора, Элементы);
	
КонецПроцедуры

&НаКлиенте
Процедура РегионПредставлениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОткрытьФормуКонтактнойИнформации();
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаОК(Команда)
	
	Если РегионРежимОтбора = 2 И ПустаяСтрока(РегионПредставление) Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не выбран регион'"),, "РегионПредставление");
		Возврат;
	КонецЕсли;
	
	Если РегионРежимОтбора = 1 И Не ОрганизацияЗарегистрирована Тогда
		Оповещение = Новый ОписаниеОповещения("ВопросРегистрацииОрганизацииПродолжение", ЭтотОбъект);
		ПоказатьВопрос(Оповещение,
			НСтр("ru = 'Для установки отбора по региону профиля необходимо зарегистрироваться в сервисе 1С:Бизнес-сеть. Продолжить?'"),
			РежимДиалогаВопрос.ДаНет);
		Возврат;
	КонецЕсли;

	ВыбратьРегион();
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьРегионыНажатие(Элемент)
	
	ПараметрыФормы = БизнесСетьСлужебныйКлиент.ОписаниеПараметровФормыНастройкиРегионов();
	
	ПараметрыФормы.Организация          = Организация;
	ПараметрыФормы.ЭтоПокупатель        = Истина;
	ПараметрыФормы.ЗаголовокФормы       = НСтр("ru = 'Регионы поиска'");
	ПараметрыФормы.КлючХраненияНастроек = "ТорговыеПредложения";
	
	БизнесСетьСлужебныйКлиент.ОткрытьФормуНастройкиРегионов(ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВопросРегистрацииОрганизацииПродолжение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		Оповещение = Новый ОписаниеОповещения("КнопкаОКПродолжение", ЭтотОбъект);
		ОчиститьСообщения();
		ОткрытьФорму("Обработка.БизнесСеть.Форма.РегистрацияОрганизаций",, ЭтотОбъект,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаОКПродолжение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Истина Тогда
		ВыбратьРегион();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьРегион()
	
	ПараметрыЗакрытия = Новый Структура;
	
	ПараметрыЗакрытия.Вставить("РегионРежимОтбора",   РегионРежимОтбора);
	ПараметрыЗакрытия.Вставить("РегионПредставление", РегионПредставление);
	ПараметрыЗакрытия.Вставить("РегионЗначенияПолей", РегионЗначенияПолей);
	
	Закрыть(ПараметрыЗакрытия);
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьРегистрациюОрганизаций()
	
	ОрганизацияЗарегистрирована = БизнесСеть.ОрганизацияПодключена(Организация);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьДоступность(РежимВыбора, Элементы)

	Элементы.ГруппаВводаРегиона.Доступность = РежимВыбора = 2;

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуКонтактнойИнформации()
	
	ПараметрыВида = ПараметрыВидаКонтактнойИнформации();
	ПараметрыВида.Наименование = НСтр("ru = 'Введите регион поставщиков'");
	ПараметрыВида.НастройкиПроверки.ВключатьСтрануВПредставление = Истина;
	ПараметрыВида.НастройкиПроверки.ПроверятьПоФИАС              = Истина;
	ПараметрыВида.РедактированиеТолькоВДиалоге                   = Истина;
	
	ПараметрыОткрытия = УправлениеКонтактнойИнформациейКлиент.ПараметрыФормыКонтактнойИнформации(
		ПараметрыВида, РегионЗначенияПолей, РегионПредставление);
	
	Оповещение = Новый ОписаниеОповещения("ОткрытьФормуКонтактнойИнформацииЗавершение", ЭтотОбъект);
	
	УправлениеКонтактнойИнформациейКлиент.ОткрытьФормуКонтактнойИнформации(ПараметрыОткрытия, ЭтотОбъект, Оповещение);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПараметрыВидаКонтактнойИнформации()
	
	Возврат УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(
		ПредопределенноеЗначение("Перечисление.ТипыКонтактнойИнформации.Адрес"));
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуКонтактнойИнформацииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		РегионПредставление = Результат.Представление;
		РегионЗначенияПолей = Результат.Значение;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти