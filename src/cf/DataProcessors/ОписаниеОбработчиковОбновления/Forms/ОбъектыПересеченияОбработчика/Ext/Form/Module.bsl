﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Параметры.АдресДанных) Тогда
		Данные = ПолучитьИзВременногоХранилища(Параметры.АдресДанных);
		Пересечения.Загрузить(Данные);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти