# Legendas Automáticas Estilo CapCut — Open Source

App web **gratuito e open source** para transcrever vídeos, gerar legendas estilo CapCut e exportar cortes para redes sociais. Roda 100% na sua máquina ou VPS — nenhum dado sai do seu computador.

## ✨ Funcionalidades

- 📝 **Transcrição automática** — palavra por palavra via OpenAI Whisper ou mlx-whisper local
- 🎨 **Estilos de legenda** — presets CapCut (Amarelo, Ciano, Minimalista, YouTube) + personalização total
- ✂️ **Cortes inteligentes** — detecção automática de cortes virais com IA (GPT-4o)
- 🎬 **Renderização** — exporta MP4 com legendas queimadas usando FFmpeg
- 🖱️ **Editor visual** — arraste a legenda no preview para posicionar
- 🔤 **Palavras-chave** — destaque automático de termos importantes
- 📱 **Templates** — Reels, YouTube Shorts, TikTok com overlays personalizados
- 🌐 **Multilíngue** — transcrição em PT, EN, ES, FR, IT, DE + detecção automática

## 🚀 Instalação rápida

```bash
git clone https://github.com/sellpayclub/gerador-legendas.git legendas-locais
cd legendas-locais
cp .env.example backend/.env   # edite e cole OPENAI_API_KEY=sk-...
bash install.sh
```

- **Mac:** http://localhost:3000 — `./legendas.sh status|reiniciar|logs`
- **VPS:** o instalador pergunta o domínio e configura HTTPS automaticamente

Guia completo para iniciantes: [GUIA-INSTALACAO.md](./GUIA-INSTALACAO.md)

---

## Pré-requisitos

### Mac (Apple Silicon — M1/M2/M3/M4)

- **Python 3.13** — `brew install python@3.13`
- **Node.js 20+** — `brew install node@20`
- **FFmpeg com libass** — `brew install ffmpeg-full`
- **OpenAI API key** — [platform.openai.com/api-keys](https://platform.openai.com/api-keys)

### VPS (Ubuntu 22.04+)

- VPS com 2+ GB RAM (recomendado 4 GB)
- Domínio apontando para o IP da VPS
- OpenAI API key

> O `install.sh` instala todas as dependências automaticamente tanto no Mac quanto na VPS.

### Verificar dependências

```bash
python3.13 --version
node --version
/opt/homebrew/opt/ffmpeg-full/bin/ffmpeg -filters | grep " ass "
# deve mostrar:  .. ass               V->V       Render ASS subtitles ...
```

## Instalação manual (sem install.sh)

### Backend

```bash
cd backend
python3.13 -m venv .venv
source .venv/bin/activate
pip install -e .
```

Configure `backend/.env`:

```
OPENAI_API_KEY=sk-...
TRANSCRIBE_ENGINE=openai
```

### Frontend

```bash
cd frontend
npm install
```

## Como rodar

Em dois terminais:

**Terminal 1 — backend:**

```bash
cd backend
source .venv/bin/activate
uvicorn main:app --reload --port 8000
```

**Terminal 2 — frontend:**

```bash
cd frontend
npm run dev
```

Abra <http://localhost:3000>.

## Uso

1. **Upload** — arraste o vídeo MP4/MOV (até ~2 GB)
2. Aguarde a transcrição (~2–4 min para 30 min de vídeo)
3. **Editor**:
   - Aba **Estilo**: escolha um preset ou ajuste cores/fonte/tamanho/outline/animação
   - Aba **Transcrição**: corrija palavras erradas; clique numa palavra para pular
   - Arraste a legenda no preview para posicionar
4. **Renderizar** → acompanhe o progresso (~1–3 min)
5. **Baixar MP4** legendado

## Performance esperada (Mac M-series, vídeo 30 min 1080p)

| Etapa                  | Tempo       |
| ---------------------- | ----------- |
| Upload + extração áudio | 10–20 s     |
| Transcrição OpenAI API  | 10–30 s     |
| Transcrição mlx-whisper | 2–4 min     |
| Geração ASS             | <1 s        |
| Render FFmpeg (HW)      | 1–3 min     |
| **Total (OpenAI)**     | **2–4 min** |
| **Total (mlx)**        | **5–8 min** |

## Modelo de transcrição

Por padrão usa OpenAI Whisper API. Para usar Whisper local no Mac:

```bash
# No backend/.env:
TRANSCRIBE_ENGINE=mlx
```

Modelos locais disponíveis:
- `mlx-community/whisper-medium-mlx-4bit` — equilíbrio velocidade/qualidade (padrão)
- `mlx-community/whisper-large-v3-turbo` — melhor qualidade, mais lento
- `mlx-community/whisper-small-mlx` — mais rápido, menos preciso

## Estrutura

```
legendas-locais/
├── backend/      # FastAPI + Whisper + FFmpeg
├── frontend/     # Next.js + Tailwind
└── data/jobs/    # arquivos por job (input, words.json, captions.ass, output.mp4)
```

Jobs antigos (mais de 7 dias) são apagados automaticamente no startup do backend.

## Deploy VPS

Para instalar em uma VPS própria com HTTPS:

```bash
git clone https://github.com/sellpayclub/gerador-legendas.git /opt/legendas-locais
cd /opt/legendas-locais
cp .env.example backend/.env
nano backend/.env  # cole OPENAI_API_KEY=sk-...
bash install.sh    # pergunta o domínio e configura HTTPS (Caddy)
```

### Atualizar

```bash
cd /opt/legendas-locais
git pull
bash install.sh --update
```

### Verificação pós-deploy

```bash
curl -s https://seu-dominio.com/api/health   # {"ok":true}
```

## Troubleshooting

- **`Could not load model` no mlx-whisper** → primeira execução baixa o modelo; verifique conexão e espaço em `~/.cache/huggingface`
- **`ffmpeg build lacks libass support`** → instale `brew install ffmpeg-full` (não o `ffmpeg` regular)
- **Legenda fora de posição** → confira se o vídeo está em tela cheia no preview antes de arrastar
- **Render lento** → verifique se `h264_videotoolbox` está disponível: `ffmpeg -encoders | grep videotoolbox`
- **Caracteres acentuados não aparecem** → troque para uma fonte com suporte a Latin Extended (Inter, Montserrat, Arial)
- **Python 3.14 + mlx-whisper com erro de wheel** → use Python 3.13

## Licença

Este projeto é open source e gratuito para uso pessoal e comercial.
