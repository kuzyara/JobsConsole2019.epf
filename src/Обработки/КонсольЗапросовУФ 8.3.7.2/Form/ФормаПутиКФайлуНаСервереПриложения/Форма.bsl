﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.ФильтрТипов = ?(ПустаяСтрока(Параметры.ФильтрТипов), ".txt", Параметры.ФильтрТипов);
	
	Объект.ПутьКФайлуНаСервереПриложения = Параметры.ПутьКФайлуНаСервереПриложения;
	
	ЗаполнитьДеревоКаталоговСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Значение = Новый Структура("Путь,Прочитать", Объект.ПутьКФайлуНаСервереПриложения, Ложь);
	Закрыть(Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура ПрочитатьФайл(Команда)
	
	Значение = Новый Структура("Путь,Прочитать", Объект.ПутьКФайлуНаСервереПриложения, Истина);
	Закрыть(Значение);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоКаталоговСервер()
	
	ДЗ = ДанныеФормыВЗначение(ДеревоКаталогов, Тип("ДеревоЗначений"));
	FSO = Новый COMОбъект("Scripting.FileSystemObject");
	
	ВывестиКаталоги = Истина;
	// Выборка объектов из коллекции Drives
	Для каждого Диск Из FSO.Drives Цикл
		// Диск.DriveLetter - буква диска
		Представление = Диск.Path;
		// Диск.DriveType = 1 - Flash накопитель
		// Диск.DriveType = 2 - Локальный жесткий диск
		// Диск.DriveType = 3 - Сетевой диск
		// Диск.DriveType = 4 - CD/DVD дисковод
		Если Диск.DriveType = 3 Тогда  // если это сетевой диск, то укажем сетевой путь
			Представление = Представление + ?(ПустаяСтрока(Диск.ShareName), "", " ") + Диск.ShareName;
		ИначеЕсли Диск.IsReady Тогда
			Представление = Представление + ?(ПустаяСтрока(Диск.VolumeName), "", " ") + Диск.VolumeName;
		Иначе
			Представление = Представление + " [Диск не найден]";
			ВывестиКаталоги = Ложь;
		КонецЕсли; 
		СтрокаДиска = ДЗ.Строки.Добавить();
		СтрокаДиска.Название = Представление;
		СтрокаДиска.ПолныйПуть = Диск.Path;
		//СтрокаДиска.Представление = Представление;
		СтрокаДиска.ЭтоКаталог = Истина;
		Если ВывестиКаталоги Тогда
			НоваяСтрока = СтрокаДиска.Строки.Добавить();
		Иначе
			СтрокаДиска.Просканирован = Истина;
		КонецЕсли;

	КонецЦикла;
	
	ЗначениеВДанныеФормы(ДЗ, ДеревоКаталогов);
КонецПроцедуры


&НаКлиенте
Процедура ДеревоКаталоговПередРазворачиванием(Элемент, Строка, Отказ)
	
	лДанныеСтроки = ДеревоКаталогов.НайтиПоИдентификатору(Строка);
	
	Если НЕ лДанныеСтроки.ЭтоКаталог ИЛИ лДанныеСтроки.Просканирован Тогда
		Возврат;
	КонецЕсли;
	
	лЭлементы = лДанныеСтроки.ПолучитьЭлементы();
	лЭлементы.Удалить(0);
	
	
	лДанныеСтроки.Просканирован = Истина;
	
	СписокПодкаталогов = ПолучитьСписокПодкаталогов(лДанныеСтроки.ПолныйПуть, Параметры.ФильтрТипов);
	ЭлементыСтроки = лДанныеСтроки.ПолучитьЭлементы();
	
	Для каждого пЭлемент Из СписокПодкаталогов.Каталоги Цикл
	
		НоваяСтрока = ЭлементыСтроки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, пЭлемент);
		НоваяСтрока.ЭтоКаталог = Истина;
		
		ЭлементыНовойСтроки = НоваяСтрока.ПолучитьЭлементы();
		ЭлементыНовойСтроки.Добавить();
		
	КонецЦикла; 
	
	Для каждого пЭлемент Из СписокПодкаталогов.Файлы Цикл
	
		НоваяСтрока = ЭлементыСтроки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, пЭлемент);
		
	КонецЦикла; 
	
КонецПроцедуры


&НаКлиенте
Процедура ДеревоКаталоговПриАктивизацииСтроки(Элемент)
	
	Объект.ПутьКФайлуНаСервереПриложения = Элемент.ТекущиеДанные.ПолныйПуть;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСписокПодкаталогов(ПолныйПуть, ФильтрТипов)

	FSO = Новый COMОбъект("Scripting.FileSystemObject");
	Каталоги = Новый Массив;
	Файлы = Новый Массив;
	
	Для каждого Подкаталог Из FSO.GetFolder(ПолныйПуть + "/").SubFolders Цикл

		Каталоги.Добавить(Новый Структура("Название, ПолныйПуть", Подкаталог.Name, Подкаталог.Path));

	КонецЦикла;
	
	Для каждого Файл Из FSO.GetFolder(ПолныйПуть + "/").Files Цикл
		
		//Если НРег(Прав(Файл.Name, СтрДлина(".txt"))) = ".txt" Тогда
		Если НРег(Прав(Файл.Name, СтрДлина(ФильтрТипов))) = ФильтрТипов Тогда
		
			Файлы.Добавить(Новый Структура("Название, ПолныйПуть", Файл.Name, Файл.Path));
		
		КонецЕсли; 
	
	КонецЦикла; 
	
	Возврат Новый Структура("Каталоги, Файлы", Каталоги, Файлы);

КонецФункции // ПолучитьСписокПодкаталогов()


