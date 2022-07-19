﻿# Squall-search
Небольшой скрипт на Powershell выполняющий поиск определенного значения по всем файлам Excel в конкретной папке рекурсивно.
Все файлы _*.xlsx_ открываются только для чтения, без обновления внешних ссылок (наиболее безвредный и часто встречающийся вариант).

## Минимальные требования
1. Microsoft Powershell 5.1
2. Microsoft Excel (версии не ниже 2010).

## Как использовать
1. Скачайте скрипт на свой компьютер. Положите его куда вам удобно.
2. Закройте Microsoft Excel. 
3. Нажмите на иконку скрипта правой кнопкой мыши и в выпадающем меню выберите пункт _"Выполнить с помощью PowerShell"_.
4. Скрипт запросит два обязательных параметра необходимых ему для работы: 
   - __Абсолютный путь__ к папке где необходимо выполнить поиск искомого значения.
      Пример задания абсолютного пути файла: D:\Work\PowerShell\Test\.
   - __Искомое значение__ - то, что собственно ищем (например текст или число).
   Скрипт сам найдёт все файлы по маске _*.xlsx_ (Если объём файлов большой, то необходимо будет подождать).
5. Опционально можно задать имя рабочего листа (вкладки) на которой необходимо искать значение. Эта опция полезна в случае 
   если поиск осуществляется по сетевому файловому хранилищу. В данном случае, если заданный вами рабочий лист не будет найден, 
   то этот файл будет пропущен. Если же в файле есть рабочий лист с таким именем, то по нему будет выполнен поиск искомого значения.
   Если рабочий лист на котором необходимо выполнять поиск не задан, то поиск осуществляется по всем рабочим листам всех найденных   файлов.
	
