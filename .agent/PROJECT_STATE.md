# Stav projektu — rakli-web

## Cíl

Migrace webu `rakli.cz` pro ordinaci praktického lékaře z WordPressu na statický web. Cílový workflow: běžné textové úpravy půjdou přes Telegram agenta, který upraví content soubory, commitne změnu, spustí build a nasadí statický výstup na hosting.

## Repozitář

- Lokální cesta: `/home/bezi/projects/rakli-web`
- GitHub remote: `git@github.com:bezecny75/rakli-web.git`
- Hlavní větev: `main`

## Aktuální stav

- Git repozitář je inicializovaný a napojený na GitHub.
- Doplněné plánovací dokumenty v kořeni projektu:
  - `AGENTS.md`
  - `MIGRATION_PLAN.md`
  - `PROJECT_STATE.md`
  - `NEXT_STEPS.md`
  - `DECISIONS.md`
  - `DEPLOYMENT.md`
  - `CHECKLIST.md`
- Potvrzená rozhodnutí:
  - stack: Astro,
  - kontaktní formulář: Web3Forms,
  - repo: `rakli-web`,
  - deploy přes FTP/SFTP skript z tohoto serveru, ne přes GitHub Actions.
- Astro aplikace zatím není inicializovaná.
- FTP/SFTP přístupy zatím nejsou uložené.

## Poslední práce

- 2026-06-30: inicializovaný Git repozitář, první commit a push.
- 2026-06-30: sesynchronizované uživatelem nahrané plánovací dokumenty; před commitem zkontrolováno, že neobsahují skutečné tajné údaje.

## Pracovní pravidla

- Tajné údaje neukládat do Gitu; patří do `.env` s právy 600.
- Textové obsahové změny po dokončení systému mohou jít rovnou build + deploy.
- Strukturální nebo rizikové změny před deployem potvrdit s uživatelem.
- Před commitem po zavedení Astru spouštět `npm run build`.
- Po každé pracovní session aktualizovat `.agent/PROJECT_STATE.md` a `.agent/NEXT_STEPS.md`.

