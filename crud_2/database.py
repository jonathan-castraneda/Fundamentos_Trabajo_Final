from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

DATABASE_URL = "mysql+pymysql://dbpbf32591496:qQncHqJRKqL[NdY33znuH@serverless-eastus.sysp0000.db3.skysql.com:4017/gestion_transporte"


engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()
