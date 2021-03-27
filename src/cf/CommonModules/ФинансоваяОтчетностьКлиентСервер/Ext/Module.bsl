﻿

#Область ПрограммныйИнтерфейс


// Возвращает родителя переданной строки в зависимости от типа.
//
//	Параметры:
//		СтрокаДерева - ДанныеФормыЭлементДерева, СтрокаДереваЗначений - строка дерева элементов отчета.
//
//	Возвращаемое значение:
//		РодительСтроки - ДанныеФормыЭлементДерева, СтрокаДереваЗначений.
//
Функция РодительСтроки(СтрокаДерева) Экспорт
	
	Если ТипЗнч(СтрокаДерева) = Тип("ДанныеФормыЭлементДерева")
		ИЛИ ТипЗнч(СтрокаДерева) = Тип("ДанныеФормыДерево") Тогда
		РодительСтроки = СтрокаДерева.ПолучитьРодителя();
	Иначе
		РодительСтроки = СтрокаДерева.Родитель;
	КонецЕсли;
	
	Возврат РодительСтроки;
	
КонецФункции

#КонецОбласти

