﻿
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗакрытиеМесяцаСервер.УстановитьОтборыВФормеСпискаРегистра(ЭтотОбъект, Список);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбраннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
		Значение = ВыбраннаяСтрока.Ключ;
	Иначе
		Значение = Элемент.ТекущиеДанные[Поле.Имя];
	КонецЕсли;
	
	ПоказатьЗначение(Неопределено, Значение);
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	
	Если ЗакрытиеМесяцаСервер.ЭтаФормаОткрытаИзФормыЗакрытияМесяца(ЭтотОбъект) Тогда
		ОтборКомпоновки = Настройки.Элементы.Найти(Список.КомпоновщикНастроек.Настройки.Отбор.ИдентификаторПользовательскойНастройки);
		ОтборКомпоновки.Элементы.Очистить();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
