﻿
#Область ПрограммныйИнтерфейс


#Область НастройкиХозяйственныхОпераций

// Для хозяйственной операции возвращает схему компоновки данных
// с помощью которой можно получить движения по текущей хозяйственной операции.
//
// Параметры:
//  ХозяйственнаяОперация - СправочникСсылка.НастройкиХозяйственныхОпераций - хозяйственная операция 
//                        для которой требуется получить схему получения данных.
//
// Возвращаемое значение:
//   СхемаКомпоновкиДанных - схема получения данных по текущей хозяйственной операции.
//
Функция СхемаПолученияДанных(ХозяйственнаяОперация) Экспорт

	СхемаПолученияДанных = Неопределено;
	ИмяИсточникаДанных = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ХозяйственнаяОперация, "ИсточникДанных");
	МакетыИсточниковПолученияДанных = Метаданные.Справочники.НастройкиХозяйственныхОпераций.Макеты;
	МакетИсточникаПолученияДанных = МакетыИсточниковПолученияДанных.Найти(ИмяИсточникаДанных);
	Если МакетИсточникаПолученияДанных <> Неопределено Тогда
		ИмяСхемы = МакетИсточникаПолученияДанных.Имя; 
		СхемаПолученияДанных = Справочники.НастройкиХозяйственныхОпераций.ПолучитьМакет(ИмяСхемы);
	КонецЕсли;
	
	Возврат СхемаПолученияДанных;

КонецФункции

// Определяет список хозяйственных операций отражаемых в текущем регистре накопления.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра накопления.
//
// Возвращаемое значение:
//    СправочникСсылка.НастройкиХозяйственныхОпераций - массив хозяйственных операций отражаемых в переданном регистре накопления.
//
Функция ХозяйственныеОперацииАналитическихРегистров(ИмяРегистра) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	НастройкиХозяйственныхОпераций.Ссылка
	|ИЗ
	|	Справочник.НастройкиХозяйственныхОпераций КАК НастройкиХозяйственныхОпераций
	|ГДЕ
	|	НастройкиХозяйственныхОпераций.ИсточникДанных = &ИмяРегистра";
	Запрос.УстановитьПараметр("ИмяРегистра", ИмяРегистра);
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда
		Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Ссылка");
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Возвращает список всех регистров накопления используемых для хранения аналитической информации.
//
// Возвращаемое значение:
//    СписокЗначений - список регистров накопления.
//
Функция ДоступныеИсточникиДанных() Экспорт
	
	Список = Новый СписокЗначений;
	Регистры = Метаданные.РегистрыНакопления;
	Список.Добавить(Регистры.ВыручкаИСебестоимостьПродаж.Имя, Регистры.ВыручкаИСебестоимостьПродаж.Синоним);
	Список.Добавить(Регистры.ДвиженияДенежныеСредстваДоходыРасходы.Имя, Регистры.ДвиженияДенежныеСредстваДоходыРасходы.Синоним);
	Список.Добавить(Регистры.ДвиженияДенежныеСредстваКонтрагент.Имя, Регистры.ДвиженияДенежныеСредстваКонтрагент.Синоним);
	Список.Добавить(Регистры.ДвиженияДенежныхСредств.Имя, Регистры.ДвиженияДенежныхСредств.Синоним);
	Список.Добавить(Регистры.ДвиженияДоходыРасходыПрочиеАктивыПассивы.Имя, Регистры.ДвиженияДоходыРасходыПрочиеАктивыПассивы.Синоним);
	Список.Добавить(Регистры.ДвиженияКонтрагентДоходыРасходы.Имя, Регистры.ДвиженияКонтрагентДоходыРасходы.Синоним);
	Список.Добавить(Регистры.ДвиженияКонтрагентКонтрагент.Имя, Регистры.ДвиженияКонтрагентКонтрагент.Синоним);
	Список.Добавить(Регистры.ДвиженияНоменклатураДоходыРасходы.Имя, Регистры.ДвиженияНоменклатураДоходыРасходы.Синоним);
	Список.Добавить(Регистры.ДвиженияНоменклатураНоменклатура.Имя, Регистры.ДвиженияНоменклатураНоменклатура.Синоним);
	Список.Добавить(Регистры.Закупки.Имя, Регистры.Закупки.Синоним);
	Список.Добавить(Регистры.НДСЗаписиКнигиПокупок.Имя, Регистры.НДСЗаписиКнигиПокупок.Синоним);
	Список.Добавить(Регистры.НДСЗаписиКнигиПродаж.Имя, Регистры.НДСЗаписиКнигиПродаж.Синоним);
	Список.Добавить(Регистры.ПрочиеРасходы.Имя, Регистры.ПрочиеРасходы.Синоним);
	Список.Добавить(Регистры.РасчетыСКлиентамиПоДокументам.Имя, Регистры.РасчетыСКлиентамиПоДокументам.Синоним);
	Список.Добавить(Регистры.РасчетыСПоставщикамиПоДокументам.Имя, Регистры.РасчетыСПоставщикамиПоДокументам.Синоним);
	
	Возврат Список;
	
КонецФункции

#КонецОбласти 

#КонецОбласти


