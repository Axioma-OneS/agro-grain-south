﻿////////////////////////////////////////////////////////////////////////////////
// Содержит процедуры для работы с регистром сведений Допустимые цели ВЕТИС.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ОбновлениеИнформационнойБазы

// Заполняет данные в регистре "Виды продукции по группам приказа ВЕТИС
//
Процедура ЗаполнитьДанныеВРегистреВидыПродукцииПоГруппамПриказаВЕТИС() Экспорт
	
	ГруппыПродукцииУполномоченныхЛиц         = ГруппыПродукцииУполномоченныхЛиц();
	ГруппыПродукцииАттестованныхСпециалистов = ГруппыПродукцииАттестованныхСпециалистов();
	
	ТаблицаПереченьУполномоченныхЛиц         = ПереченьПродукцииУполномоченныхЛиц(ГруппыПродукцииУполномоченныхЛиц);
	ТаблицаПереченьАттестованныхСпециалистов = ПереченьПродукцииАттестованныхСпециалистов(ГруппыПродукцииАттестованныхСпециалистов);
	
	ЗаполнитьВидыПродукцииПоГруппамПриказаВЕТИС(ТаблицаПереченьУполномоченныхЛиц,
		Перечисления.РолиПользователейВЕТИС.УполномоченноеЛицо);
		
	ЗаполнитьВидыПродукцииПоГруппамПриказаВЕТИС(ТаблицаПереченьАттестованныхСпециалистов,
		Перечисления.РолиПользователейВЕТИС.АттестованныйСпециалист);
	
КонецПроцедуры

// Заполняет данные в регистре "Допустимые цели по группам приказа ВЕТИС
//
Процедура ЗаполнитьДанныеВРегистреДопустимыеЦелиПоГруппамПриказаВЕТИС() Экспорт
	
	ГруппыПродукцииУполномоченныхЛиц         = ГруппыПродукцииУполномоченныхЛиц();
	ГруппыПродукцииАттестованныхСпециалистов = ГруппыПродукцииАттестованныхСпециалистов();
	
	ДеревоЦелейУполномоченныхЛиц         = ЦелиУполномоченныхЛиц(ГруппыПродукцииУполномоченныхЛиц);
	ДеревоЦелейАттестованныхСпециалистов = ЦелиАттестованныхСпециалистов(ГруппыПродукцииАттестованныхСпециалистов);
	
	ЗаполнитьДопустимыеЦелиПоГруппамПриказаВЕТИС(ДеревоЦелейУполномоченныхЛиц);
	ЗаполнитьДопустимыеЦелиПоГруппамПриказаВЕТИС(ДеревоЦелейАттестованныхСпециалистов);
	
КонецПроцедуры

#КонецОбласти

// Возвращает дерево значений со списком допустимых целей по каждой продукции
//
// Параметры:
//  МассивПродукции	 - Массив - Массив продукции документа
// 
// Возвращаемое значение:
//  ДеревоЗначений - дерево доступных целей с группировкой по продукции
//
Функция ДопустимыеЦелиПоПродукциям(МассивПродукции) Экспорт
	
	ТекстЗапроса = ПользователиВЕТИС.ТекстЗапросаРолейПользователя() +
	"
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ПродукцияВЕТИС.Ссылка КАК Продукция,
	|	ЦелиВЕТИС.Ссылка КАК Цель,
	|	ЦелиВЕТИС.ДляНекачественныхГрузов КАК НизкокачественнаяПродукция
	|ИЗ
	|	РегистрСведений.ДопустимыеЦелиПоГруппамВЕТИС КАК ДопустимыеЦелиПоГруппамПриказаВЕТИС
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ВидыПродукцииПоГруппамВЕТИС КАК ВидыПродукцииПоГруппамПриказаВЕТИС
	|		ПО ВидыПродукцииПоГруппамПриказаВЕТИС.ГруппаПриказа = ДопустимыеЦелиПоГруппамПриказаВЕТИС.ГруппаПриказа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПродукцияВЕТИС КАК ПродукцияВЕТИС
	|		ПО ПродукцияВЕТИС.Родитель.Идентификатор = ВидыПродукцииПоГруппамПриказаВЕТИС.ВидПродукцииИдентификатор
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТРолиПользователяВЕТИС КАК РолиПользователяВЕТИС
	|		ПО РолиПользователяВЕТИС.РольПользователя = ВидыПродукцииПоГруппамПриказаВЕТИС.РольПользователя
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЦелиВЕТИС КАК ЦелиВЕТИС
	|		ПО ДопустимыеЦелиПоГруппамПриказаВЕТИС.ЦельИдентификатор = ЦелиВЕТИС.Идентификатор
	|ГДЕ
	|	ПродукцияВЕТИС.Ссылка В(&МассивПродукции)
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПродукцияВЕТИС.Ссылка КАК Продукция,
	|	ЦелиВЕТИС.Ссылка КАК Цель,
	|	ЦелиВЕТИС.ДляНекачественныхГрузов КАК НизкокачественнаяПродукция
	|ИЗ
	|	Справочник.ПродукцияВЕТИС КАК ПродукцияВЕТИС
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТРолиПользователяВЕТИС КАК РолиПользователяВЕТИС
	|		ПО ИСТИНА
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЦелиВЕТИС КАК ЦелиВЕТИС
	|		ПО ИСТИНА
	|ГДЕ
	|	РолиПользователяВЕТИС.РольПользователя = ЗНАЧЕНИЕ(Перечисление.РолиПользователейВЕТИС.ГосударственныйВетеринарныйВрач)
	|	И ПродукцияВЕТИС.Ссылка В(&МассивПродукции)
	|
	|	ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПродукцияВЕТИС.Ссылка,
	|	ЦелиВЕТИС.Ссылка,
	|	ИСТИНА
	|ИЗ
	|	Справочник.ПродукцияВЕТИС КАК ПродукцияВЕТИС
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЦелиВЕТИС КАК ЦелиВЕТИС
	|		ПО (ИСТИНА)
	|ГДЕ
	|	ПродукцияВЕТИС.Ссылка В (&МассивПродукции)
	|	И ЦелиВЕТИС.Идентификатор В (&ИдентификаторыНизкокачественнойПродукции)
	|
	|ИТОГИ ПО
	|	Продукция";
	
	ИдентификаторыНизкокачественнойПродукции = Новый Массив;
	ИдентификаторыНизкокачественнойПродукции.Добавить("8670b7f0-5274-4d68-02a1-30262a34402f");// утилизация.
	ИдентификаторыНизкокачественнойПродукции.Добавить("5b90d858-e089-11e1-bcf3-b499babae7ea"); // переработка.
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("МассивПродукции",                          МассивПродукции);
	Запрос.УстановитьПараметр("Пользователь",                             Пользователи.ТекущийПользователь());
	Запрос.УстановитьПараметр("ИдентификаторыНизкокачественнойПродукции", ИдентификаторыНизкокачественнойПродукции);
	
	Результат = Запрос.Выполнить();
	Возврат Результат.Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкам);
	
КонецФункции

// Возвращает пересечение множеств допустимых целей по каждой продукции
//
// Параметры:
//  МассивПродукции	 - Массив - Массив продукции документа.
// 
// Возвращаемое значение:
//  Массив - массив допустимых целей.
//
Функция ПересечениеДопустимыхЦелейПоПродукциям(МассивПродукции, НизкокачественнаяПродукция) Экспорт
	
	Если НизкокачественнаяПродукция Тогда
		
		ИдентификаторыНизкокачественнойПродукции = Новый Массив;
		ИдентификаторыНизкокачественнойПродукции.Добавить("8670b7f0-5274-4d68-02a1-30262a34402f");// утилизация.
		ИдентификаторыНизкокачественнойПродукции.Добавить("5b90d858-e089-11e1-bcf3-b499babae7ea"); // переработка.
		
		Возврат ИдентификаторыНизкокачественнойПродукции;
		
	Иначе
		
		МассивУникальнойПродукции = Новый Массив;
		Для Каждого Продукция Из МассивПродукции Цикл
			Если МассивУникальнойПродукции.Найти(Продукция) = Неопределено Тогда 
				МассивУникальнойПродукции.Добавить(Продукция);
			КонецЕсли;
		КонецЦикла;
		
		ТекстЗапроса = ПользователиВЕТИС.ТекстЗапросаРолейПользователя() + 
		"
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	ДопустимыеЦелиПоГруппамПриказаВЕТИС.ЦельИдентификатор КАК Цель,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ПродукцияВЕТИС.Ссылка)           КАК КоличествоПродукции
		|ПОМЕСТИТЬ ВТ_Итоговая
		|ИЗ
		|	РегистрСведений.ДопустимыеЦелиПоГруппамВЕТИС КАК ДопустимыеЦелиПоГруппамПриказаВЕТИС
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ВидыПродукцииПоГруппамВЕТИС КАК ВидыПродукцииПоГруппамПриказаВЕТИС
		|		ПО (ВидыПродукцииПоГруппамПриказаВЕТИС.ГруппаПриказа = ДопустимыеЦелиПоГруппамПриказаВЕТИС.ГруппаПриказа)
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТРолиПользователяВЕТИС КАК РолиПользователяВЕТИС
		|		ПО (РолиПользователяВЕТИС.РольПользователя = ВидыПродукцииПоГруппамПриказаВЕТИС.РольПользователя)
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПродукцияВЕТИС КАК ПродукцияВЕТИС
		|		ПО (ПродукцияВЕТИС.Родитель.Идентификатор = ВидыПродукцииПоГруппамПриказаВЕТИС.ВидПродукцииИдентификатор)
		|ГДЕ
		|	ПродукцияВЕТИС.Ссылка В(&МассивПродукции)
		|
		|СГРУППИРОВАТЬ ПО
		|	ДопустимыеЦелиПоГруппамПриказаВЕТИС.ЦельИдентификатор
		|
		|ОБЪЕДИНИТЬ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ЦелиВЕТИС.Идентификатор,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ПродукцияВЕТИС.Ссылка)
		|ИЗ
		|	Справочник.ПродукцияВЕТИС КАК ПродукцияВЕТИС
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТРолиПользователяВЕТИС КАК РолиПользователяВЕТИС
		|		ПО (ИСТИНА)
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЦелиВЕТИС КАК ЦелиВЕТИС
		|		ПО (ИСТИНА)
		|ГДЕ
		|	РолиПользователяВЕТИС.РольПользователя = ЗНАЧЕНИЕ(Перечисление.РолиПользователейВЕТИС.ГосударственныйВетеринарныйВрач)
		|	И ПродукцияВЕТИС.Ссылка В(&МассивПродукции)
		|
		|СГРУППИРОВАТЬ ПО
		|	ЦелиВЕТИС.Идентификатор
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_Итоговая.Цель КАК Цель
		|ИЗ
		|	ВТ_Итоговая КАК ВТ_Итоговая
		|ГДЕ
		|	ВТ_Итоговая.КоличествоПродукции = &КоличествоПродукции";
		
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("МассивПродукции",     МассивУникальнойПродукции);
		Запрос.УстановитьПараметр("КоличествоПродукции", МассивУникальнойПродукции.Количество());
		Запрос.УстановитьПараметр("Пользователь",        Пользователи.ТекущийПользователь());
		
		Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Цель");
		
	КонецЕсли;
	
КонецФункции

// Возвращает массив допустимых целей по единственной переданной продукции
//
// Параметры:
//   Продукция - СправочникСсылка.ПродукцияВЕТИС - продукция, по которой необходимо получить цели
//   ДеревоКэш - ДеревоЗначений, Неопределено - дерево с кэшем полученных ранее целей
//   НизкокачественнаяПродукция - Булево, Неопределено - отбор по качеству продукции
//
// Возвращаемое значение:
//  Массив - массив допустимых целей
//
Функция ДопустимыеЦелиПоПродукции(Продукция, ДеревоКэш, НизкокачественнаяПродукция = Неопределено) Экспорт
	
	Если ДеревоКэш = Неопределено Тогда
		ДеревоКэш = Новый ДеревоЗначений;
	КонецЕсли;
	
	Если ДеревоКэш.Строки.Количество() = 0 Тогда
		
		ДеревоКэш = ДопустимыеЦелиПоПродукциям(Продукция);
		Возврат ПолучитьДопустимыеЦелиИзКэша(Продукция, ДеревоКэш, НизкокачественнаяПродукция);
		
	КонецЕсли;
	
	НайденнаяСтрока = ДеревоКэш.Строки.Найти(Продукция, "Продукция");
	Если ЗначениеЗаполнено(НайденнаяСтрока) Тогда
		
		Возврат ПолучитьДопустимыеЦелиИзКэша(Продукция, ДеревоКэш, НизкокачественнаяПродукция);
		
	Иначе
		
		ДеревоЦелей = ДопустимыеЦелиПоПродукциям(Продукция);
		МассивЦелей = ПолучитьДопустимыеЦелиИзКэша(Продукция, ДеревоЦелей, НизкокачественнаяПродукция);
		
		ДобавитьВКэш = ДеревоЦелей.Строки.Получить(0);
		
		ДобавляемаяСтрока = ДеревоКэш.Строки.Добавить();
		ДобавляемаяСтрока.Продукция = Продукция;
		Для каждого ДобавитьВКэшСтрокаСЦелью Из ДобавитьВКэш.Строки Цикл
			СтрокаЦели = ДобавляемаяСтрока.Строки.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаЦели, ДобавитьВКэшСтрокаСЦелью, "Цель, НизкокачественнаяПродукция");
			СтрокаЦели.Продукция = Продукция;
		КонецЦикла;
		
		Возврат МассивЦелей;
		
	КонецЕсли;
	
КонецФункции

// Контролирует корректность указания целей в табличной части
//
// Параметры:
//  Объект	 - ДокументОбъект.* - проверяемый документ
//  Отказ	 - Булево - отказ проверки
//
Процедура ПроконтролироватьКорректностьУказанияЦелей(Объект, Отказ) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	ПользователиВЕТИС.НеКонтролироватьДоступныеЦели КАК НеКонтролироватьДоступныеЦели
	|ИЗ
	|	Справочник.ПользователиВЕТИС КАК ПользователиВЕТИС
	|ГДЕ
	|	ПользователиВЕТИС.Пользователь = &Пользователь";
	
	Запрос.УстановитьПараметр("Пользователь", Пользователи.ТекущийПользователь());
	Выборка = Запрос.Выполнить().Выбрать();
	
	НеКонтролироватьДоступныеЦели = Ложь;
	Если Выборка.Следующий() Тогда
		НеКонтролироватьДоступныеЦели = Выборка.НеКонтролироватьДоступныеЦели;
	КонецЕсли;
	
	Если НеКонтролироватьДоступныеЦели Тогда
		Возврат
	КонецЕсли;
	
	ДеревоДопустимыхЦелей = ДопустимыеЦелиПоПродукциям(Объект.Товары.ВыгрузитьКолонку("Продукция"));
	
	Для каждого СтрокаПродукция Из Объект.Товары Цикл
		
		Если ЗначениеЗаполнено(СтрокаПродукция.Цель) Тогда
			НайденнаяСтрока = ДеревоДопустимыхЦелей.Строки.Найти(СтрокаПродукция.Продукция, "Продукция");
			Если ЗначениеЗаполнено(НайденнаяСтрока) Тогда
				НайденнаяЦель = НайденнаяСтрока.Строки.Найти(СтрокаПродукция.Цель, "Цель");
				Если НЕ ЗначениеЗаполнено(НайденнаяЦель) Тогда
					
					ТекстОшибки = НСтр("ru='Указанная цель ""%Цель%"" не разрешена для продукции ""%Продукция%""'");
					ТекстОшибки = СтрЗаменить(ТекстОшибки,"%Цель%", СтрокаПродукция.Цель);
					ТекстОшибки = СтрЗаменить(ТекстОшибки,"%Продукция%", СтрокаПродукция.Продукция);
					
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
						ТекстОшибки,
						Объект,
						ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", СтрокаПродукция.НомерСтроки, "Цель"),
						,
						Отказ);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЦелиУполномоченныхЛиц(ГруппыПродукции)
	
	ДеревоЦелей = Новый ДеревоЗначений;
	ДеревоЦелей.Колонки.Добавить("ГруппаПриказа",     Новый ОписаниеТипов("ПеречислениеСсылка.ГруппыПродукцииУполномоченныхЛиц"));
	ДеревоЦелей.Колонки.Добавить("ЦельНаименование",  Метаданные.ОпределяемыеТипы.СтрокаВЕТИС.Тип);
	ДеревоЦелей.Колонки.Добавить("ЦельИдентификатор", Метаданные.ОпределяемыеТипы.СтрокаВЕТИС.Тип);
	
	Макет = Обработки.КлассификаторыВЕТИС.ПолучитьМакет("ЦелиУполномоченныхЛиц");
	КоличествоСтрок = Макет.ВысотаТаблицы;
	
	СтруктураПроверкиДублей = Новый Структура("ЦельНаименование, ЦельИдентификатор");
	ГруппаПриказа           = Неопределено;
	ТекущаяСтрокаГруппа     = Неопределено;
	
	Для НомерСтроки = 2 По КоличествоСтрок Цикл
		
		СтрГруппаПриказа = СокрЛП(Макет.Область(НомерСтроки, 1).Текст);
		СтруктураПроверкиДублей.ЦельНаименование  = СокрЛП(Макет.Область(НомерСтроки, 2).Текст);
		СтруктураПроверкиДублей.ЦельИдентификатор = СокрЛП(Макет.Область(НомерСтроки, 3).Текст);
		
		Если ГруппаПриказа <> СтрГруппаПриказа Тогда
			
			ГруппаПриказа   = СтрГруппаПриказа;
			ГруппаПродукции = ГруппыПродукции.Получить(ГруппаПриказа);
			
			Если ГруппаПродукции = Неопределено Тогда
				ВызватьИсключение НСтр("ru = 'Внутренняя ошибка'");
			КонецЕсли;
			
			ТекущаяСтрокаГруппа = ДеревоЦелей.Строки.Найти(ГруппаПродукции, "ГруппаПриказа", Ложь);
			Если ТекущаяСтрокаГруппа = Неопределено Тогда
				ТекущаяСтрокаГруппа = ДеревоЦелей.Строки.Добавить();
				ТекущаяСтрокаГруппа.ГруппаПриказа = ГруппаПродукции;
			КонецЕсли;
			
		КонецЕсли;
		
		Если ТекущаяСтрокаГруппа.Строки.НайтиСтроки(СтруктураПроверкиДублей).Количество() = 0 Тогда
			НоваяСтрока = ТекущаяСтрокаГруппа.Строки.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока,СтруктураПроверкиДублей);
			НоваяСтрока.ГруппаПриказа     = ТекущаяСтрокаГруппа.ГруппаПриказа;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ДеревоЦелей;
	
КонецФункции

Функция ЦелиАттестованныхСпециалистов(ГруппыПродукции)
	
	ДеревоЦелей = Новый ДеревоЗначений;
	ДеревоЦелей.Колонки.Добавить("ГруппаПриказа",     Новый ОписаниеТипов("ПеречислениеСсылка.ГруппыПродукцииАттестованныхСпециалистов"));
	ДеревоЦелей.Колонки.Добавить("ЦельНаименование",  Метаданные.ОпределяемыеТипы.СтрокаВЕТИС.Тип);
	ДеревоЦелей.Колонки.Добавить("ЦельИдентификатор", Метаданные.ОпределяемыеТипы.СтрокаВЕТИС.Тип);
	
	Макет = Обработки.КлассификаторыВЕТИС.ПолучитьМакет("ЦелиАттестованныхСпециалистов");
	КоличествоСтрок = Макет.ВысотаТаблицы;
	
	СтруктураПроверкиДублей = Новый Структура("ЦельНаименование, ЦельИдентификатор");
	ГруппаПриказа           = Неопределено;
	ТекущаяСтрокаГруппа     = Неопределено;
	
	Для НомерСтроки = 2 По КоличествоСтрок Цикл
		
		ЧастиСтрокиГруппыПриказа = СтрРазделить(Макет.Область(НомерСтроки, 1).Текст, ".");
		Если ЧастиСтрокиГруппыПриказа.Количество() = 1 Тогда
			СтрокаТипПродукции  = Неопределено;
			СтрокаГруппаПриказа = СокрЛП(ЧастиСтрокиГруппыПриказа[0]);
		Иначе
			СтрокаТипПродукции  = СокрЛП(ЧастиСтрокиГруппыПриказа[2]);
			СтрокаГруппаПриказа = СокрЛП(ЧастиСтрокиГруппыПриказа[1]);
		КонецЕсли;
		
		СтруктураПроверкиДублей.ЦельНаименование  = СокрЛП(Макет.Область(НомерСтроки, 2).Текст);
		СтруктураПроверкиДублей.ЦельИдентификатор = СокрЛП(Макет.Область(НомерСтроки, 3).Текст);
		
		Если ГруппаПриказа <> СтрокаГруппаПриказа Тогда
			
			ГруппаПриказа = СтрокаГруппаПриказа;
			
			ГруппаПродукции = ГруппыПродукции.Получить(ГруппаПриказа);
			Если ГруппаПродукции = Неопределено И СтрокаТипПродукции <> Неопределено Тогда
				ГруппаПродукции = ГруппыПродукции.Получить(СтрокаГруппаПриказа + " / " + СтрокаТипПродукции);
			КонецЕсли;
			
			Если ГруппаПродукции = Неопределено Тогда
				ВызватьИсключение НСтр("ru = 'Внутренняя ошибка'");
			КонецЕсли;
			
			ТекущаяСтрокаГруппа = ДеревоЦелей.Строки.Найти(ГруппаПродукции, "ГруппаПриказа", Ложь);
			Если ТекущаяСтрокаГруппа = Неопределено Тогда
				ТекущаяСтрокаГруппа = ДеревоЦелей.Строки.Добавить();
				ТекущаяСтрокаГруппа.ГруппаПриказа = ГруппаПродукции;
			КонецЕсли;
			
		КонецЕсли;
		
		Если ТекущаяСтрокаГруппа.Строки.НайтиСтроки(СтруктураПроверкиДублей).Количество() = 0 Тогда
			НоваяСтрока = ТекущаяСтрокаГруппа.Строки.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтруктураПроверкиДублей);
			НоваяСтрока.ГруппаПриказа = ТекущаяСтрокаГруппа.ГруппаПриказа;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ДеревоЦелей;
	
КонецФункции

Функция ПереченьПродукцииУполномоченныхЛиц(ГруппыПродукции)
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("ГруппаПриказа",             Новый ОписаниеТипов("ПеречислениеСсылка.ГруппыПродукцииУполномоченныхЛиц"));
	Таблица.Колонки.Добавить("ВидПродукцииИдентификатор", Метаданные.ОпределяемыеТипы.УникальныйИдентификаторИС.Тип);
	Таблица.Колонки.Добавить("ВидПродукцииНаименование",  Метаданные.ОпределяемыеТипы.СтрокаВЕТИС.Тип);
	
	Макет = Обработки.КлассификаторыВЕТИС.ПолучитьМакет("ПереченьПродукцииУполномоченныхЛиц");
	КоличествоСтрок = Макет.ВысотаТаблицы;
	
	ДобавленныеСтроки = Новый Соответствие;
	Для НомерСтроки = 2 По КоличествоСтрок Цикл
		
		ГруппаПриказаСтрока       = СокрЛП(Макет.Область(НомерСтроки, 1).Текст);
		ВидПродукцииИдентификатор = СокрЛП(Макет.Область(НомерСтроки, 9).Текст);
		ВидПродукцииНаименование  = СокрЛП(Макет.Область(НомерСтроки, 7).Текст);
		
		ЗаполненныеВиды = ДобавленныеСтроки.Получить(ГруппаПриказаСтрока);
		Если ЗаполненныеВиды = Неопределено Тогда
			ЗаполненныеВиды = Новый Соответствие;
			ДобавленныеСтроки.Вставить(ГруппаПриказаСтрока, ЗаполненныеВиды);
		КонецЕсли;
		
		СтрокаТаблицы = ЗаполненныеВиды.Получить(ВидПродукцииИдентификатор);
		Если СтрокаТаблицы <> Неопределено Тогда
			Если СтрНайти(СтрокаТаблицы.ВидПродукцииНаименование, ВидПродукцииНаименование) = 0 Тогда
				СтрокаТаблицы.ВидПродукцииНаименование = СтрокаТаблицы.ВидПродукцииНаименование + ", "+ ВидПродукцииНаименование;
			КонецЕсли;
			Продолжить;
		КонецЕсли;
		
		НоваяСтрока = Таблица.Добавить();
		
		ГруппаПриказа = ГруппыПродукции.Получить(ГруппаПриказаСтрока);
		
		Если Не ЗначениеЗаполнено(ГруппаПриказа) Тогда
			ВызватьИсключение НСтр("ru = 'Внутренняя ошибка поиска группы приказа'");
		КонецЕсли;
		
		НоваяСтрока.ГруппаПриказа             = ГруппаПриказа;
		НоваяСтрока.ВидПродукцииИдентификатор = ВидПродукцииИдентификатор;
		НоваяСтрока.ВидПродукцииНаименование  = ВидПродукцииНаименование;
		
		ЗаполненныеВиды.Вставить(ВидПродукцииИдентификатор, НоваяСтрока);
		
	КонецЦикла;
	
	Возврат Таблица;
	
КонецФункции

Функция ПереченьПродукцииАттестованныхСпециалистов(ГруппыПродукции)
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("ГруппаПриказа",             Новый ОписаниеТипов("ПеречислениеСсылка.ГруппыПродукцииАттестованныхСпециалистов"));
	Таблица.Колонки.Добавить("ВидПродукцииИдентификатор", Метаданные.ОпределяемыеТипы.УникальныйИдентификаторИС.Тип);
	Таблица.Колонки.Добавить("ВидПродукцииНаименование",  Метаданные.ОпределяемыеТипы.СтрокаВЕТИС.Тип);
	
	Макет = Обработки.КлассификаторыВЕТИС.ПолучитьМакет("ПереченьПродукцииАттестованныхСпециалистов");
	КоличествоСтрок = Макет.ВысотаТаблицы;
	
	ДобавленныеСтроки = Новый Соответствие;
	Для НомерСтроки = 2 По КоличествоСтрок Цикл
		
		ЧастиСтрокиГруппыПриказа = СтрРазделить(Макет.Область(НомерСтроки, 1).Текст, ".");
		Если ЧастиСтрокиГруппыПриказа.Количество() = 1 Тогда
			ТипПродукцииНаименование  = Неопределено;
			ГруппаПриказаСтрока       = ЧастиСтрокиГруппыПриказа[0];
		ИначеЕсли ЧастиСтрокиГруппыПриказа.Количество() = 2 Тогда
			ТипПродукцииНаименование = Неопределено;
			ГруппаПриказаСтрока      = СокрЛП(ЧастиСтрокиГруппыПриказа[1]);
		Иначе
			ТипПродукцииНаименование = СокрЛП(ЧастиСтрокиГруппыПриказа[2]);
			ГруппаПриказаСтрока      = СокрЛП(ЧастиСтрокиГруппыПриказа[1]);
		КонецЕсли;
		
		ГруппаПриказа = ГруппыПродукции.Получить(ГруппаПриказаСтрока);
		Если ГруппаПриказа = Неопределено Тогда
			СтрокаПоиска = ГруппаПриказаСтрока + " / " + ТипПродукцииНаименование;
			ГруппаПриказа = ГруппыПродукции.Получить(СтрокаПоиска);
			Если Не ЗначениеЗаполнено(ГруппаПриказа) Тогда
				ВызватьИсключение НСтр("ru = 'Внутренняя ошибка поиска группы приказа'");
			КонецЕсли;
		КонецЕсли;
		
		ЗаполненныеВиды = ДобавленныеСтроки.Получить(ГруппаПриказа);
		Если ЗаполненныеВиды = Неопределено Тогда
			ЗаполненныеВиды = Новый Соответствие;
			ДобавленныеСтроки.Вставить(ГруппаПриказа, ЗаполненныеВиды);
		КонецЕсли;
		
		ВидПродукцииИдентификатор = СокрЛП(Макет.Область(НомерСтроки, 9).Текст);
		ВидПродукцииНаименование  = СокрЛП(Макет.Область(НомерСтроки, 7).Текст);
		
		СтрокаТаблицы = ЗаполненныеВиды.Получить(ВидПродукцииИдентификатор);
		Если СтрокаТаблицы <> Неопределено Тогда
			Если СтрНайти(СтрокаТаблицы.ВидПродукцииНаименование, ВидПродукцииНаименование) = 0 Тогда
				СтрокаТаблицы.ВидПродукцииНаименование = СтрокаТаблицы.ВидПродукцииНаименование + ", "+ ВидПродукцииНаименование;
			КонецЕсли;
			Продолжить;
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(ГруппаПриказа) Тогда
			ВызватьИсключение НСтр("ru = 'Внутренняя ошибка поиска группы приказа'");
		КонецЕсли;
		
		НоваяСтрока = Таблица.Добавить();
		
		НоваяСтрока.ГруппаПриказа             = ГруппаПриказа;
		НоваяСтрока.ВидПродукцииИдентификатор = ВидПродукцииИдентификатор;
		НоваяСтрока.ВидПродукцииНаименование  = ВидПродукцииНаименование;
		
		ЗаполненныеВиды.Вставить(ВидПродукцииИдентификатор, НоваяСтрока);
		
	КонецЦикла;
	
	Возврат Таблица;
	
КонецФункции

Функция ГруппыПродукцииУполномоченныхЛиц()
	
	ГруппыПродукции = Новый Соответствие;
	
	Для каждого ПеречислениеСсылка Из Перечисления.ГруппыПродукцииУполномоченныхЛиц Цикл
		
		ГруппыПродукции.Вставить(Строка(ПеречислениеСсылка), ПеречислениеСсылка);
		
	КонецЦикла;
	
	Возврат ГруппыПродукции;
	
КонецФункции

Функция ГруппыПродукцииАттестованныхСпециалистов()
	
	ГруппыПродукции = Новый Соответствие;
	
	Для каждого ПеречислениеСсылка Из Перечисления.ГруппыПродукцииАттестованныхСпециалистов Цикл
		
		ГруппыПродукции.Вставить(Строка(ПеречислениеСсылка), ПеречислениеСсылка);
		
	КонецЦикла;
	
	Возврат ГруппыПродукции;
	
КонецФункции

Процедура ЗаполнитьВидыПродукцииПоГруппамПриказаВЕТИС(ТаблицаПеречень, РольПользователя)
	
	НаборЗаписей = РегистрыСведений.ВидыПродукцииПоГруппамВЕТИС.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.РольПользователя.Установить(РольПользователя);
	
	Для каждого СтрокаТаблицы Из ТаблицаПеречень Цикл
		
		НоваяЗапись = НаборЗаписей.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяЗапись, СтрокаТаблицы);
		НоваяЗапись.РольПользователя = РольПользователя;
		
	КонецЦикла;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры

Процедура ЗаполнитьДопустимыеЦелиПоГруппамПриказаВЕТИС(ДеревоЦелей)
	
	Для каждого СтрокаДерева Из ДеревоЦелей.Строки Цикл
		
		НаборЗаписей = РегистрыСведений.ДопустимыеЦелиПоГруппамВЕТИС.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ГруппаПриказа.Установить(СтрокаДерева.ГруппаПриказа);
		Для каждого СтрокаЦели Из СтрокаДерева.Строки Цикл
			
			НоваяЗапись = НаборЗаписей.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяЗапись,СтрокаЦели);
			
		КонецЦикла;
		
		НаборЗаписей.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

Функция ПолучитьДопустимыеЦелиИзКэша(Продукция, ДеревоКэш, НизкокачественнаяПродукция)
	
	СтрокаПродукции = ДеревоКэш.Строки.Найти(Продукция, "Продукция");
	
	Если СтрокаПродукции = Неопределено Тогда
		ДеревоКэш.Строки.Добавить().Продукция = Продукция;
		Возврат Новый Массив;
	КонецЕсли;
	
	Если НизкокачественнаяПродукция = Неопределено Тогда
		Возврат СтрокаПродукции.Строки.ВыгрузитьКолонку("Цель");
	Иначе
		РезультатСУчетомКачества = Новый Массив;
		Для Каждого СтрокаЦели Из СтрокаПродукции.Строки Цикл
			Если СтрокаЦели.НизкокачественнаяПродукция = НизкокачественнаяПродукция Тогда
				РезультатСУчетомКачества.Добавить(СтрокаЦели.Цель);
			КонецЕсли;
		КонецЦикла;
		Возврат РезультатСУчетомКачества;
	КонецЕсли;
	
КонецФункции


#КонецОбласти