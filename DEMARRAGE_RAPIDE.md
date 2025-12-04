# 🚀 Démarrage Rapide - Application E-commerce

## 📋 Ce dont vous avez besoin

1. **Docker Desktop** installé sur votre ordinateur
   - Windows : [Télécharger Docker Desktop](https://www.docker.com/products/docker-desktop)
   - Mac : [Télécharger Docker Desktop](https://www.docker.com/products/docker-desktop)
   - Linux : [Installer Docker](https://docs.docker.com/engine/install/)

2. **4 GB de RAM** minimum disponible pour Docker

## 🎯 Démarrage en 3 étapes

### Étape 1 : Vérifier que Docker fonctionne

Ouvrez un terminal et tapez :
```bash
docker --version
```

Vous devriez voir quelque chose comme : `Docker version 24.0.0`

### Étape 2 : Démarrer l'application

#### Sur Windows
Double-cliquez sur le fichier `docker-start.bat`

#### Sur Mac/Linux
Ouvrez un terminal dans le dossier du projet et tapez :
```bash
chmod +x docker-start.sh
./docker-start.sh
```

#### Ou manuellement
```bash
docker-compose up --build -d
```

### Étape 3 : Accéder à l'application

Ouvrez votre navigateur et allez sur :
- **Site web** : http://localhost
- **API** : http://localhost:3000

## 👤 Se connecter

### Compte Administrateur
- **Email** : admin@example.com
- **Mot de passe** : admin123

### Compte Client
- **Email** : azizhannechi626@gmail.com
- **Mot de passe** : azerty

## 🛑 Arrêter l'application

```bash
docker-compose down
```

## 📊 Voir ce qui se passe

Pour voir les logs en temps réel :
```bash
docker-compose logs -f
```

Pour voir l'état des conteneurs :
```bash
docker-compose ps
```

## ❓ Problèmes courants

### "Port 80 is already in use"
Un autre programme utilise le port 80. Arrêtez-le ou modifiez le port dans `docker-compose.yml` :
```yaml
frontend:
  ports:
    - "8080:80"  # Utilisez 8080 au lieu de 80
```

### "Cannot connect to Docker daemon"
Docker Desktop n'est pas démarré. Lancez Docker Desktop et réessayez.

### L'application ne charge pas
Attendez 1-2 minutes que le build se termine, puis rafraîchissez la page.

## 📚 Documentation complète

Pour plus d'informations, consultez :
- **README_DOCKER.md** - Guide complet avec toutes les commandes
- **DOCKER_README.md** - Documentation technique détaillée

## 🎉 C'est tout !

Votre application e-commerce est maintenant en cours d'exécution avec Docker !

Bon développement ! 🚀
