#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 1 — AWS Setup & App Vorbereitung"
echo ""

check_file_exists \
  "aws-setup" \
  "AWS Credentials-Datei (.env) vorhanden" \
  ".env"

check_file_exists \
  "readme" \
  "README.md existiert" \
  "README.md"

check_file_contains \
  "readme" \
  "App-Dokumentation im README" \
  "README.md" \
  "app|techstyle|setup|install"

summary 1
