from sqlalchemy import Column, Integer, String, ForeignKey, Text, Float, TIMESTAMP
from sqlalchemy.orm import relationship
from database import Base
import datetime

class Usuario(Base):
    __tablename__ = 'usuarios'

    id_usr = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, default=datetime.datetime.utcnow)
    nombre = Column(Text)
    apellido = Column(Text)
    password = Column(Text)
    id_rol = Column(Integer, ForeignKey('rol.id_rol'))
    activo = Column(Integer)
    eliminado = Column(Integer)
    username = Column(Text)
    rol = relationship("Rol")

class Rol(Base):
    __tablename__ = 'rol'

    id_rol = Column(Integer, primary_key=True, index=True)
    descripcion = Column(Text)

class Bitacora(Base):
    __tablename__ = 'bitacora'

    id_bitacora = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, default=datetime.datetime.utcnow)
    comentario = Column(Text)
    km_inicial = Column(Integer)
    km_final = Column(Integer)
    num_galones = Column(Float)
    costo = Column(Float)
    tipo_gasolina = Column(Text)
    id_usr = Column(Integer, ForeignKey('usuarios.id_usr'))
    id_vehiculo = Column(Integer, ForeignKey('vehiculos.id_vehiculo'))
    id_gasolinera = Column(Integer, ForeignKey('gasolineras.id_gasolinera'))
    id_proyecto = Column(Integer, ForeignKey('proyecto.id_proyecto'))
    usuario = relationship("Usuario")
    vehiculo = relationship("Vehiculo")
    gasolinera = relationship("Gasolinera")
    proyecto = relationship("Proyecto")

class Gasolinera(Base):
    __tablename__ = 'gasolineras'

    id_gasolinera = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, default=datetime.datetime.utcnow)
    nombre = Column(Text)
    direccion = Column(Text)

class Log(Base):
    __tablename__ = 'log'

    id_log = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, default=datetime.datetime.utcnow)
    descripcion = Column(Text)
    id_usr = Column(Integer, ForeignKey('usuarios.id_usr'))
    usuario = relationship("Usuario")

class Proyecto(Base):
    __tablename__ = 'proyecto'

    id_proyecto = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, default=datetime.datetime.utcnow)
    nombre = Column(Text)
    direccion = Column(Text)
    activo = Column(Integer)

class Vehiculo(Base):
    __tablename__ = 'vehiculos'

    id_vehiculo = Column(Integer, primary_key=True, index=True)
    created_at = Column(TIMESTAMP, default=datetime.datetime.utcnow)
    modelo = Column(Text)
    marca = Column(Text)
    placa = Column(Text)
    rendimiento = Column(Text)
    galonaje = Column(Float)
    tipo_combustible = Column(Text)