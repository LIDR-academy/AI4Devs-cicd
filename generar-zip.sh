#!/bin/bash

# Definir las rutas de los archivos zip
BACKEND_ZIP="./backend.zip"
FRONTEND_ZIP="./frontend.zip"

# Remover los antiguos archivos zip
if [ -f "$BACKEND_ZIP" ]; then
    rm "$BACKEND_ZIP"
    echo "Eliminado $BACKEND_ZIP"
fi

if [ -f "$FRONTEND_ZIP" ]; then
    rm "$FRONTEND_ZIP"
    echo "Eliminado $FRONTEND_ZIP"
fi

# Crear nuevos archivos zip para backend y frontend
if [ -d "backend" ]; then
    zip -r "$BACKEND_ZIP" backend/
    echo "Creado $BACKEND_ZIP"
else
    echo "Directorio backend no encontrado, no se creó $BACKEND_ZIP"
fi

if [ -d "frontend" ]; then
    zip -r "$FRONTEND_ZIP" frontend/
    echo "Creado $FRONTEND_ZIP"
else
    echo "Directorio frontend no encontrado, no se creó $FRONTEND_ZIP"
fi