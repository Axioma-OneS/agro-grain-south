﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда


#Область ПрограммныйИнтерфейс

Функция НастройкиПредставленияПравДоступаВЕТИС() Экспорт
	
	НастройкиПредставления = Новый ТаблицаЗначений();
	НастройкиПредставления.Колонки.Добавить("ПравоДоступа");
	НастройкиПредставления.Колонки.Добавить("Заголовок");
	НастройкиПредставления.Колонки.Добавить("Подсказка");
	НастройкиПредставления.Колонки.Добавить("Значимое");
	НастройкиПредставления.Колонки.Добавить("ИмяГруппы");
	
	Для Каждого МетаПравоДоступа Из Метаданные.Перечисления.ПраваДоступаВЕТИС.ЗначенияПеречисления Цикл
		ПравоДоступаИмя = МетаПравоДоступа.Имя;
		
		НастройкаПредставления = НастройкиПредставления.Добавить();
		НастройкаПредставления.ПравоДоступа = ПравоДоступаИмя;
		НастройкаПредставления.Подсказка = МетаПравоДоступа.Синоним;
		
		Если ПравоДоступаИмя = "WebИнтерфейсЧтение" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Доступ через WEB'");
			НастройкаПредставления.Заголовок = НСтр("ru='Просмотр'");
			НастройкаПредставления.Значимое  = Ложь;
			
		ИначеЕсли ПравоДоступаИмя = "WebИнтерфейсЗапись" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Доступ через WEB'");
			НастройкаПредставления.Заголовок = НСтр("ru='Изменение'");
			НастройкаПредставления.Значимое  = Ложь;
			
		ИначеЕсли ПравоДоступаИмя = "APIЧтение" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Доступ через API'");
			НастройкаПредставления.Заголовок = НСтр("ru='Чтение'");
			НастройкаПредставления.Значимое  = Ложь;
			
		ИначеЕсли ПравоДоступаИмя = "APIЗапись" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Доступ через API'");
			НастройкаПредставления.Заголовок = НСтр("ru='Изменение'");
			НастройкаПредставления.Значимое  = Ложь;
			
		ИначеЕсли ПравоДоступаИмя = "АвторизованныйЗаявительАргус" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Заявитель в'");
			НастройкаПредставления.Заголовок = НСтр("ru='Аргус'");
			НастройкаПредставления.Значимое  = Ложь;
			
		ИначеЕсли ПравоДоступаИмя = "АвторизованныйЗаявительМеркурий" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Заявитель в'");
			НастройкаПредставления.Заголовок = НСтр("ru='Меркурий'");
			НастройкаПредставления.Значимое  = Ложь;
			
		ИначеЕсли ПравоДоступаИмя = "ГашениеВСД" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Гашение ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Гашение'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "УполномоченноеГашениеВСД" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Гашение ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Уполн. гашение'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "ОформлениеВозвратныхВСД" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Оформление ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Возврат'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "УполномоченноеОформлениеВозвратныхВСД" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Оформление ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Уполн. возврат'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "ОформлениеВСДПриказ646" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Оформление ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Пр. № 646'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "АттестованныйСпециалист" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Оформление ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Пр. № 647'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "СертификацияУлововВБР" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Оформление ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Рыба'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "ОформлениеВСДНаСыроеМолоко" Тогда
			
			НастройкаПредставления.ИмяГруппы = НСтр("ru='Оформление ВСД'");
			НастройкаПредставления.Заголовок = НСтр("ru='Сырое молоко'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "ОформлениеПроизводственныхВСД" Тогда
			
			НастройкаПредставления.Заголовок = НСтр("ru='Оформление ВСД производство'");
			НастройкаПредставления.Значимое  = Истина;
			
		ИначеЕсли ПравоДоступаИмя = "НазначениеУполномоченных" Тогда
			
			НастройкаПредставления.Заголовок = НСтр("ru='Назначение уполномоченных'");
			НастройкаПредставления.Значимое  = Ложь;
			
		ИначеЕсли ПравоДоступаИмя = "УправлениеЗонамиОтветственности" Тогда
			
			НастройкаПредставления.Заголовок = НСтр("ru='Управление зонами ответственности'");
			НастройкаПредставления.Значимое  = Ложь;
			
		КонецЕсли;
	КонецЦикла;
	
	Возврат НастройкиПредставления;
	
КонецФункции

#КонецОбласти


#КонецЕсли