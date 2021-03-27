﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Возвращает описание команды по имени элемента формы.
Функция ОписаниеКоманды(ИмяКомандыВФорме, АдресНастроек) Экспорт
	Возврат ПодключаемыеКоманды.ОписаниеКоманды(ИмяКомандыВФорме, АдресНастроек);
КонецФункции

// Проводит анализ массива документов на предмет проведенности и наличия прав на их проведение.
Функция ИнформацияОДокументах(МассивСсылок) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Непроведенные", ОбщегоНазначения.ПроверитьПроведенностьДокументов(МассивСсылок));
	Результат.Вставить("ДоступноПравоПроведения", СтандартныеПодсистемыСервер.ДоступноПравоПроведения(Результат.Непроведенные));
	Возврат Результат;
КонецФункции

#КонецОбласти
