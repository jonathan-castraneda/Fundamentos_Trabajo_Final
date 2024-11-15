from sqlalchemy import Column, Integer, String, Float, Text, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from .database import Base

class Usuario(Base):
    __tablename__ = "usuarios"

    id_usr = Column(Integer, primary_key=True, index=True)
    nombre = Column(Text)
    apellido = Column(Text)
    password = Column(Text)
    id_rol = Column(Integer, ForeignKey("rol.id_rol"))
    activo = Column(Integer)
    username = Column(Text)

class Bitacora(Base):
    __tablename__ = "bitacora"

    id_bitacora = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP)
    comentario = Column(Text)
    km_inicial = Column(Integer)
    km_final = Column(Integer)
    num_galones = Column(Float)
    costo = Column(Float)
    tipo_gasolina = Column(Text)
    id_usr = Column(Integer, ForeignKey("usuarios.id_usr"))
    id_vehiculo = Column(Integer, ForeignKey("vehiculos.id_vehiculo"))
    id_gasolinera = Column(Integer, ForeignKey("gasolineras.id_gasolinera"))
    id_proyecto = Column(Integer, ForeignKey("proyecto.id_proyecto"))
