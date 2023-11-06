-- Nama Lukman
-- No 3
CREATE TABLE students2 (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR DEFAULT NULL,
    email VARCHAR UNIQUE NOT NULL,
    age INTEGER DEFAULT 18,
    gender VARCHAR CHECK (gender IN ('male', 'female')),
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);