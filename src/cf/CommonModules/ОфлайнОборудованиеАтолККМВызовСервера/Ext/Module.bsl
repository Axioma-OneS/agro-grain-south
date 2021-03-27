﻿
#Область ПрограммныйИнтерфейс
// Обрабатывает загружаемые данные из ККМ.
// 
// Параметры:
// 	ТекстовыйДокумент - Строка - текстовый документ.
// 	ФорматОбмена - Число - формат обмена.
// 	ВыходныеПараметры - Массив - структура выходных параметров.
// Возвращаемое значение:
// 	Булево - Описание
Функция ОбработатьЗагружаемыеДанныеИзККМ(ТекстовыйДокумент, ФорматОбмена, ВыходныеПараметры) Экспорт
	
	Результат = Истина;
	
	ВсегоСтрок = ТекстовыйДокумент.КоличествоСтрок();
	
	ЗагружаемыеДанныеИзККМ = МенеджерОфлайнОборудования.ПолучитьЗагружаемыеДанныеИзККМ();
	
	ПродолжатьЧтениеФайла = Ложь;
	ТекстОшибки = "";
	Строка = ТекстовыйДокумент.ПолучитьСтроку(1);
	
	// Проверяем обработанность файла.
	Если Строка = "#" Тогда
		Индекс = 4;
		ПродолжатьЧтениеФайла = Истина;
	ИначеЕсли Строка = "@" Тогда
		ТекстОшибки = НСтр("ru='Файл загрузки был обработан ранее.'");
		Результат = Ложь;
	Иначе
		ТекстОшибки = НСтр("ru='Загрузка невозможна. Неизвестный формат отчета.'");
		Результат = Ложь;
	КонецЕсли;
	
	Смены = Новый Массив;
	ТекущаяСмена = Неопределено;
	
	// В цикле читаем транзакции.
	Пока ПродолжатьЧтениеФайла Цикл
		
		// Получаем строку с очередной транзакцией.
		Строка = ТекстовыйДокумент.ПолучитьСтроку(Индекс);
		
		// Если транзакция существует.
		Если ПустаяСтрока(Строка) Тогда
			
			Если Индекс <= ВсегоСтрок Тогда
				Индекс = Индекс + 1;
				Продолжить;
			КонецЕсли;
			
			ПродолжатьЧтениеФайла = Ложь;
			
		Иначе
			
			Транзакция = ПолучитьПустуюТранзакцию();
			
			// Раскладываем транзакцию на поля.
			Если ЗаполнитьТранзакцию(СтрЗаменить(Строка, ";", Символы.ПС), Транзакция, ФорматОбмена, ТекстОшибки) Тогда
				
				Если Транзакция.Тип = 2 ИЛИ Транзакция.Тип = 12 Тогда
					
					// Сторно продажи/возврата товара.
					Если НЕ УдалитьТранзакциюИзЧека(ТекущаяСмена, Транзакция, ТекстОшибки) Тогда
						ПродолжатьЧтениеФайла = Ложь;
						Результат = Ложь;
					КонецЕсли;
					
				ИначеЕсли Транзакция.Тип = 1 ИЛИ Транзакция.Тип = 11 Тогда
					
					// Продажа/возврат товара.
					ДобавитьТранзакциюВЧек(ТекущаяСмена, Смены, Транзакция, ФорматОбмена);
					
				ИначеЕсли Транзакция.Тип = 40 ИЛИ Транзакция.Тип = 41 Тогда
					
					// Оплата.
					ДобавитьТранзакциюВЧек(ТекущаяСмена, Смены, Транзакция, ФорматОбмена, Истина);
					
				ИначеЕсли Транзакция.Тип = 42 Тогда
					
					// Открытие чека.
					ОткрытьЧек(ТекущаяСмена, Смены, Транзакция);
					
				ИначеЕсли Транзакция.Тип = 55 Тогда
					
					// Закрытие чека.
					Если НЕ ЗакрытьЧек(ТекущаяСмена, Транзакция, ТекстОшибки) Тогда
						ПродолжатьЧтениеФайла = Ложь;
						Результат = Ложь;
					КонецЕсли;
					
				ИначеЕсли Транзакция.Тип = 56 Тогда
					
					// Отмена чека.
					УдалитьЧек(ТекущаяСмена, Транзакция, ТекстОшибки);
					
				ИначеЕсли Транзакция.Тип = 61 ИЛИ Транзакция.Тип = 63 Тогда
					
					// Закрытие смены.
					ЗакрытьСмену(ТекущаяСмена, Смены, Транзакция);
					
				ИначеЕсли Транзакция.Тип = 62 ИЛИ Транзакция.Тип = 64 Тогда
					
					// Открытие смены.
					ОткрытьСмену(ТекущаяСмена, Смены, Транзакция);
					
				КонецЕсли;
				
			Иначе
				Результат = Ложь;
				ПродолжатьЧтениеФайла = Ложь;
			КонецЕсли;
			
		КонецЕсли;
		
		Индекс = Индекс + 1;
		
	КонецЦикла;
	
	Если Результат Тогда
		
		// Если текущая смена не закрыта, закрываем ее.
		Если НЕ ТекущаяСмена = Неопределено И НЕ ЗначениеЗаполнено(ТекущаяСмена.ДатаЗакрытия) Тогда
			ЗакрытьСмену(ТекущаяСмена, Смены, Транзакция);
		КонецЕсли;
		
		// Перебираем смены.
		Для Каждого Смена Из Смены Цикл
			
			// Формируем описание смены.
			
			ОтчетОПродажахККМ = МенеджерОфлайнОборудования.ПолучитьОтчетОПродажахККМ();
			
			ОтчетОПродажахККМ.НомерСмены = Смена.Номер;
			ОтчетОПродажахККМ.ДатаОткрытияСмены = Смена.ДатаОткрытия;
			ОтчетОПродажахККМ.ДатаЗакрытияСмены = Смена.ДатаЗакрытия;
			
			УдалитьНеподдерживаемыеОперации(Смена.Чеки);
			
			// Перебираем все чеки смены.
			Для Каждого Чек Из Смена.Чеки Цикл
				
				// Если чек закрыт.
				Если Чек.Закрыт Тогда
					
					Если Чек.ТипОперацииККМ = "Продажа" ИЛИ Чек.ТипОперацииККМ = "Возврат" Тогда
						
						ЧекККМ = МенеджерОфлайнОборудования.ПолучитьЧекККМ();
						
						ЧекККМ.ДатаЧека = Чек.ДатаЧека;
						ЧекККМ.НомерЧека = Чек.НомерЧека;
						ЧекККМ.ТипРасчета = ?(Чек.ТипОперацииККМ = "Продажа",
							Перечисления.ТипыРасчетаДенежнымиСредствами.ПриходДенежныхСредств,
							Перечисления.ТипыРасчетаДенежнымиСредствами.ВозвратДенежныхСредств
						);
						
						
						Для Каждого Товар Из Чек.Товары Цикл
							
							ТоварЧекаККМ = МенеджерОфлайнОборудования.ПолучитьТоварЧекаККМ();
							
							ТоварЧекаККМ.Код 		= Товар.Код;
							ТоварЧекаККМ.Цена 		= ?(Товар.Цена > 0,  Товар.Цена,  -Товар.Цена);
							ТоварЧекаККМ.Сумма 		= ?(Товар.Сумма > 0, Товар.Сумма, -Товар.Сумма);
							ТоварЧекаККМ.Количество = ?(Товар.Количество > 0, Товар.Количество, -Товар.Количество);
							
							Если ЗначениеЗаполнено(Товар.ШтрихкодАлкогольнойПродукции) Тогда
								
								Разделитель = "¤";
								ШтрихкодыАлкогольнойПродукции = РазложитьСтрокуВМассивПодстрок(
									Товар.ШтрихкодАлкогольнойПродукции, Разделитель, Истина, Истина
								);
								
								Для Каждого Штрихкод Из ШтрихкодыАлкогольнойПродукции Цикл
									ТоварЧекаККМ.ШтрихкодыМаркированнойПродукции.Добавить(Штрихкод);
								КонецЦикла;
								
							КонецЕсли;
							
							ТоварЧекаККМ.ПризнакСпособаРасчета = Перечисления.ПризнакиСпособаРасчета.ПередачаСПолнойОплатой;
							
							ЧекККМ.Товары.Добавить(ТоварЧекаККМ);
							
						КонецЦикла;
						
						Для Каждого Оплата Из Чек.Оплаты Цикл
							
							ОплатаЧекаККМ = МенеджерОфлайнОборудования.ПолучитьОплатуЧекаККМ();
							
							Если Оплата.ТипОплаты = "0" Тогда
								ОплатаЧекаККМ.СуммаНаличнойОплаты = ?(Оплата.Сумма > 0, Оплата.Сумма, -Оплата.Сумма);
							Иначе
								ОплатаЧекаККМ.СуммаЭлектроннойОплаты   = ?(Оплата.Сумма > 0, Оплата.Сумма, -Оплата.Сумма);
								ОплатаЧекаККМ.КодВидаЭлектроннойОплаты = Оплата.КодВидаОплаты;
							КонецЕсли;
								
							ЧекККМ.Оплаты.Добавить(ОплатаЧекаККМ);
							
						КонецЦикла;
						
						ОтчетОПродажахККМ.Чеки.Добавить(ЧекККМ);
						
					ИначеЕсли Чек.ТипОперацииККМ = "ВскрытиеТары" Тогда
						
						ВскрытиеТарыККМ = МенеджерОфлайнОборудования.ПолучитьВскрытиеТарыККМ();
						
						ВскрытиеТарыККМ.Дата  = Чек.ДатаЧека;
						ВскрытиеТарыККМ.Номер = Чек.НомерЧека;
						
						Для Каждого Товар Из Чек.Товары Цикл
							
							ТоварВскрытияККМ = МенеджерОфлайнОборудования.ПолучитьТоварВскрытияТарыККМ();
							
							ТоварВскрытияККМ.Код 		= Товар.Код;
							ТоварВскрытияККМ.Количество = Товар.Количество;
							
							Если ЗначениеЗаполнено(Товар.ШтрихкодАлкогольнойПродукции) Тогда
								
								Разделитель = "¤";
								ШтрихкодыАлкогольнойПродукции = РазложитьСтрокуВМассивПодстрок(
									Товар.ШтрихкодАлкогольнойПродукции, Разделитель, Истина, Истина
								);
								
								Для Каждого Штрихкод Из ШтрихкодыАлкогольнойПродукции Цикл
									ТоварВскрытияККМ.ШтрихкодАлкогольнойПродукции.Добавить(Штрихкод);
								КонецЦикла;
								
							КонецЕсли;
							
							ВскрытиеТарыККМ.Товары.Добавить(ТоварЧекаККМ);
							
						КонецЦикла;
						
						ЗагружаемыеДанныеИзККМ.ВскрытияАлкогольнойТары.Добавить(ВскрытиеТарыККМ);
						
					ИначеЕсли Чек.ТипОперацииККМ = "Внесение" ИЛИ Чек.ТипОперацииККМ = "Выплата" Тогда
						
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЦикла;
			
			ЗагружаемыеДанныеИзККМ.ОтчетыОПродажах.Добавить(ОтчетОПродажахККМ);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если Результат Тогда
		ВыходныеПараметры.Добавить(ЗагружаемыеДанныеИзККМ);
	Иначе
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(ТекстОшибки);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция УдалитьЧек(Смена, Транзакция, ТекстОшибки)
	
	Результат = Истина;
	
	ТекущийЧек = ПолучитьЧек(Смена, Транзакция.НомерЧека);
	
	Если ТекущийЧек<>Неопределено Тогда
		Смена.Чеки.Удалить(Смена.Чеки.Найти(ТекущийЧек));
	Иначе
		ТекстОшибки = НСтр("ru='Операция прервана. Ошибка при загрузке транзакции №%1%.'");
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%1%", Транзакция.Номер);
		Результат = Ложь;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьЧек(Смена, НомерЧека)
	
	НайденныеЧеки = НайтиСтроки(Смена.Чеки, Новый Структура("НомерЧека", НомерЧека));
	
	Если НайденныеЧеки.Количество()>0 Тогда
		Возврат Смена.Чеки[НайденныеЧеки[0].ИндексВМассиве];
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Возвращает массив элементов, найденных в массиве структур по параметрам отбора.
// Параметры отбора являют собой структуру.
// Действует аналогично методу НайтиСтроки таблицы значений.
//
Функция НайтиСтроки(Знач МассивПоиска, ПараметрыОтбора)
	
	Результат = Новый Массив;
	Для ВремИндекс = 0 По МассивПоиска.Количество()-1 Цикл
		
		ЭлементМассива = МассивПоиска[ВремИндекс];
		ПолноеСовпадение = Истина;
		
		Для каждого ЭлементОтбора Из ПараметрыОтбора Цикл
			
			Если ЭлементМассива.Свойство(ЭлементОтбора.Ключ) 
				И НЕ ЭлементОтбора.Значение = ЭлементМассива[ЭлементОтбора.Ключ] Тогда
				ПолноеСовпадение = Ложь;
			КонецЕсли;
			
		КонецЦикла;
		
		Если ПолноеСовпадение Тогда
			ЭлементМассива.Вставить("ИндексВМассиве", ВремИндекс);
			Результат.Добавить(ЭлементМассива);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Процедура УдалитьНеподдерживаемыеОперации(Чеки)
	
	КодОперацииПриход = 14;
	ОперацияПриход = ТипОперацииККМ(КодОперацииПриход);
	
	Индекс = Чеки.Количество() - 1;
	
	Пока Индекс > 0 Цикл
		
		Чек = Чеки[Индекс];
		
		Если Чек.ТипОперацииККМ = ОперацияПриход Тогда
			Чеки.Удалить(Индекс);
		КонецЕсли;
		
		Индекс = Индекс - 1;
	КонецЦикла;
	
КонецПроцедуры

Функция ТипОперацииККМ(КодТипаОперации)
	
	Если КодТипаОперации = 0 Тогда
		Возврат "Продажа";
		
	ИначеЕсли КодТипаОперации = 1 Тогда
		Возврат "Возврат";
		
	ИначеЕсли КодТипаОперации = 2 Тогда
		Возврат "Аннулирование";
		
	ИначеЕсли КодТипаОперации = 3 Тогда
		Возврат "Обмен";
		
	ИначеЕсли КодТипаОперации = 4 Тогда
		Возврат "Внесение";
		
	ИначеЕсли КодТипаОперации = 5 Тогда
		Возврат "Выплата";
		
	ИначеЕсли КодТипаОперации = 6 Тогда
		Возврат "Пользовательская";
		
	ИначеЕсли КодТипаОперации = 8 Тогда
		Возврат "ОткрытиеСмены";
		
	ИначеЕсли КодТипаОперации = 9 Тогда
		Возврат "ОперацияВККМ";
		
	ИначеЕсли КодТипаОперации = 10 Тогда
		Возврат "ЗакрытиеСмены";
		
	ИначеЕсли КодТипаОперации = 11 Тогда
		Возврат "ЗакрСменыПлатСистем";
		
	ИначеЕсли КодТипаОперации = 12 Тогда
		Возврат "РедСпискаСотрудников";
		
	ИначеЕсли КодТипаОперации = 13 Тогда
		Возврат "СлужебнаяОперация";
		
	ИначеЕсли КодТипаОперации = 14 Тогда
		Возврат "Приход";
		
	ИначеЕсли КодТипаОперации = 15 Тогда
		Возврат "Расход";
		
	ИначеЕсли КодТипаОперации = 16 Тогда
		Возврат "Инвентаризация";
		
	ИначеЕсли КодТипаОперации = 17 Тогда
		Возврат "Переоценка";
		
	ИначеЕсли КодТипаОперации = 18 Тогда
		Возврат "ВскрытиеТары";
		
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

Процедура ЗакрытьСмену(Смена, Смены, Транзакция)
	
	// Если смена не открыта/закрыта, открываем ее.
	Если Смена=Неопределено ИЛИ ЗначениеЗаполнено(Смена.ДатаЗакрытия) Тогда
		ОткрытьСмену(Смена, Смены, Транзакция);
	КонецЕсли;
	
	Смена.ДатаЗакрытия = Транзакция.ДатаИВремя;
	Смены.Добавить(Смена);
	
КонецПроцедуры

Процедура ОткрытьСмену(Смена, Смены, Транзакция)
	
	// Если предыдущая смена не закрыта, закрываем ее.
	Если Смена<>Неопределено И НЕ ЗначениеЗаполнено(Смена.ДатаЗакрытия) Тогда
		ЗакрытьСмену(Смена, Смены, Транзакция);
	КонецЕсли;
	
	Смена = Новый Структура;
	
	Смена.Вставить("Номер",			Транзакция.Поле14);
	Смена.Вставить("ДатаОткрытия",	Транзакция.ДатаИВремя);
	Смена.Вставить("ДатаЗакрытия"	);
	Смена.Вставить("Чеки",			Новый Массив);
	
КонецПроцедуры

Функция ЗакрытьЧек(Смена, Транзакция, ТекстОшибки)
	
	ТекущийЧек = ПолучитьЧек(Смена, Транзакция.НомерЧека);
	
	Если ТекущийЧек = Неопределено Тогда
		ТекстОшибки = НСтр("ru='Неверный формат файла. Невозможно найти чек №%1%'");
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%1%", Транзакция.НомерЧека);
		Результат = Ложь;
	Иначе
		ТекущийЧек.Закрыт = Истина;
		ТекущийЧек.ДатаЧека = Транзакция.ДатаИВремя;
		Результат = Истина;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Открывает чек.
// 
// Параметры:
// 	Смена - Структура - структура с параметрами:
// 	*Номер - Число - .
//	*ДатаОткрытия - Дата - .
//	*ДатаЗакрытия - Дата - .
//	*Чеки - Массив - .
// 	Смены - Массив - Описание
// 	Транзакция - Структура - Описание:
// * НомерЧека - Число -
// * Тип - Число -
// * ДатаИВремя - Дата -
// * Номер - Число -
Процедура ОткрытьЧек(Смена, Смены, Транзакция)
	
	// Проверяем инициализированность текущей смены.
	Если Смена = Неопределено ИЛИ Смена.Номер <> Транзакция.Поле14 ИЛИ ЗначениеЗаполнено(Смена.ДатаЗакрытия) Тогда
		ОткрытьСмену(Смена, Смены, Транзакция);
	КонецЕсли;
	
	Чек = Новый Структура;
	
	Чек.Вставить("Закрыт", Ложь);
	Чек.Вставить("ДатаЧека", Неопределено); // устанавливается при закрытии
	Чек.Вставить("НомерЧека", Транзакция.НомерЧека);
	Чек.Вставить("Товары", Новый Массив);
	Чек.Вставить("Оплаты", Новый Массив);
	Чек.Вставить("ТипОперацииККМ", ТипОперацииККМ(Транзакция.Поле13));
	
	Смена.Чеки.Добавить(Чек);
	
КонецПроцедуры

Процедура ДобавитьТранзакциюВЧек(Смена, Смены, Транзакция, ФорматОбмена, Оплата = Ложь)
	
	Если Смена = Неопределено ИЛИ ЗначениеЗаполнено(Смена.ДатаЗакрытия) Тогда
		ОткрытьСмену(Смена, Смены, Транзакция);
	КонецЕсли;
	
	ТекущийЧек = ПолучитьЧек(Смена, Транзакция.НомерЧека);
	
	Если ТекущийЧек = Неопределено Тогда
		ОткрытьЧек(Смена, Смены, Транзакция);
	КонецЕсли;
	
	Если Оплата Тогда
		
		ОплатыЧека = Смена.Чеки[Смена.Чеки.Количество()-1].Оплаты;
		
		НайденныеОплаты = НайтиСтроки(ОплатыЧека, Новый Структура("КодВидаОплаты, ТипЧека", Транзакция.Поле9, Транзакция.Поле13));
		
		Если НайденныеОплаты.Количество()>0 Тогда
			
			Оплата = ОплатыЧека[НайденныеОплаты[0].ИндексВМассиве];
			Оплата.Сумма = Оплата.Сумма + Транзакция.Поле12;
			
		Иначе
			
			НоваяОплата = Новый Структура;
			
			НоваяОплата.Вставить("ТипОплаты",		?(Транзакция.Поле9 = "0" ИЛИ ПустаяСтрока(Транзакция.Поле9) ИЛИ Транзакция.Поле9 = "1", "0", "1")); // 0 - предопределенный тип оплаты "наличные".
			НоваяОплата.Вставить("КодВидаОплаты",	Транзакция.Поле9);
			НоваяОплата.Вставить("Сумма",			Транзакция.Поле12);
			НоваяОплата.Вставить("ТипЧека",			Транзакция.Поле13);
			
			ОплатыЧека.Добавить(НоваяОплата);
			
		КонецЕсли;
		
	Иначе
		
		Если Транзакция.Поле13 = 18 Тогда
			
			НовоеВскрытие = Новый Структура;
			
			НовоеВскрытие.Вставить("Дата",			НачалоДня(Транзакция.ДатаИВремя));
			НовоеВскрытие.Вставить("Код",			Транзакция.Поле8);
			НовоеВскрытие.Вставить("Количество",	Транзакция.Поле11);
			НовоеВскрытие.Вставить("ВскрытиеТары",	Истина);
			
			Если ФорматОбмена = 1 ИЛИ ФорматОбмена = 2 ИЛИ ФорматОбмена = 8 Тогда
				ШтрихкодМарки = Транзакция.Поле34;
			Иначе
				ШтрихкодМарки = "";
			КонецЕсли;
			
			НовоеВскрытие.Вставить("ШтрихкодАлкогольнойПродукции",	ШтрихкодМарки);
			
			МассивТоваровЧекаСмены = Смена.Чеки[Смена.Чеки.Количество()-1].Товары; //Массив - 
			МассивТоваровЧекаСмены.Добавить(НовоеВскрытие);
			
		Иначе
				
			НовыйТовар = Новый Структура;
			
			НовыйТовар.Вставить("Код",					Транзакция.Поле8);
			НовыйТовар.Вставить("Количество",			Транзакция.Поле11);
			НовыйТовар.Вставить("Цена",					Транзакция.Поле10);
			НовыйТовар.Вставить("Сумма",				Транзакция.Поле16);
			НовыйТовар.Вставить("НомерТранзакции",		Транзакция.Номер);
			НовыйТовар.Вставить("ДатаИВремяТранзакции",	Транзакция.ДатаИВремя);
			НовыйТовар.Вставить("ВскрытиеТары",			Ложь);
			
			Если ФорматОбмена = 1 ИЛИ ФорматОбмена = 2 ИЛИ ФорматОбмена = 8 Тогда
				ШтрихкодМарки = Транзакция.Поле34;
			Иначе
				ШтрихкодМарки = "";
			КонецЕсли;
			
			НовыйТовар.Вставить("ШтрихкодАлкогольнойПродукции", ШтрихкодМарки);
			
			МассивТоваровЧекаСмены = Смена.Чеки[Смена.Чеки.Количество()-1].Товары; //Массив -
			МассивТоваровЧекаСмены.Добавить(НовыйТовар);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Функция УдалитьТранзакциюИзЧека(Смена, Транзакция, ТекстОшибки)
	
	Результат = Истина;
	
	ТекущийЧек = ПолучитьЧек(Смена, Транзакция.НомерЧека);
	
	Если ТекущийЧек = Неопределено ИЛИ ТекущийЧек.Товары.Количество() = 0 Тогда
		Результат = Ложь;
	Иначе
		
		СторнируемаяТранзакция = Неопределено;
		
		Для Каждого ТекТовар Из ТекущийЧек.Товары Цикл
			
			Если ТекТовар.Код = Транзакция.Поле8 И ТекТовар.Количество = -1*Транзакция.Поле11 И ТекТовар.Цена = Транзакция.Поле10 Тогда
				СторнируемаяТранзакция = ТекТовар;
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Если НЕ СторнируемаяТранзакция = Неопределено Тогда
			ТекущийЧек.Товары.Удалить(ТекущийЧек.Товары.Найти(СторнируемаяТранзакция));
		Иначе
			Результат = Ложь;
		КонецЕсли;
		
		Если НЕ Результат Тогда
			ТекстОшибки = НСтр("ru='Операция прервана. Ошибка при загрузке транзакции №%1%.'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%1%", Транзакция.Номер);
		КонецЕсли;
		
		Возврат Результат;
		
	КонецЕсли;
	
КонецФункции

Функция ЗаполнитьТранзакцию(Строка, Транзакция, ФорматОбмена, ТекстОшибки)
	
	Результат = Истина;
	
	// Номер транзакции.
	Попытка
		
		Транзакция.Номер = Число(СтрПолучитьСтроку(Строка, 1));
		
	Исключение
		Транзакция.Номер = 0;
	КонецПопытки;
	
	
	// Дата и время транзакции.
	Попытка
		
		ДатаТранзакции = СтрЗаменить(СтрПолучитьСтроку(Строка, 2), "-", ".");
		ДатаТранзакции = СтрЗаменить(ДатаТранзакции, ".", Символы.ПС);
		
		ВремяТранзакции = СтрЗаменить(СтрПолучитьСтроку(Строка, 3), ":", Символы.ПС);
		
		Транзакция.ДатаИВремя = Дата(Число(СтрПолучитьСтроку(ДатаТранзакции, 3)),
			Число(СтрПолучитьСтроку(ДатаТранзакции, 2)),
			Число(СтрПолучитьСтроку(ДатаТранзакции, 1)),
			Число(СтрПолучитьСтроку(ВремяТранзакции, 1)),
			Число(СтрПолучитьСтроку(ВремяТранзакции, 2)),
			Число(СтрПолучитьСтроку(ВремяТранзакции, 3))
		);
		
	Исключение
		Транзакция.ДатаИВремя = Дата(1,1,1);
	КонецПопытки;
	
	// Тип транзакции.
	Попытка
		
		Транзакция.Тип = Число(СтрПолучитьСтроку(Строка, 4));
		
	Исключение
		Транзакция.Тип = 0;
	КонецПопытки;
	
	
	// Номер чека транзакции.
	Попытка
		
		Транзакция.НомерЧека = Число(СтрПолучитьСтроку(Строка, 6));
		
	Исключение
		Транзакция.НомерЧека = 0;
	КонецПопытки;
	
	
	Если ФорматОбмена = 1 ИЛИ ФорматОбмена = 2 ИЛИ ФорматОбмена = 8 Тогда
		КоличествоПолей = 34;
	Иначе
		КоличествоПолей = 26
	КонецЕсли;
	
	// При загрузке обрабатываются только первые 26 полей.
	Для Индекс = 8 По КоличествоПолей Цикл
		
		ИндексСтрокой = Формат(Индекс, "ЧГ=0");
		
		ПолеОшибки = НСтр("ru='Поле №%1% (%1%)'");
		ПолеОшибки = СтрЗаменить(ПолеОшибки, "%1%", ИндексСтрокой);
		
		Значение = СтрПолучитьСтроку(Строка, Индекс);
		
		ИндексВхождения = СтрНайти(Значение, "|");
		
		Если ИндексВхождения > 0 Тогда
			Значение = Лев(Значение, ИндексВхождения-1);
		КонецЕсли;
		
		// Преобразуем значение числовых полей в число.
		Если (Индекс >= 10 И Индекс <= 13) ИЛИ Индекс = 16 Тогда
			
			Попытка
				ЗначениеЧислом = Число(Значение);
			Исключение
				ЗначениеЧислом = 0;
			КонецПопытки;
			
			Транзакция.Вставить("Поле" + ИндексСтрокой, ?(ЗначениеЗаполнено(Значение), ЗначениеЧислом, Неопределено));
		Иначе
			Транзакция.Вставить("Поле" + ИндексСтрокой, Значение);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция РазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено, СокращатьНепечатаемыеСимволы = Ложь)
	
	Результат = Новый Массив;
	
	// Для обеспечения обратной совместимости.
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
	
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Если СокращатьНепечатаемыеСимволы Тогда
				Результат.Добавить(СокрЛП(Подстрока));
			Иначе
				Результат.Добавить(Подстрока);
			КонецЕсли;
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Если СокращатьНепечатаемыеСимволы Тогда
			Результат.Добавить(СокрЛП(Строка));
		Иначе
			Результат.Добавить(Строка);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьПустуюТранзакцию()
	
	Транзакция = Новый Структура;
	
	Транзакция.Вставить("Номер", 0);
	
	// Дата и время транзакции.
	Транзакция.Вставить("ДатаИВремя", Дата(1,1,1));
	
	// Тип транзакции.
	Транзакция.Вставить("Тип", 0);
	
	// Номер чека транзакции.
	Транзакция.Вставить("НомерЧека", 0);
	
	Возврат Транзакция;
	
КонецФункции

Функция ПолучитьНомераНалоговНаККМПоУмолчанию() Экспорт
	
	Налоги = Новый Структура;
	
	Налоги.Вставить("НомерНалога0", 1);
	Налоги.Вставить("НомерНалога10", 2);
	Налоги.Вставить("НомерНалога20", 3);
	Налоги.Вставить("НомерНалогаБезНДС", 4);
	Налоги.Вставить("НомерНалога18", 5);
	
	Возврат Налоги;
	
КонецФункции

#КонецОбласти

