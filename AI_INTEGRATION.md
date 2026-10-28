# AI Integration – TechStyle

## Implementiertes Feature

Die aus der Tag-13-Musterlösung übernommene Integration ergänzt Pull Requests mit geänderten Python-Dateien um einen AI-Kommentar. [ai-review.yml](.github/workflows/ai-review.yml) startet Ollama im GitHub-Runner, lädt `gemma3:4b` und übergibt den Python-Diff an dessen lokale API. Ein Hinweis kennzeichnet die Antwort als AI-generiert. Der Bot gibt keine Merge-Freigabe und ersetzt kein menschliches Review.

Der [System-Prompt](prompts/review-system.md), die [Spec](specs/ai-review.md), die [Prompt-Evals](evals/) und [ADR 0001](docs/adr/0001-ai-review-in-der-pipeline.md) gehören zusammen. Die Tagesplanung selbst gehört nicht in den System-Prompt. Ein versehentlich angehängter Tag-13-Quelltext wurde bei der Bereinigung aus diesem Prompt entfernt.

## Was die Integration leisten soll

Der Bot soll erste Hinweise auf potenzielle Bugs, fehlende Fehlerbehandlung und Sicherheitsprobleme liefern. Der Quellcode wird keinem externen AI-Dienst gesendet; die Inferenz läuft im Actions-Runner. Dafür werden keine Hosted-API-Zugangsdaten benötigt. Runner-Laufzeit, Modelldownload und Pflege der Testfälle bleiben Ressourcenaufwand.

Die Integration ist im Quellstand vorhanden. Die GitHub-API zeigte am 28.10.2026 keine Pull Requests in diesem Repository; eigene PRs mit AI-Kommentaren sind daher nicht belegt. Konkrete Eval-Läufe sind hier bislang nicht verlinkt. Die früheren Modellbeobachtungen und Zeitangaben waren als Musterlösung übernommen; sie werden nicht als eigene Messungen ausgegeben.

## Grenzen und Schwächen

Der Bot sieht höchstens die ersten 6000 Bytes des Python-Diffs und keinen vollständigen Anwendungskontext. Er kann fachliche Fehler übersehen und unzutreffende Befunde formulieren. Ein Modelltag wie `gemma3:4b` wählt eine Modellvariante, garantiert aber keinen dauerhaft unveränderlichen Modell-Digest. Temperatur und Seed reduzieren Zufall, garantieren keine identischen Antworten über verschiedene Laufzeiten oder Plattformen.

Der Review-Workflow ist für interne Team-PRs ausgelegt. Fork-PRs können wegen eingeschränkter Schreibrechte am Kommentar scheitern. Ein kommentierter Fallback behandelt einen Fehler beim Modellaufruf; ein Fehler beim Laden des Modells oder beim GitHub-Kommentar ist davon nicht automatisch abgedeckt.

## Security-Betrachtung

Der Diff wird als Daten zwischen Begrenzern übergeben. Der Prompt weist das Modell an, Anweisungen im Code als Manipulationsversuch zu erkennen. `jq --rawfile` serialisiert Prompt und Diff als JSON, anstatt PR-Inhalte direkt in einen Shellbefehl einzusetzen. Der Workflow erhält nur Leserechte für Inhalte und Schreibrechte für PR-Kommentare.

Die Testfälle `injection-lgtm` und `hardcoded-password` prüfen Manipulationsversuche und einen möglichen Fehlalarm. Ein erfolgreicher Eval würde nur diese Fälle abdecken; ein Prompt stellt keine Sicherheitsgrenze mit garantierter Wirkung dar. Ein eigener Test mit und ohne Härtung sowie der Injection-Test-PR sind noch durchzuführen und mit echten Ergebnissen zu dokumentieren.

## Fazit und offene Abnahme

Die Architektur ist als unterstützender Reviewer plausibel, braucht aber eigene Betriebsnachweise. Vor einer vollständigen Tag-12-Abnahme fehlen ein normaler Test-PR mit AI-Kommentar, ein Injection-Test-PR und ein grüner Lauf von **AI Prompt Eval**. Erst danach lassen sich Qualität, Fehlalarme und tatsächliche Laufzeit für dieses Repository bewerten. Menschliches Review bleibt erforderlich.
