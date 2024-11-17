# Instrucciones para Levantar la Base de Datos `gestion_transporte`

Este repositorio contiene el script SQL para crear la base de datos **gestion_transporte**. Sigue los pasos a continuación para restaurarla en tu entorno MariaDB o MySQL.

## Requisitos Previos

- Tener MariaDB o MySQL instalado en tu sistema.

## Pasos para Levantar la Base de Datos

1. Clona el repositorio.
2. Accede a la carpeta `database`.
3. Ejecuta el comando en la terminal:
   ```bash
   sudo mysql -u root -p < gestion_transporte.sql


## Ejecutar este comando antes de levantar la API
   pip install fastapi uvicorn sqlalchemy pymysql

## Comando para levantar la API
   uvicorn main:app --reload
   NOTA: se debe estar dentro de la carpeta gestion_transporte_crud}

////////////USANDO LA CARPETA Crud_2
## Ejecutar este comando antes de levantar la API
   pip install fastapi uvicorn sqlalchemy pymysql
   pip install passlib
   pip install sqlalchemy pymysql
   pip install fastapi uvicorn
   pip install bcrypt
   pip install psycopg2-binary
   ## Comando para levantar la API
   uvicorn crud_2.main:app --reload
   NOTA: se debe estar dentro de la carpeta principal 'Fundamentos_Trabajo_Final' 