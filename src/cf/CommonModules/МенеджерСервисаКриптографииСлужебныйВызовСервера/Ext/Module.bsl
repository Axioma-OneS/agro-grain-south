////////////////////////////////////////////////////////////////////////////////
// Подсистема "Менеджер сервиса криптографии".
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Функция СоздатьКонтейнерИЗапросНаСертификат(ИдентификаторЗаявления,
										СодержаниеЗапроса,
										НомерТелефона,
										ЭлектроннаяПочта,
										ИдентификаторАбонента = Неопределено,
										НотариусАдвокатГлаваКФХ = Ложь) Экспорт
	
	ПараметрыПроцедуры 	= Новый Структура;
	ПараметрыПроцедуры.Вставить("ИдентификаторЗаявления", 	ИдентификаторЗаявления);
	ПараметрыПроцедуры.Вставить("СодержаниеЗапроса", 		СодержаниеЗапроса);
	ПараметрыПроцедуры.Вставить("НомерТелефона", 			НомерТелефона);
	ПараметрыПроцедуры.Вставить("ЭлектроннаяПочта", 		ЭлектроннаяПочта);
	ПараметрыПроцедуры.Вставить("ИдентификаторАбонента", 	ИдентификаторАбонента);
	ПараметрыПроцедуры.Вставить("НотариусАдвокатГлаваКФХ", 	НотариусАдвокатГлаваКФХ);
		
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("МенеджерСервисаКриптографии.СоздатьКонтейнерИЗапросНаСертификат", 
						ПараметрыПроцедуры);
	
КонецФункции	

Функция УстановитьСертификатВКонтейнерИХранилище(ИдентификаторЗаявления, ДанныеСертификата) Экспорт
	
	ПараметрыПроцедуры 	= Новый Структура;
	ПараметрыПроцедуры.Вставить("ИдентификаторЗаявления",	ИдентификаторЗаявления);
	ПараметрыПроцедуры.Вставить("ДанныеСертификата", 		ДанныеСертификата);
		
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("МенеджерСервисаКриптографии.УстановитьСертификатВКонтейнерИХранилище", 
					ПараметрыПроцедуры);
	
КонецФункции

#КонецОбласти
