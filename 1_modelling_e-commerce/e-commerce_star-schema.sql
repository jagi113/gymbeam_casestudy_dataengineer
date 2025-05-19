CREATE TABLE dim_datetime (
    date_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    full_datetime   TIMESTAMP NOT NULL,
    date            DATE NOT NULL,
    year            INTEGER NOT NULL,
    quarter         INTEGER NOT NULL,
    month           INTEGER NOT NULL,
    day             INTEGER NOT NULL,
    weekday         INTEGER NOT NULL,
    hour            INTEGER NOT NULL,
    minute          INTEGER NOT NULL,
);

CREATE TABLE dim_product (
    product_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT NOT NULL,
    category_id     INTEGER NOT NULL,
    price           DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (category_id) REFERENCES dim_category(category_id)
);

CREATE TABLE dim_category (
    category_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name       TEXT NOT NULL,
    parent_category_id  INTEGER,
    
    FOREIGN KEY (parent_category_id) REFERENCES dim_category(category_id)
);

CREATE TABLE dim_customer (
    customer_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT NOT NULL,
    email           TEXT NOT NULL,
    registration_date DATE NOT NULL,
    region_id       INTEGER NOT NULL,

    FOREIGN KEY (region_id) REFERENCES dim_region(region_id)
);

CREATE TABLE dim_region (
    region_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    country         TEXT NOT NULL,
    city            TEXT NOT NULL,
    region          TEXT NOT NULL,
);

CREATE TABLE fact_sales (
    sale_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    datetime_id     INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    customer_id     INTEGER NOT NULL,
    region_id       INTEGER NOT NULL,
    quantity        INTEGER NOT NULL CHECK (quantity > 0),
    unit_price      DECIMAL(10,2) NOT NULL,
    total_amount    DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,

    FOREIGN KEY (datetime_id) REFERENCES dim_datetime(date_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id)
);
