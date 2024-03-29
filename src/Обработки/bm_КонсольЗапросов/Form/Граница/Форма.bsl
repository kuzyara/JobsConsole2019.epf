﻿
#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.ВидГраницы.РежимВыбораИзСписка = Истина;
	Элементы.ВидГраницы.СписокВыбора.Добавить("Дата включая");
	Элементы.ВидГраницы.СписокВыбора.Добавить("Дата исключая");
	Элементы.ВидГраницы.СписокВыбора.Добавить("Момент включая");
	Элементы.ВидГраницы.СписокВыбора.Добавить("Момент исключая");
	Элементы.ВидГраницы.КнопкаОчистки = Истина;
	
	Если Параметры.Свойство("ВидГраницы") Тогда 
		ЭтотОбъект.ВидГраницы = Параметры.ВидГраницы;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Команды

&НаКлиенте
Процедура ОК(Команда)
	
	ЭтотОбъект.Закрыть(ЭтотОбъект.ВидГраницы);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	ЭтотОбъект.Закрыть();
	
КонецПроцедуры

#КонецОбласти
