#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 08 – Deployment-Projekt weiterführen"
echo "Gewählte Basis, funktionierende Teile, Fehler, Erweiterung und echte Prüfungen im Projektabgleich abnehmen."
check_file_exists "deploy-doc" "Deployment dokumentiert" "DEPLOYMENT.md"
check_file_exists "cd-workflow" "Aktueller Deploy-Workflow vorhanden" ".github/workflows/deploy-aws.yml"
check_file_contains "deploy-stage" "Healthcheck wird ausgeführt" ".github/workflows/deploy-aws.yml" "curl.*healthz"
check_file_contains "deploy-stage" "Container startet mit Gunicorn" "Dockerfile" "gunicorn"
check_file_contains "deploy-stage" "Initialisierung bewahrt vorhandene Seed-Daten" "docker/entrypoint.sh" "--if-empty"
summary 8
