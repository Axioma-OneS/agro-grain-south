﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДатаПереходаПраваСобственности = Параметры.ДатаПереходаПраваСобственности;
	ВыделенныеСтрокиСодержатНеТолькоОтгрузку = Параметры.ВыделенныеСтрокиСодержатНеТолькоОтгрузку;
	
	Если ВыделенныеСтрокиСодержатНеТолькоОтгрузку Тогда
		ТекстПояснения = НСтр("ru='У выделенных в списке документов будет установлен статус ""Реализовано"".
			|В документах отгрузки без перехода права собственности будет установлена'");
	Иначе		
		ТекстПояснения = НСтр("ru='У выделенных в списке документов реализации будут установлены статус ""Реализовано"" и'");
	КонецЕсли;
		
	Элементы.ДекорацияПояснение.Заголовок = ТекстПояснения;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьСтатус(Команда)
	
	Если ПроверитьЗаполнение() Тогда
		Закрыть(Новый Структура("НоваяДата", ДатаПереходаПраваСобственности));
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();

КонецПроцедуры

#КонецОбласти
