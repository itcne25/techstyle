#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 8 — Monitoring & Observability Setup"
echo ""

check \
  "ci-workflow" \
  "CI/CD Workflows vorhanden" \
  "[ -d '.github/workflows' ] && ls .github/workflows/*.yml &>/dev/null"

check_file_contains \
  "ci-workflow" \
  "Logging oder Monitoring in App erwähnt" \
  "README.md|docs/*.md|app.py" \
  "log|monitor|metric|prometheus|grafana"

check_file_exists \
  "ci-workflow" \
  "Health-Check oder Status-Endpoint dokumentiert" \
  "README.md|docs/*.md"

summary 8
