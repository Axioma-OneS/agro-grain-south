﻿
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	// Вставить содержимое обработчика.
	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("Справочник.БанковскиеСчетаОрганизаций.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры

#КонецОбласти
