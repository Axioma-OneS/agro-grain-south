﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	НачальныйПризнакВыполнения = Объект.Выполнена;
	ТолькоПросмотр = Объект.Выполнена;
	
	Если Не Объект.Выполнена Тогда
		Объект.ДатаИсполнения = ТекущаяДатаСеанса();
	КонецЕсли;
	
	ИспользоватьДатуИВремяВСрокахЗадач = ПолучитьФункциональнуюОпцию("ИспользоватьДатуИВремяВСрокахЗадач");
	Элементы.СрокИсполненияВремя.Видимость = ИспользоватьДатуИВремяВСрокахЗадач;
	Элементы.СрокНачалаИсполненияВремя.Видимость = ИспользоватьДатуИВремяВСрокахЗадач;
	Элементы.ДатаИсполнения.Формат = ?(ИспользоватьДатуИВремяВСрокахЗадач, "ДЛФ=DT", "ДЛФ=D");
	
	ИзменятьЗаданияЗаднимЧислом = ПолучитьФункциональнуюОпцию("ИзменятьЗаданияЗаднимЧислом");
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ДатаИсполнения", "ТолькоПросмотр", Не ИзменятьЗаданияЗаднимЧислом);
	
	ХодСогласования.Параметры.УстановитьЗначениеПараметра("БизнесПроцесс", Объект.БизнесПроцесс);
	
	УстанавливаемыеПараметры = Новый Структура();
	ТипПредмета = Объект.Предмет.Метаданные().ПолноеИмя();
	УстанавливаемыеПараметры.Вставить("ТипОбъекта", ТипПредмета);
	УстановитьПараметрыФункциональныхОпцийФормы(УстанавливаемыеПараметры);
	
	Если БизнесПроцессы.СогласованиеПродажи.ИспользуетсяВерсионированиеПредмета(ТипПредмета) Тогда
			
			ЕстьОтличияВерсий = БизнесПроцессы.СогласованиеПродажи.ПоследняяВерсияПредметаОтличаетсяОтСогласованных(Объект.БизнесПроцесс);
			
			Если ЕстьОтличияВерсий Тогда
				
				НомерПоследнейВерсии = БизнесПроцессы.СогласованиеПродажи.НомерПоследнейВерсииПредмета(Объект.БизнесПроцесс);
				ТекстЗаголовка = НСтр("ru = 'Внимание! Текущая версия №%НомерПоследнейВерсии% отличается от согласованной'");
				ТекстЗаголовка = СтрЗаменить(ТекстЗаголовка, "%НомерПоследнейВерсии%", НомерПоследнейВерсии);
				Элементы.ДекорацияОтличияВерсии.Заголовок = ТекстЗаголовка;
				
			Иначе
				
				Элементы.ДекорацияОтличияВерсии.Видимость = Ложь;
				
			КонецЕсли;
			
	Иначе
			
		Элементы.ДекорацияОтличияВерсии.Видимость = Ложь;
			
	КонецЕсли;
	
	Если ТипЗнч(Объект.Предмет) = Тип("ДокументСсылка.КоммерческоеПредложениеКлиенту") Тогда
		Элементы.ОтклоненияОтУсловийПродаж.Видимость = Ложь;
	КонецЕсли;
		
	Если Объект.Выполнена Тогда
		РезультатСогласования = БизнесПроцессы.СогласованиеПродажи.РезультатСогласованияПоТочкеМаршрута(Объект.БизнесПроцесс, Объект.ТочкаМаршрута);
		Если РезультатСогласования <> Неопределено Тогда
			Элементы.РезультатСогласования.Заголовок = РезультатСогласования;
		КонецЕсли;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		БизнесПроцессыИЗадачиСервер.ФормаЗадачиПриСозданииНаСервере(ЭтаФорма, Объект, 
			Элементы.ГруппаСостояние, Элементы.ДатаИсполнения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	БизнесПроцессыИЗадачиКлиент.ФормаЗадачиОбработкаОповещения(ЭтаФорма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	БизнесПроцессыИЗадачиСервер.ФормаЗадачиПриСозданииНаСервере(ЭтаФорма, Объект, 
		Элементы.ГруппаСостояние, Элементы.ДатаИсполнения);
	Элементы.ОписаниеРезультата.ТолькоПросмотр = Объект.Выполнена;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрытьВыполнить()
	
	ОчиститьСообщения();
	Если Записать() Тогда
		
		ОповеститьОбИзменении(Объект.Ссылка);
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Изменение:'"),
			ПолучитьНавигационнуюСсылку(Объект.Ссылка),
			Строка(Объект.Ссылка),
			БиблиотекаКартинок.Информация32);
			
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьВыполнить(Команда)
	
	Если Записать() Тогда
		
		ОповеститьОбИзменении(Объект.Ссылка);
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Изменение:'"),
			ПолучитьНавигационнуюСсылку(Объект.Ссылка),
			Строка(Объект.Ссылка),
			БиблиотекаКартинок.Информация32);
			
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Согласовано(Команда)
	
	ОчиститьСообщения();
	Если Записать() Тогда
		
		ЗафиксироватьРезультатСогласованияСервер(Истина);
		
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Выполнение:'"),
			ПолучитьНавигационнуюСсылку(Объект.Ссылка),
			Строка(Объект.Ссылка),
			БиблиотекаКартинок.Информация32);
		
		ОповеститьОбИзменении(Объект.Ссылка);
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НеСогласовано(Команда)
	
	ОчиститьСообщения();
	Если Не ЗначениеЗаполнено(Объект.РезультатВыполнения) Тогда
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'Укажите причину отклонения документа'"),
			Объект.Ссылка,
			"Объект.РезультатВыполнения");
		
		Возврат;
		
	КонецЕсли;
	
	Если Записать() Тогда
		
		ЗафиксироватьРезультатСогласованияСервер(Ложь);
		
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Выполнение:'"),
			ПолучитьНавигационнуюСсылку(Объект.Ссылка),
			Строка(Объект.Ссылка),
			БиблиотекаКартинок.Информация32);
		
		ОповеститьОбИзменении(Объект.Ссылка);
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтклоненияОтУсловийПродаж(Команда)
	ПараметрыФормы = Новый Структура("ДокументПродажи", Объект.Предмет);
	ОткрытьФорму("Отчет.ОтклоненияОтУсловийПродаж.Форма", ПараметрыФормы);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Процедура ЗафиксироватьРезультатСогласованияСервер(Согласовано = Истина)
	
	Попытка
		ЗаблокироватьДанныеДляРедактирования(Объект.БизнесПроцесс);
	Исключение
			
		ТекстОшибки = НСтр("ru='При выполнении задачи не удалось заблокировать %Ссылка%. %ОписаниеОшибки%'");
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Ссылка%",         Объект.БизнесПроцесс);
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ОписаниеОшибки%", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
			
		ВызватьИсключение ТекстОшибки;
				
	КонецПопытки;
	
	НачатьТранзакцию();
	
	Попытка
		
		УстановитьПривилегированныйРежим(Истина);
		
		СогласованиеОбъект    = Объект.БизнесПроцесс.ПолучитьОбъект();
		РезультатСогласования = ?(Согласовано, Перечисления.РезультатыСогласования.Согласовано, Перечисления.РезультатыСогласования.НеСогласовано);
		СогласованиеОбъект.ДобавитьРезультатСогласования(
			Объект.ТочкаМаршрута,
			Пользователи.ТекущийПользователь(),
			РезультатСогласования,
			Объект.РезультатВыполнения,
			Объект.ДатаИсполнения);
		
		СогласованиеОбъект.РезультатСогласования = РезультатСогласования;
		СогласованиеОбъект.Записать();
		УстановитьПривилегированныйРежим(Ложь);
		БизнесПроцессыИЗадачиВызовСервера.ВыполнитьЗадачу(Объект.Ссылка);
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		ВызватьИсключение;
		
	КонецПопытки;
	
	РазблокироватьДанныеДляРедактирования(Объект.БизнесПроцесс);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
