﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекстДок = ЛистингИзТекста(Параметры.Текст, Параметры.СписокПараметров);
	ТекстДок = ДобавитьТабуляцию(ТекстДок);
	
	ЭтотОбъект.Листинг.УстановитьТекст(ТекстДок.ПолучитьТекст());
	
КонецПроцедуры

&НаСервере
Функция ЛистингИзТекста(ТекстЗапроса, СписокПараметров)	
	
	ТекстДок = Новый ТекстовыйДокумент();
	ТекстДок.ДобавитьСтроку("Запрос = Новый Запрос();");
	ТекстДок.ДобавитьСтроку("Запрос.Текст =");
	
	ЧислоСтрок = СтрЧислоСтрок(ТекстЗапроса);
	Для Итер = 1 По ЧислоСтрок Цикл
		СтрокаЗапроса = СтрПолучитьСтроку(ТекстЗапроса, Итер);
		СтрокаЗапроса = СтрЗаменить(СтрокаЗапроса, """", """""");
		Префикс 	= ?(Итер = 1, """", "|");
		Постфикс 	= ?(Итер = ЧислоСтрок, """;", ""); 
		ТекстДок.ДобавитьСтроку(Префикс + СтрокаЗапроса + Постфикс);
	КонецЦикла;
	
	Если СписокПараметров.Количество() > 0 Тогда
		ТекстДок.ДобавитьСтроку("");
		ТекстДок.ДобавитьСтроку("");
		ПерваяСтрока = Истина;
		Для Каждого ИмяПараметра Из СписокПараметров Цикл
			СтрокаТекста = "Запрос.УстановитьПараметр(""" + ИмяПараметра + """, " + ");"; 
			ТекстДок.ДобавитьСтроку(СтрокаТекста);
		КонецЦикла;
	КонецЕсли;
	
	ТекстДок.ДобавитьСтроку("");
	ТекстДок.ДобавитьСтроку("");		
	ТекстДок.ДобавитьСтроку("РезультатЗапроса = Запрос.Выполнить();");
	ТекстДок.ДобавитьСтроку("");
	ТекстДок.ДобавитьСтроку("Выборка = РезультатЗапроса.Выбрать();");
	
	Возврат ТекстДок;
	
КонецФункции

&НаСервере
Функция ДобавитьТабуляцию(Источник)
	
	Приемник = Новый ТекстовыйДокумент();
	
	Для Итер = 1 По Источник.КоличествоСтрок() Цикл
		Приемник.ДобавитьСтроку(Символы.Таб + Источник.ПолучитьСтроку(Итер));
	КонецЦикла;
	
	Возврат Приемник;
	
КонецФункции