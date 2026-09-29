-- Schema for the NovaMart E-Commerce Platform.
-- Hibernate auto-creates/updates tables via hibernate.hbm2ddl.auto=update;
-- this file documents the expected structure and can be executed manually.

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Product categories
CREATE TABLE IF NOT EXISTS category (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- User accounts
CREATE TABLE IF NOT EXISTS users (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email    VARCHAR(255) NOT NULL UNIQUE,
    role     VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Catalog products
CREATE TABLE IF NOT EXISTS product (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(255) NOT NULL,
    price          DECIMAL(10, 2) NOT NULL,
    stock_quantity INT,
    deleted        BOOLEAN NOT NULL DEFAULT FALSE,
    category_id    INT,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Customer orders
CREATE TABLE IF NOT EXISTS orders (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    order_date   DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    user_id      INT,
    CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Individual order line items
CREATE TABLE IF NOT EXISTS orderdetails (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    quantity   INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    order_id   INT,
    product_id INT,
    CONSTRAINT fk_detail_order   FOREIGN KEY (order_id)   REFERENCES orders  (id),
    CONSTRAINT fk_detail_product FOREIGN KEY (product_id) REFERENCES product (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
