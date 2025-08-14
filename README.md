# University of Ghana Student Management System

## 📋 Project Overview

A comprehensive web-based student management system designed specifically for the University of Ghana, featuring advanced course management, enrollment tracking, and intelligent GPA calculation capabilities. The system provides seamless integration between administrative functions and student services.

---

## 🔄 Software Development Process Documentation

### 1. Requirements Gathering

#### 1.1 Stakeholder Identification
- **Primary Users**: Students, Academic Administrators, System Administrators
- **Secondary Users**: Faculty, Department Heads, IT Support

#### 1.2 Functional Requirements
- **Java 17** - Runtime environment

### Database
- **PostgreSQL** - Primary database
- **Database Name**: `ug_student_portal`

## Prerequisites

Before running this application, ensure you have the following installed:

1. **Node.js** (v18 or higher)
2. **Java 17** (JDK)
3. **PostgreSQL** (v12 or higher)
4. **Maven** (for backend build)

## Local Development Setup

### 1. Database Setup

1. Install PostgreSQL and start the service
2. Create the database:
   ```sql
   CREATE DATABASE ug_student_portal;
   ```
3. Run the database setup script:
   ```bash
   psql -U postgres -d ug_student_portal -f scripts/setup-local-database.sql
   ```

### 2. Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Update database credentials in `src/main/resources/application.properties` if needed:
   ```properties
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

3. Build and run the Spring Boot application:
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

   The backend will be available at `http://localhost:8080`

### 3. Frontend Setup

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm run dev
   ```

   The frontend will be available at `http://localhost:3000`

## Database Schema

### Tables

1. **students** - Stores student registration information
   - `id` (Primary Key)
   - `name` (VARCHAR)
   - `student_id` (VARCHAR, Unique)
   - `email` (VARCHAR, Unique)
   - `created_at` (TIMESTAMP)
   - `updated_at` (TIMESTAMP)

2. **login_sessions** - Tracks user login sessions
   - `id` (Primary Key)
   - `student_id` (VARCHAR, Foreign Key)
   - `name` (VARCHAR)
   - `email` (VARCHAR)
   - `login_time` (TIMESTAMP)
   - `logout_time` (TIMESTAMP)
   - `session_status` (VARCHAR)
   - `ip_address` (VARCHAR)
   - `user_agent` (TEXT)

3. **admins** - Contains administrative users
   - `id` (Primary Key)
   - `name` (VARCHAR)
   - `admin_id` (VARCHAR, Unique)
   - `email` (VARCHAR)
   - `created_at` (TIMESTAMP)

### Views

- **active_login_sessions** - View for currently active user sessions

## Features

### Student Features
- Student registration and login
- Academic services dashboard
- Course registration (UI ready)
- Grade viewing (UI ready)
- Academic calendar (UI ready)
- Library services (UI ready)
- Financial aid (UI ready)

### Admin Features
- Admin login (newpassword123/newpassword123)
- System statistics dashboard
- Active sessions monitoring
- Student management (UI ready)
- System reports (UI ready)
- System settings (UI ready)

## API Endpoints

### Authentication
- `POST /api/auth/login` - Student login

### Admin Dashboard
- `GET /api/admin/dashboard-stats` - Get dashboard statistics
- `GET /api/admin/logged-students` - Get currently logged students

## Security Features

- Prepared statements to prevent SQL injection
- Connection pooling for efficient resource management
- Session tracking for user activity monitoring
- IP address and user agent logging for security auditing
- Input validation on both frontend and backend

## Development Notes

### Frontend Database Integration
The frontend connects directly to PostgreSQL through a connection pool configured in `lib/db.ts`. This allows the frontend to handle database operations for features that don't require complex business logic.

### Admin Authentication
Admin login is handled entirely on the frontend without backend verification for demonstration purposes. In a production environment, this should be implemented with proper authentication and authorization.

### Session Management
The application tracks login sessions in the database and maintains active sessions to show currently logged-in users. Sessions are marked as active until explicitly logged out.

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Ensure PostgreSQL is running
   - Verify database credentials in `application.properties`
   - Check if the database `ug_student_portal` exists

2. **Port Already in Use**
   - Backend: Change port in `application.properties`
   - Frontend: Change port in `package.json` scripts

3. **Dependencies Not Found**
   - Run `npm install` for frontend dependencies
   - Run `mvn clean install` for backend dependencies

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is for educational purposes and demonstration of full-stack development concepts.

## Contact

For questions or support, please refer to the technical presentation script for detailed implementation information. 