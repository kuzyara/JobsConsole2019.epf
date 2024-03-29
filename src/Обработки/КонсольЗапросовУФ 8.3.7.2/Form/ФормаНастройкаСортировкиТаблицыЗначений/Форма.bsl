﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Для каждого Элемент Из Параметры.ОписаниеКолонок Цикл
	
		НоваяСтрока = НастройкаСортировки.Добавить();
		НоваяСтрока.Колонка = Элемент.Имя;
	
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура Ок(Команда)
	
	СтрокаСортировки = "";
	
	Для каждого Элемент Из НастройкаСортировки Цикл
		
		Если Элемент.НаправлениеСортировки = "Возр" Тогда
			СортирвкаПоКолонке = Элемент.Колонка + " Возр";
		ИначеЕсли Элемент.НаправлениеСортировки = "Убыв" Тогда
			СортирвкаПоКолонке = Элемент.Колонка + " Убыв";
		Иначе
			СортирвкаПоКолонке = "";
		КонецЕсли; 
		
		Если НЕ СортирвкаПоКолонке = "" Тогда
			
			СтрокаСортировки = СтрокаСортировки + ?(СтрокаСортировки = "", "", ",") + СортирвкаПоКолонке;
			
		КонецЕсли; 
		
	КонецЦикла; 
	
	Закрыть(СтрокаСортировки);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры
