﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьВыгрузкуНоменклатуры() Экспорт 
	
	Оповещения = РаботаСНоменклатуройСлужебныйВызовСервера.ФоновыеЗаданияВыгрузки();
	Если ТипЗнч(Оповещения) = Тип("Массив") Тогда
		Для каждого Организация Из Оповещения Цикл
			Обработчик = Новый ОписаниеОповещения("ОткрытьПомощникВыгрузки", РаботаСНоменклатуройКлиент, Организация);
			Пояснение = СтрШаблон(НСтр("ru = 'Завершена выгрузка по организации: %1'"), Организация);
			ПоказатьОповещениеПользователя(НСтр("ru = 'Выгрузка номенклатуры'"), Обработчик, Пояснение, 
			БиблиотекаКартинок.Информация32,
			СтатусОповещенияПользователя.Важное);
		КонецЦикла;
	Иначе
		ОтключитьОбработчикОжидания("ПроверитьВыгрузкуНоменклатуры");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти