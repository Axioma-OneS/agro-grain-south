﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область Серии

//Имена реквизитов, от значений которых зависят параметры указания серий
//
//	Возвращаемое значение:
//		Строка - имена реквизитов, перечисленные через запятую
//
Функция ИменаРеквизитовДляЗаполненияПараметровУказанияСерий() Экспорт
	
	Возврат ИнтеграцияИС.ИменаРеквизитовДляЗаполненияПараметровУказанияСерий(Метаданные.РегистрыСведений.СоответствиеНоменклатурыВЕТИС);
	
КонецФункции

// Возвращает параметры указания серий для товаров, указанных в документе.
//
// Параметры:
//  Объект	 - Структура - структура значений реквизитов объекта, необходимых для заполнения параметров указания серий.
// 
// Возвращаемое значение:
//  (см. ИнтеграцияИСПереопределяемый.ЗаполнитьПараметрыУказанияСерий) - параметры указания серий
//
Функция ПараметрыУказанияСерий(Объект) Экспорт
	
	Возврат ИнтеграцияИС.ПараметрыУказанияСерий(Метаданные.РегистрыСведений.СоответствиеНоменклатурыВЕТИС, Объект);
	
КонецФункции

// Возвращает текст запроса для расчета статусов указания серий
// Параметры:
//   ПараметрыУказанияСерий - (см. ИнтеграцияИСПереопределяемый.ЗаполнитьПараметрыУказанияСерий) - параметры указания серий
// Возвращаемое значение:
//   Строка - текст запроса
//
Функция ТекстЗапросаЗаполненияСтатусовУказанияСерий(ПараметрыУказанияСерий) Экспорт
	
	Возврат ИнтеграцияИС.ТекстЗапросаЗаполненияСтатусовУказанияСерий(Метаданные.РегистрыСведений.СоответствиеНоменклатурыВЕТИС, ПараметрыУказанияСерий);

КонецФункции

#КонецОбласти

#КонецЕсли
