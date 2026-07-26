FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y nodejs npm ffmpeg && rm -rf /var/lib/apt/lists/*
COPY . .
RUN pip install fastapi uvicorn python-multipart openai python-dotenv
RUN if [ -f "supabase/requirements.txt" ]; then pip install -r supabase/requirements.txt; fi
RUN if [ -f "backend/requirements.txt" ]; then pip install -r backend/requirements.txt; fi
RUN if [ -d "viralclips-mobile" ]; then cd viralclips-mobile && npm install && npm run build || true; cd ..; fi
RUN chmod +x start.sh || true
EXPOSE 8000
CMD ["bash", "start.sh"]
