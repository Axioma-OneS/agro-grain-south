////////////////////////////////////////////////////////////////////////////////
// Подсистема "Коммерческие предложения".
// ОбщийМодуль.КоммерческиеПредложенияКлиент.
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Отправка запроса коммерческих предложений.
//  Используется для отправки и обновления Запроса коммерческих предложений через сервис 1С:Бизнес-сеть,
//  или с помощью 1С-ЭДО.
//
// Параметры:
//  Документ - ДокументСсылка - Ссылка на учетный документ Запрос коммерческих предложений поставщиков.
//                              См. ОпределяемыйТип.ЗапросКоммерческихПредложенийПоставщиков.
//
Процедура ОтправитьЗапросКоммерческихПредложений(Знач Документ) Экспорт
	
	ПараметрыОтправки = Новый Структура;
	ПараметрыОтправки.Вставить("ЗапросКоммерческихПредложений", Документ);
	
	ПродолжениеОтправки = Новый ОписаниеОповещения("ОтправитьЗапросКоммерческихПредложенийСертификатыПолучены",
		КоммерческиеПредложенияСлужебныйКлиент, ПараметрыОтправки);
	
	ОбменСКонтрагентамиСлужебныйКлиент.ПолучитьОтпечаткиСертификатов(ПродолжениеОтправки, Истина);
	
КонецПроцедуры

// Отмена Запроса коммерческих предложений.
//  После выполнения этой операции, изменение документа в сервисе будет невозможно.
//
// Параметры:
//  Документ - ДокументСсылка - Ссылка на учетный документ Запрос коммерческих предложений поставщиков.
//                              См. ОпределяемыйТип.ЗапросКоммерческихПредложенийПоставщиков.
//
Процедура ОтменитьЗапросКоммерческихПредложений(Знач Документ) Экспорт
	
	ПараметрыОтправки = Новый Структура;
	ПараметрыОтправки.Вставить("ЗапросКоммерческихПредложений", Документ);
	
	Результат = КоммерческиеПредложенияСлужебныйВызовСервера.ОтменитьЗапросКоммерческихПредложений(ПараметрыОтправки);
	
	Если Результат.ДлительнаяОперация <> Неопределено Тогда
	
		ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Неопределено);
		ПараметрыОжидания.ВыводитьПрогрессВыполнения = Ложь;
		ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
		ПараметрыОжидания.ОповещениеПользователя.Показать = Ложь;
		ПараметрыОжидания.ВыводитьСообщения = Истина;
		
		ОтправкаПродолжение = Новый ОписаниеОповещения("ОтменитьЗапросКоммерческихПредложенийЗавершение",
			КоммерческиеПредложенияСлужебныйКлиент, ПараметрыОтправки);
		
		ДлительныеОперацииКлиент.ОжидатьЗавершение(Результат.ДлительнаяОперация, ОтправкаПродолжение, ПараметрыОжидания);
		
	ИначеЕсли Результат.СостояниеДокумента <> Неопределено Тогда
		
		ЗавершениеОтправки = Новый ОписаниеОповещения("ОтменитьЗапросКоммерческихПредложенийЗавершение",
			КоммерческиеПредложенияСлужебныйКлиент, ПараметрыОтправки);
		
		ВыполнитьОбработкуОповещения(ЗавершениеОтправки, Результат.СостояниеДокумента);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
