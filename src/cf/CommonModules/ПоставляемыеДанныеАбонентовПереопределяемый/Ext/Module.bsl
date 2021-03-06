#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции для подсистемы ПоставляемыеДанныеАбонентов
// общий модуль ПоставляемыеДанныеАбонентовПереопределяемый.
//

// Обработчик полученных данных области.
//
// Параметры:
//  ПотокДанных - ФайловыйПоток - поток данных для обработки.
//  Обработчик  - Строка - идентификатор обработчика полученных данных.
//  ДанныеОбработаны - Булево - признак обработки данных. Устанавливается = Истина, если данные обработаны.
//                     Нельзя устанавливать значение = Ложь, т.к. признак = Истина может быть установлен ранее.
//  КодВозврата - Число - код возврата обработчика из значений РегистрыСведений.СвойстваЗаданий.КодыСостояний()
//  ОписаниеОшибки - Строка - описание ошибки обработки данных, если данные не обработаны.
//
//@skip-warning Пустой метод
Процедура ОбработатьПолученныеДанныеОбласти(ПотокДанных, Обработчик, ДанныеОбработаны, КодВозврата, ОписаниеОшибки) Экспорт
    
КонецПроцедуры

#КонецОбласти
