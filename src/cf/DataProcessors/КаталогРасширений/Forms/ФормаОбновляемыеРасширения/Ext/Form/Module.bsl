
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбновитьСписокОбновляемыхРасширений();
	
КонецПроцедуры

#КонецОбласти

#Область КомандыФормы

&НаКлиенте
Процедура ПрочитатьСписокОбновляемыхРасширений(Команда)
	
	ОбновитьСписокОбновляемыхРасширений();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВсеРасширения(Команда)
	
	Если Список.Количество() = 0 Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Нет расширений для обновлений'"));	
		Возврат;
	КонецЕсли;
	
	УстановитьДоступностьЭлементовОбновления(Ложь);
	
	ТекстВопроса = НСтр("ru = 'Выполнить обновление всех расширений?'")
		+ Символы.ПС + НСтр("ru = 'Работа всех пользователей будет завершена'");
	Описание = Новый ОписаниеОповещения("ОбработатьОбновлениеВсехРасширений", ЭтотОбъект);
	
	ПоказатьВопрос(Описание, ТекстВопроса, РежимДиалогаВопрос.ДаНет,,, НСтр("ru = 'Обновление расширений'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВыбранноеРасширение(Команда)
	
	Если Список.Количество() = 0 Тогда
		Возврат;	
	КонецЕсли;
	
	УстановитьДоступностьЭлементовОбновления(Ложь);
	СтрокаДанных = Элементы.Список.ТекущиеДанные;
	
	ТекстВопроса = СтрШаблон(НСтр("ru = 'Выполнить обновление расширения: %1 ?'")
		+ Символы.ПС + НСтр("ru = 'Работа всех пользователей будет завершена'"), СтрокаДанных.Наименование);
	Описание = Новый ОписаниеОповещения("ОбработатьОбновлениеТекущегоРасширения", ЭтотОбъект, СтрокаДанных);
	
	ПоказатьВопрос(Описание, ТекстВопроса, РежимДиалогаВопрос.ДаНет,,, НСтр("ru = 'Обновление расширений'"));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	КаталогРасширенийКлиент.ОткрытьФормуВерсииРасширения(Элемент.ТекущиеДанные.ИдентификаторВерсии, Элемент.ТекущиеДанные.Наименование, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьДоступностьЭлементовОбновления(Доступность)
	
	Элементы.ФормаОбновитьВыбранноеРасширение.Доступность = Доступность;
	Элементы.ФормаОбновитьВсеРасширения.Доступность = Доступность;
	Элементы.СписокКонтекстноеМенюОбновитьВыбранноеРасширение.Доступность = Доступность;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСписокОбновляемыхРасширений()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Список.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = КаталогРасширений.ТекстЗапросаОбновляемыхРасширений();
	
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрокаДанных = Список.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрокаДанных, Выборка);
		
		ИспользуемоеРасширение = РасширенияВМоделиСервиса.ИспользуемоеРасширение(Выборка.ПоставляемоеРасширение);
		
		Если ИспользуемоеРасширение.Расширение = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		НоваяСтрокаДанных.ТекущаяВерсия = ИспользуемоеРасширение.Расширение.Версия;
		НоваяСтрокаДанных.ИдентификаторИспользуемогоРасширения = ИспользуемоеРасширение.Расширение.УникальныйИдентификатор;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьОбновлениеВсехРасширений(Ответ, ДопПараметры) Экспорт 
		
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		УстановитьДоступностьЭлементовОбновления(Истина);
		Возврат;
	КонецЕсли;
	
	ОбновитьСписокОбновляемыхРасширений();
	
	Если Список.Количество() = 0 Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Нет расширений для обновлений'"));	
		Возврат;		
	КонецЕсли;
	
	ЗавершитьРаботуПользователей();
	
	ВсегоРасширений = Список.Количество();
	Текст = НСтр("ru = 'Обновление расширений'");
	
	Для Каждого СтрокаДанных Из Список Цикл
		
		ТекущийПрогресс = Список.Индекс(СтрокаДанных);
		НачатьОбновлениеРасширения(СтрокаДанных, ТекущийПрогресс, ВсегоРасширений, Текст);
		
	КонецЦикла;
	
	СнятьМонопольныйРежим();
			
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьОбновлениеТекущегоРасширения(Ответ, СтрокаДанныхРасширения) Экспорт 
	
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		УстановитьДоступностьЭлементовОбновления(Истина);
		Возврат;
	КонецЕсли;
	
	ЗавершитьРаботуПользователейПередОбновлением();	
	НачатьОбновлениеРасширения(СтрокаДанныхРасширения, 0, 1, НСтр("ru = 'Обновление расширений'"));
	ОбновитьСписокОбновляемыхРасширений();
	
КонецПроцедуры

&НаКлиенте
Процедура НачатьОбновлениеРасширения(СтрокаДанных, ТекущийПрогресс, ВсегоРасширений, Текст)
	
	Пояснение = СтрШаблон(НСтр("ru = 'Обновление: %1'"), СтрокаДанных.Наименование);
	Состояние(Текст, Окр((ТекущийПрогресс / ВсегоРасширений) * 100, 2), Пояснение, БиблиотекаКартинок.Информация32);
	
	ОбновитьРасширение(СтрокаДанных.ИдентификаторИспользуемогоРасширения);
	
	ТекущийПрогресс = ТекущийПрогресс + 1;
	Состояние(Текст, Окр((ТекущийПрогресс / ВсегоРасширений) * 100, 2), Пояснение, БиблиотекаКартинок.Информация32);	
	
	ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Для вступления изменений в силу требуется перезапустить приложение'"));
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СнятьМонопольныйРежим()
	
	УстановитьМонопольныйРежим(Ложь);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗавершитьРаботуПользователейПередОбновлением()
	
	СеансыДляЗавершения = РасширенияВМоделиСервиса.СеансыОбласти();
	
	Если НЕ СеансыДляЗавершения.Количество() = 0 Тогда
		ПрограммныйИнтерфейсСервиса.ЗавершитьСеансы(СеансыДляЗавершения);
	КонецЕсли;
	
	УстановитьМонопольныйРежим(Истина);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОбновитьРасширение(Знач ИдентификаторИспользуемогоРасширения)
	
	УстановитьПривилегированныйРежим(Истина);
	
	РасширенияВМоделиСервиса.АктуализацияИспользуемогоРасширения(ИдентификаторИспользуемогоРасширения);
	
КонецПроцедуры

#КонецОбласти










