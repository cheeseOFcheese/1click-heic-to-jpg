@echo off

REM Запуск новой командной строки с указанной директорией
start "i hate heif" cmd /c "echo START && timeout /nobreak /t 2 && exit"

REM Ожидание некоторого времени для открытия новой командной строки
timeout /nobreak /t 3 >nul

REM Установка Git и Python (если не установлены)
where git >nul 2>nul || (
    echo Установка Git...
    curl -fsSL https://git.io/JYEP9 | bash
)

where python >nul 2>nul || (
    echo Установка Python...
    curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
)

REM Установка heif-convert и его зависимостей
pip install heif-convert Pillow pillow_heif

REM Скачивание и установка heif-convert из репозитория
git clone https://github.com/NeverMendel/heif-convert.git
cd heif-convert
pip install .
cd ..

REM Конвертация файлов HEIC в JPG
mkdir "i hate heif"
for %%i in (*.heic) do (
    heif-convert "%%i" -f jpg -o "i hate heif\%%~ni.jpg"
)

REM Закрытие новой командной строки
taskkill /FI "WINDOWTITLE eq i hate heif*" /F >nul

echo Завершено.
pause
