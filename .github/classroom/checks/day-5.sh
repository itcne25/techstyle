#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 5 — Artifacts & Package Management"
echo ""

check_file_contains \
  "ci-workflow" \
  "CI Workflow hat Upload- oder Publish-Schritt" \
  ".github/workflows/ci.yml" \
  "upload-artifact|github.packages|publish|npm|pip"

check_file_exists \
  "version" \
  "requirements.txt oder setup.py existiert" \
  "requirements.txt|setup.py|setup.cfg|pyproject.toml"

check_file_contains \
  "version" \
  "Dependencies definiert (mit Versionen)" \
  "requirements.txt|setup.py" \
  "=="

summary 5
