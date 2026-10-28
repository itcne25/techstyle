#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 9 — Monitoring Grundlagen (Prometheus/Grafana)"
echo ""

check_file_exists \
  "ci-workflow" \
  "Prometheus-Konfiguration vorhanden" \
  "prometheus.yml|monitoring/prometheus.yml|docs/monitoring.md"

check_file_contains \
  "ci-workflow" \
  "Prometheus oder Metriken erwähnt" \
  "README.md|docs/*.md|app.py" \
  "prometheus|metrics|scrape|monitoring"

check_file_exists \
  "ci-workflow" \
  "Grafana-Konfiguration oder Dashboard vorhanden" \
  "grafana/dashboards/*.json|dashboards/*.json|monitoring/grafana.yml"

summary 9
