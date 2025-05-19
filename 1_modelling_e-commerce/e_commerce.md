# Návrh dátového modelu pre e-commerce platformu

1. Súbory **e-commerce_schema.png / .pdf** obsahujú ER diagram základného dátového modelu.

2. Súbory **e-commerce_star-schema.png / .pdf** obsahujú ER diagram star schémy vytvorenej s ohľadom na analýzu predajov podľa času, produktov, kategórií a regiónov.

3.  
a) Primárne kľúče sú identifikované symbolom kľúča a cudzie kľúče sú zobrazené vzťahovými spojeniami v priložených diagramoch.  
b) Navrhnuté modely sú normalizované do tretej normálnej formy – polia obsahujú elementárne hodnoty, nekľúčové stĺpce sú plne závislé od celého primárneho kľúča a nekľúčové stĺpce nezávisia od iných nekľúčových stĺpcov.  
c) Možné denormalizácie, ktoré by mohli zvýšiť výkonnosť:  
- V závislosti od podrobnosti vykonávaných analýz by sa niektoré tabuľky mohli zjednodušiť pridaním stĺpcov priamo do tabuľky fact_sales, aby sa predišlo JOIN-om (napr. dim_region by mohol byť nahradený stĺpcom region, ak chceme analyzovať iba väčšie oblasti a nie jednotlivé mestá či krajiny; dim_datetime by mohol byť nahradený stĺpcami year, month, weekday).  
- Ďalšou možnosťou je pridanie predpočítaných metrík (napr. počet objednávok za deň) 


4. SQL schémy oboch modelov sú priložené.

---

**Otázky na diskusiu**

1. **Aké kompromisy by ste spravili medzi normalizáciou a výkonnosťou?**  
Najrozumnejším riešením sa javí oddelenie produkčnej databázy od analytickej databázy, kde produkčná databáza uchováva bezpečnosť a presnosť dát, zatiaľ čo analytická databáza je optimalizovaná pre potreby analýz. Toto riešenie však vyžaduje väčší dátový priestor a spôsobuje miernu neaktuálnosť analytických dát oproti produkčným.

2. **Ako by ste riešili historické zmeny (napr. zmena ceny produktu, adresa zákazníka)?**  
Čo sa týka ceny, model uvádza aktuálnu cenu pri produkte a cenu za kus pri objednávke/predaji. Aj keď to vyzerá ako duplicita, cena pri objednávke zostáva nemenná aj pri zmene ceny produktu v čase.  
V prípade zmeny adresy zákazníka by riešením bolo pridať k objednávke pole so shipping_address (adresa odoslania), čím by zmena adresy zákazníka neovplyvnila historické dáta predošlých objednávok.

3. **Aké indexy by ste pridali na zlepšenie výkonnosti dotazov?**  

*Pre základný dátový model:*  
- tabuľka **customer**: stĺpce *region*, pre autentifikáciu aj *email*  
- tabuľka **orders**: stĺpce *customer_id*, *order_status*  
- tabuľka **order_item**: stĺpce *order_id*, *order_item* (tu asi myslíš *product_id*?)  
- tabuľka **product**: stĺpce *category_id*, *name*  
- tabuľka **category**: stĺpce *name*, prípadne aj *parent_category_id*  
- tabuľka **transaction**: stĺpec *order_id*

*Pre star schému:*  
- tabuľka **fact_sales**: stĺpce *datetime_id*, *product_id*, *customer_id*, *region_id*  
- tabuľka **dim_datetime**: stĺpce *month*, *year* (podľa potreby analýz)  
- tabuľka **dim_customer**: stĺpec *region_id*  
- tabuľka **dim_region**: stĺpce *region*, *city* (podľa potreby analýz)  
- tabuľka **dim_product**: stĺpce *name*, *category_id*  
- tabuľka **dim_category**: stĺpec *category_name*, prípadne aj *parent_category_id*  
