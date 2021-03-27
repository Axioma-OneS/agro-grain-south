﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "Новости".
// ОбщийМодуль.ОбработкаНовостейВызовСервера.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область РаботаСТекстомНовости

// Если перед выводом новости пользователю, разработчику надо "доработать" ее текст - заменить какие-то теги,
//  удалить блоки текста и т.п., то это можно сделать в этой процедуре.
// При формировании текста происходит несколько стадий: вначале компонуется ХТМЛ-текст одной или списка новостей
//  (то, что внутри <body></body>), затем полученный текст обрамляется тегами <html></html> и стилями.
//  В этой функции можно обработать текст одной новости, без стилей (то, что внутри <body></body>).
//
// Параметры:
//  ОбъектНовости - СправочникОбъект.Новости - Новость, для которой необходимо изменить уже подготовленный текст;
//  ТекстХТМЛ     - Строка - уже подготовленный текст, который по-умолчанию будет отображен в форме просмотра новости.
//
// Возвращаемое значение:
//   Строка - окончательный текст новости (то, что внутри <body></body>).
//
Процедура ДополнительноОбработатьТекстНовостиПередПоказом(ОбъектНовости, ТекстХТМЛ) Экспорт

	ОбработкаНовостейПереопределяемый.ДополнительноОбработатьТекстНовостиПередПоказом(ОбъектНовости, ТекстХТМЛ);

КонецПроцедуры

// Если перед выводом новости пользователю, разработчику надо "доработать" ее текст - заменить какие-то теги, стили,
//  удалить блоки текста и т.п., то это можно сделать в этой процедуре.
// При формировании текста происходит несколько стадий: вначале компонуется ХТМЛ-текст одной или списка новостей
//  (то, что внутри <body></body>), затем полученный текст обрамляется тегами <html></html> и стилями.
//  В этой процедуре можно обработать результирующий текст одной или списка новости, включая заголовки, стили и т.п.
//  В тексте списка новостей есть комментарии, которые можно быстро заменить с помощью строковых функций:
//   <!-- Здесь можно вставить свои теги для заголовка --> (находится внутри <html><head>)
//     например, если точно известно, что на компьютере установлен Internet Explorer последней версии, то можно добавить тег
//       <meta http-equiv="X-UA-Compatible" content="IE=edge">
//       и тогда в новостях можно будет выводить SVG картинки;
//   /* Здесь можно вставить свои стили */ (находится внутри <html><head><style type=""text/css"">).
//
// Параметры:
//  ТекстХТМЛ     - Строка - уже подготовленный текст, который по-умолчанию будет отображен в форме просмотра новости.
//
// Возвращаемое значение:
//   Строка - окончательный текст одной или списка новости.
//
Процедура ДополнительноОбработатьТекстСпискаНовостейПередПоказом(ТекстХТМЛ) Экспорт

	ОбработкаНовостейПереопределяемый.ДополнительноОбработатьТекстСпискаНовостейПередПоказом(ТекстХТМЛ);

КонецПроцедуры

// Если после получения новости надо "доработать" ее текст, реквизиты, категории и т.п.,
//  то это можно сделать в этой процедуре.
// Объект новости еще не записан, можно менять все его реквизиты (например, пометку удаления, чтобы управлять видимостью новости).
// Дополнительно передается НовостьХДТО - на случай, если передаются дополнительные теги, их можно отсюда получить.
//
// Параметры:
//  ОбъектНовости - СправочникОбъект.Новости - Новость, у которой необходимо изменить данные;
//  НовостьХДТО   - ОбъектXDTO - полученный объект новости.
//
Процедура ДополнительноОбработатьНовостьПослеПолученияПередЗаписью(ОбъектНовости, НовостьХДТО) Экспорт

	ОбработкаНовостейПереопределяемый.ДополнительноОбработатьНовостьПослеПолученияПередЗаписью(ОбъектНовости, НовостьХДТО);

КонецПроцедуры

// Если после получения новости надо "доработать" ее текст, реквизиты, категории и т.п.,
//  то это можно сделать в этой процедуре.
// Новость уже записана в базу данных, поэтому можно менять связанные регистры сведений.
//
// Параметры:
//  НовостьСсылка - СправочникСсылка.Новости - Новость, у которой необходимо изменить данные.
//
Процедура ДополнительноОбработатьНовостьПослеПолученияПослеЗаписи(НовостьСсылка) Экспорт

	ОбработкаНовостейПереопределяемый.ДополнительноОбработатьНовостьПослеПолученияПослеЗаписи(НовостьСсылка);

КонецПроцедуры

#КонецОбласти

#Область ПоискДанных

// Функция возвращает ссылку на ленту новостей по ее коду.
//
// Параметры:
//  ЛентаНовостейКод - Строка - код ленты новостей.
//
// Возвращаемое значение:
//   СправочникСсылка.ЛентыНовостей - ссылка на ленту новостей или пустая ссылка, если нет ленты новостей с таким кодом.
//
Функция ПолучитьЛентуНовостейПоКоду(ЛентаНовостейКод) Экспорт

	Результат = ОбработкаНовостейПовтИсп.ПолучитьЛентуНовостейПоКоду(ЛентаНовостейКод);

	Возврат Результат;

КонецФункции

// Возвращает массив отключенных лент новостей.
// Вынесено из Хранилища настроек.НастройкиНовостей, т.к. выполняется очень часто для контекстных новостей.
// При изменении настроек лент новостей необходимо сбросить кэш с помощью ОбновитьПовторноИспользуемыеЗначения().
//
// Параметры:
//  ИмяПользователяИБ - Строка - Имя пользователя, для которого необходимо рассчитать данные.
//
// Возвращаемое значение:
//   Массив из СправочникСсылка.ЛентыНовостей - Массив отключенных лент новостей.
//
Функция ПолучитьОтключенныеЛентыНовостей(ИмяПользователяИБ) Экспорт

	Результат = ОбработкаНовостейПовтИсп.ПолучитьОтключенныеЛентыНовостей(ИмяПользователяИБ);

	Возврат Результат;

КонецФункции

#КонецОбласти

#Область Настройки

// Возвращает признак включения условного разделения.
// В случае вызова в неразделенной конфигурации возвращает Ложь.
//
// Возвращаемое значение:
//  Булево - Истина, если разделение включено.
//         - Ложь,   если разделение выключено или не поддерживается.
//
Функция РазделениеВключено() Экспорт

	Возврат ОбщегоНазначения.РазделениеВключено();

КонецФункции

// Возвращает признак возможности обращения к разделенным данным из текущего сеанса.
// В случае вызова в неразделенной конфигурации возвращает Истина.
//
// Возвращаемое значение:
//   Булево - Истина, если разделение не поддерживается, либо разделение выключено,
//                    либо разделение включено и разделители    установлены.
//          - Ложь,   если разделение включено и разделители не установлены.
//
Функция ДоступноИспользованиеРазделенныхДанных() Экспорт

	Возврат ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных();

КонецФункции

// Определяет, сеанс запущен с разделителями или без него.
//
// Возвращаемое значение:
//   Булево - Истина, если сеанс запущен без разделителей.
//
Функция СеансЗапущенБезРазделителей() Экспорт

	Возврат ИнтернетПоддержкаПользователей.СеансЗапущенБезРазделителей();

КонецФункции

#КонецОбласти

#Область РаботаСПользователями

// Возвращает Истина, если у текущего пользователя включены административные права.
//
// Возвращаемое значение:
//   Булево - Истина, если у текущего пользователя включены административные права.
//
Функция ЭтоАдминистратор() Экспорт

	Возврат ОбработкаНовостейПовтИсп.ЭтоАдминистратор();

КонецФункции

// Функция возвращает строковое имя пользователя, как настроено в конфигураторе
//  по переданной ссылке на элемент Справочника Пользователи.
//
// Параметры:
//  ПользовательСсылка - СправочникСсылка.Пользователи, Неопределено - элемент справочника пользователи,
//                       по которому необходимо получить имя пользователя ИБ, как настроено в конфигураторе.
//                       Если передано Неопределено, то необходимо вернуть имя текущего пользователя.
//
// Возвращаемое значение:
//   Строка - имя пользователя ИБ, или пустая строка.
//
Функция ПолучитьИмяПользователяИБ(ПользовательСсылка = Неопределено) Экспорт

	Возврат ОбработкаНовостейПовтИсп.ПолучитьИмяПользователяИБ(ПользовательСсылка);

КонецФункции

// Функция возвращает ссылку на элемент справочника Пользователи, по имени пользователя (как настроено в конфигураторе).
//
// Параметры:
//  ИмяПользователяИБ - Строка - имя пользователя ИБ (как настроено в конфигураторе),
//                      по которому необходимо получить ссылку на элемент справочника пользователи.
//
// Возвращаемое значение:
//   СправочникСсылка.Пользователи - ссылка на элемент справочника или пустая ссылка.
//
Функция ПолучитьПользователяПоИмениПользователяИБ(ИмяПользователяИБ) Экспорт

	Возврат ОбработкаНовостейПовтИсп.ПолучитьПользователяПоИмениПользователяИБ(ИмяПользователяИБ);

КонецФункции

// Функция возвращает фиксированную структуру с часто используемыми параметрами пользователя.
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - фиксированная структура с ключами:
//   * ИмяПользователяИБ              - Строка - имя пользователя;
//   * ЕстьРольЧтенияНовостей         - Булево - доступность указанной роли;
//   * ЕстьРольРедактированиеНовостей - Булево - доступность указанной роли;
//   * ЕстьРольПолныеПрава            - Булево - доступность указанной роли;
//   * ЕстьРольАдминистраторСистемы   - Булево - доступность указанной роли;
//   * ЭтоВнешнийПользователь         - Булево - это внешний пользователь;
//   * ЭтоФоновоеЗадание              - Булево - это фоновое задание;
//   * ТекущийПользовательСсылка      - СправочникСсылка.Пользователи - ссылка на элемент справочника.
//
Функция ПараметрыТекущегоПользователя() Экспорт

	Возврат ОбработкаНовостейПовтИсп.ПараметрыТекущегоПользователя();

КонецФункции

#Область НастройкиПользователей

// Изменяет настройку видимости лент новостей для пользователя.
//
// Параметры:
//  ЛентыНовостей - СправочникСсылка.ЛентаНовостей, Массив из СправочникСсылка.ЛентаНовостей - Ленты новостей,
//                    для которых необходимо изменить настройку видимости;
//  Видимость     - Булево - истина = лента видима, ложь = лента скрыта;
//  Пользователь  - СправочникСсылка.Пользователи - пользователь, для которого необходимо изменить признак видимости ленты новостей;
//
Процедура ИзменитьПользовательскуюВидимостьЛентНовостей(ЛентыНовостей, Видимость = Ложь, Пользователь = Неопределено) Экспорт

	ОбработкаНовостей.ИзменитьПользовательскуюВидимостьЛентНовостей(ЛентыНовостей, Видимость, Пользователь);

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область УстаревшийФункционал

// Устаревший функционал.
// Необходимо вызывать напрямую ОбработкаНовостейПереопределяемый.ДополнительноОбработатьНовостиПослеПолучения.
// Если после сеанса получения новостей надо что-то с ними сделать,
//  то это можно сделать в этой процедуре.
// Новости уже записаны в базу данных, обработки по "пересчету" категорий и отборов уже запущены,
//  поэтому можно менять связанные регистры сведений.
//
// Параметры:
//  ТаблицаДатЗагрузокНовостейПередПолучением - ТаблицаЗначений - состав колонок соответствует регистру сведений ДатыЗагрузкиПоследнихНовостей.
//
Процедура ДополнительноОбработатьНовостиПослеПолучения(ТаблицаДатЗагрузокНовостейПередПолучением) Экспорт

	ОбработкаНовостейПереопределяемый.ДополнительноОбработатьНовостиПослеПолучения(ТаблицаДатЗагрузокНовостейПередПолучением);

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ЛогИОтладка

// Функция возвращает значение, надо ли вести подробный журнал регистрации.
//
// Возвращаемое значение:
//   Булево - Истина, если надо вести подробный журнал регистрации, Ложь в противном случае.
//
Функция ВестиПодробныйЖурналРегистрации() Экспорт

	Возврат ОбработкаНовостейПовтИсп.ВестиПодробныйЖурналРегистрации();

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнтерактивнаяРаботаСТекстомНовости

// Процедура заполняет параметры Действие и СписокПараметров для объекта
//  новости по переданному уникальному идентификатору гиперссылки.
//
// Параметры:
//  Объект           - Данные формы коллекция, ДокументСсылка.Новости, СправочникСсылка.Новости;
//  УИНДействия      - Строка;
//  Действие         - Строка;
//  СписокПараметров - СписокЗначений.
//
Процедура ПодготовитьПараметрыНавигационнойСсылки(Знач Объект, УИНДействия, Действие, СписокПараметров) Экспорт

	ОбработкаНовостей.ПодготовитьПараметрыНавигационнойСсылки(Объект, УИНДействия, Действие, СписокПараметров);

КонецПроцедуры

// Функция возвращает ХТМЛ или простой текст новости по ссылке на новость.
//
// Параметры:
//  Новости              - СправочникСсылка.Новости, Структура, Массив из СправочникСсылка.Новости - данные новости или списка новостей;
//  ПараметрыОтображения - Структура, Неопределено - параметры для отображения новости. Список возможных параметров:
//    * ОтображатьЗаголовок - Булево.
//
// Возвращаемое значение:
//  Строка - текст новости / новостей в формате HTML.
//
Функция ПолучитьХТМЛТекстНовостей(Новости, ПараметрыОтображения = Неопределено) Экспорт

	ТипМассив = Тип("Массив");

	Если ТипЗнч(Новости) = ТипМассив Тогда
		// ПовтИсп для массива - запрещено.
		Результат = Справочники.Новости.ПолучитьХТМЛТекстНовостей(Новости, ПараметрыОтображения);
	Иначе
		Результат = ОбработкаНовостейПовтИсп.ПолучитьХТМЛТекстНовостей(Новости, ПараметрыОтображения);
	КонецЕсли;

	Возврат Результат;

КонецФункции

#КонецОбласти

#Область Настройки

// Получение настройки чтения новости.
//
// Возвращаемое значение:
//  Произвольное.
//
Функция ПолучитьНастройкиПоказаНовостейНастроенныеАдминистратором() Экспорт

	Возврат ОбработкаНовостей.ПолучитьНастройкиПоказаНовостейНастроенныеАдминистратором();

КонецФункции

#КонецОбласти

#Область РаботаСоСпискамиНовостейИКлассификаторов

// Процедура возвращает список значений очень важных и просто важных новостей с неотключенными напоминаниями, т.е. новостей,
//  которые удовлетворяют настройкам отборов пользователей, не просрочены, напоминания не отключены ранее,
//  и с включенным свойством "Важность" = 1 или 2.
//
// Параметры:
//  ОченьВажныеНовости - Массив структур - в этот параметр будут возвращены новости с важностью "Очень важная", где:
//    * Новость                        - СправочникСсылка.Новости - ссылка на новость;
//    * НовостьУникальныйИдентификатор - УникальныйИдентификатор - УИН от ссылки на новость;
//    * НовостьНаименование            - Строка - заголовок новости;
//    * НовостьПодзаголовок            - Строка - подзаголовок новости;
//    * НовостьКодЛентыНовостей        - Строка - код ленты новостей;
//    * ОповещениеВключено             - Булево - Признак, что оповещение включено;
//    * ИконкаНовости                  - Неопределено - всегда Неопределено;
//  ВажныеНовости      - Массив структур - в этот параметр будут возвращены новости с важностью "Важная", где:
//    * Новость                        - СправочникСсылка.Новости - ссылка на новость;
//    * НовостьУникальныйИдентификатор - УникальныйИдентификатор - УИН от ссылки на новость;
//    * НавигационнаяСсылка            - Строка - навигационная ссылка на новость;
//    * НовостьНаименование            - Строка - заголовок новости;
//    * НовостьПодзаголовок            - Строка - подзаголовок новости;
//    * НовостьКодЛентыНовостей        - Строка - код ленты новостей;
//    * ОповещениеВключено             - Булево - Признак, что оповещение включено;
//    * ИконкаНовости                  - Картинка, Неопределено - иконка новости для оповещения пользователю;
//  ДополнительныеПараметры - Произвольный - произвольные параметры;
//  СтандартнаяОбработка    - Булево - признак выполнения стандартной обработки.
//
Процедура ПолучитьНовостиСНапоминаниями(
			ОченьВажныеНовости,
			ВажныеНовости,
			ДополнительныеПараметры,
			СтандартнаяОбработка) Экспорт

	ОбработкаНовостей.ПолучитьНовостиСНапоминаниями(
		ОченьВажныеНовости,
		ВажныеНовости,
		ДополнительныеПараметры,
		СтандартнаяОбработка);

КонецПроцедуры

// Функция находит новость по ее УИН и, если передан параметр, то по ленте новостей.
//
// Параметры:
//  УИННовости       - Строка - уникальный код новости (реквизит УИННовости);
//  ЛентаНовостейКод - Строка - код ленты новостей (реквизит Код).
//
Функция ПолучитьНовостиПоУИН(УИННовости, ЛентаНовостейКод = Неопределено) Экспорт

	Возврат ОбработкаНовостей.ПолучитьНовостиПоУИН(УИННовости, ЛентаНовостейКод);

КонецФункции

// Процедура сбрасывает дату последней загрузки новостей и, при необходимости, помечает загруженные ранее новости на удаление.
//
// Параметры:
//  ЛентаНовостейСсылка       - СправочникСсылка.ЛентаНовостей или Массив - Лента новостей или Массив лент новостей,
//                              у которой необходимо сбросить дату последней загрузки новостей;
//  ПомечатьНовостиНаУдаление - Булево - Если ИСТИНА, то пометить загруженные ранее новости на удаление.
//
Процедура СбросДатыПоследнейУспешнойЗагрузкиНовостей(ЛентыНовостей, ПомечатьНовостиНаУдаление = Ложь) Экспорт

	ОбработкаНовостей.СбросДатыПоследнейУспешнойЗагрузкиНовостей(ЛентыНовостей, ПомечатьНовостиНаУдаление);

КонецПроцедуры

// Процедура сбрасывает дату последней загрузки классификаторов..
//
// Параметры:
//  Списки - ПланВидовХарактеристикСсылка.КатегорииНовостей, Строка или Массив - Классификатор или Массив классификаторов,
//                                                                                    дату загрузки которых надо сбросить.
//
Процедура СбросДатыПоследнейУспешнойЗагрузкиКлассификатора(Списки) Экспорт

	ОбработкаНовостей.СбросДатыПоследнейУспешнойЗагрузкиКлассификатора(Списки);

КонецПроцедуры

// Функция возвращает подробную информацию о хранении новости и ее окружении по идентификатору.
//
// Параметры:
//  УИННовости      - Строка - Идентификатор новости;
//  ПрочиеПараметры - Структура - структура с ключами:
//   * ОбластьДанных   - Число - в случае запуска в модели сервиса, получает информацию по определенной области данных;
//   * ПараметрЗапуска - Строка - ПараметрЗапуска приложения (в командной строке после /C).
//
// Возвращаемое значение:
//   Строка - текст с подробной информацией о новости для службы техподдержки.
//
Функция ПолучитьИнформациюОНовости(УИННовости, ПрочиеПараметры) Экспорт

	Результат = ОбработкаНовостей.ПолучитьИнформациюОНовости(УИННовости, ПрочиеПараметры);
	Возврат Результат;

КонецФункции

#КонецОбласти

#Область РаботаСПомеченнымиНовостями

// Процедура помечает несколько новостей пометкой (число 0..9, где 0 = нет пометки).
//
// Параметры:
//  МассивНовостей - Массив;
//  Пометка        - Число 0..9, где 0 - неотмеченная новость.
//
Процедура ИзменитьПометкуНовостей(Знач МассивНовостей, Знач Пометка = 1) Экспорт

	ОбработкаНовостей.ИзменитьПометкуНовостей(МассивНовостей, Пометка);

КонецПроцедуры

#КонецОбласти

#Область РаботаСПризнакомПрочтенности

// Процедура изменяет признак прочтенности у новостей.
//
// Параметры:
//  МассивНовостей      - Массив;
//  ПризнакПрочтенности - Булево.
//
Процедура ИзменитьПризнакПрочтенностиНовостей(Знач МассивНовостей, Знач ПризнакПрочтенности = Истина) Экспорт

	ОбработкаНовостей.ИзменитьПризнакПрочтенностиНовостей(МассивНовостей, ПризнакПрочтенности);

КонецПроцедуры

#КонецОбласти

#Область РаботаСПризнакомУдаленияИзСписка

// Процедура изменяет признак удаления из списка у новостей.
//
// Параметры:
//  МассивНовостей          - Массив;
//  ПризнакУдаленияИзСписка - Булево.
//
Процедура ИзменитьПризнакУдаленияИзСпискаНовостей(Знач МассивНовостей, Знач ПризнакУдаленияИзСписка = Истина) Экспорт

	ОбработкаНовостей.ИзменитьПризнакУдаленияИзСпискаНовостей(МассивНовостей, ПризнакУдаленияИзСписка);

	// ////? Для помеченных на удаление новостей очистить кэш контекстных новостей

КонецПроцедуры

#КонецОбласти

#Область ПоискНовостей

// Выполняет полнотекстовый поиск по новостям. Возможна передача дополнительных параметров (период поиска и т.п.).
//
// Параметры:
//  СтруктураПараметровПоиска - Структура с ключами:
//                               -  СтрокПоиска - Строка;
//                               -  ПоискДатаОТ - Дата;
//                               -  ПоискДатаДО - Дата.
//
// Возвращаемое значение:
//  Массив.
//
Функция НайтиНовости(СтруктураПараметровПоиска) Экспорт

	Возврат ОбработкаНовостей.НайтиНовости(СтруктураПараметровПоиска);

КонецФункции

// Функция возвращает структуру новости из массива структур контекстных новостей.
// Массив структур готовится с помощью ОбщегоНазначения.ТаблицаЗначенийВМассив(ПолучитьКонтекстныеНовости(...)).
//
// Параметры:
//  АдресМассиваНовостей - Строка - Адрес временного хранилища;
//  НомерСтрокиНовости  - Число  - идентификатор новости, которую необходимо найти по значению ключа НомерСтрокиНовости.
//
// Возвращаемое значение:
//   Структура - структура с ключами:
//    * НомерСтрокиНовости      - Число - для реализации нажатия в подменю формы;
//    * ЛентаНовостей           - СправочникСсылка.ЛентаНовостей;
//    * Новость                 - СправочникСсылка.Новости;
//    * НовостьНаименование     - Строка (100) - заголовок новости;
//    * НовостьПодзаголовок     - Строка (100) - подзаголовок новости;
//    * УИННовости              - Строка (255) - ;
//    * ДатаПубликации          - Дата;
//    * Важность                - Число (1,0) - рассчитанная на текущую дату контекстная важность (с учетом даты сброса контекстной важности);
//    * Актуальность            - Булево - рассчитанная на текущую дату актуальность (с учетом даты завершения новости);
//    * Метаданные              - Строка (50);
//    * Форма                   - Строка (30);
//    * Событие                 - Строка (30) // Для варианта "Для форм, простой" - пустая строка;
//    * ПоказыватьВФормеОбъекта - Булево // Для варианта "Для форм, простой" - всегда ЛОЖЬ;
//    * ЭтоПостояннаяНовость    - Булево // Для варианта "Для форм, простой" - всегда ЛОЖЬ;
//    * Прочтена                - Булево;
//    * ОповещениеВключено      - Булево;
//    * ДатаНачалаОповещения    - Дата // Для варианта "Для форм, простой" - всегда пустая дата (01.01.0001).
//
Функция НайтиКонтекстнуюНовостьВМассиве(АдресМассиваНовостей, НомерСтрокиНовости) Экспорт

	Возврат ОбработкаНовостей.НайтиКонтекстнуюНовостьВМассиве(АдресМассиваНовостей, НомерСтрокиНовости);

КонецФункции

#КонецОбласти

#Область РегламентныеЗадания

// Процедура запускает удаление новостей (неактуальных и актуальных).
//
// Параметры:
//  КонтекстВыполнения - Структура, Неопределено - структура контекста выполнения.
//
Процедура УдалитьНовости_Ежедневно(КонтекстВыполнения = Неопределено) Экспорт

	ОбработкаНовостей.УдалитьНовости_Ежедневно(КонтекстВыполнения);

КонецПроцедуры

// Процедура запускает получение файлов новостей и обновление новостей для лент новостей по списку лент новостей.
//
// Параметры:
//  МассивЛентНовостей - Массив - список лент новостей. Если пустой, то по всем лентам новостей;
//  КонтекстВыполнения - Структура, Неопределено - структура контекста выполнения.
//
Процедура ПолучитьИОбработатьНовостиПоЛентамНовостей(МассивЛентНовостей, КонтекстВыполнения = Неопределено) Экспорт

	ОбработкаНовостей.ПолучитьИОбработатьНовостиПоЛентамНовостей(МассивЛентНовостей, КонтекстВыполнения);

КонецПроцедуры

// Процедура обрабатывает регистр сведений "РассчитанныеОтборыПоНовостям_РедкоМеняющиеся".
// В этом регистре хранятся заранее рассчитанные результаты отборов по новостям по редко меняющимся категориям:
//  - Версия платформы;
//  - Версия конфигурации;
//  - Продукт (включает в себя Имя+Версия, поэтому тоже меняется).
// Этот регистр имеет смысл пересчитывать после получения новостей, а также после обновления конфигурации и платформы.
// Для расчета будет браться информация из двух регистров - КатегорииНовостейПростые и КатегорииНовостейИнтервалыВерсий.
//
// Должно запускаться от имени пользователя с правами, достаточными для изменения этих данных.
//
// Параметры:
//  КонтекстВыполнения - Структура, Неопределено - структура контекста выполнения.
//
Процедура ПересчитатьОтборыПоНовостям_РедкоМеняющиеся(КонтекстВыполнения = Неопределено) Экспорт

	ОбработкаНовостей.ПересчитатьОтборыПоНовостям_РедкоМеняющиеся(КонтекстВыполнения);

КонецПроцедуры

// Процедура обрабатывает регистр сведений "РассчитанныеОтборыПоНовостям_Общие".
// В этом регистре хранятся заранее рассчитанные результаты отборов по новостям по настроенным администратором отборам,
//  за исключением отборов по категориям:
//  - Версия платформы;
//  - Версия конфигурации;
//  - Продукт (включает в себя Имя+Версия, поэтому тоже меняется),
//  которые рассчитываются и сохраняются в другом регистре.
// Этот регистр имеет смысл пересчитывать после получения новостей, а также после изменения отборов в справочнике ЛентыНовостей.
//
// Должно запускаться от имени пользователя с правами, достаточными для изменения этих данных.
//
// Параметры:
//  КонтекстВыполнения - Структура, Неопределено - структура контекста выполнения.
//
Процедура ПересчитатьОтборыПоНовостям_Общие(КонтекстВыполнения = Неопределено) Экспорт

	ОбработкаНовостей.ПересчитатьОтборыПоНовостям_Общие(КонтекстВыполнения);

КонецПроцедуры

// Процедура обрабатывает регистр сведений "РассчитанныеОтборыПоНовостям_ДляОбластиДанных".
// В этом регистре хранятся заранее рассчитанные результаты отборов по новостям по настроенным для области данных отборам,
//  за исключением отборов по категориям:
//  - Версия платформы;
//  - Версия конфигурации;
//  - Продукт (включает в себя Имя+Версия, поэтому тоже меняется),
//  которые рассчитываются и сохраняются в другом регистре.
// Этот регистр имеет смысл пересчитывать после получения новостей, а также после изменения отборов в справочнике ЛентыНовостей.
//
// Должно запускаться от имени пользователя с правами, достаточными для изменения этих данных.
//
// Параметры:
//  КонтекстВыполнения - Структура, Неопределено - структура контекста выполнения.
//
Процедура ПересчитатьОтборыПоНовостям_ДляОбластиДанных(КонтекстВыполнения = Неопределено) Экспорт

	ОбработкаНовостей.ПересчитатьОтборыПоНовостям_ДляОбластиДанных(КонтекстВыполнения);

КонецПроцедуры

// Процедура обрабатывает регистр сведений "РассчитанныеОтборыПоНовостям_Пользовательские".
// В этом регистре хранятся заранее рассчитанные результаты отборов по новостям по настроенным пользователем отборам,
//  за исключением отборов по категориям:
//  - Версия платформы;
//  - Версия конфигурации;
//  - Продукт (включает в себя Имя+Версия, поэтому тоже меняется),
//  которые рассчитываются и сохраняются в другом регистре.
// Этот регистр имеет смысл пересчитывать после получения новостей, после изменения отборов
//  в справочнике ЛентыНовостей (по всем пользователям), а также после настройки пользовательских отборов (для текущего пользователя).
//
// Должно запускаться от имени пользователя с правами, достаточными для изменения этих данных.
//
// Параметры:
//  Пользователь       - СправочникСсылка.Пользователи - пользователь, по которому необходимо пересчитать новости-исключения;
//  КонтекстВыполнения - Структура, Неопределено - структура контекста выполнения.
//
Процедура ПересчитатьОтборыПоНовостям_Пользовательские(Пользователь = Неопределено, КонтекстВыполнения = Неопределено) Экспорт

	ОбработкаНовостей.ПересчитатьОтборыПоНовостям_Пользовательские(Пользователь, КонтекстВыполнения);

КонецПроцедуры

// Процедура удаляет из регистров сведений ОтборыПоЛентамНовостейОбщие и ОтборыПоЛентамНовостейПользовательские категории и
//   значения категорий, которые некорректны.
// Некорректными записями этих регистров считаются:
//  1. записи с категориями, которых нет в табличной части "ДоступныеКатегорииНовостей" в ленте новостей,
//  2. пользовательский отборы, по категориям, по которым в ленте новостей установлен признак РазрешеноНастраиватьПользователям = Ложь,
//  3. пользовательский отборы, по значениям категорий, по которым уже установлен общий отбор,
//     а значения пользовательского отбора не входят в подмножество общего отбора
//     (например, общий отбор: География = Москва, Хабаровск, а пользователь установил География = Киев).
// Такие ситуации возможны, если:
//  а) со временем из какой-то ленты новостей удалили категории,
//  б) администратор со временем отключил пользователям возможность настраивать какие-то категории,
//  в) администратор со временем изменил общие отборы.
//
// Параметры:
//  КонтекстВыполнения - Структура, Неопределено - структура контекста выполнения.
//
Процедура ОптимизироватьОтборыПоНовостям(КонтекстВыполнения = Неопределено) Экспорт

	ОбработкаНовостей.ОптимизироватьОтборыПоНовостям(КонтекстВыполнения);

КонецПроцедуры

#КонецОбласти

#Область ФункциональныеОпции

// Функция возвращает результат - можно ли работать с новостями.
// Это результат функциональной опции "РазрешенаРаботаСНовостями"
//   И доступны нужные роли
//   И это не внешний пользователь.
// 
// Возвращаемое значение:
//  Булево - Истина, если включена ФО разрешения работы с новостями.
//
Функция РазрешенаРаботаСНовостями() Экспорт

	Возврат ОбработкаНовостейПовтИсп.РазрешенаРаботаСНовостями();

КонецФункции

// Функция возвращает результат - можно ли работать с новостями текущему пользователю.
// Это результат функциональной опции "РазрешенаРаботаСНовостями"
//   И доступны нужные роли;
//   И это не внешний пользователь;
//   И задан параметр сеанса ТекущийПользователь (т.е. мы не зашли в базу с отключенным списком пользователей).
// 
// Возвращаемое значение:
//  Булево.
//
Функция РазрешенаРаботаСНовостямиТекущемуПользователю() Экспорт

	Возврат ОбработкаНовостейПовтИсп.РазрешенаРаботаСНовостямиТекущемуПользователю();

КонецФункции

// Функция возвращает результат - можно ли работать с новостями через интернет.
// Это результат функциональной опции "РазрешенаРаботаСНовостямиЧерезИнтернет"
//   И доступны нужные роли;
//   И это не внешний пользователь.
// 
// Возвращаемое значение:
//  Булево.
//
Функция РазрешенаРаботаСНовостямиЧерезИнтернет() Экспорт

	Возврат ОбработкаНовостейПовтИсп.РазрешенаРаботаСНовостямиЧерезИнтернет();

КонецФункции

#КонецОбласти

#Область ВспомогательныеПроцедурыИФункции

// Функция возвращает значение категории, если для нее установлено свойство "ЗаполняетсяАвтоматически".
//
// Параметры:
//  Категория    - ПланВидовХарактеристикСсылка.КатегорииНовостей.
//
// Возвращаемое значение:
//  Произвольное (Строка, список значений).
//
Функция ПолучитьЗначениеПредопределеннойКатегории(Категория) Экспорт

	Возврат ОбработкаНовостейПовтИсп.ПолучитьЗначениеПредопределеннойКатегории(Категория);

КонецФункции

// Возвращает URL для получения новостей.
// Все параметры (в поле ИмяФайла заключены в квадратные скобки) будут заменены на конкретные значения.
// Возвращаемый результат можно вставить в браузер и он отобразит новости.
//
// Параметры:
//  ЛентаНовостей                          - СправочникСсылка.ЛентыНовостей, Структура - лента новостей или структура с ключами Ссылка, Протокол, Сайт, ИмяФайла,
//                                           для которой необходимо сформировать URL получения новостей.
//  ДатаЗагрузкиПоследнихНовостейНаКлиенте - Дата, Неопределено - дата последнего успешного получения новостей (для замены параметра [from]).
//                                           Если НЕ введена, то будет получена из регистра сведений.
//  ДатаПоследнейПопыткиЗагрузкиНовостей   - Дата, Неопределено - дата последней успешной загрузки файла новостей или Неопределено.
//                                           если последняя попытка получения новостей была неудачна.
//                                           Если НЕ введена, то будет получена из регистра сведений.
//
// Возвращаемое значение:
//   Строка - URL получения новостей, готовый для вставки в браузер.
//
Функция ПолучитьАдресДляПолученияНовостей(
			ЛентаНовостей,
			ДатаЗагрузкиПоследнихНовостейНаКлиенте = Неопределено,
			ДатаПоследнейПопыткиЗагрузкиНовостей = Неопределено) Экспорт

	Возврат ОбработкаНовостейПовтИсп.ПолучитьАдресДляПолученияНовостей(
				ЛентаНовостей,
				ДатаЗагрузкиПоследнихНовостейНаКлиенте,
				ДатаПоследнейПопыткиЗагрузкиНовостей);

КонецФункции

#КонецОбласти

#Область КонтекстныеНовости

// Функция получает контекстные новости из кэша. В случае необходимости кэш перезаполняется.
// Она используется в том случае, если выбрана стратегия отказа от расчета списка контекстных новостей в ПриСозданииНаСервере.
//
// Параметры:
//  ИдентификаторМетаданных           - Строка - Идентификатор метаданных, должен совпадать с таким же идентификатором в самой новости;
//  ИдентификаторФормы                - Строка - Идентификатор формы, должен совпадать с таким же идентификатором в самой новости;
//  ЗаголовокФормыКонтекстныхНовостей - Строка - ;
//  ИдентификаторыСобытийПриОткрытии  - Строка, Массив - строка или массив строк идентификаторов события "ПриОткрытии".
//                                        Если передано какое-то значение, то будет подсчитано количество очень важных контекстных
//                                        новостей. И если это количество > 0, то открывающая форма инициирует
//                                        открытие формы просмотра таких новостей;
//  НастройкиПолученияНовостей        - Структура, Неопределено - структура с ключами:
//   * ПолучатьКатегорииНовостей      - Булево - если Истина, то в реквизите формы будут также сохраняться категории новостей.
//                                        Это может быть полезно для реализации особенного отбора новостей,
//                                          который невозможно реализовать с помощью регистров сведений ОтборыПоЛентамНовостей*.
//
// Возвращаемое значение:
//   Структура - структура контекстных новостей для указанной комбинации ИдентификаторМетаданных / ИдентификаторФормы.
//       Ключи см. в ОбработкаНовостей.ПолучитьКонтекстныеНовостиДляФормы.
//
Функция ПолучитьКонтекстныеНовостиДляФормы(
			ИдентификаторМетаданных,
			ИдентификаторФормы,
			ЗаголовокФормыКонтекстныхНовостей = "",
			ИдентификаторыСобытийПриОткрытии = "ПриОткрытии",
			НастройкиПолученияНовостей = Неопределено) Экспорт

	Результат = ОбработкаНовостей.ПолучитьКонтекстныеНовостиДляФормы(
		ИдентификаторМетаданных,
		ИдентификаторФормы,
		ЗаголовокФормыКонтекстныхНовостей,
		ИдентификаторыСобытийПриОткрытии,
		НастройкиПолученияНовостей);

	Возврат Результат;

КонецФункции

#КонецОбласти

#Область ПанельКонтекстныхНовостей

// Процедура управляет видимостью панели контекстных новостей в форме, а также сохраняет настройки (дату закрытия),
//  чтобы через некоторое время снова открыть панель.
//
// Параметры:
//  Новости   - Структура - состав ключей см. в коде ОбработкаНовостей.КонтекстныеНовости_ПриСозданииНаСервере,
//                  заполнение переменной ОписаниеНовостей;
//  Видимость - Булево - новое состояние видимости.
//
Процедура ПанельКонтекстныхНовостей_ИзменитьВидимость(Новости, Видимость) Экспорт

	ОбработкаНовостей.ПанельКонтекстныхНовостей_ИзменитьВидимость(Новости, Видимость);

КонецПроцедуры

#КонецОбласти

#Область ПриНачалеРаботыСистемы

// Процедура вызывается из модуля управляемого приложения,
//  затем ОбработкаНовостейКлиент.ПриНачалеРаботыСистемы,
//  затем ОбработкаНовостейВызовСервера.ПриНачалеРаботыСистемы,
//  затем ОбработкаНовостей.ПриНачалеРаботыСистемы,
//  затем ОбработкаНовостейПереопределяемый.ПриНачалеРаботыСистемы.
//
Процедура ПриНачалеРаботыСистемы() Экспорт

	ОбработкаНовостей.ПриНачалеРаботыСистемы();

КонецПроцедуры

#КонецОбласти

#Область БСПНастройкиПрограммы

Процедура ИнтернетПоддержкаИСервисы_ВключитьРаботуСНовостямиПриИзменении(Знач Значение) Экспорт
	
	Константы.РазрешенаРаботаСНовостями.Установить(Значение);
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
