FROM python:3.9-slim

# Establecer el directorio de trabajo en la imagen de Docker
WORKDIR /app

# Copiar los requisitos y luego instalar las dependencias
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código de la aplicación
COPY . .


CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]