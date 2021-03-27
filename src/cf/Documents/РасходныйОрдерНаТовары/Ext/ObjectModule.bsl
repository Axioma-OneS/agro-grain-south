﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если НЕ ПраваПользователяПовтИсп.ВзятиеРасходногоОрдераВРаботу() Тогда
		
		Если  Статус <> Перечисления.СтатусыРасходныхОрдеров.Подготовлено
			И РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
			
			ВызватьИсключение НСтр("ru = 'Недостаточно прав на взятие расходного ордера в работу.'");
			
		КонецЕсли;
		
		СтарыйСтатус = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Статус");
		
		Если СтарыйСтатус <> Перечисления.СтатусыРасходныхОрдеров.Подготовлено
			И СтарыйСтатус <> Неопределено Тогда
			
			ВызватьИсключение НСтр("ru = 'Недостаточно прав на изменение статуса расходного ордера, взятого в работу.'");
			
		КонецЕсли;
		
	КонецЕсли;

	ПроведениеСерверУТ.УстановитьРежимПроведения(ЭтотОбъект, РежимЗаписи, РежимПроведения);

	ДополнительныеСвойства.Вставить("ЭтоНовый",    ЭтоНовый());
	ДополнительныеСвойства.Вставить("РежимЗаписи", РежимЗаписи);
	
	СформироватьСписокЗависимыхЗаказов();
	
	ПараметрыУказанияСерий = НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект, Документы.РасходныйОрдерНаТовары);
	
	НоменклатураСервер.ОчиститьНеиспользуемыеСерии(ЭтотОбъект, ПараметрыУказанияСерий.ТоварыПоРаспоряжениям);
	НоменклатураСервер.ОчиститьНеиспользуемыеСерии(ЭтотОбъект, ПараметрыУказанияСерий.ОтгружаемыеТовары);
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьСтатусыРасходныхОрдеров", Новый Структура("Склад", Склад)) Тогда
		Статус = Перечисления.СтатусыРасходныхОрдеров.Отгружен;
	КонецЕсли;
	
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		ПроверитьОрдерныйСклад(Отказ);
	КонецЕсли;
	
	ВсегоМест = УпаковочныеЛистыСервер.КоличествоМестВТЧ(ОтгружаемыеТовары);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	Перем Отказ;
	
	Если ДанныеЗаполнения = "АвтоТест" Тогда
		Возврат;
	КонецЕсли;	
	
	Если Не (ЗначениеЗаполнено(Склад)
		И ЗначениеЗаполнено(СкладскаяОперация)
		И (ЗначениеЗаполнено(Получатель) Или СкладскаяОперация = Перечисления.СкладскиеОперации.ОтгрузкаНаВнутренниеНужды)
		И ЗначениеЗаполнено(ДатаОтгрузки)) Тогда
		
		Отказ = Истина;
		
	Иначе
		
		ИспользоватьПомещения = СкладыСервер.ИспользоватьСкладскиеПомещения(Склад, ДатаОтгрузки, Истина);

		Если ИспользоватьПомещения
			И Не ЗначениеЗаполнено(Помещение) Тогда
			Отказ = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	Если Отказ = Истина Тогда
		ТекстСообщения = НСтр("ru='Расходный ордер на товары можно вводить только на основании распоряжения на отгрузку товаров.'");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
		
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
	ПараметрыУказанияСерий = Документы.РасходныйОрдерНаТовары.ПараметрыУказанияСерий(ЭтотОбъект);
	
	НоменклатураСервер.ЗаполнитьСтатусыУказанияСерий(ЭтотОбъект, ПараметрыУказанияСерий.ТоварыПоРаспоряжениям); 
	
	Документы.РасходныйОрдерНаТовары.ЗаполнитьОтгружаемыеТоварыПоТоварамПоРаспоряжениям(ЭтотОбъект);
	
	Документы.РасходныйОрдерНаТовары.ЗаполнитьДействиеВСтроках(ЭтотОбъект);
	
	НоменклатураСервер.ЗаполнитьСерииПоFEFO(ЭтотОбъект, ПараметрыУказанияСерий.ОтгружаемыеТовары, Ложь); 
	
	Если Не СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, ДатаОтгрузки)
		И ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры") Тогда
		Документы.РасходныйОрдерНаТовары.РазбитьПоУпаковкамСправочно(ЭтотОбъект);
	КонецЕсли;
	
	НоменклатураСервер.ЗаполнитьСтатусыУказанияСерий(ЭтотОбъект, ПараметрыУказанияСерий.ОтгружаемыеТовары); 
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства, РежимПроведения);

	Документы.РасходныйОрдерНаТовары.ИнициализироватьДанныеДокумента(Ссылка, ДополнительныеСвойства);

	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	ЗапасыСервер.ОтразитьТоварыНаСкладах(ДополнительныеСвойства, Движения, Отказ);
	ЗаказыСервер.ОтразитьТоварыКОтгрузке(ДополнительныеСвойства, Движения, Отказ);
	СкладыСервер.ОтразитьТоварыКОтбору(ДополнительныеСвойства, Движения, Отказ);
	СкладыСервер.ОтразитьДвиженияСерийТоваров(ДополнительныеСвойства, Движения, Отказ);
	СкладыСервер.ОтразитьТоварыВЯчейках(ДополнительныеСвойства, Движения, Отказ);

	СформироватьСписокРегистровДляКонтроля();

	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСерверУТ.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	ПроведениеСерверУТ.ЗаписатьПодчиненныеНаборамЗаписейДанные(ЭтотОбъект, Отказ);

	РегистрыСведений.СостоянияЗаказовКлиентов.ОтразитьСостояниеЗаказа(ЭтотОбъект, Отказ);

	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)

	ПроведениеСерверУТ.ИнициализироватьДополнительныеСвойстваДляПроведения(Ссылка, ДополнительныеСвойства);

	ПроведениеСерверУТ.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);

	СформироватьСписокРегистровДляКонтроля();

	ПроведениеСерверУТ.ЗаписатьНаборыЗаписей(ЭтотОбъект);

	ПроведениеСерверУТ.ВыполнитьКонтрольРезультатовПроведения(ЭтотОбъект, Отказ);
	ПроведениеСерверУТ.ЗаписатьПодчиненныеНаборамЗаписейДанные(ЭтотОбъект, Отказ);

	РегистрыСведений.СостоянияЗаказовКлиентов.ОтразитьСостояниеЗаказа(ЭтотОбъект, Отказ);

	ПроведениеСерверУТ.ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства);

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)

	ИнициализироватьДокумент();

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если Не ДополнительныеСвойства.Свойство("ОтложенноеПроведение") Тогда
		
		ПараметрыФО = Новый Структура;
		ПараметрыФО.Вставить("Склад", Склад);
		
		Если Не Проведен
			И Статус <> Перечисления.СтатусыРасходныхОрдеров.КОтбору
			И Статус <> Перечисления.СтатусыРасходныхОрдеров.Подготовлено
			И (ПолучитьФункциональнуюОпцию("ИспользоватьСерииНоменклатурыСклад",ПараметрыФО)
			Или СкладыСервер.ИспользоватьСкладскиеПомещения(Склад, ДатаОтгрузки)
			Или СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, ДатаОтгрузки)) Тогда
			
			ТекстСообщения = НСтр("ru = 'Документ должен быть проведен сначала в статусе ""К отбору"" или ""Подготовлено""'");
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект,"Статус","Объект",Отказ);
		КонецЕсли;
	КонецЕсли;

	МассивНепроверяемыхРеквизитов = Новый Массив;

	МассивНепроверяемыхРеквизитов.Добавить("ЗаданиеНаПеревозку");
	
	Если ОтгрузкаПоЗаданиюНаПеревозку Тогда
		Если Не ДоставкаТоваров.ЕстьДоставкаПоСкладскойОперации(СкладскаяОперация) Тогда
			ТекстСообщения = НСтр("ru = 'Для складской операции %СкладскаяОперация% доставка не предусмотрена'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%СкладскаяОперация%", СкладскаяОперация);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект,,,Отказ);
		ИначеЕсли Не ЗначениеЗаполнено(ЗаданиеНаПеревозку)
			И (ПолучитьФункциональнуюОпцию("НачинатьОтгрузкуПослеФормированияЗаданияНаПеревозку", Новый Структура("Склад", Склад))
			Или Статус = Перечисления.СтатусыРасходныхОрдеров.КОтгрузке
			Или Статус = Перечисления.СтатусыРасходныхОрдеров.Отгружен) Тогда
			ТекстСообщения = НСтр("ru = 'Поле ""Задание не перевозку"" не заполнено'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект,"ЗаданиеНаПеревозку","Объект",Отказ);
		ИначеЕсли Статус <> Перечисления.СтатусыРасходныхОрдеров.Отгружен Тогда
			СтатусЗаданияНаПеревозку = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ЗаданиеНаПеревозку, "Статус");
			
			Если СтатусЗаданияНаПеревозку = Перечисления.СтатусыЗаданийНаПеревозку.Отправлено
				Или СтатусЗаданияНаПеревозку = Перечисления.СтатусыЗаданийНаПеревозку.Закрыто Тогда
				
				ТекстСообщения = НСтр("ru = 'Выбранное задание на перевозку находится в статусе ""%СтатусЗадания%"", поэтому его нельзя указать в ордере, который находится в статусе ""%СтатусОрдера%"". Измените статус ордера на ""%СтатусОтгружено%"".'");
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%СтатусЗадания%", СтатусЗаданияНаПеревозку);
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%СтатусОрдера%", Статус);
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%СтатусОтгружено%", Перечисления.СтатусыРасходныхОрдеров.Отгружен);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект,"Статус","Объект",Отказ);
				
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
		
	Если Не СкладыСервер.ИспользоватьСкладскиеПомещения(Склад,ДатаОтгрузки) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Помещение");
	КонецЕсли;
	
	Если СкладскаяОперация = Перечисления.СкладскиеОперации.ОтгрузкаНаВнутренниеНужды Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Получатель");
	КонецЕсли;
	
	ИспользоватьУпаковочныеЛисты = ПолучитьФункциональнуюОпцию("ИспользоватьУпаковочныеЛисты");
	
	Если Не СкладыСервер.ИспользоватьАдресноеХранение(Склад,Помещение,ДатаОтгрузки) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ОтгружаемыеТовары.Упаковка");
		МассивНепроверяемыхРеквизитов.Добавить("ЗонаОтгрузки");
	Иначе
		Если Статус = Перечисления.СтатусыРасходныхОрдеров.КОтбору
			Или Статус = Перечисления.СтатусыРасходныхОрдеров.Подготовлено Тогда
			МассивНепроверяемыхРеквизитов.Добавить("ОтгружаемыеТовары.Упаковка");
		Иначе
			
			ПараметрыПроверки = НоменклатураСервер.ПараметрыПроверкиЗаполненияУпаковок();
			ПараметрыПроверки.ВыводитьНомераСтрок = Не ИспользоватьУпаковочныеЛисты;
			ПараметрыПроверки.ИмяТЧ = "ОтгружаемыеТовары";
			ПараметрыПроверки.ОтборПроверяемыхСтрок.Вставить("ЭтоУпаковочныйЛист", Ложь);
			
			ПараметрыПроверки.ОтборПроверяемыхСтрок.Вставить("Действие", Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.Отгрузить);
			НоменклатураСервер.ПроверитьЗаполнениеУпаковок(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ,ПараметрыПроверки);
			
			ПараметрыПроверки.ОтборПроверяемыхСтрок.Вставить("Действие", Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.НеОтгружать);
			НоменклатураСервер.ПроверитьЗаполнениеУпаковок(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ,ПараметрыПроверки);
			
		КонецЕсли;
		
		Если Не ПолучитьФункциональнуюОпцию("ИспользоватьУпаковкиНоменклатуры") Тогда
			МассивНепроверяемыхРеквизитов.Добавить("Товары.Упаковка");
			ТекстСообщения = НСтр("ru='В настройках программы не включено использование упаковок номенклатуры, 
			|поэтому нельзя оформить документ по складу с адресным хранением остатков. Обратитесь к администратору'");
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,,Отказ);
		КонецЕсли;
	КонецЕсли;	
	
	Если Статус = Перечисления.СтатусыРасходныхОрдеров.Отгружен Тогда
		
		Если ДатаОтгрузки > ТекущаяДатаСеанса() Тогда
			
			ТекстСообщения = НСтр("ru='При проведении расходного ордера в статусе ""%Отгружен%"" дата отгрузки должна быть не больше текущей даты.'");
			
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%Отгружен%",Перечисления.СтатусыРасходныхОрдеров.Отгружен);
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект,"ДатаОтгрузки","Объект",Отказ);
			
		КонецЕсли;
	КонецЕсли;

	ПараметрыПроверки = НоменклатураСервер.ПараметрыПроверкиЗаполненияХарактеристик();
	ПараметрыПроверки.ВыводитьНомераСтрок = Не ИспользоватьУпаковочныеЛисты;
	ПараметрыПроверки.ИмяТЧ = "ТоварыПоРаспоряжениям"; 
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ,ПараметрыПроверки);
	
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект,
												НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект,Документы.РасходныйОрдерНаТовары).ТоварыПоРаспоряжениям,
												Отказ,
												МассивНепроверяемыхРеквизитов);
	
	ПараметрыПроверки = НоменклатураСервер.ПараметрыПроверкиЗаполненияХарактеристик();
	ПараметрыПроверки.ВыводитьНомераСтрок = Не ИспользоватьУпаковочныеЛисты;
	ПараметрыПроверки.ИмяТЧ = "ОтгружаемыеТовары"; 
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ,ПараметрыПроверки);
	
	НоменклатураСервер.ПроверитьЗаполнениеСерий(ЭтотОбъект,
												НоменклатураСервер.ПараметрыУказанияСерий(ЭтотОбъект,Документы.РасходныйОрдерНаТовары).ОтгружаемыеТовары,
												Отказ,
												МассивНепроверяемыхРеквизитов);
	Если ИспользоватьУпаковочныеЛисты Тогда											
		УпаковочныеЛистыСервер.ПроверитьЗаполнениеТЧСУпаковочнымиЛистами(ЭтотОбъект, ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов, Отказ, "ОтгружаемыеТовары");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	ПараметрыПроверки = ОбщегоНазначенияУТ.ПараметрыПроверкиЗаполненияКоличества();
	ПараметрыПроверки.ИмяТЧ = "ОтгружаемыеТовары";
	ПараметрыПроверки.ПроверитьВозможностьОкругления = Ложь;
	ПараметрыПроверки.ПроверитьКомплектностьТоварныхМест = Истина;
	ПараметрыПроверки.УсловиеОтбораСтрокПроверкиКомплектности = "ОтгружаемыеТовары.Действие <> ЗНАЧЕНИЕ(Перечисление.ДействияСоСтрокамиОрдеровНаОтгрузку.НеОтгружать)";
	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ, ПараметрыПроверки);
	
	СкладыСервер.ПроверитьОрдерностьСклада(Склад, ДатаОтгрузки, "ПриОтгрузке", Отказ);
	
	Если Статус = Перечисления.СтатусыРасходныхОрдеров.Проверен
		Или Статус = Перечисления.СтатусыРасходныхОрдеров.КОтгрузке
		Или Статус = Перечисления.СтатусыРасходныхОрдеров.Отгружен Тогда
		
		НайденныеСтроки = ОтгружаемыеТовары.НайтиСтроки(Новый Структура("Действие", Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.Отобрать));
		
		ПредставлениеТЧ = Метаданные().ТабличныеЧасти.ОтгружаемыеТовары.Представление();
		
		Для Каждого СтрТабл Из НайденныеСтроки Цикл
			Отказ = Истина;
			
			ПутьКДанным = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ОтгружаемыеТовары", СтрТабл.НомерСтроки, "Действие");
						
			ТекстСообщения = НСтр("ru = 'В строке %НомерСтроки% списка %ИмяТЧ% выбрано действие ""%Отобрать%"". Невозможно проведение документа в статусе %СтатусДокумента%. Необходимо выбрать действие: ""%НеОтгружать%"" или ""%Отгрузить%"".'");
			
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", СтрТабл.НомерСтроки);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ИмяТЧ%", ПредставлениеТЧ);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Отобрать%", Строка(Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.Отобрать));
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%СтатусДокумента%", Строка(Статус));
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НеОтгружать%", Строка(Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.НеОтгружать));
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Отгрузить%", Строка(Перечисления.ДействияСоСтрокамиОрдеровНаОтгрузку.Отгрузить));
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, ПутьКДанным);
		КонецЦикла;
		
	КонецЕсли;
			
	Если ОбщегоНазначенияУТ.ПроверитьЗаполнениеРеквизитовОбъекта(ЭтотОбъект, ПроверяемыеРеквизиты) Тогда
		Отказ = Истина;
	КонецЕсли;
	
	Если Не Отказ Тогда
		ПроверитьСоответствиеСтрокТабличныхЧастей(Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьСоответствиеСтрокТабличныхЧастей(Отказ)
	
	Выборка = Документы.РасходныйОрдерНаТовары.ВыборкаИзЗапросаПоПревышениюРаспоряжений(ЭтотОбъект);
	
	ШаблонСообщения = НСтр("ru = 'Количество товара %Товар%, которое нужно отгрузить по распоряжениям на отгрузку не равно количеству, которое отгружается ордером.'");
	
	Пока Выборка.Следующий() Цикл
		Отказ = Истина;
		ТоварПредставление = НоменклатураКлиентСервер.ПредставлениеНоменклатуры(Выборка.Номенклатура,
																	Выборка.Характеристика,
																	,
																	Выборка.Серия,
																	Выборка.Назначение);
		ТекстСообщения = СтрЗаменить(ШаблонСообщения,"%Товар%", ТоварПредставление);
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,ЭтотОбъект.Ссылка);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)

	Ответственный = Пользователи.ТекущийПользователь();
	Приоритет = Справочники.Приоритеты.ПолучитьПриоритетПоУмолчанию(Приоритет);
	
	Если СкладыСервер.ИспользоватьАдресноеХранение(Склад,Помещение,ДатаОтгрузки) Тогда
		ЗонаОтгрузки = Справочники.СкладскиеЯчейки.ЗонаОтгрузкиПоУмолчанию(Склад,Помещение,ЗонаОтгрузки);
	КонецЕсли;
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьСтатусыРасходныхОрдеров", Новый Структура("Склад", Склад)) Тогда
		Статус = Метаданные().Реквизиты.Статус.ЗначениеЗаполнения;
	Иначе
		Статус = Перечисления.СтатусыРасходныхОрдеров.Отгружен;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

Процедура СформироватьСписокРегистровДляКонтроля()

	Массив = Новый Массив;
	
	Если Не ДополнительныеСвойства.Свойство("ОтключитьКонтрольПриПроведении") Тогда
		Если ДополнительныеСвойства.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
			Массив.Добавить(Движения.ТоварыКОтгрузке);
			Движения.ТоварыКОтгрузке.ДополнительныеСвойства.Вставить("ЗапретитьКонтрольДвиженияТоварыКОтгрузкеИзменениеСводно", Истина);
			Если Статус = Перечисления.СтатусыРасходныхОрдеров.КОтбору
				Или Статус = Перечисления.СтатусыРасходныхОрдеров.Подготовлено Тогда
				Массив.Добавить(Движения.ТоварыНаСкладах);
			КонецЕсли;
		КонецЕсли;
		
		Если СкладыСервер.ИспользоватьАдресноеХранение(Склад, Помещение, ДатаОтгрузки) Тогда
			
			Массив.Добавить(Движения.ТоварыКОтбору);
			
		КонецЕсли;
	КонецЕсли;
	
	ДополнительныеСвойства.ДляПроведения.Вставить("РегистрыДляКонтроля", Массив);

КонецПроцедуры

Процедура ПроверитьОрдерныйСклад(Отказ)
	
	Если НЕ СкладыСервер.ИспользоватьОрдернуюСхемуПриОтгрузке(Склад, Дата) Тогда
		
		Отказ = Истина;
		ТекстСообщения = НСтр("ru='На складе ""%Склад%"" на %Дата% не используется ордерная схема при отгрузке.'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%Склад%",Склад);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%Дата%",Формат(Дата, "ДЛФ=D"));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			ТекстСообщения,
			Ссылка);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура СформироватьСписокЗависимыхЗаказов()
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = ТекстЗапросаЗависимыеЗаказыКлиентов();
	
	Запрос.УстановитьПараметр("МассивЗаказов", ЭтотОбъект.ТоварыПоРаспоряжениям.ВыгрузитьКолонку("Распоряжение"));
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	УстановитьПривилегированныйРежим(Истина);
	
	Результат = Запрос.Выполнить();
	
	МассивЗависимыхЗаказов = Результат.Выгрузить().ВыгрузитьКолонку("ЗаказКлиента");
	ЭтотОбъект.ДополнительныеСвойства.Вставить("МассивЗависимыхЗаказовКлиентов", Новый ФиксированныйМассив(МассивЗависимыхЗаказов));
	
КонецПроцедуры

Функция ТекстЗапросаЗависимыеЗаказыКлиентов()
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВложенныйЗапрос.ЗаказКлиента КАК ЗаказКлиента
	|ИЗ
	|	(ВЫБРАТЬ
	|		ЗаказКлиента.Ссылка КАК ЗаказКлиента
	|	ИЗ
	|		Документ.ЗаказКлиента КАК ЗаказКлиента
	|	ГДЕ
	|		ЗаказКлиента.Ссылка В(&МассивЗаказов)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ЗаказКлиента.Ссылка
	|	ИЗ
	|		Документ.ЗаявкаНаВозвратТоваровОтКлиента КАК ЗаказКлиента
	|	ГДЕ
	|		ЗаказКлиента.Ссылка В(&МассивЗаказов)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ЗаказКлиента.Ссылка
	|	ИЗ
	|		Документ.ЗаказКлиента КАК ЗаказКлиента
	|	ГДЕ
	|		ЗаказКлиента.Ссылка В
	|				(ВЫБРАТЬ
	|					ТоварыДокумента.Распоряжение
	|				ИЗ
	|					Документ.РасходныйОрдерНаТовары.ТоварыПоРаспоряжениям КАК ТоварыДокумента
	|				ГДЕ
	|					ТоварыДокумента.Ссылка = &Ссылка)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ЗаказКлиента.Ссылка
	|	ИЗ
	|		Документ.ЗаявкаНаВозвратТоваровОтКлиента КАК ЗаказКлиента
	|	ГДЕ
	|		ЗаказКлиента.Ссылка В
	|				(ВЫБРАТЬ
	|					ТоварыДокумента.Распоряжение
	|				ИЗ
	|					Документ.РасходныйОрдерНаТовары.ТоварыПоРаспоряжениям КАК ТоварыДокумента
	|				ГДЕ
	|					ТоварыДокумента.Ссылка = &Ссылка)) КАК ВложенныйЗапрос";
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли