#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 05 – Projektkonsolidierung Tag 01–04"
echo "Retro, Owner, Termine und tatsächliche Abnahmen bleiben manuelle Nachweise. PR-Gate und Pipeline-Tuning sind Kür."
check_file_exists "readme" "Projektabgleich vorhanden" "docs/PROJECT_AUDIT_DAYS_01_12.md"
check_file_contains "readme" "Rückstände transparent erfasst" "docs/PROJECT_AUDIT_DAYS_01_12.md" "Rückstände"
summary 5
