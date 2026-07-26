#!/bin/bash
cd backend
PORT=${PORT:-8000}
echo "Iniciando na porta $PORT"
uvicorn main:app --host 0.0.0.0 --port $PORT
