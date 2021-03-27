﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Документы.СверкаВзаиморасчетов.ИнициализироватьКомпоновщикНастроек(КомпоновщикОтбор, УникальныйИдентификатор, Параметры.НастройкиОтбора);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
//Код процедур и функций
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы
//Код процедур и функций
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьОтбор(Команда)
	
	Результат = Новый Структура;
	Результат.Вставить("НастройкиОтбора", ПолучитьНастройкиОтбора());
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменаУстановки(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьНастройкиОтбора()
	
	Возврат КомпоновщикОтбор.ПолучитьНастройки();
	
КонецФункции

#КонецОбласти