@echo off
setlocal enabledelayedexpansion
title LabelImg Setup and Launch

REM === STEP 1: Check if virtual environment exists ===
if not exist "labelImg_venv\" (
    echo [INFO] Virtual environment not found. Creating one...
    python -m venv labelImg_venv
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment.
        goto :error
    )
) else (
    echo [INFO] Virtual environment 'labelImg_venv' already exists.
)

REM === STEP 2: Activate virtual environment ===
call labelImg_venv\Scripts\activate.bat
if errorlevel 1 (
    echo [ERROR] Failed to activate virtual environment.
    goto :error
)

REM === STEP 3: Install dependencies ===
echo [INFO] Installing dependencies from requirements\requirements.txt...
if not exist "requirements\requirements.txt" (
    echo [ERROR] Missing file: requirements\requirements.txt
    goto :error
)
pip install --upgrade pip
pip install -r requirements\requirements.txt
if errorlevel 1 (
    echo [ERROR] Failed to install dependencies.
    goto :error
)

REM === STEP 4: Run the application ===
echo [INFO] Starting labelImg...
python labelimg.py
if errorlevel 1 (
    echo [ERROR] labelImg encountered an error.
    goto :error
)

echo [SUCCESS] labelImg exited successfully.
goto :end

:error
echo.
echo ===============================
echo  An error occurred! Exiting...
echo ===============================
echo.
pause
exit /b 1

:end
echo.
echo ===============================
echo  Process completed successfully.
echo ===============================
echo.
pause
exit /b 0
