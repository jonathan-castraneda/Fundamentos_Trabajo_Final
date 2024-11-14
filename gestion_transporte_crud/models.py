from sqlalchemy import Column, Integer, Text, Float, ForeignKey, TIMESTAMP
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Usuarios(Base):
    __tablename__ = "usuarios"
    id_usr = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, nullable=False)
    nombre = Column(Text)
    apellido = Column(Text)
    password = Column(Text)
    id_rol = Column(Integer, ForeignKey('rol.id_rol'))
    activo = Column(Integer)
    username = Column(Text)

class Bitacora(Base):
    __tablename__ = "bitacora"
    id_bitacora = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, nullable=False)
    comentario = Column(Text, nullable=True)
    km_inicial = Column(Integer, nullable=True)
    km_final = Column(Integer, nullable=True)
    num_galones = Column(Float, nullable=True)
    costo = Column(Float, nullable=True)
    tipo_gasolina = Column(Text, nullable=True)
    id_usr = Column(Integer, ForeignKey('usuarios.id_usr'))
    id_vehiculo = Column(Integer, ForeignKey('vehiculos.id_vehiculo'))
    id_gasolinera = Column(Integer, ForeignKey('gasolineras.id_gasolinera'))
    id_proyecto = Column(Integer, ForeignKey('proyecto.id_proyecto'))

# Define otros modelos de manera similar
