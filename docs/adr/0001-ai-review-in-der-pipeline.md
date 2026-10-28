# ADR 0001: AI-Review in der CI/CD-Pipeline

## Status
Akzeptiert; mit der Tag-13-Musterlösung übernommen. Eigene Laufnachweise siehe `AI_INTEGRATION.md`.

## Kontext
Pull Requests auf TechStyle warten oft Stunden auf ein menschliches Review. Einfache Fehler
(fehlende Fehlerbehandlung, hartkodierte Secrets, falsche Randfälle) rutschen trotzdem durch.
Das Team will eine schnelle erste Einschätzung pro PR, ohne die menschliche Freigabe
aufzugeben. Die Security-Verantwortliche verlangt, dass der Code keinen externen AI-Dienst
erreicht, und das Team will keine kostenpflichtigen API-Keys verwalten.

Geprüfte Optionen:

| Option | Datenschutz | Qualität | Kosten / Aufwand |
| --- | --- | --- | --- |
| Hosted API (OpenAI, Anthropic) | Code geht an Dritte | hoch | kostenpflichtig, Secret nötig |
| Hosted Free Tier (z. B. Groq) | Code geht an Dritte | mittel bis hoch | Account, Secret, Rate-Limits |
| **Self-hosted im Runner (Ollama)** | Code bleibt im Runner | vor eigener Abnahme zu bewerten | keine Hosted-API-Kosten, zusätzlicher Runner-Aufwand |

## Entscheidung
Wir ergänzen die Pipeline um `.github/workflows/ai-review.yml`:

- Trigger: `pull_request` mit geänderten `*.py`-Dateien
- Modell: `gemma3:4b` über Ollama (`ollama/ollama:0.34.4`) als Service-Container im Runner,
  feste Modellvariante und Imageversion, bislang kein dokumentierter Modell-Digest; Aufruf über die OpenAI-kompatible API von Ollama
- Eingabe: nur der Python-Diff, max. 6000 Bytes, zwischen `<diff>`-Begrenzern; der
  System-Prompt liegt versioniert in `prompts/review-system.md`
- `temperature: 0` und fester `seed` zur Verringerung zufälliger Abweichungen; keine Garantie identischer Antworten
- Ausgabe: ausschliesslich ein PR-Kommentar mit AI-Hinweis — **kein** Merge-Gate
- Fallback-Kommentar, wenn das Modell nicht rechtzeitig antwortet
- Prompt-Änderungen laufen durch `.github/workflows/ai-prompt-eval.yml` (Regressionstest)

## Konsequenzen
- **Nutzen:** Erste Rückmeldung innert Minuten; Reviewer sehen offensichtliche Punkte vorab.
- **Kosten:** Keine Hosted-API-Kosten. Modelldownload und CPU-Inferenz brauchen Runner-Ressourcen.
  Eine tatsächliche Laufzeit wurde für dieses Team noch nicht dokumentiert.
- **Qualität:** Fachliche Fehler, erfundene Befunde und Fehlalarme sind mögliche Grenzen.
  Die eigenen Test-PRs und Evals müssen diese für die gewählte Modellvariante überprüfen.
- **Security:** Der PR-Autor kontrolliert einen Teil des Prompts (indirekte Prompt Injection).
  Begrenzer, gehärteter System-Prompt und Prompt-Evals senken das Risiko, beseitigen es
  nicht — deshalb hat der Bot keine Entscheidungsbefugnis und nur `pull-requests: write`.
  PR-Inhalte gelangen nur über `env:`/Dateien in Skripte (keine Script Injection).
- **Wartung:** Modell- und Image-Updates laufen über einen PR, der die Prompt-Evals
  durchlaufen muss. Ein Wechsel zu einem Hosted-Modell braucht einen neuen ADR.
