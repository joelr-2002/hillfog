@echo off
echo ========================================
echo   Building hillfog Project
echo ========================================
echo.

echo Step 1/2: Building core-hillfog module...
cd core-hillfog
call mvn clean install -DskipTests
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to build core-hillfog
    pause
    exit /b 1
)

echo.
echo Step 2/2: Building core-app module...
cd ..\core-app
call mvn clean package -DskipTests
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to build core-app
    pause
    exit /b 1
)

cd ..
echo.
echo ========================================
echo   Build completed successfully!
echo ========================================
echo.
echo JAR file location: core-app\target\hillfog-core-app-0.0.1-SNAPSHOT.jar
echo.
echo To run the application, execute: run-hillfog.bat
echo.
pause
