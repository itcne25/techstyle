#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 06 – Artefaktverwaltung"
echo "Ein konkretes Artefakt zusätzlich herunterladen und inspizieren; Dateiprüfungen belegen diesen Schritt nicht."
check_file_exists "version" "Python-Build konfiguriert" "pyproject.toml"
check_file_contains "ci-workflow" "Paket-Build im Workflow" ".github/workflows/ci.yml" "python -m build"
check_file_contains "ci-workflow" "Temporäres Artefakt wird hochgeladen" ".github/workflows/ci.yml" "actions/upload-artifact"
check_file_contains "readme" "Registry-Entscheidung dokumentiert" "docs/DAY_6_COMPLETION.md" "pypiserver"
summary 6
