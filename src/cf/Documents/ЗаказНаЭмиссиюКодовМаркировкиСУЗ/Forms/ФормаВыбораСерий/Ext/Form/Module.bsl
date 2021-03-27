﻿//
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Номенклатура        = Параметры.Номенклатура;
	Характеристика      = Параметры.Характеристика;
	ТребуемоеКоличество = Параметры.ТребуемоеКоличествоНомеров;
	ВидПродукции        = Параметры.ВидПродукции;
	ЦветСтиляПояснения  = ЦветаСтиля.ПоясняющийТекст;
	ШрифтПояснения      = Новый Шрифт(,,,,Истина);
	
	КоличествоСимволовСерии = 0;
	Если ВидПродукции = Перечисления.ВидыПродукцииИС.Табак Тогда
		КоличествоСимволовСерии = 7;
	ИначеЕсли ВидПродукции = Перечисления.ВидыПродукцииИС.Фотоаппараты Тогда
		КоличествоСимволовСерии = 20;
	Иначе
		КоличествоСимволовСерии = 13;
	КонецЕсли;
	
	НомерСтроки = 0;
	Для Каждого СерийныйНомер Из Параметры.СерийныеНомера Цикл
		
		НомерСтроки = НомерСтроки + 1;
		НоваяСтрока = СерийныеНомера.Добавить();
		НоваяСтрока.СерийныйНомер = СерийныйНомер;
		НоваяСтрока.НомерСтроки = НомерСтроки;
		
	КонецЦикла;
	
	ОбновитьПоясняющийТекст(ЭтотОбъект);
	СформироватьМаскуДляВводСерийногоНомера();
	
	СобытияФормИСПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура СерийныеНомераПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьПоясняющийТекст(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СерийныеНомераПослеУдаления(Элемент)
	
	ОбновитьНумерациюТаблицыСерийныеНомера(ЭтотОбъект);
	ОбновитьПоясняющийТекст(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура СерийныеНомераПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, ЭтоГруппа, Параметр)
	
	ОчиститьСообщения();
	Если ТребуемоеКоличество <= СерийныеНомера.Количество() Тогда
		Отказ = Истина;
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru='Все серии уже указаны.'"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Готово(Команда)
	
	Отказ = Ложь;
	ПроконтролироватьФорматСерийныхНомеров(Отказ);
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	СписокСерийныхНомеров = Новый Массив;
	Для Каждого Строка Из СерийныеНомера Цикл
		Если Не ПустаяСтрока(Строка.СерийныйНомер) Тогда
			СписокСерийныхНомеров.Добавить(Строка.СерийныйНомер);
		КонецЕсли;
	КонецЦикла;
	
	Закрыть(СписокСерийныхНомеров);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьПоясняющийТекст(Форма)
	
	ШаблонСообщения = НСтр("ru = 'Серий указано: %1 из %2'");
	ТекстСообщения = СтрШаблон(ШаблонСообщения, Форма.СерийныеНомера.Количество(), Форма.ТребуемоеКоличество);
	
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(ТекстСообщения, Форма.ШрифтПояснения, Форма.ЦветСтиляПояснения));
	
	Форма.ПоясняющийТекст = Новый ФорматированнаяСтрока(МассивСтрок);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьНумерациюТаблицыСерийныеНомера(Форма)
	
	Для Каждого СтрокаТаблицы Из Форма.СерийныеНомера Цикл
		СтрокаТаблицы.НомерСтроки = Форма.СерийныеНомера.Индекс(СтрокаТаблицы) + 1
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СерийныеНомераПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	Если НоваяСтрока Тогда
		Элементы.СерийныеНомера.ТекущиеДанные.НомерСтроки = СерийныеНомера.Количество();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СформироватьМаскуДляВводСерийногоНомера()
	
	Маска = "";
	Для К = 1 По КоличествоСимволовСерии Цикл
		Маска = Маска + "N";
	КонецЦикла;
	
	Элементы.СерийныеНомераСерийныйНомер.Маска = Маска;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроконтролироватьФорматСерийныхНомеров(Отказ)
	
	ОчиститьСообщения();
	
	АлфавитСерийногоНомера = АлфавитСерийногоНомера();
	Для Каждого Строка Из СерийныеНомера Цикл
		
		КоличествоСимволов = СтрДлина(СокрЛП(Строка.СерийныйНомер));
		Если КоличествоСимволов < КоличествоСимволовСерии Тогда
			
			ШаблонОшибки = НСтр("ru='Длина серийного должна содержать знаков: %1'");
			ТекстОшибки = СтрШаблон(ШаблонОшибки, КоличествоСимволовСерии);
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстОшибки,,
				ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("СерийныеНомера", Строка.НомерСтроки, "СерийныйНомер"),,
				Отказ);
			
		ИначеЕсли Не ШтрихкодированиеИСКлиентСервер.КодСоответствуетАлфавиту(Строка.СерийныйНомер, АлфавитСерийногоНомера) Тогда
			
			ШаблонОшибки = НСтр("ru='Серийный номер не соответствует алфавиту: %1'");
			ТекстОшибки = СтрШаблон(ШаблонОшибки, АлфавитСерийногоНомера);
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстОшибки,,
				ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("СерийныеНомера", Строка.НомерСтроки, "СерийныйНомер"),,
				Отказ);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция АлфавитСерийногоНомера()
	
	ДопустимыеСимволы = ШтрихкодированиеИССлужебный.ДопустимыеСимволыВКодеМаркировки();
	Возврат ДопустимыеСимволы.БуквыЦифрыЗнаки;
	
КонецФункции

#КонецОбласти