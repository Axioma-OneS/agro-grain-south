﻿

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)

	Результат = ПартнерыИКонтрагентыВызовСервера.РолиПартнеровВСделкахИПроектахДанныеВыбора(Параметры);
	
	Если Результат <> Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = Результат;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
