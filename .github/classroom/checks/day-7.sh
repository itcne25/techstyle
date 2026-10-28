#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 07 – SonarQube-Anbindung"
echo "Server, tatsächlicher Scan und rotes/grünes Quality Gate müssen separat nachgewiesen werden."
check_file_exists "ci-workflow" "SonarQube-Projektkonfiguration vorhanden" "sonar-project.properties"
check_file_contains "ci-workflow" "Scanner wartet auf das Quality Gate" "sonar-project.properties" "^sonar.qualitygate.wait=true"
check_file_contains "ci-workflow" "SonarQube-Scanner in CI integriert" ".github/workflows/ci.yml" "uses: SonarSource/sonarqube-scan-action@"
check_file_contains "ci-workflow" "SonarQube-Token aus Secret" ".github/workflows/ci.yml" "secrets.SONAR_TOKEN"
check_file_contains "testing" "Coverage-Datei ist konfiguriert" "sonar-project.properties" "coverage.xml"
check_file_exists "readme" "Aktivierung und offene Abnahme dokumentiert" "docs/DAY_7_COMPLETION.md"
summary 7
