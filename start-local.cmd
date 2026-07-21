@echo off
setlocal

cd /d "%~dp0"

where node.exe >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js was not found. Install Node.js 20 or newer first.
    exit /b 1
)

if not exist ".env" (
    if not exist ".env.example" (
        echo [ERROR] Neither .env nor .env.example was found.
        exit /b 1
    )

    copy /y ".env.example" ".env" >nul
    echo [INFO] Created .env from .env.example.
)

if not exist "node_modules\" (
    echo [INFO] Installing dependencies...
    call npm.cmd install
    if errorlevel 1 (
        echo [ERROR] Dependency installation failed.
        exit /b 1
    )
)

echo [INFO] Starting LibreTV at http://localhost:8080
echo [INFO] Press Ctrl+C to stop the server.
call npm.cmd run dev

endlocal
