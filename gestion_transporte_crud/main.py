from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from database import SessionLocal, engine
import models
import crud
import schemas

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/bitacora/", response_model=schemas.Bitacora)
def create_bitacora(bitacora: schemas.BitacoraCreate, db: Session = Depends(get_db)):
    return crud.create_bitacora(db=db, bitacora=bitacora)

@app.get("/bitacora/{bitacora_id}", response_model=schemas.Bitacora)
def read_bitacora(bitacora_id: int, db: Session = Depends(get_db)):
    db_bitacora = crud.get_bitacora(db, bitacora_id=bitacora_id)
    if db_bitacora is None:
        raise HTTPException(status_code=404, detail="Bitacora not found")
    return db_bitacora

@app.put("/bitacora/{bitacora_id}", response_model=schemas.Bitacora)
def update_bitacora(bitacora_id: int, bitacora: schemas.BitacoraCreate, db: Session = Depends(get_db)):
    return crud.update_bitacora(db=db, bitacora_id=bitacora_id, bitacora=bitacora)

@app.delete("/bitacora/{bitacora_id}")
def delete_bitacora(bitacora_id: int, db: Session = Depends(get_db)):
    return crud.delete_bitacora(db=db, bitacora_id=bitacora_id)
