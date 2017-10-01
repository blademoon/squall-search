﻿# Squall-search

   Небольшой скрипт на Powershell выполняющий поиск определенного значения по всем файлам Excel в конкретной папке рекурсивно.
   Все файлы _*.xlsx_ открываются только для чтения, без обновления внешних ссылок (наиболее безвредный и часто встречающийся вариант).

# Как использовать

1. Скачайте скрипт к себе на компьютер.

2. Положите его куда хотите.

3. Нажмите на него правой кнопкой мыши и в выпадающем меню выберите пункт _"Выполнить с помощью PowerShell"_.

4. Скрипт запросит два параметра для своей работы - абсолютный путь к папке где будет выполняться поиск и искомое значение.
   Важно: Абсолютный путь выглядит вот так, например - _D:\Work\PowerShell\Test\_.
 
5. Опционально можно задать имя рабочего листа (вкладки) на которой необходимо искать значение. Эта опция полезна в случае 
   если поиск осуществляется по сетевому файловому хранилищу. В данном случае, если заданный вами рабочий лист не будет найден, 
   то этот файл будет пропущен. Если же в файле есть рабочий лист с таким именем, то по нему будет выполнен поиск искомого значения.



# Что еще необходимо сделать

- [ ] Вынести в отдельную функцию пересчет адреса вида _R1C1_ в адрес вида _A1_.
- [ ] Сделать вывод адреса найденной ячейки в виде _A1_ в не _R1C1_.


# Что уже сделано

- [X] Сделать паузу по завершении работы.
- [X] Написать инструкцию по использованию утилиты.

# Если вы нашли ошибку в работе скрипта или коде.
  Сообщите мне об этом по электронной почте _blademoon@yandex.ru_.
  В поле "_Тема_" обзятельно укажите "_Скрипт squall-search_"
	
