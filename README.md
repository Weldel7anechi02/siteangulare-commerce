# Brango Store - E-Commerce Platform

A full-stack e-commerce application built with **Angular 16** frontend and **JSON Server** backend, containerized with Docker for easy deployment.

## 📋 Overview

Brango Store is a modern e-commerce platform featuring:
- **User Authentication** - Login & registration system with JWT support
- **Product Catalog** - Browse and filter products with detailed information
- **Shopping Cart** - Add/remove items with real-time updates
- **Order Management** - Place orders and track order history
- **Admin Dashboard** - Manage products, users, and orders
- **Responsive Design** - Mobile-friendly UI with Bootstrap & Angular Material
- **Data Visualization** - Charts and analytics with Chart.js

## 🛠️ Tech Stack

### Frontend
- **Angular 16** - Modern TypeScript framework
- **Bootstrap 5** - Responsive UI framework
- **Angular Material** - Component library
- **Chart.js** - Data visualization
- **RxJS** - Reactive programming

### Backend
- **JSON Server** - Mock REST API with hot-reload
- **Node.js 18** - Runtime environment

### Infrastructure
- **Docker & Docker Compose** - Container orchestration
- **Nginx** - Production web server
- **Alpine Linux** - Lightweight base images

## 📁 Project Structure

```
siteweb/
├── src/
│   ├── app/
│   │   ├── admin/              # Admin dashboard & management
│   │   ├── cart/               # Shopping cart component
│   │   ├── components/         # Shared components
│   │   ├── guards/             # Route guards (auth, admin)
│   │   ├── models/             # TypeScript interfaces
│   │   ├── services/           # Business logic services
│   │   ├── pipes/              # Custom pipes
│   │   ├── about/              # About page
│   │   ├── contact/            # Contact form
│   │   ├── login/              # Authentication
│   │   ├── inscription/        # User registration
│   │   └── app-routing.module  # Route configuration
│   ├── assets/                 # Images & static files
│   └── styles.css              # Global styles
├── docker-compose.yml          # Multi-container orchestration
├── Dockerfile                  # Frontend build (Angular + Nginx)
├── Dockerfile.api              # Backend (JSON Server)
├── nginx.conf                  # Nginx configuration
├── db.json                     # Mock database
└── package.json                # Dependencies & scripts
```

## 🚀 Quick Start

### Prerequisites
- **Docker & Docker Compose** (for containerized setup)
- OR **Node.js 18+** & **npm** (for local development)

### Option 1: Run with Docker (Recommended)

```bash
# Clone the repository
git clone <repository-url>
cd siteweb

# Build and start containers
docker-compose up --build

# Access the application
# Frontend: http://localhost:80
# API: http://localhost:3000
```

### Option 2: Run Locally

```bash
# Install dependencies
npm install

# Terminal 1 - Start development server
npm start
# Frontend: http://localhost:4200

# Terminal 2 - Start API server
npm run api
# API: http://localhost:3000
```

### Run Both Frontend & Backend Concurrently
```bash
npm run dev
```

## 📦 Available Scripts

```bash
# Development
npm start              # Angular dev server (port 4200)
npm run api            # JSON Server (port 3000)
npm run dev            # Both services concurrently

# Production
npm run build          # Build for production (dist/siteweb/)
npm run watch          # Watch mode build

# Testing
npm test               # Run unit tests with Karma
ng e2e                 # Run end-to-end tests

# Docker
docker-compose up      # Start containers
docker-compose down    # Stop containers
docker-compose logs    # View container logs
```

## 🔌 API Endpoints

### Base URL
- **Development**: `http://localhost:3000`
- **Production**: `http://localhost:80` (via Nginx proxy)

### Available Endpoints
```
GET     /users              # List all users
POST    /users              # Create new user
GET     /users/:id          # Get user by ID
PUT     /users/:id          # Update user
DELETE  /users/:id          # Delete user

GET     /products           # List all products
POST    /products           # Create product
GET     /products/:id       # Get product by ID
PUT     /products/:id       # Update product
DELETE  /products/:id       # Delete product

GET     /orders             # List all orders
POST    /orders             # Create new order
GET     /orders/:id         # Get order by ID
PUT     /orders/:id         # Update order
DELETE  /orders/:id         # Delete order

GET     /contacts           # List contact messages
POST    /contacts           # Submit contact form
```

## 🔐 Authentication

- Routes protected by `AuthGuard` require user login
- Admin routes protected by `AdminGuard` require admin privileges
- JWT tokens stored in browser localStorage
- Credentials validated against `/users` endpoint

## 🐳 Docker Architecture

### Services

#### Frontend (`ecommerce-frontend`)
- **Image**: Node 18 Alpine (build) + Nginx Alpine (runtime)
- **Port**: 80
- **Volumes**: None (static content in image)
- **Process**: Multi-stage build for optimization

#### API (`ecommerce-api`)
- **Image**: Node 18 Alpine
- **Port**: 3000
- **Volumes**: `./db.json:/app/db.json` (persistent data)
- **Process**: JSON Server watching db.json for changes

### Network
- **Driver**: Bridge
- **Name**: `ecommerce-network`
- Services communicate via service names (e.g., `http://api:3000`)

## 📊 Data Models

### User Model
```typescript
{
  id: number;
  username: string;
  email: string;
  password: string;
  fullName: string;
  isAdmin: boolean;
  createdAt: Date;
}
```

### Product Model
```typescript
{
  id: number;
  name: string;
  description: string;
  price: number;
  category: string;
  image: string;
  stock: number;
  createdAt: Date;
}
```

### Order Model
```typescript
{
  id: number;
  userId: number;
  items: OrderItem[];
  totalPrice: number;
  status: string;
  createdAt: Date;
}
```

## 🎨 Features

### User Features
- ✅ User registration & authentication
- ✅ Browse products with search & filter
- ✅ Add/remove items from cart
- ✅ Place orders
- ✅ View order history
- ✅ Contact support form

### Admin Features
- ✅ User management
- ✅ Product management (CRUD)
- ✅ Order management
- ✅ Sales dashboard with charts
- ✅ Analytics & statistics

### Technical Features
- ✅ Responsive design (mobile, tablet, desktop)
- ✅ Real-time cart updates
- ✅ Route guards & lazy loading
- ✅ Error handling & validation
- ✅ Docker containerization
- ✅ Multi-stage Docker builds

## 🔧 Configuration

### Environment Variables (Optional)
Create `.env` file in project root:
```env
API_URL=http://localhost:3000
PRODUCTION_MODE=false
```

### Nginx Configuration
Modify `nginx.conf` to change:
- Server port
- Proxy settings
- SSL/TLS certificates
- Cache headers

## 📝 Development Workflow

1. **Clone Repository**
   ```bash
   git clone <repository-url>
   cd siteweb
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Start Development Servers**
   ```bash
   npm run dev
   ```

4. **Make Changes**
   - Frontend code auto-reloads via Angular CLI
   - API changes auto-refresh via JSON Server watch mode

5. **Build for Production**
   ```bash
   npm run build
   docker-compose up --build
   ```

## 🧪 Testing

### Unit Tests
```bash
npm test
```

### E2E Tests
```bash
ng e2e
```

## 📦 Deployment

### Docker Deployment
```bash
# Build images
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Production Build
```bash
npm run build
# Output: dist/siteweb/
```

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Find process using port 80 or 3000
netstat -ano | findstr :80
# Kill process
taskkill /PID <PID> /F
```

### Docker Container Fails to Start
```bash
# Check logs
docker-compose logs ecommerce-frontend
docker-compose logs ecommerce-api

# Rebuild images
docker-compose build --no-cache
```

### Angular Build Errors
```bash
# Clear cache and reinstall
rm -rf node_modules dist
npm install
npm run build
```

## 📚 Key Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| @angular/core | 16.2.0 | Core framework |
| @angular/material | 16.2.14 | UI components |
| bootstrap | 5.3.6 | Responsive design |
| chart.js | 4.4.9 | Data visualization |
| rxjs | 7.8.0 | Reactive programming |
| json-server | Latest | Mock API |

## 🔄 CI/CD Ready

This project is ready for continuous integration with:
- GitHub Actions
- GitLab CI/CD
- Docker Hub automated builds
- Cloud deployment platforms (AWS, Azure, GCP)

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👥 Contributors

- Project created as an e-commerce platform solution

## 📞 Support

For issues, feature requests, or contributions:
1. Open an issue on GitHub
2. Submit a pull request
3. Check existing documentation in `/docs` folder

## 🎯 Future Enhancements

- [ ] Payment gateway integration (Stripe, PayPal)
- [ ] Email notifications
- [ ] Real database (PostgreSQL, MongoDB)
- [ ] Advanced search & filters
- [ ] Product reviews & ratings
- [ ] Inventory management
- [ ] Multi-language support
- [ ] PWA capabilities

---

**Last Updated**: December 2024  
**Angular Version**: 16.2.0  
**Node Version**: 18+
