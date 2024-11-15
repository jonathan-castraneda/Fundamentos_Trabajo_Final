from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError

# Reemplaza DATABASE_URL con la URL que ya configuraste
DATABASE_URL = "mysql+pymysql://dbpbf32591496:qQncHqJRKqL[NdY33znuH@serverless-eastus.sysp0000.db3.skysql.com:4017/gestion_transporte"

# Crear el engine
engine = create_engine(DATABASE_URL)

# Probar la conexión
try:
    with engine.connect() as connection:
        print("Conexión exitosa a la base de datos.")
except OperationalError as e:
    print("Error al conectar:", e)
