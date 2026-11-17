# Obrat

Responzivní česká aplikace pro osobní evidenci přeprodeje. Web hostuje Vercel, e-mailové přihlášení a cloudovou synchronizaci zajišťuje Supabase.

## Nastavení Supabase

1. V Supabase SQL Editoru spusťte `supabase-schema.sql`.
2. Do `supabase-config.js` doplňte Project URL a veřejný Publishable key.
3. V Supabase Auth URL Configuration nastavte Site URL na Vercel adresu a přidejte ji mezi povolené Redirect URLs ve tvaru `https://TVUJ-PROJEKT.vercel.app/**`.

Do souboru `supabase-config.js` nepatří `service_role` ani jiný tajný klíč. Databáze používá RLS pravidla, aby přihlášený účet četl a měnil jen svůj záznam.

Podrobnější postup je v [NASAZENI.md](NASAZENI.md).

## Lokální spuštění

Po doplnění Supabase konfigurace spusťte v této složce:

```sh
node server.js
```

V prohlížeči otevřete [http://127.0.0.1:4173](http://127.0.0.1:4173). Přihlášení přes e-mail vyžaduje povolit také `http://127.0.0.1:4173/**` v Supabase Redirect URLs.

## Zálohy

Data se při přihlášení ukládají do Supabase a také do místní IndexedDB jako cache. JSON záloha v sekci **Záloha a nastavení** stále obsahuje celý obsah včetně fotek. Fotky se před uložením zmenšují.
