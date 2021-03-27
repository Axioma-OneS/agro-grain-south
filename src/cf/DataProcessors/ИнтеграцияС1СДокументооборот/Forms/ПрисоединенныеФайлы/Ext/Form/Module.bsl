﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("ВладелецФайла", Владелец);
	Параметры.Свойство("ТекущийФайл", ТекущийФайл);
	
	// Покажем владельца при открытии из карточки файла.
	Элементы.ВладелецФайла.Видимость =
		ЗначениеЗаполнено(ТекущийФайл)
		И ЗначениеЗаполнено(Владелец);
		
	Если Параметры.Свойство("ЗаголовокФормы") Тогда
		Заголовок = Параметры.ЗаголовокФормы;
		ЗаголовокУстановлен = Истина;
	КонецЕсли;
	
	ИспользоватьЭлектроннуюПочтуДокументооборота = 
		ПолучитьФункциональнуюОпцию("ИспользоватьЭлектроннуюПочту1СДокументооборота");
	
	ИспользоватьЭлектронныеПодписиИС = ИнтеграцияС1СДокументооборотВызовСервера.ИспользоватьЭлектронныеЦифровыеПодписи();
	
	Если Параметры.Свойство("ПростаяФорма") Тогда
		Элементы.ОткрытьДляРедактирования.ТолькоВоВсехДействиях = Истина;
		Элементы.ОткрытьНаЧтение.ТолькоВоВсехДействиях = Истина;
		Элементы.ЗакончитьРедактирование.ТолькоВоВсехДействиях = Истина;
		Предпросмотр = Истина;
	ИначеЕсли ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиСлужебный = ОбщегоНазначения.ОбщийМодуль("РаботаСФайламиСлужебный");
		ИмяСправочникаХранилищаФайлов = МодульРаботаСФайламиСлужебный.ИмяСправочникаХраненияФайлов(Владелец);
		Если ЗначениеЗаполнено(ИмяСправочникаХранилищаФайлов) Тогда
			ТипСправочникаСФайлами = Тип("СправочникСсылка." + ИмяСправочникаХранилищаФайлов);
			Предпросмотр = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
				ТипСправочникаСФайлами, "Предпросмотр");
		Иначе
			Предпросмотр = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Элементы.ПереключитьПредпросмотр.Пометка = Предпросмотр;
	Элементы.КартинкаПредпросмотра.Видимость = Предпросмотр;
	
	РасширенияПоддерживающиеПредпросмотр = РаботаСФайламиСлужебный.СписокРасширенийДляПредпросмотра();
	
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаОжидаетсяПодключение;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Попытка
		ID = ВладелецФормы["ИнтеграцияС1СДокументооборотом_ИдентификаторОбъектаДО"];
		Тип = ВладелецФормы["ИнтеграцияС1СДокументооборотом_ТипОбъектаДО"];
	Исключение
		ID = "";
		Тип = "";
	КонецПопытки;
	
	Если Не ЗаголовокУстановлен Тогда
		ИнтеграцияС1СДокументооборотКлиент.УстановитьЗаголовокПриОткрытии(ЭтаФорма);
	КонецЕсли;
	
	ПроверитьПодключение();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ДокументооборотФайл" Тогда
		ПрочитатьИОбновитьСписокФайловИПодписей();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ДекорацияНастройкиАвторизацииНажатие(Элемент)
	
	Оповещение = Новый ОписаниеОповещения("ДекорацияНастройкиАвторизацииНажатиеЗавершение", ЭтаФорма);
	ИмяФормыПараметров = "Обработка.ИнтеграцияС1СДокументооборот.Форма.АвторизацияВ1СДокументооборот";
	 
	ОткрытьФорму(ИмяФормыПараметров,, ЭтаФорма,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияНастройкиАвторизацииНажатиеЗавершение(Результат, Параметры) Экспорт
	
	Если Результат = Истина Тогда
		ОбработатьФормуСогласноВерсииСервиса();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура КартинкаПредпросмотраНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьНаЧтение(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФайлы

&НаКлиенте
Процедура ФайлыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьНаЧтение(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлыПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	ОткрытьКарточку();
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
	Если Копирование Тогда
		ДобавитьКопированием(Элементы.Файлы.ТекущиеДанные.ID);
	Иначе
		ДобавитьСДиска(Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлыПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекстВопроса = "";
	
	Если Элементы.Файлы.ВыделенныеСтроки.Количество() = 1 Тогда
		Если ТекущиеДанные.ПометкаУдаления Тогда
			ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Снять с ""%1"" пометку на удаление?'"), ТекущиеДанные.Наименование);
		Иначе
			ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Пометить ""%1"" на удаление?'"), ТекущиеДанные.Наименование);
		КонецЕсли;
	Иначе
		Если ТекущиеДанные.ПометкаУдаления Тогда
			ТекстВопроса = НСтр("ru='Снять с выделенных файлов пометку на удаление?'");
		Иначе
			ТекстВопроса = НСтр("ru='Пометить выделенные файлы на удаление?'");
		КонецЕсли;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура("ВыделенныеСтроки", Элементы.Файлы.ВыделенныеСтроки);
	Оповещение = Новый ОписаниеОповещения(
		"ФайлыПередУдалениемЗавершение", ЭтаФорма, ДополнительныеПараметры);
	
	ИнтеграцияС1СДокументооборотКлиент.ПоказатьВопросДаНет(Оповещение, ТекстВопроса);
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлыПриАктивизацииСтроки(Элемент)
	
	УстановитьДоступностьКомандСпискаФайлов();
	ОбновитьПредпросмотр(Элементы.Файлы.ТекущаяСтрока);
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлыПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлыПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	СтандартнаяОбработка = Ложь;
	
	МассивФайлов = Новый Массив;
	Если ТипЗнч(ПараметрыПеретаскивания.Значение) = Тип("Массив")
		И ПараметрыПеретаскивания.Значение.Количество() > 0 Тогда
		
		Для Каждого ПеретаскиваемыйФайл Из ПараметрыПеретаскивания.Значение Цикл
			
			Если ТипЗнч(ПеретаскиваемыйФайл) = Тип("Файл")
				И ПеретаскиваемыйФайл.ЭтоФайл() Тогда
				
				МассивФайлов.Добавить(ПеретаскиваемыйФайл);
				
			КонецЕсли;
			
		КонецЦикла;
		
	ИначеЕсли ТипЗнч(ПараметрыПеретаскивания.Значение) = Тип("Файл")
			И ПараметрыПеретаскивания.Значение.ЭтоФайл() Тогда
		
		МассивФайлов.Добавить(ПараметрыПеретаскивания.Значение);
		
	КонецЕсли;
	
	Если МассивФайлов.Количество() > 0 Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ФайлыПеретаскиваниеЗавершение", ЭтаФорма, МассивФайлов);
		Если ЗначениеЗаполнено(ID) Тогда // связанный объект уже известен
			ВыполнитьОбработкуОповещения(ОписаниеОповещения, Неопределено);
		Иначе // связанный объект следует найти или создать
			ИнтеграцияС1СДокументооборотКлиент.НачатьПоискСвязанногоОбъектаДО(Владелец, ОписаниеОповещения);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлыПеретаскиваниеЗавершение(Результат, МассивФайлов) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		ID = Результат.id;
		Тип = Результат.type;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ID) Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("СоздатьФайлПеретаскиваниеЗавершение", ЭтаФорма, МассивФайлов);
	
	Если СостояниеРазрешаетДобавлениеСканКопии
		И Не СостояниеРазрешаетДобавлениеФайла Тогда
		
		ТекстВопроса = НСтр("ru = 'В текущем состоянии можно добавить только скан-копию оригинала документа. Продолжить?'");
		ЗаголовокВопроса = НСтр("ru = 'Добавление файла'");
		
		ИнтеграцияС1СДокументооборотКлиент.ПоказатьВопросДаНет(Оповещение, ТекстВопроса, КодВозвратаДиалога.Да,,,
			ЗаголовокВопроса);
	Иначе
		ВыполнитьОбработкуОповещения(Оповещение, КодВозвратаДиалога.Да);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьФайлПеретаскиваниеЗавершение(Результат, МассивФайлов) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтаФорма);
	Для Каждого Файл Из МассивФайлов Цикл
		ИнтеграцияС1СДокументооборотКлиент.СоздатьФайлСДискаПеретаскиванием(
			Файл,
			ЭтаФорма.УникальныйИдентификатор,
			ID,
			Тип,
			Строка(Владелец),
			Владелец,
			ОписаниеОповещения,
			(СостояниеРазрешаетДобавлениеСканКопии И Не СостояниеРазрешаетДобавлениеФайла));
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьКопированием(ОригиналID)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтаФорма);
	ИнтеграцияС1СДокументооборотКлиент.СоздатьФайлКопированием(ОригиналID, ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСДиска(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ДобавитьСДискаЗавершение", ЭтаФорма);
	Если ЗначениеЗаполнено(ID) Тогда // связанный объект уже известен
		ВыполнитьОбработкуОповещения(ОписаниеОповещения, Неопределено);
	Иначе // связанный объект следует найти или создать
		ИнтеграцияС1СДокументооборотКлиент.НачатьПоискСвязанногоОбъектаДО(Владелец, ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПечатнуюФорму(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ДобавитьПечатнуюФормуЗавершение", ЭтаФорма);
	Если ЗначениеЗаполнено(ID) Тогда // связанный объект уже известен
		ВыполнитьОбработкуОповещения(ОписаниеОповещения, Неопределено);
	Иначе // связанный объект следует найти или создать
		ИнтеграцияС1СДокументооборотКлиент.НачатьПоискСвязанногоОбъектаДО(Владелец, ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНаЧтение(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ИнтеграцияС1СДокументооборотКлиент.ОткрытьФайл(ТекущиеДанные.ID, ТекущиеДанные.Наименование,
			ТекущиеДанные.Расширение, УникальныйИдентификатор, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьДляРедактирования(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтотОбъект);
		ИнтеграцияС1СДокументооборотКлиент.ОткрытьФайл(ТекущиеДанные.ID, ТекущиеДанные.Наименование, 
			ТекущиеДанные.Расширение, УникальныйИдентификатор, Ложь, ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакончитьРедактирование(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтотОбъект);
		ИнтеграцияС1СДокументооборотКлиент.ЗакончитьРедактированиеФайла(
			ТекущиеДанные.ID, ТекущиеДанные.Наименование, ТекущиеДанные.Расширение, 
			УникальныйИдентификатор, ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНаДиск(Команда)
	
	ИнтеграцияС1СДокументооборотКлиент.НачатьСохранениеВыделенныхФайлов(Файлы,
		Элементы.Файлы.ВыделенныеСтроки,
		УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИзФайлаНаДиске(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтотОбъект);
		ИнтеграцияС1СДокументооборотКлиент.ОбновитьИзФайлаНаДиске(
			ТекущиеДанные.ID, ТекущиеДанные.Наименование, ТекущиеДанные.Расширение, 
			УникальныйИдентификатор, ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьРедактирование(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтотОбъект);
		ИнтеграцияС1СДокументооборотКлиент.ОтменитьРедактированиеФайла(
			ТекущиеДанные.ID, ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКаталогФайла(Команда)
	
	Если Элементы.Файлы.ТекущиеДанные <> Неопределено Тогда
		ИнтеграцияС1СДокументооборотКлиент.ОткрытьКаталогФайла(Элементы.Файлы.ТекущиеДанные.ID);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИзменения(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтотОбъект);
		ИнтеграцияС1СДокументооборотКлиент.СохранитьИзмененияРедактируемогоФайла(
			ТекущиеДанные.ID, ТекущиеДанные.Наименование, ТекущиеДанные.Расширение, 
			УникальныйИдентификатор, ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	ОбновитьСписокФайловКлиент();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьУдаленные(Команда)
	
	ПоказыватьУдаленные = Не ПоказыватьУдаленные;
	Элементы.ПоказыватьУдаленные.Пометка = ПоказыватьУдаленные;
	
	ОбновитьСписокФайловКлиент();
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключитьПредпросмотр(Команда)
	
	Предпросмотр = Не Предпросмотр;
	Элементы.ПереключитьПредпросмотр.Пометка = Предпросмотр;
	Элементы.КартинкаПредпросмотра.Видимость = Предпросмотр;
	ОбновитьПредпросмотр(Элементы.Файлы.ТекущаяСтрока);
	
КонецПроцедуры

&НаКлиенте
Процедура Печать(Команда)
	
	#Если ВебКлиент Тогда 
		ПоказатьПредупреждение(, НСтр("ru = 'В Веб-клиенте печать файлов не поддерживается.'"));
		Возврат;
	#КонецЕсли
	
	СистемнаяИнфо = Новый СистемнаяИнформация;
	Если СистемнаяИнфо.ТипПлатформы <> ТипПлатформы.Windows_x86 
		И СистемнаяИнфо.ТипПлатформы <> ТипПлатформы.Windows_x86_64 Тогда
			ПоказатьПредупреждение(, НСтр("ru = 'Печать файлов возможна только в Windows.'"));
			Возврат;
	КонецЕсли;
		
	ОписанияФайлов = Новый Массив;
	
	Для Каждого ВыделеннаяСтрока Из Элементы.Файлы.ВыделенныеСтроки Цикл
		
		СтрокаФайла = Файлы.НайтиПоИдентификатору(ВыделеннаяСтрока);
		
		ОписаниеФайла = Новый Структура;
		ОписаниеФайла.Вставить("Идентификатор", СтрокаФайла.ID);
		ОписаниеФайла.Вставить("Имя", СтрокаФайла.Наименование);
		ОписаниеФайла.Вставить("Расширение", СтрокаФайла.Расширение);
		
		ОписанияФайлов.Добавить(ОписаниеФайла);
		
	КонецЦикла;
	
	ИнтеграцияС1СДокументооборотКлиент.НапечататьФайлы(ОписанияФайлов, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура Отправить(Команда)
	
	Если ИспользоватьЭлектроннуюПочтуДокументооборота Тогда
		
		ОтправитьЧерезДокументооборот();
		
	Иначе
		
		ОтправитьЧерезИС();
		
	КонецЕсли;
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////////////////////////
// Файлы (ЭП)

&НаКлиенте
Процедура ПодписатьФайл(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеПодписейФайла = ДанныеПодписейФайла(ТекущиеДанные.ID);
	
	ИнтеграцияС1СДокументооборотКлиент.ПодписатьФайл(
		ТекущиеДанные.ID,
		ТекущиеДанные.Наименование,
		ТекущиеДанные.Редактируется,
		ТекущиеДанные.Зашифрован,
		ТекущиеДанные.Описание,
		ДанныеПодписейФайла);
		
	ПрочитатьИОбновитьСписокФайловИПодписей();
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьЭПИзФайла(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеПодписейФайла = ДанныеПодписейФайла(ТекущиеДанные.ID);
	
	СвойстваФайла = Новый Структура;
	СвойстваФайла.Вставить("ИдентификаторФайла", ТекущиеДанные.ID);
	СвойстваФайла.Вставить("ИмяФайла", ТекущиеДанные.Наименование);
	СвойстваФайла.Вставить("ОписаниеФайла", ТекущиеДанные.Описание);
	СвойстваФайла.Вставить("Редактируется", ТекущиеДанные.Редактируется);
	СвойстваФайла.Вставить("Зашифрован", ТекущиеДанные.Зашифрован);
	СвойстваФайла.Вставить("ДанныеПодписейФайла", ДанныеПодписейФайла);
	СвойстваФайла.Вставить("УникальныйИдентификатор", УникальныйИдентификатор);
	
	Оповещение = Новый ОписаниеОповещения("ДобавитьЭПИзФайлаЗавершение", ЭтаФорма);
	
	ИнтеграцияС1СДокументооборотКлиент.НачатьДобавлениеЭПИзФайла(Оповещение, СвойстваФайла);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлВместеСЭП(Команда)
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИнтеграцияС1СДокументооборотКлиент.НачатьСохранениеВместеСЭП(
		ТекущиеДанные.ID,
		ТекущиеДанные.Расширение,
		ТекущиеДанные.Наименование,
		ТекущиеДанные.Размер * 1024,
		ТекущиеДанные.ДатаМодификации,
		УникальныйИдентификатор);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Проверяет подключение к ДО, выводя окно авторизации, если необходимо, и изменяя форму согласно результату.
//
&НаКлиенте
Процедура ПроверитьПодключение()
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПроверитьПодключениеЗавершение", ЭтаФорма, Неопределено);
	ИнтеграцияС1СДокументооборотКлиент.ПроверитьПодключение(
		ОписаниеОповещения, ЭтаФорма, "ПроверитьПодключение");
	
КонецПроцедуры

// Вызывается после проверки подключения к ДО и изменяет форму согласно результату.
//
&НаКлиенте
Процедура ПроверитьПодключениеЗавершение(Результат, Параметры) Экспорт
	
	ОбработатьФормуСогласноВерсииСервиса();
	
	// Установим текущую строку.
	Если ЗначениеЗаполнено(ТекущийФайл) Тогда
		Для Каждого Файл Из Файлы Цикл
			Если Файл.ID = ТекущийФайл Тогда
				Элементы.Файлы.ТекущаяСтрока = Файл.ПолучитьИдентификатор();
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// Изменяет форму согласно доступности сервиса ДО и номеру его версии.
//
&НаСервере
Процедура ОбработатьФормуСогласноВерсииСервиса()
	
	ВерсияСервиса = ИнтеграцияС1СДокументооборот.ВерсияСервиса();
	
	Если ПустаяСтрока(ВерсияСервиса) Тогда // идет подключение
		
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаОжидаетсяПодключение;
		Элементы.СтраницаОжидаетсяПодключение.Видимость = Истина;
		
	Иначе // версия известна
		
		Если ВерсияСервиса = "0.0.0.0" Тогда
			
			Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаДокументооборотНедоступен;
			Элементы.СтраницаОжидаетсяПодключение.Видимость = Ложь;
			
		Иначе
			
			Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаДокументооборотДоступен;
			
			ДоступенЗахватФайлов = ИнтеграцияС1СДокументооборотПовтИсп.ДоступенФункционалВерсииСервиса(
				"1.4.9.1");
			
			ДоступныПомеченныеНаУдаление = ИнтеграцияС1СДокументооборотПовтИсп.ДоступенФункционалВерсииСервиса(
				"2.0.6.3");
				
			// Обработаем настройки ЭП.
			НастройкиДО = ИнтеграцияС1СДокументооборотПовтИсп.ПолучитьНастройки();
			ИспользоватьЭлектронныеПодписиДО = 
				(НастройкиДО.ИспользоватьЭлектронныеЦифровыеПодписи = Истина);
			ИспользоватьЭлектронныеПодписи =
				ИспользоватьЭлектронныеПодписиДО
				И ИспользоватьЭлектронныеПодписиИС;
				
			Элементы.ФайлыНомерКартинкиПодписанЗашифрован.Видимость = 
				ИспользоватьЭлектронныеПодписиДО;
			Элементы.Подписать.Видимость = ИспользоватьЭлектронныеПодписи;
			Элементы.ДобавитьЭПИзФайла.Видимость = ИспользоватьЭлектронныеПодписи;
			Элементы.СохранитьВместеСЭП.Видимость = ИспользоватьЭлектронныеПодписи;
			Элементы.ПодписатьКонтекст.Видимость = ИспользоватьЭлектронныеПодписи;
			Элементы.ДобавитьЭПИзФайлаКонтекст.Видимость = ИспользоватьЭлектронныеПодписи;
			Элементы.СохранитьВместеСЭПКонтекст.Видимость = ИспользоватьЭлектронныеПодписи;
			
			СостояниеРазрешаетДобавлениеФайла = Истина;
			СостояниеРазрешаетДобавлениеСканКопии = Истина;
			СостояниеРазрешаетРедактированиеФайла = Ложь;
			
			ДанныеОбъектаДО = ИнтеграцияС1СДокументооборотВызовСервера.
				ДанныеОбъектаДОПоВнешнемуОбъекту(Владелец);
			Если ДанныеОбъектаДО <> Неопределено Тогда
				ID = ДанныеОбъектаДО.id;
				Тип = ДанныеОбъектаДО.type;
				ОбъектИС = РегистрыСведений.ОбъектыИнтегрированныеС1СДокументооборотом.
					СсылкаНаОбъектПоДаннымДокументооборота(ID, Тип);
				Если ОбъектИС = Неопределено Тогда
					РегистрыСведений.ОбъектыИнтегрированныеС1СДокументооборотом.ДобавитьСвязь(ID, Тип, Владелец);
				КонецЕсли;
			Иначе
				ID = "";
				Тип = "";
			КонецЕсли;
			
			ПрочитатьИОбновитьСписокФайлов();
			
			Элементы.ДобавитьПечатнуюФорму.Доступность = СостояниеРазрешаетДобавлениеФайла;
			Элементы.ДобавитьСДиска.Доступность = (СостояниеРазрешаетДобавлениеФайла
				Или СостояниеРазрешаетДобавлениеСканКопии);
			Элементы.ДобавитьСДискаКонтекст.Доступность = (СостояниеРазрешаетДобавлениеФайла
				Или СостояниеРазрешаетДобавлениеСканКопии);
			
			Элементы.ОткрытьДляРедактирования.Доступность = СостояниеРазрешаетРедактированиеФайла;
			Элементы.КонтекстОткрытьДляРедактирования.Доступность = СостояниеРазрешаетРедактированиеФайла;
			Элементы.ЗакончитьРедактирование.Доступность = СостояниеРазрешаетРедактированиеФайла;
			Элементы.КонтекстЗакончитьРедактирование.Доступность = СостояниеРазрешаетРедактированиеФайла;
			Элементы.ОбновитьИзФайлаНаДиске.Доступность = СостояниеРазрешаетРедактированиеФайла;
			Элементы.ОбновитьИзФайлаНаДискеКонтекст.Доступность = СостояниеРазрешаетРедактированиеФайла;
			Элементы.СохранитьИзменения.Доступность = СостояниеРазрешаетРедактированиеФайла;
			
			Элементы.ПоказыватьУдаленные.Видимость = ДоступныПомеченныеНаУдаление;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Общее завершение команд редактирования. Обновляет форму.
//
&НаКлиенте
Процедура КомандыРедактированияЗавершение(Результат, Параметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура")
		И Результат.Свойство("Идентификатор") Тогда
		ОбновитьСписокФайловКлиент(Результат.Идентификатор);
	Иначе
		ОбновитьСписокФайловКлиент();
	КонецЕсли;
	
КонецПроцедуры

// Завершает добавление файла с диска и обновляет форму.
&НаКлиенте
Процедура ДобавитьСДискаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		ID = Результат.id;
		Тип = Результат.type;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ID) Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("СоздатьФайлЗавершение", ЭтаФорма, Новый Структура);
	
	Если СостояниеРазрешаетДобавлениеСканКопии
		И Не СостояниеРазрешаетДобавлениеФайла Тогда
		
		ТекстВопроса = НСтр("ru = 'В текущем состоянии можно добавить только скан-копию оригинала документа. Продолжить?'");
		ЗаголовокВопроса = НСтр("ru = 'Добавление файла'");
		
		ИнтеграцияС1СДокументооборотКлиент.ПоказатьВопросДаНет(Оповещение, ТекстВопроса, КодВозвратаДиалога.Да,,,
			ЗаголовокВопроса);
	Иначе
		ВыполнитьОбработкуОповещения(Оповещение, КодВозвратаДиалога.Да);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьФайлЗавершение(Результат, ПараметрыОповещения) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("КомандыРедактированияЗавершение", ЭтаФорма);
	ИнтеграцияС1СДокументооборотКлиент.СоздатьФайлСДиска(
		УникальныйИдентификатор,
		ID,
		Тип,
		Строка(Владелец),
		Владелец,
		ОписаниеОповещения,
		(СостояниеРазрешаетДобавлениеСканКопии И Не СостояниеРазрешаетДобавлениеФайла));
	
КонецПроцедуры

// Продолжает добавление печатной формы владельца.
&НаКлиенте
Процедура ДобавитьПечатнуюФормуЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		ID = Результат.id;
		Тип = Результат.type;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ID) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОбъектИС", Владелец);
	ПараметрыФормы.Вставить("ИдентификаторОбъектаДО", ID);
	ПараметрыФормы.Вставить("ТипОбъектаДО", Тип);
	ОписаниеОповещения = Новый ОписаниеОповещения("ДобавлениеПечатнойФормыЗавершение", ЭтаФорма);
	ФормаДобавления = ОткрытьФорму(
		"Обработка.ИнтеграцияС1СДокументооборот.Форма.ДобавлениеПечатнойФормы", 
		ПараметрыФормы, ЭтаФорма,,,,
		ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	Если ФормаДобавления = Неопределено Тогда
		ТекстПредупреждения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%1 не имеет печатных форм.'"), Строка(Владелец));
		ПоказатьПредупреждение(, ТекстПредупреждения);
	КонецЕсли;
	
КонецПроцедуры

// Завершает добавление печатной формы владельца. Обновляет форму.
&НаКлиенте
Процедура ДобавлениеПечатнойФормыЗавершение(Результат, Параметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Массив")
		И Результат.Количество() > 0 Тогда
		ОбновитьСписокФайловКлиент(Результат[0].Идентификатор);
	КонецЕсли;
	
КонецПроцедуры

// Обновляет список файлов, заново получая его из ДО.
//
&НаКлиенте
Процедура ОбновитьСписокФайловКлиент(ИдентификаторФайла = Неопределено)
	
	Если ИдентификаторФайла <> Неопределено Тогда
		ТекущийИдентификаторФайла = ИдентификаторФайла;
	ИначеЕсли Элементы.Файлы.ТекущиеДанные <> Неопределено Тогда
		ТекущийИдентификаторФайла = Элементы.Файлы.ТекущиеДанные.ID;
	КонецЕсли;
	
	ОбработатьФормуСогласноВерсииСервиса();
	
	// Восстановим положение в списке.
	Для Каждого Строка Из Файлы Цикл
		Если Строка.ID = ТекущийИдентификаторФайла Тогда
			Элементы.Файлы.ТекущаяСтрока = Строка.ПолучитьИдентификатор();
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Получает список файлов из ДО и обновляет список.
&НаСервере
Процедура ПрочитатьИОбновитьСписокФайлов()
	
	Файлы.Очистить();
	
	Если Не ЗначениеЗаполнено(ID) Тогда
		Возврат;
	КонецЕсли;
	
	Прокси = ИнтеграцияС1СДокументооборотПовтИсп.ПолучитьПрокси();
	ОбъектИд = ИнтеграцияС1СДокументооборот.СоздатьObjectID(Прокси, ID, Тип);
	
	Запрос = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMRetrieveRequest");
	Запрос.objectIds.Добавить(ОбъектИд);
	Запрос.columnSet.Добавить("files");
	
	Если Тип = "DMInternalDocument"
		Или Тип = "DMIncomingDocument"
		Или Тип = "DMOutgoingDocument" Тогда
		Запрос.columnSet.Добавить("enabledProperties");
	КонецЕсли;
	
	Если ПоказыватьУдаленные Тогда
		Запрос.columnSet.Добавить("ignoreDeletionMark");
	КонецЕсли;
	
	Результат = Прокси.execute(Запрос);
	ИнтеграцияС1СДокументооборот.ПроверитьВозвратВебСервиса(Прокси, Результат);
	
	ОбъектXDTO = Результат.objects[0];
	ИнтеграцияС1СДокументооборотВызовСервера.ОбновитьСписокФайлов(ОбъектXDTO.files, Файлы);
	
	Если ИспользоватьЭлектронныеПодписи Тогда
		ИнтеграцияС1СДокументооборотВызовСервера.ОбновитьСписокПодписейФайлов(
			ОбъектXDTO.files, Подписи, УникальныйИдентификатор);
	КонецЕсли;
	
	// Уточним доступность команд добавления и редактирования.
	СостояниеРазрешаетДобавлениеФайла = Истина;
	СостояниеРазрешаетРедактированиеФайла = Истина;
	СостояниеРазрешаетДобавлениеСканКопии = Истина;
	Если ОбъектXDTO.Свойства().Получить("enabledProperties") <> Неопределено
		И ОбъектXDTO.enabledProperties.Количество() <> 0 Тогда
		СостояниеРазрешаетДобавлениеФайла = Ложь;
		СостояниеРазрешаетРедактированиеФайла = Ложь;
		СостояниеРазрешаетДобавлениеСканКопии = Ложь;
		Для Каждого ДоступноеПоле из ОбъектXDTO.enabledProperties Цикл
			Если НРег(ДоступноеПоле) = "addfile" Тогда
				СостояниеРазрешаетДобавлениеФайла = Истина;
			ИначеЕсли НРег(ДоступноеПоле) = "editfile" Тогда
				СостояниеРазрешаетРедактированиеФайла = Истина;
			ИначеЕсли НРег(ДоступноеПоле) = "addscannedcopy" Тогда
				СостояниеРазрешаетДобавлениеСканКопии = Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// Открывает карточку выбранного файла.
//
&НаКлиенте
Процедура ОткрытьКарточку()
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("РазрешеноРедактирование",
			СостояниеРазрешаетРедактированиеФайла);
		ИнтеграцияС1СДокументооборотКлиент.ОткрытьОбъект("DMFile", ТекущиеДанные.ID,
			ЭтаФорма, ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

// Завершает удаление файла после вопроса пользователю.
//
&НаКлиенте
Процедура ФайлыПередУдалениемЗавершение(Результат, ПараметрыОповещения) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ПометитьНаУдаление(ПараметрыОповещения.ВыделенныеСтроки);
		ОбновитьСписокФайловКлиент();
	КонецЕсли;
	
КонецПроцедуры

// Помечает на удаление выделенные файлы.
//
&НаСервере
Процедура ПометитьНаУдаление(Знач ВыделенныеСтроки)
	
	Прокси = ИнтеграцияС1СДокументооборотПовтИсп.ПолучитьПрокси();
	Запрос = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMDeleteRequest");
	
	Для Каждого НомерСтроки Из ВыделенныеСтроки Цикл
		Данные = Файлы.НайтиПоИдентификатору(НомерСтроки);
		ОбъектXDTO = ИнтеграцияС1СДокументооборот.СоздатьObjectID(Прокси, Данные.ID, "DMFile");
		Запрос.objectIds.Добавить(ОбъектXDTO);
	КонецЦикла;
	
	Ответ = Прокси.execute(Запрос);
	ИнтеграцияС1СДокументооборот.ПроверитьВозвратВебСервиса(Прокси, Ответ);
	
КонецПроцедуры

// Меняет доступность команд в зависимости от выбранного файла.
//
&НаКлиенте
Процедура УстановитьДоступностьКомандСпискаФайлов()
	
	ТекущиеДанные = Элементы.Файлы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда 
		
		Элементы.ОткрытьНаЧтение.Доступность = Ложь;
		Элементы.КонтекстОткрытьНаЧтение.Доступность = Ложь;
		Элементы.ОткрытьДляРедактирования.Доступность = Ложь;
		Элементы.КонтекстОткрытьДляРедактирования.Доступность = Ложь;
		Элементы.ЗакончитьРедактирование.Доступность = Ложь;
		Элементы.КонтекстЗакончитьРедактирование.Доступность = Ложь;
		Элементы.СохранитьНаДиск.Доступность = Ложь;
		Элементы.СохранитьНаДискКонтекст.Доступность = Ложь;
		Элементы.ОбновитьИзФайлаНаДиске.Доступность = Ложь;
		Элементы.ОбновитьИзФайлаНаДискеКонтекст.Доступность = Ложь;
		Элементы.СохранитьИзменения.Доступность = Ложь;
		Элементы.ОтменитьРедактирование.Доступность = Ложь;
		Элементы.ОтменитьРедактированиеКонтекст.Доступность = Ложь;
		Элементы.ОткрытьКарточку.Доступность = Ложь;
		Элементы.ОткрытьКарточкуКонтекст.Доступность = Ложь;
		Элементы.Удалить.Доступность = Ложь;
		Элементы.УдалитьКонтекст.Доступность = Ложь;
		
	Иначе
		
		Редактируется = ТекущиеДанные.Редактируется;
		РедактируетсяТекущимПользователем = ТекущиеДанные.РедактируетсяТекущимПользователем;
		РедактируетсяДругимПользователем = 
			Редактируется
			И НЕ РедактируетсяТекущимПользователем;
		МожноЗахватить = 
			СостояниеРазрешаетРедактированиеФайла
			И ДоступенЗахватФайлов
			И НЕ РедактируетсяДругимПользователем;
		МожноОтпустить =
			СостояниеРазрешаетРедактированиеФайла
			И ДоступенЗахватФайлов
			И РедактируетсяТекущимПользователем;
		
		Элементы.ОткрытьНаЧтение.Доступность = Истина;
		Элементы.КонтекстОткрытьНаЧтение.Доступность = Истина;
		Элементы.ОткрытьДляРедактирования.Доступность = МожноЗахватить;
		Элементы.КонтекстОткрытьДляРедактирования.Доступность = МожноЗахватить;
		Элементы.ЗакончитьРедактирование.Доступность = МожноОтпустить;
		Элементы.КонтекстЗакончитьРедактирование.Доступность = МожноОтпустить;
		Элементы.СохранитьИзменения.Доступность = МожноОтпустить;
		Элементы.ОтменитьРедактирование.Доступность = МожноОтпустить;
		Элементы.ОтменитьРедактированиеКонтекст.Доступность = МожноОтпустить;
		Элементы.СохранитьНаДиск.Доступность = Истина;
		Элементы.СохранитьНаДискКонтекст.Доступность = Истина;
		Элементы.ОбновитьИзФайлаНаДиске.Доступность = МожноЗахватить;
		Элементы.ОбновитьИзФайлаНаДискеКонтекст.Доступность = МожноЗахватить;
		Элементы.ОткрытьКарточку.Доступность = Истина;
		Элементы.ОткрытьКарточкуКонтекст.Доступность = Истина;
		Элементы.Удалить.Доступность = МожноЗахватить;
		Элементы.УдалитьКонтекст.Доступность = МожноЗахватить;
		
	КонецЕсли;
	
КонецПроцедуры

// Обновляет картинку предпросмотра.
//
&НаСервере
Процедура ОбновитьПредпросмотр(ТекущаяСтрока)
	
	Если Не Предпросмотр
		Или ТекущаяСтрока = Неопределено Тогда
		АдресДанныхФайла = "";
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Файлы.НайтиПоИдентификатору(ТекущаяСтрока);
	
	Если РасширенияПоддерживающиеПредпросмотр.НайтиПоЗначению(НРег(ТекущиеДанные.Расширение)) <> Неопределено Тогда
		Если Не ЗначениеЗаполнено(ТекущиеДанные.АдресДанныхФайла) Тогда
			ТекущиеДанные.АдресДанныхФайла = ИнтеграцияС1СДокументооборотВызовСервера.ПолучитьФайлИПоместитьВХранилище(
				ТекущиеДанные.ID,
				УникальныйИдентификатор);
		КонецЕсли;
		АдресДанныхФайла = ТекущиеДанные.АдресДанныхФайла;
	Иначе
		АдресДанныхФайла = "";
		Элементы.КартинкаПредпросмотра.ТекстНевыбраннойКартинки = НСтр("ru = 'Предпросмотр файлов этого типа не поддерживается.'");
	КонецЕсли;
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////////////////////////
// Почта

// Формирует параметры исходящего письма со вложениями.
//
// Параметры:
//   Владелец - Произвольный - владелец файлов.
//   Вложения - Массив - массив структур со свойствами:
//     Представление - Строка - представление файла;
//     Идентификатор - Строка - идентификатор файла в ДО.
//   УникальныйИдентификатор - Строка - идентификатор формы-владельца.
//
&НаСервереБезКонтекста
Функция ПараметрыИсходящегоПисьма(Знач Владелец, Знач Вложения, Знач УникальныйИдентификатор)
	
	// Подготовим заголовок письма.
	Параметры = Новый Структура("УдалятьФайлыПослеОтправки", Истина);
	ОдноВложение = Вложения.Количество() = 1;
	
	// Получатель.
	Если ОбщегоНазначения.ПодсистемаСуществует("ОтправкаПочтовыхСообщений") Тогда
		МодульОтправкаПочтовыхСообщений = 
			ОбщегоНазначения.ОбщийМодуль("ОтправкаПочтовыхСообщений");
	Иначе
		МодульОтправкаПочтовыхСообщений = Неопределено;
	КонецЕсли;
	
	Если ОбщегоНазначения.ЕстьРеквизитОбъекта("Контрагент", Владелец.Метаданные())
		И МодульОтправкаПочтовыхСообщений <> Неопределено Тогда
		Контрагент = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Владелец, "Контрагент");
		Параметры.Вставить("Получатель", МодульОтправкаПочтовыхСообщений.АдресаЭлектроннойПочты(Контрагент));
	Иначе
		Параметры.Вставить("Получатель", "");
	КонецЕсли;
	
	// Тема.
	НомерДокумента = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Владелец, "Номер");
	Если Метаданные.ОбщиеМодули.Найти("ПрефиксацияОбъектовКлиентСервер") <> Неопределено Тогда
		МодульПрефиксацияОбъектовКлиентСервер = ОбщегоНазначения.ОбщийМодуль("ПрефиксацияОбъектовКлиентСервер");
		НомерДокумента = МодульПрефиксацияОбъектовКлиентСервер.НомерНаПечать(НомерДокумента, Истина, Истина);
	КонецЕсли;
	ДатаДокумента  = Формат(ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Владелец, "Дата"), "ДЛФ=DD");
	Тема = СтрШаблон(НСтр("ru='%1, %2 к документу %3 %4 от %5'"),
		?(ОдноВложение, НСтр("ru='Файл'"), НСтр("ru='Файлы'")),
		?(ОдноВложение, НСтр("ru='присоединенный'"), НСтр("ru='присоединенные'")),
		ТипЗнч(Владелец),
		НомерДокумента,
		ДатаДокумента);
	Параметры.Вставить("Тема", Тема);
	
	// Текст.
	Текст = СтрШаблон(НСтр("ru='К письму %1 %2:'"),
		?(ОдноВложение, НСтр("ru='присоединен'"), НСтр("ru='присоединены'")),
		?(ОдноВложение, НСтр("ru='файл'"), НСтр("ru='файлы'")));
	
	// Получим вложения из ДО.
	Для Каждого Вложение Из Вложения Цикл
		АдресВоВременномХранилище = ИнтеграцияС1СДокументооборотВызовСервера.ПолучитьФайлИПоместитьВХранилище(
			Вложение.Идентификатор,
			УникальныйИдентификатор);
		Вложение.Вставить("АдресВоВременномХранилище", АдресВоВременномХранилище);
		Текст = Текст + Символы.ПС + СтрШаблон(НСтр("ru='- %1'"), Вложение.Представление);
	КонецЦикла;
	Параметры.Вставить("Вложения", Вложения);
	
	Если МодульОтправкаПочтовыхСообщений <> Неопределено Тогда
		ПодготовленныйТекст = МодульОтправкаПочтовыхСообщений.ПодготовитьТекстПисьма(Текст);
		Параметры.Вставить("Текст", ПодготовленныйТекст);
		МодульОтправкаПочтовыхСообщений.ДополнитьПараметрыПисьма(Параметры);
	КонецЕсли;
	
	Возврат Параметры;
	
КонецФункции

// Начинает отправку письма через ДО. Вызывается, если включена соответствующая ФО.
//
&НаКлиенте
Процедура ОтправитьЧерезДокументооборот()
		
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ОтправитьЧерезДокументооборотЗавершение", ЭтотОбъект);
		
	Если ЗначениеЗаполнено(ID) Тогда
			
		Предмет = Новый Структура;
		Предмет.Вставить("id", ID);
		Предмет.Вставить("type", Тип);
		Предмет.Вставить("name", Строка(Владелец));
		
		ВыполнитьОбработкуОповещения(ОписаниеОповещения, Предмет);
		
	Иначе
	
		ИнтеграцияС1СДокументооборотКлиент.НачатьПоискСвязанногоОбъектаДО(Владелец, ОписаниеОповещения);
		
	КонецЕсли;
	
КонецПроцедуры

// Завершает отправку письма через ДО после нахождения связанного документа ДО.
//
&НаКлиенте
Процедура ОтправитьЧерезДокументооборотЗавершение(Предмет, Параметры) Экспорт
	
	Если ТипЗнч(Предмет) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	Параметры = Новый Структура;
	Параметры.Вставить("Предмет", Предмет);
	
	ОткрытьФорму("Обработка.ИнтеграцияС1СДокументооборот.Форма.ИсходящееПисьмо", Параметры);
	
КонецПроцедуры

// Начинает отправку письма средствами ИС, если использование почты ДО выключено.
//
&НаКлиенте
Процедура ОтправитьЧерезИС()
		
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ОтправитьЧерезИСНастройкаУчетнойЗаписиПредложена", ЭтотОбъект);
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями") Тогда
		МодульРаботаСПочтовымиСообщениямиКлиент = 
			ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСПочтовымиСообщениямиКлиент");
		МодульРаботаСПочтовымиСообщениямиКлиент.
			ПроверитьНаличиеУчетнойЗаписиДляОтправкиПочты(ОписаниеОповещения);
	КонецЕсли;
		
КонецПроцедуры

// Продолжает отправку письма средствами ИС после помещения файлов из ДО в хранилище.
//
&НаКлиенте
Процедура ОтправитьЧерезИСНастройкаУчетнойЗаписиПредложена(УчетнаяЗаписьНастроена, Параметры) Экспорт
	
	Если УчетнаяЗаписьНастроена <> Истина Тогда
		Возврат;
	КонецЕсли;
	
	Вложения = Новый Массив;
	Для Каждого ВыделеннаяСтрока Из Элементы.Файлы.ВыделенныеСтроки Цикл
		Строка = Файлы.НайтиПоИдентификатору(ВыделеннаяСтрока);
		Вложение = Новый Структура;
		Вложение.Вставить("Представление", Строка.Наименование);
		Вложение.Вставить("Идентификатор", Строка.ID);
		Вложения.Добавить(Вложение);
	КонецЦикла;
	
	Параметры = ПараметрыИсходящегоПисьма(Владелец, Вложения, УникальныйИдентификатор);
	
	МодульРаботаСПочтовымиСообщениямиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСПочтовымиСообщениямиКлиент");
	МодульРаботаСПочтовымиСообщениямиКлиент.СоздатьНовоеПисьмо(Параметры);
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////////////////////////
// Электронная подпись

// Получает сведения об ЭП из ДО.
//
&НаСервере
Функция ДанныеПодписейФайла(ИдентификаторФайла)
	
	Возврат ИнтеграцияС1СДокументооборотВызовСервера.ДанныеПодписейФайла(
		ИдентификаторФайла, Подписи);
	
КонецФункции

// Вызывается после добавления ЭП из файла и обновляет форму.
//
&НаКлиенте
Процедура ДобавитьЭПИзФайлаЗавершение(Успешно, ПараметрыОповещения) Экспорт
	
	Если Успешно Тогда
		ПрочитатьИОбновитьСписокФайловИПодписей();
	КонецЕсли;
	
КонецПроцедуры

// Получает подписи из ДО и обновляет форму.
//
&НаСервере
Процедура ПрочитатьИОбновитьСписокФайловИПодписей()
	
	Прокси = ИнтеграцияС1СДокументооборотПовтИсп.ПолучитьПрокси();
	ОбъектИд = ИнтеграцияС1СДокументооборот.СоздатьObjectID(Прокси, ID, Тип);
	
	Запрос = ИнтеграцияС1СДокументооборот.СоздатьОбъект(Прокси, "DMRetrieveRequest");
	Запрос.objectIds.Добавить(ОбъектИд);
	Запрос.columnSet.Добавить("files");
	
	Если Тип = "DMInternalDocument"
			Или Тип = "DMIncomingDocument"
			Или Тип = "DMOutgoingDocument" Тогда
		Запрос.columnSet.Добавить("enabledProperties");
	КонецЕсли;
	
	Если ПоказыватьУдаленные Тогда
		Запрос.columnSet.Добавить("ignoreDeletionMark");
	КонецЕсли;
	
	Результат = Прокси.execute(Запрос);
	ИнтеграцияС1СДокументооборот.ПроверитьВозвратВебСервиса(Прокси, Результат);
	
	ОбъектXDTO = Результат.objects[0];
	
	ИнтеграцияС1СДокументооборотВызовСервера.ОбновитьСписокФайлов(
		ОбъектXDTO.files, Файлы);
	
	ИнтеграцияС1СДокументооборотВызовСервера.ОбновитьСписокПодписейФайлов(
		ОбъектXDTO.files, Подписи, УникальныйИдентификатор);
	
КонецПроцедуры

#КонецОбласти