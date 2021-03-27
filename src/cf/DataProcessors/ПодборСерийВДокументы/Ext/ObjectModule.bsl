﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	ПараметрыПроверкиКоличества = ОбщегоНазначенияУТ.ПараметрыПроверкиЗаполненияКоличества();
	ПараметрыПроверкиКоличества.ИмяТЧ = "Серии";
	
	Если ПараметрыПроверки.ТолькоРедактированиеКоличества Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.Количество");
		МассивНепроверяемыхРеквизитов.Добавить("Серии.КоличествоУпаковок");
	Иначе
		ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ, ПараметрыПроверкиКоличества);
	КонецЕсли;
	
	КлючевыеРеквизиты = Новый Массив;
	
	Если Не ПараметрыПроверки.ИспользоватьСрокГодностиСерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.ГоденДо");
	Иначе
		КлючевыеРеквизиты.Добавить("ГоденДо");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ПроверятьЗаполнениеНомера Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.Номер");
	ИначеЕсли ПараметрыПроверки.ИспользоватьНомерСерии Тогда
		КлючевыеРеквизиты.Добавить("Номер");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьНомерКИЗГИСМСерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.НомерКИЗГИСМ");
	Иначе
		// Если используется НомерКИЗГИСМ, то серия должна быть по нему уникальна.
		// Не может быть две серии с одним НомерКИЗГИСМ и разными номерами.
		КлючевыеРеквизиты = Новый Массив;
		КлючевыеРеквизиты.Добавить("НомерКИЗГИСМ");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьДатуПроизводстваСерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.ДатаПроизводства");
	Иначе
		КлючевыеРеквизиты.Добавить("ДатаПроизводства");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьПроизводителяЕГАИССерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.ПроизводительЕГАИС");
	Иначе
		КлючевыеРеквизиты.Добавить("ПроизводительЕГАИС");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьСправку2ЕГАИССерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.Справка2ЕГАИС");
	Иначе
		КлючевыеРеквизиты.Добавить("Справка2ЕГАИС");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьПроизводителяВЕТИССерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.ПроизводительВЕТИС");
	Иначе
		КлючевыеРеквизиты.Добавить("ПроизводительВЕТИС");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьЗаписьСкладскогоЖурналаВЕТИССерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.ЗаписьСкладскогоЖурналаВЕТИС");
	Иначе
		КлючевыеРеквизиты.Добавить("ЗаписьСкладскогоЖурналаВЕТИС");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьИдентификаторПартииВЕТИССерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.ИдентификаторПартииВЕТИС");
	Иначе
		КлючевыеРеквизиты.Добавить("ИдентификаторПартииВЕТИС");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьМРЦМОТПСерии Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Серии.МаксимальнаяРозничнаяЦенаМОТП");
	Иначе
		КлючевыеРеквизиты.Добавить("МаксимальнаяРозничнаяЦенаМОТП");
	КонецЕсли;
	
	Если Не ПараметрыПроверки.ИспользоватьКоличествоСерии Тогда
		ОбщегоНазначенияУТ.ПроверитьНаличиеДублейСтрокТЧ(ЭтотОбъект,"Серии", КлючевыеРеквизиты, Отказ);
	КонецЕсли;
	
	Если ПараметрыПроверки.ЭтоМаркировкаТоваровГИСМ
		Или ПараметрыПроверки.ИспользоватьRFIDМеткиСерии
		Или (ПараметрыПроверки.ИспользоватьНомерКИЗГИСМСерии
			И ПараметрыПроверки.ЭтоПоступлениеИзТаможенногоСоюза) Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Серии.Номер");
		
		Для каждого СтрТабл Из Серии Цикл
			
			Если ПараметрыПроверки.ИспользоватьRFIDМеткиСерии
				И СтрТабл.ЗаполненRFIDTID
				И СтрТабл.НужноЗаписатьМетку Тогда
				
				ТекстСообщения = НСтр("ru = 'Требуется записать RFID-метку, информация о которой содержится в строке %НомерСтроки%.'");
				
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", Строка(СтрТабл.НомерСтроки));
				Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Серии", СтрТабл.НомерСтроки, "СтатусРаботыRFID");
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,Поле,"Объект",Отказ);
				
			КонецЕсли;
			
			Если(ПараметрыПроверки.ЭтоМаркировкаТоваровГИСМ
				И Не ПараметрыПроверки.ЭтоМаркировкаОстатковГИСМ) Тогда
				Если Не СтрТабл.ЗаполненRFIDTID Тогда
					Если Не ПараметрыПроверки.ЭтоМаркировкаПерсонифицированнымиКиЗ Тогда
						
						ТекстСообщения = НСтр("ru = 'По строке %НомерСтроки% не считана RFID-метка. При маркировке неперсонифицированными КиЗ необходимо обязательно считывать метку и записывать EPC.'");
						ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", Строка(СтрТабл.НомерСтроки));
						Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Серии", СтрТабл.НомерСтроки, "СтатусРаботыRFID");
						
						ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,Поле,"Объект",Отказ);
						
					ИначеЕсли Не ЗначениеЗаполнено(СтрТабл.Номер) Тогда
						
						ТекстСообщения = НСтр("ru = 'По строке %НомерСтроки% не заполнен номер серии. Маркировка осуществляется персонифицированными КиЗ, поэтому номер серии записан в RFID-метку КиЗ. Необходимо считать метку RFID-считывателем.'");
						
						ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", Строка(СтрТабл.НомерСтроки));
						Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Серии", СтрТабл.НомерСтроки, "Номер");
						
						ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,Поле,"Объект",Отказ);
					КонецЕсли;
				КонецЕсли;
			ИначеЕсли ПараметрыПроверки.ЭтоПоступлениеИзТаможенногоСоюза Тогда
				
				Если Не СтрТабл.ЗаполненRFIDTID Тогда
					
					ТекстСообщения = НСтр("ru = 'По строке %НомерСтроки% не считана RFID-метка. Оформляется ввоз из стран ЕАЭС маркируемых товаров, поэтому считывать RFID-метки обязательно.'");
					
					ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", Строка(СтрТабл.НомерСтроки));
					Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Серии", СтрТабл.НомерСтроки, "СтатусРаботыRFID");
					
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,Поле,"Объект",Отказ);
					
				ИначеЕсли Не ЗначениеЗаполнено(СтрТабл.Номер)Тогда
					
					ТекстСообщения = НСтр("ru = 'По строке %НомерСтроки% не заполнен номер серии. Оформляется ввоз из стран ЕАЭС маркируемых товаров, поэтому номер серии записан в RFID-метку КиЗ. Необходимо считать метку RFID-считывателем.'");
					
					ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", Строка(СтрТабл.НомерСтроки));
					Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Серии", СтрТабл.НомерСтроки, "Номер");
					
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,Поле,"Объект",Отказ);
				КонецЕсли;
				
			КонецЕсли
		КонецЦикла;
		
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли