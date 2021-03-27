﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ИдентификаторЗапроса", ИдентификаторЗапроса);
	
	АдресДереваДокумента = Неопределено;
	Параметры.Свойство("АдресДереваДокумента", АдресДереваДокумента);
	
	Если ЭтоАдресВременногоХранилища(АдресДереваДокумента) Тогда
		ДеревоДокумента = ПолучитьИзВременногоХранилища(АдресДереваДокумента);
	Иначе
		Отказ = Истина;
		Возврат;
	КонецЕсли;
		
	ЗаполнитьТаблицуФайлов();
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПрикрепленныеФайлы

&НаКлиенте
Процедура ПрикрепленныеФайлыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьПрикрепленныйФайл();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Просмотреть(Команда)
	
	ОткрытьПрикрепленныйФайл();
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьКак(Команда)
	
	ТекущиеДанные = Элементы.ПрикрепленныеФайлы.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Описание = Новый ОписаниеОповещения("ВыборФайлаДляСохраненияЗавершение", ЭтотОбъект);
	Фильтр = СтрШаблон(НСтр("ru = '%1|*.%1'"), ТекущиеДанные.Расширение);
		
	Режим = РежимДиалогаВыбораФайла.Сохранение;
	ДиалогСохраненияФайла = Новый ДиалогВыбораФайла(Режим);
	ДиалогСохраненияФайла.ПолноеИмяФайла = ТекущиеДанные.ПредставлениеФайла;
	ДиалогСохраненияФайла.Расширение = ТекущиеДанные.Расширение;
	ДиалогСохраненияФайла.Фильтр = Фильтр;
	ДиалогСохраненияФайла.МножественныйВыбор = Ложь;
	ДиалогСохраненияФайла.Показать(Описание);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьТаблицуФайлов()
	
	СведенияОФайлах = ДеревоДокумента.Строки.Найти("ПрисоединенныеФайлы", "ПолныйПуть");
	ПрикрепленныеФайлы.Очистить();
	
	Для Каждого Файл Из СведенияОФайлах.Строки Цикл
		
		НоваяСтрока = ПрикрепленныеФайлы.Добавить();
		НоваяСтрока.ПредставлениеФайла = ЭлектронноеВзаимодействие.ЗначениеРеквизитаВДереве(Файл,
			"ПрисоединенныеФайлы.НомерСтроки.ИмяФайла");
		
		НоваяСтрока.Расширение = ЭлектронноеВзаимодействие.ЗначениеРеквизитаВДереве(Файл,
			"ПрисоединенныеФайлы.НомерСтроки.РасширениеФайла");
		
		НоваяСтрока.ФайлДвоичныеДанные = ЭлектронноеВзаимодействие.ЗначениеРеквизитаВДереве(Файл,
			"ПрисоединенныеФайлы.НомерСтроки.ДвоичныеДанные");
		
		НоваяСтрока.ИдентификаторФайла     = Файл.Значение;
		НоваяСтрока.ИндексКартинки         = РаботаСФайламиСлужебныйКлиентСервер.ПолучитьИндексПиктограммыФайла(НоваяСтрока.Расширение);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьАдресДереваДокумента()

	Возврат ПоместитьВоВременноеХранилище(ДеревоДокумента);

КонецФункции

&НаКлиенте
Процедура ВыборФайлаДляСохраненияЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы = Неопределено
			Или ВыбранныеФайлы.Количество() = 0 Тогда
			
			Возврат;
			
		КонецЕсли;
		
	ОткрытьПрикрепленныйФайл(ВыбранныеФайлы[0]);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПрикрепленныйФайл(ПутьДляСохранения = Неопределено)
	
	ТекущиеДанные = Элементы.ПрикрепленныеФайлы.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ТекущиеДанные.ФайлДвоичныеДанные)
		И ТипЗнч(ТекущиеДанные.ФайлДвоичныеДанные) = Тип("ДвоичныеДанные") Тогда
		
		Если ЗначениеЗаполнено(ПутьДляСохранения) Тогда
			СохранитьДвоичныеДанные(ПутьДляСохранения, ТекущиеДанные);
		Иначе
			ОткрытьДвоичныеДанные(ТекущиеДанные);
		КонецЕсли;
		
		Возврат;
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(НСтр("ru = 'Получение файла'"),, СтрШаблон(НСтр("ru = 'Выполняется получение файла %1'"),
					ТекущиеДанные.ПредставлениеФайла), БиблиотекаКартинок.СинхронизацияДанныхДлительнаяОперация48);
					
	ДополнительныеПараметры = Новый Структура("ПредставлениеФайла, ИдентификаторФайла, ПутьДляСохранения",
	ТекущиеДанные.ПредставлениеФайла, ТекущиеДанные.ИдентификаторФайла, ПутьДляСохранения);
	
	Описание = Новый ОписаниеОповещения("ПолучениеПрисоединенногоФайлаЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ИдентификаторЗапроса"   , ИдентификаторЗапроса);
	ПараметрыПроцедуры.Вставить("ИдентификаторФайла"     , ТекущиеДанные.ИдентификаторФайла);
	
	ДлительнаяОперация = НачатьПолучениеФайлаИзСервиса(ПараметрыПроцедуры);
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Описание, ПараметрыОжидания);
	
КонецПроцедуры

&НаСервере
Функция НачатьПолучениеФайлаИзСервиса(Знач ПараметрыПроцедуры)
	
	ПараметрыПроцедуры.Вставить("ДеревоДокумента", ДеревоДокумента);
	
	НаименованиеФоновогоЗадания = НСтр("ru = 'Получение файла из сервиса 1С:ЗКП'");
	ИмяПроцедуры = "Обработки.ЗапросыКоммерческихПредложений.ПолучитьФайлИзСервиса";
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НаименованиеФоновогоЗадания;
	ПараметрыВыполнения.ЗапуститьВФоне = Истина;
	ПараметрыВыполнения.ОжидатьЗавершение = 0;
	
	Возврат ДлительныеОперации.ВыполнитьВФоне(ИмяПроцедуры, ПараметрыПроцедуры, ПараметрыВыполнения);
	
КонецФункции

&НаКлиенте
Процедура ПолучениеПрисоединенногоФайлаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат.Статус = "Выполнено" Тогда
		
		ИдентификаторСтроки = ДополнительныеПараметры.ИдентификаторФайла;
		Если ЗагрузитьДерево(Результат.АдресРезультата, ИдентификаторСтроки) Тогда
			
			Если Не ЗначениеЗаполнено(ИдентификаторСтроки) Тогда
				Возврат;
			КонецЕсли;
			
			Оповестить("ОбновленоДеревоЗапросаКП", ПолучитьАдресДереваДокумента(), ИдентификаторЗапроса);
			
			ТекущаяСтрока = Элементы.ПрикрепленныеФайлы.ДанныеСтроки(ИдентификаторСтроки);
			ПоказатьОповещениеПользователя(НСтр("ru = 'Получение файла'"),, СтрШаблон(НСтр("ru = 'Получение файла %1 выполнено.'"),
				ДополнительныеПараметры.ПредставлениеФайла), БиблиотекаКартинок.Успешно32);
		
			Если ЗначениеЗаполнено(ДополнительныеПараметры.ПутьДляСохранения) Тогда
				
				СохранитьДвоичныеДанные(ДополнительныеПараметры.ПутьДляСохранения, ТекущаяСтрока);
				
			Иначе
			
				ОткрытьДвоичныеДанные(ТекущаяСтрока);
			
			КонецЕсли;
		КонецЕсли;
	Иначе
		
		ПоказатьОповещениеПользователя(НСтр("ru = 'Получение файла'"),,
			СтрШаблон(НСтр("ru = 'Не удалось получить файл %1 по причине
			|%2'"),
			ДополнительныеПараметры.ПредставлениеФайла, Результат.КраткоеПредставлениеОшибки),
			БиблиотекаКартинок.Ошибка32);
		
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗагрузитьДерево(Знач АдресРезультата, ИдентификаторСтроки)
	
	Ответ = Ложь;
	Результат = ПолучитьИзВременногоХранилища(АдресРезультата);
	
	Если ЗначениеЗаполнено(Результат) Тогда
		
		ДеревоДокумента = Результат;
		
		ЗаполнитьТаблицуФайлов();
		Ответ = Истина;
		
		НайденныеСтроки = ПрикрепленныеФайлы.НайтиСтроки(Новый Структура("ИдентификаторФайла", ИдентификаторСтроки));
		
		Если НайденныеСтроки.Количество() > 0 Тогда
			ИдентификаторСтроки = НайденныеСтроки[0].ПолучитьИдентификатор();
		Иначе
			ИдентификаторСтроки = Неопределено;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Ответ;
КонецФункции

&НаКлиенте
Процедура ОткрытьДвоичныеДанные(ТекущаяСтрока)
	
	#Если ВебКлиент Тогда
		Описание = Новый ОписаниеОповещения("ПослеСозданияКаталога", ЭтотОбъект, ТекущаяСтрока);
		ФайловаяСистемаКлиент.СоздатьВременныйКаталог(Описание);
	#Иначе
		ПослеСозданияКаталога(Истина, ТекущаяСтрока);
	#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеСозданияКаталога(Результат, ДополнительныеПараметры) Экспорт
	
	ИмяВременногоФайла = "";
	
	Если Результат = Истина Тогда
		
		#Если Не ВебКлиент Тогда
			ИмяВременногоФайла = ПолучитьИмяВременногоФайла(ДополнительныеПараметры.Расширение);
		#КонецЕсли
		
	ИначеЕсли ЗначениеЗаполнено(Результат) Тогда
		Каталог = Результат;
		ИмяФайла = Строка(Новый УникальныйИдентификатор) + "." + ДополнительныеПараметры.Расширение;
		ИмяВременногоФайла = Каталог + ИмяФайла;
	Иначе
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не удалось создать временный каталог'"));
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры.ФайлДвоичныеДанные.Записать(ИмяВременногоФайла);
	
	ФайловаяСистемаКлиент.ОткрытьФайл(ИмяВременногоФайла);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДвоичныеДанные(ПутьДляСохранения, ТекущаяСтрока)
	
	ТекущаяСтрока.ФайлДвоичныеДанные.Записать(ПутьДляСохранения);
	
КонецПроцедуры

#КонецОбласти