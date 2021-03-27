﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Добавляет команду создания объекта.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	Если ПравоДоступа("Добавление", Метаданные.БизнесПроцессы.СогласованиеПродажи) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.БизнесПроцессы.СогласованиеПродажи.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = ОбщегоНазначенияУТ.ПредставлениеОбъекта(Метаданные.БизнесПроцессы.СогласованиеПродажи);
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;
	
	Возврат Неопределено;
КонецФункции

// Возвращает структуру с именем и праметрами открытия формы
//
// Параметры:
//	ЗадачаСсылка - ЗадачаСсылка.ЗадачаИсполнителя - ссылка на задачу, для которой необходимо получить форму
//	ТочкаМаршрутаСсылка - ТочкаМаршрутаБизнесПроцессаСсылка - ссылка
//							на точку маршрута бизнес-процесса, для которой необходимо получить форму.
//
// Возвращаемое значение:
//	Структура - поля ПараметрыФормы, ИмяФормы.
//
Функция ФормаВыполненияЗадачи(Знач ЗадачаСсылка, Знач ТочкаМаршрутаСсылка) Экспорт
	
	Если ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.СогласоватьЛогистическиеУсловия Или
		ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.СогласоватьФинансовыеУсловия Или
		ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.СогласоватьЦеновыеУсловия Тогда
		ИмяФормы = "БизнесПроцесс.СогласованиеПродажи.Форма.ФормаЗадачиРецензента";
	ИначеЕсли ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.ОзнакомитьсяСРезультатами Тогда
		ИмяФормы = "БизнесПроцесс.СогласованиеПродажи.Форма.ФормаЗадачиОзнакомиться";
	ИначеЕсли ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.ПодвестиИтогиСогласования Тогда
		ИмяФормы = "БизнесПроцесс.СогласованиеПродажи.Форма.ФормаЗадачиПодвестиИтоги";
	КонецЕсли;
		
	Результат = Новый Структура;
	Результат.Вставить("ПараметрыФормы", Новый Структура("Ключ", ЗадачаСсылка));
	Результат.Вставить("ИмяФормы", ИмяФормы);
	
	Возврат Результат;
	
КонецФункции

// Вызывается при выполнении задачи из формы списка
//
// Параметры:
//  ЗадачаСсылка                - ЗадачаСсылка.ЗадачаИсполнителя - задача.
//  БизнесПроцессСсылка         - БизнесПроцессСсылка.СогласованиеПродажи - экземпляр процесса согласования.
//  ТочкаМаршрутаБизнесПроцесса - ТочкаМаршрутаБизнесПроцессаСсылка - точка маршрута процесса согласования.
//
Процедура ОбработкаВыполненияПоУмолчанию(Знач ЗадачаСсылка, БизнесПроцессСсылка, Знач ТочкаМаршрутаБизнесПроцесса) Экспорт
	
	// устанавливаем значения по умолчанию для пакетного выполнения задач
	Если ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.СогласоватьЛогистическиеУсловия Или
		ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.СогласоватьФинансовыеУсловия Или
		ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.СогласоватьЦеновыеУсловия Или
		ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.ПодвестиИтогиСогласования Тогда
		
		Попытка
			ЗаблокироватьДанныеДляРедактирования(БизнесПроцессСсылка);
		Исключение
				
			ТекстОшибки = НСтр("ru='При выполнении задачи не удалось заблокировать %Ссылка%. %ОписаниеОшибки%'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Ссылка%",         БизнесПроцессСсылка);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ОписаниеОшибки%", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				
			ВызватьИсключение ТекстОшибки;
			
		КонецПопытки;
		
		УстановитьПривилегированныйРежим(Истина);
	
		СогласованиеОбъект = БизнесПроцессСсылка.ПолучитьОбъект();
		
		СогласованиеОбъект.ДобавитьРезультатСогласования(
			ТочкаМаршрутаБизнесПроцесса,
			Пользователи.ТекущийПользователь(),
			Перечисления.РезультатыСогласования.Согласовано,
			,
			ТекущаяДатаСеанса());
		
		Если ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеПродажи.ТочкиМаршрута.ПодвестиИтогиСогласования Тогда
			СогласованиеОбъект.РезультатСогласования = Перечисления.РезультатыСогласования.Согласовано;
		КонецЕсли;
		
		СогласованиеОбъект.Записать();
		УстановитьПривилегированныйРежим(Ложь);
		
		РазблокироватьДанныеДляРедактирования(БизнесПроцессСсылка);

	КонецЕсли;
	
КонецПроцедуры

// Возвращает результат согласования рецензентом по точке маршрута
//
// Параметры:
//	БизнесПроцесс - БизнесПроцессаСсылка.СогласованиеПродажи - текущий процесс согласования.
//	ТочкаМаршрута - ТочкаМаршрутаБизнесПроцессаСсылка - текущая точка маршрута процесса согласования.
//
// Возвращаемое значение:
//	ПеречислениеСсылка.РезультатыСогласования - результат согласования в точке маршрута.
//
Функция РезультатСогласованияПоТочкеМаршрута(Знач БизнесПроцесс, Знач ТочкаМаршрута) Экспорт
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	СогласованиеПродажиРезультатыСогласования.РезультатСогласования КАК РезультатСогласования
		|
		|ИЗ
		|	БизнесПроцесс.СогласованиеПродажи.РезультатыСогласования КАК СогласованиеПродажиРезультатыСогласования
		|ГДЕ
		|	СогласованиеПродажиРезультатыСогласования.Ссылка = &Ссылка
		|	И СогласованиеПродажиРезультатыСогласования.ТочкаМаршрута = &ТочкаМаршрута
		|");
		
	Запрос.УстановитьПараметр("Ссылка",        БизнесПроцесс);
	Запрос.УстановитьПараметр("ТочкаМаршрута", ТочкаМаршрута);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.РезультатСогласования;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
		
КонецФункции

// Возвращает номер последней версии предмета
//
// Параметры:
//	БизнесПроцесс - БизнесПроцессаСсылка.СогласованиеПродажи
//
// Возвращаемое значение:
//	Номер последней версии документа - Число.
//
Функция НомерПоследнейВерсииПредмета(Знач БизнесПроцесс) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	ВерсииОбъектов.НомерВерсии КАК НомерВерсии
		|ИЗ
		|	РегистрСведений.ВерсииОбъектов КАК ВерсииОбъектов
		|ГДЕ
		|	ВерсииОбъектов.Объект = ВЫРАЗИТЬ (&БизнесПроцесс КАК БизнесПроцесс.СогласованиеПродажи).Предмет
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерВерсии УБЫВ
		|
		|");
		
	Запрос.УстановитьПараметр("БизнесПроцесс", БизнесПроцесс);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		НомерВерсии = Выборка.НомерВерсии;
	Иначе
		НомерВерсии = 0;
	КонецЕсли;
	
	Возврат НомерВерсии;

КонецФункции

// Осуществляет проверку на отличия последней версии предмета от согласованных.
//
// Параметры:
//   БизнесПроцесс - БизнесПроцессаСсылка.СогласованиеПродажи - текущий бизнес-процесс согласования.
//
// Возвращаемое значение:
//   Булево - истина, если отличия есть, иначе ложь.
//
Функция ПоследняяВерсияПредметаОтличаетсяОтСогласованных(Знач БизнесПроцесс) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	ЕСТЬNULL(МАКСИМУМ(РезультатыСогласования.НомерВерсии),0) КАК НомерСогласованнойВерсии,
		|	ЕСТЬNULL(МАКСИМУМ(ВерсииОбъектов.НомерВерсии),0)         КАК НомерПоследнейВерсии
		|ИЗ
		|	БизнесПроцесс.СогласованиеПродажи.РезультатыСогласования КАК РезультатыСогласования
		|ЛЕВОЕ СОЕДИНЕНИЕ
		|	РегистрСведений.ВерсииОбъектов КАК ВерсииОбъектов
		|ПО
		|	ВерсииОбъектов.Объект = РезультатыСогласования.Ссылка.Предмет
		|ГДЕ
		|	РезультатыСогласования.Ссылка = &БизнесПроцесс
		|");
		
	Запрос.УстановитьПараметр("БизнесПроцесс", БизнесПроцесс);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Если Выборка.НомерСогласованнойВерсии <> Выборка.НомерПоследнейВерсии Тогда
			ЕстьОтличия = Истина;
		Иначе
			ЕстьОтличия = Ложь;
		КонецЕсли;
	Иначе
		ЕстьОтличия = Ложь;
	КонецЕсли;
	
	Возврат ЕстьОтличия;
	
КонецФункции

// Осуществляет проверку использования версионирования предмета согласования
//
// Параметры:
//	ТипПредмета - Строка - полное имя объекта, например "Документ.ЗаказКлиента".
//
// Возвращаемое значение:
//	Истина, если версионирование используется, иначе ложь - Булево.
//
Функция ИспользуетсяВерсионированиеПредмета(Знач ТипПредмета) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ИспользоватьВерсионированиеОбъектов = ПолучитьФункциональнуюОпцию("ИспользоватьВерсионированиеОбъектов");
	
	Если Не ИспользоватьВерсионированиеОбъектов Тогда
		Возврат Ложь;
	КонецЕсли;
		
	ПараметрыОпции = Новый Структура();
	ПараметрыОпции.Вставить("ТипОбъекта", ТипПредмета);
		
	ИспользоватьВерсионированиеОбъекта = ПолучитьФункциональнуюОпцию("ИспользоватьВерсионированиеОбъекта", ПараметрыОпции);
	
	Возврат ИспользоватьВерсионированиеОбъекта;
	
КонецФункции

// Вызывается при перенаправлении задачи.
//
// Параметры:
//   ЗадачаСсылка      - ЗадачаСсылка.ЗадачаИсполнителя - перенаправляемая задача.
//   НоваяЗадачаСсылка - ЗадачаСсылка.ЗадачаИсполнителя - задача для нового исполнителя.
//
Процедура ПриПеренаправленииЗадачи(ЗадачаСсылка, НоваяЗадачаСсылка) Экспорт
	
	ЗадачаОбъект = НоваяЗадачаСсылка.ПолучитьОбъект();
	ЗаблокироватьДанныеДляРедактирования(НоваяЗадачаСсылка);
	ЗадачаОбъект.РезультатВыполнения = РезультатВыполненияПриПеренаправлении(ЗадачаСсылка) + 
		ЗадачаОбъект.РезультатВыполнения;
	ЗадачаОбъект.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

// Установка значений реквизитов предопределенных элементов справочника РолиИсполнителей,
// относящихся к согласованию продажи.
//
Процедура ИнициализироватьРолиИсполнителей() Экспорт
	
	РольОбъект = Справочники.РолиИсполнителей.СогласующийЦеновыеУсловияПродаж.ПолучитьОбъект();
	РольОбъект.ИспользуетсяБезОбъектовАдресации = Истина;
	РольОбъект.Записать();
	
	РольОбъект = Справочники.РолиИсполнителей.СогласующийЛогистическиеУсловияПродаж.ПолучитьОбъект();
	РольОбъект.ИспользуетсяБезОбъектовАдресации = Истина;
	РольОбъект.Записать();
	
	РольОбъект = Справочники.РолиИсполнителей.СогласующийФинансовыеУсловияПродаж.ПолучитьОбъект();
	РольОбъект.ИспользуетсяБезОбъектовАдресации = Истина;
	РольОбъект.Записать();
	
	РольОбъект = Справочники.РолиИсполнителей.СогласующийКоммерческиеУсловияПродаж.ПолучитьОбъект();
	РольОбъект.ИспользуетсяБезОбъектовАдресации = Истина;
	РольОбъект.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

Функция РезультатВыполненияПриПеренаправлении(Знач ЗадачаСсылка)
	
	СтрокаФормат = НСтр("ru = '%1, %2 перенаправил(а) задачу:'");
	СтрокаФормат = СтрокаФормат + Символы.ПС + "%3" + Символы.ПС;
	
	Комментарий = СокрЛП(ЗадачаСсылка.РезультатВыполнения);
	Комментарий = ?(ПустаяСтрока(Комментарий), "", Комментарий + Символы.ПС);
	Результат = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаФормат,
		ЗадачаСсылка.ДатаИсполнения,
		ЗадачаСсылка.Исполнитель,
		Комментарий);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область Отчеты

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - Таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	КомандаОтчет =  Отчеты.РезультатыСогласованияПродажи.ДобавитьКомандуРезультатыСогласованияПродажи(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаБизнесПроцесса,ФормаСписка";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли


