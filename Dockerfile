#!/bin/bash
echo "Iniciando LIVRE CORTES..."
cd front-end 2>/dev/null || cd frontend 2>/dev/null || true
npm install
npm run build &
cd ..
cd supabase 2>/dev/null || cd backend 2>/dev/null || true
pip install -r requirements.txt 2>/dev/null || true
PORT=${PORT:-8000}
echo "Rodando na porta $PORT"
python main.py 2>/dev/null || python app.py 2>/dev/null || uvicorn main:app --host 0.0.0.0 --port $PORT
wait
