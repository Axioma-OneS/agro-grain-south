﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "ИнтернетПоддержкаПользователей.ОбменДаннымиСВнешнимиСистемами".
// ОбщийМодуль.СервисОбменаСообщениямиПереопределяемый.
//
// Серверные переопределяемые процедуры обмена данными с внешними системами:
//  - определение списка доступных для обмена внешних систем;
//  - определения алгоритмов обновления настроек и проверки возможности загрузки файлов обмена.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определяет идентификаторы внешних систем, с которыми возможно настроить обмен данными.
// Если реализация метода не заполнена, считается что конфигурация может обмениваться
// со всеми внешними системами зарегистрированными в сервисе обмена данными.
//
// Параметры:
//  ИдентификаторыСистем - Массив из Строка - содержит список идентификаторов внешних систем.
//
// Пример:
//	ИдентификаторыСистем.Добавить("DemoSystem");
//
Процедура ПриОпределенииДоступныхВнешнихСистем(ИдентификаторыСистем) Экспорт
	
	
КонецПроцедуры

// Метод вызывается перед загрузкой данных перед загрузкой файла из сервиса
// и позволяет обработать дополнительные параметры внешней системы.
//
// Параметры:
//  ИдентификаторСистем - Строка - идентификатор внешней системы в сервисе;
//  ПараметрыФайла      - Соответствие - параметры переданные внешней системой.
//
// Пример:
//	Если ИдентификаторСистем = "DemoSystem" Тогда
//		НастройкаОбменаСDemoSystem.УстановитьНастройкиУчета(
//			ДополнительныеПараметры.Получить("AccountigParameters"));
//	КонецЕсли;
//
Процедура ПередЗагрузкойФайлаОбменаДанными(ИдентификаторСистем, ПараметрыФайла) Экспорт
	
	
КонецПроцедуры

#КонецОбласти
