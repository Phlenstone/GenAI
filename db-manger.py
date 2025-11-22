import sqlite3

DB_PATH = "career_data.db"

def init_db():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS users (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT UNIQUE,
                    skills TEXT,
                    goals TEXT
                )''')
    c.execute('''CREATE TABLE IF NOT EXISTS chats (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    user_id INTEGER,
                    query TEXT,
                    response TEXT,
                    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
                )''')
    conn.commit()
    conn.close()

def register_user(name, skills, goals):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    try:
        c.execute("INSERT INTO users (name, skills, goals) VALUES (?, ?, ?)", (name, skills, goals))
        conn.commit()
        return True
    except sqlite3.IntegrityError:
        return False  # user already exists
    finally:
        conn.close()

def get_user(name):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("SELECT id, skills, goals FROM users WHERE name=?", (name,))
    result = c.fetchone()
    conn.close()
    return result

def save_chat(user_id, query, response):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("INSERT INTO chats (user_id, query, response) VALUES (?, ?, ?)", (user_id, query, response))
    conn.commit()
    conn.close()

# Initialize database on startup
init_db()