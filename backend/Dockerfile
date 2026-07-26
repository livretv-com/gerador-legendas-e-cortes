FROM python:3.11-slim

# ESSA LINHA RESOLVE SEU ERRO
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pyproject.toml uv.lock* ./
RUN pip install uv && uv sync --frozen || pip install -e .

COPY . .

CMD sh -c ".venv/bin/uvicorn main:app --host 0.0.0.0 --port ${PORT:-8080} || uvicorn main:app --host 0.0.0.0 --port ${PORT:-8080}"
