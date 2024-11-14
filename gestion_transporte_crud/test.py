from sqlalchemy import create_engine

# URL de conexión con el usuario 'usuario_fastapi' y la nueva contraseña 'fbd2024'
DATABASE_URL = "mysql+pymysql://usuario_fastapi:fbd2024@localhost/gestion_transporte"

# Crear el motor de conexión
engine = create_engine(DATABASE_URL)

try:
    # Intentar la conexión
    with engine.connect() as connection:
        print("¡Conexión exitosa!")
except Exception as e:
    print(f"Error al conectar: {e}")
