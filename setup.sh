#!/bin/bash

echo "🚀 Setting up University of Ghana Student Portal"
echo "================================================"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js v18 or higher."
    exit 1
fi

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "❌ Java is not installed. Please install Java 17 or higher."
    exit 1
fi

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo "❌ PostgreSQL is not installed. Please install PostgreSQL v12 or higher."
    exit 1
fi

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "❌ Maven is not installed. Please install Maven."
    exit 1
fi

echo "✅ All prerequisites are installed"

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ Frontend dependencies installed successfully"
else
    echo "❌ Failed to install frontend dependencies"
    exit 1
fi

# Build backend
echo "🔨 Building backend..."
cd backend
mvn clean install

if [ $? -eq 0 ]; then
    echo "✅ Backend built successfully"
else
    echo "❌ Failed to build backend"
    exit 1
fi

cd ..

echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Set up PostgreSQL database:"
echo "   - Create database: CREATE DATABASE ug_student_portal;"
echo "   - Run setup script: psql -U postgres -d ug_student_portal -f scripts/setup-local-database.sql"
echo ""
echo "2. Start the backend:"
echo "   cd backend && mvn spring-boot:run"
echo ""
echo "3. Start the frontend:"
echo "   npm run dev"
echo ""
echo "4. Access the application:"
echo "   - Frontend: http://localhost:3000"
echo "   - Backend API: http://localhost:8080"
echo ""
echo "5. Test credentials:"
echo "   - Student: Any name, student ID, and email"
echo "   - Admin: newpassword123 / newpassword123" 