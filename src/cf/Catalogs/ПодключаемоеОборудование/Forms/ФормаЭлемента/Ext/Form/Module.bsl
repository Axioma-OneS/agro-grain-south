﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ПравоДоступаСохранениеДанныхПользователя = ПравоДоступа("СохранениеДанныхПользователя", Метаданные);
	
	ЗапретИзмененияДрайвера = (Объект.Ссылка <> Справочники.ПодключаемоеОборудование.ПустаяСсылка());
	// Защита от изменения типа устройства если тип явно задан или экземпляр уже создан.
	Элементы.ТипОборудования.ТолькоПросмотр = ЗапретИзмененияДрайвера;
	// Защита от изменения обработчика драйвера уже созданного экземпляра устройства.
	Элементы.ДрайверОборудования.ТолькоПросмотр = ЗапретИзмененияДрайвера;
	
	// Возвращает флаг возможности использовать драйверов снятых с поддержки.
	ИспользоватьСнятыеСПоддержкиДрайвера = МенеджерОборудованияВызовСервераПереопределяемый.ВозможностьИспользоватьСнятыхСПоддержкиДрайверов();
	
	// Загрузка и установка списка доступных обработок.
	СписокДрайверов = ДрайвераПоТипуОборудования(Объект.ТипОборудования, НЕ ЗапретИзмененияДрайвера);
	Элементы.ДрайверОборудования.СписокВыбора.Очистить();
	
	ТипККТОборудование       = Перечисления.ТипыПодключаемогоОборудования.ККТ;
	ТипФРОборудование        = Перечисления.ТипыПодключаемогоОборудования.ФискальныйРегистратор;
	ТипПЧОборудование        = Перечисления.ТипыПодключаемогоОборудования.ПринтерЧеков;
	ТипККМОфлайнОборудование = Перечисления.ТипыПодключаемогоОборудования.ККМОфлайн;
	
	Для каждого СтрокаСписка Из СписокДрайверов Цикл
		Элементы.ДрайверОборудования.СписокВыбора.Добавить(СтрокаСписка.Значение, СтрокаСписка.Представление);
	КонецЦикла;

	// Перечисление стандартных типов.
	Для каждого ИмяПеречисления Из Метаданные.Перечисления.ТипыПодключаемогоОборудования.ЗначенияПеречисления Цикл
		СоответствиеТиповОборудования.Добавить(ИмяПеречисления.Синоним, ИмяПеречисления.Комментарий);
	КонецЦикла;
	
	ОрганизацияВидимость = Объект.ТипОборудования = ТипККТОборудование
						Или Объект.ТипОборудования = ТипФРОборудование
						Или Объект.ТипОборудования = ТипПЧОборудование
						Или Объект.ТипОборудования = ТипККМОфлайнОборудование;
	
	МенеджерОборудованияВызовСервераПереопределяемый.ЭкземплярОборудованияПриСозданииНаСервере(Объект, ЭтотОбъект, Отказ, Параметры, СтандартнаяОбработка);
	
	УстановитьВидимостьОрганизацииНаСервере();
	
	Элементы.СервисФискальногоНакопителя.Видимость = ЗначениеЗаполнено(Объект.Ссылка) И Объект.ТипОборудования = ТипККТОборудование И ПравоДоступаСохранениеДанныхПользователя;
	Элементы.ФормаНастроить.Видимость = ЗначениеЗаполнено(Объект.Ссылка) И ПравоДоступаСохранениеДанныхПользователя;
	Элементы.ГруппаПараметрыРегистрацииККТ.Видимость = ЗначениеЗаполнено(Объект.Ссылка) И Объект.ТипОборудования = ТипККТОборудование;
	
	Элементы.ПерейтиНаСайтИнструкции.Видимость = ОрганизацияВидимость;
	
	Если Объект.ТипОборудования = ТипККТОборудование Тогда
		ОбновитьПараметрыРегистрацииККТ();
	КонецЕсли;
	
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.УстройствоИспользуется);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.ТипОборудования);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.ТипОфлайнОборудования);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.ДрайверОборудования);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.Организация);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.РабочееМесто);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.Наименование);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.СерийныйНомер);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.СпособФорматноЛогическогоКонтроля);
	МенеджерОборудованияВызовСервера.ПодготовитьЭлементУправления(Элементы.ДопустимоеРасхождениеФорматноЛогическогоКонтроля);
	
	НастроитьТипОфлайнОборудования();
	
	Если ОбщегоНазначенияКлиентСервер.ЭтоМобильныйКлиент() Тогда
		Элементы.РабочееМесто.Видимость = Ложь;
		Элементы.СервисФискальногоНакопителя.Видимость = Ложь;
	КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	МенеджерОборудованияКлиентПереопределяемый.ЭкземплярОборудованияПриОткрытии(Объект, ЭтотОбъект, Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	МенеджерОборудованияКлиентПереопределяемый.ЭкземплярОборудованияПередЗакрытием(Объект, ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	МенеджерОборудованияВызовСервераПереопределяемый.ЭкземплярОборудованияПриЧтенииНаСервере(ТекущийОбъект,ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если Не Отказ И Модифицированность Тогда
		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;
	
	МенеджерОборудованияКлиентПереопределяемый.ЭкземплярОборудованияПередЗаписью(Объект, ЭтотОбъект, Отказ, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	МенеджерОборудованияВызовСервераПереопределяемый.ЭкземплярОборудованияПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	МенеджерОборудованияВызовСервераПереопределяемый.ЭкземплярОборудованияПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	Элементы.ФормаНастроить.Видимость = ЗначениеЗаполнено(Объект.Ссылка) И ПравоДоступаСохранениеДанныхПользователя;
	Элементы.СервисФискальногоНакопителя.Видимость   = Элементы.ФормаНастроить.Видимость И Объект.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ККТ;
	Элементы.ГруппаПараметрыРегистрацииККТ.Видимость = Элементы.СервисФискальногоНакопителя.Видимость;
	
	МенеджерОборудованияВызовСервераПереопределяемый.ЭкземплярОборудованияПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	МенеджерОборудованияКлиентПереопределяемый.ЭкземплярОборудованияПослеЗаписи(Объект, ЭтотОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	МенеджерОборудованияВызовСервераПереопределяемый.ЭкземплярОборудованияОбработкаПроверкиЗаполненияНаСервере(Объект, ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаНавигационнойСсылки(НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	МенеджерОборудованияКлиентПереопределяемый.ЭкземплярОборудованияОбработкаНавигационнойСсылки(Объект, ЭтотОбъект, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТипОборудованияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)

	Если Объект.ТипОборудования <> ВыбранноеЗначение Тогда
		Объект.ТипОборудования = ВыбранноеЗначение;
		Модифицированность = Истина;
		
		ЗаполнитьСписокДрайверов();
		
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ОрганизацияВидимость = Объект.ТипОборудования = ПредопределенноеЗначение("Перечисление.ТипыПодключаемогоОборудования.ККТ")
						Или Объект.ТипОборудования = ПредопределенноеЗначение("Перечисление.ТипыПодключаемогоОборудования.ФискальныйРегистратор")
						Или Объект.ТипОборудования = ПредопределенноеЗначение("Перечисление.ТипыПодключаемогоОборудования.ПринтерЧеков")
						Или Объект.ТипОборудования = ПредопределенноеЗначение("Перечисление.ТипыПодключаемогоОборудования.ККМОфлайн");
						
	Если НЕ ОрганизацияВидимость Тогда
		Объект.Организация = Неопределено;
	КонецЕсли;
	
	Элементы.ПерейтиНаСайтИнструкции.Видимость = ОрганизацияВидимость;
	
	МенеджерОборудованияКлиентПереопределяемый.ЭкземплярОборудованияТипОборудованияВыбор(Объект, ЭтотОбъект, ЭтотОбъект, Элемент, ВыбранноеЗначение);
	
	УстановитьВидимостьОрганизацииНаКлиенте();
	
	НастроитьТипОфлайнОборудования();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДрайверов()
	
	// Загрузка и установка списка доступных обработок.
	СписокДрайверов = ДрайвераПоТипуОборудования(Объект.ТипОборудования, НЕ ЗапретИзмененияДрайвера);
	Элементы.ДрайверОборудования.СписокВыбора.Очистить();
	Для каждого СтрокаСписка Из СписокДрайверов Цикл
		Элементы.ДрайверОборудования.СписокВыбора.Добавить(СтрокаСписка.Значение, СтрокаСписка.Представление);
	КонецЦикла;
	
	Объект.ДрайверОборудования = ПредопределенноеЗначение("Справочник.ДрайверыОборудования.ПустаяСсылка");
	Объект.Наименование = "";
	
КонецПроцедуры

&НаКлиенте
Процедура ДрайверОборудованияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ВыбранноеЗначение <> Объект.ДрайверОборудования Тогда
		ОбработатьВыборОбработчика(ВыбранноеЗначение, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбработатьВыборОбработчика(ВыбранныйОбработчик, СтандартнаяОбработка = Истина)

	Объект.Наименование = "'" + Строка(ВыбранныйОбработчик) + "'"
						+ ?(ПустаяСтрока(Строка(Объект.РабочееМесто)),
							"",
							" " + НСтр("ru='на'") + " " + Строка(Объект.РабочееМесто));

КонецПроцедуры

&НаКлиенте
Процедура Настроить(Команда)
	
	ОчиститьСообщения();
	
	НастроитьПодключаемоеОборудование();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьПараметрыРегистрацииККТ();
	
	Для Каждого ПараметрРегистрации Из Объект.ПараметрыРегистрации Цикл
		
		Параметр = ПараметрыРегистрацииККТ.Добавить();
		НаименованиеПараметра = ПараметрРегистрации.НаименованиеПараметра;
		ЗначениеПараметра     = ПараметрРегистрации.ЗначениеПараметра;
		
		Если НаименованиеПараметра = "РегистрационныйНомерККТ" Тогда
			НаименованиеПараметра = НСтр("ru='Регистрационный номер ККТ'")
		ИначеЕсли НаименованиеПараметра = "ОрганизацияНазвание" Тогда
			НаименованиеПараметра = НСтр("ru='Название организации'")
		ИначеЕсли НаименованиеПараметра = "ОрганизацияИНН" Тогда
			НаименованиеПараметра = НСтр("ru='ИНН организации'")
		ИначеЕсли НаименованиеПараметра = "АдресПроведенияРасчетов" Тогда
			НаименованиеПараметра = НСтр("ru='Адрес проведения расчетов'")
		ИначеЕсли НаименованиеПараметра = "КодыСистемыНалогообложения" Тогда
			НаименованиеПараметра = НСтр("ru='Системы налогообложения'");
			СистемыНалогообложения = СтрРазделить(ЗначениеПараметра, ",");
			ЗначениеПараметра = "";
			Для Каждого СистемаНалогообложения Из СистемыНалогообложения Цикл
				ЗначениеПараметра = ?(Не ПустаяСтрока(ЗначениеПараметра), ЗначениеПараметра + ",", "");
				Если Не ПустаяСтрока(СистемаНалогообложения) Тогда
					ЗначениеПараметра = ЗначениеПараметра + """"+ МенеджерОборудованияКлиентСервер.НаименованиеСистемыНалогообложения(Число(СистемаНалогообложения)) + """";
				КонецЕсли;
			КонецЦикла;
		ИначеЕсли НаименованиеПараметра = "ПризнакАвтономногоРежима" Тогда
			НаименованиеПараметра = НСтр("ru='Автономный режим'")
		ИначеЕсли НаименованиеПараметра = "ПризнакАвтоматическогоРежима" Тогда
			НаименованиеПараметра = НСтр("ru='Автоматический режим'")
		ИначеЕсли НаименованиеПараметра = "НомерАвтоматаДляАвтоматическогоРежима" Тогда
			НаименованиеПараметра = НСтр("ru='Номер автомата для автоматического режима'")
		ИначеЕсли НаименованиеПараметра = "ПризнакШифрованиеДанных" Тогда
			НаименованиеПараметра = НСтр("ru='Шифрование данных'")
		ИначеЕсли НаименованиеПараметра = "ПризнакРасчетовЗаУслуги" Тогда
			НаименованиеПараметра = НСтр("ru='Расчет за услуги'")
		ИначеЕсли НаименованиеПараметра = "ПризнакФормированияБСО" Тогда
			НаименованиеПараметра = НСтр("ru='Формирования БСО'")
		ИначеЕсли НаименованиеПараметра = "ПризнакРасчетовТолькоВИнтернет" Тогда
			НаименованиеПараметра = НСтр("ru='Расчет только в интернет'")
		ИначеЕсли НаименованиеПараметра = "ОрганизацияОФДИНН" Тогда
			НаименованиеПараметра = НСтр("ru='ОФД ИНН'")
		ИначеЕсли НаименованиеПараметра = "ОрганизацияОФДНазвание" Тогда
			НаименованиеПараметра = НСтр("ru='Наименование ОФД'")
		ИначеЕсли НаименованиеПараметра = "ЗаводскойНомерККТ" Тогда
			НаименованиеПараметра = НСтр("ru='Заводской номер ККТ'")
		ИначеЕсли НаименованиеПараметра = "ПризнакФискализации" Тогда
			НаименованиеПараметра = НСтр("ru='Признак фискализации'")
		ИначеЕсли НаименованиеПараметра = "ЗаводскойНомерФН" Тогда
			НаименованиеПараметра = НСтр("ru='Заводской номер ФН'")
		ИначеЕсли НаименованиеПараметра = "НомерДокументаФискализации" Тогда
			НаименованиеПараметра = НСтр("ru='Номер документа фискализации'")
		ИначеЕсли НаименованиеПараметра = "ДатаВремяФискализации" Тогда
			НаименованиеПараметра = НСтр("ru='Дата и время фискализации'")
		ИначеЕсли НаименованиеПараметра = "ВерсияФФДККТ" Тогда
			НаименованиеПараметра = НСтр("ru='Версия ФФД ККТ'")
		ИначеЕсли НаименованиеПараметра = "ВерсияФФДФН" Тогда
			НаименованиеПараметра = НСтр("ru='Версия ФФД ФН'")
		// ФФД 1.0.5 и ФФД  1.1
		ИначеЕсли НаименованиеПараметра = "МестоПроведенияРасчетов" Тогда
			НаименованиеПараметра = НСтр("ru='Место проведения расчетов'")
		ИначеЕсли НаименованиеПараметра = "ПродажаПодакцизногоТовара" Тогда
			НаименованиеПараметра = НСтр("ru='Продажа подакцизного товара'")
		ИначеЕсли НаименованиеПараметра = "ПроведенияАзартныхИгр" Тогда
			НаименованиеПараметра = НСтр("ru='Проведения азартных игр'")
		ИначеЕсли НаименованиеПараметра = "ПроведенияЛотерей" Тогда
			НаименованиеПараметра = НСтр("ru='Проведения лотерей'")
		ИначеЕсли НаименованиеПараметра = "ПризнакиАгента" Тогда
			НаименованиеПараметра = НСтр("ru='Признаки агента'")
		ИначеЕсли НаименованиеПараметра = "УстановкаПринтераВАвтомате" Тогда
			НаименованиеПараметра = НСтр("ru='Установка принтера в автомате'")
		КонецЕсли;
			
		Параметр.НаименованиеПараметра = НаименованиеПараметра;
		Параметр.ЗначениеПараметра     = ЗначениеПараметра;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьПодключаемоеОборудование()
	
	СообщениеОбОшибке = "";
	
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;
	
	Закрыть();
	
	МенеджерОборудованияКлиент.ВыполнитьНастройкуОборудования(Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОперацияФискальногоНакопителя_Завершение(РезультатВыполнения, Параметры) Экспорт
	
	ОчиститьСообщения();
	
	Если РезультатВыполнения.Результат Тогда
		ТекстСообщения = НСтр("ru='Операция завершена.'");
	Иначе
		ТекстСообщения = РезультатВыполнения.ОписаниеОшибки;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	
КонецПроцедуры

&НаКлиенте
Процедура ОперацияФискальногоНакопителя_Продолжить(РезультатВыполнения, Параметры) Экспорт
	
	Если РезультатВыполнения <> Неопределено И Тип(РезультатВыполнения) = Тип("Структура") Тогда
		ФискальноеУстройство = Объект.Ссылка;
		ОповещениеПриЗавершении = Новый ОписаниеОповещения("ОперацияФискальногоНакопителя_Завершение", ЭтотОбъект);
		МенеджерОборудованияКлиент.НачатьОперациюФНДляФискальногоУстройства(ОповещениеПриЗавершении, УникальныйИдентификатор, РезультатВыполнения, ФискальноеУстройство); 
	КонецЕсли;
	
	ЭтотОбъект.Прочитать();
	
КонецПроцедуры

&НаКлиенте
Процедура РегистрацияФискальногоНакопителя(Команда)
	
#Если ВебКлиент Тогда
	ПоказатьПредупреждение(, НСтр("ru='Данный функционал доступен только в режиме тонкого и толстого клиента.'"));
	Возврат;
#КонецЕсли
	
	ФискальноеУстройство = Объект.Ссылка;
	Если Не ЗначениеЗаполнено(ФискальноеУстройство) Тогда
		Возврат;
	КонецЕсли;               
	
	ПараметрыОперации = Новый Структура("ФискальноеУстройство, Организация, ТипОперации", ФискальноеУстройство, Объект.Организация, 1);
	Обработчик = Новый ОписаниеОповещения("ОперацияФискальногоНакопителя_Продолжить", ЭтотОбъект);
	ОткрытьФорму("Справочник.ПодключаемоеОборудование.Форма.ПараметрыФискализации", ПараметрыОперации,,,,,Обработчик, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеПараметровРегистрацииФискальногоНакопителя(Команда)
	
#Если ВебКлиент Тогда
	ПоказатьПредупреждение(, НСтр("ru='Данный функционал доступен только в режиме тонкого и толстого клиента.'"));
	Возврат;
#КонецЕсли

	ФискальноеУстройство = Объект.Ссылка;
	Если Не ЗначениеЗаполнено(ФискальноеУстройство) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОперации = Новый Структура("ФискальноеУстройство, ТипОперации", ФискальноеУстройство, 2);
	Обработчик = Новый ОписаниеОповещения("ОперацияФискальногоНакопителя_Продолжить", ЭтотОбъект);
	ОткрытьФорму("Справочник.ПодключаемоеОборудование.Форма.ПараметрыФискализации", ПараметрыОперации,,,,,Обработчик, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытиеФискальногоНакопителя(Команда)
	
#Если ВебКлиент Тогда
	ПоказатьПредупреждение(, НСтр("ru='Данный функционал доступен только в режиме тонкого и толстого клиента.'"));
	Возврат;
#КонецЕсли
	
	ФискальноеУстройство = Объект.Ссылка;
	Если Не ЗначениеЗаполнено(ФискальноеУстройство) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОперации = Новый Структура("ФискальноеУстройство, ТипОперации", ФискальноеУстройство, 3);
	Обработчик = Новый ОписаниеОповещения("ОперацияФискальногоНакопителя_Продолжить", ЭтотОбъект);
	ОткрытьФорму("Справочник.ПодключаемоеОборудование.Форма.ПараметрыФискализации", ПараметрыОперации,,,,,Обработчик, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимостьОрганизацииНаКлиенте()
	
	Элементы.Организация.Видимость = ОрганизацияВидимость;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьОрганизацииНаСервере()
	
	Элементы.Организация.Видимость = ОрганизацияВидимость;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьТипОфлайнОборудования()
	
	Если МенеджерОборудованияВызовСервера.ИспользуетсяПодсистемаОфлайнОборудования() Тогда
		
		Элементы.ТипОфлайнОборудования.ТолькоПросмотр = ЗапретИзмененияДрайвера;
		
		Если Объект.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ККМОфлайн Тогда
			Элементы.ТипОфлайнОборудования.Видимость = Истина;
			ЗаполнитьСписокТиповОфлайнОборудования();
		Иначе
			Элементы.ТипОфлайнОборудования.Видимость = Ложь;
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Объект.ТипОфлайнОборудования) Тогда
			ТипККМ = Перечисления["ТипыОфлайнОборудования"].ККМ;
			Объект.ТипОфлайнОборудования = ТипККМ;
		КонецЕсли;
		
	Иначе
		Элементы.ТипОфлайнОборудования.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьДрайвераОфлайнОборудования()
	
	Если МенеджерОборудованияВызовСервера.ИспользуетсяПодсистемаОфлайнОборудования() Тогда
		
		ЗаполнитьСписокДрайверов();
		
		ТипККМ = Перечисления["ТипыОфлайнОборудования"].ККМ;
		ТипПрайсЧекер = Перечисления["ТипыОфлайнОборудования"].ПрайсЧекер;
		
		Если Объект.ТипОфлайнОборудования = ТипККМ Тогда
			
		ИначеЕсли Объект.ТипОфлайнОборудования = ТипПрайсЧекер Тогда
			
			Элементы.ДрайверОборудования.СписокВыбора.Очистить();
			Элементы.ДрайверОборудования.СписокВыбора.Добавить(Справочники.ДрайверыОборудования.Драйвер1СККМOffline);
			
		Иначе
			Элементы.ДрайверОборудования.СписокВыбора.Очистить();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТипОфлайнОборудованияПриИзменении(Элемент)
	
	НастроитьДрайвераОфлайнОборудования();
	
КонецПроцедуры

&НаСервере
Функция ДрайвераПоТипуОборудования(ТипОборудования, ТолькоДоступные)
	
	СписокДрайверов = Новый СписокЗначений();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДрайверыОборудования.Ссылка,
		|	ДрайверыОборудования.Наименование,
		|	ДрайверыОборудования.ТипОборудования
		|ИЗ
		|	Справочник.ДрайверыОборудования КАК ДрайверыОборудования
		|ГДЕ
		|	(ДрайверыОборудования.ТипОборудования = &ТипОборудования)
		|	%УСЛОВИЕ1%
		|	%УСЛОВИЕ2%
		|УПОРЯДОЧИТЬ ПО ДрайверыОборудования.Наименование";
		
	Если ТолькоДоступные Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%УСЛОВИЕ1%", "И НЕ ДрайверыОборудования.ПометкаУдаления");
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%УСЛОВИЕ1%", "");
	КонецЕсли;
	
	Если НЕ ИспользоватьСнятыеСПоддержкиДрайвера Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%УСЛОВИЕ2%", "И НЕ ДрайверыОборудования.СнятСПоддержки");
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%УСЛОВИЕ2%", "");
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ТипОборудования", ТипОборудования);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СписокДрайверов.Добавить(ВыборкаДетальныеЗаписи.Ссылка, ВыборкаДетальныеЗаписи.Наименование);
	КонецЦикла;
	
	Возврат СписокДрайверов;

КонецФункции

&НаСервере
Процедура ЗаполнитьСписокТиповОфлайнОборудования()
	
	Если МенеджерОборудованияВызовСервера.ИспользуетсяПодсистемаОфлайнОборудования() Тогда
		
		МодульМенеджерОфлайнОборудованияПереопределяемый = ОбщегоНазначения.ОбщийМодуль("МенеджерОфлайнОборудованияПереопределяемый");
		ДоступныеТипыОборудования = МодульМенеджерОфлайнОборудованияПереопределяемый.ПолучитьДоступныеТипыОфлайнОборудования();
		
		Элементы.ТипОфлайнОборудования.СписокВыбора.Очистить();
		
		Для Каждого СтрокаСписка Из ДоступныеТипыОборудования Цикл
			Элементы.ТипОфлайнОборудования.СписокВыбора.Добавить(СтрокаСписка);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиНаСайтИнструкцииНажатие(Элемент)
	
	АдресЗагрузки = "https://its.1c.ru/db/metod81#browse:13:-1:2115:2511";
	ОбщегоНазначенияКлиент.ОткрытьНавигационнуюСсылку(АдресЗагрузки);
	
КонецПроцедуры

#КонецОбласти
