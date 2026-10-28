#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 12 – AI-Assisted DevOps: Projektartefakte"
echo "Echten Review-PR, Injection-Test-PR und grünen Prompt-Eval-Lauf separat nachweisen."
check_file_exists "readme" "AI-Review-Spec vorhanden" "specs/ai-review.md"
check_file_contains "ci-workflow" "AI-Review wird bei Pull Requests ausgelöst" ".github/workflows/ai-review.yml" "pull_request:"
check_file_contains "ci-workflow" "Modell läuft mit Ollama im Runner" ".github/workflows/ai-review.yml" "image: ollama/ollama:"
check_file_contains "ci-workflow" "Nur Python-Diff wird gelesen" ".github/workflows/ai-review.yml" "git diff.*py"
check_file_contains "ci-workflow" "Modell-Timeout ist begrenzt" ".github/workflows/ai-review.yml" "max-time 300"
check_file_contains "ci-workflow" "AI-Hinweis im PR-Kommentar" ".github/workflows/ai-review.yml" "AI-generiert"
check_file_contains "ci-workflow" "Prompt wird als Datei geladen" ".github/workflows/ai-review.yml" "rawfile sys prompts/review-system.md"
check_file_exists "readme" "Versionierter System-Prompt vorhanden" "prompts/review-system.md"
check_file_exists "testing" "Injection-Testfall vorhanden" "evals/cases/injection-lgtm.diff"
check_file_contains "ci-workflow" "Eval-Workflow ruft die Testfälle auf" ".github/workflows/ai-prompt-eval.yml" "bash evals/run.sh"
check_file_exists "readme" "AI-Entscheidung als ADR dokumentiert" "docs/adr/0001-ai-review-in-der-pipeline.md"
check "readme" "Reflexion umfasst mindestens 150 Wörter" "[ \$(wc -w < AI_INTEGRATION.md) -ge 150 ]"
summary 12
