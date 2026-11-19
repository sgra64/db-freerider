-- Gemini-generated database schema:
-- - "Create a MySQL database schema for orders owned by customers."

-- Create the database, it not present
CREATE DATABASE IF NOT EXISTS ECOMMERCE_DB
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ECOMMERCE_DB;

-- Drop all tables in reverse creation order, if present
DROP TABLE IF EXISTS ORDER_ITEMS;
DROP TABLE IF EXISTS ORDERS;
DROP TABLE IF EXISTS PRODUCTS;
DROP TABLE IF EXISTS CUSTOMERS;


-- Create 'CUSTOMERS' Table
CREATE TABLE CUSTOMERS (
    customer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    shipping_address TEXT,
    billing_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_customer_email (email),
    INDEX idx_customer_name (last_name, first_name)
) ENGINE=InnoDB;

-- Create 'ORDERS' Table
CREATE TABLE ORDERS (
    order_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    order_number VARCHAR(50) NOT NULL UNIQUE,
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded') NOT NULL DEFAULT 'pending',
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    currency CHAR(3) NOT NULL DEFAULT 'USD',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Key linking order to customer
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) 
        REFERENCES CUSTOMERS(customer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    INDEX idx_order_customer (customer_id),
    INDEX idx_order_status (status),
    INDEX idx_order_date (order_date)
) ENGINE=InnoDB;

-- Create 'PRODUCTS' Table (Optional, for line-item tracking)
CREATE TABLE PRODUCTS (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Create 'ORDER_ITEMS' Table (Junction table for Orders <-> Products)
CREATE TABLE ORDER_ITEMS (
    order_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL, -- Snapshot of price at time of purchase
    
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id) 
        REFERENCES ORDERS(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_items_product
        FOREIGN KEY (product_id) 
        REFERENCES PRODUCTS(product_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    INDEX idx_item_order (order_id)
) ENGINE=InnoDB;
