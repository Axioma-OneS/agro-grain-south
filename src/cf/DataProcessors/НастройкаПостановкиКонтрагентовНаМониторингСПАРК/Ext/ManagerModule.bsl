﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

Процедура ПолучитьДоговоры(Договоры, ТипыДоговоров, ХранилищеНастроекКомпоновкиДанных) Экспорт

	СхемаКомпоновкиДанных = ПолучитьМакет("Макет");
	
	НастройкиКомпоновкиДанных = ХранилищеНастроекКомпоновкиДанных.Получить();
	
	Если НЕ ЗначениеЗаполнено(НастройкиКомпоновкиДанных) Тогда
		НастройкиКомпоновкиДанных = СхемаКомпоновкиДанных.НастройкиПоУмолчанию;
	КонецЕсли;
	
	ПараметрСКД = СхемаКомпоновкиДанных.Параметры.Найти("ТипыДоговоров");
	Если ПараметрСКД <> Неопределено Тогда
		ПараметрСКД.Значение = ТипыДоговоров;
	КонецЕсли;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновкиДанных = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных, , , Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновкиДанных);
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ПроцессорВывода.УстановитьОбъект(Договоры);
	ПроцессорВывода.НачатьВывод();
	Пока Истина Цикл
		ЭлементРезультатаКомпоновкиДанных = ПроцессорКомпоновкиДанных.Следующий();
		Если ЭлементРезультатаКомпоновкиДанных = Неопределено Тогда
			Прервать;
		КонецЕсли;
		ПроцессорВывода.ВывестиЭлемент(ЭлементРезультатаКомпоновкиДанных);
	КонецЦикла;
	ПроцессорВывода.ЗакончитьВывод();

КонецПроцедуры

#КонецОбласти

#КонецЕсли