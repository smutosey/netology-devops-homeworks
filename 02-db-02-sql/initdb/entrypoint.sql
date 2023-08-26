CREATE ROLE "test-admin-user" LOGIN PASSWORD 'badpassword';
CREATE DATABASE test_db;
\c test_db;
CREATE TABLE IF NOT EXISTS orders (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    price   INTEGER
);
CREATE TABLE IF NOT EXISTS clients (
    id          SERIAL PRIMARY KEY,
    last_name    VARCHAR(50) NOT NULL,
    country     VARCHAR(50) NOT NULL,
    order_id     INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders (id)
);
CREATE INDEX country_idx ON clients (country);
GRANT ALL PRIVILEGES ON TABLE orders, clients TO "test-admin-user";
CREATE ROLE "test-simple-user" LOGIN PASSWORD 'anotherbadpassword';
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE orders, clients TO "test-simple-user";