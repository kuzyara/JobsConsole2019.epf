# Консоль регламентных заданий для платформы 1С:8.3 

__[Скачать архив](https://github.com/kuzyara/JobsConsole2019.epf/releases/latest/download/JobsConsole2019.zip)__ КонсольЗаданий2019.epf __[Скачать обработку](https://github.com/kuzyara/JobsConsole2019.epf/raw/master/КонсольЗаданий2019.epf)__

[![Github All Releases](https://img.shields.io/github/downloads/kuzyara/JobsConsole2019.epf/total.svg)]() [![telegram](https://patrolavia.github.io/telegram-badge/chat.png)](https://t.me/KuzNikAl)

Адаптация консоли Душелова для 8.3
* без модальных окон (РежимИспользованияМодальности = НеИспользовать)
* тонкий и веб-клиент
* с редактированием параметров
* не зависает при открытии
* режим совместимости 8.2
* не требует БСП
* Поддержка конфигураций на английском коде (спасибо @alexkmbk)

Страница на инфостарте: https://infostart.ru/public/1242071/

![image](Main/JobConsole2019.gif?raw=true)

Обработка оптимизирована под хайлоад, поэтому:
* по-умолчанию при запуске фоновые отбираются за последний час
* при большом количестве рег. заданий состояние получается по активации строки, а не сразу для всех

Новое в версии 1.0.10:
* добавлена возможность встраивания в справочник "Дополнительные отчеты и обработки" из БСП типовых (спасибо KrapivinAndrey)
* для толстого и тонкого клиента показывается информация о том где запуститься задание: на сервере или на клиенте
* при очистке отбора фоновых фильтр по времени теперь остаётся (для больших баз актуально)
* теперь для заполнения колонок "Выполнялось" и "Состояние" при открытии даётся всего 200 мс, получение всех перенесено на кнопку обновления списка регламентных (результат замера выполения в подсказке заголовка этих колонок)
* подчищены все замечания от новой версии bsl-ls плагина edt

## Типовая консоль запросов с конструктором для тонкого клиента:
* добавил закладки для запросов
* УФ, веб-клиент

`КонсольЗапросов_8.3.5(ИТС).epf` __[Скачать обработку](https://github.com/kuzyara/JobsConsole2019.epf/raw/master/Обработки/КонсольЗапросов_8.3.5(ИТС).epf)__
![image](https://user-images.githubusercontent.com/2604430/50132733-22f2fb00-02bb-11e9-8f59-a7e9ee058f05.png)

## Обработка по выводу структуры метаданных
* для УФ и ОФ
* удобно искать таблицу/поле по внутреннему идентификатору

`ВнутренняяСтруктураБД.epf` __[Скачать обработку](https://github.com/kuzyara/JobsConsole2019.epf/raw/master/Обработки/ВнутренняяСтруктураБД.epf)__

![image](https://user-images.githubusercontent.com/2604430/62603889-6f15ad00-b929-11e9-8be8-57a7852830f7.png)

## Отчет по типам общих модулей и всех их Флагах
* для УФ и ОФ
* периодически пригождается когда нужно найти все глобальные модули
* выделяет модули, флаги готорых не соответствуют стандарту ИТС __[(1)](https://its.1c.ru/db/v8std/content/469/hdoc)__ __[(2)](https://1c-syntax.github.io/bsl-language-server/diagnostics/CommonModuleInvalidType/)__

`ФлагиОбщихМодулей.erf` __[Скачать обработку](https://github.com/kuzyara/JobsConsole2019.epf/raw/master/Обработки/ФлагиОбщихМодулей.erf)__

![image](https://user-images.githubusercontent.com/2604430/129529252-e7ae88e6-2afd-4638-a7d3-ba26d9470a61.png)

По [стандарту](https://its.1c.ru/db/v8std/content/469/hdoc), при разработке общих модулей следует выбирать один из четырех контекстов выполнения кода:

|Тип общего модуля | Пример наименования | Вызов сервера | Сервер | Внешнее соединение | Клиент(обычное приложение) | Клиент(управляемое приложение)|
| -- | -- | -- | -- | -- | -- | -- |
| Серверный | ОбщегоНазначения (или ОбщегоНазначенияСервер) |   | + | + | + |  
| Серверный для вызова с клиента | ОбщегоНазначенияВызовСервера | + | + |   |   |  
| Клиентский | ОбщегоНазначенияКлиент (или ОбщегоНазначенияГлобальный) |   |   |   | + | +
| Клиент-серверный | ОбщегоНазначенияКлиентСервер |   | + | + | + | +|

## Преобразователь имен таблиц из sql запроса в 1С
* понимает запросы из технологического журнала
* понимает запросы из MS SQL Server Profiler
* расшифровывает ссылки в hex-формате 0xA76E0050569934C711E39DD823175F06
* кеширование ранее расшифрованных ссылок
* УФ и ОФ

`ПреобразовательИменТаблицSqlВ1С.epf` __[Скачать обработку](https://github.com/kuzyara/JobsConsole2019.epf/raw/master/Обработки/ПреобразовательИменТаблицSqlВ1С.epf)__

![image](https://user-images.githubusercontent.com/2604430/129534878-3b10eafd-013e-4196-af25-8ee87392bc7c.png)

## Консоль запросов 8.2
* модификация на базе обработки Чистова
* замер производительности и количество строк результата в дереве запросов
* автосохранение и автовосстановление при краше (отладке)
* параметры в отдельной вкладке
* меню Файл -> Открыть последние выполненные
* ОФ

`КонсольЗапросов_8.2(www.chistov.spb.ru).epf` __[Скачать обработку](https://github.com/kuzyara/JobsConsole2019.epf/raw/master/Обработки/КонсольЗапросов_8.2(www.chistov.spb.ru).epf)__

![image](Main/QueryConcoleScreenshot.png?raw=true)

Разработка ведётся по git-flow в edt
