FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
WORKDIR /app

# Cache dependencies separately; tests and development tools stay outside the image.
COPY requirements-container.txt .
RUN pip install --no-cache-dir -r requirements-container.txt \
    && groupadd --gid 10001 app \
    && useradd --uid 10001 --gid app --create-home app

COPY app.py database.py seed_data.py ./
COPY templates ./templates
COPY static ./static
COPY --chmod=755 docker/entrypoint.sh /usr/local/bin/techstyle-entrypoint

LABEL org.opencontainers.image.source="https://github.com/tbzdevops/techstyle"
USER 10001:10001
EXPOSE 5001
ENTRYPOINT ["techstyle-entrypoint"]
CMD ["gunicorn", "--workers", "2", "--bind", "0.0.0.0:5001", "--access-logfile", "-", "--error-logfile", "-", "app:app"]
