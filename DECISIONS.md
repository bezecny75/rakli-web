# Decisions

- POTVRZENO 2026-06-30: stack = Astro, kontaktní formulář = Web3Forms, repo = rakli-web (kebab-case)
- Statický generátor Astro místo zůstání na WordPressu — kolega nepoužívá WP editor, jen Telegram, takže CMS administrace je zbytečná zátěž.
- Obsah jako strukturovaná data (JSON/Markdown content collections), ne volný HTML — usnadňuje AI agentovi najít a upravit přesně to, co má, bez rizika rozbití layoutu.
- Deploy rovnou na produkci po každé textové úpravě (ne staging/preview flow) — malý web, nízké riziko, Git revert jako pojistka.
- Strukturální/rizikové změny (mazání sekcí, nová stránka) → agent pošle náhled ke schválení, nečeká se to samé u textových úprav.
- Deploy přes FTP/SFTP skript, NE GitHub Actions zatím — hosting nemá SSH, jednodušší je řídit deploy z cloudbot-bezi serveru.
- Kontaktní formulář přes Web3Forms (ne vlastní PHP backend) — nula údržby, žádný server-side kód navíc.
- Produkční přihlašovací údaje (FTP) se necommitují, žijí jen v `.env` na serveru s právy 600.
- Stará WP instalace se po přepnutí nemaže hned — zálohuje se a nechává běžet/dostupná min. 2-4 týdny pro jistotu.
