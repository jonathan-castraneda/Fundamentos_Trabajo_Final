from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
import models, schemas, crud
from database import engine, SessionLocal

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Endpoints para Usuarios
@app.post("/usuarios/", response_model=schemas.Usuario)
def create_usuario(usuario: schemas.UsuarioCreate, db: Session = Depends(get_db)):
    return crud.create_usuario(db=db, usuario=usuario)

@app.get("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def read_usuario(usuario_id: int, db: Session = Depends(get_db)):
    db_usuario = crud.get_usuario(db, usuario_id=usuario_id)
    if db_usuario is None:
        raise HTTPException(status_code=404, detail="Usuario not found")
    return db_usuario

@app.get("/usuarios/", response_model=List[schemas.Usuario])
def read_usuarios(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    usuarios = crud.get_usuarios(db, skip=skip, limit=limit)
    return usuarios

@app.put("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def update_usuario(usuario_id: int, usuario: schemas.UsuarioUpdate, db: Session = Depends(get_db)):
    return crud.update_usuario(db=db, usuario_id=usuario_id, usuario=usuario)

@app.delete("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def delete_usuario(usuario_id: int, db: Session = Depends(get_db)):
    return crud.delete_usuario(db=db, usuario_id=usuario_id)


# Endpoints para Rol
@app.post("/roles/", response_model=schemas.Rol)
def create_rol(rol: schemas.RolCreate, db: Session = Depends(get_db)):
    return crud.create_rol(db=db, rol=rol)

@app.get("/roles/{rol_id}", response_model=schemas.Rol)
def read_rol(rol_id: int, db: Session = Depends(get_db)):
    db_rol = crud.get_rol(db, rol_id=rol_id)
    if db_rol is None:
        raise HTTPException(status_code=404, detail="Rol not found")
    return db_rol

@app.get("/roles/", response_model=List[schemas.Rol])
def read_roles(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    roles = crud.get_roles(db, skip=skip, limit=limit)
    return roles

@app.put("/roles/{rol_id}", response_model=schemas.Rol)
def update_rol(rol_id: int, rol: schemas.RolUpdate, db: Session = Depends(get_db)):
    return crud.update_rol(db=db, rol_id=rol_id, rol=rol)

@app.delete("/roles/{rol_id}", response_model=schemas.Rol)
def delete_rol(rol_id: int, db: Session = Depends(get_db)):
    return crud.delete_rol(db=db, rol_id=rol_id)



# Endpoints para Bitacora
@app.post("/bitacoras/", response_model=schemas.Bitacora)
def create_bitacora(bitacora: schemas.BitacoraCreate, db: Session = Depends(get_db)):
    return crud.create_bitacora(db=db, bitacora=bitacora)

@app.get("/bitacoras/{bitacora_id}", response_model=schemas.Bitacora)
def read_bitacora(bitacora_id: int, db: Session = Depends(get_db)):
    db_bitacora = crud.get_bitacora(db, bitacora_id=bitacora_id)
    if db_bitacora is None:
        raise HTTPException(status_code=404, detail="Bitacora not found")
    return db_bitacora

@app.get("/bitacoras/", response_model=List[schemas.Bitacora])
def read_bitacoras(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    bitacoras = crud.get_bitacoras(db, skip=skip, limit=limit)
    return bitacoras

@app.put("/bitacoras/{bitacora_id}", response_model=schemas.Bitacora)
def update_bitacora(bitacora_id: int, bitacora: schemas.BitacoraUpdate, db: Session = Depends(get_db)):
    return crud.update_bitacora(db=db, bitacora_id=bitacora_id, bitacora=bitacora)

@app.delete("/bitacoras/{bitacora_id}", response_model=schemas.Bitacora)
def delete_bitacora(bitacora_id: int, db: Session = Depends(get_db)):
    return crud.delete_bitacora(db=db, bitacora_id=bitacora_id)




# Endpoints para Gasolinera
@app.post("/gasolineras/", response_model=schemas.Gasolinera)
def create_gasolinera(gasolinera: schemas.GasolineraCreate, db: Session = Depends(get_db)):
    return crud.create_gasolinera(db=db, gasolinera=gasolinera)

@app.get("/gasolineras/{gasolinera_id}", response_model=schemas.Gasolinera)
def read_gasolinera(gasolinera_id: int, db: Session = Depends(get_db)):
    db_gasolinera = crud.get_gasolinera(db, gasolinera_id=gasolinera_id)
    if db_gasolinera is None:
        raise HTTPException(status_code=404, detail="Gasolinera not found")
    return db_gasolinera

@app.get("/gasolineras/", response_model=List[schemas.Gasolinera])
def read_gasolineras(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    gasolineras = crud.get_gasolineras(db, skip=skip, limit=limit)
    return gasolineras

@app.put("/gasolineras/{gasolinera_id}", response_model=schemas.Gasolinera)
def update_gasolinera(gasolinera_id: int, gasolinera: schemas.GasolineraUpdate, db: Session = Depends(get_db)):
    return crud.update_gasolinera(db=db, gasolinera_id=gasolinera_id, gasolinera=gasolinera)

@app.delete("/gasolineras/{gasolinera_id}", response_model=schemas.Gasolinera)
def delete_gasolinera(gasolinera_id: int, db: Session = Depends(get_db)):
    return crud.delete_gasolinera(db=db, gasolinera_id=gasolinera_id)





# Endpoints para Log
@app.post("/logs/", response_model=schemas.Log)
def create_log(log: schemas.LogCreate, db: Session = Depends(get_db)):
    return crud.create_log(db=db, log=log)

@app.get("/logs/{log_id}", response_model=schemas.Log)
def read_log(log_id: int, db: Session = Depends(get_db)):
    db_log = crud.get_log(db, log_id=log_id)
    if db_log is None:
        raise HTTPException(status_code=404, detail="Log not found")
    return db_log

@app.get("/logs/", response_model=List[schemas.Log])
def read_logs(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    logs = crud.get_logs(db, skip=skip, limit=limit)
    return logs

@app.put("/logs/{log_id}", response_model=schemas.Log)
def update_log(log_id: int, log: schemas.LogUpdate, db: Session = Depends(get_db)):
    return crud.update_log(db=db, log_id=log_id, log=log)

@app.delete("/logs/{log_id}", response_model=schemas.Log)
def delete_log(log_id: int, db: Session = Depends(get_db)):
    return crud.delete_log(db=db, log_id=log_id)





# Endpoints para Proyecto
@app.post("/proyectos/", response_model=schemas.Proyecto)
def create_proyecto(proyecto: schemas.ProyectoCreate, db: Session = Depends(get_db)):
    return crud.create_proyecto(db=db, proyecto=proyecto)

@app.get("/proyectos/{proyecto_id}", response_model=schemas.Proyecto)
def read_proyecto(proyecto_id: int, db: Session = Depends(get_db)):
    db_proyecto = crud.get_proyecto(db, proyecto_id=proyecto_id)
    if db_proyecto is None:
        raise HTTPException(status_code=404, detail="Proyecto not found")
    return db_proyecto

@app.get("/proyectos/", response_model=List[schemas.Proyecto])
def read_proyectos(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    proyectos = crud.get_proyectos(db, skip=skip, limit=limit)
    return proyectos

@app.put("/proyectos/{proyecto_id}", response_model=schemas.Proyecto)
def update_proyecto(proyecto_id: int, proyecto: schemas.ProyectoUpdate, db: Session = Depends(get_db)):
    return crud.update_proyecto(db=db, proyecto_id=proyecto_id, proyecto=proyecto)

@app.delete("/proyectos/{proyecto_id}", response_model=schemas.Proyecto)
def delete_proyecto(proyecto_id: int, db: Session = Depends(get_db)):
    return crud.delete_proyecto(db=db, proyecto_id=proyecto_id)


# Endpoints para Vehiculo
@app.post("/vehiculos/", response_model=schemas.Vehiculo)
def create_vehiculo(vehiculo: schemas.VehiculoCreate, db: Session = Depends(get_db)):
    return crud.create_vehiculo(db=db, vehiculo=vehiculo)

@app.get("/vehiculos/{vehiculo_id}", response_model=schemas.Vehiculo)
def read_vehiculo(vehiculo_id: int, db: Session = Depends(get_db)):
    db_vehiculo = crud.get_vehiculo(db, vehiculo_id=vehiculo_id)
    if db_vehiculo is None:
        raise HTTPException(status_code=404, detail="Vehiculo not found")
    return db_vehiculo

@app.get("/vehiculos/", response_model=List[schemas.Vehiculo])
def read_vehiculos(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    vehiculos = crud.get_vehiculos(db, skip=skip, limit=limit)
    return vehiculos

@app.put("/vehiculos/{vehiculo_id}", response_model=schemas.Vehiculo)
def update_vehiculo(vehiculo_id: int, vehiculo: schemas.VehiculoUpdate, db: Session = Depends(get_db)):
    return crud.update_vehiculo(db=db, vehiculo_id=vehiculo_id, vehiculo=vehiculo)

@app.delete("/vehiculos/{vehiculo_id}", response_model=schemas.Vehiculo)
def delete_vehiculo(vehiculo_id: int, db: Session = Depends(get_db)):
    return crud.delete_vehiculo(db=db, vehiculo_id=vehiculo_id)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)