#Область СлужебныйПрограммныйИнтерфейс

// См. РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий.
// 
// Параметры:
// 	Настройки - см. РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий.Настройки
// 
Процедура ПриОпределенииНастроекРегламентныхЗаданий(Настройки) Экспорт
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.УдалениеВременныхФайловОбластейДанных;
	Настройка.РаботаетСВнешнимиРесурсами = Истина;
	
КонецПроцедуры

// Вызывается при включении разделения данных по областям данных.
//
Процедура ПриВключенииРазделенияПоОбластямДанных() Экспорт
	
	РеглЗадание = РегламентныеЗадания.НайтиПредопределенное(Метаданные.РегламентныеЗадания.УдалениеВременныхФайловОбластейДанных);
	РеглЗадание.Использование = Истина;
	РеглЗадание.Записать();
	
КонецПроцедуры

#КонецОбласти