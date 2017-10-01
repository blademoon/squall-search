# Функция проверяющая блокировку файла Excel.
function Is-Excel-File-Lock {
    param (
    [Parameter(Mandatory=$true)] [System.IO.FileSystemInfo] $file_full_path
    )

    try {$IsFileLock = [System.IO.File]::Open($file_full_path, "Open", "ReadWrite", "None") }
    catch {
        #Если файл заблокирован, закрываем файл и возвращаем True 
        # Нигде не описанно нужно ли закрывать в этом случае поток. 
        #$IsFileLock.close()
        
        return $True
    }

    #Если файл не заблокирован, закрываем поток и возвращаем False
    $IsFileLock.close()
    return $False
}

# Функция проверяющая наличие парольной защиты файла Excel.
function Is-XLSX-password-protected {
    param (
        [Parameter(Mandatory=$true)] [System.IO.FileSystemInfo] $file_full_path
    )

        $SigWithPsswd = [Byte[]] (0xD0,0xCF,0x11,0xE0,0xA1,0xB1,0x1A)    # Сигнатура файла Excel который защищён паролем.
        $bytes = get-content $file_full_path -encoding byte -total 7     # Считываем первые 7 байт проверяемого файла.
    
        # Сравниваем два массива объектов, байты сигнатуры и байты считанные из проверяемого файла, если длинна результирующего массива объектов равна 0,
        # следовательно разницы нет. Значит установленна парольная защита файла.
        if (@(compare-object $SigWithPsswd $bytes -sync 0).length -eq 0) {
            return $true
        }

        return $false
    }

# Функция получения корректного адреса последней используемой ячейки.
function Get-Last-Cell ($worksheet)  {

$xlCellTypeLastCell = 11
$used = $worksheet.usedRange 
$lastCell = $used.SpecialCells($xlCellTypeLastCell) 
$row = $lastCell.row 
$column = $lastCell.column
return ($worksheet.cells.item($row,$column).Address($false,$false))
}


# Поиск строки на вкладке Policy во всех файлах Excel находящихся в папке ... рекурсивно! 
$Destination = Read-Host -Prompt "Введите путь к папке в которой необходимо произвести поиск (обязательный параметр)"
$SearchText = Read-Host -Prompt "Введите значение которое необходимо найти (обязательный параметр)"
$RequiredWorksheet = Read-Host -Prompt "Введите имя рабочего листа на котором необходимо выполнять поиск (если необходимо искать на всех рабочих листах, нажните Enter)"

$files = Get-ChildItem -recurse $Destination\* -include *.xls,*.xlsx -exclude ~$*


# Получаем колличество файлов Excel в папке 
Write-Host ("__________________________________________________________________________________________________________")
Write-Host ("В указанной папке рекурсивно найдено файлов *.xlsx: " +$files.Count)
Write-Host ("__________________________________________________________________________________________________________")


# Открываем Excel для поиска (Выключаем отображение окна Excel)
$excel = New-Object -comobject Excel.Application                                        

# Блокируем запросы на подтверждение выполнения операции, скрываем окно Excel, оключаем обновление окна Excel (повышаем быстродействие).
$Excel.DisplayAlerts = $false
$Excel.ScreenUpdating = $false
$Excel.Visible = $False
$UpdateLinks = $False
$ReadOnly = $True

# Задаём параметр поиска - искать только значения значения
# Константы для работы с Excel
$xlValues = -4163 
$LookIn = $xlValues

$SaveChanges = $false


foreach ($file in $files) {
    
    # Проверяем свободен ли файл, перед его открытием
    if ((Is-Excel-File-Lock($file))) {
        Write-Host ("Текуший файл в обработке: " +$file)
        Write-Host ("Файл заблокирован, переходим к следующему файлу.")
        Write-Host ("__________________________________________________________________________________________________________")
        continue
        }

    # Проверяем установленна ли парольная защита на файл, перед его открытием
    if ((Is-XLSX-password-protected($file))) {
        Write-Host ("Текуший файл в обработке: " +$file)
        Write-Host ("Файл защищён паролем, переходим к следующему файлу.")
        Write-Host ("__________________________________________________________________________________________________________")
        Continue
    }

    # Открываем конкретный файл XLSX
    $workbook = $excel.workbooks.Open($file,$UpdateLinks,$ReadOnly)
    Write-Host ("Текуший файл в обработке: " +$file)


    # Если задана конкретная вкладка для поиска, то проверяем существует ли эта вкладка в данном файле
    if ($RequiredWorksheet -ne "") {
        $sheet = $workbook.worksheets | where {$_.name -eq $RequiredWorksheet}
        
        # Если вкладка существует, то ищем в файле значение.
        if ($sheet) {
         
            # Выбираем заданную вкладку, дальше работаем только с ней.
            Write-Host ("В данном файле сущетвует заданный рабочий лист.") 
            $worksheet = $workbook.worksheets.item($RequiredWorksheet)

            # Получаем адрес последне используемой на листе ячейки, формируем диапазон поиска и производим поиск.
            $LastCellAdr = Get-Last-Cell($worksheet)
            $SearchRange = $worksheet.Range("A1:$LastCellAdr")
            $Search = $SearchRange.Find($SearchText,[Type]::Missing,$LookIn)

            # Если искомое значение найдено, то выводим где...
            If ($Search) {
                Write-Host ("Текущий рабочий лист: " +$worksheet.Name)
                $Addr = $worksheet.cells.item($Search.Row,$Search.Column).Address($false,$false)
                Write-Host ("ЗНАЧЕНИЕ НАЙДЕНО! Адрес ячейки содержащей значение : " +$Addr)
                #Write-Host ("__________________________________________________________________________________________________________")
            }


        }

        # Если вкладка не существует, то пропускаем файл.
        if(!($sheet)) { 
            Write-Host ("В данном файле заданная вкладка отсутствует! Переходим к следующему файлу.")
            Write-Host ("__________________________________________________________________________________________________________")
            continue    
        }

    }

    #Если не введено имя необходимого рабочего листа, то выполняем поиск по всем листам!
    if ($RequiredWorksheet -eq "") {
            
        # Цикл перебора всех вкладок в файле XLSX
        foreach ($worksheet in $workbook.worksheets) {
            
            # Получаем адрес последний используемой ячейки на текущем рабочем листе и формируем диапазон для поиска.
            $LastCellAdr = Get-Last-Cell($worksheet)
            $SearchRange = $worksheet.Range("A1:$LastCellAdr")
            $Search = $SearchRange.Find($SearchText,[Type]::Missing,$LookIn)

            # Если искомое значение найдено, то выводим где...
            If ($Search) {
                Write-Host ("Текущий рабочий лист: " +$worksheet.Name)
                $Addr = $worksheet.cells.item($Search.Row,$Search.Column).Address($false,$false)
                Write-Host ("ЗНАЧЕНИЕ НАЙДЕНО! Адрес ячейки содержащей значение : " +$Addr)
                #Write-Host ("__________________________________________________________________________________________________________")
            }
        }

    }

    $workbook.Close($SaveChanges)
    Write-Host ("__________________________________________________________________________________________________________")
    
}

# Закрываем Excel и убиваем процес, чтобы он не висел в памяти 
$excel.Quit()
Stop-Process -Name EXCEL
Write-Host ("Обработка завершена.")

Pause