﻿#Область СлужебныйПрограммныйИнтерфейс

Процедура УправлениеЭлементами_ПанельСправочниковСклад(Элементы, ЕстьДанныеДляОтображения) Экспорт

	//++ Локализация

	ПравоДоступаКатегорииЭксплуатации = ПравоДоступа("Просмотр", Метаданные.Справочники.КатегорииЭксплуатации);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ОткрытьКатегорииЭксплуатации",
		"Видимость",
		ПравоДоступаКатегорииЭксплуатации);
		
	ЕстьДанныеДляОтображения = ЕстьДанныеДляОтображения ИЛИ ПравоДоступаКатегорииЭксплуатации;
	
	//-- Локализация
		
КонецПроцедуры

#КонецОбласти
