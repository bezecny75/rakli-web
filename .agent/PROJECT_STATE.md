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
- Kontaktní formulář je připravený přes Web3Forms; lokální `.env` obsahuje `PUBLIC_WEB3FORMS_ACCESS_KEY`, takže staging build renderuje aktivní formulář. Bez klíče se renderuje bezpečný fallback na e-mail.
- Testovací deploy cíl v lokálním `.env`: `/rakli.cz/www/_new`; produkční WordPress zůstává v `/rakli.cz/www`.
- Testovací náhled běží na `https://rakli.cz/_new/`.
- Lokálně připraven redesign 2025 podle `DESIGNE_PROMT.md`: světlý healthcare vizuál, top bar, sticky header, hero s foto placeholderem, trust bar, workflow sekce, přepracované karty/služby/hodiny/ceník/FAQ/kontakt/footer, bez JS knihoven.
- Přidané content soubory `src/content/status.json` a `src/content/alert.json`; `.agent/CONTENT_MAP.md` rozšířený o jejich mapování.
- Redesign 2025 je nasazený na staging `https://rakli.cz/_new/`; produkční WordPress na rootu zůstává nedotčený.
- Lokálně připravená další iterace podle připomínek: šipka nahoru, český formát dat aktualit, lokální inline SVG ikony služeb, zvýraznění aktuálního dne v ordinačních hodinách, dynamický status podle hodin/alertu/status.json, samostatná stránka ceníku `src/pages/cenik.astro`, nové formulářové pole rok narození a select předmětu zprávy.
- Iterace podle připomínek je nasazená na staging `https://rakli.cz/_new/`; nová stránka ceníku běží na `https://rakli.cz/_new/cenik/`.
- Aktuální staging status je nastaven na dovolenou: `status.json` state `vacation`, label `Dnes dovolená`, note `Dovolená do 06.07.2026`; `alert.json` je aktivní urgent alert s expirací `2026-07-06`.
- Poslední staging iterace upravila ceník (tlačítko zpět i nahoře), zjemnila inline SVG ikony služeb a nastavila ordinační hodiny tak, aby časy/konzultace byly tučné pro každý den a pauza byla světlejší inline poznámka.
- Formulář na stagingu má zpřísněnou klientskou validaci: jméno required, e-mail nebo telefon povinné aspoň jedno, formát českého telefonu, HTML email validace, rok narození v rozumném rozsahu 100 let; honeypot `botcheck` zůstává jako základní ochrana proti botům. Ikony služeb jsou nahrazené jemnějšími emoji ikonami podobnými horní ikoně.

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
- Formulářový build byl nasazen do `https://rakli.cz/_new/`; živý staging obsahuje aktivní formulář a `https://rakli.cz/_new/dekujeme/` vrací HTTP 200.
- Serverový test odeslání přes `curl` nelze použít: Web3Forms vrací 403 s informací, že metoda je povolená jen klientsky z prohlížeče. Reálný test doručení je potřeba provést ručně na staging stránce.
- Opravená patička podle konkrétní stránky `https://www.rakli.cz/?page_id=948`: převzatá struktura `custom-footer` se sloupci brand, odkazy, kontakt, pojišťovny a spodním copyright řádkem.
- Footer odkazy používají cíle z reference `#top`, `#services`, `#ordinacni-hodiny`, `https://www.rakli.cz/cenik`, `#contact`; v Astro stránce jsou doplněné alias kotvy pro interní odkazy.
- 2026-07-01
- Připraven lokální redesign podle dodaného `DESIGNE_PROMT.md`: nové CSS tokeny, Inter font, top bar, sticky header, mobile CSS hamburger, světlý hero s foto placeholderem, trust bar, workflow sekce, přepracované aktuality/služby/hodiny/ceník/FAQ/kontakt/footer.
- Přidány `src/content/status.json` a `src/content/alert.json` z dodaných podkladů a mapování do `.agent/CONTENT_MAP.md`.
- Ověřeno: `npm run build` prošel, lokální preview `/_new/` a `/_new/dekujeme/` vrací HTTP 200, dist obsahuje nové design komponenty a neobsahuje původní iconify JS.
- Nezávislý review redesignu prošel buildem; původní nálezy byly zapracované: hero už nemá interní foto placeholder text a trust bar nepoužívá neověřený claim `E-recepty do 24h`.
- Redesign 2025 byl nasazený na staging `https://rakli.cz/_new/`.
- Ověřeno po deployi: `https://rakli.cz/_new/` HTTP 200, `https://rakli.cz/_new/dekujeme/` HTTP 200, CSS asset HTTP 200, stránka obsahuje nové design komponenty (`top-bar`, status badge, workflow), nemá interní foto placeholder a Web3Forms redirect míří na `https://rakli.cz/_new/dekujeme/`.
- Produkční WordPress na `https://www.rakli.cz/` zůstal nedotčený; ověřený meta generator `WordPress 6.9.4`.
- Zapracovaná další lokální iterace podle připomínek: back-to-top kotva, český formát dat aktualit, inline SVG ikony služeb bez externí knihovny, aktuální den v ordinačních hodinách podle prohlížeče, dynamický status badge, samostatná stránka ceníku, rozšířený kontaktní formulář o rok narození a výběr předmětu.
- Ověřeno: `npm run build` prošel, generují se 3 stránky (`/`, `/dekujeme/`, `/cenik/`); kontrolní skript potvrdil česká data, back-to-top, SVG ikony, dynamický status, link na ceník, rok narození a subject select.
- Iterace byla nasazená na staging; ověřeno po deployi: `https://rakli.cz/_new/` HTTP 200, `https://rakli.cz/_new/cenik/` HTTP 200, `https://rakli.cz/_new/dekujeme/` HTTP 200, CSS asset HTTP 200, produkční WordPress root zůstal `WordPress 6.9.4`.
- 2026-07-01: podle požadavku nastaven staging status na dovolenou dle existující aktuality o dovolené MUDr. Klímy do 06.07.2026. Upravené `src/content/status.json` a `src/content/alert.json`, build prošel a deploy na `https://rakli.cz/_new/` ověřený HTTP 200 + live obsah obsahuje `Dnes dovolená` a urgent alert.
- 2026-07-01: podle dalších připomínek doplněné tlačítko `← Zpět na hlavní stránku` i nahoře na stránce ceníku, zjemněné ikony služeb (tenčí světlejší inline SVG) a upravené ordinační hodiny: všechny časy/konzultace zůstávají tučně, pauzy jsou světlejší přes `.hours-note`. Build prošel, deploy na staging proběhl, ověřeno HTTP 200 pro `/_new/` i `/_new/cenik/`.
- 2026-07-01: zpřísněná validace kontaktního formuláře a další styling: jméno zůstává required, e-mail/telefon stačí jeden z nich, telefon má český pattern, rok narození min/max 100 let, chybová hláška přes `form-error`; potvrzený honeypot `botcheck`. Služby převedené z tmavých SVG na jemné emoji ikony. Build a deploy na staging prošly; live ověřeno: validační JS, phone pattern, birth year range, honeypot, emoji ikony, světlejší pauzy, CSS asset HTTP 200.

## Next Steps
1. Ručně zkontrolovat nasazený redesign 2025 na `https://rakli.cz/_new/` na mobilu i desktopu.
2. Zkontrolovat ručně namapovaný obsah na `https://rakli.cz/_new/`.
3. Otestovat reálné doručení formuláře z prohlížeče na `https://rakli.cz/_new/` a ověřit cílový e-mail ve Web3Forms.
4. Stáhnout a optimalizovat použitelné obrázky z `wp-content/uploads`, pokud je budeme chtít použít v nové grafice.

## Known Issues
- Kontaktní formulář čeká na reálný test doručení a ověření cílového e-mailu ve Web3Forms; klíč není commitovaný do Gitu.
- Hosting nemá SSH, deploy musí jít přes FTP/SFTP, ne git pull na serveru
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
