CREATE TABLE app_config (
    id SERIAL PRIMARY KEY,
    ai_name TEXT,
    ai_persona TEXT,
    dev_name TEXT,
    api_keys TEXT[],
    avatar_url TEXT
);

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username TEXT NOT NULL,
    access_key TEXT NOT NULL UNIQUE,
    role TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    profile JSONB,
    config JSONB
);

CREATE TABLE chat_logs (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    role TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO app_config (ai_name, ai_persona, dev_name, api_keys, avatar_url) VALUES
('CentralGPT', 'A helpful AI assistant.', 'XdpzQ', '{}', '');

INSERT INTO users (username, access_key, role) VALUES
('dap', 'dap32', 'admin');
