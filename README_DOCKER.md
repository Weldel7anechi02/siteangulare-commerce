# 🛍️ Application E-commerce Angular - Guide Docker

Application e-commerce complète développée avec Angular 16, incluant gestion des produits, panier d'achat, authentification utilisateur et tableau de bord administrateur.

## 🚀 Démarrage Rapide avec Docker

### Prérequis
- [Docker Desktop](https://www.docker.com/products/docker-desktop) installé et en cours d'exécution
- 4 GB de RAM minimum disponible pour Docker

### Méthode 1 : Script de démarrage automatique (Recommandé)

#### Windows
```bash
docker-start.bat
```

#### Linux/Mac
```bash
chmod +x docker-start.sh
./docker-start.sh
```

### Méthode 2 : Commandes manuelles

```bash
# Construire et démarrer tous les services
docker-compose up --build -d

# Vérifier que les conteneurs sont en cours d'exécution
docker-compose ps

# Voir les logs
docker-compose logs -f
```

### 🌐 Accès à l'application

Une fois les conteneurs démarrés :

- **Frontend (Application Web)** : http://localhost
- **Backend (API)** : http://localhost:3000

### 👤 Comptes de test

#### Administrateur
- **Email** : admin@example.com
- **Mot de passe** : admin123

#### Client
- **Email** : azizhannechi626@gmail.com
- **Mot de passe** : azerty

## 📦 Architecture Docker

### Services

1. **Frontend (ecommerce-frontend)**
   - Image : Nginx Alpine
   - Port : 80
   - Contient l'application Angular buildée
   - Proxy vers l'API via Nginx

2. **Backend (ecommerce-api)**
   - Image : Node Alpine + json-server
   - Port : 3000
   - API REST avec base de données JSON
   - Données persistées via volume Docker

### Réseau
Les deux services communiquent via un réseau Docker bridge nommé `ecommerce-network`.

## 🛠️ Commandes Docker Utiles

### Gestion des conteneurs

```bash
# Démarrer les services
docker-compose up -d

# Arrêter les services
docker-compose stop

# Redémarrer les services
docker-compose restart

# Arrêter et supprimer les conteneurs
docker-compose down

# Arrêter et supprimer les conteneurs + volumes
docker-compose down -v
```

### Logs et débogage

```bash
# Voir tous les logs
docker-compose logs

# Voir les logs d'un service spécifique
docker-compose logs frontend
docker-compose logs api

# Suivre les logs en temps réel
docker-compose logs -f

# Voir les logs des 100 dernières lignes
docker-compose logs --tail=100
```

### Inspection et maintenance

```bash
# Voir l'état des conteneurs
docker-compose ps

# Voir les statistiques en temps réel
docker stats

# Accéder au shell d'un conteneur
docker exec -it ecommerce-frontend sh
docker exec -it ecommerce-api sh

# Inspecter un conteneur
docker inspect ecommerce-frontend
```

### Reconstruction

```bash
# Reconstruire sans cache
docker-compose build --no-cache

# Reconstruire et redémarrer
docker-compose up --build --force-recreate -d

# Reconstruire un service spécifique
docker-compose build frontend
docker-compose build api
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

### Variables d'environnement

Les URLs de l'API sont configurées dans :
- **Développement** : `src/environments/environment.ts`
- **Production (Docker)** : `src/environments/environment.prod.ts`

## 📊 Données

### Base de données JSON

Les données sont stockées dans `db.json` et incluent :
- Utilisateurs (users)
- Produits (products)
- Commandes (orders)

### Persistance des données

Les modifications apportées via l'API sont automatiquement sauvegardées dans `db.json` grâce au volume Docker :

```yaml
volumes:
  - ./db.json:/app/db.json
```

### Réinitialiser les données

```bash
# Restaurer db.json depuis une sauvegarde
cp db.json.backup db.json

# Redémarrer le service API
docker-compose restart api
```

## 🐛 Dépannage

### Le frontend ne charge pas

```bash
# Vérifier les logs
docker-compose logs frontend

# Reconstruire le frontend
docker-compose build --no-cache frontend
docker-compose up -d frontend
```

### L'API ne répond pas

```bash
# Vérifier les logs
docker-compose logs api

# Redémarrer l'API
docker-compose restart api

# Vérifier que le port 3000 n'est pas utilisé
netstat -ano | findstr :3000  # Windows
lsof -i :3000                  # Linux/Mac
```

### Erreur "port already in use"

```bash
# Arrêter tous les conteneurs
docker-compose down

# Trouver et arrêter le processus utilisant le port
# Windows
netstat -ano | findstr :80
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :80
kill -9 <PID>
```

### Problèmes de mémoire

```bash
# Nettoyer les ressources Docker inutilisées
docker system prune -a

# Augmenter la mémoire allouée à Docker Desktop
# Settings > Resources > Memory
```

### Les modifications de code ne sont pas prises en compte

```bash
# Reconstruire complètement
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## 🚀 Développement

### Mode développement (sans Docker)

```bash
# Installer les dépendances
npm install

# Démarrer le serveur de développement et l'API
npm run dev

# Ou séparément
npm start          # Frontend sur http://localhost:4200
npm run api        # API sur http://localhost:3000
```

### Mode production (avec Docker)

```bash
# Build et démarrage
docker-compose up --build -d

# L'application est accessible sur http://localhost
```

## 📁 Structure du projet

```
.
├── src/                          # Code source Angular
│   ├── app/                      # Composants et services
│   ├── assets/                   # Images et ressources
│   └── environments/             # Configuration environnements
├── Dockerfile                    # Image Docker frontend
├── Dockerfile.api                # Image Docker backend
├── docker-compose.yml            # Orchestration des services
├── nginx.conf                    # Configuration Nginx
├── db.json                       # Base de données JSON
├── docker-start.sh               # Script de démarrage (Linux/Mac)
├── docker-start.bat              # Script de démarrage (Windows)
└── DOCKER_README.md              # Ce fichier
```

## 🔒 Sécurité

⚠️ **Important pour la production** :
- Changez les mots de passe par défaut
- Utilisez HTTPS avec des certificats SSL
- Implémentez une vraie base de données (PostgreSQL, MongoDB)
- Ajoutez l'authentification JWT
- Configurez CORS correctement
- Utilisez des variables d'environnement pour les secrets

## 📚 Fonctionnalités

### Pour les clients
- ✅ Navigation par catégories (Pulls, Pantalons, Chaussures)
- ✅ Recherche de produits
- ✅ Panier d'achat
- ✅ Gestion du profil utilisateur
- ✅ Historique des commandes
- ✅ Inscription et connexion

### Pour les administrateurs
- ✅ Tableau de bord avec statistiques
- ✅ Gestion des produits (CRUD)
- ✅ Gestion des commandes
- ✅ Gestion des utilisateurs
- ✅ Graphiques de ventes

## 🤝 Contribution

Pour contribuer au projet :

1. Fork le projet
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📄 Licence

Ce projet est sous licence MIT.

## 📞 Support

Pour toute question ou problème :
- Consultez la section [Dépannage](#-dépannage)
- Ouvrez une issue sur GitHub
- Consultez la [documentation Docker](https://docs.docker.com/)

---

Développé avec ❤️ en utilisant Angular et Docker
