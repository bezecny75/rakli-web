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
- Astro projekt je inicializovaný minimální šablonou.
- `astro.config.mjs` má dočasně nastavené `base: '/_new/'`, aby náhled fungoval v testovací podsložce.
- `scripts/deploy.sh` je otestovaný pro deploy z `dist/` přes SFTP na `rakli.cz` do `/rakli.cz/www/_new`.
- Kontaktní formulář je připravený přes Web3Forms; bez `PUBLIC_WEB3FORMS_ACCESS_KEY` se renderuje bezpečný fallback na e-mail.
- Testovací deploy cíl v lokálním `.env`: `/rakli.cz/www/_new`; produkční WordPress zůstává v `/rakli.cz/www`.
- Testovací náhled běží na `https://rakli.cz/_new/`.

## Last Completed Work
- 2026-06-30
- commit: 90fd70d
- Inicializován Git repozitář a push na GitHub.
- Sesynchronizované plánovací dokumenty, následně přesunuté do `.agent/`.
- Odstraněný omylem přenesený tenisový deploy helper; `deploy.sh` upravený pro statický Astro výstup `dist/` a SFTP na `rakli.cz`.
- Inicializován Astro projekt, vytvořena první testovací stránka a nasazena do `/_new/`.
- Ověřeno: `npm run build`, lokální preview `/_new/`, deploy dry-run, deploy apply, HTTP 200 na `https://rakli.cz/_new/`.
- Ověřeno: kořen `https://rakli.cz/` po redirectu stále vrací WordPress.
- Vytvořena první obsahová struktura (`src/content/*.json`) a content map pro Telegram agenta.
- Postaven první reálný one-page layout ordinace: aktuality, ordinační hodiny, služby, FAQ, kontakt a Web3Forms fallback.
- Review přes `BEZI-ReviewerTest`: první review našel 2 deploy bezpečnostní nálezy; opraveno a finální re-review PROŠLO bez nálezů.
- Reviewed build byl nasazen do `https://rakli.cz/_new/`; ověřeno HTTP 200 pro stránku i CSS asset.
- Produkční WordPress na `https://www.rakli.cz/` po deployi stále běží; ověřený meta generator `WordPress 6.9.4`.
- Grafika náhledu byla upravena podle referenční stránky `https://www.rakli.cz/?page_id=948#ordinacni-hodiny`: tmavý one-page styl, CTA `Objednat`, karty služeb, FAQ plus/minus a výrazné zaoblené bloky.
- Review přes `BEZI-ReviewerTest` pro grafickou úpravu: PROŠLO bez nálezů.
- Graficky upravený build byl nasazen do `https://rakli.cz/_new/`; ověřeno HTTP 200 pro stránku i CSS asset.
- Uživatel dodal WordPress export `raklisro.WordPress.2026-07-01.xml`; obsah byl namapován do `src/content/*.json`.
- Doplněné nové content soubory: `about.json`, `ordering.json`, `vaccination.json`; rozšířený `pricing.json`, `news.json`, `services.json`, `hours.json`, `faq.json`.
- Review přes `BEZI-ReviewerTest` pro mapování WP exportu: PROŠLO bez nálezů.
- Obsahově doplněný build byl nasazen do `https://rakli.cz/_new/`.
- Ověřeno po deployi: `https://rakli.cz/_new/` vrací HTTP 200, CSS asset vrací HTTP 200, kořen `https://rakli.cz/` po redirectu stále běží na WordPressu (`WordPress 6.9.4`).
- Připravený kontaktní formulář přes Web3Forms: jméno, e-mail, telefon, zpráva, honeypot `botcheck`, subject/from metadata a redirect na `/dekujeme/`.
- Přidaná děkovací stránka `src/pages/dekujeme.astro`; kontrolní build s dočasným klíčem ověřil aktivní formulář a redirect na `https://rakli.cz/_new/dekujeme/`.
- Review přes `BEZI-ReviewerTest` pro kontaktní formulář: PROŠLO bez nálezů.

## Next Steps
1. Zkontrolovat ručně namapovaný obsah na `https://rakli.cz/_new/`.
2. Doplnit Web3Forms access key do `.env`, znovu buildnout/deploynout a otestovat reálné doručení formuláře.
3. Stáhnout a optimalizovat použitelné obrázky z `wp-content/uploads`, pokud je budeme chtít použít v nové grafice.

## Known Issues
- Kontaktní formulář čeká na reálný Web3Forms access key a test doručení; bez klíče se zobrazuje fallback na e-mail.
- Hosting nemá SSH, deploy musí jít přes FTP/SFTP, ne git pull na serveru
- Není ještě definovaná "content map" pro Telegram agenta (který text patří do kterého souboru)
- Lokální `.env` obsahuje SFTP údaje a míří na testovací složku `/rakli.cz/www/_new`; soubor je ignorovaný Gitem.
- `npm install` hlásí upozornění, že lokální npm je 9.2.0 a Astro 7 vyžaduje npm >= 9.6.5; build přesto prošel. Před delší prací je vhodné npm aktualizovat.
- Opakované stahování `page_id` stránek z WordPressu aktuálně blokuje WAF; pro první verzi byl použit obsah dostupný z již stažené homepage a projektových poznámek.

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
