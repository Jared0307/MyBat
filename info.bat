@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem Obtener la fecha actual
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set "datetime=%%i"

rem Extraer componentes de la fecha y hora
set "year=%datetime:~0,4%"
set "month=%datetime:~4,2%"
set "day=%datetime:~6,2%"


rem Formatear la fecha y hora en el formato deseado
set "formatted_date=%year%-%month%-%day%"

rem Crear un archivo de prueba llamado "info" para evitar errores
echo. > info_%USERNAME%_%formatted_date%.txt

rem Obtener nombre del equipo
echo =============================== > info_%USERNAME%_%formatted_date%.txt
echo Nombre del equipo: %COMPUTERNAME% >> info_%USERNAME%_%formatted_date%.txt
echo =============================== >> info_%USERNAME%_%formatted_date%.txt
echo. >> info_%USERNAME%_%formatted_date%.txt

rem Obtener información del sistema
echo Usuario Actual: %USERNAME% >> "info_%USERNAME%_%formatted_date%.txt"
echo. >> "info_%USERNAME%_%formatted_date%.txt"

rem Obtener usuarios locales usando dir en C:\Users
echo Usuarios: >> info_%USERNAME%_%formatted_date%.txt
for /f "tokens=*" %%U in ('dir /b /a:d C:\Users') do (
    echo - %%U >> info_%USERNAME%_%formatted_date%.txt
)
echo. >> info_%USERNAME%_%formatted_date%.txt

rem Obtener direcciones IP
echo Direcciones IPs y Adaptadores: >> info_%USERNAME%_%formatted_date%.txt
ipconfig/all >> info_%USERNAME%_%formatted_date%.txt
echo. >> info_%USERNAME%_%formatted_date%.txt

rem Obtener información de la RAM
echo Memoria RAM: >> "info_%USERNAME%_%formatted_date%.txt"
wmic memorychip get capacity > temp.txt
type temp.txt | findstr /r /v "^$" >> "info_%USERNAME%_%formatted_date%.txt"
del temp.txt
echo. >> "info_%USERNAME%_%formatted_date%.txt"

rem Obtener capacidad del disco
echo Capacidad del Disco: >> "info_%USERNAME%_%formatted_date%.txt"
wmic logicaldisk get size,freespace,caption > temp.txt
type temp.txt | findstr /r /v "^$" >> "info_%USERNAME%_%formatted_date%.txt"
del temp.txt
echo. >> "info_%USERNAME%_%formatted_date%.txt"

rem Obtener información del procesador
echo Información del Procesador: >> "info_%USERNAME%_%formatted_date%.txt"
wmic cpu get name, maxclockspeed, caption > temp.txt
type temp.txt | findstr /r /v "^$" >> "info_%USERNAME%_%formatted_date%.txt"
del temp.txt
echo. >> "info_%USERNAME%_%formatted_date%.txt"

echo =============================== >> info_%USERNAME%_%formatted_date%.txt
echo Información recolectada en info_%USERNAME%_%formatted_date%.txt
endlocal
