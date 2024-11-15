from sqlalchemy.orm import Session
from . import models, schemas
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password):
    return pwd_context.hash(password)

def create_usuario(db: Session, usuario: schemas.UsuarioCreate):
    db_usuario = models.Usuario(
        nombre=usuario.nombre,
        apellido=usuario.apellido,
        username=usuario.username,
        password=get_password_hash(usuario.password)
    )
    db.add(db_usuario)
    db.commit()
    db.refresh(db_usuario)
    return db_usuario

def get_usuario(db: Session, usuario_id: int):
    return db.query(models.Usuario).filter(models.Usuario.id_usr == usuario_id).first()

def get_usuarios(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Usuario).offset(skip).limit(limit).all()

def update_usuario(db: Session, usuario_id: int, usuario: schemas.UsuarioCreate):
    db_usuario = get_usuario(db, usuario_id)
    if db_usuario:
        db_usuario.nombre = usuario.nombre
        db_usuario.apellido = usuario.apellido
        db_usuario.username = usuario.username
        db_usuario.password = get_password_hash(usuario.password)
        db.commit()
        db.refresh(db_usuario)
    return db_usuario

def delete_usuario(db: Session, usuario_id: int):
    db_usuario = get_usuario(db, usuario_id)
    if db_usuario:
        db.delete(db_usuario)
        db.commit()
    return db_usuario

def create_bitacora(db: Session, bitacora: schemas.BitacoraCreate):
    db_bitacora = models.Bitacora(
        created_at=bitacora.created_at,
        comentario=bitacora.comentario,
        km_inicial=bitacora.km_inicial,
        km_final=bitacora.km_final,
        num_galones=bitacora.num_galones,
        costo=bitacora.costo,
        tipo_gasolina=bitacora.tipo_gasolina,
        id_usr=bitacora.id_usr,
        id_vehiculo=bitacora.id_vehiculo,
        id_gasolinera=bitacora.id_gasolinera,
        id_proyecto=bitacora.id_proyecto
    )
    db.add(db_bitacora)
    db.commit()
    db.refresh(db_bitacora)
    return db_bitacora

def get_bitacora(db: Session, bitacora_id: int):
    return db.query(models.Bitacora).filter(models.Bitacora.id_bitacora == bitacora_id).first()

def get_bitacoras(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Bitacora).offset(skip).limit(limit).all()

def update_bitacora(db: Session, bitacora_id: int, bitacora: schemas.BitacoraCreate):
    db_bitacora = get_bitacora(db, bitacora_id)
    if db_bitacora:
        db_bitacora.created_at = bitacora.created_at
        db_bitacora.comentario = bitacora.comentario
        db_bitacora.km_inicial = bitacora.km_inicial
        db_bitacora.km_final = bitacora.km_final
        db_bitacora.num_galones = bitacora.num_galones
        db_bitacora.costo = bitacora.costo
        db_bitacora.tipo_gasolina = bitacora.tipo_gasolina
        db_bitacora.id_usr = bitacora.id_usr
        db_bitacora.id_vehiculo = bitacora.id_vehiculo
        db_bitacora.id_gasolinera = bitacora.id_gasolinera
        db_bitacora.id_proyecto = bitacora.id_proyecto
        db.commit()
        db.refresh(db_bitacora)
    return db_bitacora

def delete_bitacora(db: Session, bitacora_id: int):
    db_bitacora = get_bitacora(db, bitacora_id)
    if db_bitacora:
        db.delete(db_bitacora)
        db.commit()
    return db_bitacora

# Vehiculos CRUD
def create_vehiculo(db: Session, vehiculo: schemas.VehiculoCreate):
    db_vehiculo = models.Vehiculo(
        modelo=vehiculo.modelo,
        marca=vehiculo.marca,
        placa=vehiculo.placa,
        rendimiento=vehiculo.rendimiento,
        galonaje=vehiculo.galonaje,
        tipo_combustible=vehiculo.tipo_combustible
    )
    db.add(db_vehiculo)
    db.commit()
    db.refresh(db_vehiculo)
    return db_vehiculo

def get_vehiculo(db: Session, vehiculo_id: int):
    return db.query(models.Vehiculo).filter(models.Vehiculo.id_vehiculo == vehiculo_id).first()

def get_vehiculos(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Vehiculo).offset(skip).limit(limit).all()

def update_vehiculo(db: Session, vehiculo_id: int, vehiculo: schemas.VehiculoCreate):
    db_vehiculo = get_vehiculo(db, vehiculo_id)
    if db_vehiculo:
        db_vehiculo.modelo = vehiculo.modelo
        db_vehiculo.marca = vehiculo.marca
        db_vehiculo.placa = vehiculo.placa
        db_vehiculo.rendimiento = vehiculo.rendimiento
        db_vehiculo.galonaje = vehiculo.galonaje
        db_vehiculo.tipo_combustible = vehiculo.tipo_combustible
        db.commit()
        db.refresh(db_vehiculo)
    return db_vehiculo

def delete_vehiculo(db: Session, vehiculo_id: int):
    db_vehiculo = get_vehiculo(db, vehiculo_id)
    if db_vehiculo:
        db.delete(db_vehiculo)
        db.commit()
    return db_vehiculo

# Gasolineras CRUD
def create_gasolinera(db: Session, gasolinera: schemas.GasolineraCreate):
    db_gasolinera = models.Gasolinera(
        nombre=gasolinera.nombre,
        direccion=gasolinera.direccion
    )
    db.add(db_gasolinera)
    db.commit()
    db.refresh(db_gasolinera)
    return db_gasolinera

def get_gasolinera(db: Session, gasolinera_id: int):
    return db.query(models.Gasolinera).filter(models.Gasolinera.id_gasolinera == gasolinera_id).first()

def get_gasolineras(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Gasolinera).offset(skip).limit(limit).all()

def update_gasolinera(db: Session, gasolinera_id: int, gasolinera: schemas.GasolineraCreate):
    db_gasolinera = get_gasolinera(db, gasolinera_id)
    if db_gasolinera:
        db_gasolinera.nombre = gasolinera.nombre
        db_gasolinera.direccion = gasolinera.direccion
        db.commit()
        db.refresh(db_gasolinera)
    return db_gasolinera

def delete_gasolinera(db: Session, gasolinera_id: int):
    db_gasolinera = get_gasolinera(db, gasolinera_id)
    if db_gasolinera:
        db.delete(db_gasolinera)
        db.commit()
    return db_gasolinera

# Proyectos CRUD
def create_proyecto(db: Session, proyecto: schemas.ProyectoCreate):
    db_proyecto = models.Proyecto(
        nombre=proyecto.nombre,
        direccion=proyecto.direccion,
        activo=proyecto.activo
    )
    db.add(db_proyecto)
    db.commit()
    db.refresh(db_proyecto)
    return db_proyecto

def get_proyecto(db: Session, proyecto_id: int):
    return db.query(models.Proyecto).filter(models.Proyecto.id_proyecto == proyecto_id).first()

def get_proyectos(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Proyecto).offset(skip).limit(limit).all()

def update_proyecto(db: Session, proyecto_id: int, proyecto: schemas.ProyectoCreate):
    db_proyecto = get_proyecto(db, proyecto_id)
    if db_proyecto:
        db_proyecto.nombre = proyecto.nombre
        db_proyecto.direccion = proyecto.direccion
        db_proyecto.activo = proyecto.activo
        db.commit()
        db.refresh(db_proyecto)
    return db_proyecto

def delete_proyecto(db: Session, proyecto_id: int):
    db_proyecto = get_proyecto(db, proyecto_id)
    if db_proyecto:
        db.delete(db_proyecto)
        db.commit()
    return db