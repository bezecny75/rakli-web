# Project State

## Project Goal
Migrace webu rakli.cz (praktický lékař, IT manager: Bezi) z WordPressu na statický web (Astro), s cílem umožnit kolegovi zadávat drobné obsahové úpravy textem/hlasem přes Telegram. AI agent (na cloudbot-bezi) přijme požadavek, upraví příslušný content soubor, commitne do Gitu, vybuilduje a nasadí na shared hosting přes FTP/SFTP. Cílový stav: žádný WordPress, žádná DB, jen statické soubory + Git historie jako audit trail.

## Current Branch
main

## Current Status
- Plán migrace sepsán (`MIGRATION_PLAN.md`)
- Obsah aktuálního webu zmapován (sekce: Aktuality, Zdravotní péče, Ordinační hodiny, Kontaktní formulář, FAQ, Kontakt + podstránky Poskytované služby, Ceník, Aktuality, Objednávání, Očkování, O nás)
- Repo je založeno a napojené na GitHub.
- Agent dokumentace je přesunutá do `.agent/`, podobně jako v projektu tenis.
- Astro projekt zatím NENÍ inicializován.
- `scripts/deploy.sh` je připravený jako deploy z `dist/` přes SFTP na `rakli.cz`, ale zatím není otestovaný bez reálných přístupů a buildu.
- Kontaktní formulář aktuálně bez backendu (posílá na mail přes WP) — nutno nahradit
- Testovací deploy cíl v lokálním `.env`: `/rakli.cz/www/_new`; produkční WordPress zůstává v `/rakli.cz/www`.

## Last Completed Work
- 2026-06-30
- commit: 90fd70d
- Inicializován Git repozitář a push na GitHub.
- Sesynchronizované plánovací dokumenty, následně přesunuté do `.agent/`.
- Odstraněný omylem přenesený tenisový deploy helper; `deploy.sh` upravený pro statický Astro výstup `dist/` a SFTP na `rakli.cz`.
- Testy: `git diff --check` před synchronizačním commitem; SFTP listing `/rakli.cz/www/_new` ověřený.

## Next Steps
1. Inicializovat Astro projekt (`npm create astro@latest`)
2. Migrovat obsah z rakli.cz do content collections (hodiny, aktuality, FAQ, ceník, služby, kontakt)
3. Nahradit kontaktní formulář přes Web3Forms a otestovat SFTP deploy do `/rakli.cz/www/_new`

## Known Issues
- Kontaktní formulář nemá vlastní backend, jen WP mail — musí se nahradit před vypnutím WP
- Hosting nemá SSH, deploy musí jít přes FTP/SFTP, ne git pull na serveru
- Není ještě definovaná "content map" pro Telegram agenta (který text patří do kterého souboru)
- Lokální `.env` obsahuje SFTP údaje a míří na testovací složku `/rakli.cz/www/_new`; soubor je ignorovaný Gitem.

## Important Decisions
- Zvolen statický generátor (Astro) místo zůstání na WP — kolega nepotřebuje WP editor, jen diktuje změny do Telegramu, takže CMS vrstva je zbytečná
- Deploy jde rovnou na produkci po každé úpravě (ne přes staging/náhled) — malý web, nízké riziko, Git umožňuje rychlý revert
- Výjimka: strukturální/rizikové změny (mazání sekcí, nová struktura) agent pošle ke schválení před nasazením
- Nepoužívat GitHub Actions pro deploy (zatím) — hosting bez SSH shellu, jednodušší je lokální/serverový deploy skript přes SFTP
- Secrets (FTP heslo) nikdy necommitovat, jen v `.env` s právy 600

## How To Run
```bash
npm install
npm run dev      # lokální vývoj
npm run build    # produkční build do dist/
./scripts/deploy.sh --dry-run
./scripts/deploy.sh --apply
```
