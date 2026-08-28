# Git Workflow
 
## Branching Strategy

Wir verwenden **GitHub Flow**.
 
- `main` enthält immer stabilen, produktionsfähigen Code.

- Änderungen erfolgen in separaten Branches.

- Branch-Namen:

  - `feature/<name>`

  - `bugfix/<name>`

  - `hotfix/<name>`
 
## Merge Strategy

Änderungen werden über Pull Requests gemerged.
 
Standard:

- **Squash Merge** für Features und Bugfixes

- **Rebase** nur lokal zum Aktualisieren eines Branches

- Keine direkten Änderungen auf `main`
 
## Pull Requests

Vor dem Merge:
 
- mindestens 1 Review

- Tests erfolgreich

- keine Merge-Konflikte

- verständliche Beschreibung
 
## Commits

Wir verwenden **Conventional Commits**:
 
```text

feat: add shopping cart

fix: correct checkout error

docs: update README

chore: update .gitignore

```
 
## Releases

Wir verwenden **Semantic Versioning**:
 
```text

MAJOR.MINOR.PATCH

```
 
Beispiele:
 
```text

v1.0.0

v1.1.0

v1.1.1

```
 
Releases werden aus `main` erstellt und mit einem Git-Tag versehen.
 
## Konflikte

Merge-Konflikte löst grundsätzlich der Autor des Pull Requests. Danach werden die Tests erneut ausgeführt.
 
