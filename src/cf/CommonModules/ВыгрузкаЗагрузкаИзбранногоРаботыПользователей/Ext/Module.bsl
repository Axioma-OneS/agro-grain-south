﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Выгрузка загрузка данных".
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область РегистрацияОбработчиковВыгрузкиЗагрузкиДанных

// Вызывается при регистрации произвольных обработчиков выгрузки данных.
//
// Параметры:
//  ТаблицаОбработчиков - ТаблицаЗначений - в данной процедуре требуется
//    дополнить эту таблицу значений информацией о регистрируемых произвольных
//    обработчиках выгрузки данных. 
//    Колонки:
//    * ОбъектМетаданных - ОбъектМетаданных - при выгрузке данных которого должен
//      вызываться регистрируемый обработчик,
//    * Обработчик - ОбщийМодуль - общий модуль, в котором реализован произвольный
//      обработчик выгрузки данных. Набор экспортных процедур, которые должны
//      быть реализованы в обработчике, зависит от установки значений следующих
//      колонок таблицы значений,
//    * Версия - Строка - номер версии интерфейса обработчиков выгрузки / загрузки данных,
//      поддерживаемого обработчиком,
//    * ПередВыгрузкойТипа - Булево -  флаг необходимости вызова обработчика перед
//      выгрузкой всех объектов информационной базы, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПередВыгрузкойТипа(),
//      поддерживающая следующие параметры:
//      * Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//      * Сериализатор - СериализаторXDTO - инициализированный с поддержкой выполнения
//          аннотации ссылок. В случае, если в произвольном обработчике выгрузки требуется
//          выполнять выгрузку дополнительных данных - следует использовать
//          СериализаторXDTO, переданный в процедуру ПередВыгрузкойТипа() в качестве
//          значения параметра Сериализатор, а не полученных с помощью свойства глобального
//          контекста СериализаторXDTO,
//      * ОбъектМетаданных - ОбъектМетаданных - перед выгрузкой данных которого
//          был вызван обработчик,
//      * Отказ - Булево - если в процедуре ПередВыгрузкойТипа() установить значение
//          данного параметра равным Истина - выгрузка объектов, соответствующих
//          текущему объекту метаданных, выполняться не будет.
//    * ПередВыгрузкойОбъекта - Булево - флаг необходимости вызова обработчика перед
//      выгрузкой конкретного объекта информационной базы. Если присвоено значение
//      Истина - в общем модуле обработчика должна быть реализована экспортируемая процедура
//      ПередВыгрузкойОбъекта(), поддерживающая следующие параметры:
//      * Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//      * МенеджерВыгрузкиОбъекта - ОбработкаОбъект - ВыгрузкаЗагрузкаДанныхМенеджерВыгрузкиДанныхИнформационнойБазы -
//          менеджер выгрузки текущего объекта. Подробнее см. комментарий к программному интерфейсу обработки
//          ВыгрузкаЗагрузкаДанныхМенеджерВыгрузкиДанныхИнформационнойБазы. Параметр передается только при вызове
//          процедур обработчиков, для которых при регистрации указана версия не ниже 1.0.0.1,
//      * Сериализатор - СериализаторXDTO - инициализированный с поддержкой выполнения
//          аннотации ссылок. В случае, если в произвольном обработчике выгрузки требуется
//          выполнять выгрузку дополнительных данных - следует использовать
//          СериализаторXDTO, переданный в процедуру ПередВыгрузкойОбъекта() в качестве
//          значения параметра Сериализатор, а не полученных с помощью свойства глобального
//          контекста СериализаторXDTO,
//      * Объект - КонстантаМенеджерЗначения, СправочникОбъект, ДокументОбъект,
//          БизнесПроцессОбъект, ЗадачаОбъект, ПланСчетовОбъект, ПланОбменаОбъект,
//          ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей,
//          РегистрРасчетаНаборЗаписей, ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей -
//          объект данных информационной базы, перед выгрузкой которого был вызван обработчик.
//          Значение, переданное в процедуру ПередВыгрузкойОбъекта() в качестве значения параметра
//          Объект может быть модифицировано внутри обработчика ПередВыгрузкойОбъекта(), при
//          этом внесенные изменения будут отражены в сериализации объекта в файлах выгрузки, но
//          не будут зафиксированы в информационной базе
//      * Артефакты - Массив Из ОбъектXDTO - набор дополнительной информации, логически неразрывно
//          связанной с объектом, но не являющейся его частью (артефакты объекта). Артефакты должны
//          сформированы внутри обработчика ПередВыгрузкойОбъекта() и добавлены в массив, переданный
//          в качестве значения параметра Артефакты. Каждый артефакт должен являться XDTO-объектом,
//          для типа которого в качестве базового типа используется абстрактный XDTO-тип
//          {http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}Artefact. Допускается использовать XDTO-пакеты,
//          помимо изначально поставляемых в составе подсистемы ВыгрузкаЗагрузкаДанных. В дальнейшем
//          артефакты, сформированные в процедуре ПередВыгрузкойОбъекта(), будут доступны в процедурах
//          обработчиков загрузки данных (см. комментарий к процедуре ПриРегистрацииОбработчиковЗагрузкиДанных().
//      * Отказ - Булево - если в процедуре ПередВыгрузкойОбъекта() установить значение
//           данного параметра равным Истина - выгрузка объекта, для которого был вызван обработчик,
//           выполняться не будет.
//    * ПослеВыгрузкиТипа - Булево - флаг необходимости вызова обработчика после выгрузки всех
//      объектов информационной базы, относящихся к данному объекту метаданных. Если присвоено значение
//      Истина - в общем модуле обработчика должна быть реализована экспортируемая процедура
//      ПослеВыгрузкиТипа(), поддерживающая следующие параметры:
//      * Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//      * Сериализатор - СериализаторXDTO - инициализированный с поддержкой выполнения
//          аннотации ссылок. В случае, если в произвольном обработчике выгрузки требуется
//          выполнять выгрузку дополнительных данных - следует использовать
//          СериализаторXDTO, переданный в процедуру ПослеВыгрузкиТипа() в качестве
//          значения параметра Сериализатор, а не полученных с помощью свойства глобального
//          контекста СериализаторXDTO,
//      * ОбъектМетаданных - ОбъектМетаданных - после выгрузки данных которого был вызван обработчик.
//
Процедура ПриРегистрацииОбработчиковВыгрузкиДанных(ТаблицаОбработчиков) Экспорт
	
	НовыйОбработчик = ТаблицаОбработчиков.Добавить();
	НовыйОбработчик.Обработчик = ВыгрузкаЗагрузкаИзбранногоРаботыПользователей;
	НовыйОбработчик.ПередВыгрузкойНастроек = Истина;
	НовыйОбработчик.Версия = ВыгрузкаЗагрузкаДанныхСлужебныйСобытия.ВерсияОбработчиков1_0_0_1();
	
КонецПроцедуры

// Вызывается при регистрации произвольных обработчиков загрузки данных.
//
// Параметры:
//  ТаблицаОбработчиков - ТаблицаЗначений - в данной процедуре требуется
//  дополнить эту таблицу значений информацией о регистрируемых произвольных
//  обработчиках загрузки данных. Колонки:
//    ОбъектМетаданных - ОбъектМетаданных - при загрузке данных которого должен
//      вызываться регистрируемый обработчик,
//    Обработчик - ОбщийМодуль - общий модуль, в котором реализован произвольный
//      обработчик загрузки данных. Набор экспортных процедур, которые должны
//      быть реализованы в обработчике, зависит от установки значений следующих
//      колонок таблицы значений,
//    Версия - Строка - номер версии интерфейса обработчиков выгрузки / загрузки данных,
//      поддерживаемого обработчиком,
//    ПередСопоставлениемСсылок - Булево -  флаг необходимости вызова обработчика перед
//      сопоставлением ссылок (в исходной ИБ и в текущей), относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПередСопоставлениемСсылок(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        ОбъектМетаданных - ОбъектМетаданных - перед сопоставлением ссылок которого
//          был вызван обработчик,
//        СтандартнаяОбработка - Булево - если процедуре ПередСопоставлениемСсылок()
//          установить значение данного параметра равным Ложь, вместо стандартного
//          сопоставления ссылок (поиск объектов в текущей ИБ с теми же значениями
//          естественного ключа, которые были выгружены из ИБ-источника) будет
//          вызвана функция СопоставитьСсылки() общего модуля, в процедуре
//          ПередСопоставлениемСсылок() которого значение параметра СтандартнаяОбработка
//          было установлено равным Ложь.
//          Параметры функции СопоставитьСсылки():
//            Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//              контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//              к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//            ТаблицаИсходныхСсылок - ТаблицаЗначений -  содержащая информацию о ссылках,
//              выгруженных из исходной ИБ. Колонки:
//                ИсходнаяСсылка - ЛюбаяСсылка -  ссылка объекта исходной ИБ, которую требуется
//                  сопоставить c ссылкой в текущей ИБ,
//                Остальные колонки равным полям естественного ключа объекта, которые в
//                  процессе выгрузки данных были переданы в функцию
//                  ВыгрузкаЗагрузкаДанныхИнформационнойБазы.ТребуетсяСопоставитьСсылкуПриЗагрузке()
//          Возвращаемое значение функции СопоставитьСсылки() - ТаблицаЗначений, колонки:
//            ИсходнаяСсылка - ЛюбаяСсылка -  ссылка объекта, выгруженная из исходной ИБ,
//            Ссылка - ЛюбаяСсылка -  сопоставленная исходной ссылка в текущей ИБ.
//        Отказ - Булево - Если в процедуре ПередСопоставлениемСсылок() установить значение
//          данного параметра равным Истина - сопоставление ссылок, соответствующих
//          текущему объекту метаданных, выполняться не будет.
//    ПередЗагрузкойТипа - Булево - флаг необходимости вызова обработчика перед
//      загрузкой всех объектов данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПередЗагрузкойТипа(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        ОбъектМетаданных - ОбъектМетаданных -  перед загрузкой всех данных которого
//          был вызван обработчик,
//        Отказ - Булево - Если в процедуре ПередЗагрузкойТипа() установить значение данного
//          параметра равным Истина - загрузка всех объектов данных соответствующих текущему
//          объекту метаданных выполняться не будет.
//    ПередЗагрузкойОбъекта - Булево - флаг необходимости вызова обработчика перед
//      загрузкой объекта данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПередЗагрузкойОбъекта(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        Объект - КонстантаМенеджерЗначения, СправочникОбъект, ДокументОбъект,
//          БизнесПроцессОбъект, ЗадачаОбъект, ПланСчетовОбъект, ПланОбменаОбъект,
//          ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей,
//          РегистрРасчетаНаборЗаписей, ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей -
//          объект данных информационной базы, перед загрузкой которого был вызван обработчик.
//          Значение, переданное в процедуру ПередЗагрузкойОбъекта() в качестве значения параметра
//          Объект может быть модифицировано внутри процедуры обработчика ПередЗагрузкойОбъекта().
//        Артефакты - Массив Из ОбъектXDTO - дополнительные данные, логически неразрывно связанные
//          с объектом данных, но не являющиеся его частью. Сформированы в экспортируемых процедурах
//          ПередВыгрузкойОбъекта() обработчиков выгрузки данных (см. комментарий к процедуре
//          ПриРегистрацииОбработчиковВыгрузкиДанных(). Каждый артефакт должен являться XDTO-объектом,
//          для типа которого в качестве базового типа используется абстрактный XDTO-тип
//          {http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}Artefact. Допускается использовать XDTO-пакеты,
//          помимо изначально поставляемых в составе подсистемы ВыгрузкаЗагрузкаДанных.
//        Отказ - Булево - если в процедуре ПередЗагрузкойОбъекта() установить значение данного
//          параметра равным Истина - загрузка объекта данных выполняться не будет.
//    ПослеЗагрузкиОбъекта - Булево - флаг необходимости вызова обработчика после
//      загрузки объекта данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПослеЗагрузкиОбъекта(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        Объект - КонстантаМенеджерЗначения -  СправочникОбъект, ДокументОбъект,
//          БизнесПроцессОбъект, ЗадачаОбъект, ПланСчетовОбъект, ПланОбменаОбъект,
//          ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей,
//          РегистрРасчетаНаборЗаписей, ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей -
//          объект данных информационной базы, после загрузки которого был вызван обработчик.
//        Артефакты - Массив Из ОбъектXDTO - дополнительные данные, логически неразрывно связанные
//          с объектом данных, но не являющиеся его частью. Сформированы в экспортируемых процедурах
//          ПередВыгрузкойОбъекта() обработчиков выгрузки данных (см. комментарий к процедуре
//          ПриРегистрацииОбработчиковВыгрузкиДанных(). Каждый артефакт должен являться XDTO-объектом,
//          для типа которого в качестве базового типа используется абстрактный XDTO-тип
//          {http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}Artefact. Допускается использовать XDTO-пакеты,
//          помимо изначально поставляемых в составе подсистемы ВыгрузкаЗагрузкаДанных.
//    ПослеЗагрузкиТипа - Булево - флаг необходимости вызова обработчика после
//      загрузки всех объектов данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПослеЗагрузкиТипа(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        ОбъектМетаданных - ОбъектМетаданных - после загрузки всех объектов которого
//          был вызван обработчик.
//
Процедура ПриРегистрацииОбработчиковЗагрузкиДанных(ТаблицаОбработчиков) Экспорт
	
	НовыйОбработчик = ТаблицаОбработчиков.Добавить();
	НовыйОбработчик.Обработчик = ВыгрузкаЗагрузкаИзбранногоРаботыПользователей;
	НовыйОбработчик.ПередЗагрузкойНастроек = Истина;
	НовыйОбработчик.Версия = ВыгрузкаЗагрузкаДанныхСлужебныйСобытия.ВерсияОбработчиков1_0_0_1();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиВыгрузкиЗагрузкиДанных

Процедура ПередВыгрузкойНастроек(Контейнер, Сериализатор, ИмяХранилищаНастроек, КлючНастроек, КлючОбъекта, Настройки, Пользователь, Представление, Артефакты, Отказ) Экспорт
	
	Если ТипЗнч(Настройки) = Тип("ИзбранноеРаботыПользователя") Тогда
		
		Для Каждого ЭлементИзбранного Из Настройки Цикл
			
			НовыйАртефакт = ФабрикаXDTO.Создать(ТипАртефактЭлементИзбранного());
			НовыйАртефакт.Important = ЭлементИзбранного.Важное;
			НовыйАртефакт.URL = ОтображениеНавигационнойСсылкиВАртефакт(ЭлементИзбранного.НавигационнаяСсылка);
			НовыйАртефакт.Presentation = ЭлементИзбранного.Представление;
			
			Артефакты.Добавить(НовыйАртефакт);
			
		КонецЦикла;
		
		Настройки = Новый ИзбранноеРаботыПользователя();
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗагрузкойНастроек(Контейнер, ИмяХранилищаНастроек, КлючНастроек, КлючОбъекта, Настройки, Пользователь, Представление, Артефакты, Отказ) Экспорт
	
	Если ТипЗнч(Настройки) = Тип("ИзбранноеРаботыПользователя") Тогда
		
		Для Каждого Артефакт Из Артефакты Цикл
			
			Если Артефакт.Тип() = ТипАртефактЭлементИзбранного() Тогда
				
				НовыйЭлемент = Новый ЭлементИзбранногоРаботыПользователя();
				НовыйЭлемент.Важное = Артефакт.Important;
				НовыйЭлемент.НавигационнаяСсылка = НавигационнаяСсылкаПоОтображениюВАртефакт(Артефакт.URL);
				НовыйЭлемент.Представление = Артефакт.Presentation;
				
				Настройки.Добавить(НовыйЭлемент);
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

Функция НавигационнаяСсылкаПоОтображениюВАртефакт(Знач Отображение)
	
	Результат = Отображение.Template;
	
	Если Отображение.MainRef <> Неопределено Тогда
		
		Ключ = Отображение.MainRef.Key;
		Ссылка = Отображение.MainRef.Value;
		
		Результат = СтрЗаменить(Результат, Строка(Ключ) + ".Type", Ссылка.Метаданные().ПолноеИмя());
		Результат = СтрЗаменить(Результат, Строка(Ключ) + ".UUID",
			ОтображениеУникальногоИдентификатораКФорматуНавигационнойСсылки(Ссылка.УникальныйИдентификатор()));
		
	КонецЕсли;
	
	Для Каждого ОтображениеДополнительнойСсылки Из Отображение.AdditionalRef Цикл
		
		Ключ = ОтображениеДополнительнойСсылки.Key;
		Ссылка = ОтображениеДополнительнойСсылки.Value;
		
		СтрокаТипа = ОбщегоНазначения.СтроковоеПредставлениеТипа(ТипЗнч(Ссылка));
		СтрокаИдентификатора = ОтображениеУникальногоИдентификатораКФорматуНавигационнойСсылки(Ссылка.УникальныйИдентификатор());
		
		Если ОтображениеДополнительнойСсылки.RequreTypeAnnotition Тогда
			
			СтрокаПодстановки = СтрокаТипа + ":" + СтрокаИдентификатора;
			
		Иначе
			
			СтрокаПодстановки = СтрокаИдентификатора;
			
		КонецЕсли;
		
		СтрокаПодстановки = КодироватьСтроку(СтрокаПодстановки, СпособКодированияСтроки.КодировкаURL);
		
		Результат = СтрЗаменить(Результат, Строка(Ключ) + ".UUID", СтрокаПодстановки);
		
	КонецЦикла;
	
	СтруктураСсылки = СтруктураНавигационнойСсылки(Результат);
	
	Результат = СтруктураСсылки.Протокол + "/" + СтруктураСсылки.Тип;
	
	Если ЗначениеЗаполнено(СтруктураСсылки.Путь) Тогда
		Результат = Результат + "/" + СтруктураСсылки.Путь;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СтруктураСсылки.Параметры) Тогда
		Результат = Результат + "?" + СтруктураСсылки.Параметры;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ОтображениеНавигационнойСсылкиВАртефакт(Знач НавигационнаяСсылка)
	
	Отображение = ФабрикаXDTO.Создать(ТипОтображениеНавигационнойСсылкиВАртефакт());
	Отображение.Template = НавигационнаяСсылка;
	
	СтруктураСсылки = СтруктураНавигационнойСсылки(НавигационнаяСсылка);
	
	Если ЭтоНавигационнаяСсылкаНаОбъектИнформационнойБазы(СтруктураСсылки) Тогда
		
		СтруктураСсылки.Параметры = СтруктураСсылки.Параметры;
		
		ОбъектМетаданных = ОбъектМетаданныхПоПутиВНавигационнойСсылке(СтруктураСсылки.Путь);
		
		Если ОбъектМетаданных <> Неопределено Тогда
			
			Если ОбщегоНазначенияБТС.ЭтоСсылочныеДанные(ОбъектМетаданных) Тогда
				
				Ключ = Новый УникальныйИдентификатор();
				
				Отображение.MainRef = ФабрикаXDTO.Создать(ТипОтображениеСсылкиВАртефакт());
				Отображение.MainRef.Key = Ключ;
				
				Отображение.Template = СтрЗаменить(Отображение.Template, ОбъектМетаданных.ПолноеИмя(), Строка(Ключ) + ".Type");
				
			КонецЕсли;
			
			СсылкиВПараметрах = СсылкиВПараметрахНавигационнойСсылки(СтруктураСсылки.Параметры, ОбъектМетаданных);
			
			Для Каждого Строка Из СсылкиВПараметрах Цикл
				
				Отображение.Template = СтрЗаменить(Отображение.Template, Строка.ИсходнаяПодстрока, Строка.ДекодированнаяПодстрока);
				
				Если Строка.ИмяПараметра = "ref" Тогда
					
					Отображение.MainRef.Value = СериализаторXDTO.ЗаписатьXDTO(Строка.Ссылка);
					Отображение.MainRef.RequreTypeAnnotition = Строка.ТребуетсяАннотацияТипаВНавигационнойСсылке;
					Отображение.Template = СтрЗаменить(Отображение.Template, Строка.ПодстрокаСсылки, Строка(Ключ) + ".UUID");
					
				Иначе
					
					Ключ = Новый УникальныйИдентификатор();
					
					ОтображениеДополнительнойСсылки = ФабрикаXDTO.Создать(ТипОтображениеСсылкиВАртефакт());
					ОтображениеДополнительнойСсылки.Key = Ключ;
					ОтображениеДополнительнойСсылки.Value = СериализаторXDTO.ЗаписатьXDTO(Строка.Ссылка);
					ОтображениеДополнительнойСсылки.RequreTypeAnnotition = Строка.ТребуетсяАннотацияТипаВНавигационнойСсылке;
					
					Отображение.AdditionalRef.Добавить(ОтображениеДополнительнойСсылки);
					
					Отображение.Template = СтрЗаменить(Отображение.Template, Строка.ПодстрокаСсылки, Строка(Ключ) + ".UUID");
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Отображение;
	
КонецФункции

Функция ЭтоНавигационнаяСсылкаНаОбъектИнформационнойБазы(Знач СтруктураНавигационнойСсылки)
	
	Если СтруктураНавигационнойСсылки.Протокол = "e1cib" И СтруктураНавигационнойСсылки.Тип = "data" Тогда // Не локализуется
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

Функция СтруктураНавигационнойСсылки(Знач НавигационнаяСсылка)
	
	Результат = Новый Структура;
	Результат.Вставить("Протокол", "");
	Результат.Вставить("Тип", "");
	Результат.Вставить("Путь", "");
	Результат.Вставить("Параметры", "");
	
	ПодстрокиСсылки = СтрРазделить(НавигационнаяСсылка, "/");
	
	Если ПодстрокиСсылки.Количество() >= 1 Тогда
		Результат.Протокол = ПодстрокиСсылки[0];
	КонецЕсли;
	
	Если ПодстрокиСсылки.Количество() >= 2 Тогда
		Результат.Тип = ПодстрокиСсылки[1];
	КонецЕсли;
	
	Если ПодстрокиСсылки.Количество() >= 3 Тогда
		
		Тело = ПодстрокиСсылки[2];
		
		ПозицияРазделителя = СтрНайти(Тело, "?");
		
		Если ПозицияРазделителя = 0 Тогда
			
			Результат.Путь = Тело;
			Результат.Параметры = "";
			
		Иначе
			
			Результат.Путь = Лев(Тело, ПозицияРазделителя - 1);
			Результат.Параметры = СтрЗаменить(Тело, Результат.Путь + "?", "");
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ОбъектМетаданныхПоПутиВНавигационнойСсылке(Знач СтрокаПути)
	
	СтруктураПути = СтрРазделить(СтрокаПути, ".");
	
	Если СтруктураПути.Количество() >= 2 Тогда
		
		Возврат Метаданные.НайтиПоПолномуИмени(СтруктураПути[0] + "." + СтруктураПути[1]);
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция СсылкиВПараметрахНавигационнойСсылки(Знач СтрокаПараметров, Знач ОбъектМетаданных)
	
	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить("ИсходнаяПодстрока", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("ДекодированнаяПодстрока", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("ИмяПараметра", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("Ссылка", ОбщегоНазначенияБТСПовтИсп.ОписаниеСсылочныхТипов());
	Результат.Колонки.Добавить("ПодстрокаСсылки", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("ТребуетсяАннотацияТипаВНавигационнойСсылке", Новый ОписаниеТипов("Булево"));
	
	Подстроки = СтрРазделить(СтрокаПараметров, "&");
	
	Для Каждого Подстрока Из Подстроки Цикл
		
		ПозицияРазделителя = СтрНайти(Подстрока, "=");
		
		ИмяПоля = Лев(Подстрока, ПозицияРазделителя - 1);
		ЗначениеПоля = СтрЗаменить(Подстрока, ИмяПоля + "=", "");
		
		Если Не ОбщегоНазначенияБТС.ЭтоПеречисление(ОбъектМетаданных)
			И ОбщегоНазначенияБТС.ЭтоСсылочныеДанные(ОбъектМетаданных) 
			И ИмяПоля = "ref" Тогда
			
			Менеджер = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ОбъектМетаданных.ПолноеИмя());
			УникальныйИдентификаторСсылки = УникальныйИдентификаторИзОтображенияВФорматеНавигационнойСсылки(ЗначениеПоля);
			Ссылка = Менеджер.ПолучитьСсылку(УникальныйИдентификаторСсылки);
			
			СтрокаРезультата = Результат.Добавить();
			СтрокаРезультата.ИсходнаяПодстрока = Подстрока;
			СтрокаРезультата.ДекодированнаяПодстрока = Подстрока;
			СтрокаРезультата.ИмяПараметра = "ref";
			СтрокаРезультата.Ссылка = Ссылка;
			СтрокаРезультата.ПодстрокаСсылки = ЗначениеПоля;
			СтрокаРезультата.ТребуетсяАннотацияТипаВНавигационнойСсылке = Ложь;
			
		ИначеЕсли ОбщегоНазначенияБТС.ЭтоНаборЗаписей(ОбъектМетаданных) Тогда
			
			ИсходноеЗначениеПоля = ЗначениеПоля;
			ЗначениеПоля = РаскодироватьСтроку(ЗначениеПоля, СпособКодированияСтроки.КодировкаURL);
			
			ПолеИзмерения = ОбъектМетаданных.Измерения.Найти(ИмяПоля);
			
			Если ПолеИзмерения = Неопределено Тогда
				
				КоличествоВозможныхТипов = 0;
				
			Иначе
				
				КоличествоВозможныхТипов = КоличествоСсылочныхТиповВОписанииТипов(ПолеИзмерения.Тип);
				
			КонецЕсли;
			
			Если КоличествоВозможныхТипов = 1 Тогда
				
				ТребуетсяАннотацияТипаВНавигационнойСсылке = Ложь;
				СтрокаИдентификатора = СтрокаИдентификатораИзОтображенияВФорматеНавигационнойСсылки(ЗначениеПоля);
				
				Если Не СтроковыеФункцииКлиентСервер.ЭтоУникальныйИдентификатор(СтрокаИдентификатора) Тогда
					Продолжить;
				КонецЕсли;
					
				ПустаяСсылка = Новый(ПолеИзмерения.Тип.Типы()[0]);
				
				Если ОбщегоНазначенияБТС.ЭтоПеречисление(ПустаяСсылка.Метаданные()) Тогда
					Продолжить;
				КонецЕсли;
				
				Менеджер = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПустаяСсылка.Метаданные().ПолноеИмя());
				УникальныйИдентификаторСсылки = Новый УникальныйИдентификатор(СтрокаИдентификатора);
				Ссылка = Менеджер.ПолучитьСсылку(УникальныйИдентификаторСсылки);
				
			ИначеЕсли КоличествоВозможныхТипов > 1 Тогда
				
				ТребуетсяАннотацияТипаВНавигационнойСсылке = Истина;
				ПозицияРазделителяТипа = СтрНайти(ЗначениеПоля, ":");
				
				Если ПозицияРазделителяТипа > 0 Тогда
					
					ИмяТипа = Лев(ЗначениеПоля, ПозицияРазделителяТипа - 1);
					СтрокаИдентификатора = СтрокаИдентификатораИзОтображенияВФорматеНавигационнойСсылки(
						СтрЗаменить(ЗначениеПоля, ИмяТипа + ":", ""));
					
					Если Не СтроковыеФункцииКлиентСервер.ЭтоУникальныйИдентификатор(СтрокаИдентификатора) Тогда
						Продолжить;
					КонецЕсли;
					
					ПустаяСсылка = Новый(Тип(ИмяТипа));
					
					Если ОбщегоНазначенияБТС.ЭтоПеречисление(ПустаяСсылка.Метаданные()) Тогда
						Продолжить;
					КонецЕсли;
				
					Менеджер = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПустаяСсылка.Метаданные().ПолноеИмя());
					УникальныйИдентификаторСсылки = Новый УникальныйИдентификатор(СтрокаИдентификатора);
					Ссылка = Менеджер.ПолучитьСсылку(УникальныйИдентификаторСсылки);
					
				Иначе
					
					Продолжить;
					
				КонецЕсли;
				
			Иначе
				
				Продолжить;
				
			КонецЕсли;
			
			СтрокаРезультата = Результат.Добавить();
			СтрокаРезультата.ИсходнаяПодстрока = Подстрока;
			СтрокаРезультата.ДекодированнаяПодстрока = СтрЗаменить(Подстрока, ИсходноеЗначениеПоля, ЗначениеПоля);
			СтрокаРезультата.ИмяПараметра = ИмяПоля;
			СтрокаРезультата.Ссылка = Ссылка;
			СтрокаРезультата.ПодстрокаСсылки = ЗначениеПоля;
			СтрокаРезультата.ТребуетсяАннотацияТипаВНавигационнойСсылке = ТребуетсяАннотацияТипаВНавигационнойСсылке;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция КоличествоСсылочныхТиповВОписанииТипов(Знач ОписаниеТипов)
	
	Результат = 0;
	
	Для Каждого Тип Из ОписаниеТипов.Типы() Цикл
		
		Если Не ОбщегоНазначенияБТС.ЭтоПримитивныйТип(Тип) Тогда
			
			Результат = Результат + 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ОтображениеУникальногоИдентификатораКФорматуНавигационнойСсылки(Знач Идентификатор)
	
	ИдентификаторСсылки = Строка(Идентификатор);
	
	Возврат Сред(ИдентификаторСсылки, 20, 4)
		+ Сред(ИдентификаторСсылки, 25)
		+ Сред(ИдентификаторСсылки, 15, 4)
		+ Сред(ИдентификаторСсылки, 10, 4)
		+ Сред(ИдентификаторСсылки, 1, 8);
	
КонецФункции

Функция УникальныйИдентификаторИзОтображенияВФорматеНавигационнойСсылки(Знач Отображение)
	
	СтрокаИдентификатора = СтрокаИдентификатораИзОтображенияВФорматеНавигационнойСсылки(Отображение);
	Возврат Новый УникальныйИдентификатор(СтрокаИдентификатора);
	
КонецФункции

Функция СтрокаИдентификатораИзОтображенияВФорматеНавигационнойСсылки(Знач Отображение)
	
	ПерваяЧасть    = Сред(Отображение, 25, 8);
	ВтораяЧасть    = Сред(Отображение, 21, 4);
	ТретьяЧасть    = Сред(Отображение, 17, 4);
	ЧетвертаяЧасть = Сред(Отображение, 1,  4);
	ПятаяЧасть     = Сред(Отображение, 5,  12);
	
	Возврат ПерваяЧасть + "-" + ВтораяЧасть + "-" + ТретьяЧасть + "-" + ЧетвертаяЧасть + "-" + ПятаяЧасть;
	
КонецФункции

Функция ТипАртефактЭлементИзбранного()
	
	Возврат ФабрикаXDTO.Тип(Пакет(), "FavoriteItemArtefact");
	
КонецФункции

Функция ТипОтображениеНавигационнойСсылкиВАртефакт()
	
	Возврат ФабрикаXDTO.Тип(Пакет(), "URL");
	
КонецФункции

Функция ТипОтображениеСсылкиВАртефакт()
	
	Возврат ФабрикаXDTO.Тип(Пакет(), "URLRef");
	
КонецФункции

Функция Пакет()
	
	Возврат "http://www.1c.ru/1cFresh/Data/Artefacts/UserWorkFavorites/1.0.0.1";
	
КонецФункции

#КонецОбласти
