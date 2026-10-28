#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 11 — DevSecOps"
echo ""

check_workflow_exists \
  "security-scan" \
  "Security-Workflow existiert (security.yml)" \
  "security*.yml"

check_file_contains \
  "security-scan" \
  "Sicherheitsprüfung vorhanden (SAST/SCA)" \
  ".github/workflows/security*.yml" \
  "snyk|trivy|sonarqube|security|scan|sast"

check_file_contains \
  "security-scan" \
  "Security-Secret oder Token referenziert" \
  ".github/workflows/security*.yml" \
  "token|secret|key|auth"

check_file_contains \
  "security-scan" \
  "Security-Dokumentation vorhanden" \
  "README.md|SECURITY.md|docs/security.md" \
  "security|vulnerability|scan|policy"

summary 11
