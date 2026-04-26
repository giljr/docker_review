CREATE DATABASE IF NOT EXISTS outfit_db;
USE outfit_db;

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT,
    sales_code INT NOT NULL,
    date DATE NOT NULL,
    store_id VARCHAR(255),
    product VARCHAR(255),
    qty INT NOT NULL,
    unit_price DECIMAL(10, 2),
    PRIMARY KEY (id)
);

INSERT INTO products (sales_code, date, store_id, product, qty, unit_price) VALUES
(65020, '2019-02-01', 'Shopping Morumbi', 'Slim Fit Shirt', 3, 89.90),
(65021, '2019-02-02', 'Shopping Morumbi', 'Denim Jacket', 2, 189.90),
(65022, '2019-02-03', 'Iguatemi Campinas', 'Casual T-Shirt', 6, 49.90),
(65023, '2019-02-04', 'Iguatemi Campinas', 'Leather Boots', 1, 399.90),
(65024, '2019-02-05', 'Shopping Eldorado', 'Chino Pants', 4, 119.90),
(65025, '2019-02-06', 'Shopping Eldorado', 'Graphic Tee', 5, 59.90),
(65026, '2019-02-07', 'Shopping Eldorado', 'Running Shoes', 2, 299.90),
(65027, '2019-02-08', 'Shopping Morumbi', 'Formal Blazer', 1, 349.90),
(65028, '2019-02-09', 'Iguatemi Campinas', 'Hoodie Classic', 3, 149.90),
(65029, '2019-02-10', 'Shopping Morumbi', 'Cargo Shorts', 2, 99.90),
(65030, '2019-02-11', 'Shopping Eldorado', 'Sports Cap', 7, 39.90),
(65031, '2019-02-12', 'Iguatemi Campinas', 'Sweatpants', 4, 129.90),
(65032, '2019-02-13', 'Shopping Morumbi', 'Winter Coat', 1, 499.90),
(65033, '2019-02-14', 'Shopping Eldorado', 'Tank Top', 6, 34.90),
(65034, '2019-02-15', 'Iguatemi Campinas', 'Slip-On Shoes', 2, 179.90);