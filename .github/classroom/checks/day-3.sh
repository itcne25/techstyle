#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 3 — MVP & Dokumentation"
echo ""

check_file_exists \
  "readme" \
  "Dokumentation oder Konzept vorhanden" \
  "docs/README.md|CONCEPT.md|MVP.md|docs/architecture.md"

check_file_exists \
  "readme" \
  "App-Code (app.py) existiert" \
  "app.py|main.py|src/app.py"

check_file_contains \
  "readme" \
  "App hat Funktionalität (Imports/Funktionen)" \
  "app.py" \
  "def|import|class"

summary 3
