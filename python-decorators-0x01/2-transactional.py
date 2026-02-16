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


# Decorator to manage transactions
def transactional(func):
    @functools.wraps(func)
    def wrapper(conn, *args, **kwargs):
        try:
            result = func(conn, *args, **kwargs)
            conn.commit()   # Commit if no error
            return result
        except Exception:
            conn.rollback()  # Rollback if error occurs
            raise            # Re-raise the exception
    return wrapper


@with_db_connection
@transactional
def update_user_email(conn, user_id, new_email):
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE users SET email = ? WHERE id = ?",
        (new_email, user_id)
    )


# Update user's email with automatic transaction handling
update_user_email(
    user_id=1,
    new_email='Crawford_Cartwright@hotmail.com'
)
