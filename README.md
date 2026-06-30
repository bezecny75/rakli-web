# rakli-web

Statický web pro Rakli s.r.o. (ordinace praktického lékaře), migrace z WordPressu.
Viz `.agent/MIGRATION_PLAN.md` a `.agent/` pro detaily a stav projektu.

## Založení repa (lokálně nebo na serveru)

```bash
cd rakli-redesign
git init
git add .
git commit -m "Initial project scaffolding: migration plan + agent docs"
git branch -M main
git remote add origin git@github.com:<tvuj-ucet>/rakli-web.git
# (repo musí být na GitHubu předem založené jako "rakli-web")
git push -u origin main
```

## Další krok
`npm create astro@latest` v tomto adresáři, viz `.agent/NEXT_STEPS.md`.
