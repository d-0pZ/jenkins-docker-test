# --- Stage 1: Build stage for installing pip dependencies only ---
FROM python:3.12-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/home/appuser/.local/bin:$PATH"

RUN useradd -m appuser && mkdir -p /app && chown -R appuser:appuser /app

WORKDIR /app
COPY requirements.txt .

USER appuser
RUN pip install --no-cache-dir --user -r requirements.txt


# --- Stage 2: Runtime-only stage ---
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/home/appuser/.local/bin:$PATH" \
    PYTHONPATH="/app/src"

RUN useradd -m appuser && mkdir -p /app && chown -R appuser:appuser /app

COPY --from=builder /home/appuser/.local /home/appuser/.local
COPY src /app/src

USER appuser
WORKDIR /app/src

CMD ["python", "-m", "unittest", "test_user_hitcount.py", "-v"]
