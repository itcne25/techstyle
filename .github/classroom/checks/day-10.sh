#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 10 — Alerting & Dashboards"
echo ""

check_file_contains \
  "ci-workflow" \
  "Alert-Rules oder Alert-Konfiguration vorhanden" \
  "prometheus/rules.yml|rules.yml|app.py|README.md" \
  "alert|rule|threshold|trigger"

check_file_exists \
  "ci-workflow" \
  "Dashboard-Definition vorhanden" \
  "grafana/dashboards/*.json|dashboards/*.json"

check_file_contains \
  "ci-workflow" \
  "Alerting-Dokumentation existiert" \
  "README.md|docs/monitoring.md|docs/alerts.md" \
  "alert|notification|on-call"

summary 10
