# Migration Plan — rakli.cz WordPress → statický web + Telegram agent

## 0. Rozhodnutí (shrnutí z konzultace)
- Cíl: kolega posílá text/hlas do Telegramu → agent upraví obsah webu → rovnou nasadí na produkci.
- Drobné textové změny (hodiny, ceny, aktuality) = rovnou produkce + commit.
- Rizikové změny (mazání sekcí, změna struktury) = agent nejdřív pošle náhled.
- Kontaktní formulář bez backendu (jen mail) → nahradit Formspree/Web3Forms.
- Deploy na shared hosting bez SSH → FTP/SFTP, ne Git pull na serveru.

---

## Fáze 1 — Založení projektu

- [ ] Založit nový GitHub repo (`rakli-web` nebo dle preference)
- [ ] `git init`, první commit s prázdnou strukturou
- [ ] Zvolit stack: **Astro** (doporučeno — rychlý, content collections přesně sedí na "Markdown soubory = obsah webu") vs alternativa Hugo (rychlejší build, ale Go templating je míň přívětivý pro AI editaci)
- [ ] `npm create astro@latest`
- [ ] Přidat `.gitignore` (node_modules, dist, .env)
- [ ] Vytvořit `.agent/` a `AGENTS.md` (viz níže)

## Fáze 2 — Migrace obsahu z WP

- [ ] Export obsahu z `rakli.cz` (ručně, stránka má jen ~10 podstránek, není potřeba WP XML import nástroj)
- [ ] Rozdělit do content souborů:
  - `src/content/hours.json` — ordinační hodiny (strukturovaná data, ne text)
  - `src/content/news/*.md` — aktuality (každá jako samostatný soubor s frontmatter datem)
  - `src/content/faq.json` — FAQ otázky/odpovědi
  - `src/content/pricing.md` nebo `.json` — ceník
  - `src/content/services.json` — 6 karet zdravotní péče
  - `src/content/contact.json` — telefon, mail, adresa
  - statické podstránky (O nás, Poskytované služby...) jako `.md` v `src/pages` nebo content collection
- [ ] Stáhnout a převést obrázky (`wp-content/uploads/...`) do `src/assets` nebo `public/`
- [ ] Postavit šablonu webu v Astru podle aktuálního vzhledu (sekce: hero, aktuality, služby, hodiny, formulář, FAQ, kontakt)

## Fáze 3 — Kontaktní formulář

- [ ] Založit účet na Web3Forms nebo Formspree (zdarma)
- [ ] Nahradit WP formulář static formem s `fetch()` na jejich endpoint
- [ ] Otestovat doručení mailu
- [ ] **Rozhodnutí (potvrď):** Web3Forms vs vlastní PHP skript na hostingu — doporučuju Web3Forms, nula údržby

## Fáze 4 — Build & Deploy pipeline

- [ ] Lokální build: `npm run build` → vygeneruje `dist/`
- [ ] Deploy skript `scripts/deploy.sh` — FTP/SFTP upload `dist/` na hosting (lftp nebo rclone s FTP backendem)
- [ ] **Potřebuju od tebe:** FTP/SFTP přístupové údaje (host, username, cílová složka, typ) — heslo NEPOSÍLEJ do chatu, uložíme do `.env` s právy 600 na serveru
- [ ] Testovací deploy na zkušební podsložku (např. `/test/`) než přepneme produkci
- [ ] Ostrý deploy na produkci, ověřit že stará WP instalace je zazálohovaná (DB dump + soubory) pro případ návratu

## Fáze 5 — Telegram agent workflow

- [ ] Napojit nový repo do `agent2telegram` bridge (stejný princip jako u `cloudbot-bezi`)
- [ ] Definovat "content map" — jednoduchý seznam, který agent použije k rozpoznání, který soubor odpovídá které části webu (např. JSON: `{"ordinační hodiny": "src/content/hours.json", "aktuality": "src/content/news/", ...}`)
- [ ] Agent flow: přijme zprávu → najde cílový soubor → upraví → `git commit` → `npm run build` → `deploy.sh` → pošle zpět link + diff do Telegramu
- [ ] Pravidlo rizikovosti: textová úprava existující hodnoty = auto-deploy; strukturální změna (nová sekce, smazání) = pošle návrh ke schválení
- [ ] Otestovat na 2-3 reálných příkladech (změna hodin, přidání aktuality, úprava ceny)

## Fáze 6 — Vypnutí WordPressu

- [ ] DNS/hosting přesměrování na nový statický build
- [ ] Zálohovat WP DB + soubory natrvalo (archiv, ne mazat hned)
- [ ] Po 2-4 týdnech provozu bez problémů — WP instalaci deaktivovat/smazat z hostingu

---

## Otevřené otázky k potvrzení
1. Astro vs Hugo? (doporučení: Astro)
2. Web3Forms vs vlastní PHP mail skript? (doporučení: Web3Forms)
3. FTP/SFTP přístupové údaje — pošli mimo chat nebo rovnou nastav na serveru do `.env`
4. Název GitHub repa?
