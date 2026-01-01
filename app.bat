@echo off
chcp 65001 > nul
setlocal

set "version=1.0.0"
set "beta=yes"

if "%1"=="admin" (
    goto adminok
) else (
    powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin\"' -Verb RunAs"
    exit
)

:adminok
set "startone=null"

if exist start.txt (
    set "startone=yes"
    goto startone_test
) else (
    set "startone=no"
    goto startone_test
)

:startone_test
if "%startone%"=="yes" goto hello
if "%startone%"=="no" goto menu
call :Red "[!] Произошла ошибка при выполнении метки startone_test: неправильное значение переменной."
pause
exit

:hello
if "%beta%"=="yes" goto hello_beta
if "%beta%"=="no" goto hello_not_beta
call :Red "[!] Произошла ошибка при выполнении метки hello: неправильное значение переменной."
pause
exit

:hello_beta
cls
call :Yellow "WindowsAddon v%version% beta"
call :Green "[!] Добро пожаловать в WindowsAddon!"
pause
del "start.txt"
goto menu

:hello_not_beta
cls
call :Yellow "WindowsAddon v%version%"
call :Green "[!] Добро пожаловать в WindowsAddon!"
pause
del "start.txt"
goto menu

:menu
if "%beta%"=="yes" goto menu_beta
if "%beta%"=="no" goto menu_not_beta
call :Red "[!] Произошла ошибка при выполнении метки menu: неправильное значение переменной."
pause
exit

:menu_beta
set "menu_beta=null"

cls
call :Yellow "WindowsAddon v%version% beta"
call :Yellow "1. Пуск"
set /p menu_beta=Ваш выбор: 

if "%menu_beta%"=="1" goto shutdown_menu_beta
goto menu_beta

:shutdown_menu_beta
set "menu_shutdown_beta=null"

cls
call :Yellow "WindowsAddon v%version% beta"
call :Yellow "1. Завершение работы"
call :Yellow "2. Завершение работы через время"
call :Yellow "3. Перезагрузка"
call :Yellow "4. Перезагрузка через время"
call :Yellow "5. Выход из учётной записи"
call :Yellow "0. Назад"
set /p menu_shutdown_beta=Ваш выбор (0-5):

if "%menu_shutdown_beta%"=="1" shutdown /s /t 0
if "%menu_shutdown_beta%"=="2" goto shutdown_beta
if "%menu_shutdown_beta%"=="3" shutdown /r /t 0
if "%menu_shutdown_beta%"=="4" goto shutdown_r_beta
if "%menu_shutdown_beta%"=="5" shutdown /l
if "%menu_shutdown_beta%"=="0" goto menu_beta
goto shutdown_menu_beta

:shutdown_beta
set "sb=null"
set /p sb=Введите через сколько секунд выключить:

:: Проверка на числовой ввод
echo %sb%|findstr "^[0-9][0-9]*$">nul
if errorlevel 1 (
    echo Ошибка: введите число!
    pause
    goto shutdown_beta
)

shutdown /s /t %sb%
echo Компьютер выключится через %sb% секунд.
pause
goto menu_beta

:shutdown_r_beta
set "sr=null"
set /p sr=Введите через сколько секунд перезагрузить:


:: Проверка на числовой ввод
echo %sr%|findstr "^[0-9][0-9]*$">nul
if errorlevel 1 (
    echo Ошибка: введите число!
    pause
    goto shutdown_r_beta
)

shutdown /r /t %sr%
echo Компьютер перезагрузится через %sr% секунд.
pause
goto menu_beta

:: Функции для цветного вывода
:Green
powershell -Command "Write-Host '%~1' -ForegroundColor Green"
exit /b

:Red
powershell -Command "Write-Host '%~1' -ForegroundColor Red"
exit /b

:Yellow
powershell -Command "Write-Host '%~1' -ForegroundColor Yellow"
exit /b
