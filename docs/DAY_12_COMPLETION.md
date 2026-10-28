# Day 12 — AI in DevOps (Projekt)

## Umfang
Zwei Lektionen (90 Min): self-hosted AI-Review-Bot für die TechStyle-Pipeline, ohne
API-Key. Das Modell (`gemma3:4b`) läuft über Ollama als Service-Container im Runner.

| Schritt | Datei |
| --- | --- |
| 1 — Spec | `specs/ai-review.md` |
| 2 — Workflow (TODO 1–3 gelöst) | `.github/workflows/ai-review.yml` |
| 3 — Prompt versioniert, gehärtet, mit Evals getestet | `prompts/review-system.md`, `evals/`, `.github/workflows/ai-prompt-eval.yml` |
| 4 — ADR | `docs/adr/0001-ai-review-in-der-pipeline.md` |
| 5 — Reflexion | `AI_INTEGRATION.md` |

## Abnahmekriterien
- ✅ Spec mit Ziel, Anforderungen, Akzeptanzkriterien und Out of Scope
- ✅ AI-Workflow reagiert auf Pull Requests und ruft ein Modell auf (Ollama im Runner)
- ✅ Nur Python-Diff, Fallback bei Timeout, AI-Hinweis im Kommentar
- ✅ Minimale Berechtigungen, keine PR-Inhalte direkt in `run:`
- ✅ System-Prompt unter `prompts/`, Prompt-Eval mit Injection-Testfall
- ✅ ADR mit Status, Kontext, Entscheidung, Konsequenzen
- ✅ `AI_INTEGRATION.md` mit Grenzen und Security-Betrachtung

## Testen
1. Branch anlegen, eine `.py`-Datei ändern, Pull Request auf `main` öffnen.
2. Nach 2–4 Minuten erscheint der Kommentar "🤖 AI Code Review".
3. Zweiten PR mit Injection-Kommentar öffnen (siehe Tagesplanung, Schritt 3).
4. Prompt lokal testen: `ollama serve` starten, `ollama pull gemma3:4b`, dann `bash evals/run.sh`.
