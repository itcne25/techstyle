#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 20 — Abschluss & Reflexion"
echo ""

check_file_exists \
  "ci-workflow" \
  "Abschlusspräsentation oder Projekt-Übersicht vorhanden" \
  "PRESENTATION.md|FINAL_REPORT.md|LESSONS_LEARNED.md|SUMMARY.md|docs/final.md"

check_file_contains \
  "ci-workflow" \
  "Lessons Learned oder Reflexion dokumentiert" \
  "LESSONS_LEARNED.md|PRESENTATION.md|FINAL_REPORT.md|README.md" \
  "lesson|learned|reflect|challenge|success|next|improve"

check_file_contains \
  "ci-workflow" \
  "Projekt-Architektur-Übersicht vorhanden" \
  "README.md|ARCHITECTURE.md|docs/*.md|PRESENTATION.md" \
  "architecture|overview|pipeline|workflow|tech.stack"

summary 20
