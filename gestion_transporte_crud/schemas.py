from pydantic import BaseModel
from datetime import datetime

class BitacoraBase(BaseModel):
    comentario: str
    km_inicial: int
    km_final: int
    num_galones: float
    costo: float
    tipo_gasolina: str
    id_usr: int
    id_vehiculo: int
    id_gasolinera: int
    id_proyecto: int

class BitacoraCreate(BitacoraBase):
    pass

class Bitacora(BitacoraBase):
    id_bitacora: int
    created_at: datetime

    class Config:
        orm_mode = True
