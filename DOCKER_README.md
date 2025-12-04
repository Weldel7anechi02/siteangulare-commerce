# 🐳 Guide Docker - Projet E-commerce Angular

Ce guide vous explique comment exécuter votre application e-commerce Angular avec Docker.

## 📋 Prérequis

- Docker installé sur votre machine ([Télécharger Docker](https://www.docker.com/products/docker-desktop))
- Docker Compose installé (inclus avec Docker Desktop)

## 🏗️ Architecture

Le projet utilise deux conteneurs Docker :

1. **Frontend (Angular + Nginx)** - Port 80
   - Application Angular buildée en mode production
   - Servie par Nginx pour de meilleures performances

2. **Backend (json-server)** - Port 3000
   - API REST mock avec json-server
   - Base de données JSON (db.json)

## 🚀 Démarrage Rapide

### Option 1 : Utiliser Docker Compose (Recommandé)

```bash
# Construire et démarrer tous les services
docker-compose up --build

# Ou en mode détaché (arrière-plan)
docker-compose up -d --build
```

L'application sera accessible à :
- **Frontend** : http://localhost
- **API** : http://localhost:3000

### Option 2 : Construire et exécuter manuellement

#### Backend (API)
```bash
# Construire l'image
docker build -f Dockerfile.api -t ecommerce-api .

# Exécuter le conteneur
docker run -d -p 3000:3000 -v $(pwd)/db.json:/app/db.json --name ecommerce-api ecommerce-api
```

#### Frontend
```bash
# Construire l'image
docker build -t ecommerce-frontend .

# Exécuter le conteneur
docker run -d -p 80:80 --name ecommerce-frontend ecommerce-frontend
```

## 🛠️ Commandes Utiles

### Gestion des conteneurs

```bash
# Voir les conteneurs en cours d'exécution
docker-compose ps

# Arrêter les services
docker-compose stop

# Démarrer les services arrêtés
docker-compose start

# Arrêter et supprimer les conteneurs
docker-compose down

# Voir les logs
docker-compose logs

# Voir les logs d'un service spécifique
docker-compose logs frontend
docker-compose logs api

# Suivre les logs en temps réel
docker-compose logs -f
```

### Reconstruction

```bash
# Reconstruire les images sans cache
docker-compose build --no-cache

# Reconstruire et redémarrer
docker-compose up --build --force-recreate
```

### Nettoyage

```bash
# Supprimer les conteneurs, réseaux et volumes
docker-compose down -v

# Supprimer les images
docker rmi ecommerce-frontend ecommerce-api

# Nettoyer tout Docker (attention : supprime tout)
docker system prune -a
```

## 📁 Structure des Fichiers Docker

```
.
├── Dockerfile              # Image pour le frontend Angular
├── Dockerfile.api          # Image pour l'API json-server
├── docker-compose.yml      # Orchestration des services
├── nginx.conf             # Configuration Nginx
├── .dockerignore          # Fichiers à ignorer lors du build
└── db.json                # Base de données JSON
```

## 🔧 Configuration

### Modifier les ports

Éditez `docker-compose.yml` :

```yaml
services:
  frontend:
    ports:
      - "8080:80"  # Changez 8080 par le port souhaité
  
  api:
    ports:
      - "3001:3000"  # Changez 3001 par le port souhaité
```

### Persister les données

Les données de `db.json` sont automatiquement persistées grâce au volume :

```yaml
volumes:
  - ./db.json:/app/db.json
```

Toute modification dans l'API sera sauvegardée dans votre fichier local `db.json`.

## 🐛 Dépannage

### Le frontend ne se connecte pas à l'API

Vérifiez que votre service Angular utilise l'URL correcte :
- En développement local : `http://localhost:3000`
- Avec Docker : `http://localhost/api` (proxy Nginx)

### Erreur de port déjà utilisé

```bash
# Trouver le processus utilisant le port
# Windows
netstat -ano | findstr :80
netstat -ano | findstr :3000

# Linux/Mac
lsof -i :80
lsof -i :3000

# Arrêter le processus ou changer le port dans docker-compose.yml
```

### Les modifications de db.json ne sont pas prises en compte

```bash
# Redémarrer le conteneur API
docker-compose restart api
```

### Problèmes de build

```bash
# Nettoyer et reconstruire
docker-compose down
docker-compose build --no-cache
docker-compose up
```

## 📊 Monitoring

### Vérifier l'état des conteneurs

```bash
# Statistiques en temps réel
docker stats

# Inspecter un conteneur
docker inspect ecommerce-frontend
docker inspect ecommerce-api
```

### Accéder à un conteneur

```bash
# Shell dans le conteneur frontend
docker exec -it ecommerce-frontend sh

# Shell dans le conteneur API
docker exec -it ecommerce-api sh
```

## 🚀 Déploiement en Production

Pour un déploiement en production, considérez :

1. **Variables d'environnement** : Utilisez un fichier `.env`
2. **HTTPS** : Configurez SSL/TLS avec Let's Encrypt
3. **Base de données réelle** : Remplacez json-server par PostgreSQL/MongoDB
4. **Reverse proxy** : Utilisez Traefik ou Nginx Proxy Manager
5. **Orchestration** : Considérez Kubernetes pour la scalabilité

## 📝 Notes

- Le build Angular peut prendre quelques minutes la première fois
- Les images Docker sont optimisées avec un build multi-stage
- Nginx sert les fichiers statiques et proxy les requêtes API
- Les conteneurs redémarrent automatiquement en cas d'erreur

## 🆘 Support

Pour plus d'informations :
- [Documentation Docker](https://docs.docker.com/)
- [Documentation Docker Compose](https://docs.docker.com/compose/)
- [Documentation Nginx](https://nginx.org/en/docs/)

---

Bon développement ! 🎉
