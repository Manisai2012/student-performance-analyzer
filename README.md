# Student Performance Analyzer & Performance Booster

A modern, cloud-ready Full-Stack Academic Analytics & Student Performance Optimization Platform featuring JWT-secured authentication, marks evaluation, subject-wise diagnostics, automated percentage calculations, rule-based performance booster recommendations, and official CSV report generation.

---

## 🏗️ System Architecture & Tech Stack

| Layer | Technologies & Tools |
|---|---|
| **Frontend UI/UX** | React 19, Vite, Bootstrap 5, Recharts (Data Visualizations), Lucide React Icons, Axios |
| **Backend REST API** | Java 17/21, Spring Boot 3.2.4, Spring Data JPA, Hibernate ORM, Maven |
| **Security & Auth** | Spring Security 6, Stateless JWT (JJWT), BCrypt Password Hashing, CORS |
| **Database** | MySQL (Local MySQL 8.0 for Development / Cloud MySQL such as Aiven or Railway for Production) |
| **Cloud Hosting** | **Vercel / Netlify** (Static Frontend SPA) + **Render / Railway / Docker** (Backend REST API) |

---

## 🚀 Local Development (Quick Start)

### 1. Prerequisites
- **Node.js** (v18+)
- **Java JDK** (17 or 21)
- **MySQL Server** (running locally on port 3306)

### 2. Backend Startup
```powershell
cd backend
# Run via Maven Wrapper:
.\mvnw.cmd spring-boot:run

# Or run pre-built JAR:
java -jar target/factory-0.0.1-SNAPSHOT.jar
```
Backend runs at `http://localhost:8080/api`.

### 3. Frontend Startup
```powershell
cd frontend
npm.cmd run dev
```
Frontend runs at `http://localhost:5173`.

---

## 🌐 Public Deployment Guide

### A. Deploy Persistent MySQL Database (Free Cloud Options)

Recommended Providers: **Aiven MySQL** (Free trial / tier) or **Railway MySQL**.

1. Create a MySQL database instance on [Aiven.io](https://aiven.io) or [Railway.app](https://railway.app).
2. Note down your connection parameters:
   - **Host** (e.g., `mysql-xxxx.aivencloud.com`)
   - **Port** (e.g., `15432`)
   - **User** (e.g., `avnadmin`)
   - **Password** (e.g., `<secret-password>`)
   - **Database Name** (e.g., `defaultdb`)
3. Construct your JDBC URL:
   ```text
   jdbc:mysql://<HOST>:<PORT>/<DATABASE>?sslmode=require&allowPublicKeyRetrieval=true
   ```

---

### B. Deploy Backend (e.g., Render / Railway)

#### Option 1: Render (Web Service)
- **Repository**: Connect your GitHub repository.
- **Environment**: **Docker** (Root `Dockerfile` is pre-configured) or **Java / Maven Native**.
- **Root Directory**: Leave blank if using root `Dockerfile`, or set to `backend`.
- **Build Command** (if native): `mvn clean package -DskipTests`
- **Start Command** (if native): `java -jar target/factory-0.0.1-SNAPSHOT.jar`
- **Environment Variables**:
  | Variable | Value | Description |
  |---|---|---|
  | `PORT` | `8080` | Render port binding |
  | `DB_URL` | `jdbc:mysql://<HOST>:<PORT>/<DATABASE>?...` | Cloud MySQL JDBC URL |
  | `DB_USERNAME` | `<your-db-user>` | Cloud MySQL Username |
  | `DB_PASSWORD` | `<your-db-password>` | Cloud MySQL Password |
  | `JWT_SECRET` | `<random-32-char-string>` | JWT Signing Secret (256-bit) |
  | `HIBERNATE_DDL_AUTO` | `update` | Automatically creates database tables on boot |

Once deployed, note your backend public URL (e.g., `https://your-backend.onrender.com`).

---

### C. Deploy Frontend (e.g., Vercel / Netlify)

#### Vercel Configuration:
1. Import your GitHub repository into [Vercel](https://vercel.com).
2. Configure project settings:
   - **Root Directory**: `frontend`
   - **Framework Preset**: `Vite`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
   - **Install Command**: `npm install`
3. **Environment Variables**:
   | Variable | Value |
   |---|---|
   | `VITE_API_BASE_URL` | `https://your-backend.onrender.com/api` |
4. Deploy! `frontend/vercel.json` already contains single-page application (SPA) rewrites to support React Router navigation seamlessly.

---

## 👥 Demo Accounts (Seeded Automatically)

| Role | Username | Password | Permissions |
|---|---|---|---|
| **Student** | `student` *(alex.johnson@university.edu)* | `student123` | Personal Dashboard, Marks Management, Performance Booster, Report Cards |
| **Admin** | `admin` *(admin@university.edu)* | `admin123` | Full access + Student Academic Cohort Registry (`/students`) |

---

## 🔒 Security & Secret Management

- Passwords are encrypted using **BCrypt**.
- Authorization is stateless via **JSON Web Tokens (JWT)**.
- Sensitive credentials (`DB_PASSWORD`, `JWT_SECRET`) are read exclusively from environment variables in production and are never hardcoded in source control.
