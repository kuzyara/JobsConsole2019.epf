﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбъектОбработки = РеквизитФормыВЗначение("Объект");
	Список = ОбъектОбработки.СписокВТ();
	
	Для Каждого Имя Из Список Цикл
		НовСтр = ЭтотОбъект.СписокВТ.Добавить();
		НовСтр.Имя = Имя;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВТВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекДанные = Элементы.СписокВТ.ТекущиеДанные;
	ОповеститьОВыборе(ТекДанные.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	ТекДанные = Элементы.СписокВТ.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОповеститьОВыборе(ТекДанные.Имя);
	
КонецПроцедуры


