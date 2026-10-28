#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 09 – Projektaufträge Tag 01–07 aufarbeiten"
echo "Kein neuer Prometheus-/Grafana-Projektauftrag. Offene Aufgaben und Retro manuell bewerten."
check_file_exists "readme" "Bestandsaufnahme der bisherigen Projektaufträge vorhanden" "docs/PROJECT_AUDIT_DAYS_01_12.md"
check_file_contains "readme" "Nächste überprüfbare Schritte erfasst" "docs/PROJECT_AUDIT_DAYS_01_12.md" "Abschlussbeleg"
summary 9
