@echo off
REM Script de démarrage rapide pour Docker (Windows)
REM Ce script construit et démarre l'application e-commerce

echo 🐳 Démarrage de l'application e-commerce avec Docker...
echo.

REM Vérifier si Docker est installé
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker n'est pas installé. Veuillez installer Docker Desktop.
    pause
    exit /b 1
)

REM Vérifier si Docker Compose est installé
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker Compose n'est pas installé. Veuillez installer Docker Compose.
    pause
    exit /b 1
)

echo ✅ Docker et Docker Compose sont installés
echo.

REM Arrêter les conteneurs existants
echo 🛑 Arrêt des conteneurs existants...
docker-compose down

REM Construire les images
echo 🔨 Construction des images Docker...
docker-compose build --no-cache

REM Démarrer les services
echo 🚀 Démarrage des services...
docker-compose up -d

echo.
echo ✅ Application démarrée avec succès!
echo.
echo 📱 Accédez à l'application:
echo    Frontend: http://localhost
echo    API:      http://localhost:3000
echo.
echo 📊 Pour voir les logs:
echo    docker-compose logs -f
echo.
echo 🛑 Pour arrêter l'application:
echo    docker-compose down
echo.
pause
