#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 13 - Container: strukturelle Abnahmekriterien"
echo "Der Laufnachweis erfolgt im Container-Workflow, nicht durch diese Dateipruefung."
check_file_exists "container" "Dockerfile vorhanden" "Dockerfile"
check_file_exists "container" "Compose-Datei vorhanden" "docker-compose.yml"
check_file_exists "container" "Buildkontext begrenzt" ".dockerignore"
check_file_contains "container" "Datenbank konfigurierbar" "database.py" "DATABASE_URL"
check_file_contains "container" "PostgreSQL-Service definiert" "docker-compose.yml" "postgres:"
check_file_contains "container" "Persistentes Volume definiert" "docker-compose.yml" "postgres-data:"
check_file_exists "container" "Container-Laufnachweis implementiert" "scripts/container_smoke.py"
check_file_contains "container" "Registry-Publish nach Tests" ".github/workflows/container.yml" "needs: verify"
check_file_exists "container" "Architektur und Bedienung dokumentiert" "docs/DAY_13_COMPLETION.md"
summary 13
