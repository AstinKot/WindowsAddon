@echo off
title Windows Addon v1.0.1
chcp 65001 > nul
color 0a
setlocal EnableDelayedExpansion

:: Проверка на наличие прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Требуются права администратора. Запуск от имени администратора...
    runas /user:%COMPUTERNAME%\Администратор "cmd /c \"%~f0\"" >nul 2>&1
    if %errorlevel% neq 0 (
        powershell Start-Process -FilePath cmd -ArgumentList "/c ""%~f0""" -Verb RunAs
    )
    exit /b
)

:: Удаляем лицензию (если существует)
if exist "license.txt" del /F /Q "license.txt" > nul

:main_menu
cls
echo ================================
echo      Windows Addon v1.0.1      
echo ================================
echo 1. Настройки сети и подключения
echo 2. Установить полезные программы
echo 3. Параметры безопасности
echo 4. Локализация и региональные стандарты
echo 5. Пароль и защита учётной записи
echo 6. Темы оформления и персонализация
echo 7. Резервное копирование данных
echo 8. Информация о системе
echo 0. Выход
echo -------------------------------
set /P choice="Выберите действие: "
if "%choice%"=="1" goto network_settings
if "%choice%"=="2" goto install_programs
if "%choice%"=="3" goto security_settings
if "%choice%"=="4" goto localization
if "%choice%"=="5" goto account_security
if "%choice%"=="6" goto personalization
if "%choice%"=="7" goto backup_data
if "%choice%"=="8" goto sysinfo
if "%choice%"=="0" goto exit_app
goto main_menu

:network_settings
cls
echo Настройки сети и подключения
echo ----------------------------
echo 1. Wi-Fi подключение
echo 2. VPN-подключение
echo 3. Интернет-браузеры
echo 4. Проверка скорости соединения
echo 0. Назад
set /P choice="Выберите пункт меню: "
if "%choice%"=="1" start ms-settings:network-wifi
if "%choice%"=="2" start ms-settings:vpn
if "%choice%"=="3" start ms-settings:browsers
if "%choice%"=="4" netsh wlan show interfaces && ping google.com
if "%choice%"=="0" goto main_menu
goto network_settings

:install_programs
cls
echo Установка полезных программ
echo ---------------------------
echo 1. Google Chrome
echo 2. Microsoft Office
echo 3. Adobe Acrobat Reader DC
echo 4. Skype
echo 5. Telegram Desktop
echo 6. Steam
echo 0. Назад
set /P choice="Выберите приложение для установки: "
if "%choice%"=="1" start https://www.google.ru/chrome
if "%choice%"=="2" start https://office.live.com/download
if "%choice%"=="3" start https://get.adobe.com/reader
if "%choice%"=="4" start https://www.skype.com/en/get-skype
if "%choice%"=="5" start https://desktop.telegram.org
if "%choice%"=="6" start https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe
if "%choice%"=="0" goto main_menu
goto install_programs

:security_settings
cls
echo Параметры безопасности
echo ----------------------
echo 1. Антивирус и защита от угроз
echo 2. Брандмауэр
echo 3. Центр обновления Windows
echo 4. Конфиденциальность
echo 0. Назад
set /P choice="Выберите пункт меню: "
if "%choice%"=="1" start ms-settings:windowsdefender
if "%choice%"=="2" start control /name Microsoft.WindowsFirewall
if "%choice%"=="3" start ms-settings:windowsupdate
if "%choice%"=="4" start ms-settings:privacy
if "%choice%"=="0" goto main_menu
goto security_settings

:localization
cls
echo Локализация и региональные стандарты
echo ----------------------------------
echo 1. Язык интерфейса
echo 2. Формат даты и времени
echo 3. Клавиатура и раскладка
echo 0. Назад
set /P choice="Выберите пункт меню: "
if "%choice%"=="1" start ms-settings:language
if "%choice%"=="2" start ms-settings:regionformat
if "%choice%"=="3" start ms-settings:typing
if "%choice%"=="0" goto main_menu
goto localization

:account_security
cls
echo Пароль и защита учётной записи
echo ------------------------------
echo 1. Задать пароль для входа
echo 2. Двухэтапная аутентификация
echo 3. Вход в систему
echo 0. Назад
set /P choice="Выберите пункт меню: "
if "%choice%"=="1" start net user %username% *
if "%choice%"=="2" start ms-settings:accounts
if "%choice%"=="3" start ms-settings:signinoptions
if "%choice%"=="0" goto main_menu
goto account_security

:personalization
cls
echo Темы оформления и персонализация
echo ---------------------------------
echo 1. Выбор фона рабочего стола
echo 2. Цветовые схемы
echo 3. Экранные заставки
echo 0. Назад
set /P choice="Выберите пункт меню: "
if "%choice%"=="1" start ms-settings:background
if "%choice%"=="2" start ms-settings:colors
if "%choice%"=="3" start ms-settings:lockscreen
if "%choice%"=="0" goto main_menu
goto personalization

:backup_data
cls
echo Резервное копирование данных
echo -----------------------------
echo 1. Создать резервную копию
echo 2. Восстановить из резервной копии
echo 0. Назад
set /P choice="Выберите пункт меню: "
if "%choice%"=="1" start wbadmin start backup
if "%choice%"=="2" start ms-settings:recovery
if "%choice%"=="0" goto main_menu
goto backup_data

:sysinfo
cls
echo Информация о системе
echo --------------------
systeminfo
timeout /t 10 > nul
goto main_menu

:exit_app
cls
echo Спасибо за использование Windows Addon!
timeout /t 3 > nul
exit /b
