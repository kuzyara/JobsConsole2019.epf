﻿

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Об = РеквизитФормыВЗначение("Объект");
	
	ЭтоОбъектКонфигурации = Метаданные.НайтиПоТипу(ТипЗнч(Об)) <> Неопределено;
	
	МетаданныеОбъекта = Об.Метаданные();
	
	Если ЭтоОбъектКонфигурации Тогда
		ИмяОбработки = МетаданныеОбъекта.Имя;
	Иначе
		ПутьКФайлуКонсолиЗапросов = Об.ИспользуемоеИмяФайла;
		Элементы.ВариантВызоваКонсолиЗапросов.Доступность = Ложь;
	КонецЕсли; 

	ВариантВызоваКонсолиЗапросов = ?(ЭтоОбъектКонфигурации, 1, 0);
	
	ПроверкаЗащитыОтОпасныхДействий = ПроверкаЗащитыОтОпасныхДействий();
	
	Если ПроверкаЗащитыОтОпасныхДействий.ЕстьПроверка Тогда
		
		Если ПроверкаЗащитыОтОпасныхДействий.ПроверкаВключена Тогда
			ТекстСообщения = "У текущего пользователя включена защита от опасных действий!
			|Чтобы вызов консоли не блокировался - необходимо отключить защиту.";
			Элементы.ДекорацияЗнакЗапрета.Видимость = Истина;
			Элементы.ДекорацияЗапретаНет.Видимость = Ложь;
		Иначе
			ТекстСообщения = "Защита от опасных действий отключена.";
			Элементы.ДекорацияЗнакЗапрета.Видимость = Ложь;
			Элементы.ДекорацияЗапретаНет.Видимость = Истина;
		КонецЕсли; 
	Иначе
		Элементы.ГруппаПроверкаЗащиты.Видимость = Ложь;
	КонецЕсли; 
	
	Элементы.ДекорацияТекстСообщения.Заголовок = ТекстСообщения;

	НазваниеПеременнойЗапроса = ?(НазваниеПеременнойЗапроса = "", "Запрос", НазваниеПеременнойЗапроса);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьСтрокуВызова();

КонецПроцедуры


&НаКлиенте
Процедура НазваниеПеременнойЗапросаПриИзменении(Элемент)
	
	ОбновитьСтрокуВызова();

КонецПроцедуры

&НаКлиенте
Процедура ВариантВызоваКонсолиЗапросовПриИзменении(Элемент)
	
	ОбновитьСтрокуВызова();

КонецПроцедуры

&НаКлиенте
Процедура СтрокаВызоваНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
    ОбъектКопирования = Новый COMОбъект("htmlfile");
    ОбъектКопирования.ParentWindow.ClipboardData.Setdata("Text", СтрокаВызова);
	ПоказатьОповещениеПользователя("Текст скопирован в буфер обмена!");
	
КонецПроцедуры


&НаКлиенте
Процедура ОбновитьСтрокуВызова()
	
	Элементы.ПутьКФайлуКонсолиЗапросов.Видимость = ВариантВызоваКонсолиЗапросов = 0;
	Элементы.ИмяОбработки.Видимость = ВариантВызоваКонсолиЗапросов = 1;
	
	Если ВариантВызоваКонсолиЗапросов = 0 Тогда  // Внешняя обработка
		ДвоичныеДанные = Новый ДвоичныеДанные(ПутьКФайлуКонсолиЗапросов);
		Адрес = ПоместитьВоВременноеХранилище(ДвоичныеДанные, Новый УникальныйИдентификатор);
		лФайл = Новый Файл(ПутьКФайлуКонсолиЗапросов);
		ПоместитьВХранилищеНаСервере(Адрес, ПутьКФайлуКонсолиЗапросовНаСервере, лФайл.Имя);
		
		СтрокаВызова = "ВнешниеОбработки.Создать(""[ПутьКФайлуКонсолиЗапросов]"", Ложь).ОбработатьВнешнийЗапрос([Запрос])";
		СтрокаВызова = СтрЗаменить(СтрокаВызова, "[ПутьКФайлуКонсолиЗапросов]", ?(ПустаяСтрока(ПутьКФайлуКонсолиЗапросовНаСервере), "<ПутьКФайлуКонсолиЗапросов>", ПутьКФайлуКонсолиЗапросовНаСервере));				
	Иначе // 1 Объект конфигурации.
		СтрокаВызова = "Обработки.[ИмяОбработки].Создать().ОбработатьВнешнийЗапрос([Запрос])";
		СтрокаВызова = СтрЗаменить(СтрокаВызова, "[ИмяОбработки]", ?(ПустаяСтрока(ИмяОбработки), "<ИмяОбработки>", ИмяОбработки));				
	КонецЕсли; 
	
	СтрокаВызова = СтрЗаменить(СтрокаВызова, "[Запрос]", ?(ПустаяСтрока(НазваниеПеременнойЗапроса), "<ПеременнаяЗапроса>", НазваниеПеременнойЗапроса));				
	
	ПроверкаЗащитыОтОпасныхДействий();

КонецПроцедуры

&НаСервере
Процедура ПоместитьВХранилищеНаСервере(Адрес, ПутьКФайлуНаСервере, ИмяФайла)
	
	ПутьКФайлуНаСервере = КаталогВременныхФайлов() + ИмяФайла;
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	
	ДвоичныеДанные.Записать(ПутьКФайлуНаСервере);
	
КонецПроцедуры

&НаСервере
Функция ПроверкаЗащитыОтОпасныхДействий() Экспорт
	
	Результат = Новый Структура("ЕстьПроверка,ПроверкаВключена", Ложь, Неопределено);
	
	Свойства = Новый Структура("ЗащитаОтОпасныхДействий, UnsafeOperationProtection");
	ЗаполнитьЗначенияСвойств(Свойства, ПользователиИнформационнойБазы.ТекущийПользователь());

	ЗначениеНастройки = Неопределено;
	
	Если Свойства.ЗащитаОтОпасныхДействий <> Неопределено Тогда
	     ЗначениеНастройки = Свойства.ЗащитаОтОпасныхДействий;
		 Результат.ЕстьПроверка = Истина;
	ИначеЕсли Свойства.UnsafeOperationProtection <> Неопределено Тогда
	     ЗначениеНастройки = Свойства.UnsafeOperationProtection;
		 Результат.ЕстьПроверка = Истина;
	КонецЕсли; 
	
	Если Результат.ЕстьПроверка И ВариантВызоваКонсолиЗапросов = 0 Тогда
		Результат.ПроверкаВключена = ?(ЗначениеНастройки = Неопределено, Ложь, ЗначениеНастройки.ПредупреждатьОбОпасныхДействиях);
		Элементы.ГруппаПроверкаЗащиты.Видимость = Истина;
	Иначе
		Элементы.ГруппаПроверкаЗащиты.Видимость = Ложь;
	КонецЕсли; 
	
	Возврат Результат;
	
КонецФункции
