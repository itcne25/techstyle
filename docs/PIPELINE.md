# Pipeline-Überblick

## Aktive Workflows

| Datei | Auslöser | Zweck und Ergebnis |
| --- | --- | --- |
| `ci.yml` | Push/PR auf `main` und `day_*` | `lint` prüft Tests und Fixture; `test` führt Pytest mit Coverage aus; optionaler SonarQube-Job wertet das Quality Gate aus; `build` erzeugt sdist/Wheel und lädt sie hoch |
| `deploy-aws.yml` | Push auf `main`, manuell | Anwendungstests und laufenden Compose-Stack prüfen → SHA-Image nach ECR → Stack auf EC2 aktualisieren → lokale und öffentliche Healthchecks |
| `classroom.yml` | Push, PR, manuell | Strukturelle Projektchecks für den ermittelten Kurstag; aktuell steht `.github/classroom/day` auf `14` |
| `ai-review.yml` | PR mit Python-Änderungen | Ollama im Runner starten, Python-Diff bewerten, Kommentar mit AI-Hinweis schreiben |
| `ai-prompt-eval.yml` | PR mit Prompt-/Eval-/AI-Workflow-Änderungen, manuell | Modellantworten gegen die versionierten Erwartungsmuster prüfen |
| `container.yml` | Branch `day_13_solution`, manuell | Übernommener Tag-13-Containercheck und optionale GHCR-Veröffentlichung; aktuelles Cloudimage kommt aus ECR |

Die Tag-14-Pipeline ist der aktuelle Deploy-Weg. `ci.yml` prüft zusätzlich Paketierung und Coverage; diese Lernziele werden deshalb nicht in den Container-Deploy hineinkopiert. Der aktivierbare SonarQube-Scan ist in [DAY_7_COMPLETION.md](DAY_7_COMPLETION.md) beschrieben. Der Tag-14-Deploy hängt derzeit nicht von diesem separaten CI-Workflow ab.

## Nachvollziehbarkeit

Die belegten Tag-14-Läufe und Image-URIs stehen in [DEPLOYMENT.md](../DEPLOYMENT.md). Für einen Fehler zuerst den fehlgeschlagenen Job und dessen Log öffnen. Ein abgebrochener Test verhindert in `deploy-aws.yml` durch `needs` den ECR-Push und das Deployment. Containerlogs werden im Fehlerfall ausgegeben; temporäre Testcontainer und Testvolumes werden anschliessend entfernt.

Es liegen keine belastbaren Laufzeitmessungen vor, mit denen eine Pipeline-Beschleunigung aus Tag 05 belegt werden könnte. Zeiten sollen aus einem konkreten Actions-Lauf übernommen werden, statt sie aus der Musterlösung abzuschreiben. Der derzeitige Überblick ist deshalb ein Zweck- und Abhängigkeitsverzeichnis, kein erfundenes Performanceprotokoll.

## Entfernte und archivierte Teile

Die frühere `main.yml` rief vier wiederverwendbare Workflows auf, die jeweils nur „Not implemented yet“ ausgaben. Sie und `.github/scripts/check-workflows.sh` wurden entfernt. Sie lieferten weder Tests noch Builds und erzeugten einen irreführenden zusätzlichen grünen Lauf.

Die früheren IaC-/Blue-Green-Workflows stehen unter [archive/day08/](archive/day08/). Ihre Originalkonfiguration arbeitet mit einem anderen S3-State und einer anderen AWS-Umgebung. Eine Reaktivierung ist eine eigene technische Änderung und kein Bestandteil des aktuellen Deploys.

## Kurschecks richtig lesen

Die Projektchecks für Tag 01–12 orientieren sich an der bereitgestellten Tagesplanung. Sie prüfen Repo-Artefakte, keine mündlichen Leistungen, echten Browseraufrufe oder externen Teamhandlungen. Ein grüner Dateicheck beweist weder ein laufendes Grafana noch einen getesteten Rollback. Die offenen manuellen Nachweise bleiben im [Projektabgleich](PROJECT_AUDIT_DAYS_01_12.md) sichtbar.
