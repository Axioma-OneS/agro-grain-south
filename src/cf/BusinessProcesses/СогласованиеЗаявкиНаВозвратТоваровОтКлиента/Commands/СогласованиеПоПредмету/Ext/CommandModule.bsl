﻿

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОткрытьФорму("БизнесПроцесс.СогласованиеЗаявкиНаВозвратТоваровОтКлиента.ФормаСписка",
	             Новый Структура("Предмет", ПараметрКоманды),
	             ПараметрыВыполненияКоманды.Источник,
	             ПараметрыВыполненияКоманды.Уникальность,
	             ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры

#КонецОбласти
