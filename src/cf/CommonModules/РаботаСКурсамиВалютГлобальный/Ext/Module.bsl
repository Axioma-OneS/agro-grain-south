﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Выводит оповещение о необходимости обновления курсов валют.
//
Процедура РаботаСКурсамиВалютВывестиОповещениеОНеактуальности() Экспорт
	Если НЕ РаботаСКурсамиВалютВызовСервера.КурсыАктуальны() Тогда
		РаботаСКурсамиВалютКлиент.ОповеститьКурсыУстарели();
	КонецЕсли;
	
	ТекущаяДата = ОбщегоНазначенияКлиент.ДатаСеанса();
	ПериодОбработчикаСледующегоДня = КонецДня(ТекущаяДата) - ТекущаяДата + 59;
	ПодключитьОбработчикОжидания("РаботаСКурсамиВалютВывестиОповещениеОНеактуальности", ПериодОбработчикаСледующегоДня, Истина);
КонецПроцедуры

#КонецОбласти
