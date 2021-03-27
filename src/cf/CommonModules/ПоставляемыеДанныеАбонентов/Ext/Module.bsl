﻿
#Область ПрограммныйИнтерфейс

// МЕТОД НЕ ПОДДЕРЖИВАЕТСЯ.
// Возвращает описание данных логического хранилища.
//
// Параметры:
//  ИдентификаторХранилища - Строка - идентификатор логического хранилища.
//  ИдентификаторДанных    - Строка - идентификатор данных хранилища.
// 
// Возвращаемое значение:
//  Неопределено - Вызывается исключение.
//
Функция Описание(ИдентификаторХранилища, ИдентификаторДанных) Экспорт
	
	ВызватьИсключение ПоставляемыеДанныеАбонентовСловарь.МетодНеПоддерживается();
	//@skip-warning Возможно, недостижимое выражение
	Возврат Неопределено;
    
КонецФункции

// МЕТОД НЕ ПОДДЕРЖИВАЕТСЯ.
// Возвращает данные логического хранилища.
//
// Параметры:
//  ОписаниеДанных - Структура - описание данных хранилища.
// 
// Возвращаемое значение:
//  Неопределено - Вызывается исключение.
//
Функция Данные(ОписаниеДанных) Экспорт
    
	ВызватьИсключение ПоставляемыеДанныеАбонентовСловарь.МетодНеПоддерживается();
	//@skip-warning Возможно, недостижимое выражение
	Возврат Неопределено;
	
КонецФункции

// Записывает данные в логическое хранилище.
// Выполняет действия:
// - сохраняет файл данных в файловом хранилище
// - планирует задание очереди заданий на обработки файла
// - возвращается идентификатор задания в ответ
//
// Параметры:
//  ОписаниеДанных - Структура - описание данных хранилища:
//    * ИмяФайла - Строка - имя файла.
//    * Размер - Число - размер файла в байтах.
//    * Данные - ДвоичныеДанные, Строка - двоичные данные файла или расположение файла на диске.
//
// Возвращаемое значение:
//   Структура - идентификатор задания очереди заданий (см. функцию ОтветПоУмолчанию).
//
Функция Загрузить(ОписаниеДанных) Экспорт
    
    Словарь = ПоставляемыеДанныеАбонентовСловарь;
    Ответ = ОтветПоУмолчанию();
	
    УстановитьПривилегированныйРежим(Истина);
    ИдентификаторФайла = ФайлыОбластейДанных.Загрузить(ОписаниеДанных);
    
	ПараметрыЗапуска = Новый Массив();
	ПараметрыЗапуска.Добавить(Строка(ИдентификаторФайла));
    
    ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("ОбластьДанных", РаботаВМоделиСервиса.ЗначениеРазделителяСеанса());
	ПараметрыЗадания.Вставить("Использование", Истина);
	ПараметрыЗадания.Вставить("ЭксклюзивноеВыполнение", Истина);
	ПараметрыЗадания.Вставить("ИмяМетода", "ПоставляемыеДанныеАбонентов.ОбработатьДанные");
	ПараметрыЗадания.Вставить("Параметры", ПараметрыЗапуска);
	ПараметрыЗадания.Вставить("Ключ", Строка(ИдентификаторФайла));
	ПараметрыЗадания.Вставить("ИнтервалПовтораПриАварийномЗавершении", 0);
	ПараметрыЗадания.Вставить("КоличествоПовторовПриАварийномЗавершении", 0);
	Задание = ОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);
    РегистрыСведений.СвойстваЗаданий.Установить(Задание);
    
    Ответ.Вставить(Словарь.ПолеХранилище(), ОчередьЗаданийВнешнийИнтерфейс.ИдентификаторХранилища());
    Ответ.Вставить(Словарь.ПолеИдентификатор(), Строка(Задание.УникальныйИдентификатор()));
    
    Возврат Ответ;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков.
//
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	СоответствиеИменПсевдонимам.Вставить("ПоставляемыеДанныеАбонентов.ОбработатьДанные");
	
КонецПроцедуры                                                       

// Обработчик задания очереди заданий.
//
// Параметры:
//  ИдентификаторФайла - Строка - идентификатор файла для обработки (длина 36).
//
Процедура ОбработатьДанные(ИдентификаторФайла) Экспорт
    
    Словарь = ПоставляемыеДанныеАбонентовСловарь;
    ИдентификаторЗадания = ОчередьЗаданийВнешнийИнтерфейс.ИдентификаторЗадания(ИдентификаторФайла);
    ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
    КодыСостояний = РегистрыСведений.СвойстваЗаданий.КодыСостояний();
    
    Попытка
        ОписаниеФайла = ФайлыОбластейДанных.ОписаниеФайла(ИдентификаторФайла);
        Если ЗначениеЗаполнено(ОписаниеФайла.ПолноеИмя) Тогда
            ПотокДанных = ФайловыеПотоки.ОткрытьДляЧтения(ОписаниеФайла.ПолноеИмя);
        Иначе
            ПотокДанных = ОписаниеФайла.Данные.ОткрытьПотокДляЧтения();
        КонецЕсли; 
        Архиватор = Новый ЧтениеZipФайла(ПотокДанных);
        Попытка
            Архиватор.ИзвлечьВсе(ИмяВременногоФайла);
        Исключение
            ОчередьЗаданийВнешнийИнтерфейс.УстановитьОшибкуДанных(ИдентификаторЗадания, Словарь.ФайлПоврежден());
            Возврат;
        КонецПопытки;
        ПоискМанифеста = НайтиФайлы(ИмяВременногоФайла, ПоставляемыеДанныеАбонентовСловарь.ИмяФайлаМанифеста(), Истина);
        Если ПоискМанифеста.Количество() = 0 Тогда
            ОчередьЗаданийВнешнийИнтерфейс.УстановитьОшибкуДанных(ИдентификаторЗадания, Словарь.МанифестНеЗадан());
            Возврат;
        КонецЕсли;
        Попытка
            ЧтениеJSON = Новый ЧтениеJSON;
            ЧтениеJSON.ОткрытьФайл(ПоискМанифеста[0].ПолноеИмя);
            Манифест = ПрочитатьJSON(ЧтениеJSON);
            ЧтениеJSON.Закрыть();
        Исключение
            ОчередьЗаданийВнешнийИнтерфейс.УстановитьОшибкуДанных(ИдентификаторЗадания, Словарь.МанифестНеВерногоФормата());
            Возврат;
        КонецПопытки;
        Порядок = ПоставляемыеДанныеАбонентовСловарь.ИмяПоляСоставаДанных();
        Если Не Манифест.Свойство(Порядок) Тогда
            ОчередьЗаданийВнешнийИнтерфейс.УстановитьОшибкуДанных(ИдентификаторЗадания, 
                СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Словарь.ОтсутствуетСвойствоМанифеста(), Порядок));
            Возврат;
        КонецЕсли;
        Результаты = Новый Массив;
        Для Каждого Элемент Из Манифест[Порядок] Цикл
            ПоискФайла = НайтиФайлы(ИмяВременногоФайла, Элемент[Словарь.ПолеФайл()]);
            Если Элемент.Свойство(Словарь.ПолеВерсия()) Тогда
                Версия = Элемент[Словарь.ПолеВерсия()];
            Иначе 
                Версия = "";
            КонецЕсли; 
            Если ПоискФайла.Количество() = 0 Тогда
                ОчередьЗаданийВнешнийИнтерфейс.УстановитьОшибкуДанных(ИдентификаторЗадания, 
                    СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Словарь.ФайлНеНайден(), Элемент[Словарь.ПолеФайл()]));
                Возврат;
            КонецЕсли; 
            ПотокДанных = ФайловыеПотоки.ОткрытьДляЧтения(ПоискФайла[0].ПолноеИмя);
            Обработчик = Элемент[Словарь.ПолеОбработчик()];
            ДанныеОбработаны = Ложь;
            КодВозвратаОбработчика = КодыСостояний.Выполнено;
            ОписаниеОшибкиОбработчика = "";
            ПоставляемыеДанныеАбонентовПереопределяемый.ОбработатьПолученныеДанныеОбласти(
                ПотокДанных, Обработчик, ДанныеОбработаны, КодВозвратаОбработчика, ОписаниеОшибкиОбработчика);
                
            РезультатОбработчика = Новый Структура;
            РезультатОбработчика.Вставить(Словарь.ПолеФайл(), Элемент[Словарь.ПолеФайл()]);
            РезультатОбработчика.Вставить(Словарь.ПолеВерсия(), Версия);
            РезультатОбработчика.Вставить(Словарь.ПолеОбработчик(), Обработчик);
            РезультатОбработчика.Вставить(Словарь.ПолеКодВозврата(), КодВозвратаОбработчика);
            РезультатОбработчика.Вставить(Словарь.ПолеОшибка(), Не ДанныеОбработаны);
            РезультатОбработчика.Вставить(Словарь.ПолеСообщениеОбОшибке(), ОписаниеОшибкиОбработчика);
            Результаты.Добавить(РезультатОбработчика);
            
            Если Не ДанныеОбработаны Тогда
                ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
                    Словарь.ОбработчикНеНайден(), Обработчик); 
            КонецЕсли; 
        КонецЦикла;
	Исключение
		
		Файл = Новый Файл(ИмяВременногоФайла);
		Если Файл.Существует() Тогда
			Попытка
				УдалитьФайлы(ИмяВременногоФайла)
			Исключение
				Комментарий = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				ЗаписьЖурналаРегистрации(Словарь.УдалениеФайла(), УровеньЖурналаРегистрации.Ошибка, , , Комментарий);
			КонецПопытки;
		КонецЕсли;
	
        ОчередьЗаданийВнешнийИнтерфейс.УстановитьВнутреннююОшибку(
            ИдентификаторЗадания, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
        ВызватьИсключение ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецПопытки;
	
	Попытка
		УдалитьФайлы(ИмяВременногоФайла)
	Исключение
		Комментарий = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(Словарь.УдалениеФайла(), УровеньЖурналаРегистрации.Ошибка, , , Комментарий);
	КонецПопытки;

    Свойства = РегистрыСведений.СвойстваЗаданий.НовыйСвойстваЗадания();
    Свойства.КодСостояния = КодыСостояний.Выполнено;
    Свойства.Результат = РаботаВМоделиСервисаБТС.СтрокаИзСтруктурыJSON(Результаты);
    
    РегистрыСведений.СвойстваЗаданий.Установить(ИдентификаторЗадания, Свойства);
    
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки.
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	Типы.Добавить(Метаданные.РегистрыСведений.ФайлыОбластейДанных);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОтветПоУмолчанию()
    
    Словарь = ПоставляемыеДанныеАбонентовСловарь;
    КодыСостояний = Словарь.КодыВозврата();
    ОсновнойРаздел = Новый Структура;
    ОсновнойРаздел.Вставить(Словарь.ПолеКодВозврата(), КодыСостояний.Выполнено);
    ОсновнойРаздел.Вставить(Словарь.ПолеОшибка(), Ложь);
    ОсновнойРаздел.Вставить(Словарь.ПолеСообщениеОбОшибке(), "");
    ОтветПоУмолчанию = Новый Структура;
    ОтветПоУмолчанию.Вставить(Словарь.ПолеОсновнойРаздел(), ОсновнойРаздел);
    
    Возврат ОтветПоУмолчанию;
    
КонецФункции

#КонецОбласти 

