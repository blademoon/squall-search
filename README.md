﻿# squall-search
Небольшой скрипт на Powershell выполняющий поиск определенного значения по всем файлам Excel в конкретной папке рекурсивно.
Все файлы *.xlsx открываются только для чтения, без обновления внешних ссылок (наиболее безвредный и часто встречающийся вариант).

# Иструкция

1.	Скачайте скрипт к себе на компьютер.
2.	Положите его куда хотите.
3.	Нажмите на него правой кнопкой мыши и в выпадающем меню выберите пункт "Выполнить с помощью PowerShell"
4.	Скрипт запросит два параметра для своей работы - абсолютный путь к папке где будет выполняться поиск и искомое значение.
	Важно: Абсолютный путь выглядит вот так, например - D:\Work\PowerShell\Test\.
5.	Опционально можно задать имя рабочего листа (вкладки) на которой необходимо искать значение. Эта опция полезна в случае 
	если поиск осуществляется по сетевому файловому хранилищу. В данном случае, если заданный вами рабочий лист не будет найден, 
	то этот файл будет пропущен. Если же в файле есть рабочий лист с таким именем, то по нему будет выполнен поиск искомого значения.



## Что еще необходимо сделать

- [ ] Вынести в отдельную функцию пересчет адреса вида R1C1 в адрес вида A1.
- [ ] Сделать вывод адреса найденной ячейки в виде A1 в не R1C1.
- [ ] Написать инструкцию по использованию утилиты.

## Что уже сделано

- [*] Сделать паузу по завершении работы.
