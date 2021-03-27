﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает структуру с именем и праметрами открытия формы
//
// Параметры:
//	ЗадачаСсылка - ЗадачаСсылка.ЗадачаИсполнителя - ссылка на задачу, для которой необходимо получить форму
//	ТочкаМаршрутаСсылка - ТочкаМаршрутаБизнесПроцессаСсылка - ссылка на точку маршрута
//							бизнес-процесса, для которой необходимо получить форму.
//
// Возвращаемое значение:
//	Структура - поля ПараметрыФормы, ИмяФормы.
//
Функция ФормаВыполненияЗадачи(Знач ЗадачаСсылка, Знач ТочкаМаршрутаСсылка) Экспорт
	
	Если ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеДоговоров.ТочкиМаршрута.ОзнакомитьсяСРезультатами Тогда
		ИмяФормы = "БизнесПроцесс.СогласованиеДоговоров.Форма.ФормаЗадачиОзнакомиться";
	Иначе 
		ИмяФормы = "БизнесПроцесс.СогласованиеДоговоров.Форма.ФормаЗадачиРецензента";
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("ПараметрыФормы", Новый Структура("Ключ", ЗадачаСсылка));
	Результат.Вставить("ИмяФормы", ИмяФормы);
	
	Возврат Результат;
	
КонецФункции

// Вызывается при выполнении задачи из формы списка
//
// Параметры:
//   ЗадачаСсылка                – ЗадачаСсылка.ЗадачаИсполнителя                        – текущая выполняемая задача.
//   БизнесПроцессСсылка         - БизнесПроцессСсылка.СогласованиеЗакупки               - текущий процесс согласования.
//   ТочкаМаршрутаБизнесПроцесса – ТочкаМаршрутаБизнесПроцессаСсылка - точка маршрута согласования.
//
Процедура ОбработкаВыполненияПоУмолчанию(Знач ЗадачаСсылка, БизнесПроцессСсылка, Знач ТочкаМаршрутаБизнесПроцесса) Экспорт
	
	// устанавливаем значения по умолчанию для пакетного выполнения задач
	Если ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеДоговоров.ТочкиМаршрута.СогласованиеФинДиректором Или
		ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеДоговоров.ТочкиМаршрута.СогласованиеГенДир Или
		ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеДоговоров.ТочкиМаршрута.СогласованиеРукПодразделения Или
		ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеДоговоров.ТочкиМаршрута.СогласованиеЮристом Тогда
		
		Попытка
			ЗаблокироватьДанныеДляРедактирования(БизнесПроцессСсылка);
		Исключение
				
			ТекстОшибки = НСтр("ru='При выполнении задачи не удалось заблокировать %Ссылка%. %ОписаниеОшибки%'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Ссылка%",         БизнесПроцессСсылка);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ОписаниеОшибки%", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				
			ВызватьИсключение ТекстОшибки;
			
		КонецПопытки;
		
		УстановитьПривилегированныйРежим(Истина);
		
		КоличествоРезультатовСогласования = БизнесПроцессСсылка.РезультатыСогласования.Количество();
		Если КоличествоРезультатовСогласования = 0 Тогда 
			РезультатСогл = Перечисления.РезультатыСогласования.НеСогласовано;	
		Иначе 
			РезультатСогл = БизнесПроцессСсылка.РезультатыСогласования[КоличествоРезультатовСогласования-1].РезультатСогласования;
		КонецЕсли;	
		
		СогласованиеОбъект = БизнесПроцессСсылка.ПолучитьОбъект();
		
		ТекстОписания = СтрШаблон("Дата выполнения: %1
						|Роль: %2
						|Рецендент: %3
						|Результат выполнения: %4
						|", ЗадачаСсылка.ДатаИсполнения, ЗадачаСсылка.ГруппаИсполнителейЗадач, ПараметрыСеанса.ТекущийПользователь, ЗадачаСсылка.РезультатВыполнения);
		СогласованиеОбъект.ДобавитьРезультатСогласования(
			ТочкаМаршрутаБизнесПроцесса,
			Пользователи.ТекущийПользователь(),
			РезультатСогл,
			ТекстОписания,
			ТекущаяДатаСеанса());
		
		СогласованиеОбъект.РезультатСогласования = РезультатСогл;

		
		СогласованиеОбъект.Записать();
		УстановитьПривилегированныйРежим(Ложь);
		
		РазблокироватьДанныеДляРедактирования(БизнесПроцессСсылка);

	КонецЕсли;
	
КонецПроцедуры

// Возвращает номер последней версии предмета.
//
// Параметры:
//   БизнесПроцесс - БизнесПроцессСсылка.СогласованиеЗакупки - бизнес-процесс, для которого получается номер версии.
//
// Возвращаемое значение:
//   Число - Номер последней версии документа.
//
Функция НомерПоследнейВерсииПредмета(Знач БизнесПроцесс) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	ВерсииОбъектов.НомерВерсии КАК НомерВерсии
		|ИЗ
		|	РегистрСведений.ВерсииОбъектов КАК ВерсииОбъектов
		|ГДЕ
		|	ВерсииОбъектов.Объект = ВЫРАЗИТЬ (&БизнесПроцесс КАК БизнесПроцесс.СогласованиеДоговоров).Предмет
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

// Вызывается при перенаправлении задачи
//
// Параметры:
//   ЗадачаСсылка – ЗадачаСсылка.ЗадачаИсполнителя – перенаправляемая задача.
//  НоваяЗадачаСсылка – ЗадачаСсылка.ЗадачаИсполнителя – задача для нового исполнителя.
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
// относящихся к согласованию закупок
// Вызывается при первоначальном заполнении ИБ.
//
Процедура ИнициализироватьРолиИсполнителей() Экспорт
	
	РольОбъект = Справочники.РолиИсполнителей.ГенеральныйДиректор.ПолучитьОбъект();
	РольОбъект.ИспользуетсяБезОбъектовАдресации = Истина;
	РольОбъект.Записать();
		
	РольОбъект = Справочники.РолиИсполнителей.ФинансовыйДиректор.ПолучитьОбъект();
	РольОбъект.ИспользуетсяБезОбъектовАдресации = Истина;
	РольОбъект.Записать();
	
	РольОбъект = Справочники.РолиИсполнителей.Юрист.ПолучитьОбъект();
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
	
	//КомандаОтчет = Отчеты.РезультатыСогласованияЗакупки.ДобавитьКомандуОтчета(КомандыОтчетов);
	//Если КомандаОтчет <> Неопределено Тогда
	//	КомандаОтчет.ВидимостьВФормах = "ФормаБизнесПроцесса,ФормаСписка";
	//КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли


