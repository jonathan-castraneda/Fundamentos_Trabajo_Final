
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# Esquemas para Usuario
class UsuarioBase(BaseModel):
    nombre: str
    apellido: str
    username: str

class UsuarioCreate(UsuarioBase):
    password: str

class Usuario(UsuarioBase):
    id_usr: int
    activo: Optional[int] = None

    class Config:
        orm_mode = True

# Esquemas para Bitacora
class BitacoraBase(BaseModel):
    comentario: Optional[str] = None
    km_inicial: Optional[int] = None
    km_final: Optional[int] = None
    num_galones: Optional[float] = None
    costo: Optional[float] = None
    tipo_gasolina: Optional[str] = None
    id_usr: Optional[int] = None
    id_vehiculo: Optional[int] = None
    id_gasolinera: Optional[int] = None
    id_proyecto: Optional[int] = None

class BitacoraCreate(BitacoraBase):
    created_at: datetime

class Bitacora(BitacoraBase):
    id_bitacora: int

    class Config:
        orm_mode = True

# Esquemas para Vehiculo
class VehiculoBase(BaseModel):
    modelo: Optional[str] = None
    marca: Optional[str] = None
    placa: Optional[str] = None
    rendimiento: Optional[str] = None
    galonaje: Optional[float] = None
    tipo_combustible: Optional[str] = None

class VehiculoCreate(VehiculoBase):
    created_at: datetime

class Vehiculo(VehiculoBase):
    id_vehiculo: int

    class Config:
        orm_mode = True

# Esquemas para Gasolinera
class GasolineraBase(BaseModel):
    nombre: Optional[str] = None
    direccion: Optional[str] = None

class GasolineraCreate(GasolineraBase):
    created_at: datetime

class Gasolinera(GasolineraBase):
    id_gasolinera: int

    class Config:
        orm_mode = True

# Esquemas para Proyecto
class ProyectoBase(BaseModel):
    nombre: Optional[str] = None
    direccion: Optional[str] = None
    activo: Optional[int] = None

class ProyectoCreate(ProyectoBase):
    created_at: datetime

class Proyecto(ProyectoBase):
    id_proyecto: int

    class Config:
        orm_mode = True
