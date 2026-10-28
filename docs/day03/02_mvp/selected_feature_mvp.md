# MVP-Definition: Rabatt- und Gutscheincodes

Detaillierte Definition der MVP-Phasen für das ausgewählte Feature.

---

## Feature-Übersicht

**Feature:** Rabatt- und Gutscheincodes  
**Business-Goal:** Marketing-Team in die Lage versetzen, gezielte Rabatt-Kampagnen durchzuführen und den Umsatz zu steigern  
**Primäre User:** Endkunden (Nutzer des Shops), Secondary: Marketing-Team (Code-Management)  
**Erfolgs-KPI:** Code-Redemption-Rate, durchschnittlicher Kaufwert mit Code, Kampagnen-Konversionsrate

---

## MVP Phase 1: MVP (Minimum Viable Product)

### Beschreibung

Einfaches Rabatt-Code-System mit statischen Prozentsatz-Rabatten. Codes werden im Checkout eingegeben und gewähren einen pauschalen Rabatt auf den gesamten Warenkorb. Keine zeitlichen Beschränkungen, keine Bedingungen.

### Scope

**Includes:**
- [x] Code-Generation mit einfachen alphanumerischen Codes
- [x] Eingabe-Feld im Checkout (Warenkorb-Übersicht)
- [x] Rabatt-Validierung und -Anwendung auf Warenkorbsumme
- [x] Admin-Interface zur Code-Verwaltung (Create/Read/Delete)
- [x] Code-Status: Aktiv / Inaktiv
- [x] Basis-Analytics: Wie viele Codes wurden verwendet?
- [x] Einfache Fehlerbehandlung (ungültiger Code, bereits verwendet)

**Excludes:**
- [ ] Zeitgesteuerte Codes (Gültigkeitsdatum)
- [ ] Code-Limits (maximal X Nutzungen pro Code)
- [ ] Personalisierte Codes
- [ ] Rabattarten außer Prozentsatz (z.B. Festbetrag, Freiversand)
- [ ] Bedingungen (Mindestbestellwert, spezifische Produkte)
- [ ] KI-basierte Empfehlungen für Codes

### User Stories

- US-101: Als Nutzer möchte ich einen Rabatt-Code im Checkout eingeben, damit ich einen Rabatt auf meine Bestellung erhalte
- US-102: Als Nutzer möchte ich sehen, wie viel Rabatt ich durch meinen Code erhalte, damit ich die Einsparungen kenne
- US-103: Als Marketing-Manager möchte ich neue Rabatt-Codes erstellen können, damit ich Kampagnen durchführen kann
- US-104: Als Marketing-Manager möchte ich die Nutzung von Codes sehen, damit ich Kampagnen-Erfolg messe
- US-105: Als Marketing-Manager möchte ich Codes deaktivieren können, damit ich Kampagnen beenden kann

### Technische Details

**Backend:**
- Datenstruktur: 
  - Tabelle `discount_codes` mit: `id`, `code`, `discount_percentage`, `is_active`, `created_at`, `created_by`
  - Tabelle `code_usage` mit: `id`, `code_id`, `order_id`, `discount_amount`, `used_at`
- API-Endpoints:
  - `POST /api/admin/codes` — Code erstellen
  - `GET /api/admin/codes` — Codes auflisten
  - `PATCH /api/admin/codes/{id}` — Code aktivieren/deaktivieren
  - `DELETE /api/admin/codes/{id}` — Code löschen
  - `POST /api/checkout/validate-code` — Code validieren
- Datenbank-Änderungen: Zwei neue Tabellen hinzufügen

**Frontend:**
- UI-Komponenten: 
  - Code-Input-Feld im Warenkorb
  - Rabatt-Anzeige (x€ Rabatt)
  - Admin-Panel für Code-Verwaltung (simple Tabelle)
- UI-Änderungen: 
  - Warenkorb-Seite: Code-Eingabe-Feld hinzufügen
  - Admin-Dashboard: Code-Management-Seite
- Responsive-Design: Mobile-freundlich

**Validierung & Fehlerbehandlung:**
- Code existiert?
- Code ist aktiv?
- Code bereits von diesem Nutzer verwendet? (optional für MVP1)
- Validierungsfehler-Messages anzeigen

### Abhängigkeiten & Voraussetzungen

- [x] Besteht bereits Datenstruktur? (Nein, neue Tabellen)
- [x] Externe Libraries/Services? (Keine)
- [x] Gibt es Blockers? (Nein)

### Geschätzter Aufwand

- **Entwicklung:** 4-5 Tage
  - Backend API: 2 Tage
  - Database Schema: 1 Tag
  - Frontend: 1-2 Tage
- **Testing:** 1-2 Tage
  - Unit Tests für Validierung
  - Integration Tests für API & Checkout
  - Manual Testing
- **Deployment:** 0.5 Tage
- **Total:** ~1 Woche

### Erfolgskriterien

- [x] Code-Validierung funktioniert korrekt
- [x] Rabatt wird korrekt im Checkout angewendet
- [x] Admin kann Codes erstellen und verwalten
- [x] Unit Tests für Code-Logik (>85% Coverage)
- [x] Integration Tests für Checkout-Flow
- [x] Manual Testing durchgeführt (Happy Path + Error Cases)
- [x] Performance-Tests: Validierung unter 100ms
- [x] In Produktion deployed

---

## MVP Phase 2: MVP+ (Erweiterte Version)

### Beschreibung

Erweiterte Rabatt-Code-Funktionen basierend auf Phase 1 Feedback. Zeitgesteuerte Codes, Rabatt-Limits und verbesserte Analytics für Marketing-Teams.

### Zusätzliche Features gegenüber Phase 1

- [x] Zeitgesteuerte Codes (Start- & Enddatum)
- [x] Code-Limits (maximal X Nutzungen pro Code, optional: pro Nutzer)
- [x] Verschiedene Rabattarten:
  - Prozentsatz-Rabatt (wie Phase 1)
  - Festbetrag-Rabatt
  - Freiversand
- [x] Bedingungen für Codes:
  - Mindestbestellwert
  - Spezifische Produktkategorien
- [x] Erweiterte Admin-Analytics:
  - Code-Erfolgsrate
  - Durchschnittlicher Rabatt pro Code
  - Trend-Analyse
  - Export-Funktionalität (CSV)
- [x] Verbesserte User Experience:
  - Warnung wenn Code kurz vor Ablauf
  - Code-Vorschläge basierend auf Warenkorbinhalt
  - Automatische Code-Anwendung bei Newsletter-Subscribers

### Neue User Stories

- US-201: Als Marketing-Manager möchte ich zeitgesteuerte Codes erstellen, damit Kampagnen zu spezifischen Zeiten laufen
- US-202: Als Marketing-Manager möchte ich Code-Limits setzen, damit Codes nicht unbegrenzt verwendet werden
- US-203: Als Nutzer möchte ich sehen, wenn ein Code bald abläuft, damit ich ihn noch nutzen kann
- US-204: Als Marketing-Manager möchte ich Analytics zum Code-Erfolg sehen, damit ich Kampagnen optimiere
- US-205: Als Marketing-Manager möchte ich verschiedene Rabattarten verwenden, damit ich flexible Promotionen anbiete

### Geschätzter zusätzlicher Aufwand

- **Entwicklung:** 5-7 Tage
  - Zeitgesteuerte Logik: 2 Tage
  - Code-Bedingungen: 2 Tage
  - Analytics & UI: 1-3 Tage
- **Testing:** 2-3 Tage
- **Total zusätzlich:** ~1-2 Wochen nach Phase 1

---

## MVP Phase 3: Full Feature (Premium-Lösung)

### Beschreibung

Vollständige, hochmoderne Rabatt-Lösung mit KI-gestützten Empfehlungen, erweiterten Integrations-Optionen und Enterprise-Features.

### Advanced Features

- [x] KI-basierte Code-Empfehlungen:
  - Automatische Code-Vorschläge pro Nutzer basierend auf Kaufhistorie
  - Optimale Rabattsätze basierend auf Preis-Elastizität
  - Vorhersage von Checkout-Abandonment und automatische Code-Trigger
  
- [x] Personalisierte Codes:
  - Unique Codes pro Nutzer (statt globale Codes)
  - Codes in Marketing-Emails automatisch eingebunden
  - Automatic Audience Segmentation
  
- [x] Integration mit Marketing-Tools:
  - Slack-Benachrichtigungen für Campaign-Performance
  - Webhook-Integration mit Email-Marketing-Plattformen
  - Google Analytics Integration für Campaign-Tracking
  - CRM-Integration
  
- [x] Advanced Analytics & Insights:
  - Customer Lifetime Value Berechnung mit Codes
  - Cohort Analysis
  - ROI-Tracking per Code/Kampagne
  - Predictive Analytics für zukünftige Kampagnen
  - Real-time Dashboard
  
- [x] Enterprise-Features:
  - Multi-Campaign Management
  - Approval-Workflows für Code-Erstellung
  - Detailed Audit-Logs
  - Advanced Reporting mit Custom Reports
  - API für externe Integrationen

### Geschätzter zusätzlicher Aufwand

- **Entwicklung:** 8-12 Tage
  - KI-Modell-Entwicklung: 5-7 Tage
  - Integrationen: 2-3 Tage
  - Analytics & Dashboard: 2-3 Tage
- **ML-Modell-Training & Optimization:** 3-5 Tage
- **Testing & Validation:** 3-5 Tage
- **Total zusätzlich:** ~3-4 Wochen nach Phase 2

---

## Implementierungs-Roadmap

```
Woche 1-2:  Phase 1 MVP
           ├─ Backend: Datenstruktur & API
           ├─ Frontend: Code-Input & Admin-Panel
           └─ Testing & Deployment in Production
           └─ Go-Live & Early Adopter Phase

Woche 3-4:  Phase 2 MVP+
           ├─ Zeitgesteuerte Codes
           ├─ Code-Bedingungen
           ├─ Enhanced Analytics
           └─ User-Experience Verbesserungen

Woche 5+:   Phase 3 Full Feature
           ├─ KI-Modell-Entwicklung
           ├─ Personalisierte Codes
           ├─ Marketing-Tool Integrationen
           └─ Enterprise-Features & Optimization
```

**Parallele Aktivitäten:**
- Tag 04: CI-Pipeline auf Code-Branch (Phase 1)
- Tag 05: Testing & QA für Phase 1
- Danach: Kontinuierliche Iteration auf Phase 2/3 basierend auf Produktions-Feedback

---

## Feedback & Rationale

**Warum diese Aufteilung?**

1. **Phase 1 MVP** liefert in 1 Woche ein funktionierendes System
   - Marketing kann sofort Kampagnen starten
   - Minimal komplexe Logik = weniger Bugs
   - Klare Erfolgskriterien
   - Echtes User-Feedback sammeln

2. **Phase 2 MVP+** verbessert basierend auf Phase 1 Erfahrungen
   - Zeitgesteuerte Codes für planbare Kampagnen
   - Code-Limits für Budget-Kontrolle
   - Analytics für Optimierung
   - Flexible Rabattarten

3. **Phase 3 Full Feature** addiert intelligente Automatisierung
   - KI-gestützte Empfehlungen für bessere Conversion
   - Personalisierte Codes für höhere Relevanz
   - Enterprise-Integrationen
   - Advanced Analytics für Data-Driven Decisions

**Warum nicht alles auf einmal?**
- Phase 1 in 1 Woche live, Phases 2+3 brauchen 4+ Wochen zusammen
- Risiko wird verteilt: Früh Feedback, regelmäßige Anpassungen
- Team lernt Step-by-Step, statt overload
- Business-Value fließt kontinuierlich

**Risiken & Mitigation:**

| Risiko | Wahrscheinlichkeit | Mitigation |
|--------|------------------|-----------|
| Code-Validierung zu langsam | Niedrig | Query-Optimierung, Caching, Load-Test in Phase 1 |
| Nutzer geben falsche Codes ein | Niedrig | Clear UX mit Error-Messages, Input-Validation |
| Rabatt-Kombinationen erzeugen Bugs | Mittel | Comprehensive Test-Suite, Edge-Case Testing |
| Datenbank-Schema muss ändern | Niedrig | Migration-Tests durchführen |
| Phase 1 zu einfach, Marketing unzufrieden | Niedrig | Roadmap zeigen, Timeline erklären |
| Transition von Phase 1→2 schwierig | Mittel | Vorsicht bei Schema-Design, Backward-Compatibility |

---

**Team:** [Team-Name]  
**Datum:** [Datum]  
**Status:** Draft / In Review / Approved
