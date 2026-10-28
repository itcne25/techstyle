#!/bin/bash
source .github/classroom/grade.sh

echo "🔍 Prüfe Abnahmekriterien für Tag 17 — Infrastructure as Code (Terraform)"
echo ""

check_directory_exists \
  "ci-workflow" \
  "Terraform-Verzeichnis existiert" \
  "terraform|infrastructure|iac"

check_file_contains \
  "ci-workflow" \
  "Terraform-Konfiguration vorhanden" \
  "terraform/*.tf|infrastructure/*.tf" \
  "resource|provider|variable|output"

check_file_contains \
  "ci-workflow" \
  "Backend-Konfiguration für Terraform State" \
  "terraform/backend.tf|terraform/*.tf" \
  "backend|s3|remote|state"

summary 17
