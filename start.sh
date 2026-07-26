#!/bin/bash
echo "Iniciando LIVRE CORTES..."
cd supabase 2>/dev/null || cd backend 2>/dev/null || true
pip install -r requirements.txt 2>/dev/null || true
PORT=${PORT:-8000}
echo "Iniciando na porta $PORT"
uvicorn main:app --host 0.0.0.0 --port $PORT || python main.py || python app.py
