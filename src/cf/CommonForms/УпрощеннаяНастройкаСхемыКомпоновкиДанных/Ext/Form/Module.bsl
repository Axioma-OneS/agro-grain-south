﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		
		Возврат;
		
	КонецЕсли;
	
	// Переданный в параметре адрес сохраняется в качестве адреса исходной схемы
	АдресИсходнойСхемыКомпоновкиДанных = Параметры.АдресСхемыКомпоновкиДанных;
	УникальныйИдентификаторВладельца = Параметры.УникальныйИдентификатор;
	
	ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных = Параметры.ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных;
	ПроцедураПроверкиСхемыКомпоновкиДанных           = Параметры.ПроцедураПроверкиСхемыКомпоновкиДанных;
	ПроцедураПриИнициализацииНастроекКомпоновки      = Параметры.ПроцедураПриИнициализацииНастроекКомпоновки;
	СхемаКомпоновкиДанныхСодержитКритическиеОшибки   = Ложь;
	
	// Заголовок формы
	Заголовок = Параметры.Заголовок;
	
	ИмяТекущегоШаблонаСКД           	  = Параметры.ИмяШаблонаСКД;
	ВозвращатьИмяТекущегоШаблонаСКД 	  = Параметры.ВозвращатьИмяТекущегоШаблонаСКД;
	ВозвращатьПолноеИмяТекущегоШаблонаСКД = Параметры.ВозвращатьПолноеИмяТекущегоШаблонаСКД;
	
	// Заполнение списка шаблонов
	Если НЕ Параметры.ИсточникШаблонов = Неопределено Тогда
		
		ПолноеИмяИсточникаШаблонов = ОбщегоНазначения.ИмяТаблицыПоСсылке(Параметры.ИсточникШаблонов);
		МенеджерИсточникаШаблонов = ОбщегоНазначения.МенеджерОбъектаПоСсылке(Параметры.ИсточникШаблонов);
		
		Для каждого МакетШаблона Из МенеджерИсточникаШаблонов.ШаблоныСхемыКомпоновкиДанных() Цикл
			
			НоваяСтрока = Шаблоны.Добавить();
			НоваяСтрока.Синоним = МакетШаблона.Синоним;
			НоваяСтрока.Имя = МакетШаблона.Имя;
			Если МакетШаблона.Свойство("ПолноеИмяИсточникаШаблонов") И ЗначениеЗаполнено(МакетШаблона.ПолноеИмяИсточникаШаблонов) Тогда				
				НоваяСтрока.ПолноеИмяИсточникаШаблонов = МакетШаблона.ПолноеИмяИсточникаШаблонов;				
			Иначе
				НоваяСтрока.ПолноеИмяИсточникаШаблонов = ПолноеИмяИсточникаШаблонов;			
			КонецЕсли; 
			НоваяСтрока.ПолноеИмя = НоваяСтрока.ПолноеИмяИсточникаШаблонов + "." + НоваяСтрока.Имя;
			Если ВозвращатьПолноеИмяТекущегоШаблонаСКД Тогда
				Элементы.ТекущийШаблонСхемыКомпоновкиДанных.СписокВыбора.Добавить(НоваяСтрока.ПолноеИмя, НоваяСтрока.Синоним);
			Иначе
				Элементы.ТекущийШаблонСхемыКомпоновкиДанных.СписокВыбора.Добавить(НоваяСтрока.Имя, НоваяСтрока.Синоним);
			КонецЕсли; 			
		КонецЦикла;
		
		Если ПустаяСтрока(ИмяТекущегоШаблонаСКД) Тогда
			
			Элементы.ТекущийШаблонСхемыКомпоновкиДанных.СписокВыбора.Добавить("", НСтр("ru = 'Произвольная'"));
			
		КонецЕсли;
		
		ТекущийШаблонСхемыКомпоновкиДанных = ИмяТекущегоШаблонаСКД;
		Элементы.ТекущийШаблонСхемыКомпоновкиДанных.Видимость = Истина;
		
	Иначе
		
		Элементы.ТекущийШаблонСхемыКомпоновкиДанных.Видимость = Ложь;
		
	КонецЕсли;
	
	// Исходная схема компоновки данных копируется в редактируемую схему компоновки данных.
	СкопироватьСхемуКомпоновкиДанных(АдресРедактируемойСхемыКомпоновкиДанных, АдресИсходнойСхемыКомпоновкиДанных);
	
	// Компоновщик настроек инициализируется редактируемой схемой компоновки данных
	ИнициализироватьКомпоновщикНастроек(КомпоновщикНастроек,
	                                    АдресРедактируемойСхемыКомпоновкиДанных,
	                                    Параметры.АдресНастроекКомпоновкиДанных,
	                                    ПроцедураПриИнициализацииНастроекКомпоновки);
	
	Элементы.РедактироватьСхемуКомпоновки.Видимость = Не Параметры.НеРедактироватьСхемуКомпоновкиДанных;
	Элементы.ФормаЗагрузитьСхемуИзФайла.Видимость   = Не Параметры.НеЗагружатьСхемуКомпоновкиДанныхИзФайла;
	
	Элементы.ГруппаОтбор.Видимость                  = Не Параметры.НеНастраиватьОтбор;
	Элементы.ГруппаПараметры.Видимость              = Не Параметры.НеНастраиватьПараметры;
	Элементы.ГруппаПорядок.Видимость                = Не Параметры.НеНастраиватьПорядок;
	Элементы.ГруппаУсловноеОформление.Видимость     = Не Параметры.НеНастраиватьУсловноеОформление;
	Элементы.ГруппаПоля.Видимость                   = Не Параметры.НеНастраиватьВыбор;
	Если ОбщегоНазначения.РазделениеВключено() Тогда
		Элементы.РедактироватьСхемуКомпоновки.Видимость = Ложь;
		Элементы.ФормаЗагрузитьСхемуИзФайла.Видимость = Ложь;
	КонецЕсли; 
	НеПомещатьНастройкиВСхемуКомпоновкиДанных = Параметры.НеПомещатьНастройкиВСхемуКомпоновкиДанных;
	
	ТолькоПросмотр = Параметры.ТолькоПросмотр;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ИзмененаСхемаКомпоновкиДанных(Форма, СхемаКомпоновкиДанных)
	
	// Получена схема из конструктора схемы компоновки данных
	Форма.Модифицированность = Истина;
	Форма.РедактируемаяСхемаКомпоновкиДанныхМодифицированность = Истина;
	
	// Редактируемая схема компоновки данных замещается схемой, полученной из конструктора.
	БылиИзменения = Ложь;
	
	Если НЕ ПустаяСтрока(Форма.ПроцедураПроверкиСхемыКомпоновкиДанных) Тогда
		Форма.СписокКритическихОшибокСхемыКомпоновки.Очистить();
		ПараметрыПроверки = Новый Структура;
		ПараметрыПроверки.Вставить("ИдентификаторФормы", Форма.УникальныйИдентификатор);
		ПараметрыПроверки.Вставить("ИмяМетода", Форма.ПроцедураПроверкиСхемыКомпоновкиДанных);
		ПараметрыПроверки.Вставить("ЕстьКритическиеОшибки", Форма.СхемаКомпоновкиДанныхСодержитКритическиеОшибки);
		ПараметрыПроверки.Вставить("СписокКритическихОшибокСхемыКомпоновки", Форма.СписокКритическихОшибокСхемыКомпоновки);
		ВыполнитьМетодПроверкиСхемыКомпоновкиДанных(СхемаКомпоновкиДанных, ПараметрыПроверки);
		Форма.СхемаКомпоновкиДанныхСодержитКритическиеОшибки = ПараметрыПроверки.ЕстьКритическиеОшибки;
		Форма.СписокКритическихОшибокСхемыКомпоновки = ПараметрыПроверки.СписокКритическихОшибокСхемыКомпоновки;
	КонецЕсли;
	
	УстановитьСхемуКомпоновкиДанных(Форма.АдресРедактируемойСхемыКомпоновкиДанных, СхемаКомпоновкиДанных, Истина, БылиИзменения);
	
	Если БылиИзменения Тогда
		
		Если Форма.Элементы.ТекущийШаблонСхемыКомпоновкиДанных.СписокВыбора.НайтиПоЗначению("") = Неопределено Тогда
			Форма.Элементы.ТекущийШаблонСхемыКомпоновкиДанных.СписокВыбора.Добавить("", НСтр("ru = 'Произвольная'"));
		КонецЕсли;
		
		Форма.ИмяТекущегоШаблонаСКД = "";
		Форма.ТекущийШаблонСхемыКомпоновкиДанных = Форма.ИмяТекущегоШаблонаСКД;
		
	КонецЕсли;
	
	// Компоновщик настроек инициализируется редактируемой схемой
	ИнициализироватьКомпоновщикНастроек(Форма.КомпоновщикНастроек,
	                                    Форма.АдресРедактируемойСхемыКомпоновкиДанных,,
	                                    Форма.ПроцедураПриИнициализацииНастроекКомпоновки);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	#Если ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
		
		ОчиститьСообщения();
		ИзмененаСхемаКомпоновкиДанных(ЭтаФорма, ВыбранноеЗначение);
		
	#КонецЕсли
	
КонецПроцедуры

&НаСервере
Функция СформироватьСтруктуруВозврата()
	
	СтруктураВозврата = Новый Структура("АдресХранилищаНастройкиКомпоновщика, ИмяТекущегоШаблонаСКД");
	СтруктураВозврата.АдресХранилищаНастройкиКомпоновщика =  ПолучитьНастройкиКомпоновщика(КомпоновщикНастроек, УникальныйИдентификаторВладельца);
	СтруктураВозврата.ИмяТекущегоШаблонаСКД = ИмяТекущегоШаблонаСКД;
		
	Возврат СтруктураВозврата;
	
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КомпоновщикНастроекНастройкиОтборПриИзменении(Элемент)
	
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура КомпоновщикНастроекНастройкиОтборДоступныеПоляОтбораВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура КомпоновщикНастроекНастройкиПараметрыДанныхПриИзменении(Элемент)
	
	Модифицированность = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	Если СхемаКомпоновкиДанныхСодержитКритическиеОшибки Тогда
		ОчиститьСообщения();
		Для Каждого КритическаяОшибка Из СписокКритическихОшибокСхемыКомпоновки Цикл
			ОбщегоНазначенияКлиент.СообщитьПользователю(КритическаяОшибка.Значение);
		КонецЦикла;
		Возврат;
	КонецЕсли;
	
	Если РедактируемаяСхемаКомпоновкиДанныхМодифицированность Тогда
		
		Если Не НеПомещатьНастройкиВСхемуКомпоновкиДанных Тогда
			
			// Настройки компоновщика настроек помещаются в редактируемую схему
			Если НЕ ПустаяСтрока(ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных) Тогда
				ВыполнитьМетодПомещенияНастройкиВСхемуКомпоновкиДанных(ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных,
				                                                       КомпоновщикНастроек,
				                                                       АдресРедактируемойСхемыКомпоновкиДанных);
			Иначе
				ПоместитьНастройкиВСхемуКомпоновкиДанных(КомпоновщикНастроек, АдресРедактируемойСхемыКомпоновкиДанных);
			КонецЕсли;
			
		КонецЕсли;
		
		// Исходная схема замещается редактируемой схемой
		УстановитьСхемуКомпоновкиДанных(АдресИсходнойСхемыКомпоновкиДанных, АдресРедактируемойСхемыКомпоновкиДанных);
		
	Иначе
		
		// Настройки компоновщика настроек помещаются в исходную схему
		Если Не НеПомещатьНастройкиВСхемуКомпоновкиДанных Тогда
			
			Если НЕ ПустаяСтрока(ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных) Тогда
				ВыполнитьМетодПомещенияНастройкиВСхемуКомпоновкиДанных(ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных,
				                                                       КомпоновщикНастроек,
				                                                       АдресИсходнойСхемыКомпоновкиДанных);
			Иначе
				ПоместитьНастройкиВСхемуКомпоновкиДанных(КомпоновщикНастроек, АдресИсходнойСхемыКомпоновкиДанных);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Модифицированность = Ложь;
	
	Если ВозвращатьИмяТекущегоШаблонаСКД И ЗначениеЗаполнено(УникальныйИдентификаторВладельца) Тогда
		
		Закрыть(СформироватьСтруктуруВозврата());
		
	ИначеЕсли ЗначениеЗаполнено(УникальныйИдентификаторВладельца) Тогда
		
		Закрыть(ПолучитьНастройкиКомпоновщика(КомпоновщикНастроек, УникальныйИдентификаторВладельца));
		
	Иначе
		
		Закрыть(Неопределено);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьСхемуКомпоновки(Команда)
	
	ОткрытьКонструкторСхемыКомпоновкиДанных();
	
КонецПроцедуры

&НаКлиенте
Процедура ТекущийШаблонСхемыКомпоновкиДанныхОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ВыбранноеЗначение <> Неопределено И ВыбранноеЗначение <> ИмяТекущегоШаблонаСКД Тогда
		
		ТекстВопроса = НСтр("ru='Текущие настройки будут потеряны. Продолжить?'");
		ПоказатьВопрос(
			Новый ОписаниеОповещения("ТекущийШаблонСхемыКомпоновкиДанныхОбработкаВыбораЗавершение", 
				ЭтотОбъект, Новый Структура("ВыбранноеЗначение", ВыбранноеЗначение)), 
			ТекстВопроса, 
			РежимДиалогаВопрос.ДаНет, 
			, 
			КодВозвратаДиалога.Нет);
		
		СтандартнаяОбработка = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТекущийШаблонСхемыКомпоновкиДанныхОбработкаВыбораЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	ВыбранноеЗначение = ДополнительныеПараметры.ВыбранноеЗначение;
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		
		Если ВозвращатьПолноеИмяТекущегоШаблонаСКД Тогда
			НайденныеСтроки = Шаблоны.НайтиСтроки(Новый Структура("ПолноеИмя", ВыбранноеЗначение));
		Иначе
			НайденныеСтроки = Шаблоны.НайтиСтроки(Новый Структура("Имя", ВыбранноеЗначение));
		КонецЕсли;
		
		Если НайденныеСтроки.Количество() = 0 Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				НСтр("ru='Ошибка загрузки шаблона. Выберите другой шаблон.'"),
				,
				"ТекущийШаблонСхемыКомпоновкиДанных");
			Возврат;
		КонецЕсли;
		
		ЗагрузитьИзМакета(НайденныеСтроки[0].ПолноеИмяИсточникаШаблонов,
		                  НайденныеСтроки[0].Имя,
		                  КомпоновщикНастроек,
		                  АдресРедактируемойСхемыКомпоновкиДанных,
		                  ПроцедураПриИнициализацииНастроекКомпоновки);
		
		Модифицированность = Истина;
		РедактируемаяСхемаКомпоновкиДанныхМодифицированность = Истина;
		ИмяТекущегоШаблонаСКД = ВыбранноеЗначение;
		ТекущийШаблонСхемыКомпоновкиДанных = ВыбранноеЗначение;
		
		ПустойЭлемент =  Элементы.ТекущийШаблонСхемыКомпоновкиДанных.СписокВыбора.НайтиПоЗначению("");
		Если ПустойЭлемент <> Неопределено Тогда
			Элементы.ТекущийШаблонСхемыКомпоновкиДанных.СписокВыбора.Удалить(ПустойЭлемент);
		КонецЕсли;
		
	Иначе
		
		ТекущийШаблонСхемыКомпоновкиДанных = ИмяТекущегоШаблонаСКД;
		
	КонецЕсли;
	
КонецПроцедуры

#Область ПроцедурыИФункцииОбщегоНазначения

&НаКлиенте
Процедура ОткрытьКонструкторСхемыКомпоновкиДанных()
	
	#Если ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
		
		// Настройки компоновщика настроек помещаются в редактируемую схему
		Если Не НеПомещатьНастройкиВСхемуКомпоновкиДанных Тогда
			Если НЕ ПустаяСтрока(ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных) Тогда
				ВыполнитьМетодПомещенияНастройкиВСхемуКомпоновкиДанных(ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных,
				                                                       КомпоновщикНастроек,
				                                                       АдресРедактируемойСхемыКомпоновкиДанных);
			Иначе
				ПоместитьНастройкиВСхемуКомпоновкиДанных(КомпоновщикНастроек, АдресРедактируемойСхемыКомпоновкиДанных);
			КонецЕсли;
		КонецЕсли;
		
		// Создается копия редактируемой схемы
		СхемаКомпоновкиДанных = СериализаторXDTO.ПрочитатьXDTO(СериализаторXDTO.ЗаписатьXDTO(ПолучитьИзВременногоХранилища(АдресРедактируемойСхемыКомпоновкиДанных)));
		
		// Копия редактируемой схемы открывается в конструкторе
		Конструктор = Новый КонструкторСхемыКомпоновкиДанных(СхемаКомпоновкиДанных);
		Конструктор.Редактировать(ЭтаФорма);
		
	#Иначе
		
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Для того, чтобы редактировать схему компоновки, необходимо запустить конфигурацию в режиме толстого клиента.'"));
		
	#КонецЕсли
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УстановитьСхемуКомпоновкиДанных(АдресПриемник, АдресСхемаИсточник, ПроверятьНаИзменение = Ложь, БылиИзменения = Ложь)
	
	Если ЭтоАдресВременногоХранилища(АдресСхемаИсточник) Тогда
		
		СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресСхемаИсточник);
		
	Иначе
		
		СхемаКомпоновкиДанных = АдресСхемаИсточник;
		
	КонецЕсли;
	
	Если ПроверятьНаИзменение Тогда
		
		БылиИзменения = Ложь;
		
		Если ЭтоАдресВременногоХранилища(АдресПриемник) Тогда
			
			ТекущаяСКД = ПолучитьИзВременногоХранилища(АдресПриемник);
			Если ТипЗнч(ТекущаяСКД) = Тип("СхемаКомпоновкиДанных") Тогда
				
				Если СегментыСервер.ПолучитьXML(СхемаКомпоновкиДанных) <> СегментыСервер.ПолучитьXML(ТекущаяСКД) Тогда
					
					БылиИзменения = Истина;
					
				КонецЕсли
				
			Иначе
				
				БылиИзменения = Истина;
				
			КонецЕсли;
			
		Иначе
			
			БылиИзменения = Истина;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если ЭтоАдресВременногоХранилища(АдресПриемник) Тогда
		
		ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, АдресПриемник);
		
	Иначе
		
		АдресПриемник = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, Новый УникальныйИдентификатор);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СкопироватьСхемуКомпоновкиДанных(АдресПриемник, АдресИсточник)
	
	СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресИсточник);
	
	Если ТипЗнч(СхемаКомпоновкиДанных) = Тип("СхемаКомпоновкиДанных") Тогда
		
		СхемаКомпоновкиДанных = СериализаторXDTO.ПрочитатьXDTO(СериализаторXDTO.ЗаписатьXDTO(СхемаКомпоновкиДанных));
		
	Иначе
		
		СхемаКомпоновкиДанных = Новый СхемаКомпоновкиДанных;
		
	КонецЕсли;
	
	Если ЭтоАдресВременногоХранилища(АдресПриемник) Тогда
		
		ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, АдресПриемник);
		
	Иначе
		
		АдресПриемник = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, Новый УникальныйИдентификатор);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ИнициализироватьКомпоновщикНастроек(КомпоновщикНастроек, АдресСхемыКомпоновкиДанных, АдресНастроекКомпоновкиДанных = Неопределено, ПроцедураПриИнициализацииНастроекКомпоновки = "")
	
	СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновкиДанных);
	Если ЗначениеЗаполнено(АдресНастроекКомпоновкиДанных) Тогда
		НастройкиКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресНастроекКомпоновкиДанных);
	КонецЕсли;
	
	Попытка
		КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемыКомпоновкиДанных));
	Исключение
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Выполнение операции'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
					УровеньЖурналаРегистрации.Ошибка,,,
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	Если ЗначениеЗаполнено(АдресНастроекКомпоновкиДанных) Тогда
		КомпоновщикНастроек.ЗагрузитьНастройки(НастройкиКомпоновкиДанных);
	Иначе
		КомпоновщикНастроек.ЗагрузитьНастройки(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ПроцедураПриИнициализацииНастроекКомпоновки) Тогда
		ВыполнитьМетодПриИнициализацииНастроекКомпоновки(ПроцедураПриИнициализацииНастроекКомпоновки,
		                                                 СхемаКомпоновкиДанных,
		                                                 КомпоновщикНастроек);
	КонецЕсли;
	
	КомпоновщикНастроек.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПоместитьНастройкиВСхемуКомпоновкиДанных(КомпоновщикНастроек, АдресСхемыКомпоновкиДанных)
	
	КомпоновщикНастроек.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	
	СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновкиДанных);
	
	КомпоновкаДанныхКлиентСервер.ОчиститьНастройкиКомпоновкиДанных(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
	КомпоновкаДанныхКлиентСервер.СкопироватьНастройкиКомпоновкиДанных(СхемаКомпоновкиДанных.НастройкиПоУмолчанию, КомпоновщикНастроек.Настройки);
	
	ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, АдресСхемыКомпоновкиДанных);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьНастройкиКомпоновщика(КомпоновщикНастроек, УникальныйИдентификатор)
	
	КомпоновщикНастроек.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	
	Возврат ПоместитьВоВременноеХранилище(КомпоновщикНастроек.ПолучитьНастройки(), УникальныйИдентификатор);
	
КонецФункции

&НаСервереБезКонтекста
Процедура ВыполнитьМетодПомещенияНастройкиВСхемуКомпоновкиДанных(ИмяПроцедурыПомещения, КомпоновщикНастроек, АдресСхемыКомпоновкиДанных)
	
	СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновкиДанных);
	
	ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("СхемаКомпоновкиДанных", СхемаКомпоновкиДанных);
	ПараметрыМетода.Вставить("КомпоновщикНастроек", КомпоновщикНастроек);
	
	ВызовПроцедуры = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		"%1(Параметры.%2, Параметры.%3)",
		ИмяПроцедурыПомещения,
		"СхемаКомпоновкиДанных",
		"КомпоновщикНастроек");
		
	ОбщегоНазначения.ВыполнитьВБезопасномРежиме(ВызовПроцедуры, ПараметрыМетода);
	
	ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, АдресСхемыКомпоновкиДанных);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ВыполнитьМетодПроверкиСхемыКомпоновкиДанных(СхемаКомпоновкиДанных, ПараметрыПроверки)
	
	ИдентификаторФормы = ПараметрыПроверки.ИдентификаторФормы;
	ИмяМетода = ПараметрыПроверки.ИмяМетода;
	ЕстьКритическиеОшибки = ПараметрыПроверки.ЕстьКритическиеОшибки;
	СписокКритическихОшибокСхемыКомпоновки = ПараметрыПроверки.СписокКритическихОшибокСхемыКомпоновки;
	
	ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("СхемаКомпоновкиДанных", СхемаКомпоновкиДанных);
	ПараметрыМетода.Вставить("ЕстьКритическиеОшибки", Ложь);
	ПараметрыМетода.Вставить("СписокКритическихОшибокСхемыКомпоновки", Новый СписокЗначений);
	ПараметрыМетода.Вставить("СписокПрочихСообщений", Новый СписокЗначений);
	
	ВызовПроцедуры = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		"%1(Параметры.%2, Параметры.%3, Параметры.%4, Параметры.%5)",
		ИмяМетода,
		"СхемаКомпоновкиДанных",
		"ЕстьКритическиеОшибки",
		"СписокКритическихОшибокСхемыКомпоновки",
		"СписокПрочихСообщений");
	
	//ОбщегоНазначения.ВыполнитьМетодКонфигурации(ИмяМетода, ПараметрыМетода);
	ОбщегоНазначения.ВыполнитьВБезопасномРежиме(ВызовПроцедуры, ПараметрыМетода);
	
	ПараметрыПроверки.ЕстьКритическиеОшибки = ПараметрыМетода.ЕстьКритическиеОшибки;
	ПараметрыПроверки.СписокКритическихОшибокСхемыКомпоновки = ПараметрыМетода.СписокКритическихОшибокСхемыКомпоновки;
	
	Если ПараметрыМетода.ЕстьКритическиеОшибки Тогда
		Для Каждого КритическаяОшибка Из ПараметрыМетода.СписокКритическихОшибокСхемыКомпоновки Цикл
			СообщениеПользователю = Новый СообщениеПользователю;
			СообщениеПользователю.Текст = КритическаяОшибка.Значение;
			СообщениеПользователю.ИдентификаторНазначения = ИдентификаторФормы;
			СообщениеПользователю.Сообщить();
		КонецЦикла;
	КонецЕсли;
	Если ПараметрыМетода.СписокПрочихСообщений.Количество() > 0 Тогда
		Для Каждого СообщениеПроверки Из ПараметрыМетода.СписокПрочихСообщений Цикл
			СообщениеПользователю = Новый СообщениеПользователю;
			СообщениеПользователю.Текст = СообщениеПроверки.Значение;
			СообщениеПользователю.ИдентификаторНазначения = ИдентификаторФормы;
			СообщениеПользователю.Сообщить();
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ВыполнитьМетодПриИнициализацииНастроекКомпоновки(ИмяМетода, СхемаКомпоновкиДанных, КомпоновщикНастроек)
	
	ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("СхемаКомпоновкиДанных", СхемаКомпоновкиДанных);
	ПараметрыМетода.Вставить("КомпоновщикНастроек", КомпоновщикНастроек);
	
	ВызовПроцедуры = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		"%1(Параметры.%2, Параметры.%3)",
		ИмяМетода,
		"СхемаКомпоновкиДанных",
		"КомпоновщикНастроек");
		
	ОбщегоНазначения.ВыполнитьВБезопасномРежиме(ВызовПроцедуры, ПараметрыМетода);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗагрузитьИзМакета(ПолноеИмяИсточникаШаблонов, ИмяМакета, КомпоновщикНастроек, АдресСхемыКомпоновкиДанных, ПроцедураПриИнициализацииНастроекКомпоновки)
	
	ПоместитьВоВременноеХранилище(ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмяИсточникаШаблонов).ПолучитьМакет(ИмяМакета), АдресСхемыКомпоновкиДанных);
	ИнициализироватьКомпоновщикНастроек(КомпоновщикНастроек,
	                                    АдресСхемыКомпоновкиДанных,,
	                                    ПроцедураПриИнициализацииНастроекКомпоновки);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если Модифицированность Тогда
		
		ПоказатьВопрос(Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект), 
			НСтр("ru='Вся несохраненная информация будет потеряна. Все равно закрыть?'"),
			РежимДиалогаВопрос.ДаНет);
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		Модифицированность = Ложь;
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСхемуИзФайлаНаСервере(ТекстXML)
	
	Попытка
		
		ЧтениеXML = Новый ЧтениеXML();
		ЧтениеXML.УстановитьСтроку(ТекстXML);
		СхемаКомпоновкиДанных = СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
		ИзмененаСхемаКомпоновкиДанных(ЭтаФорма, СхемаКомпоновкиДанных);
		
	Исключение
		
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Выполнение операции'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
					УровеньЖурналаРегистрации.Ошибка,,,
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	
	КонецПопытки;
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСхемуИзФайлаНаСервереВеб(АдресФайлаВоВременномХранилище)
	
	Попытка
		
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресФайлаВоВременномХранилище);
		
		ИмяВременногоФайла = ПолучитьИмяВременногоФайла("xml");
		ДвоичныеДанные.Записать(ИмяВременногоФайла);
		
		ТекстовыйДокумент = Новый ТекстовыйДокумент;
		ТекстовыйДокумент.Прочитать(ИмяВременногоФайла, КодировкаТекста.UTF8);
		ТекстXML = ТекстовыйДокумент.ПолучитьТекст();
		
		ЧтениеXML = Новый ЧтениеXML();
		ЧтениеXML.УстановитьСтроку(ТекстXML);
		
		СхемаКомпоновкиДанных = СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
		ИзмененаСхемаКомпоновкиДанных(ЭтаФорма, СхемаКомпоновкиДанных);
		
		УдалитьФайлы(ИмяВременногоФайла);
		
	Исключение		
		
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Выполнение операции'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
					УровеньЖурналаРегистрации.Ошибка,,,
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке())); 	
		
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСхемуИзФайла(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ЗагрузитьСхемуИзФайлаРасширениеПодключено",
		ЭтотОбъект);
	
	НачатьПодключениеРасширенияРаботыСФайлами(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСхемуИзФайлаРасширениеПодключено(Подключено, ДополнительныеПараметры) Экспорт
	
	Если Подключено Тогда
		
		ВыборФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
		ВыборФайла.ПолноеИмяФайла = "";
		ВыборФайла.Заголовок = НСтр("ru = 'Выбор схемы компоновки данных'");
		ВыборФайла.Фильтр = НСтр("ru = 'Схема компоновки данных (*.xml)|*.xml'");
		
		ОписаниеОповещения = Новый ОписаниеОповещения(
			"ЗагрузитьСхемуИзФайлаВыборФайла",
			ЭтотОбъект);
		
		ВыборФайла.Показать(ОписаниеОповещения);
		
	Иначе
		
		#Если ВебКлиент Тогда
			
			АдресФайлаВоВременномХранилище = "";
			ИмяФайла = "";
			НачатьПомещениеФайла(
				Новый ОписаниеОповещения(
					"ЗагрузитьСхемуИзФайлаЗавершение",
					ЭтотОбъект,
					Новый Структура("АдресФайлаВоВременномХранилище", АдресФайлаВоВременномХранилище)),
				АдресФайлаВоВременномХранилище,
				ИмяФайла,
				Истина,
				УникальныйИдентификатор);
			
		#КонецЕсли
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСхемуИзФайлаВыборФайла(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ТекстовыйДокумент", ТекстовыйДокумент);
	
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ЗагрузитьСхемуИзФайлаВыборФайлаЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ТекстовыйДокумент.НачатьЧтение(ОповещениеОЗавершении, ВыбранныеФайлы[0], КодировкаТекста.UTF8);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСхемуИзФайлаВыборФайлаЗавершение(ДополнительныеПараметры) Экспорт
	
	ТекстовыйДокумент = ДополнительныеПараметры.ТекстовыйДокумент;
	
	Текст = ТекстовыйДокумент.ПолучитьТекст();
	
	ОчиститьСообщения();
	ЗагрузитьСхемуИзФайлаНаСервере(Текст);

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСхемуИзФайлаЗавершение(Результат, Адрес, ИмяФайла, ДополнительныеПараметры) Экспорт
	
	АдресФайлаВоВременномХранилище = ДополнительныеПараметры.АдресФайлаВоВременномХранилище;
	
	Если НЕ Результат Тогда
		Возврат;
	КонецЕсли;
	
	ОчиститьСообщения();
	ЗагрузитьСхемуИзФайлаНаСервереВеб(АдресФайлаВоВременномХранилище);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
