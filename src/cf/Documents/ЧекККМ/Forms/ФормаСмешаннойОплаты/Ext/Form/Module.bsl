﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	РозничныеПродажи.ПодписатьГорячиеКлавишиНаКнопках(ЭтотОбъект);
	Дисплеи.ЗагрузитьЗначения(МенеджерОборудованияВызовСервера.ОборудованиеПоПараметрам("ДисплейПокупателя"));
	АвтоматическиСоздаватьПартнеров = Константы.АвтоматическиСоздаватьПартнеровПриОтправкеЭлектронногоЧекаПокупателю.Получить();
	АвтоматическиОбновлятьКонтактыПартнеров = Константы.ОбновлятьКонтактнуюИнформациюПартнеровПриОтправкеЭлектронныхЧеков.Получить();
	
	КоличествоСимволовПослеЗапятой = 2;
	ПервыйВвод = Истина;
	
	ИнформацияОбОплате = Параметры.ИнформацияОбОплате;
	Документ = ИнформацияОбОплате.Документ;
	НастроитьВидимостьЭлементов(ИнформацияОбОплате);
	
	КОплате           = ИнформацияОбОплате.СуммаКОплате;
	ПолученоНаличными = Формат(ИнформацияОбОплате.Наличные, "ЧДЦ=2; ЧГ=3,0");
	ОплаченоСертификатами = ИнформацияОбОплате.ПодарочныеСертификаты;
	ОплаченоБонуснымиБаллами = ИнформацияОбОплате.БонусныеБаллы;
	
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.ЧекККМВозврат")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.ВозвратПодарочныхСертификатов") Тогда
		ОплаченоПлатежнымиКартами = ИнформацияОбОплате.ПлатежныеКартыОтменено;
	Иначе
		ОплаченоПлатежнымиКартами = ИнформацияОбОплате.ПлатежныеКарты;
	КонецЕсли;
	
	Элементы.ГруппаОтправкаЭлектронногоЧека.Видимость = Параметры.ДоступнаПередачаДанных;
	ЦветФонаВыделенияПоля = ЦветаСтиля.ЦветФонаВыделения;
	
	Партнер = Параметры.Партнер;
	РозничныеПродажи.ЗаполнитьПараметрыОтправкиЭлектронногоЧекаПоПартнеру(ЭтотОбъект);
	
	РозничныеПродажиКлиентСервер.УстановитьАктивныйЭлемент(ЭтотОбъект, Элементы.ПолеПолученоНаличными);
	Телефон = РозничныеПродажиКлиентСервер.ОтформатироватьНомерТелефона(Телефон10Знаков);
	
	РассчитатьИтоги(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("ВывестиИнформациюНаДисплейПокупателя", 0.1, Истина);
	
	ПодключитьОбработчикОжидания("УстановитьАктивностьЭлементов", 1, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ПринудительноЗакрытьФорму ИЛИ ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(ПолученоНаличными) <> 0
		ИЛИ ОплаченоПлатежнымиКартами <> 0
		ИЛИ ОплаченоСертификатами <> 0
		ИЛИ ОплаченоБонуснымиБаллами Тогда
		
		Отказ = Истина;
		
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить("ОтменитьОплату", НСтр("ru = 'Отменить оплату'"));
		Кнопки.Добавить("Отмена", НСтр("ru = 'Отмена'"));
		
		ПоказатьВопрос(
			Новый ОписаниеОповещения("ПередЗакрытиемВопросЗавершение", ЭтотОбъект),
			НСтр("ru = 'Перед закрытием формы оплаты требуется отменить произведенную оплату.'"), Кнопки);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ТелефонПриИзменении(Элемент)
	
	Телефон10Знаков = РозничныеПродажиКлиентСервер.НомерТелефонаВФормате10Знаков(Телефон);
	
КонецПроцедуры

&НаКлиенте
Процедура EmailПриИзменении(Элемент)
	
	РозничныеПродажиКлиентСервер.УстановитьВариантОтправкиЭлектронногоЧека(
		ЭтотОбъект,
		ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьEmail"));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Команда0(Команда)
	
	ДобавитьЦифру("0")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда1(Команда)
	
	ДобавитьЦифру("1")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда2(Команда)
	
	ДобавитьЦифру("2")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда3(Команда)
	
	ДобавитьЦифру("3")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда4(Команда)
	
	ДобавитьЦифру("4")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда5(Команда)
	
	ДобавитьЦифру("5")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда6(Команда)
	
	ДобавитьЦифру("6")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда7(Команда)
	
	ДобавитьЦифру("7")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда8(Команда)
	
	ДобавитьЦифру("8")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда9(Команда)
	
	ДобавитьЦифру("9")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда0ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("0")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда1ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("1")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда2ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("2")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда3ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("3")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда4ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("4")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда5ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("5")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда6ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("6")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда7ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("7")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда8ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("8")
	
КонецПроцедуры

&НаКлиенте
Процедура Команда9ПраваяКлавиатура(Команда)
	
	ДобавитьЦифру("9")
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаТочка(Команда)
	
	Если АктивноеПоле = Элементы.ПолеПолученоНаличными.Имя Тогда
		
		Если ПервыйВвод Тогда
			ПолученоНаличными = "";
			ПервыйВвод = Ложь;
		КонецЕсли;
		
		Если ПолученоНаличными = "" Тогда
			ПолученоНаличными = "0";
		КонецЕсли;
		
		ЧислоВхождений = СтрЧислоВхождений(ПолученоНаличными, ",");
		
		Если Не ЧислоВхождений > 0 Тогда
			ПолученоНаличными = ПолученоНаличными + ",";
		КонецЕсли;
		
		РассчитатьИтоги(ЭтотОбъект);
		ПодключитьОбработчикОжидания("ВывестиИнформациюНаДисплейПокупателя", 0.1, Истина);
		
	Иначе
		
		Телефон10Знаков = "";
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСтереть(Команда)
	
	Если АктивноеПоле = Элементы.ПолеПолученоНаличными.Имя Тогда
		
		ПолученоНаличными = "";
		ПервыйВвод = Ложь;
		
		РассчитатьИтоги(ЭтотОбъект);
		ПодключитьОбработчикОжидания("ВывестиИнформациюНаДисплейПокупателя", 0.1, Истина);
		
	ИначеЕсли АктивноеПоле = Элементы.Телефон.Имя Тогда
		
		Телефон10Знаков = "";
		Телефон = РозничныеПродажиКлиентСервер.ОтформатироватьНомерТелефона(Телефон10Знаков);
		
	ИначеЕсли АктивноеПоле = Элементы.Email.Имя Тогда
		
		Email = "";
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПробитьЧек(Команда)
	
	СуммаОплатыЧисло = РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(ПолученоНаличными);
	
	ДанныеЭлектронногоЧека = РозничныеПродажиКлиентСервер.ДанныеЭлектронногоЧека(ЭтотОбъект);
	НеобходимостьОбработкиДанных = РозничныеПродажиКлиентСервер.ПроверитьНеобходимостьОбработкиДанныхЭлектронногоЧека(ЭтотОбъект);
	Если НеобходимостьОбработкиДанных.ТребуетсяОбновитьКонтактнуюИнформацию
		Или НеобходимостьОбработкиДанных.ТребуетсяСоздатьПартнера
		Или НеобходимостьОбработкиДанных.ТребуетсяОбновитьВариантОтправкиЭлектронногоЧекаПартнера Тогда
		ДанныеЭлектронногоЧека = ОбработатьДанныеЭлектронногоЧека();
	КонецЕсли;
	
	Если ДанныеЭлектронногоЧека = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РезультатОплаты = РозничныеПродажиКлиентСервер.СтруктураРезультатаОплаты();
	РезультатОплаты.ПолученоНаличными      = СуммаОплатыЧисло;
	РезультатОплаты.ДанныеЭлектронногоЧека = ДанныеЭлектронногоЧека;
	
	ПринудительноЗакрытьФорму = Истина;
	Закрыть(РезультатОплаты);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму(Команда)
	ПринудительноЗакрытьФорму = Истина;
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПлатежнаяКарта(Команда)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ОповещениеВФормуОплаты", Новый ОписаниеОповещения("ОплатаЗавершение", ЭтотОбъект));
	ДополнительныеПараметры.Вставить("ПолученоНаличными", РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(ПолученоНаличными));
	
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.ЧекККМ")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.РеализацияПодарочныхСертификатов") Тогда
		ВыполнитьОбработкуОповещения(
			Новый ОписаниеОповещения("ДобавитьОплатуКартой", ВладелецФормы, ДополнительныеПараметры),
			Истина);
	Иначе
		ВыполнитьОбработкуОповещения(
			Новый ОписаниеОповещения("ОтменитьОплату", ВладелецФормы, ДополнительныеПараметры),
			Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПодарочныйСертификат(Команда)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ОповещениеВФормуОплаты", Новый ОписаниеОповещения("ОплатаЗавершение", ЭтотОбъект));
	ДополнительныеПараметры.Вставить("ПолученоНаличными", РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(ПолученоНаличными));
	
	ВыполнитьОбработкуОповещения(
		Новый ОписаниеОповещения("ДобавитьОплатуПодарочнымСертификатом", ВладелецФормы, ДополнительныеПараметры),
		Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаБонусныеБаллы(Команда)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ОповещениеВФормуОплаты", Новый ОписаниеОповещения("ОплатаЗавершение", ЭтотОбъект));
	ДополнительныеПараметры.Вставить("ПолученоНаличными", РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(ПолученоНаличными));
	
	ВыполнитьОбработкуОповещения(
		Новый ОписаниеОповещения("ДобавитьОплатуБонуснымиБаллами", ВладелецФормы, ДополнительныеПараметры),
		Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСторно(Команда)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ОповещениеВФормуОплаты", Новый ОписаниеОповещения("ОплатаЗавершение", ЭтотОбъект));
	ДополнительныеПараметры.Вставить("ПолученоНаличными", РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(ПолученоНаличными));
	
	ВыполнитьОбработкуОповещения(
		Новый ОписаниеОповещения("ОтменитьОплатыПлатежнымиКартами", ВладелецФормы, ДополнительныеПараметры),
		Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтправитьSMS(Команда)
	
	РозничныеПродажиКлиентСервер.УстановитьАктивныйЭлемент(ЭтотОбъект, Элементы.Телефон);
	РозничныеПродажиКлиентСервер.УстановитьВариантОтправкиЭлектронногоЧека(
		ЭтотОбъект,
		ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьSMS"));
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтправитьEmail(Команда)
	
	РозничныеПродажиКлиентСервер.УстановитьАктивныйЭлемент(ЭтотОбъект, Элементы.Email);
	РозничныеПродажиКлиентСервер.УстановитьВариантОтправкиЭлектронногоЧека(
		ЭтотОбъект,
		ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьEmail"));
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтправкаНеТребуется(Команда)
	
	РозничныеПродажиКлиентСервер.УстановитьВариантОтправкиЭлектронногоЧека(
		ЭтотОбъект,
		ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.НеОтправлять"));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ДобавитьЦифру(ВведеннаяЦифраСтрокой)
	
	Если АктивноеПоле = Элементы.ПолеПолученоНаличными.Имя Тогда
	
		Если ПервыйВвод Тогда
			Если ВведеннаяЦифраСтрокой = "0" Тогда
				Возврат;
			КонецЕсли;
			ПолученоНаличными = "";
			ПервыйВвод = Ложь;
		КонецЕсли;
		
		Запятая = Сред(ПолученоНаличными, СтрДлина(ПолученоНаличными) - КоличествоСимволовПослеЗапятой, 1);
		
		Если НЕ Запятая = "," Тогда
			ПолученоНаличными = ПолученоНаличными + ВведеннаяЦифраСтрокой;
		КонецЕсли;
		
		РассчитатьИтоги(ЭтотОбъект);
		ПодключитьОбработчикОжидания("ВывестиИнформациюНаДисплейПокупателя", 0.1, Истина);
		
	ИначеЕсли АктивноеПоле = Элементы.Телефон.Имя Тогда
		
		Если ПервыйВвод Тогда
			Телефон10Знаков = "";
			ПервыйВвод = Ложь;
		КонецЕсли;
		
		Телефон10Знаков = Телефон10Знаков + ВведеннаяЦифраСтрокой;
		Телефон = РозничныеПродажиКлиентСервер.ОтформатироватьНомерТелефона(Телефон10Знаков);
		
		Если СтрДлина(Телефон10Знаков) = 10 Тогда
			ТекущийЭлемент = Элементы.КомандаПробитьЧек;
		КонецЕсли;
		
		РозничныеПродажиКлиентСервер.УстановитьВариантОтправкиЭлектронногоЧека(
			ЭтотОбъект,
			ПредопределенноеЗначение("Перечисление.ВариантыОтправкиЭлектронногоЧекаПокупателю.ОтправитьSMS"));
		
	ИначеЕсли АктивноеПоле = Элементы.Email.Имя Тогда
		
		Если ПервыйВвод Тогда
			Email = "";
			ПервыйВвод = Ложь;
		КонецЕсли;
		
		Email = СокрЛП(Email) + ВведеннаяЦифраСтрокой;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьИтоги(Форма)
	
	Форма.СуммаОплаты = РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(Форма.ПолученоНаличными)
	                  + Форма.ОплаченоБонуснымиБаллами
	                  + Форма.ОплаченоПлатежнымиКартами
	                  + Форма.ОплаченоСертификатами;
	
	Если Форма.СуммаОплаты >= Форма.КОплате Тогда
		
		Форма.СуммаСдачи   = Форма.СуммаОплаты - Форма.КОплате;
		Форма.СуммаДоплаты = 0;
		
		Форма.Элементы.ГруппаИтого.ТекущаяСтраница = Форма.Элементы.ГруппаСдача;
		Форма.Элементы.КомандаПробитьЧек.Доступность = Истина;
		
		Форма.ТекущийЭлемент = Форма.Элементы.КомандаПробитьЧек;
		
	Иначе
		
		Форма.СуммаСдачи   = 0;
		Форма.СуммаДоплаты = Форма.КОплате - Форма.СуммаОплаты;
		
		Форма.Элементы.ГруппаИтого.ТекущаяСтраница = Форма.Элементы.ГруппаДоплата;
		Форма.Элементы.КомандаПробитьЧек.Доступность = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатаЗавершение(ИнформацияОбОплате, ДополнительныеПараметры) Экспорт
	
	КОплате = ИнформацияОбОплате.СуммаКОплате;
	
	ПолученоНаличными = ИнформацияОбОплате.Наличные;
	
	ОплаченоСертификатами = ИнформацияОбОплате.ПодарочныеСертификаты;
	ОплаченоБонуснымиБаллами = ИнформацияОбОплате.БонусныеБаллы;
	
	Если ТипЗнч(ИнформацияОбОплате.Документ) = Тип("ДокументСсылка.ЧекККМВозврат")
		ИЛИ ТипЗнч(ИнформацияОбОплате.Документ) = Тип("ДокументСсылка.ВозвратПодарочныхСертификатов") Тогда
		ОплаченоПлатежнымиКартами = ИнформацияОбОплате.ПлатежныеКартыОтменено;
	Иначе
		ОплаченоПлатежнымиКартами = ИнформацияОбОплате.ПлатежныеКарты;
	КонецЕсли;
	
	РассчитатьИтоги(ЭтотОбъект);
	ПодключитьОбработчикОжидания("ВывестиИнформациюНаДисплейПокупателя", 0.1, Истина);
	
	Если ПринудительноЗакрытьФормуПриУспешнойОтменеОплаты Тогда
		
		Если ИнформацияОбОплате.ИтогоОплачено = 0 Тогда
			ПринудительноЗакрытьФорму = Истина;
			Закрыть();
		Иначе
			ПринудительноЗакрытьФормуПриУспешнойОтменеОплаты = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемВопросЗавершение(ОтветНаВопрос, ДополнительныеПараметры) Экспорт
	
	Если ОтветНаВопрос = "ОтменитьОплату" Тогда
		
		ПринудительноЗакрытьФормуПриУспешнойОтменеОплаты = Истина;
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("ОповещениеВФормуОплаты", Новый ОписаниеОповещения("ОплатаЗавершение", ЭтотОбъект));
		ДополнительныеПараметры.Вставить("ПолученоНаличными", РозничныеПродажиКлиентСервер.ПривестиСтрокуКЧислу(ПолученоНаличными));
		
		Если ТипЗнч(Документ) = Тип("ДокументСсылка.ЧекККМВозврат")
			ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.ВозвратПодарочныхСертификатов") Тогда
			ВыполнитьОбработкуОповещения(
				Новый ОписаниеОповещения("ОтменитьОплатуСторно", ВладелецФормы, ДополнительныеПараметры),
				Истина);
		Иначе
			ВыполнитьОбработкуОповещения(
				Новый ОписаниеОповещения("ОтменитьОплату", ВладелецФормы, ДополнительныеПараметры),
				Истина);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьВидимостьЭлементов(ИнформацияОбОплате)
	
	ДоступныеВидыОплаты = ИнформацияОбОплате.ДоступныеВидыОплаты;
	
	Элементы.ПолеОплаченоПлатежнымиКартами.Видимость = ДоступныеВидыОплаты.ПлатежныеКарты;
	Элементы.ОплатаПлатежнаяКарта.Видимость          = ДоступныеВидыОплаты.ПлатежныеКарты;
	Элементы.КомандаСторно.Видимость                 = ДоступныеВидыОплаты.ПлатежныеКарты;
	
	Элементы.ПолеОплаченоСертификатами.Видимость     = ДоступныеВидыОплаты.ПодарочныеСертификаты;
	Элементы.ОплатаПодарочныйСертификат.Видимость    = ДоступныеВидыОплаты.ПодарочныеСертификаты;
	
	Элементы.ПолеОплаченоБонуснымиБаллами.Видимость  = ДоступныеВидыОплаты.БонусныеБаллы;
	Элементы.ОплатаБонусныеБаллы.Видимость           = ДоступныеВидыОплаты.БонусныеБаллы;
	
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.ЧекККМВозврат")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.ВозвратПодарочныхСертификатов") Тогда
		
		Заголовок = НСтр("ru = 'Возврат смешанной оплаты'");
		
		Элементы.КОплате.Заголовок                    = НСтр("ru = 'К возврату'");
		Элементы.ОплатаПлатежнаяКарта.Заголовок       = НСтр("ru = 'Отменить оплату платежными картами'");
		Элементы.ОплатаПодарочныйСертификат.Заголовок = НСтр("ru = 'Вернуть оплату подарочным сертификатом'");
		Элементы.ОплатаБонусныеБаллы.Заголовок        = НСтр("ru = 'Отменить оплату бонусными баллами'");
		
		Элементы.СуммаСдачи.Заголовок   = НСтр("ru = 'Получить сдачу'");
		Элементы.СуммаДоплаты.Заголовок = НСтр("ru = 'Осталось вернуть'");
		
		Элементы.КомандаСторно.Видимость = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВывестиИнформациюНаДисплейПокупателя()
	
	Если Не ВводДоступен() Тогда
		Возврат;
	КонецЕсли;
	
	ФорматнаяСтрока = "ЧДЦ=2; ЧРГ=' '; ЧН=0.00; ЧГ=0";
	ДлинаТекста = 20;
	
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.ЧекККМ")
		ИЛИ ТипЗнч(Документ) = Тип("ДокументСсылка.РеализацияПодарочныхСертификатов") Тогда
		ТекстКОплате = НСтр("ru = 'К оплате'")  + ":";
		ТекстСдача   = НСтр("ru = 'Сдача'")     + ":";
		ТекстДоплата = НСтр("ru = 'Доплатить'") + ":";
	Иначе
		ТекстКОплате = НСтр("ru = 'К возврату'") + ":";
		ТекстСдача   = НСтр("ru = 'Сдача'")      + ":";
		ТекстДоплата = НСтр("ru = 'Вернуть'")    + ":";
	КонецЕсли;
	
	ДПТекст1 = РозничныеПродажиКлиент.ПодготовитьСтрокуКВыводуНаДисплейПокупателя(ТекстКОплате, КОплате);
	
	Если СуммаДоплаты > 0 Тогда
		ДПТекст2 = РозничныеПродажиКлиент.ПодготовитьСтрокуКВыводуНаДисплейПокупателя(ТекстДоплата, СуммаДоплаты);
	ИначеЕсли СуммаСдачи > 0 Тогда
		ДПТекст2 = РозничныеПродажиКлиент.ПодготовитьСтрокуКВыводуНаДисплейПокупателя(ТекстСдача, СуммаСдачи);
	Иначе
		ДПТекст2 = "";
	КонецЕсли;
	
	РозничныеПродажиКлиент.ВывестиТекстНаДисплеиПокупателя(
		ВладелецФормы,
		Дисплеи,
		ДПТекст1 + Символы.ПС + ДПТекст2);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьАктивностьЭлементов()
	
	РозничныеПродажиКлиентСервер.УстановитьАктивностьЭлементов(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Функция ОбработатьДанныеЭлектронногоЧека()
	
	Возврат РозничныеПродажи.ОбработатьДанныеЭлектронногоЧека(ЭтотОбъект);
	
КонецФункции

#КонецОбласти