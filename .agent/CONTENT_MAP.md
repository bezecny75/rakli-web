# Content Map

Tento soubor říká agentům, kde upravovat jednotlivé části webu.

- Název ordinace, hlavní popis, provozní upozornění: `src/content/site.json`
- Adresa, telefony, e-maily: `src/content/contact.json`
- Ordinační hodiny: `src/content/hours.json`
- Služby / karty zdravotní péče: `src/content/services.json`
- Aktuality: `src/content/news.json`
- FAQ: `src/content/faq.json`
- Ceník: `src/content/pricing.json`
- Hlavní layout a vizuální struktura: `src/pages/index.astro`

Pravidlo:

- Textová změna existující hodnoty v JSON souboru je nízkoriziková.
- Přidání nové sekce, změna layoutu nebo mazání obsahu je strukturální změna a vyžaduje review před deployem.
