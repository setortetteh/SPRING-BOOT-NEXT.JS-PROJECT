const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'managementsystem_students',
  password: 'K1w2a3m4e5n6a7',
  port: 5432,
});

async function testDatabase() {
  console.log('Testing database connection...');
  
  try {
    const client = await pool.connect();
    console.log('✅ Database connection successful!');
    
    // Check if students table exists
    const tableCheck = await client.query(`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'students'
      );
    `);
    
    console.log('Students table exists:', tableCheck.rows[0].exists);
    
    if (!tableCheck.rows[0].exists) {
      console.log('Creating students table...');
      
      await client.query(`
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
      `);
      
      console.log('✅ Students table created successfully!');
    }
    
    // Check if login_sessions table exists
    const sessionTableCheck = await client.query(`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'login_sessions'
      );
    `);
    
    console.log('Login_sessions table exists:', sessionTableCheck.rows[0].exists);
    
    if (!sessionTableCheck.rows[0].exists) {
      console.log('Creating login_sessions table...');
      
      await client.query(`
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
      `);
      
      console.log('✅ Login_sessions table created successfully!');
    }
    
    // List all tables
    const tables = await client.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `);
    
    console.log('All tables in database:', tables.rows.map(row => row.table_name));
    
    client.release();
    
  } catch (error) {
    console.error('❌ Database error:', error);
  } finally {
    await pool.end();
  }
}

testDatabase();
