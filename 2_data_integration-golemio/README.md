# Nastavenie a spustenie extraktora dát z Golemio API

---

## 1. Vytvorenie virtuálneho prostredia a inštalácia závislostí

```bash
python3 -m venv venv
source venv/bin/activate       
pip install -r requirements.txt
```

---

## 2. Uloženie API kľúča

Ulož svoj API kľúč do súboru `.env` vedľa `extractor.py` v tomto formáte:

```
API_KEY=your_api_key
```

---

## 3. Vytvorenie cron jobu
Cron job je možné vytvoriť iba na Linuxe!

Na vytvorenie cron jobu spusti v termináli:

```bash
chmod +x install_cron.sh
./install_cron.sh
```

---

## 4. Odstránenie cron jobu

Na odstránenie cron jobu spusti v termináli:

```bash
chmod +x uninstall_cron.sh
./uninstall_cron.sh
```
