#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 6 — Testing & Code Quality"
echo ""

check_file_exists \
  "testing" \
  "Test-Dateien vorhanden (tests/ oder test_*.py)" \
  "tests/*.py|test_*.py|*_test.py"

check_file_contains \
  "testing" \
  "pytest oder Unittest importiert" \
  "tests/*.py|test_*.py|conftest.py" \
  "pytest|unittest|test_"

check_file_contains \
  "testing" \
  "Quality Gate konfiguriert (SonarQube/Codecov)" \
  ".github/workflows/ci.yml|sonar-project.properties" \
  "sonar|codecov|quality|coverage"

summary 6
