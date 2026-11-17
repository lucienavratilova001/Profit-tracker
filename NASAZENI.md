# Nasazení Obratu na Vercel se Supabase

## Co je potřeba

- Vercel hostuje webovou stránku.
- Supabase zajišťuje přihlášení e-mailem a synchronizaci dat do databáze.
- Veřejná adresa typu `profit-tracker.vercel.app` může být dostupná bez vlastní domény, pokud je název volný. `.tracker` není veřejně delegovaná koncovka domény.

## 1. Připravit Supabase

1. Vytvořit samostatný Supabase projekt a zvolit evropský region.
2. V SQL Editoru spustit obsah `supabase-schema.sql`. Tabulka ukládá jeden JSON záznam pro účet a má zapnutá pravidla RLS, která omezí přístup na právě přihlášeného uživatele.
3. V nastavení Auth ponechat zapnuté přihlašování přes e-mail.
4. V URL Configuration později nastavit Site URL na konečnou Vercel adresu a mezi povolené Redirect URLs přidat `https://TVUJ-PROJEKT.vercel.app/**`.
5. Zkopírovat Project URL a veřejný Publishable key do `supabase-config.js`.

Do webového kódu nikdy nevkládat `service_role` ani tajný klíč. Klientská aplikace používá pouze veřejný publishable key; přístup k datům hlídají RLS pravidla.

## 2. Připravit web na Vercel

Složka `vercel-deploy` má obsahovat `index.html`, `supabase-config.js` a tento projektový SQL soubor není třeba nahrávat. V dashboardu Vercel vybrat nasazení složky. První publikovaná stránka dostane adresu `*.vercel.app`.

## 3. První přihlášení

Otevřít Vercel adresu, zadat svůj e-mail a kliknout na přihlašovací odkaz doručený e-mailem. První přihlášení vytvoří uživatele. Po přihlášení si aplikace může nabídnout přenesení dat, která jsou uložená v aktuálním prohlížeči. Starší data z jiné adresy lze přenést JSON zálohou přes **Záloha a nastavení → Obnovit ze souboru**.

Data a fotky se synchronizují se Supabase. Fotky se před uložením zmenšují. JSON zálohy si přesto pravidelně stahovat.
