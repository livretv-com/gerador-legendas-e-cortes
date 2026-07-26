#!/bin/bash
echo "Iniciando LIVRE CORTES..."
PORT=${PORT:-8080}
echo "Iniciando na porta $PORT"
echo "=== LISTANDO ARQUIVOS ==="
ls -la
echo "=== PROCURANDO main.py ==="
find . -name "main.py" -o -name "app.py" | head -20

# Tenta achar automaticamente
if [ -f "main.py" ]; then
  exec uvicorn main:app --host 0.0.0.0 --port $PORT
elif [ -f "app.py" ]; then
  exec uvicorn app:app --host 0.0.0.0 --port $PORT
elif [ -f "backend/main.py" ]; then
  cd backend
  exec uvicorn main:app --host 0.0.0.0 --port $PORT
elif [ -f "src/main.py" ]; then
  cd src
  exec uvicorn main:app --host 0.0.0.0 --port $PORT
else
  MAIN_FILE=$(find . -type f -name "main.py" | head -1)
  echo "Achado: $MAIN_FILE"
  DIR=$(dirname "$MAIN_FILE")
  cd "$DIR"
  exec uvicorn main:app --host 0.0.0.0 --port $PORT
fi
