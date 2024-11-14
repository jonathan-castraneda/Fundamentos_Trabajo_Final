from sqlalchemy.orm import Session
import models
import schemas

def get_bitacora(db: Session, bitacora_id: int):
    return db.query(models.Bitacora).filter(models.Bitacora.id_bitacora == bitacora_id).first()

def create_bitacora(db: Session, bitacora: schemas.BitacoraCreate):
    db_bitacora = models.Bitacora(**bitacora.dict())
    db.add(db_bitacora)
    db.commit()
    db.refresh(db_bitacora)
    return db_bitacora

def update_bitacora(db: Session, bitacora_id: int, bitacora: schemas.BitacoraCreate):
    db_bitacora = db.query(models.Bitacora).filter(models.Bitacora.id_bitacora == bitacora_id).first()
    for key, value in bitacora.dict().items():
        setattr(db_bitacora, key, value)
    db.commit()
    db.refresh(db_bitacora)
    return db_bitacora

def delete_bitacora(db: Session, bitacora_id: int):
    db_bitacora = db.query(models.Bitacora).filter(models.Bitacora.id_bitacora == bitacora_id).first()
    db.delete(db_bitacora)
    db.commit()
    return {"message": "Bitacora deleted successfully"}
