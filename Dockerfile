# Imagen base: usamos Python liviano para ejecutar Flask
FROM python:3.11-slim

# Carpeta de trabajo dentro del contenedor
# Todo lo que copiemos y ejecutemos ocurrirá dentro de /app
WORKDIR /app

# Copiamos primero requirements.txt para instalar dependencias
# Esto ayuda a que Docker aproveche mejor la caché si el código cambia después
COPY requirements.txt .

# Instalamos las dependencias del frontend Flask
# --no-cache-dir evita guardar caché innecesaria y reduce tamaño de imagen
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el resto del proyecto frontend al contenedor
# Incluye app.py, templates/, README, .env.example, etc.
COPY . .

# Documentamos que la app Flask usa el puerto 5000
# Ojo: EXPOSE no abre el puerto solo, el puerto se publica en docker-compose.yml
EXPOSE 5000

# Comando que se ejecuta cuando inicia el contenedor
# En este caso arranca la aplicación Flask
CMD ["python", "app.py"]