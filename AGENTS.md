# AGENTS.md

Než začneš pracovat:
1. Přečti `.agent/PROJECT_STATE.md`
2. Přečti `.agent/NEXT_STEPS.md`
3. Zkontroluj `git status`

Než skončíš:
1. Aktualizuj `.agent/PROJECT_STATE.md` (Current Status, Last Completed Work, Next Steps)
2. Aktualizuj `.agent/NEXT_STEPS.md`
3. Projdi `.agent/CHECKLIST.md`

## Pravidla
- Nevkládej secrets (FTP heslo, API klíče) do Gitu — vždy do `.env`, necommitovat.
- Před commitem spusť `npm run build`, musí projít bez chyby.
- Textová úprava existující hodnoty (hodiny, ceny, kontakt, nová aktualita) → uprav, commitni, vybuilduj, nasaď rovnou. Po nasazení pošli do Telegramu link + stručný diff.
- Strukturální/rizikové změny (nová sekce, smazání obsahu, změna layoutu) → NEnasazuj rovnou, pošli návrh/náhled ke schválení a počkej na potvrzení.
- Content soubory najdeš podle content mapy v `.agent/CONTENT_MAP.md` (pokud existuje) — pokud požadavek neodpovídá žádnému známému souboru, zeptej se, nehádej.
- Viz `.agent/DEPLOYMENT.md` pro přesný deploy postup a `.agent/DECISIONS.md` pro architektonický kontext.
