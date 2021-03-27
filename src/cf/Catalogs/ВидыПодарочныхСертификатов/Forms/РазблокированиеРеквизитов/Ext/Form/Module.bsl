﻿#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

&НаКлиенте
Перем ФормаДлительнойОперации;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РазрешитьРедактирование(Команда)

	Закрыть(Истина);

КонецПроцедуры

&НаКлиенте
Процедура ПроверитьИспользованиеОбъекта(Команда)
	
	ЗапретРедактированияРеквизитовОбъектовУТКлиент.ПроверитьИспользованиеОбъекта(ЭтаФорма, ПараметрыОбработчикаОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	ЗапретРедактированияРеквизитовОбъектовУТКлиент.ПроверитьВыполнениеЗадания(
		ЭтаФорма,
		ФормаДлительнойОперации,
		ПараметрыОбработчикаОжидания);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
