#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 7 — CD & Deployment"
echo ""

check_workflow_exists \
  "cd-workflow" \
  "CD/Deployment Workflow existiert (deploy.yml oder cd.yml)" \
  "deploy*.yml|cd*.yml"

check_file_contains \
  "cd-workflow" \
  "Deployment-Umgebungen (environments) konfiguriert" \
  ".github/workflows/deploy*.yml|.github/workflows/cd*.yml" \
  "environment:|env:|secrets"

check_file_contains \
  "cd-workflow" \
  "Deployment-Script oder Deploy-Befehl vorhanden" \
  ".github/workflows/deploy*.yml|.github/workflows/cd*.yml|deploy.sh" \
  "deploy|release|push"

summary 7
