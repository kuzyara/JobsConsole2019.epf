﻿
&НаКлиенте
Процедура ВывестиСтруктуруТаблиц(Команда)
	ВывестиСтруктуруТаблицНаСервере();
	ЭтаФорма.Заголовок = СтрШаблон("Кэш от %1", СохрДата);
КонецПроцедуры

&НаСервере
Процедура ВывестиСтруктуруТаблицНаСервере()
	
	МассивИменМетаданных = Новый Массив();
	
	// Если нужна структура таблиц только некоторых объектов конфигурации
	// их можно перечислить в массиве имен метаданных
	
	//МассивИменМетаданных.Добавить("Справочник.Номенклатура");
	//МассивИменМетаданных.Добавить("Документ.РеализацияТоваровУслуг");
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ТекстовыйДокумент = ОбработкаОбъект.ПолучитьСтруктуруТаблицНаСервере(МассивИменМетаданных);
	
	СохрТекст = ТекстовыйДокумент.ПолучитьТекст(); // сохраняется в данных формы автоматически
	СохрДата = ТекущаяДата();  // сохраняется в данных формы автоматически
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	Если ПустаяСтрока(СохрТекст) Тогда
		ВывестиСтруктуруТаблицНаСервере();
	Иначе
		ТекстовыйДокумент.УстановитьТекст(СохрТекст);
		ЭтаФорма.Заголовок = СтрШаблон("Кэш от %1", СохрДата);
	КонецЕсли;
	
	//ТекстовыйДокумент.Показать("Структура хранения базы данных");
КонецПроцедуры
