﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Состояние("Сбор информации дерева метаданных...");
	Объект.ТипДанных = "Документ";
	ПоказатьПодписки();
КонецПроцедуры

&НаСервере
Процедура ПоказатьПодписки()
	РеквизитФормыВЗначение("Объект").ВывестиПодписки(ТабДок, Элементы.ТипДанных.СписокВыбора);
КонецПроцедуры

&НаКлиенте
Процедура ТипДанныхПриИзменении(Элемент)
	ПоказатьПодписки()
КонецПроцедуры


&НаСервере
Процедура ОбновитьНаСервере()
	РеквизитФормыВЗначение("Объект").ВывестиПодписки(ТабДок, Элементы.ТипДанных.СписокВыбора);
КонецПроцедуры


&НаКлиенте
Процедура Обновить(Команда)
	ОбновитьНаСервере();
КонецПроцедуры

