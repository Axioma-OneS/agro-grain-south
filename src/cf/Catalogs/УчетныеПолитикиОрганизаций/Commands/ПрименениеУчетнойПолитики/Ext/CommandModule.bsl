﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Отбор = Новый Структура("УчетнаяПолитика", ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Отбор", Отбор);

	ОткрытьФорму("РегистрСведений.УчетнаяПолитикаОрганизаций.ФормаСписка",
					ПараметрыФормы,
					ПараметрыВыполненияКоманды.Источник,
					ПараметрыВыполненияКоманды.Уникальность,
					ПараметрыВыполненияКоманды.Окно,
					ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры

#КонецОбласти