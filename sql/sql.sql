-- SQL schema based on ConfigContext.tsx

-- Table for global application configuration
CREATE TABLE app_config (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    ai_name TEXT,
    ai_persona TEXT,
    dev_name TEXT,
    api_keys TEXT[],
    avatar_url TEXT
);

-- Default configuration entry
INSERT INTO app_config (ai_name, ai_persona, dev_name, api_keys, avatar_url) VALUES
('CentralGPT', 'PERSONA', 'XdpzQ', ARRAY[]::TEXT[], '');

-- Table for users
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username TEXT NOT NULL,
    access_key TEXT NOT NULL UNIQUE,
    role TEXT NOT NULL CHECK (role IN ('user', 'admin')),
    created_at TIMESTAMPTZ DEFAULT now(),
    profile JSONB,
    config JSONB
);

-- Table for chat logs
CREATE TABLE chat_logs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    role TEXT NOT NULL CHECK (role IN ('user', 'model')),
    content TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);
