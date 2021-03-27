﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	КоличествоЭлементов = 0;
	Если РаботаСФайламиСлужебныйКлиент.ПроинициализироватьКомпоненту() Тогда
		МассивУстройств = РаботаСФайламиСлужебныйКлиент.ПолучитьУстройства();
		Для Каждого Строка Из МассивУстройств Цикл
			КоличествоЭлементов = КоличествоЭлементов + 1;
			Элементы.ИмяУстройства.СписокВыбора.Добавить(Строка);
		КонецЦикла;
	КонецЕсли;
	Если КоличествоЭлементов = 0 Тогда
		Отказ = Истина;
		ПоказатьПредупреждение(, НСтр("ru = 'Не установлен сканер. Обратитесь к администратору программы.'"));
	Иначе
		Элементы.ИмяУстройства.РежимВыбораИзСписка = Истина;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьСканер(Команда)
	
	Если ПустаяСтрока(ИмяУстройства) Тогда
		ТекстСообщения = НСтр("ru = 'Не выбран сканер.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, , "ИмяУстройства");
		Возврат;
	КонецЕсли;
	
	СистемнаяИнформация = Новый СистемнаяИнформация();
	ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекСохранить(
		"НастройкиСканирования/ИмяУстройства",
		СистемнаяИнформация.ИдентификаторКлиента,
		ИмяУстройства,
		,
		,
		Истина);
	Закрыть(ИмяУстройства);
КонецПроцедуры

#КонецОбласти