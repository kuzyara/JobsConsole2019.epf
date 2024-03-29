﻿//==============================================================================================================================================
// ПЕРЕМЕННЫЕ МОДУЛЯ
//==============================================================================================================================================

//==============================================================================================================================================
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ
//==============================================================================================================================================

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ДобавитьВТаблицуВидовРесурсов("jpg", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("png", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("cur", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("gif", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("bmp", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("emf", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("icon", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("ico", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("svg", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("tiff", 	"Картинка", 		"Картинка");
	ДобавитьВТаблицуВидовРесурсов("wmf", 	"Картинка", 		"Картинка");
	
	ДобавитьВТаблицуВидовРесурсов("mxl", 	"ТабличныйДокумент", "Табличный документ");
	
	ДобавитьВТаблицуВидовРесурсов("html", 	"html", 			"HTML");
	
	ДобавитьВТаблицуВидовРесурсов("lf", 	"Текст", 			"Управляемая форма");
	ДобавитьВТаблицуВидовРесурсов("сlf", 	"Текст", 			"Управляемая форма");
	ДобавитьВТаблицуВидовРесурсов("f", 		"Текст", 			"Обычная форма");
	ДобавитьВТаблицуВидовРесурсов("css", 	"Текст", 			"Стиль");
	ДобавитьВТаблицуВидовРесурсов("js", 	"Текст", 			"Скрипт");
	ДобавитьВТаблицуВидовРесурсов("txt", 	"Текст", 			"Текст");
	ДобавитьВТаблицуВидовРесурсов("xml", 	"Текст", 			"XML");
	ДобавитьВТаблицуВидовРесурсов("xsd", 	"Текст", 			"XML-схема");
	ДобавитьВТаблицуВидовРесурсов("xdto", 	"Текст", 			"XDTO-пакет");
	ДобавитьВТаблицуВидовРесурсов("xslt", 	"Текст", 			"XDTO-пакет");
	ДобавитьВТаблицуВидовРесурсов("dtd", 	"Текст", 			"XDTO-пакет");
	ДобавитьВТаблицуВидовРесурсов("st", 	"Текст", 			"Шаблон");
	ДобавитьВТаблицуВидовРесурсов("spl", 	"Текст", 			"Локализация");
	ДобавитьВТаблицуВидовРесурсов("sh", 	"Текст", 			"Скрипт");
	
КонецПроцедуры // ПриСозданииНаСервере()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если ТипЗнч(Настройки) = Тип("Соответствие") И Настройки.Получить("ОтображатьГруппировкуПоФайлам") <> Неопределено Тогда
		Элементы.ДеревоРесурсовИмяФайла.Видимость = Не Настройки.Получить("ОтображатьГруппировкуПоФайлам");
		Элементы.ДеревоРесурсовОтображатьГруппировкуПоФайлам.Пометка = ОтображатьГруппировкуПоФайлам;
	КонецЕсли;
	
КонецПроцедуры // ПриЗагрузкеДанныхИзНастроекНаСервере()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	КаталогВременныхФайлов = КаталогВременныхФайлов();
	
	КаталогФайлов = КаталогВременныхФайлов + "1c_res\";
	Файл = Новый Файл(КаталогФайлов);
	Если Не Файл.Существует() Тогда
		СоздатьКаталог(КаталогФайлов);
	КонецЕсли;
	
	Если ПустаяСтрока(КаталогРесурсов) Тогда
		КаталогРесурсов = КаталогПрограммы();
		
		СписокФайлов.Очистить();
		Для Каждого Файл Из НайтиФайлы(КаталогРесурсов, "*.res") Цикл
			
			Если Файл.Расширение <> ".res" Тогда
				Продолжить;
			КонецЕсли;
			
			Пометка = (Файл.Имя = "mngbase_ru.res");
			СписокФайлов.Добавить(Файл.ПолноеИмя, Файл.Имя, Пометка);
			
		КонецЦикла;

	КонецЕсли;
	
	Анализ();
	
КонецПроцедуры // ПриОткрытии()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	// Удаляем созданные временные файлы.
	УдалитьФайлы(КаталогФайлов, "*.*");
	
КонецПроцедуры // ПриЗакрытии()

//==============================================================================================================================================
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ
//==============================================================================================================================================

&НаКлиенте
Процедура ВыбратьФайлы(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыбратьФайлыОбработчик", ЭтаФорма);
	
	СписокЭлементов = Новый СписокЗначений;
	Для Каждого ЭлементСписка Из СписокФайлов Цикл
		СписокЭлементов.Добавить(ЭлементСписка.Представление, ЭлементСписка.Представление, ЭлементСписка.Пометка);
	КонецЦикла;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СписокЭлементов", СписокЭлементов);
	ПараметрыФормы.Вставить("Режим", "Выбор файлов");
	
	ОткрытьФорму(ИмяФормы + "ВыбораЭлементов", ПараметрыФормы, ЭтаФорма, , , , ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры // ВыбратьФайлы()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ВыбратьРасширения(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыбратьРасширенияОбработчик", ЭтотОбъект);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СписокЭлементов", ПолучитьСписокРасширений());
	ПараметрыФормы.Вставить("Режим", "Выбор расширений");
	
	ОткрытьФорму(ИмяФормы + "ВыбораЭлементов", ПараметрыФормы, ЭтаФорма, , , , ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры // ВыбратьРасширения()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура Анализ(Команда = Неопределено)
	
	Файл = Новый Файл(КаталогРесурсов);
	Если Не Файл.Существует() Тогда
		Возврат;
	КонецЕсли;
	
	Начало = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	КоллекцияСтрокПервогоУровня = ДеревоРесурсов.ПолучитьЭлементы();
	КоллекцияСтрокПервогоУровня.Очистить();
	
	СоответствиеРасширений = Новый Соответствие;
	Для Каждого ЭлементСписка Из ПолучитьСписокРасширений() Цикл
		СоответствиеРасширений.Вставить(ЭлементСписка.Значение, ЭлементСписка.Пометка);
	КонецЦикла;
	
	СоответствиеСтрок = Неопределено;
	СоответствиеКоллекций = Неопределено;
	
	ВсегоФайлов = 0;
	ВсегоРесурсов = 0;
	Для Каждого ЭлементСписка Из СписокФайлов Цикл
		
		Если Не ЭлементСписка.Пометка Тогда
			Продолжить;
		КонецЕсли;
		
		ВсегоФайлов 	= ВсегоФайлов + 1;
		ПолноеИмяФайла 	= ЭлементСписка.Значение;
		ИмяФайла 		= ЭлементСписка.Представление;
		
		Если ОтображатьГруппировкуПоФайлам Тогда
			
			СтрокаПервогоУровня = КоллекцияСтрокПервогоУровня.Добавить();
			СтрокаПервогоУровня.ПолноеИмяФайла 	= ПолноеИмяФайла;
			СтрокаПервогоУровня.Имя 			= ЭлементСписка.Представление;
			СтрокаПервогоУровня.ИмяФайла 		= ИмяФайла;
			
			КоллекцияСтрокВторогоУровня = СтрокаПервогоУровня.ПолучитьЭлементы();
			
		Иначе
			
			КоллекцияСтрокВторогоУровня = КоллекцияСтрокПервогоУровня;
			
		КонецЕсли;
		
		Поток = ФайловыеПотоки.ОткрытьДляЧтения(ПолноеИмяФайла);
		
		// Читаем заголовок файла в 32 байта.
		РазмерЗаголовка = 32;
		БуферДвоичныхДанных = Новый БуферДвоичныхДанных(РазмерЗаголовка);
		Поток.Прочитать(БуферДвоичныхДанных, 0, РазмерЗаголовка);
		
		// Заголовок пока не анализируем, todo.
		
		// Читаем заголовок таблицы.
		Поток.Прочитать(БуферДвоичныхДанных, 0, 4);
		
		ОписаниеТаблицы0 	= БуферДвоичныхДанных[0];
		ОписаниеТаблицы1 	= БуферДвоичныхДанных[1];
		ОписаниеТаблицы2 	= БуферДвоичныхДанных[2];
		ТипОсновнойТаблицы 	= БуферДвоичныхДанных[3];
		
		Если ТипОсновнойТаблицы <> 32 И ТипОсновнойТаблицы <> 64 И ТипОсновнойТаблицы <> 80 Тогда
			Сообщить("Неизвестный тип основной таблицы в файле " + ЭлементСписка.Представление);
			Продолжить;
		КонецЕсли;
		
		ЭтоУпрощеннаяТаблица 	= (ТипОсновнойТаблицы = 80);
		ЭтоТаблица64			= (ТипОсновнойТаблицы = 64);
		
		// Читаем количество индексов.
		Поток.Прочитать(БуферДвоичныхДанных, 0, 4);
		КоличествоИндексов = БуферДвоичныхДанных.ПрочитатьЦелое32(0);
		МассивИндексов = Новый Массив;
		Для НомерИндекса = 1 По КоличествоИндексов - 1 Цикл
			
			Поток.Прочитать(БуферДвоичныхДанных, 0, 4);
			МассивИндексов.Добавить(БуферДвоичныхДанных.ПрочитатьЦелое32(0));
			
		КонецЦикла;
		
		ИндексНачалаСтрокУникод 		= МассивИндексов[0] * 4 + РазмерЗаголовка;
		ИндексНачалаБинарныхРесурсов 	= МассивИндексов[5] * 4 + РазмерЗаголовка;
		
		// Чтение идентификаторов ресурсов.
		ЧтениеДанных = Новый ЧтениеДанных(Поток, КодировкаТекста.ANSI);
		
		ВсегоУжеПрочитано 	= РазмерЗаголовка + 4 + 4 + (КоличествоИндексов - 1) * 4;
		ВсегоПрочитать 		= ИндексНачалаСтрокУникод - ВсегоУжеПрочитано;
		РазмерБлока 		= 8192; // При попытке чтения большим блоком выдается ошибка переполнения буфера.
		ВсегоБлоков 		= ВсегоПрочитать / РазмерБлока;
		ВсегоБлоков 		= ?(Цел(ВсегоБлоков) = ВсегоБлоков, ВсегоБлоков, Цел(ВсегоБлоков) + 1);
		
		СтрокаИменРесурсов = "";
		Для НомерБлока = 1 По ВсегоБлоков Цикл
			
			Прочитать = Мин(ВсегоПрочитать, РазмерБлока);
			СтрокаИменРесурсов = СтрокаИменРесурсов + ЧтениеДанных.ПрочитатьСимволы(Прочитать);
			ВсегоПрочитать = ВсегоПрочитать - РазмерБлока;
			
		КонецЦикла;
		ЧтениеДанных.Закрыть();
		
		РазмерИлиСмещениеТаблицы = ОписаниеТаблицы2 * 256 * 256 + ОписаниеТаблицы1 * 256 + ОписаниеТаблицы0;
		Если Не ЭтоУпрощеннаяТаблица Тогда
			СмещениеОсновнойТаблицы = РазмерИлиСмещениеТаблицы * 4 + РазмерЗаголовка;
		Иначе
			СмещениеОсновнойТаблицы = ИндексНачалаСтрокУникод + РазмерИлиСмещениеТаблицы * 2;
		КонецЕсли;
		
		// Смещание на описание таблицы.
		Поток.Перейти(СмещениеОсновнойТаблицы, ПозицияВПотоке.Начало);
		
		// Количество элементов в таблице.
		Если ЭтоТаблица64 Тогда
			Поток.Прочитать(БуферДвоичныхДанных, 0, 4);
			ВсегоЭлементов = БуферДвоичныхДанных.ПрочитатьЦелое32(0);
		Иначе
			Поток.Прочитать(БуферДвоичныхДанных, 0, 2);
			ВсегоЭлементов = БуферДвоичныхДанных.ПрочитатьЦелое16(0);
		КонецЕсли;
		
		СоответствиеСтрок 		= ?(ОтображатьГруппировкуПоФайлам Или СоответствиеСтрок = Неопределено, Новый Соответствие, СоответствиеСтрок);
		СоответствиеКоллекций 	= ?(ОтображатьГруппировкуПоФайлам Или СоответствиеКоллекций = Неопределено, Новый Соответствие, СоответствиеКоллекций);
		СоответствиеРесурсов 	= Новый Соответствие;
		
		// Далее по два байта (по 4 байта для таблицы 64) смещение идентификаторов.
		Для ИндексЭлемента = 0 По ВсегоЭлементов - 1 Цикл
			
			Если ЭтоТаблица64 Тогда
				Поток.Прочитать(БуферДвоичныхДанных, 0, 4);
				Смещение = БуферДвоичныхДанных.ПрочитатьЦелое32(0) + РазмерЗаголовка;
			Иначе
				Поток.Прочитать(БуферДвоичныхДанных, 0, 2);
				Смещение = БуферДвоичныхДанных.ПрочитатьЦелое16(0) + РазмерЗаголовка;
			КонецЕсли;
			
			ПозицияВСтроке 	= Смещение - ВсегоУжеПрочитано + 1;
			Номер 			= СтрНайти(СтрокаИменРесурсов, Символ(0), , ПозицияВСтроке);
			ИмяРесурса 		= Сред(СтрокаИменРесурсов, ПозицияВСтроке, Номер - ПозицияВСтроке);
			
			НомерТочки = Найти(ИмяРесурса, ".");
			Расширение = ?(НомерТочки > 0, Сред(ИмяРесурса, НомерТочки + 1), "");
			ОтображатьРасширение = СоответствиеРасширений.Получить(Расширение);
			Если ОтображатьРасширение = Неопределено Тогда
				ОтображатьРасширение = СоответствиеРасширений.Получить("-");
			КонецЕсли;
			
			Если Не ОтображатьРасширение Тогда
				Продолжить;
			КонецЕсли;
			
			КоллекцияЭлементов = СоответствиеКоллекций.Получить(Расширение);
			Если КоллекцияЭлементов = Неопределено Тогда
				
				СтрокаВторогоУровня = КоллекцияСтрокВторогоУровня.Добавить();
				СтрокаВторогоУровня.Имя 			= ?(ПустаяСтрока(Расширение), "<без расширения>", "." + Расширение);
				СтрокаВторогоУровня.ПолноеИмяФайла 	= ПолноеИмяФайла;
				
				КоллекцияЭлементов = СтрокаВторогоУровня.ПолучитьЭлементы();
				
				СоответствиеСтрок.Вставить(Расширение, СтрокаВторогоУровня);
				СоответствиеКоллекций.Вставить(Расширение, КоллекцияЭлементов);
				
			КонецЕсли;
			
			СтрокаРесурса = КоллекцияЭлементов.Добавить();
			СтрокаРесурса.ПолноеИмяФайла 	= ПолноеИмяФайла;
			СтрокаРесурса.ИмяФайла 			= ИмяФайла;
			СтрокаРесурса.Имя 				= ИмяРесурса;
			СтрокаРесурса.Расширение 		= Расширение;
			СтрокаРесурса.СмещениеИмени 	= Смещение;
			
			СоответствиеРесурсов.Вставить(ИндексЭлемента, СтрокаРесурса);
			
			ВсегоРесурсов = ВсегоРесурсов + 1;
			
		КонецЦикла;
		
		Если СоответствиеРесурсов.Количество() = 0 И ОтображатьГруппировкуПоФайлам Тогда
			
			ВсегоФайлов = ВсегоФайлов - 1;
			КоллекцияСтрокПервогоУровня.Удалить(СтрокаПервогоУровня);
			Продолжить;
			
		КонецЕсли;
		
		// Затем от 0 до позиции C парные символы AA.
		ТекущаяПозиция = Поток.ТекущаяПозиция();
		Для Номер = 1 По 20 Цикл
			
			Поток.Прочитать(БуферДвоичныхДанных, 0, 2);
			Если БуферДвоичныхДанных[0] = 170 И БуферДвоичныхДанных[1] = 170 Тогда
				ТекущаяПозиция = ТекущаяПозиция + 2;
			Иначе
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Поток.Перейти(ТекущаяПозиция, ПозицияВПотоке.Начало);
		
		Для ИндексЭлемента = 0 По ВсегоЭлементов - 1 Цикл
			
			Если Не ЭтоУпрощеннаяТаблица Тогда
				
				Поток.Прочитать(БуферДвоичныхДанных, 0, 4);
				Тип = БуферДвоичныхДанных[3];
				ЛокальноеСмещение = БуферДвоичныхДанных[2] * 256 * 256 + БуферДвоичныхДанных[1] * 256 + БуферДвоичныхДанных[0];
				
			Иначе
				
				Поток.Прочитать(БуферДвоичныхДанных, 0, 2);
				Тип = 96; // Строка уникод.
				ЛокальноеСмещение = БуферДвоичныхДанных[1] * 256 + БуферДвоичныхДанных[0];
				
			КонецЕсли;
			
			Если Тип = 16 Тогда // Двоичные данные.
				Смещение = ЛокальноеСмещение * 4 + РазмерЗаголовка; // Смещение в байтах относительно начала.
			Иначе
				Смещение = ЛокальноеСмещение; // Смещение в символах относительно начала строк уникод.
				Смещение = ИндексНачалаСтрокУникод + Смещение * 2;
			КонецЕсли;
			
			СтрокаРесурса = СоответствиеРесурсов.Получить(ИндексЭлемента);
			Если СтрокаРесурса = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			СтрокаРесурса.ТипРесурса 			= Тип;
			СтрокаРесурса.СмещениеЗначения 		= Смещение;
			СтрокаРесурса.ЭтоДвоичныеДанные 	= (Тип = 16);
			
		КонецЦикла;
		
		ОбщийРазмер = 0;
		
		// Читаем размеры ресурсов.
		Для ИндексЭлемента = 0 По ВсегоЭлементов - 1 Цикл
			
			СтрокаРесурса = СоответствиеРесурсов.Получить(ИндексЭлемента);
			Если СтрокаРесурса = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			Если СтрокаРесурса.ЭтоДвоичныеДанные Тогда
				
				Поток.Перейти(СтрокаРесурса.СмещениеЗначения, ПозицияВПотоке.Начало);
				Поток.Прочитать(БуферДвоичныхДанных, 0, 4);
				СтрокаРесурса.Размер = БуферДвоичныхДанных.ПрочитатьЦелое32(0);
				
				СтрокаВторогоУровня = СоответствиеСтрок.Получить(СтрокаРесурса.Расширение);
				СтрокаВторогоУровня.Размер = СтрокаВторогоУровня.Размер + СтрокаРесурса.Размер;
				ОбщийРазмер = ОбщийРазмер + СтрокаРесурса.Размер;
				
			КонецЕсли;
			
		КонецЦикла;
		
		// Поток больше не нужен, его надо закрыть.
		Поток.Закрыть();
		
		Если ОтображатьГруппировкуПоФайлам Тогда
			
			СтрокаПервогоУровня.Размер = ОбщийРазмер;
			СтрокаПервогоУровня.Имя = СтрокаПервогоУровня.Имя + " (" + СоответствиеРесурсов.Количество() + ")";
			ОтобразитьКоличество(СоответствиеСтрок);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если Не ОтображатьГруппировкуПоФайлам Тогда
		ОтобразитьКоличество(СоответствиеСтрок);
	КонецЕсли;
	
	Окончание = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	ВремяАнализа = "" + (Окончание - Начало) / 1000 + " сек.";
	
КонецПроцедуры // Анализ()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ОтобразитьКоличество(пСоответствиеСтрок)
	
	Если пСоответствиеСтрок = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого КлючЗначение Из пСоответствиеСтрок Цикл
		СтрокаДерева = КлючЗначение.Значение;
		СтрокаДерева.Имя = "" + СтрокаДерева.Имя + " (" + СтрокаДерева.ПолучитьЭлементы().Количество() + ")";
	КонецЦикла;
	
КонецПроцедуры // ОтобразитьКоличество()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура СохранитьФайл(Команда)
	
	ТекущиеДанные = Элементы.ДеревоРесурсов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПодчЭлементы = ТекущиеДанные.ПолучитьЭлементы();
	
	Если ТекущиеДанные.ЭтоДвоичныеДанные Тогда
		ПутьКВременномуФайлу = КаталогФайлов + ТекущиеДанные.Имя;
		Base64Значение(ТекущиеДанные.Значение).Записать(ПутьКВременномуФайлу);
	КонецЕсли;
	
	КоличествоПодчиненных = ПодчЭлементы.Количество();
	Если КоличествоПодчиненных > 0 Тогда
		Если Вопрос("Выгрузить " + КоличествоПодчиненных + " элементов?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда
			Сч = 0;
			Для Каждого ТекущиеДанные Из ПодчЭлементы Цикл
				Сч = Сч + 1;
				Если ТекущиеДанные.ЭтоДвоичныеДанные Тогда
					ИзвлечьРесурс(ТекущиеДанные);
					ПутьКВременномуФайлу = КаталогФайлов + ТекущиеДанные.Имя;
					Base64Значение(ТекущиеДанные.Значение).Записать(ПутьКВременномуФайлу);
				КонецЕсли;
				ОбработкаПрерыванияПользователя();
				Состояние("Выгрузка " + Сч + " из " + КоличествоПодчиненных);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
	ЗапуститьПриложение(КаталогФайлов);
	
КонецПроцедуры // СохранитьФайл()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ОткрытьКакВнешнююОбработку(Команда)
	
	ТекущиеДанные = Элементы.ДеревоРесурсов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Или ТекущиеДанные.Расширение <> "epf" Тогда
		Возврат;
	КонецЕсли;
	
	ПутьКОбработке = КаталогФайлов + ТекущиеДанные.Имя;
	ИмяОбработки = СтрЗаменить(ТекущиеДанные.Имя, ".epf", "");
	
	ДвоичныеДанные = Base64Значение(ТекущиеДанные.Значение);
	ДвоичныеДанные.Записать(ПутьКОбработке);
	
	ДанныеОбработки = Новый ДвоичныеДанные(ПутьКОбработке);
	АдресДанныхОбработки = ПоместитьВоВременноеХранилище(ДанныеОбработки, УникальныйИдентификатор);
	ИмяОбработки = ПодключитьОбработкуНаСервере(АдресДанныхОбработки, ИмяОбработки);
	
	ОткрытьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма");
	
КонецПроцедуры // ОткрытьКакВнешнююОбработку()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ОтображатьГруппировкуПоФайлам(Команда)
	
	ОтображатьГруппировкуПоФайлам = Не ОтображатьГруппировкуПоФайлам;
	Элементы.ДеревоРесурсовОтображатьГруппировкуПоФайлам.Пометка = ОтображатьГруппировкуПоФайлам;
	Элементы.ДеревоРесурсовИмяФайла.Видимость = Не ОтображатьГруппировкуПоФайлам;
	
КонецПроцедуры // ОтображатьГруппировкуПоФайлам()

//==============================================================================================================================================
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ
//==============================================================================================================================================

&НаКлиенте
Процедура КаталогРесурсовНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогОткрытияФайла.ПолноеИмяФайла 	= КаталогРесурсов;
	ДиалогОткрытияФайла.Заголовок 		= "Выберите каталог с ресурсами";
	ДиалогОткрытияФайла.Каталог = КаталогРесурсов;
	
	Если ДиалогОткрытияФайла.Выбрать() Тогда
		КаталогРесурсов = ДиалогОткрытияФайла.Каталог;
		КаталогРесурсовПриИзменении(Элемент);
	КонецЕсли;
	
КонецПроцедуры // КаталогРесурсовНачалоВыбора()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура КаталогРесурсовПриИзменении(Элемент)
	
	НеотмеченныеФайлы = Новый Соответствие;
	Для Каждого ЭлементСписка Из СписокФайлов Цикл
		
		Если Не ЭлементСписка.Пометка Тогда
			НеотмеченныеФайлы.Вставить(ЭлементСписка.Представление, Истина);
		КонецЕсли;
		
	КонецЦикла;
	
	СписокФайлов.Очистить();
	Для Каждого Файл Из НайтиФайлы(КаталогРесурсов, "*.res") Цикл
		
		Если Файл.Расширение <> ".res" Тогда
			Продолжить;
		КонецЕсли;
		
		Пометка = (НеотмеченныеФайлы.Получить(Файл.Имя) = Неопределено);
		СписокФайлов.Добавить(Файл.ПолноеИмя, Файл.Имя, Пометка);
		
	КонецЦикла;
	
КонецПроцедуры // КаталогРесурсовПриИзменении()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ДеревоРесурсовПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ОтобразитьРесурс", 0.1, Истина);
	
КонецПроцедуры // ДеревоРесурсовПриАктивизацииСтроки()

//==============================================================================================================================================
// КЛИЕНТСКИЕ ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ
//==============================================================================================================================================

&НаКлиенте
Процедура ВыбратьФайлыОбработчик(пРезультат, пДополнительныеПараметры) Экспорт
	
	Если пРезультат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ЭлементФайла Из СписокФайлов Цикл
		
		ЭлементСписка = пРезультат.НайтиПоЗначению(ЭлементФайла.Представление);
		Если ЭлементСписка <> Неопределено Тогда
			ЭлементФайла.Пометка = ЭлементСписка.Пометка;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры // ВыбратьФайлыОбработчик()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ВыбратьРасширенияОбработчик(пРезультат, пДополнительныеПараметры) Экспорт
	
	Если пРезультат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИгнорируемыеРасширения.Очистить();
	Для Каждого ЭлементСписка Из пРезультат Цикл
		
		Если Не ЭлементСписка.Пометка Тогда
			ИгнорируемыеРасширения.Добавить(ЭлементСписка.Значение);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры // ВыбратьФайлыОбработчик()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ИзвлечьРесурс(пТекущиеДанные)
	
	Если Не ПустаяСтрока(пТекущиеДанные.Значение) Тогда
		Возврат;
	КонецЕсли;
	
	Если пТекущиеДанные.СмещениеЗначения = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Если пТекущиеДанные.ЭтоДвоичныеДанные Тогда
		
		ЧтениеДанных = Новый ЧтениеДанных(пТекущиеДанные.ПолноеИмяФайла);
		ЧтениеДанных.Пропустить(пТекущиеДанные.СмещениеЗначения);
		
		// Читаем заголовок.
		РазмерДанных = ЧтениеДанных.ПрочитатьЦелое32();
		Если РазмерДанных <> Неопределено Тогда
			
			Результат = ЧтениеДанных.Прочитать(РазмерДанных);
			
			ДвоичныеДанные = Результат.ПолучитьДвоичныеДанные();
			пТекущиеДанные.Значение = Base64Строка(ДвоичныеДанные);
			
			Если пТекущиеДанные.Расширение = "zip" Тогда
				
				ПутьКВременномуФайлу 	= КаталогФайлов + пТекущиеДанные.Имя;
				ПутьККаталогу			= КаталогФайлов + Лев(пТекущиеДанные.Имя, СтрДлина(пТекущиеДанные.Имя) - 4);
				
				КоллекцияСтрок = пТекущиеДанные.ПолучитьЭлементы();
				
				ЧтениеZipФайла = Новый ЧтениеZipФайла(Результат.ОткрытьПотокДляЧтения());
				ЧтениеZipФайла.ИзвлечьВсе(ПутьККаталогу, РежимВосстановленияПутейФайловZIP.НеВосстанавливать);
				Для Каждого ЭлементZip Из ЧтениеZipФайла.Элементы Цикл
					
					Если ПустаяСтрока(ЭлементZip.Имя) Тогда
						Продолжить;
					КонецЕсли;
					
					Данные = Новый ДвоичныеДанные(ПутьККаталогу + "\" + ЭлементZip.Имя);
					
					СтрокаЭлемента = КоллекцияСтрок.Добавить();
					СтрокаЭлемента.ПолноеИмяФайла 		= пТекущиеДанные.ПолноеИмяФайла;
					СтрокаЭлемента.Имя 					= ЭлементZip.Имя;
					СтрокаЭлемента.ЭтоДвоичныеДанные 	= Истина;
					СтрокаЭлемента.Значение				= Base64Строка(Данные);
					СтрокаЭлемента.Размер 				= Данные.Размер();
					СтрокаЭлемента.Расширение			= ЭлементZip.Расширение;
					
				КонецЦикла;
				
			КонецЕсли;
			
		КонецЕсли;
		
		ЧтениеДанных.Закрыть();
		
	Иначе
		
		Поток = ФайловыеПотоки.ОткрытьДляЧтения(пТекущиеДанные.ПолноеИмяФайла);
		Поток.Перейти(пТекущиеДанные.СмещениеЗначения, ПозицияВПотоке.Начало);
		
		БуферДвоичныхДанных = Новый БуферДвоичныхДанных(2);
		
		// Читаем первый символ уникод.
		Поток.Прочитать(БуферДвоичныхДанных, 0, 2);
		КодСимвола = БуферДвоичныхДанных.ПрочитатьЦелое16(0);
		Значение = "";
		Пока КодСимвола <> 0 Цикл
			
			Значение = Значение + Символ(КодСимвола);
			Поток.Прочитать(БуферДвоичныхДанных, 0, 2);
			КодСимвола = БуферДвоичныхДанных.ПрочитатьЦелое16(0);
			
		КонецЦикла;
		
		пТекущиеДанные.Значение = ?(СтрДлина(Значение) > 40, Сред(Значение, 2), Значение);
		
	КонецЕсли;
	
КонецПроцедуры // ИзвлечьРесурс()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ОтобразитьРесурс()
	
	ТекущиеДанные = Элементы.ДеревоРесурсов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИзвлечьРесурс(ТекущиеДанные);
	Если ТекущиеДанные.ЭтоДвоичныеДанные Тогда
		
		Если ТекущиеДанные.Расширение = "zip" Тогда // Для коллекции картинок делается попытка поиска масштаба 100%.
			
			СтрокаPNG = Неопределено;
			ПерваяСтрокаPNG = Неопределено;
			Для Каждого СтрокаДерева Из ТекущиеДанные.ПолучитьЭлементы() Цикл
				
				Если СтрНайти(СтрокаДерева.Имя, "_100.") > 0 Тогда
					СтрокаPNG = СтрокаДерева;
					Прервать;
				КонецЕсли;
				
				Если (СтрокаДерева.Расширение = "png" Или СтрокаДерева.Расширение = "gif") И СтрокаPNG = Неопределено Тогда
					ПерваяСтрокаPNG = СтрокаДерева;
				КонецЕсли;
				
			КонецЦикла;
			
			Если СтрокаPNG <> Неопределено Тогда
				ТекущиеДанные = СтрокаPNG;
			ИначеЕсли ПерваяСтрокаPNG <> Неопределено Тогда
				ТекущиеДанные = ПерваяСтрокаPNG;
			КонецЕсли;
			
		КонецЕсли;
		
		ТипЗначения = Неопределено;
		Для Каждого СтрокаТЗ Из ТаблицаВидовРесурсов Цикл
			
			Если НРег(ТекущиеДанные.Расширение) = СтрокаТЗ.Расширение Тогда
				ТипЗначения = СтрокаТЗ.Тип;
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Если ТипЗначения <> Неопределено Тогда
			
			ПутьКВременномуФайлу = КаталогФайлов + ТекущиеДанные.Имя;
			ДвоичныеДанные = Base64Значение(ТекущиеДанные.Значение);
			
			Если ТипЗначения = "Картинка" Тогда
				
				Значение = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
				
			ИначеЕсли ТипЗначения = "ТабличныйДокумент" Тогда
				
				Адрес = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
				ПрочитатьТабличныйДокумент(Адрес);
				
			Иначе
				
				ДвоичныеДанные.Записать(ПутьКВременномуФайлу);
				
				Текст = Новый ТекстовыйДокумент;
				Текст.Прочитать(ПутьКВременномуФайлу, "UTF-8");
				Значение = Текст.ПолучитьТекст();
				
			КонецЕсли;
			
			Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы["Страница" + ТипЗначения];
			
		Иначе
			
			Значение = ТекущиеДанные.Значение;
			Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаТекст;
			
		КонецЕсли;
		
	Иначе
		
		Значение = ТекущиеДанные.Значение;
		Элементы.ГруппаСтраницы.ТекущаяСтраница = ?(ПустаяСтрока(Значение), Элементы.СтраницаПустая, Элементы.СтраницаТекст);
		
	КонецЕсли;
	
КонецПроцедуры // ОтобразитьРесурс()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Процедура ОткрытьСохранитьВнешнююОбработку(пОткрыть)
	
	ТекущиеДанные = Элементы.ДеревоРесурсов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Или ТекущиеДанные.Расширение <> "epf" Тогда
		Возврат;
	КонецЕсли;
	
	ПутьКОбработке = КаталогФайлов + ТекущиеДанные.Имя;
	ИмяОбработки = СтрЗаменить(ТекущиеДанные.Имя, ".epf", "");
	
	ДвоичныеДанные = Base64Значение(ТекущиеДанные.ДвоичныеДанные);
	ДвоичныеДанные.Записать(ПутьКОбработке);
	
	Если пОткрыть Тогда
		
		ДанныеОбработки = Новый ДвоичныеДанные(ПутьКОбработке);
		АдресДанныхОбработки = ПоместитьВоВременноеХранилище(ДанныеОбработки, УникальныйИдентификатор);
		ИмяОбработки = ПодключитьОбработкуНаСервере(АдресДанныхОбработки, ИмяОбработки);
		
		ОткрытьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма");
		
	Иначе
		ЗапуститьПриложение(КаталогФайлов);
	КонецЕсли;
	
КонецПроцедуры // ОткрытьСохранитьВнешнююОбработку()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаКлиенте
Функция ПолучитьСписокРасширений()
	
	СписокРасширений = Новый СписокЗначений;
	Для Каждого СтрокаТЗ Из ТаблицаВидовРесурсов Цикл
		Пометка = (ИгнорируемыеРасширения.НайтиПоЗначению(СтрокаТЗ.Расширение) = Неопределено);
		СписокРасширений.Добавить(СтрокаТЗ.Расширение, СтрокаТЗ.Расширение, Пометка);
	КонецЦикла;
	
	Пометка = (ИгнорируемыеРасширения.НайтиПоЗначению("zip") = Неопределено);
	СписокРасширений.Добавить("zip", "zip", Пометка);
	
	Пометка = (ИгнорируемыеРасширения.НайтиПоЗначению("epf") = Неопределено);
	СписокРасширений.Добавить("epf", "epf", Пометка);
	
	Пометка = (ИгнорируемыеРасширения.НайтиПоЗначению("") = Неопределено);
	СписокРасширений.Добавить("", "<без расширения>", Пометка);
	
	Пометка = (ИгнорируемыеРасширения.НайтиПоЗначению("-") = Неопределено);
	СписокРасширений.Добавить("-", "<прочие расширения>", Пометка);
	
	Возврат СписокРасширений;
	
КонецФункции // ПолучитьСписокРасширений()

//==============================================================================================================================================
// КЛИЕНТ-СЕРВЕРНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ
//==============================================================================================================================================

//==============================================================================================================================================
// СЕРВЕРНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ
//==============================================================================================================================================

&НаСервере
Процедура ДобавитьВТаблицуВидовРесурсов(пРасширение, пТип, пПредставление)
	
	СтрокаТЗ = ТаблицаВидовРесурсов.Добавить();
	СтрокаТЗ.Расширение 	= пРасширение;
	СтрокаТЗ.Тип 			= пТип;
	СтрокаТЗ.Представление 	= пПредставление;
	
КонецПроцедуры // ДобавитьВТаблицуВидовРесурсов()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаСервере
Процедура ПрочитатьТабличныйДокумент(пАдрес)
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(пАдрес);
	ПутьКВременномуФайлу = ПолучитьИмяВременногоФайла("mxl");
	
	ДвоичныеДанные.Записать(ПутьКВременномуФайлу);
	ТабличныйДокумент.Прочитать(ПутьКВременномуФайлу);
	
КонецПроцедуры // ПрочитатьТабличныйДокумент()

//----------------------------------------------------------------------------------------------------------------------------------------------

&НаСервере
Функция ПодключитьОбработкуНаСервере(пАдресДанныхОбработки, пИмяОбработки)
	
	Возврат ВнешниеОбработки.Подключить(пАдресДанныхОбработки, пИмяОбработки, Ложь);
	
КонецФункции // ПодключитьОбработкуНаСервере()

//==============================================================================================================================================
// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ
//==============================================================================================================================================
