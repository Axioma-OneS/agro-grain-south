﻿
#Область ПрограммныйИнтерфейс

#Область ФискальныеОперации

Процедура ЗаполнитьДанныеФискальнойОперации(ПараметрыОперацииФискализацииЧека, ДанныеФискальнойОперации) Экспорт
	
	Если НЕ ДанныеФискальнойОперации.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.НеОтправлять") Тогда
		ПараметрыОперацииФискализацииЧека.Электронно = ДанныеФискальнойОперации.НеПечататьФискальныйЧек;
	КонецЕсли;
	
	Если ДанныеФискальнойОперации.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьSMS")
		И ЗначениеЗаполнено(ДанныеФискальнойОперации.КонтактныеДанныеЭлектронногоЧека) Тогда
		ПараметрыОперацииФискализацииЧека.Отправляет1СSMS = Не ДанныеФискальнойОперации.ОтправлятьSMSЧерезОФД;
		ПараметрыОперацииФискализацииЧека.ПокупательНомер = ДанныеФискальнойОперации.КонтактныеДанныеЭлектронногоЧека;
	КонецЕсли;
	
	Если ДанныеФискальнойОперации.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьEmail")
		И ЗначениеЗаполнено(ДанныеФискальнойОперации.КонтактныеДанныеЭлектронногоЧека) Тогда
		ПараметрыОперацииФискализацииЧека.Отправляет1СEmail = Не ДанныеФискальнойОперации.ОтправлятьEmailЧерезОФД;
		ПараметрыОперацииФискализацииЧека.ПокупательEmail = ДанныеФискальнойОперации.КонтактныеДанныеЭлектронногоЧека;
	КонецЕсли;
	
	ПараметрыОперацииФискализацииЧека.ОтправительEmail = ДанныеФискальнойОперации.ОтправительEmail;
	
КонецПроцедуры

Функция СтавкаНДСФискальнойОперации(СтавкаНДС, ПрименяютсяРасчетныеСтавки = Ложь) Экспорт
	
	Если СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.БезНДС")
		Или СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.ПустаяСсылка") Тогда
		Возврат Неопределено;
	ИначеЕсли СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС20_120") И ПрименяютсяРасчетныеСтавки Тогда
		Возврат 120;
	ИначеЕсли СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС18_118") И ПрименяютсяРасчетныеСтавки Тогда
		Возврат 118;
	ИначеЕсли СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС10_110") И ПрименяютсяРасчетныеСтавки Тогда
		Возврат 110;
	Иначе
		Возврат ЦенообразованиеКлиентСервер.ПолучитьСтавкуНДСЧислом(СтавкаНДС);
	КонецЕсли;
	
КонецФункции

Функция ПризнакПредметаРасчетаФискальнойОперации(ТипНоменклатуры, ПодакцизныйТовар) Экспорт
	
	ВозвращаемоеЗначение = ПредопределенноеЗначение("Перечисление.ПризнакиПредметаРасчета.Товар");
	
	Если ПодакцизныйТовар Тогда
		ВозвращаемоеЗначение = ПредопределенноеЗначение("Перечисление.ПризнакиПредметаРасчета.ПодакцизныйТовар");
	КонецЕсли;
	
	Если ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Работа") Тогда
		ВозвращаемоеЗначение = ПредопределенноеЗначение("Перечисление.ПризнакиПредметаРасчета.Работа");
	ИначеЕсли ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Услуга") Тогда
		ВозвращаемоеЗначение = ПредопределенноеЗначение("Перечисление.ПризнакиПредметаРасчета.Услуга");
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

#КонецОбласти

// Обновляет данные информационной панели
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма, на которой расположена информационная панель
//  Данные - Структура - Структура с данными информационной панели.
//
Процедура ОбновитьДанныеИнформационнойПанели(Форма, Данные) Экспорт
	
	Если Данные = Неопределено Тогда
		Форма.ИнформационнаяПанельНаименованиеТовара      = "";
		Форма.ИнформационнаяПанельРасчетСуммы             = "";
		Форма.ИнформационнаяПанельПрочиеПараметрыИмя      = "";
		Форма.ИнформационнаяПанельПрочиеПараметрыЗначение = "";
		Возврат;
	КонецЕсли;
	
	Если Данные.ОтобразитьСдачу Тогда
		
		ТекстНачисленныеБонусныеБаллы = "";
		Если Данные.Свойство("ТекстНачисленныеБонусныеБаллы") Тогда
			ТекстНачисленныеБонусныеБаллы = Данные.ТекстНачисленныеБонусныеБаллы;
		КонецЕсли;
		
		Форма.ИнформационнаяПанельНаименованиеТовара      = ТекстНачисленныеБонусныеБаллы;
		Форма.ИнформационнаяПанельРасчетСуммы             = Данные.ТекстСдача;
		Форма.ИнформационнаяПанельПрочиеПараметрыИмя      = "";
		Форма.ИнформационнаяПанельПрочиеПараметрыЗначение = "";
		Возврат;
	КонецЕсли;
	
	НаименованиеТовара = Новый ФорматированнаяСтрока(Данные.НаименованиеТовара);
	ДанныеСтроки       = Данные.ДанныеСтроки;
	СуммовыеПараметры  = Данные.СуммовыеПараметры;
	
	РасчетСуммы = Новый ФорматированнаяСтрока("");
	
	Формат = ФорматнаяСтрока(СуммовыеПараметры.Цена, 2);
	
	Если СуммовыеПараметры.Сумма <> 0 Тогда
		
		// Количество x Цена
		ФорматКоличество = ФорматнаяСтрока(СуммовыеПараметры.Количество, 3);
		ЦенаКоличество = СтрШаблон("%1 x %2",
			Формат(СуммовыеПараметры.Количество, ФорматКоличество),
			Формат(СуммовыеПараметры.Цена, Формат));
			
		// Ручная скидка
		Формат = ФорматнаяСтрока(СуммовыеПараметры.СуммаРучнойСкидки, 2);
		РучнаяСкидка = Новый ФорматированнаяСтрока("");
		Если СуммовыеПараметры.Свойство("СуммаРучнойСкидки") Тогда
			Если СуммовыеПараметры.СуммаРучнойСкидки > 0 Тогда
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					" - ",
					Новый ФорматированнаяСтрока(Формат(СуммовыеПараметры.СуммаРучнойСкидки, Формат),,,,"РучнаяСкидка"));
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(СуммовыеПараметры.ПроцентРучнойСкидки, Формат) + "%" + " )",,,,"РучнаяСкидка"));
			КонецЕсли;
			Если СуммовыеПараметры.СуммаРучнойСкидки < 0 Тогда
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					" + ",
					Новый ФорматированнаяСтрока(Формат(-СуммовыеПараметры.СуммаРучнойСкидки, Формат),,,,"РучнаяСкидка"));
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(-СуммовыеПараметры.ПроцентРучнойСкидки, Формат) + "%" + " )",,,,"РучнаяСкидка"));
			КонецЕсли;
		КонецЕсли;
		
		// Автоматическая скидка
		Формат = ФорматнаяСтрока(СуммовыеПараметры.СуммаАвтоматическойСкидки, 2);
		АвтоматическаяСкидка = Новый ФорматированнаяСтрока("");
		Если СуммовыеПараметры.Свойство("СуммаАвтоматическойСкидки") Тогда
			Если СуммовыеПараметры.СуммаАвтоматическойСкидки > 0 Тогда
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					" - ",
					Новый ФорматированнаяСтрока(Формат(СуммовыеПараметры.СуммаАвтоматическойСкидки, Формат),,,,"АвтоматическаяСкидка"));
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(СуммовыеПараметры.ПроцентАвтоматическойСкидки,  Формат) + "%" + " )",,,,"АвтоматическаяСкидка"));
			КонецЕсли;
			Если СуммовыеПараметры.СуммаАвтоматическойСкидки < 0 Тогда
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					" + ",
					Новый ФорматированнаяСтрока(Формат(-СуммовыеПараметры.СуммаАвтоматическойСкидки, Формат),,,,"АвтоматическаяСкидка"));
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(-СуммовыеПараметры.ПроцентАвтоматическойСкидки, Формат) + "%" + " )",,,,"АвтоматическаяСкидка"));
			КонецЕсли;
		КонецЕсли;
		
		// Сумма
		Формат = ФорматнаяСтрока(СуммовыеПараметры.Сумма, 2);
		Сумма  = " = " + Формат(СуммовыеПараметры.Сумма, Формат);
		
		РасчетСуммы = Новый ФорматированнаяСтрока(
			ЦенаКоличество,
			РучнаяСкидка,
			АвтоматическаяСкидка,
			Сумма
		);
		
	КонецЕсли;
	
	ВыводитьПиктограммуСообщенийОколоКарты = Ложь;
	Если Данные.Свойство("СтруктураСообщений")
		И Данные.СтруктураСообщений <> Неопределено
		И Данные.СтруктураСообщений.Сообщения.Количество() > 0 Тогда
		
		Если ДанныеСтроки.Количество() <= 2
			Или (ДанныеСтроки.Свойство("Карта") И Не ЗначениеЗаполнено(ДанныеСтроки.Карта)) Тогда
			
			НепрочитанныхСообщений = 0;
			Для Каждого СтрокаТЧ Из Данные.СтруктураСообщений.Сообщения Цикл
				Если СтрокаТЧ.НапомнитьПозже Тогда
					НепрочитанныхСообщений = НепрочитанныхСообщений + 1;
				КонецЕсли;
			КонецЦикла;
			
			Если НепрочитанныхСообщений > 0 Тогда
				Текст = СтрШаблон(НСтр("ru = 'Новые (%1)'"), НепрочитанныхСообщений);
			Иначе
				Текст = Данные.СтруктураСообщений.Сообщения.Количество();
			КонецЕсли;
			
			ДанныеСтроки.Вставить("Сообщения", Текст);
			
		Иначе
			ВыводитьПиктограммуСообщенийОколоКарты = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	Имена = Новый ФорматированнаяСтрока("");
	Значения = Новый ФорматированнаяСтрока("");
	Для Каждого ЭлементСтруктуры Из ДанныеСтроки Цикл
		
		Разделитель = "";
		Если ЗначениеЗаполнено(Имена) Тогда
			Разделитель = Символы.ПС;
		КонецЕсли;
		
		Суффикс = "";
		Цвет = Неопределено;
		
		Если ЭлементСтруктуры.Ключ = "Карта" И ВыводитьПиктограммуСообщенийОколоКарты Тогда
			Значение = Новый ФорматированнаяСтрока(
				Строка(ЭлементСтруктуры.Значение),
				Новый ФорматированнаяСтрока(БиблиотекаКартинок.НовостиВнимание,,,,"Сообщения"));
		Иначе
			Значение = Строка(ЭлементСтруктуры.Значение);
		КонецЕсли;
		
		Если Данные.ОбязательныеРеквизиты.Найти(ЭлементСтруктуры.Ключ) <> Неопределено
			И Не ЗначениеЗаполнено(ЭлементСтруктуры.Значение) Тогда
			
			#Если Клиент Тогда
				Цвет = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("ПоясняющийОшибкуТекст");
			#Иначе
				Цвет = ЦветаСтиля.ПоясняющийОшибкуТекст;
			#КонецЕсли
			
			Значение = НСтр("ru = '<не заполнено>'");
			Суффикс = "ЗначениеНеЗаполнено";
			
		ИначеЕсли Не ЗначениеЗаполнено(ЭлементСтруктуры.Значение) Тогда
			
			Продолжить;
			
		КонецЕсли;
		
		Имена = Новый ФорматированнаяСтрока(
			Имена,
			Разделитель,
			ЭлементСтруктуры.Ключ + ":");
		
		Значения = Новый ФорматированнаяСтрока(
			Значения,
			Разделитель,
			Новый ФорматированнаяСтрока(Значение,,Цвет,,ЭлементСтруктуры.Ключ + Суффикс));
		
	КонецЦикла;
	
	Форма.ИнформационнаяПанельРасчетСуммы             = РасчетСуммы;
	Форма.ИнформационнаяПанельНаименованиеТовара      = НаименованиеТовара;
	Форма.ИнформационнаяПанельПрочиеПараметрыИмя      = Имена;
	Форма.ИнформационнаяПанельПрочиеПараметрыЗначение = Значения;
	
КонецПроцедуры

// Структура данных для повтора операции записи.
// 
// Возвращаемое значение:
//  Структура - Данные для повтора операции записи.
//
Функция СтруктураПовтораЗаписи() Экспорт
	
	СтруктураПовтораЗаписи = Новый Структура;
	СтруктураПовтораЗаписи.Вставить("РеквизитыФискальнойОперацииКассовогоУзла");
	СтруктураПовтораЗаписи.Вставить("ОписаниеОповещения");
	СтруктураПовтораЗаписи.Вставить("ТекстСообщения");
	СтруктураПовтораЗаписи.Вставить("ВозвращатьРезультатФункции");
	СтруктураПовтораЗаписи.Вставить("РезультатПриУспешномПроведении");
	СтруктураПовтораЗаписи.Вставить("РезультатПриОтмене");
	СтруктураПовтораЗаписи.Вставить("ИмяПроцедуры");
	СтруктураПовтораЗаписи.Вставить("ПараметрыПроцедуры");
	СтруктураПовтораЗаписи.Вставить("РезультатОперации");
	
	Возврат СтруктураПовтораЗаписи;
	
КонецФункции

// Структура строки чека для ЕГАИС
// 
// Возвращаемое значение:
//  Структура - Структура строки чека для ЕГАИС.
//
Функция СтруктураСтрокиЧекаЕГАИС() Экспорт
	
	СтрокаТовара = Новый Структура;
	СтрокаТовара.Вставить("НомерСтроки");
	СтрокаТовара.Вставить("Наименование");
	СтрокаТовара.Вставить("ТипНоменклатуры");
	СтрокаТовара.Вставить("ПодакцизныйТовар");
	СтрокаТовара.Вставить("Номенклатура");
	СтрокаТовара.Вставить("Характеристика");
	СтрокаТовара.Вставить("Упаковка");
	СтрокаТовара.Вставить("Количество");
	СтрокаТовара.Вставить("КоличествоУпаковок");
	СтрокаТовара.Вставить("Цена");
	СтрокаТовара.Вставить("ПроцентАвтоматическойСкидки");
	СтрокаТовара.Вставить("СуммаАвтоматическойСкидки");
	СтрокаТовара.Вставить("ПроцентРучнойСкидки");
	СтрокаТовара.Вставить("СуммаРучнойСкидки");
	СтрокаТовара.Вставить("Сумма");
	СтрокаТовара.Вставить("СтавкаНДС");
	СтрокаТовара.Вставить("СуммаНДС");
	СтрокаТовара.Вставить("Штрихкод");
	
	СтрокаТовара.Вставить("НоменклатураЕГАИС");
	СтрокаТовара.Вставить("АлкогольнаяПродукция");
	СтрокаТовара.Вставить("АлкогольнаяПродукцияВоВскрытойТаре");
	СтрокаТовара.Вставить("Сопоставлено");
	СтрокаТовара.Вставить("КодАкцизнойМарки");
	СтрокаТовара.Вставить("МаркируемаяПродукция");
	СтрокаТовара.Вставить("ВидПродукции");
	СтрокаТовара.Вставить("КодВидаАлкогольнойПродукции");
	СтрокаТовара.Вставить("Объем");
	СтрокаТовара.Вставить("Крепость");
	СтрокаТовара.Вставить("ИНН");
	СтрокаТовара.Вставить("КПП");
	СтрокаТовара.Вставить("ПроизводительИмпортерАлкогольнойПродукции");
	
	Возврат СтрокаТовара;
	
КонецФункции

// Структура данных документа для передачи параметра ДанныеДокумента в метод ПодключаемоеОборудованиеУТВызовСервера.ПараметрыФискализацииЧека()
// 
// Возвращаемое значение:
//  Структура - Структура параметра ДанныеДокумента.
//
Функция СтруктураДанныхДокументаДляПараметровФискализацииЧека() Экспорт
	
	СтруктураДанных = Новый Структура;
	СтруктураДанных.Вставить("Заказы");
	СтруктураДанных.Вставить("Шапка");
	СтруктураДанных.Вставить("Товары");
	СтруктураДанных.Вставить("ДанныеДляИСМП");
	СтруктураДанных.Вставить("ДанныеДляЕГАИС");
	
	Возврат СтруктураДанных;
КонецФункции

#Область РаботаСКонтрактнойИнформациейФЗ54

// Установить активность элементов формы: ПолеПолученоНаличными, Телефон, Email.
// Активные элементы связаны с цифровой клавиатурой формы.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма (ФормаОплатыНаличными или ФормаСмешаннойОплаты).
//
Процедура УстановитьАктивностьЭлементов(Форма) Экспорт
	
	Если Форма.ТекущийЭлемент = Форма.Элементы.ПолеПолученоНаличными
		И Форма.АктивноеПоле <> Форма.Элементы.ПолеПолученоНаличными.Имя Тогда
		
		РозничныеПродажиКлиентСервер.УстановитьАктивныйЭлемент(Форма, Форма.Элементы.ПолеПолученоНаличными);
		
	КонецЕсли;
	
	Если Форма.ТекущийЭлемент = Форма.Элементы.Телефон
		И Форма.АктивноеПоле <> Форма.Элементы.Телефон.Имя Тогда
		
		РозничныеПродажиКлиентСервер.УстановитьАктивныйЭлемент(Форма, Форма.Элементы.Телефон);
		
	КонецЕсли;
	
	Если Форма.ТекущийЭлемент = Форма.Элементы.Email
		И Форма.АктивноеПоле <> Форма.Элементы.Email.Имя Тогда
		
		РозничныеПродажиКлиентСервер.УстановитьАктивныйЭлемент(Форма, Форма.Элементы.Email);
		
	КонецЕсли;
	
КонецПроцедуры

// Включить использование клавиатуры для элемента формы.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма (ФормаОплатыНаличными или ФормаСмешаннойОплаты).
//  Элемент - ПолеВвода - Элемент формы, для которого необходимо включить клавиатуру.
//
Процедура УстановитьАктивныйЭлемент(Форма, Элемент) Экспорт
	
	Форма.АктивноеПоле = Элемент.Имя;
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить(Форма.Элементы.ПолеПолученоНаличными);
	МассивЭлементов.Добавить(Форма.Элементы.Телефон);
	МассивЭлементов.Добавить(Форма.Элементы.Email);
	
	Для Каждого ЭлементФормы Из МассивЭлементов Цикл
		ЭлементФормы.ЦветФона = Новый Цвет;
	КонецЦикла;
	
	Форма.Элементы[Форма.АктивноеПоле].ЦветФона = Форма.ЦветФонаВыделенияПоля;
	
	Если Форма.АктивноеПоле = Форма.Элементы.Email.Имя Тогда
		Форма.Элементы.ГруппаСтраницаПраваяКлавиатура.Видимость = Ложь;
		Форма.Элементы.ГруппаСтраницаПрочее.Видимость = Ложь;
		Форма.Элементы.ГруппаСтраницы.ТекущаяСтраница = Форма.Элементы.ГруппаРежимКлавиатуры;
		Форма.ТекущийЭлемент = Форма.Элементы.Email;
	Иначе
		Форма.Элементы.ГруппаСтраницаПраваяКлавиатура.Видимость = Истина;
		Форма.Элементы.ГруппаСтраницаПрочее.Видимость = Истина;
		Форма.Элементы.ГруппаСтраницы.ТекущаяСтраница = Форма.Элементы.ГруппаСтраницаПраваяКлавиатура;
	КонецЕсли;
	
КонецПроцедуры

// Процедура - Установить вариант отправки электронного чека.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма (ФормаОплатыНаличными или ФормаСмешаннойОплаты).
//  ВариантОтправкиЭлектронногоЧека - ПеречислениеСсылка.ВариантыОтправкиЭлектронногоЧекаПокупателю - Вариант отправки
//                                                                                                    электронного чека.
//
Процедура УстановитьВариантОтправкиЭлектронногоЧека(Форма, ВариантОтправкиЭлектронногоЧека) Экспорт
	
	Если Форма.ВариантОтправкиЭлектронногоЧека = ВариантОтправкиЭлектронногоЧека Тогда
		Возврат;
	КонецЕсли;
	
	Форма.ВариантОтправкиЭлектронногоЧека = ВариантОтправкиЭлектронногоЧека;
	
	Если ОбщегоНазначенияУТКлиентСервер.ЕстьРеквизитОбъекта(Форма.Элементы, "КомандаОтправитьSMS") Тогда
		
		МассивЭлементов = Новый Массив;
		МассивЭлементов.Добавить(Форма.Элементы.КомандаОтправитьSMS);
		МассивЭлементов.Добавить(Форма.Элементы.КомандаОтправитьEmail);
		МассивЭлементов.Добавить(Форма.Элементы.КомандаОтправкаНеТребуется);
		
		Для Каждого ЭлементФормы Из МассивЭлементов Цикл
			ЭлементФормы.ЦветФона = Новый Цвет;
		КонецЦикла;
		
		Если Форма.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьSMS") Тогда
			Форма.Элементы.КомандаОтправитьSMS.ЦветФона = Форма.ЦветФонаВыделенияПоля;
		ИначеЕсли Форма.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьEmail") Тогда
			Форма.Элементы.КомандаОтправитьEmail.ЦветФона = Форма.ЦветФонаВыделенияПоля;
		ИначеЕсли Форма.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.НеОтправлять") Тогда
			Форма.Элементы.КомандаОтправкаНеТребуется.ЦветФона = Форма.ЦветФонаВыделенияПоля;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Отформатировать номер телефона. Из номера вида 9999999999 формирует +7(999)999-99-99.
//
// Параметры:
//  Телефон - Строка - Номер телефона.
// 
// Возвращаемое значение:
//  Строка - Отформатированный номер телефона.
//
Функция ОтформатироватьНомерТелефона(Телефон) Экспорт
	
	Если ЗначениеЗаполнено(Телефон) Тогда
		
		Если СтрДлина(Телефон) > 3 Тогда;
			Буфер = Сред(Телефон, 4, СтрДлина(Телефон) - 3);
		Иначе
			Буфер = "";
		КонецЕсли;
		
		Возврат "+7(" + Лев(Телефон, 3) + ")" + Буфер;
		
	Иначе
		
		Возврат "+7";
		
	КонецЕсли;
	
КонецФункции

// Получить 10 знаков номера телефона по переданному представлению.
//
// Параметры:
//  Телефон - Строка - Представление номера телефона.
// 
// Возвращаемое значение:
//  Строка - 10 знаков номера телефона.
//
Функция НомерТелефонаВФормате10Знаков(Телефон) Экспорт
	
	Телефон10Знаков = "";
	Числа = "0123456789";
	
	ДлинаПредставленияТелефона = СтрДлина(Телефон);
	Для Индекс = 1 По ДлинаПредставленияТелефона Цикл
		
		Символ = Сред(Телефон, Индекс, 1);
		Если СтрНайти(Числа, Символ) > 0 Тогда
			Телефон10Знаков = Телефон10Знаков + Символ;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Прав(Телефон10Знаков, 10);
	
КонецФункции

// Возвращает пустую структура результата оплаты чека ККМ.
// 
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * ПолученоНаличными - Число - Сумма оплаты наличными.
//   * ДанныеЭлектронногоЧека - Структура - Данные электронного чека, см. функцию СтруктураДанныеЭлектронногоЧека().
//
Функция СтруктураРезультатаОплаты() Экспорт
	
	РезультатОплаты = Новый Структура;
	РезультатОплаты.Вставить("ПолученоНаличными",      0);
	РезультатОплаты.Вставить("ДанныеЭлектронногоЧека", Неопределено);
	
	Возврат РезультатОплаты;
	
КонецФункции

// Возвращает пустую структура данных электронного чека ККМ.
// 
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * Партнер - СправочникСсылка.Партнеры - Партнер.
//   * ВариантОтправкиЭлектронногоЧека - ПеречислениеСсылка.ВариантыОтправкиЭлектронногоЧекаПокупателю - Вариант
//       отправки электронного чека.
//   * КонтактныеДанныеЭлектронногоЧека - Строка - Телефон или адрес электронной почты.
//
Функция СтруктураДанныеЭлектронногоЧека() Экспорт
	
	ДанныеЭлектронногоЧека = Новый Структура;
	ДанныеЭлектронногоЧека.Вставить("Партнер",                          ПредопределенноеЗначение("Справочник.Партнеры.РозничныйПокупатель"));
	ДанныеЭлектронногоЧека.Вставить("ВариантОтправкиЭлектронногоЧека",  ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.НеОтправлять"));
	ДанныеЭлектронногоЧека.Вставить("КонтактныеДанныеЭлектронногоЧека", "");
	
	Возврат ДанныеЭлектронногоЧека;
	
КонецФункции

// Получить данные электронного чека.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма (ФормаОплатыНаличными или ФормаСмешаннойОплаты).
// 
// Возвращаемое значение:
//  Структура - Данные электронного чека, см. функцию СтруктураДанныеЭлектронногоЧека().
//
Функция ДанныеЭлектронногоЧека(Форма) Экспорт
	
	ДанныеЭлектронногоЧека = СтруктураДанныеЭлектронногоЧека();
	
	КонтактныеДанныеЭлектронногоЧека = "";
	Если Форма.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьSMS") Тогда
		
		КонтактныеДанныеЭлектронногоЧека = "+7" + НомерТелефонаВФормате10Знаков(Форма.Телефон);
		
	ИначеЕсли Форма.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьEmail") Тогда
		
		КонтактныеДанныеЭлектронногоЧека = Форма.Email;
		
	КонецЕсли;
	
	Если (Не ЗначениеЗаполнено(Форма.Партнер) Или Форма.Партнер = ПредопределенноеЗначение("Справочник.Партнеры.РозничныйПокупатель"))
		И ЗначениеЗаполнено(КонтактныеДанныеЭлектронногоЧека) Тогда
		РезультатПоиска = РозничныеПродажиВызовСервера.НайтиПартнераПоКонтактнымДаннымЭлектронногоЧека(
			Форма.ВариантОтправкиЭлектронногоЧека,
			КонтактныеДанныеЭлектронногоЧека);
		Если РезультатПоиска <> Неопределено Тогда
			
			Форма.Партнер                                 = РезультатПоиска.Партнер;
			Форма.ВариантОтправкиЭлектронногоЧекаПартнера = РезультатПоиска.ВариантОтправкиЭлектронногоЧека;
			
			Если ЗначениеЗаполнено(РезультатПоиска.Телефон) Тогда
				Форма.Телефон10Знаков = РозничныеПродажиКлиентСервер.НомерТелефонаВФормате10Знаков(РезультатПоиска.Телефон);
				Форма.Телефон = РозничныеПродажиКлиентСервер.ОтформатироватьНомерТелефона(Форма.Телефон10Знаков);
				Форма.Элементы.Телефон.СписокВыбора.Добавить(Форма.Телефон);
			КонецЕсли;
			
			Если ЗначениеЗаполнено(РезультатПоиска.Email) Тогда
				Форма.Email = РезультатПоиска.Email;
				Форма.Элементы.Email.СписокВыбора.Добавить(Форма.Email);
			КонецЕсли;
			
			Если Форма.Элементы.Телефон.СписокВыбора.Количество() > 0 Тогда
				Форма.Элементы.Телефон.КнопкаВыпадающегоСписка = Истина;
			КонецЕсли;
			
			Если Форма.Элементы.Email.СписокВыбора.Количество() > 0 Тогда
				Форма.Элементы.Email.КнопкаВыпадающегоСписка = Истина;
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
	ДанныеЭлектронногоЧека.Партнер                          = Форма.Партнер;
	ДанныеЭлектронногоЧека.ВариантОтправкиЭлектронногоЧека  = Форма.ВариантОтправкиЭлектронногоЧека;
	ДанныеЭлектронногоЧека.КонтактныеДанныеЭлектронногоЧека = КонтактныеДанныеЭлектронногоЧека;
	
	Возврат ДанныеЭлектронногоЧека;
	
КонецФункции

// Проверить необходимость обработки данных электронного чека на сервере.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма (ФормаОплатыНаличными или ФормаСмешаннойОплаты).
// 
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * ТребуетсяОбновитьКонтактнуюИнформацию - Булево - Требуется обновить контактную информацию.
//   * ТребуетсяСоздатьПартнера - Булево - Требуется создать партнера.
//
Функция ПроверитьНеобходимостьОбработкиДанныхЭлектронногоЧека(Форма) Экспорт
	
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("ТребуетсяОбновитьКонтактнуюИнформацию", Ложь);
	ВозвращаемоеЗначение.Вставить("ТребуетсяСоздатьПартнера", Ложь);
	ВозвращаемоеЗначение.Вставить("ТребуетсяОбновитьВариантОтправкиЭлектронногоЧекаПартнера", Ложь);
	
	СозданПартнер = ЗначениеЗаполнено(Форма.Партнер)
	             И (Форма.Партнер <> ПредопределенноеЗначение("Справочник.Партнеры.РозничныйПокупатель"));
	
	ОбновлятьКонтактнуюИнформацию = (СозданПартнер И Форма.АвтоматическиОбновлятьКонтактыПартнеров)
	                                 ИЛИ (Форма.АвтоматическиСоздаватьПартнеров И Не СозданПартнер);
	
	Если Форма.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьSMS") Тогда
		
		Телефоны = Новый Массив;
		Для Каждого ЭлементСпискаЗначений Из Форма.Элементы.Телефон.СписокВыбора Цикл
			Телефоны.Добавить(НомерТелефонаВФормате10Знаков(ЭлементСпискаЗначений.Значение));
		КонецЦикла;
		
		Если Телефоны.Найти(НомерТелефонаВФормате10Знаков(Форма.Телефон)) = Неопределено Тогда
			ВозвращаемоеЗначение.ТребуетсяОбновитьКонтактнуюИнформацию = ОбновлятьКонтактнуюИнформацию;
		КонецЕсли;
		
	ИначеЕсли Форма.ВариантОтправкиЭлектронногоЧека = ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьEmail") Тогда
		
		АдресаEmail = Новый Массив;
		Для Каждого ЭлементСпискаЗначений Из Форма.Элементы.Email.СписокВыбора Цикл
			АдресаEmail.Добавить(ЭлементСпискаЗначений.Значение);
		КонецЦикла;
		
		Если АдресаEmail.Найти(Форма.Email) = Неопределено Тогда
			ВозвращаемоеЗначение.ТребуетсяОбновитьКонтактнуюИнформацию = ОбновлятьКонтактнуюИнформацию;
		КонецЕсли;
		
	КонецЕсли;
	
	ВозвращаемоеЗначение.ТребуетсяОбновитьВариантОтправкиЭлектронногоЧекаПартнера
		= ОбновлятьКонтактнуюИнформацию
		И Форма.ВариантОтправкиЭлектронногоЧека <> Форма.ВариантОтправкиЭлектронногоЧекаПартнера;
		
	Если Форма.ВариантОтправкиЭлектронногоЧека <> ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.НеОтправлять") Тогда
		ВозвращаемоеЗначение.ТребуетсяСоздатьПартнера = Форма.АвтоматическиСоздаватьПартнеров И Не СозданПартнер;
	Иначе
		ВозвращаемоеЗначение.ТребуетсяСоздатьПартнера = Ложь;
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Функция выполняет приведение строки к числу.
//
// Параметры:
//  ЧислоСтрокой           - Строка - Строка приводимая к числу.
//  ВозвращатьНеопределено - Булево - Если Истина и строка содержит некорректное значение, то возвращать Неопределено.
//
// Возвращаемое значение:
//  Число - Приведенное значение.
//
Функция ПривестиСтрокуКЧислу(ЧислоСтрокой) Экспорт
	
	ОписаниеТипаЧисла = Новый ОписаниеТипов("Число");
	ЗначениеЧисла = ОписаниеТипаЧисла.ПривестиЗначение(ЧислоСтрокой);
	
	Возврат ЗначениеЧисла;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ФорматнаяСтрока(Число, РазрядностьДробнойЧасти)
	
	Если Цел(Число) = Число Тогда
		Возврат "ЧН=0; ЧДЦ=;";
	Иначе
		Возврат "ЧН=0; ЧДЦ=" + РазрядностьДробнойЧасти;
	КонецЕсли
	
КонецФункции

#КонецОбласти
