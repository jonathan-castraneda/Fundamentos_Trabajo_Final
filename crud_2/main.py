from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from crud_2 import models, schemas, crud
from crud_2.database import SessionLocal, engine
from typing import List



models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Dependencia para obtener la sesión de la base de datos 
def get_db(): 
    db = SessionLocal() 
    try: 
        yield db 
    finally: 
        db.close()

@app.get("/")
def read_root():
    return {"Hello": "World"}



    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# Rutas para Usuario
@app.post("/usuarios/", response_model=schemas.Usuario)
def create_usuario(usuario: schemas.UsuarioCreate, db: Session = Depends(get_db)):
    return crud.create_usuario(db=db, usuario=usuario)

@app.get("/usuarios/", response_model=List[schemas.Usuario])
def read_usuarios(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    usuarios = crud.get_usuarios(db, skip=skip, limit=limit)
    return usuarios

@app.get("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def read_usuario(usuario_id: int, db: Session = Depends(get_db)):
    db_usuario = crud.get_usuario(db, usuario_id=usuario_id)
    if db_usuario is None:
        raise HTTPException(status_code=404, detail="Usuario not found")
    return db_usuario

@app.put("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def update_usuario(usuario_id: int, usuario: schemas.UsuarioCreate, db: Session = Depends(get_db)):
    db_usuario = crud.update_usuario(db, usuario_id=usuario_id, usuario=usuario)
    if db_usuario is None:
        raise HTTPException(status_code=404, detail="Usuario not found")
    return db_usuario

@app.delete("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def delete_usuario(usuario_id: int, db: Session = Depends(get_db)):
    db_usuario = crud.delete_usuario(db, usuario_id=usuario_id)
    if db_usuario is None:
        raise HTTPException(status_code=404, detail="Usuario not found")
    return db_usuario

# Rutas para Bitacora
@app.post("/bitacoras/", response_model=schemas.Bitacora)
def create_bitacora(bitacora: schemas.BitacoraCreate, db: Session = Depends(get_db)):
    return crud.create_bitacora(db=db, bitacora=bitacora)

@app.get("/bitacoras/", response_model=List[schemas.Bitacora])
def read_bitacoras(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    bitacoras = crud.get_bitacoras(db, skip=skip, limit=limit)
    return bitacoras

@app.get("/bitacoras/{bitacora_id}", response_model=schemas.Bitacora)
def read_bitacora(bitacora_id: int, db: Session = Depends(get_db)):
    db_bitacora = crud.get_bitacora(db, bitacora_id=bitacora_id)
    if db_bitacora is None:
        raise HTTPException(status_code=404, detail="Bitacora not found")
    return db_bitacora

@app.put("/bitacoras/{bitacora_id}", response_model=schemas.Bitacora)
def update_bitacora(bitacora_id: int, bitacora: schemas.BitacoraCreate, db: Session = Depends(get_db)):
    db_bitacora = crud.update_bitacora(db, bitacora_id=bitacora_id, bitacora=bitacora)
    if db_bitacora is None:
        raise HTTPException(status_code=404, detail="Bitacora not found")
    return db_bitacora

@app.delete("/bitacoras/{bitacora_id}", response_model=schemas.Bitacora)
def delete_bitacora(bitacora_id: int, db: Session = Depends(get_db)):
    db_bitacora = crud.delete_bitacora(db, bitacora_id=bitacora_id)
    if db_bitacora is None:
        raise HTTPException(status_code=404, detail="Bitacora not found")
    return db_bitacora

# Rutas para Vehiculo
@app.post("/vehiculos/", response_model=schemas.Vehiculo)
def create_vehiculo(vehiculo: schemas.VehiculoCreate, db: Session = Depends(get_db)):
    return crud.create_vehiculo(db=db, vehiculo=vehiculo)

@app.get("/vehiculos/", response_model=List[schemas.Vehiculo])
def read_vehiculos(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    vehiculos = crud.get_vehiculos(db, skip=skip, limit=limit)
    return vehiculos

@app.get("/vehiculos/{vehiculo_id}", response_model=schemas.Vehiculo)
def read_vehiculo(vehiculo_id: int, db: Session = Depends(get_db)):
    db_vehiculo = crud.get_vehiculo(db, vehiculo_id=vehiculo_id)
    if db_vehiculo is None:
        raise HTTPException(status_code=404, detail="Vehiculo not found")
    return db_vehiculo

@app.put("/vehiculos/{vehiculo_id}", response_model=schemas.Vehiculo)
def update_vehiculo(vehiculo_id: int, vehiculo: schemas.VehiculoCreate, db: Session = Depends(get_db)):
    db_vehiculo = crud.update_vehiculo(db, vehiculo_id=vehiculo_id, vehiculo=vehiculo)
    if db_vehiculo is None:
        raise HTTPException(status_code=404, detail="Vehiculo not found")
    return db_vehiculo

@app.delete("/vehiculos/{vehiculo_id}", response_model=schemas.Vehiculo)
def delete_vehiculo(vehiculo_id: int, db: Session = Depends(get_db)):
    db_vehiculo = crud.delete_vehiculo(db, vehiculo_id=vehiculo_id)
    if db_vehiculo is None:
        raise HTTPException(status_code=404, detail="Vehiculo not found")
    return db_vehiculo

# Rutas para Gasolinera
@app.post("/gasolineras/", response_model=schemas.Gasolinera)
def create_gasolinera(gasolinera: schemas.GasolineraCreate, db: Session = Depends(get_db)):
    return crud.create_gasolinera(db=db, gasolinera=gasolinera)

@app.get("/gasolineras/", response_model=List[schemas.Gasolinera])
def read_gasolineras(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    gasolineras = crud.get_gasolineras(db, skip=skip, limit=limit)
    return gasolineras

@app.get("/gasolineras/{gasolinera_id}", response_model=schemas.Gasolinera)
def read_gasolinera(gasolinera_id: int, db: Session = Depends(get_db)):
    db_gasolinera = crud.get_gasolinera(db, gasolinera_id=gasolinera_id)
    if db_gasolinera is None:
        raise HTTPException(status_code=404, detail="Gasolinera not found")
    return db_gasolinera

@app.put("/gasolineras/{gasolinera_id}", response_model=schemas.Gasolinera)
def update_gasolinera(gasolinera_id: int, gasolinera: schemas.GasolineraCreate, db: Session = Depends(get_db)):
    db_gasolinera = crud.update_gasolinera(db, gasolinera_id=gasolinera_id, gasolinera=gasolinera)
    if db_gasolinera is None:
        raise HTTPException(status_code=404, detail="Gasolinera not found")
    return db_gasolinera

@app.delete("/gasolineras/{gasolinera_id}", response_model=schemas.Gasolinera)
def delete_gasolinera(gasolinera_id: int, db: Session = Depends(get_db)):
    db_gasolinera = crud.delete_gasolinera(db, gasolinera_id=gasolinera_id)
    if db_gasolinera is None:
        raise HTTPException(status_code=404, detail="Gasolinera not found")
    return db_gasolinera

# Rutas para Proyecto
@app.post("/proyectos/", response_model=schemas.Proyecto)
def create_proyecto(proyecto: schemas.ProyectoCreate, db: Session = Depends(get_db)):
    return crud.create_proyecto(db=db, proyecto=proyecto)

@app.get("/proyectos/", response_model=List[schemas.Proyecto])
def read_proyectos(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    proyectos = crud.get_proyectos(db, skip=skip, limit=limit)
    return proyectos

@app.get("/proyectos/{proyecto_id}", response_model=schemas.Proyecto)
def read_proyecto(proyecto_id: int, db: Session = Depends(get_db)):
    db_proyecto = crud.get_proyecto(db, proyecto_id=proyecto_id)
    if db_proyecto is None:
        raise HTTPException(status_code=404, detail="Proyecto not found")
    return db_proyecto

@app.put("/proyectos/{proyecto_id}", response_model=schemas.Proyecto)
def update_proyecto(proyecto_id: int, proyecto: schemas.ProyectoCreate, db: Session = Depends(get_db)):
    db_proyecto = crud.update_proyecto(db, proyecto_id=proyecto_id, proyecto=proyecto)
    if db_proyecto is None:
        raise HTTPException(status_code=404, detail="Proyecto not found")
    return db_proyecto

@app.delete("/proyectos/{proyecto_id}", response_model=schemas.Proyecto)
def delete_proyecto(proyecto_id: int, db: Session = Depends(get_db)):
    db_proyecto = crud.delete_proyecto(db, proyecto_id=proyecto_id)
    if db_proyecto is None:
        raise HTTPException(status_code=404, detail="Proyecto not found")
    return db_proyecto

if __name__ == "__main__": 
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)