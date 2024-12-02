from sqlalchemy.orm import Session
import models, schemas
from passlib.context import CryptContext
from models import Usuario

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password):
    return pwd_context.hash(password)




# CRUD Usuarios
def create_usuario(db: Session, usuario: schemas.UsuarioCreate):
    db_usuario = models.Usuario(
        nombre=usuario.nombre,
        apellido=usuario.apellido,
        password=get_password_hash(usuario.password),
        id_rol=usuario.id_rol,
        activo=usuario.activo,
        username=usuario.username,
        eliminado=usuario.eliminado,
    )
    db.add(db_usuario)
    db.commit()
    db.refresh(db_usuario)
    return db_usuario

def get_usuario(db: Session, usuario_id: int):
    return db.query(models.Usuario).filter(models.Usuario.id_usr == usuario_id).first()

def get_usuarios(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Usuario).offset(skip).limit(limit).all()

def update_usuario(db: Session, usuario_id: int, usuario: schemas.UsuarioUpdate):
    db_usuario = db.query(models.Usuario).filter(models.Usuario.id_usr == usuario_id).first()
    if db_usuario:
        for key, value in usuario.dict(exclude_unset=True).items():
            setattr(db_usuario, key, value)
        db.commit()
        db.refresh(db_usuario)
    return db_usuario

def delete_usuario(db: Session, usuario_id: int):
    db_usuario = db.query(models.Usuario).filter(models.Usuario.id_usr == usuario_id).first()
    if db_usuario:
        db.delete(db_usuario)
        db.commit()
    return db_usuario

def get_user_by_username(db: Session, username: str):
    return db.query(models.Usuario).filter(models.Usuario.username == username).first()



# CRUD Rol
def create_rol(db: Session, rol: schemas.RolCreate):
    db_rol = models.Rol(descripcion=rol.descripcion)
    db.add(db_rol)
    db.commit()
    db.refresh(db_rol)
    return db_rol

def get_rol(db: Session, rol_id: int):
    return db.query(models.Rol).filter(models.Rol.id_rol == rol_id).first()

def get_roles(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Rol).offset(skip).limit(limit).all()

def update_rol(db: Session, rol_id: int, rol: schemas.RolUpdate):
    db_rol = db.query(models.Rol).filter(models.Rol.id_rol == rol_id).first()
    if db_rol:
        for key, value in rol.dict(exclude_unset=True).items():
            setattr(db_rol, key, value)
        db.commit()
        db.refresh(db_rol)
    return db_rol

def delete_rol(db: Session, rol_id: int):
    db_rol = db.query(models.Rol).filter(models.Rol.id_rol == rol_id).first()
    if db_rol:
        db.delete(db_rol)
        db.commit()
    return db_rol




# CRUD Bitacora
def create_bitacora(db: Session, bitacora: schemas.BitacoraCreate):
    db_bitacora = models.Bitacora(
        comentario=bitacora.comentario,
        km_inicial=bitacora.km_inicial,
        km_final=bitacora.km_final,
        num_galones=bitacora.num_galones,
        costo=bitacora.costo,
        tipo_gasolina=bitacora.tipo_gasolina,
        id_usr=bitacora.id_usr,
        id_vehiculo=bitacora.id_vehiculo,
        id_gasolinera=bitacora.id_gasolinera,
        id_proyecto=bitacora.id_proyecto,
    )
    db.add(db_bitacora)
    db.commit()
    db.refresh(db_bitacora)
    return db_bitacora

def get_bitacora(db: Session, bitacora_id: int):
    return db.query(models.Bitacora).filter(models.Bitacora.id_bitacora == bitacora_id).first()

def get_bitacoras(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Bitacora).offset(skip).limit(limit).all()

def update_bitacora(db: Session, bitacora_id: int, bitacora: schemas.BitacoraUpdate):
    db_bitacora = db.query(models.Bitacora).filter(models.Bitacora.id_bitacora == bitacora_id).first()
    if db_bitacora:
        for key, value in bitacora.dict(exclude_unset=True).items():
            setattr(db_bitacora, key, value)
        db.commit()
        db.refresh(db_bitacora)
    return db_bitacora

def delete_bitacora(db: Session, bitacora_id: int):
    db_bitacora = db.query(models.Bitacora).filter(models.Bitacora.id_bitacora == bitacora_id).first()
    if db_bitacora:
        db.delete(db_bitacora)
        db.commit()
    return db_bitacora




# CRUD Gasolinera
def create_gasolinera(db: Session, gasolinera: schemas.GasolineraCreate):
    db_gasolinera = models.Gasolinera(nombre=gasolinera.nombre, direccion=gasolinera.direccion)
    db.add(db_gasolinera)
    db.commit()
    db.refresh(db_gasolinera)
    return db_gasolinera

def get_gasolinera(db: Session, gasolinera_id: int):
    return db.query(models.Gasolinera).filter(models.Gasolinera.id_gasolinera == gasolinera_id).first()

def get_gasolineras(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Gasolinera).offset(skip).limit(limit).all()

def update_gasolinera(db: Session, gasolinera_id: int, gasolinera: schemas.GasolineraUpdate):
    db_gasolinera = db.query(models.Gasolinera).filter(models.Gasolinera.id_gasolinera == gasolinera_id).first()
    if db_gasolinera:
        for key, value in gasolinera.dict(exclude_unset=True).items():
            setattr(db_gasolinera, key, value)
        db.commit()
        db.refresh(db_gasolinera)
    return db_gasolinera

def delete_gasolinera(db: Session, gasolinera_id: int):
    db_gasolinera = db.query(models.Gasolinera).filter(models.Gasolinera.id_gasolinera == gasolinera_id).first()
    if db_gasolinera:
        db.delete(db_gasolinera)
        db.commit()
    return db_gasolinera




# CRUD Log
def create_log(db: Session, log: schemas.LogCreate):
    db_log = models.Log(descripcion=log.descripcion, id_usr=log.id_usr)
    db.add(db_log)
    db.commit()
    db.refresh(db_log)
    return db_log

def get_log(db: Session, log_id: int):
    return db.query(models.Log).filter(models.Log.id_log == log_id).first()

def get_logs(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Log).offset(skip).limit(limit).all()

def update_log(db: Session, log_id: int, log: schemas.LogUpdate):
    db_log = db.query(models.Log).filter(models.Log.id_log == log_id).first()
    if db_log:
        for key, value in log.dict(exclude_unset=True).items():
            setattr(db_log, key, value)
        db.commit()
        db.refresh(db_log)
    return db_log

def delete_log(db: Session, log_id: int):
    db_log = db.query(models.Log).filter(models.Log.id_log == log_id).first()
    if db_log:
        db.delete(db_log)
        db.commit()
    return db_log



# CRUD Proyecto
def create_proyecto(db: Session, proyecto: schemas.ProyectoCreate):
    db_proyecto = models.Proyecto(
        nombre=proyecto.nombre,
        direccion=proyecto.direccion,
        activo=proyecto.activo,
    )
    db.add(db_proyecto)
    db.commit()
    db.refresh(db_proyecto)
    return db_proyecto

def get_proyecto(db: Session, proyecto_id: int):
    return db.query(models.Proyecto).filter(models.Proyecto.id_proyecto == proyecto_id).first()

def get_proyectos(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Proyecto).offset(skip).limit(limit).all()

def update_proyecto(db: Session, proyecto_id: int, proyecto: schemas.ProyectoUpdate):
    db_proyecto = db.query(models.Proyecto).filter(models.Proyecto.id_proyecto == proyecto_id).first()
    if db_proyecto:
        for key, value in proyecto.dict(exclude_unset=True).items():
            setattr(db_proyecto, key, value)
        db.commit()
        db.refresh(db_proyecto)
    return db_proyecto

def delete_proyecto(db: Session, proyecto_id: int):
    db_proyecto = db.query(models.Proyecto).filter(models.Proyecto.id_proyecto == proyecto_id).first()
    if db_proyecto:
        db.delete(db_proyecto)
        db.commit()
    return db_proyecto


# CRUD Vehiculo
def create_vehiculo(db: Session, vehiculo: schemas.VehiculoCreate):
    db_vehiculo = models.Vehiculo(
        modelo=vehiculo.modelo,
        marca=vehiculo.marca,
        placa=vehiculo.placa,
        rendimiento=vehiculo.rendimiento,
        galonaje=vehiculo.galonaje,
        tipo_combustible=vehiculo.tipo_combustible,
    )
    db.add(db_vehiculo)
    db.commit()
    db.refresh(db_vehiculo)
    return db_vehiculo

def get_vehiculo(db: Session, vehiculo_id: int):
    return db.query(models.Vehiculo).filter(models.Vehiculo.id_vehiculo == vehiculo_id).first()

def get_vehiculos(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Vehiculo).offset(skip).limit(limit).all()

def update_vehiculo(db: Session, vehiculo_id: int, vehiculo: schemas.VehiculoUpdate):
    db_vehiculo = db.query(models.Vehiculo).filter(models.Vehiculo.id_vehiculo == vehiculo_id).first()
    if db_vehiculo:
        for key, value in vehiculo.dict(exclude_unset=True).items():
            setattr(db_vehiculo, key, value)
        db.commit()
        db.refresh(db_vehiculo)
    return db_vehiculo

def delete_vehiculo(db: Session, vehiculo_id: int):
    db_vehiculo = db.query(models.Vehiculo).filter(models.Vehiculo.id_vehiculo == vehiculo_id).first()
    if db_vehiculo:
        db.delete(db_vehiculo)
        db.commit()
    return db_vehiculo
