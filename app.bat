@echo off
title Windows Addon v1.0.1
chcp 65001 > nul
color 0a
setlocal EnableDelayedExpansion

:: Удаляем лицензию (если существует)
if exist "license.txt" del /F /Q "license.txt" > nul

:: Основная страница меню
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
choice /C 123456780 /N /M "Выберите действие:"
if errorlevel 9 goto exit_app
if errorlevel 8 goto sysinfo
if errorlevel 7 goto backup_data
if errorlevel 6 goto personalization
if errorlevel 5 goto account_security
if errorlevel 4 goto localization
if errorlevel 3 goto security_settings
if errorlevel 2 goto install_programs
if errorlevel 1 goto network_settings

:: Подменю настройки сети
:network_settings
cls
echo Настройки сети и подключения
echo ----------------------------
echo 1. Wi-Fi подключение
echo 2. VPN-подключение
echo 3. Интернет-браузеры
echo 4. Проверка скорости соединения
echo 0. Назад
choice /C 12340 /N /M "Выберите пункт меню:"
if errorlevel 5 goto main_menu
if errorlevel 4 netsh wlan show interfaces && ping google.com
if errorlevel 3 start ms-settings:browsers
if errorlevel 2 start ms-settings:vpn
if errorlevel 1 start ms-settings:network-wifi

:: Подменю установки полезных программ
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
choice /C 1234560 /N /M "Выберите приложение для установки:"
if errorlevel 7 goto main_menu
if errorlevel 6 start https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe
if errorlevel 5 start https://desktop.telegram.org
if errorlevel 4 start https://www.skype.com/en/get-skype
if errorlevel 3 start https://get.adobe.com/reader
if errorlevel 2 start https://office.live.com/download
if errorlevel 1 start https://www.google.ru/chrome

:: Подменю безопасности
:security_settings
cls
echo Параметры безопасности
echo ----------------------
echo 1. Антивирус и защита от угроз
echo 2. Брандмауэр
echo 3. Центр обновления Windows
echo 4. Конфиденциальность
echo 0. Назад
choice /C 12340 /N /M "Выберите пункт меню:"
if errorlevel 5 goto main_menu
if errorlevel 4 start ms-settings:privacy
if errorlevel 3 start ms-settings:windowsupdate
if errorlevel 2 start control /name Microsoft.WindowsFirewall
if errorlevel 1 start ms-settings:windowsdefender

:: Подменю локализации
:localization
cls
echo Локализация и региональные стандарты
echo ----------------------------------
echo 1. Язык интерфейса
echo 2. Формат даты и времени
echo 3. Клавиатура и раскладка
echo 0. Назад
choice /C 1230 /N /M "Выберите пункт меню:"
if errorlevel 4 goto main_menu
if errorlevel 3 start ms-settings:typing
if errorlevel 2 start ms-settings:regionformat
if errorlevel 1 start ms-settings:language

:: Подменю защиты учётной записи
:account_security
cls
echo Пароль и защита учётной записи
echo ------------------------------
echo 1. Задать пароль для входа
echo 2. Двухэтапная аутентификация
echo 3. Вход в систему
echo 0. Назад
choice /C 1230 /N /M "Выберите пункт меню:"
if errorlevel 4 goto main_menu
if errorlevel 3 start ms-settings:signinoptions
if errorlevel 2 start ms-settings:accounts
if errorlevel 1 start net user %username% *

:: Подменю персонализации
:personalization
cls
echo Темы оформления и персонализация
echo ---------------------------------
echo 1. Выбор фона рабочего стола
echo 2. Цветовые схемы
echo 3. Экранные заставки
echo 0. Назад
choice /C 1230 /N /M "Выберите пункт меню:"
if errorlevel 4 goto main_menu
if errorlevel 3 start ms-settings:lockscreen
if errorlevel 2 start ms-settings:colors
if errorlevel 1 start ms-settings:background

:: Подменю резервного копирования
:backup_data
cls
echo Резервное копирование данных
echo -----------------------------
echo 1. Создать резервную копию
echo 2. Восстановить из резервной копии
echo 0. Назад
choice /C 120 /N /M "Выберите пункт меню:"
if errorlevel 3 goto main_menu
if errorlevel 2 start ms-settings:recovery
if errorlevel 1 start wbadmin start backup

:: Информационная панель
:sysinfo
cls
echo Информация о системе
echo --------------------
systeminfo
timeout /t 10 > nul
goto main_menu

:: Выход из программы
:exit_app
cls
echo Спасибо за использование Windows Addon!
timeout /t 3 > nul
exit /b
