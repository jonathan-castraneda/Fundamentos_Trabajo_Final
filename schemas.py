from pydantic import BaseModel
from typing import Optional

class UsuarioBase(BaseModel):
    nombre: Optional[str] = None
    apellido: Optional[str] = None
    username: Optional[str] = None
    id_rol: Optional[int] = None
    activo: Optional[int] = None

class UsuarioCreate(UsuarioBase):
    password: str

class UsuarioUpdate(UsuarioBase):
    password: Optional[str] = None
    id_rol: Optional[int] = None
    activo: Optional[int] = None

class Usuario(UsuarioBase):
    id_usr: int
    id_rol: int
    activo: Optional[int] = None

    class Config:
        orm_mode = True



class RolBase(BaseModel):
    descripcion: Optional[str] = None

class RolCreate(RolBase):
    pass

class RolUpdate(RolBase):
    pass

class Rol(RolBase):
    id_rol: int

    class Config:
        orm_mode = True





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
    pass

class BitacoraUpdate(BitacoraBase):
    pass

class Bitacora(BitacoraBase):
    id_bitacora: int

    class Config:
        orm_mode = True


class GasolineraBase(BaseModel):
    nombre: Optional[str] = None
    direccion: Optional[str] = None

class GasolineraCreate(GasolineraBase):
    pass

class GasolineraUpdate(GasolineraBase):
    pass

class Gasolinera(GasolineraBase):
    id_gasolinera: int

    class Config:
        orm_mode = True




class LogBase(BaseModel):
    descripcion: Optional[str] = None
    id_usr: Optional[int] = None

class LogCreate(LogBase):
    pass

class LogUpdate(LogBase):
    pass

class Log(LogBase):
    id_log: int

    class Config:
        orm_mode = True



class ProyectoBase(BaseModel):
    nombre: Optional[str] = None
    direccion: Optional[str] = None
    activo: Optional[int] = None

class ProyectoCreate(ProyectoBase):
    pass

class ProyectoUpdate(ProyectoBase):
    pass

class Proyecto(ProyectoBase):
    id_proyecto: int

    class Config:
        orm_mode = True




class VehiculoBase(BaseModel):
    modelo: Optional[str] = None
    marca: Optional[str] = None
    placa: Optional[str] = None
    rendimiento: Optional[str] = None
    galonaje: Optional[float] = None
    tipo_combustible: Optional[str] = None

class VehiculoCreate(VehiculoBase):
    pass

class VehiculoUpdate(VehiculoBase):
    pass

class Vehiculo(VehiculoBase):
    id_vehiculo: int

    class Config:
        orm_mode = True





