#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 01 – Projektstart: Repo-Artefakte"
echo "AWS-Login und laufende lokale Startseite sind manuell nachzuweisen; keine Credential-Datei wird verlangt."
check_file_exists "readme" "Projektübersicht vorhanden" "README.md"
check_file_exists "readme" "Flask-Anwendung vorhanden" "app.py"
check_file_exists "readme" "Lokaler Einstieg dokumentiert" "run_dev.sh|run_dev.ps1"
summary 1
