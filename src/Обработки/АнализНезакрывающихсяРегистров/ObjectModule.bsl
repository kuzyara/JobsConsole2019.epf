﻿Процедура Тест(ФормаОтработкиTDD) Экспорт
	Если Ложь Тогда ФормаОтработкиTDD = ПолучитьФорму("Форма"); КонецЕсли;
	//Маршрутный лист ОТСПБ002186 от 12.05.2018 23:59:00
	//Маршрутный лист ОТЯ00111662 от 29.01.2018 22:54:46
	
	//Заказ покупателя ОТАНН00005648 от 24.10.2014 18:32:38
	СсылкаНаОбъект = Документы.ЗаказПокупателя.НайтиПоНомеру("ОТАНН00005648", Дата(2014,10,24));
	
	ЭлементыФормы = ФормаОтработкиTDD.ЭлементыФормы;

	
	ТабДокумент = Печать(СсылкаНаОбъект);
	//ТестВывестиТабДокНаСтраницуПанели(1, ТабДокумент, ЭлементыФормы);
	
	//ТабДокумент = Печать("ЦенникА4");
	//ТестВывестиТабДокНаСтраницуПанели(2, ТабДокумент, ЭлементыФормы);
	//
	//ТабДокумент = Печать("ЦенникА5");
	//ТестВывестиТабДокНаСтраницуПанели(3, ТабДокумент, ЭлементыФормы);
	//
	//ТабДокумент = Печать("ЦенникПБС_9х4_5_перфорация");
	//ТестВывестиТабДокНаСтраницуПанели(4, ТабДокумент, ЭлементыФормы);
	//
	//ТабДокумент = Печать("Бедж_6х9");
	//ТестВывестиТабДокНаСтраницуПанели(5, ТабДокумент, ЭлементыФормы);
	
	//ДополнительныеПараметры.Вставить("ИмяМакета", "Этикетка_47_25");
	
КонецПроцедуры

Функция Печать(СсылкаНаОбъект) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТоварыВРезервеНаСкладах.Период КАК Период,
		|	ТоварыВРезервеНаСкладах.Регистратор КАК Регистратор,
		|	ТоварыВРезервеНаСкладах.НомерСтроки КАК НомерСтроки,
		|	ТоварыВРезервеНаСкладах.Активность КАК Активность,
		|	ТоварыВРезервеНаСкладах.ВидДвижения КАК ВидДвижения,
		|	ТоварыВРезервеНаСкладах.Склад КАК Склад,
		|	ТоварыВРезервеНаСкладах.Номенклатура КАК Номенклатура,
		|	ТоварыВРезервеНаСкладах.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
		|	ТоварыВРезервеНаСкладах.ДокументРезерва КАК ДокументРезерва,
		|	ТоварыВРезервеНаСкладах.СерияНоменклатуры КАК СерияНоменклатуры,
		|	ТоварыВРезервеНаСкладах.ID КАК ID,
		|	ТоварыВРезервеНаСкладах.Количество КАК Количество,
		|	ТоварыВРезервеНаСкладах.МоментВремени КАК МоментВремени
		|ИЗ
		|	РегистрНакопления.ТоварыВРезервеНаСкладах КАК ТоварыВРезервеНаСкладах
		|ГДЕ
		|	ТоварыВРезервеНаСкладах.ДокументРезерва = &ДокументРезерва";
	
	Запрос.УстановитьПараметр("ДокументРезерва", СсылкаНаОбъект);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ТаблицаДвижений = РезультатЗапроса.Выгрузить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТоварыВРезервеНаСкладахОстатки.Склад КАК Склад,
		|	ТоварыВРезервеНаСкладахОстатки.Номенклатура КАК Номенклатура,
		|	ТоварыВРезервеНаСкладахОстатки.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
		|	ТоварыВРезервеНаСкладахОстатки.ДокументРезерва КАК ДокументРезерва,
		|	ТоварыВРезервеНаСкладахОстатки.СерияНоменклатуры КАК СерияНоменклатуры,
		|	ТоварыВРезервеНаСкладахОстатки.ID КАК ID
		|ИЗ
		|	РегистрНакопления.ТоварыВРезервеНаСкладах.Остатки КАК ТоварыВРезервеНаСкладахОстатки
		|ГДЕ
		|	ТоварыВРезервеНаСкладахОстатки.ДокументРезерва = &ДокументРезерва";
	
	Запрос.УстановитьПараметр("ДокументРезерва", СсылкаНаОбъект);
	
	РезультатЗапроса = Запрос.Выполнить();

	ТаблицаОстатков = РезультатЗапроса.Выгрузить();
	
	
	// раскидаем на приход/расход
	ТЗПриход = ТаблицаДвижений.Скопировать(Новый Структура("ВидДвижения", ВидДвиженияНакопления.Приход));
	ТЗРасход = ТаблицаДвижений.Скопировать(Новый Структура("ВидДвижения", ВидДвиженияНакопления.Расход));
	
	//Форма = ЭтотОбъект.ПолучитьФорму("Форма");
	//ДеревоСопоставления=Форма.деревосопоставления;
	//Если Ложь Тогда ДеревоСопоставления = Новый ДеревоЗначений; КонецЕсли;
	
	// сопоставим по измерениям
	//Для Сч = 0 По ТаблицаОстатков.Колонки.Количество() Цикл
	//	КоличествоРазличий = Сч;
	//	НоваяСтрока = ДеревоСопоставления.Строки.Добавить();
	//	НоваяСтрока.Колонка1 = "Различий " + КоличествоРазличий;
	//	
	//	// 1 - остаток по должен выходить в 0
	//	
	//	
	//	
	//КонецЦикла;

	МассивИзмерений = Новый Массив;
	МассивИзмерений.Добавить("Склад");
	МассивИзмерений.Добавить("Номенклатура");
	МассивИзмерений.Добавить("ХарактеристикаНоменклатуры");
	МассивИзмерений.Добавить("ДокументРезерва");
	МассивИзмерений.Добавить("СерияНоменклатуры");
	МассивИзмерений.Добавить("ID");
		
	МассивНаборовИзмерений = СгенерироватьСочетанияРекурсивно(МассивИзмерений);
	//Для Сч1 = 0 По МассивИзмерений.Количество() - 1 Цикл
	//	Рез.Добавить(МассивИзмерений[Сч1]);
	//	Для Сч2 = 0 По МассивИзмерений.Количество() - 1 Цикл
	//		Если МассивИзмерений[Сч2] > МассивИзмерений[Сч1] Тогда
	//			Рез.Добавить(МассивИзмерений[Сч1] + МассивИзмерений[Сч2]);
	//			Для Сч3 = 0 По МассивИзмерений.Количество() - 1 Цикл
	//				Если МассивИзмерений[Сч3] > МассивИзмерений[Сч2] Тогда
	//					Рез.Добавить(МассивИзмерений[Сч1] + МассивИзмерений[Сч2]+МассивИзмерений[Сч3]);
	//				КонецЕсли;
	//			КонецЦикла;
	//		КонецЕсли;
	//	КонецЦикла;
	//КонецЦикла;
	ТЗ = Новый ТаблицаЗначений;
	Для Каждого Измерение Из МассивИзмерений Цикл
		ТЗ.Колонки.Добавить();
	КонецЦикла;
	Для Каждого НаборИзмерений Из МассивНаборовИзмерений Цикл
		НоваяСтрока = ТЗ.Добавить();
		Для Сч = 0 По НаборИзмерений.Количество() - 1 Цикл
			НоваяСтрока[Сч] = НаборИзмерений[Сч];
		КонецЦикла;
	КонецЦикла;
	
	
	МассивИзмерений = Новый Массив;
	МассивИзмерений.Добавить("Склад");
	МассивИзмерений.Добавить("Номенклатура");
	МассивИзмерений.Добавить("ХарактеристикаНоменклатуры");
	МассивИзмерений.Добавить("ДокументРезерва");
	МассивИзмерений.Добавить("СерияНоменклатуры");
	
	НаДату = Дата(2018, 11, 1);
	
	// найдем сворачиваемые
	// сгруппируем и посмотрим какие вывелись в 0
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТоварыВРезервеНаСкладахОстатки.Склад КАК Склад,
		|	ТоварыВРезервеНаСкладахОстатки.Номенклатура КАК Номенклатура,
		|	ТоварыВРезервеНаСкладахОстатки.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
		|	ТоварыВРезервеНаСкладахОстатки.ДокументРезерва КАК ДокументРезерва,
		|	ТоварыВРезервеНаСкладахОстатки.СерияНоменклатуры КАК СерияНоменклатуры,
		|	ТоварыВРезервеНаСкладахОстатки.ID КАК ID,
		|	ТоварыВРезервеНаСкладахОстатки.КоличествоОстаток КАК КоличествоОстаток
		|ПОМЕСТИТЬ втОстатки
		|ИЗ
		|	РегистрНакопления.ТоварыВРезервеНаСкладах.Остатки(, ДокументРезерва = &ДокументРезерва) КАК ТоварыВРезервеНаСкладахОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	втОстатки.Склад КАК Склад,
		|	втОстатки.Номенклатура КАК Номенклатура,
		|	втОстатки.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
		|	втОстатки.ДокументРезерва КАК ДокументРезерва,
		|	втОстатки.СерияНоменклатуры КАК СерияНоменклатуры,
		|	СУММА(втОстатки.КоличествоОстаток) КАК КоличествоОстаток
		|ПОМЕСТИТЬ вт
		|ИЗ
		|	втОстатки КАК втОстатки
		|
		|СГРУППИРОВАТЬ ПО
		|	втОстатки.Склад,
		|	втОстатки.ДокументРезерва,
		|	втОстатки.ХарактеристикаНоменклатуры,
		|	втОстатки.Номенклатура,
		|	втОстатки.СерияНоменклатуры
		|
		|ИМЕЮЩИЕ
		|	СУММА(втОстатки.КоличествоОстаток) = 0
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТоварыВРезервеНаСкладах.Период КАК Период,
		|	ТоварыВРезервеНаСкладах.Регистратор КАК Регистратор,
		|	ТоварыВРезервеНаСкладах.НомерСтроки КАК НомерСтроки,
		|	ТоварыВРезервеНаСкладах.Активность КАК Активность,
		|	ТоварыВРезервеНаСкладах.ВидДвижения КАК ВидДвижения,
		|	ТоварыВРезервеНаСкладах.Склад КАК Склад,
		|	ТоварыВРезервеНаСкладах.Номенклатура КАК Номенклатура,
		|	ТоварыВРезервеНаСкладах.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
		|	ТоварыВРезервеНаСкладах.ДокументРезерва КАК ДокументРезерва,
		|	ТоварыВРезервеНаСкладах.СерияНоменклатуры КАК СерияНоменклатуры,
		|	ТоварыВРезервеНаСкладах.ID КАК ID,
		|	ВЫБОР
		|		КОГДА ТоварыВРезервеНаСкладах.ВидДвижения = ЗНАЧЕНИЕ(виддвижениянакопления.приход)
		|			ТОГДА ТоварыВРезервеНаСкладах.Количество
		|		ИНАЧЕ -ТоварыВРезервеНаСкладах.Количество
		|	КОНЕЦ КАК Количество
		|ИЗ
		|	вт КАК вт
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыВРезервеНаСкладах КАК ТоварыВРезервеНаСкладах
		|		ПО вт.Склад = ТоварыВРезервеНаСкладах.Склад
		|			И вт.Номенклатура = ТоварыВРезервеНаСкладах.Номенклатура
		|			И вт.ХарактеристикаНоменклатуры = ТоварыВРезервеНаСкладах.ХарактеристикаНоменклатуры
		|			И вт.ДокументРезерва = ТоварыВРезервеНаСкладах.ДокументРезерва
		|			И вт.СерияНоменклатуры = ТоварыВРезервеНаСкладах.СерияНоменклатуры
		|
		|УПОРЯДОЧИТЬ ПО
		|	ДокументРезерва,
		|	Склад,
		|	Номенклатура,
		|	ХарактеристикаНоменклатуры,
		|	СерияНоменклатуры";
	
	Запрос.УстановитьПараметр("ДокументРезерва", СсылкаНаОбъект);
	Запрос.УстановитьПараметр("НаДату", НаДату);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	
	ТЗ = РезультатЗапроса.Выгрузить();
	//Для Каждого ТекКолонка Из РезультатЗапроса.Колонки Цикл
	//	ТЗ.Колонки.Добавить(ТекКолонка.Имя, ТекКолонка.ТипЗначения, ТекКолонка.Имя, ТекКолонка.Ширина);
	//КонецЦикла;

	//ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	//// загрузим в таблицу значений
	//Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	//	// Вставить обработку выборки ВыборкаДетальныеЗаписи
	//КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

	Возврат ТЗ;



КонецФункции

Функция СгенерироватьСочетанияРекурсивно(Знач МассивИзмерений, Результат = Неопределено, ТекИзмерение = "", ТекМассив = Неопределено)
	Если Результат = Неопределено Тогда
		Результат = Новый Массив;
		ТекМассив = Новый ФиксированныйМассив(Результат);
	КонецЕсли;
	
	Для Каждого Измерение Из МассивИзмерений Цикл
		Если Измерение > ТекИзмерение Тогда
			НовыйМассив = Новый Массив(ТекМассив);
			НовыйМассив.Добавить(Измерение);
			Результат.Добавить(НовыйМассив);

			СгенерироватьСочетанияРекурсивно(МассивИзмерений, Результат, Измерение, Новый ФиксированныйМассив(НовыйМассив));
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции
