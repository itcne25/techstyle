#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 14 - AWS-Deployment: strukturelle Abnahmekriterien"
echo "Einen erfolgreichen Cloud-Lauf, die Shop-URL und das Rollback bitte separat nachweisen."

check_file_exists "compose-file" "Produktions-Compose vorhanden" "docker-compose.prod.yml"
check_file_contains "compose-file" "Webimage wird aus ECR bezogen" "docker-compose.prod.yml" "TECHSTYLE_IMAGE"
check_file_contains "compose-file" "Shop wird auf Port 80 angeboten" "docker-compose.prod.yml" "80:5001"
check_file_contains "compose-file" "PostgreSQL-Daten sind persistent" "docker-compose.prod.yml" "postgres-data:"
check_file_exists "cd-workflow" "AWS-Workflow vorhanden" ".github/workflows/deploy-aws.yml"
check_file_contains "ci-trigger" "Deployment startet bei Push auf main" ".github/workflows/deploy-aws.yml" "branches:.*main"
check_file_contains "testing" "Tests vor Build" ".github/workflows/deploy-aws.yml" "needs: test"
check_file_contains "ecr-push" "Image wird nach ECR gepusht" ".github/workflows/deploy-aws.yml" "docker push"
check_file_contains "ecr-push" "Commit-SHA wird als Image-Tag genutzt" ".github/workflows/deploy-aws.yml" "GITHUB_SHA"
check_file_contains "aws-credentials" "AWS-Zugangsdaten kommen aus Secrets" ".github/workflows/deploy-aws.yml" "secrets.AWS_SESSION_TOKEN"
check_file_contains "deploy-stage" "Deployment folgt auf Build" ".github/workflows/deploy-aws.yml" "needs: build"
check_file_contains "deploy-stage" "Compose wartet auf gesunde Container" ".github/workflows/deploy-aws.yml" "up -d --no-build --wait"
check_file_exists "deploy-doc" "Deployment dokumentiert" "DEPLOYMENT.md"

summary 14
