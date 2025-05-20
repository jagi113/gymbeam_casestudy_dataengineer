import csv
from datetime import datetime
from dotenv import load_dotenv
import os
import requests

load_dotenv()
API_KEY = os.getenv("API_KEY")

API_URL = "https://api.golemio.cz/v2/municipalLibraries"


def fetch_libraries():
    headers = {"x-access-token": API_KEY}
    response = requests.get(API_URL, headers=headers)

    response.raise_for_status()
    data = response.json()
    print(data.get("features", [])[0])
    return data.get("features", [])


def extract_library_info(lib):
    properties = lib["properties"]
    addr = properties["address"]
    coords = lib["geometry"]["coordinates"]

    opening_hours = []
    for entry in properties.get("opening_hours", []):
        if entry["is_default"] == True:
            opening_hours.append(
                f'{entry["day_of_week"]}: {entry["opens"]}–{entry["closes"]}'
            )
    opening_text = "; ".join(opening_hours)

    return {
        "id": properties["id"],
        "name": properties["name"],
        "street": addr.get("street_address"),
        "postal_code": addr.get("postal_code"),
        "city": addr.get("address_locality"),
        "region": properties["district"],
        "country": addr.get("address_country"),
        "latitude": coords[1],
        "longitude": coords[0],
        "opening_hours": opening_text,
    }


def save_to_csv(data, folder_name="data", filename=None):
    if not filename:
        filename = f"libraries_{datetime.today().strftime('%Y-%m-%d')}.csv"

    base_dir = os.path.dirname(os.path.abspath(__file__))
    target_dir = os.path.join(base_dir, folder_name)
    os.makedirs(target_dir, exist_ok=True)
    filepath = os.path.join(target_dir, filename)

    headers = {
        "id": "ID knižnice",
        "name": "Názov knižnice",
        "street": "Ulica",
        "postal_code": "PSČ",
        "city": "Mesto",
        "region": "Kraj",
        "country": "Krajina",
        "latitude": "Zemepisná šírka",
        "longitude": "Zemepisná dĺžka",
        "opening_hours": "Čas otvorenia",
    }

    with open(filepath, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=headers.keys())
        f.write(",".join(headers.values()) + "\n")
        for row in data:
            writer.writerow(row)


def main():
    libs = fetch_libraries()
    extracted = [extract_library_info(lib) for lib in libs]
    save_to_csv(extracted)
    print(f"{len(extracted)} records saved to libraries.csv")


if __name__ == "__main__":
    main()
