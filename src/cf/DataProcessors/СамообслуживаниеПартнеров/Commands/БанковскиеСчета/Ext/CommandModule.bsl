﻿

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОткрытьФорму("Обработка.СамообслуживаниеПартнеров.Форма.МоиБанковскиеСчета",
				,
				ПараметрыВыполненияКоманды.Источник,
				ПараметрыВыполненияКоманды.Уникальность,
				ПараметрыВыполненияКоманды.Окно);

КонецПроцедуры

#КонецОбласти
