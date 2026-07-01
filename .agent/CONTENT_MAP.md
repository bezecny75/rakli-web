# Content Map

Tento soubor říká agentům, kde upravovat jednotlivé části webu.

- Název ordinace, hlavní popis, provozní upozornění: `src/content/site.json`
- Adresa, telefony, e-maily: `src/content/contact.json`
- Ordinační hodiny: `src/content/hours.json`
- Služby / karty zdravotní péče: `src/content/services.json`
- Aktuality: `src/content/news.json`
- FAQ: `src/content/faq.json`
- Ceník: `src/content/pricing.json`
- O nás / tým ordinace: `src/content/about.json`
- Objednávání: `src/content/ordering.json`
- Očkování: `src/content/vaccination.json`
- Hlavní layout a vizuální struktura: `src/pages/index.astro`

Zdroj posledního mapování obsahu:

- WordPress export: `/home/bezi/.local/state/agent2telegram/attachments/raklisro.WordPress.2026-07-01.xml`
- ACF homepage `page_id=948`: hero, služby, FAQ, ordinační hodiny, referenční grafika
- Starší WP stránky: aktuality, ceník, objednávání, očkování, kontakt, o nás

Pravidlo:

- Textová změna existující hodnoty v JSON souboru je nízkoriziková.
- Přidání nové sekce, změna layoutu nebo mazání obsahu je strukturální změna a vyžaduje review před deployem.
