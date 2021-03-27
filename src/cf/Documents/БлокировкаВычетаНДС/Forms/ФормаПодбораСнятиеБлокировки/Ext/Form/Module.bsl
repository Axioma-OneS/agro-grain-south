﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("Дата", Дата);
	Параметры.Свойство("Организация", Организация);
	Параметры.Свойство("ВыбранныеСчетаФактуры", СписокВыбранныхСчетовФактур);
	
	ЗаполнитьСчетаФактуры();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Для каждого Строка Из СчетаФактуры Цикл
		
		ОбновитьИтоговыеСуммы(Строка);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПеренестиВДокумент(Команда)
	
	СтруктураРеквизитовФормы = Новый Структура;
	
	МассивДокументов = Новый Массив;
	Для каждого Строка  Из ЭтаФорма.СчетаФактуры Цикл
		Если Строка.Флаг Тогда 
			МассивДокументов.Добавить(Строка.СчетФактура);
		КонецЕсли;
	КонецЦикла; 
	СтруктураРеквизитовФормы.Вставить("СчетаФактуры", МассивДокументов);
	
	Закрыть(СтруктураРеквизитовФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	
	УстановитьЗначениеФлага(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	УстановитьЗначениеФлага(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СчетаФактурыФлагПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.СчетаФактуры.ТекущиеДанные;
	
	ОбновитьИтоговыеСуммы(ТекущаяСтрока);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСчетаФактуры() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Заблокировано.Организация КАК Организация,
	|	Заблокировано.СчетФактура КАК СчетФактура,
	|	ДанныеПервичныхДокументов.ДатаРегистратора КАК ДатаПоступления,
	|	Заблокировано.Период КАК ПериодБлокировки,
	|	ДОБАВИТЬКДАТЕ(КОНЕЦПЕРИОДА(ДанныеПервичныхДокументов.ДатаРегистратора, КВАРТАЛ), КВАРТАЛ, 12) КАК ПравоНаВычетДо,
	|	ВЫБОР
	|		КОГДА Заблокировано.СчетФактура В (&СписокВыбранныхСчетовФактур)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ДокументУжеВыбран,
	|	ВЫБОР
	|		КОГДА Заблокировано.СчетФактура В (&СписокВыбранныхСчетовФактур)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК Флаг
	|ПОМЕСТИТЬ ВТ_Заблокировано
	|ИЗ
	|	РегистрСведений.СостоянияБлокировкиВычетаНДСПоСчетамФактурам.СрезПоследних(, Организация = &Организация) КАК Заблокировано
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ДанныеПервичныхДокументов КАК ДанныеПервичныхДокументов
	|		ПО Заблокировано.Организация = ДанныеПервичныхДокументов.Организация
	|			И Заблокировано.СчетФактура = ДанныеПервичныхДокументов.Документ
	|ГДЕ
	|	Заблокировано.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияБлокировкиВычетаНДС.Установлена)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	НДСПредъявленный.Организация КАК Организация,
	|	НДСПредъявленный.СчетФактура КАК СчетФактура,
	|	НДСПредъявленный.НДСОстаток КАК НДС
	|ПОМЕСТИТЬ ВТ_НДСПредъявленный
	|ИЗ
	|	РегистрНакопления.НДСПредъявленный.Остатки(
	|			&Дата,
	|			Организация = &Организация
	|				И СчетФактура В
	|					(ВЫБРАТЬ
	|						Т.СчетФактура
	|					ИЗ
	|						ВТ_Заблокировано КАК Т)) КАК НДСПредъявленный
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	СчетФактура,
	|	Организация
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Заблокировано.Организация КАК Организация,
	|	Заблокировано.СчетФактура КАК СчетФактура,
	|	ЕСТЬNULL(СФПолученный.Ссылка.Дата, ЕСТЬNULL(СФПолученныйНА.Ссылка.Дата, ЕСТЬNULL(ИнойДокументПодтвержденияНДС.Дата, СФВыданный.Ссылка.Дата))) КАК ДатаПолученияСчетаФактуры
	|ПОМЕСТИТЬ ВТ_СчетаФактуры
	|ИЗ
	|	ВТ_Заблокировано КАК Заблокировано
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СчетФактураПолученный.ДокументыОснования КАК СФПолученный
	|		ПО Заблокировано.СчетФактура = СФПолученный.ДокументОснование
	|			И (СФПолученный.Ссылка.Проведен)
	|			И (НЕ СФПолученный.Ссылка.Исправление)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СчетФактураПолученныйНалоговыйАгент.ДокументыОснования КАК СФПолученныйНА
	|		ПО (Заблокировано.СчетФактура = СФПолученный.ДокументОснование)
	|			И (СФПолученный.Ссылка.Проведен)
	|			И (НЕ СФПолученный.Ссылка.Исправление)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СчетФактураВыданный.ДокументыОснования КАК СФВыданный
	|		ПО Заблокировано.СчетФактура = СФВыданный.ДокументОснование
	|			И (СФВыданный.Ссылка.Проведен)
	|			И (НЕ СФВыданный.Ссылка.Исправление)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ИнойДокументПодтвержденияНДС КАК ИнойДокументПодтвержденияНДС
	|		ПО Заблокировано.СчетФактура = ИнойДокументПодтвержденияНДС.ДокументОснование
	|			И (ИнойДокументПодтвержденияНДС.Проведен)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	СчетФактура,
	|	Организация
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Заблокировано.Организация              КАК Организация,
	|	Заблокировано.СчетФактура              КАК СчетФактура,
	|	ЕСТЬNULL(НДСПредъявленный.НДС, 0)      КАК НДС,
	|	Заблокировано.ДатаПоступления          КАК ДатаПоступления,
	|	СчетаФактуры.ДатаПолученияСчетаФактуры КАК ДатаПолученияСчетаФактуры,
	|	Заблокировано.ПериодБлокировки         КАК ПериодБлокировки,
	|	Заблокировано.ПравоНаВычетДо           КАК ПравоНаВычетДо,
	|	Заблокировано.ДокументУжеВыбран        КАК ДокументУжеВыбран,
	|	Заблокировано.Флаг                     КАК Флаг
	|ИЗ
	|	ВТ_Заблокировано КАК Заблокировано
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_НДСПредъявленный КАК НДСПредъявленный
	|		ПО Заблокировано.СчетФактура = НДСПредъявленный.СчетФактура
	|			И Заблокировано.Организация = НДСПредъявленный.Организация
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_СчетаФактуры КАК СчетаФактуры
	|		ПО Заблокировано.СчетФактура = СчетаФактуры.СчетФактура
	|			И Заблокировано.Организация = СчетаФактуры.Организация
	|";
	
	Запрос.УстановитьПараметр("Дата",        Дата);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("СписокВыбранныхСчетовФактур", СписокВыбранныхСчетовФактур);
	
	СчетаФактуры.Загрузить(Запрос.Выполнить().Выгрузить());
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗначениеФлага(ЗначениеФлага)
	
	Для каждого Строка Из СчетаФактуры Цикл
		
		Строка.Флаг = ЗначениеФлага;
		ОбновитьИтоговыеСуммы(Строка);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИтоговыеСуммы(ТекущаяСтрока)
	
	Если ТекущаяСтрока.Флаг Тогда
		ВыбраноНаСумму = ВыбраноНаСумму + ТекущаяСтрока.НДС;
	Иначе
		ВыбраноНаСумму = ВыбраноНаСумму - ТекущаяСтрока.НДС;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти