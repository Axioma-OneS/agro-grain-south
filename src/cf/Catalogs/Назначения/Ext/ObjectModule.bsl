﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		ОбщегоНазначенияУТ.ПодготовитьДанныеДляСинхронизацииКлючей(ЭтотОбъект, ПараметрыСинхронизацииКлючей());
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ЭтоНовый() Тогда
		ДвиженияПоСкладскимРегистрам = Истина;
	КонецЕсли;
	
	КонтролироватьТолькоНаличие =
		НЕ Партнер.Пустая() И НЕ ЗначениеЗаполнено(Заказ)
		ИЛИ НЕ НаправлениеДеятельности.Пустая() И НЕ ЗначениеЗаполнено(Заказ)
			И ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НаправлениеДеятельности, "ДопускаетсяОбособлениеСверхПотребности");
	
	ОбщегоНазначенияУТ.ПодготовитьДанныеДляСинхронизацииКлючей(ЭтотОбъект, ПараметрыСинхронизацииКлючей());
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	ОбщегоНазначенияУТ.СинхронизироватьКлючи(ЭтотОбъект);
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ВызватьИсключение НСтр("ru = 'Копирование недоступно'");;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыСинхронизацииКлючей()
	
	Результат = Новый Соответствие;
	
	Результат.Вставить("Справочник.ВидыЗапасов", "ПометкаУдаления");
	Результат.Вставить("Справочник.КлючиАналитикиУчетаНоменклатуры", "ПометкаУдаления");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли
