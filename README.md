# TechStyle

TechStyle ist ein Flask-Demoshop für das DevOps-Projekt. Der aktuelle Stand basiert auf der übernommenen Tag-13-Containerlösung und dem an Tag 14 ergänzten AWS-Deployment. Frühere Kursartefakte sind im Repository enthalten; ihre Existenz belegt keine eigenständige Bearbeitung der jeweiligen Tage. Der [Projektabgleich für Tag 1–12](docs/PROJECT_AUDIT_DAYS_01_12.md) ordnet sie ein.

## Aktueller Aufbau

- `app.py`, `database.py`, `templates/`, `static/`: Shop und HTTP-Endpunkt `/healthz`.
- `Dockerfile`, `docker-compose.yml`: lokaler Stack mit Flask/Gunicorn und PostgreSQL.
- `docker-compose.prod.yml`, `.github/workflows/deploy-aws.yml`: Deployment nach ECR und EC2 bei Push auf `main`.
- `tests/`, `.github/workflows/ci.yml`: Anwendungstests, Linting und Paket-Build.
- `.github/classroom/`: übernommene Kurschecks; sie sind keine vollständige Abnahme des laufenden Cloud-Dienstes.

## Lokal starten

Voraussetzung: Docker Engine bzw. Docker Desktop mit Compose v2.

```bash
cp .env.container.example .env.container
# POSTGRES_PASSWORD und SECRET_KEY in .env.container setzen
docker compose --env-file .env.container up --build -d --wait
```

Danach den Shop unter <http://localhost:5001/> und den Healthcheck unter <http://localhost:5001/healthz> öffnen. Zum Beenden: `docker compose --env-file .env.container down`. Das benannte Datenbank-Volume bleibt dabei erhalten.

Ohne Container starten `./run_dev.sh` (macOS/Linux) oder `powershell -ExecutionPolicy Bypass -File .\run_dev.ps1` (Windows) die SQLite-Entwicklungsvariante. Dafür sind Python 3.11 oder neuer und die lokalen Abhängigkeiten erforderlich.

## Prüfen und deployen

```bash
python -m pip install -r requirements-container.txt pytest
python -m pytest tests/ -v
```

Der aktuelle Cloud-Deploy läuft über [Tag-14-GitHub-Actions](.github/workflows/deploy-aws.yml), nachdem die in [DEPLOYMENT.md](DEPLOYMENT.md) genannten Secrets und AWS-Ressourcen bereitstehen. Ein Push auf `main` testet den Stack, veröffentlicht ein Image mit Commit-SHA in ECR und aktualisiert EC2. Frühere Deploy-Beispiele stehen im [Archiv](docs/archive/README.md).

## Projektdokumentation

- [Tag 1–12: Projektabgleich und Aufräum-Entscheidungen](docs/PROJECT_AUDIT_DAYS_01_12.md)
- [Dokumentationsverzeichnis](docs/README.md) und [Pipeline-Überblick](docs/PIPELINE.md)
- [Tag 13: Containerisierung](docs/DAY_13_COMPLETION.md)
- [Tag 14: AWS-Deployment und Nachweise](DEPLOYMENT.md)
- [AI-Review aus Tag 12](AI_INTEGRATION.md)
- [Beitrags- und Commit-Regeln](CONTRIBUTING.md)

Die Anwendung ist ein Lehrprojekt. Die Admin-Routen in `app.py` haben derzeit keine Zugriffskontrolle; `/admin/seed` verändert Daten auch ohne Anmeldung. Der öffentliche Tag-14-Stack verwendet HTTP ohne TLS. Keine echten Kunden- oder Zahlungsdaten verwenden und die Lab-Instanz nach der Übung stoppen.
