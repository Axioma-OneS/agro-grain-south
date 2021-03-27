﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеШаблона = Параметры.ДанныеШаблона;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// ПодключаемоеОборудование
	ПоддерживаемыеТипыВО = Новый Массив();
	ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
	ОповещенияПриПодключении = Новый ОписаниеОповещения("ПодключитьОборудованиеЗавершение", ЭтотОбъект);    
	МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПоТипу(ОповещенияПриПодключении, УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

&НаКлиенте
Процедура ПодключитьОборудованиеЗавершение(РезультатВыполнения, Параметры) Экспорт
	
	Если Не РезультатВыполнения.Результат Тогда
		ТекстСообщения = НСтр( "ru = 'При подключении оборудования произошла ошибка:
				|""%ОписаниеОшибки%"".'" );
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%" , РезультатВыполнения.ОписаниеОшибки);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	// ПодключаемоеОборудование
	ПоддерживаемыеТипыВО = Новый Массив();
	ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
	МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПоТипу(Неопределено, УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры


// Проверяет код на соответствие шаблону.
// 
// Параметры:
// 	ДанныеДорожек - Массив - .
// 	ДанныеШаблона - Произвольный - где:
// 	*Ссылка - СправочникСсылка.ШаблоныМагнитныхКарт - .
// Возвращаемое значение:
// 	Булево - Описание
&НаКлиенте
Функция КодСоответствуетШаблонуМК(ДанныеДорожек, ДанныеШаблона)
	
	ОднаДорожкаПрисутствует = Ложь;
	ПроверкаПройдена = Истина;
	
	Для Итератор = 1 По 3 Цикл
		Если ДанныеШаблона["ДоступностьДорожки"+Строка(Итератор)] Тогда
			ОднаДорожкаПрисутствует = Истина;
			текСтрока = ДанныеДорожек[Итератор - 1];
			Если Прав(текСтрока, СтрДлина(ДанныеШаблона["Суффикс" + Строка(Итератор)])) <> ДанныеШаблона["Суффикс" + Строка(Итератор)] Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Дорожка'") + Символы.НПП + Строка(Итератор) 
					+ ". "+НСтр("ru='Суффикс карты не соответствует суффиксу шаблона.'"));
				ПроверкаПройдена = Ложь;
			КонецЕсли;
			
			Если Лев(текСтрока, СтрДлина(ДанныеШаблона["Префикс" + Строка(Итератор)])) <> ДанныеШаблона["Префикс" + Строка(Итератор)] Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Дорожка'") + Символы.НПП + Строка(Итератор) 
					+ ". " + НСтр("ru='Префикс карты не соответствует префиксу шаблона.'"));
				ПроверкаПройдена = Ложь;
			КонецЕсли;
			
			Если Найти(текСтрока, ДанныеШаблона["РазделительБлоков"+Строка(Итератор)]) = 0 Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Дорожка'") + Символы.НПП + Строка(Итератор) 
					+ ". "+НСтр("ru='Разделитель блоков карты не соответствует разделителю блоков шаблона.'"));
				ПроверкаПройдена = Ложь;
			КонецЕсли;
				
			Если СтрДлина(текСтрока) <> ДанныеШаблона["ДлинаКода"+Строка(Итератор)] Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Дорожка'") + Символы.НПП + Строка(Итератор) 
					+ ". " + НСтр("ru='Длина кода карты не соответствует длине кода шаблона.'"));
				ПроверкаПройдена = Ложь;
			КонецЕсли;
			
			Если НЕ ПроверкаПройдена Тогда
				Возврат Ложь;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Если ОднаДорожкаПрисутствует Тогда 
		Возврат Истина;
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='В шаблоне не указано ни одной доступной дорожки.'"));
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование"
	   И ВводДоступен() Тогда
		Если ИмяСобытия = "TracksData" Тогда
			Если Параметр[1] = Неопределено Тогда
				ДанныеДорожек = Параметр[0];
			Иначе
				ДанныеДорожек = Параметр[1][1];
			КонецЕсли;
			
			ОчиститьСообщения();
			Если НЕ КодСоответствуетШаблонуМК(ДанныеДорожек, ДанныеШаблона) Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Карта не соответствует шаблону.'"));
				Возврат;
			КонецЕсли;
			
			// Выводим зашифрованные поля
			Если Параметр[1][3] = Неопределено
				ИЛИ Параметр[1][3].Количество() = 0 Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Не удалось распознать ни одного поля. Возможно, поля шаблона настроены неверно.'"));
			Иначе
				НайденШаблон = Неопределено;
				Для каждого текШаблон Из Параметр[1][3] Цикл
					Если текШаблон.Шаблон = ДанныеШаблона.Ссылка Тогда
						НайденШаблон = текШаблон;
					КонецЕсли;
				КонецЦикла;
				Если НайденШаблон = Неопределено Тогда
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Код не соответствует данному шаблону. Возможно, шаблон настроен неверно.'"));
				Иначе
					ТекстСообщения = НСтр("ru='Карта соответствует шаблону и содержит следующие поля:'")+Символы.ПС+Символы.ПС;
					Итератор = 1;
					Для каждого текПоле Из НайденШаблон.ДанныеДорожек Цикл
						ТекстСообщения = ТекстСообщения + Строка(Итератор)+". "+?(ЗначениеЗаполнено(текПоле.Поле), Строка(текПоле.Поле), "")+" = "+Строка(текПоле.ЗначениеПоля)+Символы.ПС;
						Итератор = Итератор + 1;
					КонецЦикла;
					ПоказатьПредупреждение(,ТекстСообщения, , НСтр("ru='Результат расшифровки кода карты'"));
				КонецЕсли;
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
КонецПроцедуры

&НаКлиенте
Процедура ВнешнееСобытие(Источник, Событие, Данные)
	
	Если ВводДоступен() Тогда
		
		ОписаниеСобытия = Новый Структура();
		ОписаниеОшибки  = "";
		ОписаниеСобытия.Вставить("Источник", Источник);
		ОписаниеСобытия.Вставить("Событие",  Событие);
		ОписаниеСобытия.Вставить("Данные",   Данные);
		
		Результат = МенеджерОборудованияКлиент.ПолучитьСобытиеОтУстройства(ОписаниеСобытия, ОписаниеОшибки);
		Если Результат = Неопределено Тогда 
			ТекстСообщения = НСтр("ru = 'При обработке внешнего события от устройства произошла ошибка:'")
								+ Символы.ПС + ОписаниеОшибки;
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Иначе
			ОбработкаОповещения(Результат.ИмяСобытия, Результат.Параметр, Результат.Источник);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти