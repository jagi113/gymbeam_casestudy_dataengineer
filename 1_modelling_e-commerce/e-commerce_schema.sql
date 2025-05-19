CREATE TABLE category (
    category_id     INT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    parent_id       INT,
    FOREIGN KEY (parent_id) REFERENCES category(category_id)
);


CREATE TABLE product (
    product_id      INT PRIMARY KEY,
    name            VARCHAR(200) NOT NULL,
    price           DECIMAL(10,2) NOT NULL,
    description     TEXT,
    in_stock        INT NOT NULL CHECK (in_stock >= 0),
    category_id     INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE customer (
    customer_id     INT PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    address         TEXT NOT NULL,
    region          VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL
);


CREATE TABLE order_ (
    order_id        INT PRIMARY KEY,
    customer_id     INT NOT NULL,
    order_date      DATE NOT NULL,
    status          VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


CREATE TABLE order_item (
    order_item_id   INT PRIMARY KEY,
    order_id        INT NOT NULL,
    product_id      INT NOT NULL,
    quantity        INT NOT NULL CHECK (quantity > 0),
    unit_price      DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES order_(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);


CREATE TABLE transaction (
    transaction_id  INT PRIMARY KEY,
    order_id        INT NOT NULL,
    transaction_date DATE NOT NULL,
    payment_method  VARCHAR(50) NOT NULL,
    total_amount    DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES order_(order_id)
);