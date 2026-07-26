#!/bin/bash
echo "Iniciando LIVRE CORTES..."
PORT=${PORT:-8080}
echo "Iniciando na porta $PORT"
# Tenta achar o arquivo certo
if [ -f "main.py" ]; then
  exec uvicorn main:app --host 0.0.0.0 --port $PORT
elif [ -f "app.py" ]; then
  exec uvicorn app:app --host 0.0.0.0 --port $PORT
else
  exec uvicorn main:app --host 0.0.0.0 --port $PORT
fi
