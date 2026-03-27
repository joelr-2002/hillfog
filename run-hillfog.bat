@echo off
echo ========================================
echo   Starting hillfog Application
echo ========================================
echo.
echo Application will start on: http://127.0.0.1:8088
echo Press Ctrl+C to stop the application
echo.

java -Xmx512M -jar core-app\target\hillfog-core-app-0.0.1-SNAPSHOT.jar
