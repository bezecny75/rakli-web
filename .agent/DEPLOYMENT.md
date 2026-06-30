# Deployment

## Hosting
Shared hosting bez SSH přístupu — deploy pouze přes FTP/SFTP.

## Lokální build
```bash
npm run build
```
Výstup: `dist/`

## Publikování
```bash
./scripts/deploy.sh --dry-run
./scripts/deploy.sh --apply
```
Skript nahraje obsah `dist/` na hosting přes FTP/SFTP (lftp/rclone), přepíše produkční složku.

## Konfigurace (.env, necommitovat)
```
FTP_HOST=rakli.cz
FTP_USER=
FTP_PASS=
FTP_REMOTE_DIR=
FTP_PROTOCOL=sftp
```

Lokální konfigurace:

```bash
cp .env.example .env
chmod 600 .env
```

Do `.env` doplň SFTP uživatele, heslo a cílovou cestu na hostingu. Soubor `.env` je ignorovaný Gitem.

Aktuální bezpečný testovací cíl:

```bash
FTP_REMOTE_DIR=/rakli.cz/www/_new
```

Produkční WordPress běží v `/rakli.cz/www`; dokud se deployuje do `/_new/`, produkce není ovlivněná.

## Co nepublikovat
- `.env`
- `.git`
- `node_modules`
- `.agent`
- zdrojové `.md`/`.json` content soubory (jen vybuildovaný `dist/`)

## Postup nasazení změny (pro agenta)
1. Uprav content soubor podle požadavku
2. `git add . && git commit -m "..."`
3. `npm run build`
4. `./scripts/deploy.sh --apply`
5. Pošli do Telegramu: link na živý web + stručný diff co se změnilo

## Rollback
```bash
git revert <commit>
npm run build
./scripts/deploy.sh --apply
```
