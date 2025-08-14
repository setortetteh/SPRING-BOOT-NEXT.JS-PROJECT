-- Fix database tables for University of Ghana Student Portal
-- Run this in pgAdmin or psql

-- Connect to the managementsystem_students database first

-- Drop existing tables if they exist (to start fresh)
DROP TABLE IF EXISTS login_sessions;
DROP TABLE IF EXISTS students;

-- Create students table with correct structure
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    student_id VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE,
    date_of_birth DATE,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create login_sessions table
CREATE TABLE login_sessions (
    id SERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    session_type VARCHAR(20) DEFAULT 'login',
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    logout_time TIMESTAMP,
    session_status VARCHAR(20) DEFAULT 'active'
);

-- Verify tables were created
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('students', 'login_sessions');

-- Show table structure
\d students;
\d login_sessions;
