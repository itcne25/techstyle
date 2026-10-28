#!/bin/bash

set -e

echo "🚀 Starte MVP1 Issues Erstellung..."
echo "=================================="
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Überprüfe gh CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI nicht gefunden. Installiere mit: brew install gh"
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo "❌ Nicht authentifiziert. Führe aus: gh auth login"
    exit 1
fi

echo -e "${BLUE}✓ gh CLI installiert und authentifiziert${NC}"
echo ""

# ============================================================
# Erstelle Labels
# ============================================================
echo -e "${BLUE}Erstelle Labels...${NC}"

LABELS=(
  "MVP1"
  "Epic"
  "Rabatt-Codes"
  "Backend"
  "Frontend"
  "Testing"
  "Database"
  "Admin"
  "API"
  "Checkout"
  "UX"
  "Utility"
  "Integration"
  "Manual"
  "Logic"
)

for label in "${LABELS[@]}"; do
  gh label create "$label" --force 2>/dev/null || true
done

echo -e "${GREEN}✓ Labels erstellt${NC}"
echo ""

# ============================================================
# EPIC-001
# ============================================================
echo -e "${BLUE}Erstelle EPIC-001...${NC}"
gh issue create \
  --title "EPIC-001: Rabatt-Code-System (MVP Phase 1)" \
  --body "# Rabatt-Code-System MVP Phase 1

Eine umfassende Implementierung eines einfachen Rabatt-Code-Systems für Marketing-Kampagnen.

## Ziel
Ein funktionierendes System zur Code-Generierung, -Validierung und -Anwendung im Checkout innerhalb von 1 Woche live stellen.

## Akzeptanz-Kriterien
- [ ] Code-Generierung funktioniert
- [ ] Codes können im Checkout eingegeben werden
- [ ] Rabatt wird korrekt berechnet
- [ ] Admin-Panel zum Code-Management existiert
- [ ] System läuft stabil in Production

## Stories
- US-101, US-102, US-103, US-104, US-105
- TS-101, TS-102
- TEST-101, TEST-102, TEST-103
" \
  --label "MVP1,Epic,Rabatt-Codes"
echo -e "${GREEN}✓ EPIC-001 erstellt${NC}"

# ============================================================
# TS-101
# ============================================================
echo -e "${BLUE}Erstelle TS-101...${NC}"
gh issue create \
  --title "TS-101: Code-Generierungs-Logik" \
  --body "## Beschreibung
Implementiere eine Hilfs-Funktion zur Generierung von eindeutigen, alphanumerischen Rabatt-Codes.

## Akzeptanz-Kriterien
- [ ] Funktion generate_code() existiert
- [ ] Codes sind eindeutig (keine Duplikate)
- [ ] Format: 8-12 alphanumerische Zeichen
- [ ] Nur Großbuchstaben
- [ ] Beispiele: SUMMER10, APRIL2526, NEWUSER5
- [ ] Unit Tests vorhanden

## Aufwand: 1 Stunde
## Abhängigkeiten: Keine
" \
  --label "MVP1,Backend,Utility"
echo -e "${GREEN}✓ TS-101 erstellt${NC}"

# ============================================================
# US-105
# ============================================================
echo -e "${BLUE}Erstelle US-105...${NC}"
gh issue create \
  --title "US-105: Datenbank-Schema für Codes" \
  --body "## Akzeptanz-Kriterien
- [ ] Tabelle discount_codes mit: id, code, discount_percentage, is_active, created_at, updated_at, created_by
- [ ] Tabelle code_usage mit: id, code_id, user_id, order_id, discount_amount, used_at
- [ ] Indizes erstellt
- [ ] Migration-Script funktioniert
- [ ] Rollback-Script existiert

## Aufwand: 1-2 Stunden
## Abhängigkeiten: Keine
" \
  --label "MVP1,Backend,Database"
echo -e "${GREEN}✓ US-105 erstellt${NC}"

# ============================================================
# TS-102
# ============================================================
echo -e "${BLUE}Erstelle TS-102...${NC}"
gh issue create \
  --title "TS-102: Code-Validierungs-Logik" \
  --body "## Beschreibung
Implementiere die Business-Logik zur Validierung von Codes und Berechnung des Rabatts.

## Akzeptanz-Kriterien
- [ ] Funktion validate_code(code: str) existiert
- [ ] Prüft: Code existiert + is_active
- [ ] Berechnet: discount_amount = cart_total * discount_percentage / 100
- [ ] Unit Tests: >85% Coverage
- [ ] Edge Cases getestet

## Aufwand: 2 Stunden
## Abhängigkeiten: US-105
" \
  --label "MVP1,Backend,Logic"
echo -e "${GREEN}✓ TS-102 erstellt${NC}"

# ============================================================
# US-104
# ============================================================
echo -e "${BLUE}Erstelle US-104...${NC}"
gh issue create \
  --title "US-104: Code-Validierungs-API" \
  --body "## Akzeptanz-Kriterien
- [ ] Endpoint POST /api/checkout/validate-code existiert
- [ ] Request-Payload: { code: string }
- [ ] Response bei gültigem Code enthält discount_amount
- [ ] Response bei ungültigem Code enthält Error-Message
- [ ] Validierung ist schnell (<100ms)
- [ ] API ist authentifiziert

## Technical Details
- Language: Python/Flask
- Database Query: discount_codes table

## Aufwand: 2-3 Stunden
## Abhängigkeiten: TS-102, US-105
" \
  --label "MVP1,Backend,API"
echo -e "${GREEN}✓ US-104 erstellt${NC}"

# ============================================================
# US-103
# ============================================================
echo -e "${BLUE}Erstelle US-103...${NC}"
gh issue create \
  --title "US-103: Code-Verwaltung im Admin-Panel" \
  --body "## Als Marketing-Manager möchte ich neue Rabatt-Codes erstellen und verwalten

## Akzeptanz-Kriterien
- [ ] Admin-Seite /admin/codes existiert
- [ ] Marketing kann Codes erstellen (Code-String, Rabatt-%)
- [ ] Codes können in Tabelle angezeigt werden
- [ ] Status kann gesehen werden (Aktiv/Inaktiv)
- [ ] Codes können aktiviert/deaktiviert werden
- [ ] Codes können gelöscht werden
- [ ] Nur Admins/Marketing können diese Seite sehen

## API Endpoints
- POST /api/admin/codes
- GET /api/admin/codes
- PATCH /api/admin/codes/{id}
- DELETE /api/admin/codes/{id}

## Aufwand: 3-4 Stunden
## Abhängigkeiten: US-104, US-105
" \
  --label "MVP1,Backend,Admin"
echo -e "${GREEN}✓ US-103 erstellt${NC}"

# ============================================================
# US-101
# ============================================================
echo -e "${BLUE}Erstelle US-101...${NC}"
gh issue create \
  --title "US-101: Code-Eingabe im Checkout" \
  --body "## Als Nutzer möchte ich einen Rabatt-Code im Checkout eingeben

## Akzeptanz-Kriterien
- [ ] Input-Feld für Rabatt-Codes im Warenkorb/Checkout vorhanden
- [ ] Feld akzeptiert Text-Eingaben (maximal 50 Zeichen)
- [ ] Button 'Code anwenden' vorhanden
- [ ] Rabatt wird sofort berechnet
- [ ] Fehlermeldungen werden angezeigt
- [ ] Design ist responsive (Mobile & Desktop)
- [ ] Code ist optional

## Component: Checkout/Cart Page
## API: POST /api/checkout/validate-code

## Aufwand: 2-3 Stunden
## Abhängigkeiten: US-104
" \
  --label "MVP1,Frontend,Checkout"
echo -e "${GREEN}✓ US-101 erstellt${NC}"

# ============================================================
# US-102
# ============================================================
echo -e "${BLUE}Erstelle US-102...${NC}"
gh issue create \
  --title "US-102: Rabatt-Anzeige" \
  --body "## Als Nutzer möchte ich sehen, wie viel Rabatt ich erhalte

## Akzeptanz-Kriterien
- [ ] Rabatt-Betrag wird angezeigt (z.B. '€ 15,00 Rabatt')
- [ ] Original-Preis und Neu-Preis sind erkennbar
- [ ] Prozentsatz wird angezeigt (z.B. '10% Rabatt')
- [ ] Anzeige wird sofort nach Code-Eintrag aktualisiert
- [ ] Rabatt wird in Bestellzusammenfassung angezeigt
- [ ] Ist visuell deutlich hervorgehoben

## Aufwand: 1-2 Stunden
## Abhängigkeiten: US-101
" \
  --label "MVP1,Frontend,UX"
echo -e "${GREEN}✓ US-102 erstellt${NC}"

# ============================================================
# TEST-101
# ============================================================
echo -e "${BLUE}Erstelle TEST-101...${NC}"
gh issue create \
  --title "TEST-101: Unit Tests für Code-Validierung" \
  --body "## Test-Cases
- [ ] Valid code returns discount
- [ ] Invalid code returns error
- [ ] Inactive code returns error
- [ ] Code calculation is correct
- [ ] Empty code returns error
- [ ] Special characters handled
- [ ] Case insensitivity tested

## Coverage Target: >85%

## Aufwand: 1-2 Stunden
## Abhängigkeiten: TS-102
" \
  --label "MVP1,Testing,Backend"
echo -e "${GREEN}✓ TEST-101 erstellt${NC}"

# ============================================================
# TEST-102
# ============================================================
echo -e "${BLUE}Erstelle TEST-102...${NC}"
gh issue create \
  --title "TEST-102: Integration Tests für Checkout-Flow" \
  --body "## Test-Cases
- [ ] User enters valid code → discount applied
- [ ] User enters invalid code → error message
- [ ] User applies code → sees discount in summary
- [ ] User applies code → correct price calculated
- [ ] Code field is optional

## Aufwand: 1-2 Stunden
## Abhängigkeiten: US-101, US-104
" \
  --label "MVP1,Testing,Integration"
echo -e "${GREEN}✓ TEST-102 erstellt${NC}"

# ============================================================
# TEST-103
# ============================================================
echo -e "${BLUE}Erstelle TEST-103...${NC}"
gh issue create \
  --title "TEST-103: Manual Testing Checklist" \
  --body "## Admin Panel Testing
- [ ] Neue Codes erstellen
- [ ] Codes aktivieren/deaktivieren
- [ ] Codes anzeigen
- [ ] Codes löschen

## Checkout Testing
- [ ] Gültigen Code eingeben → Rabatt wird angewendet
- [ ] Ungültigen Code eingeben → Error Message
- [ ] Code löschen und neuen eingeben
- [ ] Abbrechen mit/ohne Code

## Mobile & Desktop
- [ ] Responsive Design auf Mobile
- [ ] Input-Feld lesbar
- [ ] Button erreichbar

## Aufwand: 2-3 Stunden
## Abhängigkeiten: Alle anderen Stories müssen Done sein
" \
  --label "MVP1,Testing,Manual"
echo -e "${GREEN}✓ TEST-103 erstellt${NC}"

echo ""
echo "=================================="
echo -e "${GREEN}✅ Alle 10 Issues erfolgreich erstellt!${NC}"
echo ""
echo "Nächste Schritte:"
echo "1. Gehe zu: https://github.com/tbzdevops/techstyle/issues"
echo "2. Verschiebe alle MVP1-Issues zu Project 2:"
echo "   - Wähle jedes Issue mit Label 'MVP1'"
echo "   - Setze Status zu 'Ready for Development'"
echo "   - Oder dragg sie direkt ins Project 2"
echo ""
echo -e "${GREEN}🚀 Team kann Montag starten!${NC}"
