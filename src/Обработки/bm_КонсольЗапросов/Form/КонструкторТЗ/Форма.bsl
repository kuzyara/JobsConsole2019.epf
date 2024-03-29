﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не ПустаяСтрока(Параметры.Адрес) Тогда
		ЗагрузитьДанныеИзВременногоХранилища(Параметры.Адрес);
	КонецЕсли;
	
	Элементы.КолонкиОбновитьТаблицу.Видимость = (Элементы.Таблица.ПодчиненныеЭлементы.Количество() = 0);
	
	Элементы.КолонкиТипЗначения.РежимРедактирования = РежимРедактированияКолонки.Непосредственно;
	
КонецПроцедуры

&НаКлиенте
Процедура ГруппаСтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	Если Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаТаблица
		И ЭтотОбъект.ФлагИзмененияКолонок Тогда
		ОбновитьТаблицуНаКлиенте();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КолонкиПриИзменении(Элемент)
	
	ЭтотОбъект.ФлагИзмененияКолонок = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура КолонкиПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	ТекДанные = Элементы.Колонки.ТекущиеДанные;
	
	Если НоваяСтрока Тогда
		ТекДанные.ТипЗначения = Новый ОписаниеТипов();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КолонкиПослеУдаления(Элемент)
	
	Если ЭтотОбъект.Колонки.Количество() = 0 Тогда
		Элементы.КолонкиОбновитьТаблицу.Видимость = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТипЗначенияПриИзменении(Элемент)
	
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТипЗначенияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекДанные = Элементы.Колонки.ТекущиеДанные;
	ПараметрыОткрытия = Новый Структура("ПодборТипа, БыстрыйВыбор, ТипЗначения", Ложь, Истина, ТекДанные.ТипЗначения);
	ОткрытьФорму(ИмяФормыОбработки("ВыборТипаЗначения"), ПараметрыОткрытия, Элемент, ЭтотОбъект.УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура КолонкиТипЗначенияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекДанные = Элементы.Колонки.ТекущиеДанные;
	ТекДанные.ТипЗначения 	= ВыбранноеЗначение;
	
	ЭтотОбъект.ФлагИзмененияКолонок = Истина;
	ЭтотОбъект.Модифицированность 	= Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	Отказ = Ложь;
	
	Если ЭтотОбъект.ФлагИзмененияКолонок Тогда
		ОбновитьТаблицуНаКлиенте(Отказ);
	КонецЕсли;
	
	Если Не Отказ Тогда
		ОповеститьОВыборе(ПоместитьДанныеВоВременноеХранилище());
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УказатьАдрес(Команда)
	
	Описание = Новый ОписаниеТипов("Строка");
	Значение = Описание.ПривестиЗначение();
	
	Оповещение = Новый ОписаниеОповещения("УказатьАдрес_Завершение", ЭтотОбъект, Новый Структура());
	
	ПоказатьВводЗначения(Оповещение, Значение); 
	
КонецПроцедуры

&НаКлиенте
Процедура УказатьАдрес_Завершение(Значение, ДополнительныеПараметры) Экспорт
	
	Если Значение = Неопределено Или ПустаяСтрока(Значение) Тогда
		Возврат; 
	КонецЕсли;
	
	ЭтотОбъект.Колонки.Очистить();
	УдалитьСтарыеРеквизиты();
	ЗагрузитьДанныеИзВременногоХранилища(Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьТаблицу(Команда)
	
	ОбновитьТаблицуНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьТаблицуНаКлиенте(Отказ = Ложь)
	
	Попытка
		ОбновитьТаблицуНаСервере();
		ЭтотОбъект.ФлагИзмененияКолонок = Ложь;
	Исключение
		Отказ = Истина;
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаКолонки;
		ТекстСообщения = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
    	ПоказатьПредупреждение(, ТекстСообщения);
	КонецПопытки;
	
	Элементы.КолонкиОбновитьТаблицу.Видимость = (Элементы.Таблица.ПодчиненныеЭлементы.Количество() = 0);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьТаблицуНаСервере()
	
	Попытка
		ПроверитьСозданиеТЗ();	
	Исключение
		ВызватьИсключение;
	КонецПопытки;
	
	СтараяТЗ = ЭтотОбъект.Таблица.Выгрузить();
	ЭтотОбъект.Таблица.Очистить();
	
	УдалитьСтарыеРеквизиты();
	СоздатьНовыеРеквизиты();
	
	Если СтараяТЗ.Количество() > 0 Тогда
   		ЗагрузитьНовуюТЗИзСтарой(СтараяТЗ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьСозданиеТЗ()
	
	ТЗ = Новый ТаблицаЗначений();
	
	Для Каждого Колонка Из ЭтотОбъект.Колонки Цикл
		Если ПустаяСтрока(Колонка.Имя) Тогда
			ВызватьИсключение "Пустое имя колонки";
		КонецЕсли;
		ТЗ.Колонки.Добавить(Колонка.Имя, Колонка.ТипЗначения);
	КонецЦикла;	
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьНовуюТЗИзСтарой(Источник)
	
	Приемник = ЭтотОбъект.Таблица.Выгрузить();
	МассивИменКолонок = Новый Массив();
	Для Каждого КолонкаИсточника Из Источник.Колонки Цикл
		НоваяКолонка = Приемник.Колонки.Найти(КолонкаИсточника.Имя);
		Если НоваяКолонка <> Неопределено Тогда
			МассивИменКолонок.Добавить(КолонкаИсточника.Имя);
		КонецЕсли;
	КонецЦикла;
	Если МассивИменКолонок.Количество() > 0 Тогда
		СписокСвойств = "";
		Для Каждого ИмяКолонки Из МассивИменКолонок Цикл
			СписокСвойств = СписокСвойств + ?(ПустаяСтрока(СписокСвойств), ИмяКолонки, "," + ИмяКолонки);
		КонецЦикла;
		Для Каждого Стр Из Источник Цикл
			НовСтр = Приемник.Добавить();
			Для Каждого ИмяКолонки Из МассивИменКолонок Цикл
				Значение = Приемник.Колонки[ИмяКолонки].ТипЗначения.ПривестиЗначение(Стр[ИмяКолонки]);
				НовСтр[ИмяКолонки] = Значение;
			КонецЦикла;
		КонецЦикла;
		ЭтотОбъект.Таблица.Загрузить(Приемник);
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура УдалитьСтарыеРеквизиты()
	
	РеквизитФормы 	= РеквизитФормыВЗначение("Таблица");
	КолонкиТЗ 		= РеквизитФормы.Колонки;
	
	МассивРеквизитов = Новый Массив();	
	Для Каждого Колонка Из КолонкиТЗ Цикл
		МассивРеквизитов.Добавить("Таблица." + Колонка.Имя);
	КонецЦикла;
	ЭтаФорма.ИзменитьРеквизиты(, МассивРеквизитов);
	
	Для Каждого Колонка Из КолонкиТЗ Цикл
		Элементы.Удалить(Элементы["Таблица" + Колонка.Имя]);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьНовыеРеквизиты()
	
	МассивРеквизитов = Новый Массив();
	Для Каждого Колонка Из ЭтаФорма.Колонки Цикл
		МассивРеквизитов.Добавить(Новый РеквизитФормы(Колонка.Имя, Колонка.ТипЗначения, "Таблица", Колонка.Имя));
	КонецЦикла;
	ЭтаФорма.ИзменитьРеквизиты(МассивРеквизитов);
	
	Для Каждого Колонка Из ЭтотОбъект.Колонки Цикл
		ПолеФормы = Элементы.Добавить("Таблица" + Колонка.Имя, Тип("ПолеФормы"), Элементы.Таблица);
		ПолеФормы.ПутьКДанным = "Таблица." + Колонка.Имя;
		ПолеФормы.Вид = ВидПоляФормы.ПолеВвода;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьДанныеИзВременногоХранилища(Адрес)
	
	ТЗ = ПолучитьИзВременногоХранилища(Адрес);
	
	Для Каждого Колонка Из ТЗ.Колонки Цикл
		НовСтр = ЭтотОбъект.Колонки.Добавить();
		НовСтр.Имя = Колонка.Имя;
		НовСтр.ТипЗначения = Колонка.ТипЗначения;
	КонецЦикла;
	
	СоздатьНовыеРеквизиты();
	
	ЭтотОбъект.Таблица.Загрузить(ТЗ);
	
КонецПроцедуры

&НаСервере
Функция ПоместитьДанныеВоВременноеХранилище()
		
	Возврат ПоместитьВоВременноеХранилище(ЭтотОбъект.Таблица.Выгрузить());
	
КонецФункции

&НаКлиенте
Функция ИмяФормыОбработки(Имя)
	
	ТипМетаданных = ?(СтрНачинаетсяС(ЭтотОбъект.ИмяФормы, "ВнешняяОбработка"), "ВнешняяОбработка", "Обработка");
	Возврат ТипМетаданных + ".bm_КонсольЗапросов.Форма." + Имя;
	
КонецФункции















