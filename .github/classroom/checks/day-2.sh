#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 2 — Git Workflows & Branches"
echo ""

check_file_exists \
  "git-ignore" \
  ".gitignore existiert" \
  ".gitignore"

check_file_contains \
  "git-ignore" \
  ".gitignore hat Python-Einträge" \
  ".gitignore" \
  "__pycache__|\.pyc|\.venv|\.env"

check_file_exists \
  "version" \
  "setup.py, setup.cfg oder pyproject.toml existiert" \
  "setup.py|setup.cfg|pyproject.toml"

summary 2
