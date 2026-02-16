import sqlite3

conn = sqlite3.connect("users.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT
)
""")

cursor.execute("INSERT INTO users (name, email) VALUES (?, ?)", 
               ("John", "john@example.com"))
cursor.execute("INSERT INTO users (name, email) VALUES (?, ?)", 
               ("Jane", "jane@example.com"))

conn.commit()
conn.close()

print("Database created successfully!")
