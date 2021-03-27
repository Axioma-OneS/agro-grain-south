﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	КассаККМ = Параметры.КассаККМ;
	
	Период = Новый СтандартныйПериод(ВариантСтандартногоПериода.Сегодня);
	
	СтруктураСостояниеКассовойСмены = РозничныеПродажи.ПолучитьСостояниеКассовойСмены(КассаККМ);
	КассоваяСмена = СтруктураСостояниеКассовойСмены.КассоваяСмена;
	ИспользуетсяККТФЗ54 = РозничныеПродажиВызовСервера.ИспользуетсяККТФЗ54(КассоваяСмена);
	
	Элементы.Период.Видимость = ИспользуетсяККТФЗ54;
	
	ЗаполнитьТаблицуТоваров();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	Если КлиентскоеПриложение.ТекущийВариантИнтерфейса() = ВариантИнтерфейсаКлиентскогоПриложения.Версия8_2 Тогда
		Элементы.ГруппаИтого.ЦветФона = Новый Цвет();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОформитьВозврат(Команда)
	
	Если ПодобраноПозиций = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ЧекККМ = Неопределено;
	Для Каждого СтрокаТЧ Из ТаблицаСертификатов Цикл
		Если СтрокаТЧ.Выбран Тогда
			ЧекККМ = СтрокаТЧ.ЧекККМ;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ПодарочныеСертификаты", АдресВоВременномХранилище(ВладелецФормы.УникальныйИдентификатор));
	ПараметрыОткрытия.Вставить("ЧекККМ", ЧекККМ);
	
	ОткрытьФорму("Документ.ВозвратПодарочныхСертификатов.Форма.ФормаДокументаРМК", Новый Структура("Основание", ПараметрыОткрытия), ВладелецФормы);
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТаблицаСертификатовВыбранПриИзменении(Элемент)
	
	ТаблицаСертификатовВыбранПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Функция АдресВоВременномХранилище(УникальныйИдентификатор)
	
	ПодарочныеСертификаты = ТаблицаСертификатов.Выгрузить(Новый Массив);
	Для Каждого СтрокаТЧ Из ТаблицаСертификатов Цикл
		Если СтрокаТЧ.Выбран Тогда
			ЗаполнитьЗначенияСвойств(ПодарочныеСертификаты.Добавить(), СтрокаТЧ);
		КонецЕсли;
	КонецЦикла;
	
	Возврат ПоместитьВоВременноеХранилище(ПодарочныеСертификаты, УникальныйИдентификатор);
	
КонецФункции

&НаСервере
Процедура ЗаполнитьТаблицуТоваров()
	
	ТаблицаСертификатов.Очистить();
	
	ТекстУсловияИспользуетсяККТФЗ54        = "И Т.Дата >= &ДатаНачала И Т.Дата <= &ДатаОкончания";
	ТекстУсловияИспользуетсяККТФЗ54Возврат = "И Т.Дата >= &ДатаНачала";
	ТекстУсловияНеИспользуетсяККТФЗ54      = "И Т.КассоваяСмена = &КассоваяСмена";
	ТекстУсловияНомерЧека                  = "И ФискальныеОперации.НомерЧекаККМ = &НомерЧекаККМ";
	ТекстУсловияВидПодарочногоСертификата =
	"И Т.Ссылка В (
	|	ВЫБРАТЬ Т.Ссылка
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ПодарочныеСертификаты КАК Т
	|ГДЕ
	|	Т.Ссылка.КассоваяСмена = &КассоваяСмена И Т.ПодарочныйСертификат.Владелец = &ВидПодарочногоСертификата)
	|";
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ ЧекиККМ
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов КАК Т
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ФискальныеОперации КАК ФискальныеОперации
	|		ПО Т.Ссылка = ФискальныеОперации.ДокументОснование
	|ГДЕ
	|	Т.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыЧековККМ.Пробит)
	|	" + ?(ИспользуетсяККТФЗ54,                          ТекстУсловияИспользуетсяККТФЗ54, ТекстУсловияНеИспользуетсяККТФЗ54) + "
	|	" + ?(ЗначениеЗаполнено(НомерЧекаККМ),              ТекстУсловияНомерЧека,                 "")                          + "
	|	" + ?(ЗначениеЗаполнено(ВидПодарочногоСертификата), ТекстУсловияВидПодарочногоСертификата, "")                          + "
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.ВозвратПодарочныхСертификатов КАК Т
	|ГДЕ
	|	Т.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыЧековККМ.Пробит)
	|	" + ?(ИспользуетсяККТФЗ54, ТекстУсловияИспользуетсяККТФЗ54Возврат, ТекстУсловияНеИспользуетсяККТФЗ54) + "
	|;
	|
	|///////////////////////////////////////////////////////////////////////
	|";

	ТекстЗапроса = ТекстЗапроса +
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ОплатаПлатежнымиКартами.Ссылка,
	|	ИСТИНА КАК ОплаченКартой
	|ПОМЕСТИТЬ ЧекиККМОплаченныеКартами
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ОплатаПлатежнымиКартами КАК ОплатаПлатежнымиКартами
	|ГДЕ
	|	ОплатаПлатежнымиКартами.Ссылка В (Выбрать Т.Ссылка ИЗ ЧекиККМ КАК Т)
	|;
	|
	|///////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПодарочныеСертификаты.Ссылка               КАК ЧекККМ,
	|	
	|	ПодарочныеСертификаты.ПодарочныйСертификат КАК ПодарочныйСертификат,
	|	1                                          КАК Количество,
	|	ПодарочныеСертификаты.Сумма                КАК Сумма
	|	
	|ПОМЕСТИТЬ врПодарочныеСертификаты
	|ИЗ
	|	Документ.РеализацияПодарочныхСертификатов.ПодарочныеСертификаты КАК ПодарочныеСертификаты
	|ГДЕ
	|	ПодарочныеСертификаты.Ссылка В (Выбрать Т.Ссылка ИЗ ЧекиККМ КАК Т)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ПодарочныеСертификаты.Ссылка.РеализацияПодарочныхСертификатов КАК ЧекККМ,
	|	
	|	ПодарочныеСертификаты.ПодарочныйСертификат КАК ПодарочныйСертификат,
	|	-1                                         КАК Количество,
	|	-ПодарочныеСертификаты.Сумма               КАК Сумма
	|ИЗ
	|	Документ.ВозвратПодарочныхСертификатов.ПодарочныеСертификаты КАК ПодарочныеСертификаты
	|ГДЕ
	|	ПодарочныеСертификаты.Ссылка В (Выбрать Т.Ссылка ИЗ ЧекиККМ КАК Т)
	|;
	|
	|///////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПодарочныеСертификаты.ЧекККМ               КАК ЧекККМ,
	|	ПодарочныеСертификаты.ПодарочныйСертификат КАК ПодарочныйСертификат,
	|	СУММА(ПодарочныеСертификаты.Количество)    КАК Количество,
	|	СУММА(ПодарочныеСертификаты.Сумма)         КАК Сумма
	|ПОМЕСТИТЬ Результат
	|ИЗ
	|	врПодарочныеСертификаты КАК ПодарочныеСертификаты
	|СГРУППИРОВАТЬ ПО
	|	ПодарочныеСертификаты.ЧекККМ,
	|	ПодарочныеСертификаты.ПодарочныйСертификат
	|ИМЕЮЩИЕ
	|	СУММА(ПодарочныеСертификаты.Количество) > 0
	|;
	|
	|///////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПодарочныеСертификаты.ЧекККМ                            КАК ЧекККМ,
	|	ФискальныеОперации.НомерЧекаККМ КАК НомерЧекаККМ,
	|	ЕСТЬNULL(ЧекиККМОплаченныеКартами.ОплаченКартой, ЛОЖЬ)  КАК ОплаченКартой,
	|	
	|	ПодарочныеСертификаты.ПодарочныйСертификат             КАК ПодарочныйСертификат,
	|	ПодарочныеСертификаты.Сумма             КАК Сумма
	|ИЗ
	|	Результат КАК ПодарочныеСертификаты
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ФискальныеОперации КАК ФискальныеОперации
	|		ПО ПодарочныеСертификаты.ЧекККМ = ФискальныеОперации.ДокументОснование
	|		
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЧекиККМОплаченныеКартами ПО ПодарочныеСертификаты.ЧекККМ = ЧекиККМОплаченныеКартами.Ссылка
	|";
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.Параметры.Вставить("КассоваяСмена", КассоваяСмена);
	
	Если ЗначениеЗаполнено(НомерЧекаККМ) Тогда
		Запрос.Параметры.Вставить("НомерЧекаККМ", НомерЧекаККМ);
	КонецЕсли;
	Если ЗначениеЗаполнено(ВидПодарочногоСертификата) Тогда
		Запрос.Параметры.Вставить("ВидПодарочногоСертификата", ВидПодарочногоСертификата);
	КонецЕсли;
	Если ИспользуетсяККТФЗ54 Тогда
		Запрос.Параметры.Вставить("ДатаНачала",     Период.ДатаНачала);
		Запрос.Параметры.Вставить("ДатаОкончания",  Период.ДатаОкончания);
	КонецЕсли;
	
	ПодобраноПозиций = 0;
	Всего = 0;
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		СтрокаТЧ = ТаблицаСертификатов.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТЧ, Выборка);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиСертификаты(Команда)
	
	ЗаполнитьТаблицуТоваров();
	
КонецПроцедуры

&НаСервере
Процедура ПересчитатьНаСервере()
	
	ПодобраноПозиций = 0;
	Всего            = 0;
	
	Для Каждого СтрокаТЧ Из ТаблицаСертификатов Цикл
		
		Если НЕ СтрокаТЧ.Выбран Тогда
			Продолжить;
		КонецЕсли;
		
		ПодобраноПозиций = ПодобраноПозиций + 1;
		Всего = Всего + СтрокаТЧ.Сумма;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ТаблицаСертификатовВыбранПриИзмененииНаСервере()
	
	ТекущиеДанные = ТаблицаСертификатов.НайтиПоИдентификатору(Элементы.ТаблицаСертификатов.ТекущаяСтрока);
	ЧекККМ        = ТекущиеДанные.ЧекККМ;
	ОплаченКартой = ТекущиеДанные.ОплаченКартой;
	Для Каждого СтрокаТЧ Из ТаблицаСертификатов Цикл
		Если СтрокаТЧ.ЧекККМ = ЧекККМ И ОплаченКартой Тогда
			СтрокаТЧ.Выбран = ТекущиеДанные.Выбран;
		КонецЕсли;
		Если НЕ СтрокаТЧ.ЧекККМ = ЧекККМ Тогда
			СтрокаТЧ.Выбран = Ложь;
		КонецЕсли;
	КонецЦикла;
	
	ПересчитатьНаСервере();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
