﻿
&НаСервере
Перем Дерево;

&НаКлиенте
Перем ТекСтрокаДерева;


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Отбор = Новый Структура("ИД, Название", Параметры.Параметр_ИД, Параметры.Параметр_Имя);
	ПутьКХранилищу = Параметры.ПутьКХранилищу;
	Хранилище = ПолучитьИзВременногоХранилища(ПутьКХранилищу);
	ТекПараметр = Хранилище.ТабПараметров.НайтиСтроки(Отбор)[0];
	
	// ++ tristarr1 Оптимизация открытия формы выбора типов.
	// Исходный код модифицирован и перемещён в процедуру СфоримироватьСтруктуруТипов() модуля объекта.
	Если НЕ Хранилище.Свойство("СтруктураТипов") Тогда
		ОбОбъект = РеквизитФормыВЗначение("Объект");
		СтруктураТипов = ОбОбъект.СфоримироватьСтруктуруТипов(); 
		Хранилище.Вставить("СтруктураТипов",СтруктураТипов);
	Иначе
		СтруктураТипов = Хранилище.СтруктураТипов;	
	КонецЕсли;
	
	Дерево = СтруктураТипов.ДеревоТипов.Скопировать();
	Таблица = СтруктураТипов.ТаблицаТипов.Скопировать();
	// -- tristarr1 Оптимизация открытия формы выбора типов.

	ЭтаФорма.СписокЗначений = ТекПараметр.ОграничениеТипов.СписокЗначений;
	Массив = Новый Массив;
	Если ТекПараметр.ОграничениеТипов.ОписаниеТипа = "ТаблицаЗначений" 
		ИЛИ ТекПараметр.ОграничениеТипов.ОписаниеТипа = Новый ОписаниеТипов("МоментВремени") 
		ИЛИ ТекПараметр.ОграничениеТипов.ОписаниеТипа = "Граница"
		ИЛИ ТекПараметр.ОграничениеТипов.ОписаниеТипа = Новый ОписаниеТипов("ВидДвиженияНакопления")
		ИЛИ ТекПараметр.ОграничениеТипов.ОписаниеТипа = Новый ОписаниеТипов("ВидСчета")
		ИЛИ ТекПараметр.ОграничениеТипов.ОписаниеТипа = Новый ОписаниеТипов("ВидДвиженияБухгалтерии")
		Тогда
		 пОписаниеТипа = Новый ОписаниеТипов(ТекПараметр.ОграничениеТипов.ОписаниеТипа);
		 ВидТипа = 1;
	Иначе
		 пОписаниеТипа = ТекПараметр.ОграничениеТипов.ОписаниеТипа;
	КонецЕсли; 
	УстановитьФлаги(Таблица, Дерево, пОписаниеТипа);
	
	ЗначениеВДанныеФормы(Дерево, ДеревоТипов);           
	ЗначениеВДанныеФормы(Таблица, ДополнительныетТипы);
	
	// ++ 08.09.2015 Доработка от tristarr1
	// ++ AKOR Замена флагов на переключатель
	//Вычисляемый = Параметры.Вычисляемый;
	//ТекстМодуля = ?(Вычисляемый,Параметры.Параметр_Значение,"");
	//Элементы.Группа1.Видимость = НЕ Параметры.Свойство("Редактирование");
	//////////Если Параметры.Вычисляемый Тогда
	Если ТекПараметр.Вычисляемый Тогда
		ВидТипа = 2;
	КонецЕсли; 
	//////////ТекстМодуля = ?(ВидТипа = 2, Параметры.Параметр_Значение, "");
	ТекстМодуля = ?(ВидТипа = 2, ТекПараметр.Значение, "");
	// -- AKOR Замена флагов на переключатель
	// -- 08.09.2015 Доработка от tristarr1
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьОтображение();
	РазвернутьДерево(ДеревоТипов);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьФлаги(Таблица, Дерево, ИсходноеОграничениеТипа)

        МассивИсходныхТипов = ИсходноеОграничениеТипа.Типы();
        КоличествоИсходныхТипов = МассивИсходныхТипов.Количество();
        тДополнительно = Ложь;
        
        Если КоличествоИсходныхТипов = 1 Тогда
            МассивДопТипов = Новый Массив;
            МассивДопТипов.Добавить("ТаблицаЗначений");
            МассивДопТипов.Добавить("МоментВремени");
            МассивДопТипов.Добавить("Граница");
            МассивДопТипов.Добавить("Массив");
            
            МассивДопТипов.Добавить("ВидДвиженияНакопления");
            МассивДопТипов.Добавить("ВидСчета");
            МассивДопТипов.Добавить("ВидДвиженияБухгалтерии");
            
            Для каждого Элемент Из МассивДопТипов Цикл
                Элемент = ?(Элемент = "Массив", "СписокЗначений", Элемент);
                Если МассивИсходныхТипов[0] = Тип(Элемент) Тогда
                    Дополнительно = Истина;
                    СтрокаТипа = Таблица.Найти(Элемент, "ИмяТипа");
                    СтрокаТипа.Выбрать = Истина;
                    Дополнительно = Истина;
                    тДополнительно = Истина;
                    Прервать;
                КонецЕсли;
            КонецЦикла; 
        КонецЕсли;
        
        Если НЕ тДополнительно И НЕ КоличествоИсходныхТипов = 0 Тогда
            СоставнойТип = КоличествоИсходныхТипов > 1;

			Для каждого Опись Из МассивИсходныхТипов Цикл
				Если Опись = Тип("Число") Тогда
					Строка = Дерево.Строки.Найти("Число", "Синоним");
					Строка.Выбрать = Истина;
				ИначеЕсли Опись = Тип("Строка") Тогда
					Строка = Дерево.Строки.Найти("Строка", "Синоним");
					Строка.Выбрать = Истина;
				ИначеЕсли Опись = Тип("Дата") Тогда
					Строка = Дерево.Строки.Найти("Дата", "Синоним");
					Строка.Выбрать = Истина;
				ИначеЕсли Опись = Тип("Булево") Тогда
					Строка = Дерево.Строки.Найти("Булево", "Синоним");
					Строка.Выбрать = Истина;
				ИначеЕсли Опись = Тип("УникальныйИдентификатор") Тогда
					Строка = Дерево.Строки.Найти("Уникальный идентификатор", "Синоним");
					Строка.Выбрать = Истина;
				ИначеЕсли Опись = Тип("Null") Тогда
					Строка = Дерево.Строки.Найти("Null", "Синоним");
					Строка.Выбрать = Истина;
				ИначеЕсли Опись = Тип("Неопределено") Тогда
					Строка = Дерево.Строки.Найти("Неопределено", "Синоним");
					Строка.Выбрать = Истина;
				Иначе
					ПолноеИмя = Метаданные.НайтиПоТипу(Опись).ПолноеИмя();
					Точка = Найти(ПолноеИмя, ".");
					Если Точка > 0 Тогда
						ИмяКоллекции = Лев(ПолноеИмя, Точка - 1) + "Ссылка";
						ИмяОбъекта = Сред(ПолноеИмя, Точка + 1);
						Ветка = Дерево.Строки.Найти(ИмяКоллекции, "Синоним");
						Строка = Ветка.Строки.Найти(ИмяОбъекта, "ИмяТипа");
						Строка.Выбрать = Истина;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла; 
		Иначе
			Строка = Дерево.Строки.Найти("Неопределено", "Синоним");
			Строка.Выбрать = Истина;
		КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьДерево(Ветка)
	
	//Развернуть дерево 
	Для Каждого Строка Из Ветка.ПолучитьЭлементы() Цикл
		Если Строка.Выбрать И ТипЗнч(Ветка) = Тип("ДанныеФормыЭлементДерева") Тогда
			ИдентификаторСтроки = Ветка.ПолучитьИдентификатор();
			Элементы.ДеревоТипов.Развернуть(ИдентификаторСтроки);
			ТекСтрокаДерева = Строка;
		КонецЕсли;
		Если Строка.Выбрать Тогда
			ТекСтрокаДерева = Строка.ПолучитьИдентификатор();
		КонецЕсли;
		РазвернутьДерево(Строка);
	КонецЦикла;
	
КонецПроцедуры

// ++ tristarr1 Оптимизация открытия формы выбора типов.
//Процедуры перемещены в модуль объекта.
//Функция ВывестиКоллекцию(КонтейнерСтрок, ИмяКоллекции = "", ИмяЭлемента = "")
//Функция ЗаполнитьСтрокуДерева(КонтейнерСтрок, ИмяТипа = "", Синоним = "", Картинка = Неопределено)
//Процедура ЗаполнитьСтрокуТаблицы(КонтейнерСтрок, ИмяТипа = "", Синоним = "", Картинка = Неопределено)
// -- tristarr1 Оптимизация открытия формы выбора типов.

&НаКлиенте
Процедура ОбновитьОтображение()

	Элементы.ГруппаФлаги.Видимость          = ВидТипа = 0;
	Элементы.ДеревоТипов.Видимость          = ВидТипа = 0;
	Элементы.ДополнительныетТипы.Видимость  = ВидТипа = 1;
	Элементы.ТекстМодуля.Видимость          = ВидТипа = 2;
	Элементы.ГруппаРедактирование.Видимость = ВидТипа = 2;

	Если ВидТипа = 2 И ТекстМодуля = "" Тогда
		
		ТекстМодуля = 
		"	 
		|//Параметр = Истина;
		|//Параметр = Неопределено;
		|//Параметр = NULL;
		|//
		|//Запрос = Новый Запрос;
		|//
		|//Запрос.Текст = ""
		|//|ВЫБРАТЬ
		|//|	Хозрасчетный.Ссылка
		|//|ИЗ
		|//|	ПланСчетов.Хозрасчетный КАК Хозрасчетный
		|//|ГДЕ
		|//|	Хозрасчетный.Ссылка В ИЕРАРХИИ(ЗНАЧЕНИЕ())
		|//|	И НЕ Хозрасчетный.ПометкаУдаления
		|//|	И Хозрасчетный.Вид = &Вид"";
		|//
		|//Выгрузка = Запрос.Выполнить().Выгрузить();
		|//
		|//Параметр = Выгрузка.ВыгрузитьКолонку(""Ссылка"");
		|";
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВидТипаПриИзменении(Элемент)
	
	ОбновитьОтображение();	
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	ОписатьТип();
	// ++ 08.09.2015 Доработка от tristarr1
	// ++ AKOR Замена флагов на переключатель
	//Закрыть(Новый Структура("ОписаниеТипа, СписокЗначений", ОписаниеТипа, СписокЗначений));
	//Закрыть(Новый Структура("ОписаниеТипа, СписокЗначений, ТекстМодуля", ОписаниеТипа, СписокЗначений, ?(Вычисляемый,ТекстМодуля,"")));
	Закрыть(Новый Структура("ОписаниеТипа, СписокЗначений, ТекстМодуля, ЗначениеДляКлиента", ОписаниеТипа, СписокЗначений, ?(ВидТипа = 2,ТекстМодуля,""), ЗначениеДляКлиента));
	// -- AKOR Замена флагов на переключатель
	// -- 08.09.2015 Доработка от tristarr1
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

&НаСервере
Процедура ОписатьТип()
	
	ИмяДопТипа = "Неопределено";
	
	Если ВидТипа = 1 Тогда // Дополнительно
		//СписокЗначений = Ложь;
		Таблица = ДанныеФормыВЗначение(ДополнительныетТипы, Тип("ТаблицаЗначений"));
		НайденнаяСтрока =  Таблица.Найти(Истина, "Выбрать");
		
		
		Если НайденнаяСтрока = Неопределено Тогда
			ОписаниеТипа = Новый ОписаниеТипов("Неопределено");
        Иначе
			ИмяДопТипа = НайденнаяСтрока.ИмяТипа;
            Если НайденнаяСтрока.ИмяТипа = "ТаблицаЗначений" Тогда
                ОписаниеТипа = ИмяДопТипа;
            ИначеЕсли НайденнаяСтрока.ИмяТипа = "Граница" Тогда	
                ОписаниеТипа = ИмяДопТипа;
            Иначе	
                ОписаниеТипа = Новый ОписаниеТипов(ИмяДопТипа);
            КонецЕсли; 
		КонецЕсли;
		
		ЗначениеВДанныеФормы(Таблица, ДополнительныетТипы);
	// ++ 08.09.2015 Доработка от tristarr1
	// ++ AKOR Замена флагов на переключатель
	//ИначеЕсли Вычисляемый Тогда
	ИначеЕсли ВидТипа = 2 Тогда // Вычисляемый
	// -- AKOR Замена флагов на переключатель
		ОписаниеТипа = Новый ОписаниеТипов("Строка");		
	// -- 08.09.2015 Доработка от tristarr1
	Иначе
		Дерево = ДанныеФормыВЗначение(ДеревоТипов, Тип("ДеревоЗначений"));
		
		Массив = Новый Массив;
		ОбойтиДеревоТиповРекурсивно(Дерево.Строки, Массив);
		
		МассивТипов = Новый Массив;
		ОписаниеТипа = Новый ОписаниеТипов();
		
		Для каждого Элемент Из Массив Цикл
			Если Элемент = "КонстантаСсылка" Тогда
				//
			ИначеЕсли Элемент = "Уникальный идентификатор" Тогда
				МассивДляУИ = Новый Массив;
				МассивДляУИ.Добавить(Тип("УникальныйИдентификатор"));
				ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, МассивДляУИ);
			ИначеЕсли Элемент = "СправочникСсылка" Тогда
				Т = Новый ОписаниеТипов(Справочники.ТипВсеСсылки());
				ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, Т.Типы());
			ИначеЕсли Элемент = "ДокументСсылка" Тогда
				Т = Новый ОписаниеТипов(Документы.ТипВсеСсылки());
				ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, Т.Типы());
			ИначеЕсли Элемент = "Дата" Тогда
				ОписаниеТипа = Новый ОписаниеТипов("Дата",,,,, Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя));
			Иначе
				ОписаниеТипа = Новый ОписаниеТипов(ОписаниеТипа, Элемент);
			КонецЕсли; 
			
		КонецЦикла;
		
		ЗначениеВДанныеФормы(Дерево, ДеревоТипов);           
	КонецЕсли;
	
	// ++ 08.09.2015 Доработка от tristarr1
	// ++ AKOR Замена флагов на переключатель
	//Если НЕ Вычисляемый Тогда ТекстМодуля = "" КонецЕсли;
	Если НЕ ВидТипа = 2 Тогда ТекстМодуля = "" КонецЕсли;
	// -- AKOR Замена флагов на переключатель
	// -- 08.09.2015 Доработка от tristarr1
	
	ПоместитьТипВХранилище(ИмяДопТипа);
	
КонецПроцедуры 

&НаСервере
Процедура ПоместитьТипВХранилище(ИмяДопТипа  = "")
	
	Отбор = Новый Структура("ИД, Название", Параметры.Параметр_ИД, Параметры.Параметр_Имя);
	ПутьКХранилищу = Параметры.ПутьКХранилищу;
	Хранилище = ПолучитьИзВременногоХранилища(ПутьКХранилищу);
	ТаблПарам = Хранилище.ТабПараметров;
	ТекПараметр = ТаблПарам.НайтиСтроки(Отбор)[0];
	
	ТекПараметр.Вычисляемый = ВидТипа = 2;
	ТекПараметр.ОграничениеТипов.Вставить("ОписаниеТипа", ОписаниеТипа);
	ТекПараметр.ОграничениеТипов.Вставить("СписокЗначений", ?(ВидТипа = 0, СписокЗначений, Ложь));
	ТекПараметр.ОграничениеТипов.Вставить("ТекстМодуля", ТекстМодуля);
	
	// Привести значение к типу.
	Если ВидТипа = 0 Тогда
		Если ТипЗнч(ТекПараметр.Значение) = Тип("СписокЗначений") ИЛИ ТекПараметр.ОграничениеТипов.СписокЗначений Тогда
			ПривестиЗначениеКТипу(ТекПараметр.Значение, ТекПараметр.ОграничениеТипов, ТекПараметр.Значение);
		Иначе
			ТекПараметр.Значение = ОписаниеТипа.ПривестиЗначение(ТекПараметр.Значение);
		КонецЕсли;
	ИначеЕсли ВидТипа = 1 Тогда
		ОписаниеДопТипа = Новый ОписаниеТипов(ИмяДопТипа);
		ТекПараметр.Значение = ОписаниеДопТипа.ПривестиЗначение(ТекПараметр.Значение);
	ИначеЕсли ВидТипа = 2 Тогда
		ТекПараметр.Значение = ТекстМодуля;
	КонецЕсли;
	
	ЗначениеДляКлиента = ПолучитьЗначениеДляКлиента(ТекПараметр.Значение);
	
	Хранилище.Вставить("ТабПараметров", ТаблПарам);
	ПоместитьВоВременноеХранилище(Хранилище, ПутьКХранилищу);

КонецПроцедуры 

&НаСервере
Процедура ОбойтиДеревоТиповРекурсивно(Строки, Массив)

	Для каждого Строка Из Строки Цикл
		 Если Строка.Выбрать Тогда
		 	  Массив.Добавить(Строка.Синоним);
		 КонецЕсли;
		 ОбойтиДеревоТиповРекурсивно(Строка.Строки, Массив);
	КонецЦикла; 

КонецПроцедуры 

&НаКлиенте
Процедура ДополнительныетТипыВыбратьПриИзменении(Элемент)
    
    Идентификатор = Элементы.ДополнительныетТипы.ТекущиеДанные.ПолучитьИдентификатор();
    Для каждого Строка Из ДополнительныетТипы Цикл
    	 Строка.Выбрать = Идентификатор = Строка.ПолучитьИдентификатор();
    КонецЦикла;
    
КонецПроцедуры

&НаКлиенте
Процедура ДеревоТиповВыбратьПриИзменении(Элемент)
	
	ТекСтрокаДерева = Элементы.ДеревоТипов.ТекущаяСтрока;
	
	Если НЕ СоставнойТип Тогда

		УбратьФлажкиВДеревеТипов();
		ДеревоТипов.НайтиПоИдентификатору(ТекСтрокаДерева).Выбрать = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УбратьФлажкиВДеревеТипов(Дерево = Неопределено)
	
	Если Дерево = Неопределено Тогда
		Итератор = ДеревоТипов.ПолучитьЭлементы();
	Иначе
		Итератор = Дерево.ПолучитьЭлементы();
	КонецЕсли;
	
	Для каждого Строка Из Итератор Цикл
		Строка.Выбрать = Ложь;
		УбратьФлажкиВДеревеТипов(Строка);
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьКомментарий(Команда)

	Текст = ТекстМодуля;
    
    НачалоСтроки = 0; НачалоКолонки = 0; КонецСтроки = 0; КонецКолонки = 0;
	Элементы.ТекстМодуля.ПолучитьГраницыВыделения(НачалоСтроки, НачалоКолонки, КонецСтроки, КонецКолонки);
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.УстановитьТекст(Текст);
	
	ПоследняяСтрока = ТекстовыйДокумент.ПолучитьСтроку(КонецСтроки);
	ВыделеноСимволовНаПоследнейСтроке = СтрДлина(Лев(ПоследняяСтрока, КонецКолонки - 1));
	ЗакомментироватьПоследнююСтроку = Истина;
	
	Если (НачалоСтроки <> КонецСтроки) И ВыделеноСимволовНаПоследнейСтроке = 0 Тогда
		ЗакомментироватьПоследнююСтроку = Ложь;
	КонецЕсли;
    
    МаксимальныйОтступ = 0;
    МинимальныйОтступ = 0;
	
	Для i = НачалоСтроки По КонецСтроки Цикл
        Строка = ТекстовыйДокумент.ПолучитьСтроку(i);
        Строка = СтрЗаменить(Строка, "  ", "    ");
        СимволовСлева = Найти(Строка, СокрЛП(Строка));
        МаксимальныйОтступ = Макс(СимволовСлева, МаксимальныйОтступ);
        МинимальныйОтступ = ?(МинимальныйОтступ = 0, МаксимальныйОтступ, МинимальныйОтступ);
        МинимальныйОтступ  = Мин(МаксимальныйОтступ, МинимальныйОтступ );
    КонецЦикла;
    
    ТексДляВыделения = "";
	КонСтроки = ?(ЗакомментироватьПоследнююСтроку, КонецСтроки, КонецСтроки - 1); 
	
	Для i = НачалоСтроки По КонСтроки Цикл
        Строка = ТекстовыйДокумент.ПолучитьСтроку(i);
        Строка = СтрЗаменить(Строка, "  ", "    ");
        Строка = Лев(Строка, МинимальныйОтступ-1) + "//" + Сред(Строка, МинимальныйОтступ);
        ТекстовыйДокумент.ЗаменитьСтроку(i, Строка);
        ТексДляВыделения = ТексДляВыделения + Символы.ПС + Строка;
    КонецЦикла;
    
    НовыйТекст = ТекстовыйДокумент.ПолучитьТекст();
    ТекстМодуля = НовыйТекст;
    
	ЭтаФорма.ТекущийЭлемент = Элементы.ТекстМодуля;
	ЭтаФорма.ОбновитьОтображениеДанных();    
	Элементы.ТекстМодуля.УстановитьГраницыВыделения(НачалоСтроки, 1, КонецСтроки + ?(ЗакомментироватьПоследнююСтроку, 1, 0), 1); 

КонецПроцедуры

&НаКлиенте
Процедура УдалитьКомментарий(Команда)

	Текст = ТекстМодуля;
    
    НачалоСтроки = 0; НачалоКолонки = 0; КонецСтроки = 0; КонецКолонки = 0;
    Элементы.ТекстМодуля.ПолучитьГраницыВыделения(НачалоСтроки, НачалоКолонки, КонецСтроки, КонецКолонки);		
    
    ТекстовыйДокумент = Новый ТекстовыйДокумент;
    ТекстовыйДокумент.УстановитьТекст(Текст);
	
	ПоследняяСтрока = ТекстовыйДокумент.ПолучитьСтроку(КонецСтроки);
	ВыделеноСимволовНаПоследнейСтроке = СтрДлина(Лев(ПоследняяСтрока, КонецКолонки - 1));
	ЗакомментироватьПоследнююСтроку = Истина;
	
	Если (НачалоСтроки <> КонецСтроки) И ВыделеноСимволовНаПоследнейСтроке = 0 Тогда
		ЗакомментироватьПоследнююСтроку = Ложь;
	КонецЕсли;
    
	КонСтроки = ?(ЗакомментироватьПоследнююСтроку, КонецСтроки, КонецСтроки - 1); 
	
	Для i = НачалоСтроки По КонСтроки Цикл
        Строка = ТекстовыйДокумент.ПолучитьСтроку(i);
        Вхождение = Найти(Строка, "//");
        Если Вхождение > 0 Тогда
            Строка = Лев(Строка, Вхождение-1) + Сред(Строка, Вхождение + 2);
        КонецЕсли; 
        ТекстовыйДокумент.ЗаменитьСтроку(i, Строка);
    КонецЦикла;
    
    ТекстМодуля = ТекстовыйДокумент.ПолучитьТекст();
	ЭтаФорма.ТекущийЭлемент = Элементы.ТекстМодуля;
	ЭтаФорма.ОбновитьОтображениеДанных();    
	Элементы.ТекстМодуля.УстановитьГраницыВыделения(НачалоСтроки, 1, КонецСтроки + ?(ЗакомментироватьПоследнююСтроку, 1, 0), 1);

КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТекстМодуля(Команда)
	
	ТекстМодуля = "";
	
КонецПроцедуры

&НаКлиенте
Процедура СоставнойТипПриИзменении(Элемент)
	
	Если НЕ СоставнойТип Тогда

		УбратьФлажкиВДеревеТипов();
		ДеревоТипов.НайтиПоИдентификатору(ТекСтрокаДерева).Выбрать = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПривестиЗначениеКТипу(ИсходноеЗначение, ОписаниеВыбранныхТипов, НовоеЗначение)
	
	ИсходныйТипСписокЗначений = ТипЗнч(ИсходноеЗначение) = Тип("СписокЗначений");
	ИсходныйТип = ?(ИсходныйТипСписокЗначений, ИсходноеЗначение.ТипЗначения, ТипЗнч(ИсходноеЗначение));
	
	ПривестиКСпискуЗначений = ОписаниеВыбранныхТипов.СписокЗначений;
	НовыйТип = ОписаниеВыбранныхТипов.ОписаниеТипа;
	
	ЭлементыИсходногоЗначения = Новый Массив;
	Если ИсходныйТипСписокЗначений Тогда
		Для каждого Эл Из ИсходноеЗначение Цикл
			ЭлементыИсходногоЗначения.Добавить(Эл.Значение);
		КонецЦикла;
	Иначе
		ЭлементыИсходногоЗначения.Добавить(ИсходноеЗначение);
	КонецЕсли;
	
	Если ПривестиКСпискуЗначений Тогда
		НовоеЗначение = Новый СписокЗначений;
		НовоеЗначение.ТипЗначения = НовыйТип;
		Для каждого ЭлИсхЗнач Из ЭлементыИсходногоЗначения Цикл
			Если НовыйТип.СодержитТип(ТипЗнч(ЭлИсхЗнач)) Тогда
				НовоеЗначение.Добавить(ЭлИсхЗнач);
			КонецЕсли; 
		КонецЦикла; 
	Иначе
		Для каждого ЭлИсхЗнач Из ЭлементыИсходногоЗначения Цикл
			Если НовыйТип.СодержитТип(ТипЗнч(ЭлИсхЗнач)) Тогда
				НовоеЗначение = ЭлИсхЗнач;
				Прервать;
			КонецЕсли; 
		КонецЦикла; 
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция ПолучитьЗначениеДляКлиента(ИсходноеЗначение)
	
	Если ТипЗнч(ИсходноеЗначение) = Тип("Неопределено") Тогда
		Возврат "Неопределено";
	ИначеЕсли ТипЗнч(ИсходноеЗначение) = Тип("Null") Тогда
		Возврат "Null";
	ИначеЕсли ТипЗнч(ИсходноеЗначение) = Тип("ТаблицаЗначений") Тогда
		Возврат "ТаблицаЗначений";
	ИначеЕсли ТипЗнч(ИсходноеЗначение) = Тип("Граница") Тогда
		Возврат "Включая:01.01.0001 0:00:00";
	Иначе	
		Возврат ИсходноеЗначение;
	КонецЕсли;
КонецФункции

