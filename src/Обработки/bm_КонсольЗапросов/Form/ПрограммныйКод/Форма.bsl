﻿
#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Код") Тогда
		ЭтотОбъект.ВидКода = Параметры.ВидКода;
		ЭтотОбъект.Код.УстановитьТекст(Параметры.Код);
	КонецЕсли;
	Если ПустаяСтрока(ЭтотОбъект.ВидКода) Тогда
		ЭтотОбъект.ВидКода = "Выражение";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Команды

&НаКлиенте
Процедура ОК(Команда)
	
	ПараметрЗакрытия = Новый Структура("ВидКода, Код", ЭтотОбъект.ВидКода, ЭтотОбъект.Код.ПолучитьТекст());
	ЭтотОбъект.Закрыть(ПараметрЗакрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	ЭтотОбъект.Закрыть();
	
КонецПроцедуры

#КонецОбласти
