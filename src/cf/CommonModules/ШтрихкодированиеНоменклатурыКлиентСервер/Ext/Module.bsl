﻿
#Область ПрограммныйИнтерфейс

// Функция - Параметры заполнения флагов работы с меткой
// 
// Возвращаемое значение:
//  Структура - содержит свойства
//		*GTIN								 - ОпределяемыйТип.GTIN - GTIN
//		*ТекущаяМетка						 - Структура - данные текущей метки RFID
//		*НастройкиИспользованияСерий		 - Структура - реквизит формы подбора серий с настройками серий
//		*ЭтоМаркировкаТоваровГИСМ
//		*ЭтоМаркировкаПерсонифицированнымиКиЗ - Булево - признак маркировки персонифицированными метками КиЗ.
//
Функция ПараметрыЗаполненияФлаговРаботыСМеткой() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("GTIN");
	Результат.Вставить("ТекущаяМетка");
	Результат.Вставить("НастройкиИспользованияСерий");
	Результат.Вставить("ЭтоМаркировкаОстатковГИСМ");
	Результат.Вставить("ЭтоМаркировкаПерсонифицированнымиКиЗ");
	
	Возврат Результат;
	
КонецФункции

// Заполняет флаги работы с меткой RFID.
//
// Параметры:
//	ОбрабатываемаяСтрока - ДанныеФормыЭлементКоллекции  - строка для обработки
//	ПараметрыЗаполненияФлаговРаботыСМеткой - Структура - см. функцию ПараметрыЗаполненияФлаговРаботыСМеткой().
//
Процедура ЗаполнитьФлагиРаботыСМеткой(ОбрабатываемаяСтрока, ПараметрыЗаполненияФлаговРаботыСМеткой) Экспорт
	
	GTIN = ПараметрыЗаполненияФлаговРаботыСМеткой.GTIN;
	ТекущаяМетка = ПараметрыЗаполненияФлаговРаботыСМеткой.ТекущаяМетка;
	НастройкиИспользованияСерий = ПараметрыЗаполненияФлаговРаботыСМеткой.НастройкиИспользованияСерий;
	ЭтоМаркировкаОстатковГИСМ = ПараметрыЗаполненияФлаговРаботыСМеткой.ЭтоМаркировкаОстатковГИСМ;
	ЭтоМаркировкаПерсонифицированнымиКиЗ = ПараметрыЗаполненияФлаговРаботыСМеткой.ЭтоМаркировкаПерсонифицированнымиКиЗ;
	
	Если ОбрабатываемаяСтрока = Неопределено
		Или Не НастройкиИспользованияСерий.ИспользоватьRFIDМеткиСерии Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущаяМетка <> Неопределено Тогда
		
		ОбрабатываемаяСтрока.RFIDEPC = ТекущаяМетка.EPC;
		
	КонецЕсли;
	
	ОбрабатываемаяСтрока.ЗаполненRFIDTID = ЗначениеЗаполнено(ОбрабатываемаяСтрока.RFIDTID);
	
	Если НастройкиИспользованияСерий.ИспользоватьНомерСерии Тогда
		
		Если ЭтоМаркировкаПерсонифицированнымиКиЗ Тогда
			
			Если ОбрабатываемаяСтрока.EPCGTIN <> GTIN
				И ОбрабатываемаяСтрока.ЗаполненRFIDTID Тогда
			
				ТекстСообщения = НСтр("ru = 'GTIN, считанный из RFID метки не соответствует GTIN из КиЗ. Маркировка осуществляется персонифицированными КиЗ, поэтому необходимо считать подходящую метку RFID-считывателем.'");
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
				
			КонецЕсли;
			
		ИначеЕсли ЗначениеЗаполнено(GTIN) Тогда
			
			ОбрабатываемаяСтрока.EPCGTIN = GTIN;
				
			Если НастройкиИспользованияСерий.ИспользоватьНомерКИЗГИСМСерии
				И ОбрабатываемаяСтрока.ЗаполненRFIDTID Тогда
				
				РезультатРасчетаНомера = МенеджерОборудованияКлиентСервер.ПолучитьСерийныйНомерПоTID(ОбрабатываемаяСтрока.RFIDTID, ОбрабатываемаяСтрока.RFIDEPC);	
				
				Если РезультатРасчетаНомера.Результат Тогда
					ОбрабатываемаяСтрока.Номер = Формат(РезультатРасчетаНомера.СерийныйНомер, "ЧГ=0");
				Иначе
					ОбрабатываемаяСтрока.Номер = "";
					
					ТекстСообщения = НСтр("ru = 'При маркировке неперсонифицированными КиЗ номер серии должен быть сгенерирован по TID RFID-метки. При генерации произошла ошибка: %ТекстОшибки%. Обратитесь к администратору.'");
					ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ТекстОшибки%", РезультатРасчетаНомера.ОписаниеОшибки); 
					
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
				КонецЕсли;	
			КонецЕсли;
			
			Если СтроковыеФункцииКлиентСервер.СтрокаВЧисло(ОбрабатываемаяСтрока.Номер) <> Неопределено Тогда
				
				ДанныеEPC = МенеджерОборудованияКлиентСервер.СформироватьДанныеSGTIN96(ОбрабатываемаяСтрока.EPCGTIN, ОбрабатываемаяСтрока.Номер, 1);
				
				Если Не ЭтоМаркировкаОстатковГИСМ
					И (Не МенеджерОборудованияКлиентСервер.ПустойEPC(ДанныеEPC)
					Или Не МенеджерОборудованияКлиентСервер.ПустойEPC(ОбрабатываемаяСтрока.RFIDEPC)) Тогда
					ОбрабатываемаяСтрока.НужноЗаписатьМетку = ДанныеEPC <> ОбрабатываемаяСтрока.RFIDEPC;
				Иначе
					ОбрабатываемаяСтрока.НужноЗаписатьМетку = Ложь;
				КонецЕсли;
			Иначе
				ОбрабатываемаяСтрока.НужноЗаписатьМетку = Ложь;
			КонецЕсли;
			
		КонецЕсли;
	Иначе
		ОбрабатываемаяСтрока.НужноЗаписатьМетку = Ложь;
	КонецЕсли;
	
	
	Если Не ОбрабатываемаяСтрока.ЗаполненRFIDTID Тогда
		ОбрабатываемаяСтрока.СтатусРаботыRFID = 0;
	ИначеЕсли ОбрабатываемаяСтрока.НужноЗаписатьМетку Тогда
		ОбрабатываемаяСтрока.СтатусРаботыRFID = 1;
	Иначе
		ОбрабатываемаяСтрока.СтатусРаботыRFID = 2;
	КонецЕсли;
	
КонецПроцедуры

//Возвращает структуру параметров обработки штрихкодов.
//
// Возвращаемое значение:
//  Структура - Параметры обработки штрихкодов.
//
Функция ПараметрыОбработкиШтрихкодов() Экспорт
	
	ПараметрыОбработки = Новый Структура;
	ПараметрыОбработки.Вставить("Штрихкоды",                                      Неопределено);
	ПараметрыОбработки.Вставить("СтруктураДействийСДобавленнымиСтроками",         Неопределено);
	ПараметрыОбработки.Вставить("СтруктураДействийСИзмененнымиСтроками",          Неопределено);
	ПараметрыОбработки.Вставить("СтруктураДействийСоСтрокамиИзУпаковочныхЛистов", Неопределено);
	ПараметрыОбработки.Вставить("ПараметрыУказанияСерий",                 Неопределено);
	ПараметрыОбработки.Вставить("ДействияСНеизвестнымиШтрихкодами",       "ЗарегистрироватьПеренестиВДокумент");
	ПараметрыОбработки.Вставить("ИмяКолонкиКоличество",                   "КоличествоУпаковок");
	ПараметрыОбработки.Вставить("ИмяКолонкиУпаковка",                     "Упаковка");
	ПараметрыОбработки.Вставить("НеИспользоватьУпаковки",                 Ложь);
	ПараметрыОбработки.Вставить("ИмяТЧ",                                  "Товары");
	ПараметрыОбработки.Вставить("ИзменятьКоличество",                     Истина);
	ПараметрыОбработки.Вставить("БлокироватьДанныеФормы",                 Истина);
	ПараметрыОбработки.Вставить("ТолькоТовары",                           Ложь);
	ПараметрыОбработки.Вставить("ТолькоТоварыИРабота",                    Ложь);
	ПараметрыОбработки.Вставить("ТолькоУслуги",                           Ложь);
	ПараметрыОбработки.Вставить("ТолькоТара",                             Ложь);
	ПараметрыОбработки.Вставить("ТолькоНеПодакцизныйТовар",               Ложь);
	ПараметрыОбработки.Вставить("НеизвестныеШтрихкоды",                   Новый Массив);
	ПараметрыОбработки.Вставить("ОтложенныеТовары",                       Новый Массив);
	ПараметрыОбработки.Вставить("ПараметрыПроверкиАссортимента",          Неопределено);
	ПараметрыОбработки.Вставить("РассчитыватьНаборы",                     Ложь);
	ПараметрыОбработки.Вставить("УчитыватьУпаковочныеЛисты",              Ложь);
	ПараметрыОбработки.Вставить("ОтработатьИзменениеУпаковочныхЛистов",   Ложь);
	ПараметрыОбработки.Вставить("ШтрихкодыВТЧ",                           Ложь);
	ПараметрыОбработки.Вставить("МаркируемаяПродукцияВТЧ",                Ложь);
	ПараметрыОбработки.Вставить("УвеличиватьКоличествоВСтрокахССериями",  Истина);
	ПараметрыОбработки.Вставить("ТекущийУпаковочныйЛист",                 Неопределено);
	ПараметрыОбработки.Вставить("ЗаполнятьНазначения",                    Ложь);
	ПараметрыОбработки.Вставить("ЗагрузкаИзТСД",                          Ложь);
	
	//Возвращаемые параметры
	ПараметрыОбработки.Вставить("МассивСтрокССериями",          Новый Массив);
	ПараметрыОбработки.Вставить("МассивСтрокСАкцизнымиМарками", Новый Массив);
	ПараметрыОбработки.Вставить("ТекущаяСтрока",       Неопределено);
	
	Возврат ПараметрыОбработки;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


#КонецОбласти
