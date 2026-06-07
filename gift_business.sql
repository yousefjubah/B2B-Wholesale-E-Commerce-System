CREATE DATABASE IF NOT EXISTS gift_business;
USE gift_business;

CREATE TABLE IF NOT EXISTS category (

    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS product (

    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    sku VARCHAR(100) UNIQUE,
    category_id INT ,
    price DECIMAL(10,2),
    
    FOREIGN KEY (category_id)
		REFERENCES category(category_id)
    
);
CREATE TABLE IF NOT EXISTS location (

location_id INT PRIMARY KEY AUTO_INCREMENT,
location_name VARCHAR(255) 

);
CREATE TABLE IF NOT EXISTS inventory (

inventory_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT ,
location_id INT,
quantity INT ,
FOREIGN KEY (product_id)
	REFERENCES product(product_id),

FOREIGN KEY (location_id)
    REFERENCES location(location_id)
);

CREATE TABLE IF NOT EXISTS shop (

shop_id INT PRIMARY KEY AUTO_INCREMENT,
shop_name VARCHAR(100) NOT NULL,
phone VARCHAR(20) NOT NULL,
email VARCHAR(150),
balance DECIMAL(10,2) DEFAULT 0

);

-- ALTER TABLE address DROP FOREIGN KEY fk_address_shop;
-- DROP TABLE IF EXISTS order_item;
-- DROP TABLE IF EXISTS orders;
-- DROP TABLE IF EXISTS shop;
-- DROP TABLE IF EXISTS address;


-- SET FOREIGN_KEY_CHECKS = 1;

-- DROP TABLE IF EXISTS shop;
-- DROP TABLE IF EXISTS address;

CREATE TABLE IF NOT EXISTS address (

address_id INT PRIMARY KEY AUTO_INCREMENT,
shop_id INT,
city VARCHAR(100),
area VARCHAR(100),
street VARCHAR(100),
details TEXT,
zip_code VARCHAR(20),
Bulding_no VARCHAR(20),

   FOREIGN KEY (shop_id)
       REFERENCES shop(shop_id)
);

CREATE TABLE IF NOT EXISTS orders (

    order_id INT PRIMARY KEY AUTO_INCREMENT,
    shop_id INT,
    address_id INT,
    total_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    final_price DECIMAL(10,2),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (shop_id)
		REFERENCES shop(shop_id),

    FOREIGN KEY (address_id)
        REFERENCES address(address_id)
);

CREATE TABLE IF NOT EXISTS order_item (

    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id)
		REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

CREATE TABLE IF NOT EXISTS payment (

    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    method VARCHAR(50),
    status VARCHAR(50),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

CREATE TABLE IF NOT EXISTS supplier_company (

    supplier_company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    supplier_type VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS purchase (

    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_company_id INT NOT NULL,
    total_cost DECIMAL(10,2),
    discount DECIMAL(10,2),
    final_price DECIMAL(10,2),
    status VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (supplier_company_id)
        REFERENCES supplier_company(supplier_company_id)
);

CREATE TABLE IF NOT EXISTS purchase_items (

    purchase_item_id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    cost_price DECIMAL(10 , 2 ),
    FOREIGN KEY (purchase_id)
        REFERENCES purchase (purchase_id),
        
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
);

CREATE TABLE IF NOT EXISTS employee (

    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100),
    phone VARCHAR(20),
    salary DECIMAL(10,2),
    email VARCHAR(100),
    address_id INT,

    FOREIGN KEY (address_id)
        REFERENCES address(address_id)
);

CREATE TABLE IF NOT EXISTS employee_order (
    employee_id INT,
    order_id INT,
    role_in_order VARCHAR(50),
    PRIMARY KEY (employee_id, order_id),

    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

CREATE TABLE IF NOT EXISTS employee_purchase (
    employee_id INT,
    purchase_id INT,

    PRIMARY KEY (employee_id, purchase_id),

    FOREIGN KEY (employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY (purchase_id)
        REFERENCES purchase(purchase_id)
);


