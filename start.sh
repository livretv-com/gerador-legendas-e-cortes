#!/bin/bash
echo "Iniciando LIVRE CORTES..."
PORT=${PORT:-8080}
echo "Iniciando na porta $PORT"

# Entra na pasta backend onde tá o main.py
cd backend
echo "Entrando em backend, arquivos:"
ls main.py

echo "Iniciando servidor..."
exec uvicorn main:app --host 0.0.0.0 --port $PORT
