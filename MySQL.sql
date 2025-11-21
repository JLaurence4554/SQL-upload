CREATE DATABASE inventory_management;
USE inventory_management;

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(200) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    quantity_in_stock INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 10,
    supplier_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE purchase_orders (
    po_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE purchase_order_details (
    po_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    po_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE sales_transactions (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    sale_date DATE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE sales_details (
    sale_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    FOREIGN KEY (sale_id) REFERENCES sales_transactions(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Apparel and fashion items'),
('Food & Beverages', 'Food products and drinks'),
('Home & Garden', 'Home improvement and garden supplies'),
('Sports & Outdoors', 'Sports equipment and outdoor gear');

-- Insert Suppliers
INSERT INTO suppliers (supplier_name, contact_person, phone, email, address) VALUES
('Tech Supply Co.', 'John Smith', '555-0101', 'john@techsupply.com', '123 Tech Ave, Silicon Valley, CA'),
('Fashion Wholesale', 'Maria Garcia', '555-0102', 'maria@fashionwholesale.com', '456 Fashion Blvd, New York, NY'),
('Food Distributors Inc.', 'David Lee', '555-0103', 'david@fooddist.com', '789 Food St, Chicago, IL'),
('Home Goods Supply', 'Sarah Johnson', '555-0104', 'sarah@homegoods.com', '321 Home Rd, Austin, TX'),
('Sports Gear Wholesale', 'Mike Brown', '555-0105', 'mike@sportsgear.com', '654 Sports Dr, Denver, CO');

-- Insert Products
INSERT INTO products (product_name, category_id, description, unit_price, quantity_in_stock, reorder_level, supplier_id) VALUES
('Laptop Computer', 1, '15-inch display, 8GB RAM, 256GB SSD', 799.99, 25, 5, 1),
('Wireless Mouse', 1, 'Ergonomic design, Bluetooth connectivity', 29.99, 150, 20, 1),
('USB-C Cable', 1, '6ft charging cable', 12.99, 200, 30, 1),
('Men T-Shirt', 2, 'Cotton blend, various sizes', 19.99, 100, 15, 2),
('Women Jeans', 2, 'Denim, slim fit', 49.99, 75, 10, 2),
('Organic Coffee Beans', 3, '1lb bag, medium roast', 14.99, 80, 20, 3),
('Energy Drink', 3, '12oz can, various flavors', 2.99, 300, 50, 3),
('Garden Hose', 4, '50ft, heavy duty', 34.99, 40, 10, 4),
('LED Light Bulbs', 4, '4-pack, 60W equivalent', 19.99, 120, 25, 4),
('Basketball', 5, 'Official size, indoor/outdoor', 24.99, 60, 15, 5),
('Yoga Mat', 5, 'Non-slip, eco-friendly', 29.99, 45, 10, 5);

-- Insert Customers
INSERT INTO customers (customer_name, phone, email, address) VALUES
('Alice Johnson', '555-1001', 'alice@email.com', '111 Oak St, Portland, OR'),
('Bob Williams', '555-1002', 'bob@email.com', '222 Pine St, Seattle, WA'),
('Carol Martinez', '555-1003', 'carol@email.com', '333 Maple Ave, Boston, MA'),
('David Brown', '555-1004', 'david@email.com', '444 Elm St, Miami, FL'),
('Emma Davis', '555-1005', 'emma@email.com', '555 Cedar Rd, Atlanta, GA');

-- Insert Purchase Orders
INSERT INTO purchase_orders (supplier_id, order_date, total_amount, status) VALUES
(1, '2024-01-15', 8299.75, 'Completed'),
(2, '2024-02-01', 3499.25, 'Completed'),
(3, '2024-02-10', 1799.40, 'Completed'),
(4, '2024-02-20', 2199.60, 'Pending'),
(5, '2024-03-01', 1649.45, 'Completed');

-- Insert Purchase Order Details
INSERT INTO purchase_order_details (po_id, product_id, quantity, unit_price) VALUES
(1, 1, 10, 749.99),
(1, 2, 20, 24.99),
(1, 3, 50, 10.99),
(2, 4, 100, 15.99),
(2, 5, 50, 39.99),
(3, 6, 80, 11.99),
(3, 7, 200, 1.99),
(4, 8, 40, 29.99),
(4, 9, 60, 16.99),
(5, 10, 50, 19.99),
(5, 11, 40, 24.99);

-- Insert Sales Transactions
INSERT INTO sales_transactions (customer_id, sale_date, total_amount, payment_method) VALUES
(1, '2024-03-01', 829.98, 'Credit Card'),
(2, '2024-03-02', 82.96, 'Cash'),
(3, '2024-03-03', 104.94, 'Debit Card'),
(4, '2024-03-05', 799.99, 'Credit Card'),
(5, '2024-03-06', 54.98, 'Cash'),
(1, '2024-03-08', 42.97, 'Credit Card'),
(2, '2024-03-10', 74.97, 'Debit Card'),
(3, '2024-03-12', 99.96, 'Credit Card');

-- Insert Sales Details
INSERT INTO sales_details (sale_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 799.99),
(1, 2, 1, 29.99),
(2, 3, 4, 12.99),
(2, 7, 10, 2.99),
(3, 6, 5, 14.99),
(3, 7, 10, 2.99),
(4, 1, 1, 799.99),
(5, 10, 2, 24.99),
(5, 11, 1, 29.99),
(6, 7, 12, 2.99),
(6, 6, 1, 14.99),
(7, 4, 2, 19.99),
(7, 8, 1, 34.99),
(8, 9, 5, 19.99);

UPDATE purchase_orders 
SET status = 'Completed' 
WHERE po_id = 4;

UPDATE customers 
SET phone = '555-9999', email = 'newemail@email.com' 
WHERE customer_id = 1;

UPDATE products 
SET unit_price = 849.99 
WHERE product_id = 1;

SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.quantity_in_stock,
    p.reorder_level,
    (p.reorder_level - p.quantity_in_stock) AS units_needed,
    s.supplier_name,
    s.contact_person,
    s.phone AS supplier_phone,
    s.email AS supplier_email
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE p.quantity_in_stock <= p.reorder_level
ORDER BY (p.reorder_level - p.quantity_in_stock) DESC;

SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.unit_price,
    SUM(sd.quantity) AS total_quantity_sold,
    SUM(sd.quantity * sd.unit_price) AS total_revenue,
    COUNT(DISTINCT sd.sale_id) AS number_of_orders,
    ROUND(AVG(sd.quantity), 2) AS avg_quantity_per_order,
    p.quantity_in_stock AS current_stock
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN sales_details sd ON p.product_id = sd.product_id
GROUP BY p.product_id, p.product_name, c.category_name, p.unit_price, p.quantity_in_stock
ORDER BY total_revenue DESC
LIMIT 10;

SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
    COUNT(sale_id) AS number_of_transactions,
    SUM(total_amount) AS monthly_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(total_amount) / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM sales_transactions
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sales_month;

SELECT 
    s.supplier_name,
    s.contact_person,
    COUNT(DISTINCT po.po_id) AS total_orders,
    SUM(po.total_amount) AS total_purchase_value,
    ROUND(AVG(po.total_amount), 2) AS avg_order_value,
    SUM(CASE WHEN po.status = 'Completed' THEN 1 ELSE 0 END) AS completed_orders,
    ROUND(SUM(CASE WHEN po.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS completion_rate_percent,
    COUNT(DISTINCT p.product_id) AS products_supplied
FROM suppliers s
LEFT JOIN purchase_orders po ON s.supplier_id = po.supplier_id
LEFT JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name, s.contact_person
ORDER BY total_purchase_value DESC;

SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.quantity_in_stock AS current_stock,
    COALESCE(SUM(sd.quantity), 0) AS total_units_sold,
    p.unit_price,
    COALESCE(SUM(sd.quantity * sd.unit_price), 0) AS revenue_generated,
    CASE 
        WHEN p.quantity_in_stock > 0 
        THEN ROUND(COALESCE(SUM(sd.quantity), 0) / p.quantity_in_stock, 2)
        ELSE 0 
    END AS turnover_ratio,
    CASE
        WHEN COALESCE(SUM(sd.quantity), 0) / NULLIF(p.quantity_in_stock, 0) >= 2 THEN 'Fast Moving'
        WHEN COALESCE(SUM(sd.quantity), 0) / NULLIF(p.quantity_in_stock, 0) >= 0.5 THEN 'Moderate'
        ELSE 'Slow Moving'
    END AS movement_category
FROM products p
JOIN categories c ON p.category_id = c.category_id
LEFT JOIN sales_details sd ON p.product_id = sd.product_id
GROUP BY p.product_id, p.product_name, c.category_name, p.quantity_in_stock, p.unit_price
ORDER BY turnover_ratio DESC;

-- View all products with their categories and suppliers
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.unit_price,
    p.quantity_in_stock,
    p.reorder_level
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
ORDER BY c.category_name, p.product_name;

SELECT 
    st.sale_id,
    st.sale_date,
    c.customer_name,
    p.product_name,
    sd.quantity,
    sd.unit_price,
    (sd.quantity * sd.unit_price) AS line_total,
    st.payment_method
FROM sales_transactions st
JOIN customers c ON st.customer_id = c.customer_id
JOIN sales_details sd ON st.sale_id = sd.sale_id
JOIN products p ON sd.product_id = p.product_id
ORDER BY st.sale_date DESC, st.sale_id;

SELECT 
    po.po_id,
    po.order_date,
    s.supplier_name,
    p.product_name,
    pod.quantity,
    pod.unit_price,
    (pod.quantity * pod.unit_price) AS line_total,
    po.status
FROM purchase_orders po
JOIN suppliers s ON po.supplier_id = s.supplier_id
JOIN purchase_order_details pod ON po.po_id = pod.po_id
JOIN products p ON pod.product_id = p.product_id
ORDER BY po.order_date DESC, po.po_id;

SELECT 
    c.customer_name,
    COUNT(st.sale_id) AS total_purchases,
    SUM(st.total_amount) AS lifetime_value,
    ROUND(AVG(st.total_amount), 2) AS avg_transaction_value,
    MAX(st.sale_date) AS last_purchase_date
FROM customers c
LEFT JOIN sales_transactions st ON c.customer_id = st.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC;

SELECT 
    c.category_name,
    COUNT(DISTINCT p.product_id) AS total_products,
    SUM(p.quantity_in_stock) AS total_inventory,
    COALESCE(SUM(sd.quantity), 0) AS units_sold,
    COALESCE(SUM(sd.quantity * sd.unit_price), 0) AS category_revenue,
    ROUND(AVG(p.unit_price), 2) AS avg_product_price
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
LEFT JOIN sales_details sd ON p.product_id = sd.product_id
GROUP BY c.category_id, c.category_name
ORDER BY category_revenue DESC;

SELECT 'categories' AS table_name, COUNT(*) AS record_count FROM categories
UNION ALL
SELECT 'suppliers', COUNT(*) FROM suppliers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'purchase_orders', COUNT(*) FROM purchase_orders
UNION ALL
SELECT 'purchase_order_details', COUNT(*) FROM purchase_order_details
UNION ALL
SELECT 'sales_transactions', COUNT(*) FROM sales_transactions
UNION ALL
SELECT 'sales_details', COUNT(*) FROM sales_details;

SELECT 'Database setup complete!' AS status;