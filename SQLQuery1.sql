USE ResturantDB;

DELETE FROM Reviews;
DELETE FROM OrderItems;
DELETE FROM [Transaction];
DELETE FROM [Order];
DELETE FROM Foods;
DELETE FROM Categories;
DELETE FROM Employees;
DELETE FROM Employees_Categories;
DELETE FROM Customer;



-- درج داده در جدول Customer
INSERT INTO Customer (customer_id, name, email, phone, address, registered_date)
VALUES 
(1, 'Ali', 'ali@example.com', '09121234567', 'Tehran', '2024-01-01'),
(2, 'Sara', 'sara@example.com', '09121234568', 'Shiraz', '2024-02-15'),
(3, 'Reza', 'reza@example.com', '09121234569', 'Mashhad', '2024-03-10');

-- درج داده در جدول Categories
INSERT INTO Categories (category_id, category_name)
VALUES 
(1, 'starter'),
(2, 'main food'),
(3, 'dessert');

-- درج داده در جدول Foods
INSERT INTO Foods (food_id, category_id, price, food_name, description, image_url, availability)
VALUES 
(1, 1, 150000, 'Margherita Pizza', 'Cheese and Tomato Pizza', 'http://example.com/pizza1.jpg', 1),
(2, 2, 120000, 'Classic Burger', 'Beef Burger with Fries', 'http://example.com/burger1.jpg', 1),
(3, 3, 100000, 'Spaghetti', 'Spaghetti with Marinara Sauce', 'http://example.com/pasta1.jpg', 1);

-- درج داده در جدول Order
INSERT INTO [Order] (order_id, customer_id, order_date, total_amount, status, payment_status)
VALUES 
(101, 1, '2024-04-01', 250000, 'Completed', 'Paid'),
(102, 2, '2024-04-02', 120000, 'Processing', 'Pending'),
(103, 3, '2024-04-03', 100000, 'Cancelled', 'Refunded');

-- درج داده در جدول Transaction
INSERT INTO [Transaction] (transaction_id, order_id, transaction_date, amount, type, description)
VALUES 
(201, 101, '2024-04-01', 250000, 'Online', 'Paid via Credit Card'),
(202, 102, '2024-04-02', 120000, 'Cash', 'Paid in cash'),
(203, 103, '2024-04-03', 100000, 'Online', 'Payment refunded');

-- درج داده در جدول OrderItems
INSERT INTO OrderItems (order_item_id, order_id, food_id, quantity, item_price)
VALUES 
(301, 101, 1, 2, 150000),
(302, 102, 2, 1, 120000),
(303, 103, 3, 1, 100000);

-- درج داده در جدول Reviews
INSERT INTO Reviews (review_id, customer_id, food_id, rating, comment, review_date)
VALUES 
(401, 1, 1, 5, 'Excellent pizza!', '2024-04-02'),
(402, 2, 2, 4, 'Great burger, but fries were cold.', '2024-04-03'),
(403, 3, 3, 3, 'Average pasta.', '2024-04-04');

-- درج داده در جدول Employees_Categories
INSERT INTO Employees_Categories (category_id, category_name)
VALUES 
(1, 'Kitchen'),
(2, 'Service'),
(3, 'Management');

-- درج داده در جدول Employees
INSERT INTO Employees (employee_id, category_id, name, phone, email, salary, hire_date, active)
VALUES 
(501, 1, 'Ahmad', '09121234560', 'ahmad@example.com', 5000000, '2024-01-15', 1),
(502, 2, 'Zahra', '09121234561', 'zahra@example.com', 3000000, '2024-02-20', 1),
(503, 3, 'Hassan', '09121234562', 'hassan@example.com', 7000000, '2024-03-10', 1);


SELECT * FROM Customer;
SELECT * FROM Categories;
SELECT * FROM Foods;
SELECT * FROM [Order];
SELECT * FROM [Transaction];
SELECT * FROM OrderItems;
SELECT * FROM Reviews;
SELECT * FROM Employees_Categories;
SELECT * FROM Employees;