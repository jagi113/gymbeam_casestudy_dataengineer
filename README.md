# Case Study - Data Engineer

## 1. Úloha - modelling e-commerce
Riešenie úlohy s grafinckým návrhom tabuliek je v priečinku 1_modelling_e-commerce s vlastným e_commerce.md popisným súborom.

## 2. Úloha - golemio knižnice
Riešenia na 2. úlohu sú dve:
a) pythonový extractor v súbore 2_data_integration-golemio s vlastným README súborom. Časové spúšťanie je vykonávané cez cronjob, ktorý je nutné nastaviť (viac v príslušnom README súbore). Jeho limitácia je, že niektoré verzie cronu nepodporujú časové pásma a cron spúšťa jednotlivé tasky na základe času servera.
b) keboola extractor - v rámci projektu, je zložený z generického extraktora "api.golemio/libraries" a pythonového transformátora "libraries_openinghours", ktoré spolu tvoria flow "golemio_libraries". Output je v buckete "golemio_libraries" v tabulke "libraries". Vzhľadom na slovenské zadanie a názvy stĺpcov, aj stĺpce v tabulke su v slovenských verziách. (Za normálnych okolností používam anglické verzie.) Flow je načasovaný na 7.00 podľa časového pásma Prahy.

## 3. Úloha - manual input
Úloha je v rovakom keboola projekte ako 2. úloha. Transformáciu vykonáva pythonový transformátor "input_csv_transformation". Jeho kód je rozvrhnutý do jednotlivých logických krokov. 
Pri snahe o zachovanie čo najväčšieho množstva dát a zaručenie ich korektnosti okrem bežných úloh normalizácie dát, transformácia overuje hodnoty medzi PaymentAmount a TotalValue, prepočítava správnosť, respektíve dopočítava hodnoty podľa logického princípu Price * Amount = PaymentAmount/TotalValue . Keďže nie je známy druh analýz, ktoré majú na dátach prebiehať, všetky riadky, v ktorých boli chybné hodnoty alebo hodnoty úplne chýbali (okrem stĺca DiscountCode ) boli odstránené. 
Output je tabuľka "csv_output" v buckete "manual_output".