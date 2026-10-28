# Historische Deploy-Beispiele

Diese Dateien stammen aus dem übernommenen Kursstand. Sie dokumentieren frühere Ansätze und werden nicht von GitHub Actions ausgeführt, weil sie ausserhalb von `.github/workflows/` liegen.

| Artefakt | Bedeutung |
| --- | --- |
| `deploy-manual.sh` | Frühes SCP/SSH-Beispiel mit fest eingetragener fremder Server-IP; nicht auf die aktuelle EC2 anwenden. |
| `day08/aws_infrastruktur.yml` | OpenTofu-Provisionierung mit separatem S3-State für `day_8_solution`. |
| `day08/aws_infrastruktur_destroy.yml` | Abbau genau dieser früheren Infrastruktur. Die zugehörige `infrastruktur/destroy.conf` steht im übernommenen Stand auf `destroy=true`. |
| `day08/ci_cd_blue_green.yml` | Deployment und ALB-Umschaltung des früheren Blue-Green-Beispiels. |

Die zugehörigen Dateien `infrastruktur/` und `deploy_docker.sh` stehen ebenfalls unter `day08/`. Die archivierten Workflows enthalten noch die ursprünglichen Pfade relativ zur damaligen Repository-Wurzel. Ihr State, ihre Ressourcen und ihre SSH-Secret-Namen entsprechen nicht dem aktuellen Tag-14-Stack. Ein funktionierender früherer AWS-Lauf ist damit nicht nachgewiesen.

Das aktuelle Deployment wird ausschliesslich in [DEPLOYMENT.md](../../DEPLOYMENT.md) beschrieben. Eine spätere Reaktivierung eines archivierten Workflows erfordert zuerst die Prüfung seiner Ressourcen, Secrets und Pfade.
