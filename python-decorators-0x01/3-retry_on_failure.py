import time
import sqlite3
import functools


# Decorator to automatically handle DB connection
def with_db_connection(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        conn = sqlite3.connect("users.db")
        try:
            result = func(conn, *args, **kwargs)
        finally:
            conn.close()
        return result
    return wrapper


# Decorator to retry function on failure
def retry_on_failure(retries=3, delay=2):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(conn, *args, **kwargs):
            last_exception = None
            for attempt in range(retries):
                try:
                    return func(conn, *args, **kwargs)
                except Exception as e:
                    last_exception = e
                    if attempt < retries - 1:
                        time.sleep(delay)
                    else:
                        raise last_exception
        return wrapper
    return decorator


@with_db_connection
@retry_on_failure(retries=3, delay=1)
def fetch_users_with_retry(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    return cursor.fetchall()


# attempt to fetch users with automatic retry on failure
users = fetch_users_with_retry()
print(users)
