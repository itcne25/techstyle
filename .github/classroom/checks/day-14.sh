#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 14 — Container Basics"
echo ""

check_file_exists \
  "dockerfile" \
  "Dockerfile existiert" \
  "Dockerfile"

check_file_contains \
  "dockerfile" \
  "Dockerfile hat Base-Image (FROM)" \
  "Dockerfile" \
  "^FROM"

check_file_exists \
  "dockerfile" \
  ".dockerignore existiert" \
  ".dockerignore"

check_file_contains \
  "dockerfile" \
  "Non-Root User oder USER-Anweisung vorhanden (Security Best Practice)" \
  "Dockerfile" \
  "^USER"

summary 14
