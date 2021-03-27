﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ДляВсехСтрок(ЗначениеРазрешено(ЕстьNull(Товары.ВидЦены, Значение(Справочник.ВидыЦен.ПустаяСсылка))))";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет список команд создания на основании.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	Документы.ИзменениеАссортимента.ДобавитьКомандуСоздатьНаОснованииСоздатьЗаказНаВнутреннееПотребление(КомандыСозданияНаОсновании);
	
	Документы.ИзменениеАссортимента.ДобавитьКомандуСоздатьНаОснованииСоздатьЗаказНаПеремещение(КомандыСозданияНаОсновании);
	
	Обработки.НастройкаПоддержанияЗапасов.ДобавитьКомандуУстановитьПоддержаниеЗапасов(КомандыСозданияНаОсновании);
	
	Обработки.НастройкаПоддержанияЗапасов.ДобавитьКомандуНастройкаПоддержанияЗапасов(КомандыСозданияНаОсновании);
	
	Документы.ЗаказПоставщику.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
	Документы.УстановкаЦенНоменклатуры.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
	БизнесПроцессы.Задание.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
КонецПроцедуры

// Добавляет команду создания документа "Изменение ассортимента".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОснованииСоздатьЗаказНаВнутреннееПотребление(КомандыСозданияНаОсновании) Экспорт
	Если ПравоДоступа("Добавление", Метаданные.Документы.ЗаказНаВнутреннееПотребление) И ПолучитьФункциональнуюОпцию("ИспользоватьАссортимент") Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Обработчик = "СозданиеНаОснованииУТКлиент.СоздатьЗаказНаВнутреннееПотребление";
		КомандаСоздатьНаОсновании.Идентификатор = "СоздатьЗаказНаВнутреннееПотребление";
		КомандаСоздатьНаОсновании.Представление = НСтр("ru = 'Заказ на внутреннее потребление'");
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		КомандаСоздатьНаОсновании.ФункциональныеОпции = "ИспользоватьЗаказыНаВнутреннееПотребление";
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;
	
	Возврат Неопределено;
КонецФункции

// Добавляет команду создания документа "Изменение ассортимента".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОснованииСоздатьЗаказНаПеремещение(КомандыСозданияНаОсновании) Экспорт
	Если ПравоДоступа("Добавление", Метаданные.Документы.ЗаказНаПеремещение) И ПолучитьФункциональнуюОпцию("ИспользоватьАссортимент") Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Обработчик = "СозданиеНаОснованииУТКлиент.СоздатьЗаказНаПеремещение";
		КомандаСоздатьНаОсновании.Идентификатор = "СоздатьЗаказНаПеремещение";
		КомандаСоздатьНаОсновании.Представление = НСтр("ru = 'Заказ на перемещение'");
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		КомандаСоздатьНаОсновании.ФункциональныеОпции = "ИспользоватьЗаказыНаПеремещение";
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;
	
	Возврат Неопределено;
КонецФункции

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - Таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	ВариантыОтчетовУТПереопределяемый.ДобавитьКомандуСтруктураПодчиненности(КомандыОтчетов);
	
	
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// Интерфейс для работы с подсистемой Загрузка из файла.

// Устанавливает параметры загрузки.
//
Процедура УстановитьПараметрыЗагрузкиИзФайлаВТЧ(Параметры) Экспорт
	
КонецПроцедуры

// Производит сопоставление данных, загружаемых в табличную часть ПолноеИмяТабличнойЧасти,
// с данными в ИБ, и заполняет параметры АдресТаблицыСопоставления и СписокНеоднозначностей.
//
// Параметры:
//   ПолноеИмяТабличнойЧасти   - Строка - полное имя табличной части, в которую загружаются данные.
//   АдресЗагружаемыхДанных    - Строка - адрес временного хранилища с таблицей значений, в которой
//                                        находятся загруженные данные из файла. Состав колонок:
//     * Идентификатор - Число - порядковый номер строки;
//     * остальные колонки сооответствуют колонкам макета ЗагрузкаИзФайла.
//   АдресТаблицыСопоставления - Строка - адрес временного хранилища с пустой таблицей значений,
//                                        являющейся копией табличной части документа, 
//                                        которую необходимо заполнить из таблицы АдресЗагружаемыхДанных.
//   СписокНеоднозначностей - ТаблицаЗначений - список неоднозначных значений, для которых в ИБ имеется несколько
//     подходящих вариантов.
//     * Колонка       - Строка - имя колонки, в которой была обнаружена неоднозначность;
//     * Идентификатор - Число  - идентификатор строки, в которой была обнаружена неоднозначность.
//
Процедура СопоставитьЗагружаемыеДанные(АдресЗагружаемыхДанных, АдресТаблицыСопоставления, СписокНеоднозначностей, ПолноеИмяТабличнойЧасти, ДополнительныеПараметры) Экспорт
	
	Товары =  ПолучитьИзВременногоХранилища(АдресТаблицыСопоставления);
	ЗагружаемыеДанные = ПолучитьИзВременногоХранилища(АдресЗагружаемыхДанных);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.Штрихкод КАК СТРОКА(&ШтрихкодДлина)) КАК Штрихкод,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.Код КАК СТРОКА(&КодДлина)) КАК Код,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.Артикул КАК СТРОКА(&АртикулДлина)) КАК Артикул,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.Номенклатура КАК СТРОКА(&НоменклатураДлина)) КАК Номенклатура,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.ВидЦены КАК СТРОКА(&ВидыЦенДлина)) КАК ВидЦены,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.РейтингПродаж КАК СТРОКА(&РейтингПродажДлина)) КАК РейтингПродаж,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор
	|ПОМЕСТИТЬ ДанныеДляСопоставления
	|ИЗ
	|	&ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ШтрихкодыНоменклатуры.Номенклатура КАК НоменклатураСсылка,
	|	ШтрихкодыНоменклатуры.Штрихкод,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор
	|ПОМЕСТИТЬ СопоставленнаяНоменклатураПоШтрихкоду
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ШтрихкодыНоменклатуры КАК ШтрихкодыНоменклатуры
	|		ПО (ШтрихкодыНоменклатуры.Штрихкод = ДанныеДляСопоставления.Штрихкод)
	|ГДЕ
	|	НЕ ШтрихкодыНоменклатуры.Номенклатура ЕСТЬ NULL 
	|	И ВЫБОР
	|			КОГДА &ИспользоватьУправлениеКоллекциями
	|				ТОГДА ШтрихкодыНоменклатуры.Номенклатура.КоллекцияНоменклатуры = &КоллекцияНоменклатуры
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеДляСопоставления.Код,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор
	|ПОМЕСТИТЬ ДанныеДляСопоставленияПоКоду
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ СопоставленнаяНоменклатураПоШтрихкоду КАК СопоставленнаяНоменклатураПоШтрихкоду
	|		ПО (ДанныеДляСопоставления.Штрихкод = СопоставленнаяНоменклатураПоШтрихкоду.Штрихкод)
	|ГДЕ
	|	СопоставленнаяНоменклатураПоШтрихкоду.Штрихкод ЕСТЬ NULL 
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СпрНоменклатура.Ссылка КАК НоменклатураСсылка,
	|	СпрНоменклатура.Код,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор
	|ПОМЕСТИТЬ СопоставленнаяНоменклатураПоКоду
	|ИЗ
	|	ДанныеДляСопоставленияПоКоду КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СпрНоменклатура
	|		ПО (СпрНоменклатура.Код = ДанныеДляСопоставления.Код)
	|ГДЕ
	|	НЕ СпрНоменклатура.Ссылка ЕСТЬ NULL 
	|	И ВЫБОР
	|			КОГДА &ИспользоватьУправлениеКоллекциями
	|				ТОГДА СпрНоменклатура.КоллекцияНоменклатуры = &КоллекцияНоменклатуры
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеДляСопоставления.Номенклатура,
	|	ДанныеДляСопоставления.Идентификатор КАК Идентификатор
	|ПОМЕСТИТЬ ДанныеДляСопоставленияПоНаименованию
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ СопоставленнаяНоменклатураПоШтрихкоду КАК СопоставленнаяНоменклатураПоШтрихкоду
	|		ПО (ДанныеДляСопоставления.Штрихкод = СопоставленнаяНоменклатураПоШтрихкоду.Штрихкод)
	|		ЛЕВОЕ СОЕДИНЕНИЕ СопоставленнаяНоменклатураПоКоду КАК СопоставленнаяНоменклатураПоКоду
	|		ПО (ДанныеДляСопоставления.Код = СопоставленнаяНоменклатураПоКоду.Код)
	|ГДЕ
	|	СопоставленнаяНоменклатураПоШтрихкоду.Штрихкод ЕСТЬ NULL 
	|	И СопоставленнаяНоменклатураПоКоду.Код ЕСТЬ NULL 
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(СпрНоменклатура.Ссылка) КАК НоменклатураСсылка,
	|	ДанныеДляСопоставленияПоНаименованию.Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставленияПоНаименованию.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставленияПоНаименованию КАК ДанныеДляСопоставленияПоНаименованию
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СпрНоменклатура
	|		ПО (СпрНоменклатура.Наименование = ДанныеДляСопоставленияПоНаименованию.Номенклатура)
	|ГДЕ
	|	НЕ СпрНоменклатура.Ссылка ЕСТЬ NULL 
	|	И ВЫБОР
	|			КОГДА &ИспользоватьУправлениеКоллекциями
	|				ТОГДА СпрНоменклатура.КоллекцияНоменклатуры = &КоллекцияНоменклатуры
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставленияПоНаименованию.Идентификатор
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	МАКСИМУМ(СопоставленнаяНоменклатураПоШтрихкоду.НоменклатураСсылка),
	|	СопоставленнаяНоменклатураПоШтрихкоду.Идентификатор,
	|	КОЛИЧЕСТВО(СопоставленнаяНоменклатураПоШтрихкоду.Идентификатор)
	|ИЗ
	|	СопоставленнаяНоменклатураПоШтрихкоду КАК СопоставленнаяНоменклатураПоШтрихкоду
	|
	|СГРУППИРОВАТЬ ПО
	|	СопоставленнаяНоменклатураПоШтрихкоду.Идентификатор
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	МАКСИМУМ(СопоставленнаяНоменклатураПоКоду.НоменклатураСсылка),
	|	СопоставленнаяНоменклатураПоКоду.Идентификатор,
	|	КОЛИЧЕСТВО(СопоставленнаяНоменклатураПоКоду.Идентификатор)
	|ИЗ
	|	СопоставленнаяНоменклатураПоКоду КАК СопоставленнаяНоменклатураПоКоду
	|
	|СГРУППИРОВАТЬ ПО
	|	СопоставленнаяНоменклатураПоКоду.Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ВидыЦен.Ссылка) КАК ВидЦеныСсылка,
	|	ДанныеДляСопоставления.Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВидыЦен КАК ВидыЦен
	|		ПО (ВидыЦен.ИспользоватьПриПродаже)
	|			И (ВидыЦен.Наименование = ДанныеДляСопоставления.ВидЦены)
	|ГДЕ
	|	НЕ ВидыЦен.Ссылка ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставления.Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(РейтингиПродажНоменклатуры.Ссылка) КАК РейтингПродажСсылка,
	|	ДанныеДляСопоставления.Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.РейтингиПродажНоменклатуры КАК РейтингиПродажНоменклатуры
	|		ПО (РейтингиПродажНоменклатуры.Наименование = ДанныеДляСопоставления.РейтингПродаж)
	|ГДЕ
	|	НЕ РейтингиПродажНоменклатуры.Ссылка ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставления.Идентификатор";
	
	ШтрихкодДлина = Метаданные.РегистрыСведений.ШтрихкодыНоменклатуры.Измерения.Найти("Штрихкод").Тип.КвалификаторыСтроки.Длина;
	МетаданныеНоменклатура = Метаданные.Справочники.Номенклатура;
	КодДлина = МетаданныеНоменклатура.ДлинаКода;
	АртикулДлина = МетаданныеНоменклатура.Реквизиты.Найти("Артикул").Тип.КвалификаторыСтроки.Длина;
	НоменклатураДлина = МетаданныеНоменклатура.ДлинаНаименования;
	ВидыЦенДлина = Метаданные.Справочники.ВидыЦен.ДлинаНаименования;
	РейтингПродажДлина = Метаданные.Справочники.РейтингиПродажНоменклатуры.ДлинаНаименования;
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ШтрихкодДлина", ШтрихкодДлина);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&КодДлина", КодДлина);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&АртикулДлина", АртикулДлина);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&НоменклатураДлина", НоменклатураДлина);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ВидыЦенДлина", ВидыЦенДлина);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&РейтингПродажДлина", РейтингПродажДлина);
	
	Если ЗагружаемыеДанные.Колонки.Найти("ВидЦены") = Неопределено 
		ИЛИ ЗагружаемыеДанные.Колонки.Найти("РейтингПродаж") = Неопределено Тогда
	
		ДанныеДляСопоставления = ЗагружаемыеДанные.Скопировать();
		Если ЗагружаемыеДанные.Колонки.Найти("ВидЦены") = Неопределено Тогда
			ДанныеДляСопоставления.Колонки.Добавить("ВидЦены", Новый ОписаниеТипов("Строка"));
		КонецЕсли;
		
		Если ЗагружаемыеДанные.Колонки.Найти("РейтингПродаж") = Неопределено Тогда
			ДанныеДляСопоставления.Колонки.Добавить("РейтингПродаж", Новый ОписаниеТипов("Строка")); 
		КонецЕсли;
	Иначе
		ДанныеДляСопоставления = ЗагружаемыеДанные;
	КонецЕсли; 
	
	Запрос.УстановитьПараметр("ДанныеДляСопоставления", ДанныеДляСопоставления);
	Запрос.УстановитьПараметр("ИспользоватьУправлениеКоллекциями", ПолучитьФункциональнуюОпцию("ИспользоватьУправлениеКоллекциями"));
	Запрос.УстановитьПараметр("КоллекцияНоменклатуры", ДополнительныеПараметры.КоллекцияНоменклатуры);
	
	РезультатыЗапросов = Запрос.ВыполнитьПакет();
	
	ТаблицаНоменклатура = РезультатыЗапросов[5].Выгрузить();
	ТаблицаВидыЦен = РезультатыЗапросов[6].Выгрузить();
	ТаблицаРейтингиПродаж = РезультатыЗапросов[7].Выгрузить();
	
	РолиАссортимента = Новый Соответствие;
	РолиАссортимента.Вставить(НСтр("ru = 'Постоянный ассортимент'"), Перечисления.РолиАссортимента.ПостоянныйАссортимент);
	РолиАссортимента.Вставить("ПостоянныйАссортимент", Перечисления.РолиАссортимента.ПостоянныйАссортимент);
	РолиАссортимента.Вставить(НСтр("ru = 'Дополнительный ассортимент'"), Перечисления.РолиАссортимента.ДополнительныйАссортимент);
	РолиАссортимента.Вставить("ДополнительныйАссортимент", Перечисления.РолиАссортимента.ДополнительныйАссортимент);
	РолиАссортимента.Вставить(НСтр("ru = 'Пробный ассортимент'"), Перечисления.РолиАссортимента.ПробныйАссортимент);
	РолиАссортимента.Вставить("ПробныйАссортимент", Перечисления.РолиАссортимента.ПробныйАссортимент);
	
	ИспользоватьНесколькоВидовЦен = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВидовЦен");
	
	Для каждого СтрокаТаблицы Из ЗагружаемыеДанные Цикл 
		
		НоваяСтрока = Товары.Добавить();
		НоваяСтрока.Идентификатор = СтрокаТаблицы.Идентификатор;
		НоваяСтрока.РольАссортимента = РолиАссортимента.Получить(СокрЛП(СтрокаТаблицы.РольАссортимента));
		
		СтрокаНоменклатура = ТаблицаНоменклатура.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаНоменклатура <> Неопределено Тогда 
			Если СтрокаНоменклатура.Количество = 1 Тогда 
				НоваяСтрока.Номенклатура  = СтрокаНоменклатура.НоменклатураСсылка;
			ИначеЕсли СтрокаНоменклатура.Количество > 1 Тогда 
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "Номенклатура";
			КонецЕсли;
		КонецЕсли;
		
		Если ИспользоватьНесколькоВидовЦен Тогда
			
			СтрокаВидаЦен = ТаблицаВидыЦен.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
			Если СтрокаВидаЦен <> Неопределено Тогда 
				Если СтрокаВидаЦен.Количество = 1 Тогда 
					НоваяСтрока.ВидЦены  = СтрокаВидаЦен.ВидЦеныСсылка;
				ИначеЕсли СтрокаВидаЦен.Количество > 1 Тогда 
					ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
					ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
					ЗаписьОНеоднозначности.Колонка = "ВидЦены";
				КонецЕсли;
			КонецЕсли;
		
		КонецЕсли; 
		
		СтрокаРейтингПродаж = ТаблицаРейтингиПродаж.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаРейтингПродаж <> Неопределено Тогда 
			Если СтрокаРейтингПродаж.Количество = 1 Тогда 
				НоваяСтрока.РейтингПродаж  = СтрокаРейтингПродаж.РейтингПродажСсылка;
			ИначеЕсли СтрокаРейтингПродаж.Количество > 1 Тогда 
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "РейтингПродаж";
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	ПоместитьВоВременноеХранилище(Товары, АдресТаблицыСопоставления);
	
КонецПроцедуры

// Возврашает список подходящих объектов ИБ для неоднозначного значения ячейки.
// 
// Параметры:
//   ПолноеИмяТабличнойЧасти  - Строка - полное имя табличной части, в которую загружаются данные.
//  ИмяКолонки                - Строка - имя колонки, в который возника неоднозначность 
//  СписокНеоднозначностей    - ТаблицаЗначений - Список для заполения с неоднозначными данными
//     * Идентификатор        - Число  - Уникальный идентификатор строки
//     * Колонка              - Строка -  Имя колонки с возникшей неоднозначностью 
//  ЗагружаемыеЗначенияСтрока - Строка - Загружаемые данные на основании которых возникла неоднозначность.
//
Процедура ЗаполнитьСписокНеоднозначностей(ПолноеИмяТабличнойЧасти, СписокНеоднозначностей, ИмяКолонки, ЗагружаемыеЗначенияСтрока, ДополнительныеПараметры) Экспорт 
	
	Если ИмяКолонки = "Номенклатура" Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Наименование = &Наименование";
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.Номенклатура);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);  
		КонецЦикла;
	КонецЕсли;
	
	Если ИмяКолонки = "РейтингПродаж" Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	РейтингиПродаж.Ссылка
		|ИЗ
		|	Справочник.РейтингиПродажНоменклатуры КАК РейтингиПродаж
		|ГДЕ
		|	РейтингиПродаж.Наименование = &Наименование";
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.РейтингПродаж);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);  
		КонецЦикла;
	КонецЕсли;
	
	Если ИмяКолонки = "ВидЦены" Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВидыЦен.Ссылка
		|ИЗ
		|	Справочник.ВидыЦен КАК ВидыЦен
		|ГДЕ
		|	ВидыЦен.Наименование = &Наименование
		|	И ВидыЦен.ИспользоватьПриПродаже";
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.ВидЦены);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);  
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#Область Проведение

// Инициализирует таблицы значений, содержащие данные табличных частей документа.
// Таблицы значений сохраняет в свойствах структуры "ДополнительныеСвойства".

Функция ДополнительныеИсточникиДанныхДляДвижений(ИмяРегистра) Экспорт

	ИсточникиДанных = Новый Соответствие;

	Возврат ИсточникиДанных; 

КонецФункции

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
КонецПроцедуры

Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	////////////////////////////////////////////////////////////////////////////
	// Создадим запрос инициализации движений
	
	Запрос = Новый Запрос;
	ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка);
	
	////////////////////////////////////////////////////////////////////////////
	// Сформируем текст запроса
	ТекстыЗапроса = Новый СписокЗначений;
	ТекстЗапросаТаблицаАссортимент(Запрос, ТекстыЗапроса, Регистры);
	
	ПроведениеСерверУТ.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений, Истина);
	
КонецПроцедуры

Функция ТекстЗапросаТаблицаАссортимент(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "Ассортимент";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	Товары.Ссылка.Дата КАК Период,
	|	Товары.Номенклатура КАК Номенклатура,
	|	Товары.Ссылка.ОбъектПланирования КАК ОбъектПланирования,
	|	Товары.РольАссортимента КАК РольАссортимента,
	|	ВЫБОР
	|		КОГДА Товары.Ссылка.Стадия = ЗНАЧЕНИЕ(Перечисление.СтадииАссортимента.РазрешеныТолькоЗакупки)
	|			ТОГДА ИСТИНА
	|		КОГДА Товары.Ссылка.Стадия = ЗНАЧЕНИЕ(Перечисление.СтадииАссортимента.РазрешеныЗакупкиИПродажи)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК РазрешеныЗакупки,
	|	ВЫБОР
	|		КОГДА Товары.Ссылка.Стадия = ЗНАЧЕНИЕ(Перечисление.СтадииАссортимента.РазрешеныТолькоПродажи)
	|			ТОГДА ИСТИНА
	|		КОГДА Товары.Ссылка.Стадия = ЗНАЧЕНИЕ(Перечисление.СтадииАссортимента.РазрешеныЗакупкиИПродажи)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК РазрешеныПродажи,
	|	Товары.ВидЦены КАК ВидЦены,
	|	Товары.РейтингПродаж КАК РейтингПродаж,
	|	Товары.Ссылка.КоллекцияНоменклатуры КАК КоллекцияНоменклатуры
	|ИЗ
	|	Документ.ИзменениеАссортимента.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка = &Ссылка
	|	И Товары.Ссылка.Операция = ЗНАЧЕНИЕ(Перечисление.ОперацииИзмененияАссортимента.ИзменениеВАссортименте)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Товары.Ссылка.ДатаНачалаЗакупок,
	|	Товары.Номенклатура,
	|	Товары.Ссылка.ОбъектПланирования,
	|	Товары.РольАссортимента,
	|	ИСТИНА,
	|	ВЫБОР
	|		КОГДА Товары.Ссылка.ДатаНачалаЗакупок = Товары.Ссылка.ДатаНачалаПродаж
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ,
	|	Товары.ВидЦены,
	|	Товары.РейтингПродаж КАК РейтингПродаж,
	|	Товары.Ссылка.КоллекцияНоменклатуры
	|ИЗ
	|	Документ.ИзменениеАссортимента.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка = &Ссылка
	|	И Товары.Ссылка.Операция = ЗНАЧЕНИЕ(Перечисление.ОперацииИзмененияАссортимента.УправлениеКоллекцией)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Товары.Ссылка.ДатаНачалаПродаж,
	|	Товары.Номенклатура,
	|	Товары.Ссылка.ОбъектПланирования,
	|	Товары.РольАссортимента,
	|	ВЫБОР
	|		КОГДА Товары.Ссылка.ДатаЗапретаЗакупки > Товары.Ссылка.ДатаНачалаПродаж
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ,
	|	ИСТИНА,
	|	Товары.ВидЦены,
	|	Товары.РейтингПродаж КАК РейтингПродаж,
	|	Товары.Ссылка.КоллекцияНоменклатуры
	|ИЗ
	|	Документ.ИзменениеАссортимента.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка = &Ссылка
	|	И Товары.Ссылка.Операция = ЗНАЧЕНИЕ(Перечисление.ОперацииИзмененияАссортимента.УправлениеКоллекцией)
	|	И Товары.Ссылка.ДатаНачалаЗакупок <> Товары.Ссылка.ДатаНачалаПродаж
	|			И Товары.Ссылка.ДатаЗапретаЗакупки <> Товары.Ссылка.ДатаНачалаПродаж
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Товары.Ссылка.ДатаЗапретаЗакупки,
	|	Товары.Номенклатура,
	|	Товары.Ссылка.ОбъектПланирования,
	|	Товары.РольАссортимента,
	|	ЛОЖЬ,
	|	ВЫБОР
	|		КОГДА Товары.Ссылка.ДатаЗапретаЗакупки < Товары.Ссылка.ДатаЗапретаПродажи
	|				И Товары.Ссылка.ДатаЗапретаЗакупки >= Товары.Ссылка.ДатаНачалаПродаж
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ,
	|	Товары.ВидЦены,
	|	Товары.РейтингПродаж КАК РейтингПродаж,
	|	Товары.Ссылка.КоллекцияНоменклатуры
	|ИЗ
	|	Документ.ИзменениеАссортимента.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка = &Ссылка
	|	И Товары.Ссылка.Операция = ЗНАЧЕНИЕ(Перечисление.ОперацииИзмененияАссортимента.УправлениеКоллекцией)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Товары.Ссылка.ДатаЗапретаПродажи,
	|	Товары.Номенклатура,
	|	Товары.Ссылка.ОбъектПланирования,
	|	Товары.РольАссортимента,
	|	ВЫБОР
	|		КОГДА Товары.Ссылка.ДатаЗапретаЗакупки > Товары.Ссылка.ДатаЗапретаПродажи
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ,
	|	ЛОЖЬ,
	|	Товары.ВидЦены,
	|	Товары.РейтингПродаж КАК РейтингПродаж,
	|	Товары.Ссылка.КоллекцияНоменклатуры
	|ИЗ
	|	Документ.ИзменениеАссортимента.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка = &Ссылка
	|	И Товары.Ссылка.Операция = ЗНАЧЕНИЕ(Перечисление.ОперацииИзмененияАссортимента.УправлениеКоллекцией)
	|	И Товары.Ссылка.ДатаЗапретаЗакупки <> Товары.Ссылка.ДатаЗапретаПродажи
	|
	|УПОРЯДОЧИТЬ ПО
	|	Период,
	|	Номенклатура,
	|	ОбъектПланирования";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

// Добавляет команду создания документа "Изменение ассортимента".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	Если ПравоДоступа("Добавление", Метаданные.Документы.ИзменениеАссортимента) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.ИзменениеАссортимента.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = ОбщегоНазначенияУТ.ПредставлениеОбъекта(Метаданные.Документы.ИзменениеАссортимента);
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		КомандаСоздатьНаОсновании.ФункциональныеОпции = "ИспользоватьАссортимент";
		
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;
	
	Возврат Неопределено;
КонецФункции

#КонецОбласти

#КонецЕсли