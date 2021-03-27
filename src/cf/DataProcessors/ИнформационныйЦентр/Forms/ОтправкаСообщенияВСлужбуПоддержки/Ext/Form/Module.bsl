﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИдентификаторПользователя = Пользователи.ТекущийПользователь().ИдентификаторПользователяСервиса;
	ОбластьДанных = ИнтеграцияПодсистемБТС.ЗначениеРазделителяСеанса();
	
	СоздаватьОбращение = Параметры.СоздаватьОбращение;
	ИдентификаторОбращения = Параметры.ИдентификаторОбращения;
	
	ЗаполнитьШаблономСодержание();
	
	МаксимальныйРазмерФайлов = ИнформационныйЦентрСервер.МаксимальныйРазмерВложенийДляОтправкиСообщенияВПоддержкуСервиса();
	
	АдресДляОтвета = ИнформационныйЦентрСервер.ОпределитьАдресЭлектроннойПочтыПользователя();
	Если ПустаяСтрока(АдресДляОтвета) Тогда 
		Элементы.АдресОтвета.Видимость = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьКурсорВШаблонеТекста();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Параметры:
// 	Элемент - ДекорацияФормы - элемент формы.
&НаКлиенте
Процедура Подключаемый_УдалитьФайл(Элемент)
	
	ИмяКнопки = Элемент.Имя;
	УдалитьФайлСервер(ИмяКнопки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отправить(Команда)
	
	Если Элементы.АдресОтвета.Видимость Тогда 
		Если ПустаяСтрока(АдресДляОтвета) Тогда 
			ВызватьИсключение НСтр("ru = 'Необходимо ввести адрес электронной почты для ответа'");
		КонецЕсли;
		Результат = РазобратьСтрокуСПочтовымиАдресами(АдресДляОтвета);
		Если Результат.Количество() = 0 Тогда 
			Оповещение = Новый ОписаниеОповещения("ОтправлениеСообщенияВСлужбуПоддержки", ЭтотОбъект);
			ПоказатьВопрос(Оповещение, НСтр("ru = 'Адрес электронной почты возможно введен неверно. Отправить сообщение?'"), РежимДиалогаВопрос.ДаНет);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	ОтправитьСообщениеСервер();
	ПоказатьОповещениеПользователя(НСтр("ru = 'Сообщение в службу поддержки отправлено.'"));
	Оповестить("ОтправкаСообщенияВСлужбуПоддержки");
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ПрикрепитьФайл(Команда)
	
#Если ВебКлиент Тогда
	ОписаниеОповещения = Новый ОписаниеОповещения("ПрикрепитьФайлОповещение", ЭтотОбъект);
	НачатьПодключениеРасширенияРаботыСФайлами(ОписаниеОповещения);
#Иначе
	ДобавитьВнешниеФайлы(Истина);
#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УдалитьФайлСервер(ИмяКнопкиУдаления)
	
	Фильтр = Новый Структура("ИмяКнопкиУдаления", ИмяКнопкиУдаления);
	НайденныеСтроки = ВыбираемыеФайлы.НайтиСтроки(Фильтр);
	Если НайденныеСтроки.Количество() = 0 Тогда 
		Возврат;
	КонецЕсли;
	
	НайденнаяСтрока = НайденныеСтроки.Получить(0);
	ИндексИмени = ПолучитьИндексЭлементаФормы(ИмяКнопкиУдаления);
	УдалитьВсеПодчиненныеЭлементы(ИндексИмени);
	УдалитьИзВременногоХранилища(НайденнаяСтрока.АдресХранилища);
	
	Индекс = ВыбираемыеФайлы.Индекс(НайденнаяСтрока);
	ВыбираемыеФайлы.Удалить(Индекс);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправлениеСообщенияВСлужбуПоддержки(Результат) Экспорт
	
	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ОтправитьСообщениеСервер();
	ПоказатьОповещениеПользователя(НСтр("ru = 'Сообщение в службу поддержки отправлено.'"));
	Оповестить("ОтправкаСообщенияВСлужбуПоддержки");
	Закрыть();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьШаблономСодержание()
	
	Текст = ИнформационныйЦентрСервер.ШаблонТекстаВТехПоддержку();
	СтрокаПозицияКурсора = НСтр("ru = 'ПозицияКурсора'");
	ПозицияКурсора = СтрНайти(Текст, СтрокаПозицияКурсора)- 9;
	Текст = СтрЗаменить(Текст, СтрокаПозицияКурсора, "");
	Содержание.УстановитьHTML(Текст, Новый Структура);
	
КонецПроцедуры

&НаСервере
Процедура УдалитьВсеПодчиненныеЭлементы(ИндексЭлемента)
	
	НайденнаяЭлемент = Элементы.Найти("ГруппаФайла" + Строка(ИндексЭлемента));
	Если НайденнаяЭлемент <> Неопределено Тогда 
		Элементы.Удалить(НайденнаяЭлемент);
	КонецЕсли;
	
	НайденнаяЭлемент = Элементы.Найти("ТекстИмениФайла" + Строка(ИндексЭлемента));
	Если НайденнаяЭлемент <> Неопределено Тогда 
		Элементы.Удалить(НайденнаяЭлемент);
	КонецЕсли;
	
	НайденнаяЭлемент = Элементы.Найти("КнопкаУдаленияФайла" + Строка(ИндексЭлемента));
	Если НайденнаяЭлемент <> Неопределено Тогда 
		Элементы.Удалить(НайденнаяЭлемент);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьИндексЭлементаФормы(ИмяЭлемента)
	
	НачалоПозиции = СтрДлина("КнопкаУдаленияФайла") + 1;
	Возврат Число(Сред(ИмяЭлемента, НачалоПозиции));
	
КонецФункции

&НаКлиенте
Процедура ПрикрепитьФайлОповещение(Подключено, Контекст) Экспорт
	
	ДобавитьВнешниеФайлы(Подключено);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВнешниеФайлы(РасширениеПодключено)
	
	Если РасширениеПодключено Тогда 
		ПоместитьФайлыСРасширением();
	Иначе
		ПоместитьФайлыБезРасширения();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоместитьФайлыСРасширением()
	
	// Вызов диалога выбора файлов.
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = НСтр("ru = 'Выберите файл'");
	Диалог.МножественныйВыбор = Ложь;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПоместитьФайлСРасширениемОповещение", ЭтотОбъект);
	НачатьПомещениеФайлов(ОписаниеОповещения,, Диалог, Истина, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоместитьФайлСРасширениемОповещение(ВыбранныеФайлы, ОбработчикЗавершения) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ВыбранныйФайл = ВыбранныеФайлы.Получить(0); // ОписаниеПереданногоФайла
	ПолноеИмя = ВыбранныйФайл.ПолноеИмя;
	ПолноеИмяФайла = ?(ПустаяСтрока(ПолноеИмя), ВыбранныйФайл.Имя, ПолноеИмя);
	АдресХранилища = ВыбранныйФайл.Хранение;
	
	// Проверка на корректность общего размера файлов.
	Файл = Новый Файл;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ПолноеИмяФайла", ПолноеИмяФайла);
	ДополнительныеПараметры.Вставить("АдресХранилища", АдресХранилища);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("НачатьИнициализациюОповещение", ЭтотОбъект, ДополнительныеПараметры);
	Файл.НачатьИнициализацию(ОписаниеОповещения, ПолноеИмяФайла);
	
	
КонецПроцедуры

// Параметры:
// 	Файл - Файл - файл. 
// 	ДополнительныеПараметры - Структура - дополнительные параметры.
&НаКлиенте
Процедура НачатьИнициализациюОповещение(Файл, ДополнительныеПараметры) Экспорт
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПоместитьФайлСРасширениемОповещениеРазмерОповещение", ЭтотОбъект, ДополнительныеПараметры);
	Файл.НачатьПолучениеРазмера(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоместитьФайлСРасширениемОповещениеРазмерОповещение(Размер, ДополнительныеПараметры) Экспорт
	
	Если Размер = 0 Тогда
		
		Возврат;
		
	КонецЕсли;
	
	Если Не ОбщийРазмерФайловОптимален(Размер) Тогда 
		
		ТекстПредупреждения = НСтр("ru = 'Не удалось добавить файл. Размер выбранных файлов превышает предел в %1 Мб'");
		ТекстПредупреждения = СтрШаблон(ТекстПредупреждения, МаксимальныйРазмерФайлов);
		ОчиститьСообщения();
		ПоказатьСообщениеПользователю(ТекстПредупреждения);
		
	КонецЕсли;
	
	Состояние(НСтр("ru = 'Файл добавляется к сообщению.'"));

	// Добавить файлы в таблицу.
	ИмяИРасширениеФайла = ПолучитьИмяИРасширениеФайла(ДополнительныеПараметры.ПолноеИмяФайла);
	ПоместитьФайлыБезРасширенияНаСервере(ДополнительныеПараметры.АдресХранилища, ИмяИРасширениеФайла);
	
	Состояние();
	
	СоздатьЭлементыФормыДляВложенногоФайла();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоместитьФайлыБезРасширения()
	
	ПослеПомещенияФайла = Новый ОписаниеОповещения(
		"ПослеПомещенияФайлов", ЭтотОбъект);
	
	НачатьПомещениеФайла(
		ПослеПомещенияФайла,
		,
		,
		Истина,
		УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПомещенияФайлов(Результат, АдресХранилища, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
	
	Если Результат Тогда
		
		ИмяИРасширениеФайла = ПолучитьИмяИРасширениеФайла(ВыбранноеИмяФайла);
		ПоместитьФайлыБезРасширенияНаСервере(АдресХранилища, ИмяИРасширениеФайла);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьИмяИРасширениеФайла(Знач ВыбранноеИмяФайла)
	
	Результат = ИнтеграцияПодсистемБТС.РазложитьПолноеИмяФайла(ВыбранноеИмяФайла);
	
	ИмяИРасширениеФайла = Новый Структура;
	ИмяИРасширениеФайла.Вставить("Имя", Результат.ИмяБезРасширения);
	ИмяИРасширениеФайла.Вставить("Расширение", Результат.Расширение);
	
	Возврат ИмяИРасширениеФайла;
	
КонецФункции

&НаСервере
Процедура ПоместитьФайлыБезРасширенияНаСервере(АдресХранилища, ИмяИРасширениеФайла)
	
	НовыйФайл = ПолучитьИзВременногоХранилища(АдресХранилища);
	
	// Проверка на корректность общего размера файлов.
	РазмерФайла = НовыйФайл.Размер();
	Если Не ОбщийРазмерФайловОптимален(РазмерФайла) Тогда 
		ТекстПредупреждения = НСтр("ru = 'Размер выбранных файлов превышает предел в %1 Мб'");
		ТекстПредупреждения = СтрШаблон(ТекстПредупреждения, МаксимальныйРазмерФайлов);
		ПоказатьСообщениеПользователю(ТекстПредупреждения);
		УдалитьИзВременногоХранилища(АдресХранилища);
		Возврат;
	КонецЕсли;
	
	СтрокаТаблицы = ВыбираемыеФайлы.Добавить();
	СтрокаТаблицы.ИмяФайла = ИмяИРасширениеФайла.Имя;
	СтрокаТаблицы.Расширение = ИмяИРасширениеФайла.Расширение;
	СтрокаТаблицы.Размер = РазмерФайла;
	СтрокаТаблицы.АдресХранилища = АдресХранилища;
	
	СоздатьЭлементыФормыДляВложенногоФайла();
	
КонецПроцедуры

&НаСервере
Функция ОбщийРазмерФайловОптимален(РазмерФайла)
	
	Размер = РазмерФайла / 1024;
	
	// Подсчет общего размера приложенных к письму файлов (с установленной пометкой).
	Для Итерация = 0 По ВыбираемыеФайлы.Количество() - 1 Цикл
		Размер = Размер + (ВыбираемыеФайлы.Получить(Итерация).Размер / 1024);
	КонецЦикла;
	
	РазмерВМегабайтах = Размер / 1024;
	
	Если РазмерВМегабайтах > МаксимальныйРазмерФайлов Тогда 
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ОтправитьСообщениеСервер()
	
	ТекстHTML = "";
	ВложенияHTML = Новый Структура;
	Содержание.ПолучитьHTML(ТекстHTML, ВложенияHTML);
    ВложенияBase64 = ПреобразоватьКартинкиВBase64(ВложенияHTML);
    Обработки.ИнформационныйЦентр.ДобавитьИнформациюОПриложении(ТекстHTML, ВложенияBase64);
        
	ТекстСообщения = Содержание.ПолучитьТекст();
    Если ПустаяСтрока(ТекстСообщения) Тогда 
		ВызватьИсключение НСтр("ru = 'Текст сообщения не может быть пустым.'");
	КонецЕсли;
	
	Если ПустаяСтрока(Тема) Тогда 
		ТемаСообщения = ОпределитьТему();
	Иначе
		ТемаСообщения = Тема;
	КонецЕсли;
	
	Попытка
		
		WSПрокси = ИнформационныйЦентрСервер.ПолучитьПроксиСлужбыПоддержки();
		
		СписокФайловXDTO = СформироватьСписокФайловXDTO(WSПрокси.ФабрикаXDTO);
		
		WSПрокси.addComments(Строка(ИдентификаторПользователя), Строка(ИдентификаторОбращения), ТемаСообщения, ТекстHTML, СоздаватьОбращение,  СписокФайловXDTO, ОбластьДанных, АдресДляОтвета);
		
	Исключение
		
		ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации(), 
		                         УровеньЖурналаРегистрации.Ошибка,
		                         ,
		                         ,
		                         ТекстОшибки);
		ТекстВывода = ИнформационныйЦентрСервер.ТекстВыводаИнформацииОбОшибкеВСлужбеПоддержки();
		ВызватьИсключение ТекстВывода;
		
	КонецПопытки;
	
КонецПроцедуры

&НаСервере 
Функция ПреобразоватьКартинкиВBase64(Вложения)
	
	ВложенияBase64 = Новый Структура;
	Для каждого КиЗ Из Вложения Цикл
		ВложенияBase64.Вставить(КиЗ.Ключ,Base64Строка(КиЗ.Значение.ПолучитьДвоичныеДанные()));
	КонецЦикла;
	
	Возврат ВложенияBase64;
КонецФункции

&НаСервере
Функция ОпределитьТему()
	
	Если Не ПустаяСтрока(Тема) Тогда 
		Возврат Тема;
	КонецЕсли;
	
	ТекстСообщения = Содержание.ПолучитьТекст();
	ТекстСообщения = СтрЗаменить(ТекстСообщения, "Здравствуйте.", "");
	ТекстСообщения = Лев(ТекстСообщения, 500);
	ТекстСообщения = СтрЗаменить(ТекстСообщения, Символы.ПС, " ");
	ТекстСообщения = СтрЗаменить(ТекстСообщения, "  ", " ");
	
	Возврат СокрЛП(ТекстСообщения);
	
КонецФункции

&НаСервере
Функция СформироватьСписокФайловXDTO(Фабрика)
	
	ТипСпискаФайлов = Фабрика.Тип("http://www.1c.ru/1cFresh/InformationCenter/SupportServiceData/1.0.0.1", "ListFile");
	СписокФайлов = Фабрика.Создать(ТипСпискаФайлов);
	
	Для Каждого ТекущийФайл Из ВыбираемыеФайлы Цикл 
		
		ТипФайла = Фабрика.Тип("http://www.1c.ru/1cFresh/InformationCenter/SupportServiceData/1.0.0.1", "File");
		ФайлОбъект = Фабрика.Создать(ТипФайла);
		ФайлОбъект.Name = ТекущийФайл.ИмяФайла;
		ФайлОбъект.Data = ПолучитьИзВременногоХранилища(ТекущийФайл.АдресХранилища);
		ФайлОбъект.Extension = ТекущийФайл.Расширение;
		ФайлОбъект.Size = ТекущийФайл.Размер;
		
		Обработки.ИнформационныйЦентр.ДобавитьЗначениеВСписокXDTO(СписокФайлов, "Files", ФайлОбъект);
		
	КонецЦикла;
	
	Возврат СписокФайлов;
	
КонецФункции

&НаКлиенте
Процедура УстановитьКурсорВШаблонеТекста()
	
	ПодключитьОбработчикОжидания("ОбработчикУстановитьКурсорВШаблонеТекста", 0.5, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикУстановитьКурсорВШаблонеТекста()
	
	ТекущийЭлемент = Элементы.Содержание;
	Закладка = Содержание.ПолучитьЗакладкуПоПозиции(ПозицияКурсора);
	Элементы.Содержание.УстановитьГраницыВыделения(Закладка, Закладка);
	
КонецПроцедуры

&НаСервере
Процедура СоздатьЭлементыФормыДляВложенногоФайла()
	
	Для Каждого ВыбираемыйФайл Из ВыбираемыеФайлы Цикл
		
		Если Не ПустаяСтрока(ВыбираемыйФайл.ИмяКнопкиУдаления) Тогда 
			Продолжить;
		КонецЕсли;
		
		ПредставлениеФайла = ВыбираемыйФайл.ИмяФайла + ВыбираемыйФайл.Расширение + " (" + Окр(ВыбираемыйФайл.Размер / 1024, 2) + " " + НСтр("ru = 'Кб'") +")";
		
		Индекс = ВыбираемыйФайл.ПолучитьИдентификатор();
		
		ГруппаФайла = Элементы.Добавить("ГруппаФайла" + Строка(Индекс), Тип("ГруппаФормы"), Элементы.ГруппаПрикрепленныхФайлов);
		ГруппаФайла.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		ГруппаФайла.ОтображатьЗаголовок = Ложь;
		ГруппаФайла.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Горизонтальная;
		ГруппаФайла.Отображение = ОтображениеОбычнойГруппы.Нет;
		
		ТекстИмениФайла = Элементы.Добавить("ТекстИмениФайла" + Строка(Индекс), Тип("ДекорацияФормы"), ГруппаФайла);
		ТекстИмениФайла.Вид = ВидДекорацииФормы.Надпись;
		ТекстИмениФайла.Заголовок = ПредставлениеФайла;
		ТекстИмениФайла.АвтоМаксимальнаяШирина = Ложь;
		ТекстИмениФайла.РастягиватьПоГоризонтали = Истина;
		
		КнопкаУдаленияФайла = Элементы.Добавить("КнопкаУдаленияФайла" + Строка(Индекс), Тип("ДекорацияФормы"), ГруппаФайла);
		КнопкаУдаленияФайла.Вид = ВидДекорацииФормы.Картинка;
		КнопкаУдаленияФайла.Картинка = БиблиотекаКартинок.УдалитьНепосредственно;
		КнопкаУдаленияФайла.Подсказка = НСтр("ru = 'Удалить файл'");
		КнопкаУдаленияФайла.Ширина = 2;
		КнопкаУдаленияФайла.Высота = 1;
		КнопкаУдаленияФайла.РазмерКартинки = РазмерКартинки.Растянуть;
		КнопкаУдаленияФайла.Гиперссылка = Истина;
		КнопкаУдаленияФайла.УстановитьДействие("Нажатие", "Подключаемый_УдалитьФайл");
		
		ВыбираемыйФайл.ИмяКнопкиУдаления = КнопкаУдаленияФайла.Имя;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПоказатьСообщениеПользователю(Текст)
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = Текст;
	Сообщение.Сообщить();
	
КонецПроцедуры

&НаСервере
Функция РазобратьСтрокуСПочтовымиАдресами(АдресДляОтвета)
	
	Возврат ИнтеграцияПодсистемБТС.РазобратьСтрокуСПочтовымиАдресами(АдресДляОтвета, Ложь);
	
КонецФункции

#КонецОбласти