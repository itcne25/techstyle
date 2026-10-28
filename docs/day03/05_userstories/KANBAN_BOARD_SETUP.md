# Kanban Board Setup für MVP 1

**Projekt:** https://github.com/orgs/tbzdevops/projects/1  
**Feature:** Rabatt- & Gutscheincodes (MVP Phase 1)  
**Woche:** 11.06.-15.06.2026

---

## 📊 Kanban Board Struktur (Aufgabe 4)

### Spalten-Setup

Das Kanban Board sollte diese Spalten haben (falls noch nicht von Tag 1 vorhanden):

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│  Backlog     │  Ready for   │  In          │  Code Review │  Ready for   │  Done        │
│              │  Dev         │  Progress    │  / Testing   │  Deployment  │              │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│              │              │              │              │              │              │
│ [Zukünftige] │ [MVP1 Stories│ [In Work]    │ [Waiting]    │ [Production  │ [Completed]  │
│ [Features]   │ ready]       │              │              │ Ready]       │              │
│              │              │              │              │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
```

### Optional: WIP Limits (Work in Progress)

Setze WIP-Limits pro Spalte, um zu verhindern, dass zu viel parallel läuft:

| Spalte | WIP-Limit | Begründung |
|--------|-----------|-----------|
| In Development | 3 | Max. 3 Personen arbeiten gleichzeitig |
| Code Review | 2 | Nicht zu viele Reviews parallel |
| Testing | 2 | QA kann max. 2 Features parallel testen |

---

## 🎯 Initiale Board-Belegung (Montag 11.06.)

Nachdem alle User Stories erstellt sind, sollte das Board so aussehen:

### Backlog (künftige Features)
```
- Personalisierte Produktempfehlungen (Phase 3+)
- Social Media Sharing
- E-Mail Marketing Integration
- Bewertungssystem
```

### Ready for Development (MVP 1 Stories)
```
✅ EPIC-001: Rabatt-Code-System
  ├─ TS-101: Code-Generierungs-Logik (1h)
  ├─ US-105: Datenbank-Schema (1-2h)
  ├─ TS-102: Code-Validierungs-Logik (2h)
  ├─ US-104: Code-Validierungs-API (2-3h)
  ├─ US-103: Admin-Panel (3-4h)
  ├─ US-101: Checkout Code-Input (2-3h)
  ├─ US-102: Rabatt-Anzeige (1-2h)
  ├─ TEST-101: Unit Tests (1-2h)
  ├─ TEST-102: Integration Tests (1-2h)
  └─ TEST-103: Manual Testing (2-3h)
```

---

## 📅 Tägliches Board-Management

### Montag 11.06. – Kick-Off & Start
```
Ready for Development:  10 Stories (ungestartet)
In Development:         [leer]
Code Review:            [leer]
Testing:                [leer]
Ready for Deployment:   [leer]
Done:                   [leer]
```

**Team starts working** → Verschiebe Stories nach "In Development"

---

### Dienstag-Donnerstag 12.06.-14.06. – Active Development
```
Ready for Development:  2-3 Stories (noch zu starten)
In Development:         3-4 Stories (aktiv in Arbeit)
Code Review:            2-3 Stories (warten auf Review)
Testing:                1-2 Stories (in Test-Phase)
Ready for Deployment:   0-1 Stories (bereit für Go-Live)
Done:                   2-4 Stories (fertiggestellt)
```

**Daily Standup:** Morning Check-In, Blockers identifizieren

---

### Freitag 15.06. – Go-Live Target
```
Ready for Development:  [leer] ✅
In Development:         [leer] ✅
Code Review:            [leer] ✅
Testing:                [leer] ✅
Ready for Deployment:   [leer] ✅
Done:                   All 10 Stories ✅
```

**13:00 Uhr:** Code gemergt in `production`  
**14:00 Uhr:** Deployment in Production  
**15:00 Uhr:** Go-Live Celebration 🎉

---

## 🔄 Status-Übergangs-Richtlinien

Wann verschieben wir ein Issue?

### Ready for Dev → In Development
- **Wer:** Team-Member, der arbeiten anfängt
- **Wann:** Wenn man anfängt zu arbeiten (am selben Tag)
- **Wie:** Klick Issue → Status "In Development" setzen

### In Development → Code Review
- **Wer:** Developer, wenn Code fertig
- **Wann:** Wenn Code committed & PR geöffnet
- **Wie:** Issue-Kommentar: "Ready for review" + PR-Link

### Code Review → Testing
- **Wer:** Reviewer, nach Approval
- **Wann:** Nach erfolgreichem Code Review
- **Wie:** Issue-Status → "Testing"

### Testing → Ready for Deployment
- **Wer:** QA, wenn Tests bestanden
- **Wann:** Wenn Unit Tests + Manual Tests bestanden
- **Wann:** Nicht bei Bugs! (Zurück zu "In Development")

### Ready for Deployment → Done
- **Wer:** DevOps, nach Deployment
- **Wann:** Nach erfolgreichem Deployment in Production
- **Wie:** Issue schließen + Status "Done"

---

## 📋 Tägliche Board-Review Checkliste

**Jeden Morgen (09:00 Uhr):**

- [ ] Öffne https://github.com/orgs/tbzdevops/projects/1
- [ ] Überprüfe "In Development" Spalte:
  - [ ] Sind Personen zugewiesen?
  - [ ] Gibt es Comments/Updates?
  - [ ] Blockers sichtbar?
- [ ] Überprüfe "Code Review" Spalte:
  - [ ] Warten PRs auf Review?
  - [ ] Sind Reviews blockiert?
- [ ] Überprüfe "Testing" Spalte:
  - [ ] Sind Tests durchgeführt?
  - [ ] Gibt es Bugs zu melden?
- [ ] Überprüfe "Ready for Deployment":
  - [ ] Sind Items bereit für Produktion?

---

## 🚀 Deployment & Go-Live Workflow

### Freitag 15.06. – Deployment Steps

1. **14:00 - Code Deployment**
   ```
   1. Alle Issues → "Done" Status
   2. Code gemergt in main/production Branch
   3. CI/CD Pipeline durchlaufen (Tag 04)
   4. Tests bestanden
   5. Deployment in Staging durchführen
   6. Smoke Tests in Staging
   ```

2. **14:30 - Production Deployment**
   ```
   1. Finales OK vom Team
   2. Deployment zu Production
   3. Health Checks durchführen
   4. Monitoring aktiviert
   ```

3. **15:00 - Go-Live**
   ```
   1. Marketing wird informiert
   2. Erste Test-Codes erstellen
   3. Live-Monitoring
   4. Bereit für Support
   ```

---

## 📊 Metriken & Burndown

Wir tracken diese Metriken während der Woche:

| Metrik | Target | Aktuell |
|--------|--------|---------|
| Issues total | 10 | |
| Issues in "Done" | 10 ✅ | |
| Story Points completed | 19-28h | |
| Code Coverage | >85% | |
| Test Pass Rate | 100% | |
| Critical Bugs | 0 | |

---

## 🎯 Success Criteria für diese Woche

✅ **Aufgabe 4 (Kanban Board Anpassung):**
- [ ] Board hat 6 Spalten (Backlog → Done)
- [ ] MVP 1 Stories sind eingefügt
- [ ] Spalten sind mit Labels/Farben gekennzeichnet
- [ ] WIP-Limits sind gesetzt (optional aber empfohlen)
- [ ] Team versteht das Board-Workflow

✅ **Aufgabe 5 (User Stories erstellen):**
- [ ] 1 Epic (EPIC-001) erstellt
- [ ] 7 User Stories erstellt (US-101–US-105, TS-101, TS-102)
- [ ] 3 Test Stories erstellt (TEST-101–TEST-103)
- [ ] Alle Stories haben:
  - [ ] Eindeutige ID
  - [ ] User Story Format (As a... I want... So that...)
  - [ ] Akzeptanz-Kriterien (Checkboxes)
  - [ ] Aufwands-Schätzung
  - [ ] Abhängigkeiten
  - [ ] Labels

✅ **Bonus – Board-Ready:**
- [ ] Stories sind in "Ready for Development" Spalte
- [ ] Team-Mitglieder sind zugewiesen
- [ ] Es gibt einen Sprint-Start für Montag

---

## 📚 Referenzen

- **User Stories:** `docs/day03/02_mvp/user_stories_mvp1.md`
- **Setup Guide:** `docs/day03/GITHUB_SETUP_GUIDE.md`
- **MVP Definition:** `docs/day03/02_mvp/selected_feature_mvp.md`
- **Marketing Feedback:** `docs/day03/03_feedback/marketing_feedback.md`

---

**Status:** 🟢 Ready for Implementation  
**Erstellt:** 11.06.2026  
**Nächster Check:** Montag 11.06. 09:00 Uhr
