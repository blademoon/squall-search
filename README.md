﻿# Squall-search

   Небольшой скрипт на Powershell выполняющий поиск определенного значения по всем файлам Excel в конкретной папке рекурсивно.
   Все файлы _*.xlsx_ открываются только для чтения, без обновления внешних ссылок (наиболее безвредный и часто встречающийся вариант).

# Как использовать

1. Скачайте скрипт на свой компьютер. Положите его куда вам удобно.

2. Закройте Microsoft Excel. 

3. Нажмите на иконку скрипта правой кнопкой мыши и в выпадающем меню выберите пункт _"Выполнить с помощью PowerShell"_.

4. Скрипт запросит два обзятельных параметра необходимых ему для работы: 
   __Абсолютный путь__ к папке где необходимо выполнить поиск искомого значения.
      Пример задания абсолютного пути файла: D:\Work\PowerShell\Test\.
   
   __Искомое значение__ - то, что собственно ищем (например текст или число).
   
   Скрипт сам найдёт все файлы по маске _*.xlsx_ (Если объём файлов большой, то необходимо будет подождать).
 
5. Опционально можно задать имя рабочего листа (вкладки) на которой необходимо искать значение. Эта опция полезна в случае 
   если поиск осуществляется по сетевому файловому хранилищу. В данном случае, если заданный вами рабочий лист не будет найден, 
   то этот файл будет пропущен. Если же в файле есть рабочий лист с таким именем, то по нему будет выполнен поиск искомого значения.
   Если рабочий лист на котором необходимо выполнять поиск не задан, то поиск осуществляется по всем рабочим листам всех найденных   файлов.

# Что еще необходимо сделать

- [ ] Вынести в отдельную функцию пересчет адреса вида _R1C1_ в адрес вида _A1_.
- [ ] Сделать "тихий" режим работы. Минимальный вывод информации в консоль.


# Что уже сделано

- [X] Сделать паузу по завершении работы.
- [X] Написать инструкцию по использованию утилиты.
- [X] Сделать вывод адреса найденной ячейки в виде _A1_ в не _R1C1_.

# Если вы нашли ошибку в работе скрипта или коде.
  Сообщите мне об этом по электронной почте _blademoon@yandex.ru_.
  В поле "_Тема_" обзятельно укажите "_Скрипт squall-search_"
	
