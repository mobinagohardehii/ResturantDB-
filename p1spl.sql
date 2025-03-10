USE ResturantDB;

SELECT * FROM sys.tables WHERE name = 'Customer';

-- بررسی جدول Foods
SELECT * FROM sys.tables WHERE name = 'Foods';

-- بررسی جدول Transaction
SELECT * FROM sys.tables WHERE name = 'Transaction';
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddCustomer]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[AddCustomer];
GO

CREATE PROCEDURE AddCustomer
    @customer_id INT,
    @name NVARCHAR(100),
    @email NVARCHAR(100),
    @phone NVARCHAR(15),
    @address NVARCHAR(255),
    @registered_date DATE
AS
BEGIN
    INSERT INTO Customer (customer_id, name, email, phone, address, registered_date)
    VALUES (@customer_id, @name, @email, @phone, @address, @registered_date);
END;



EXEC AddCustomer 1, 'Ali', 'ali@example.com', '09121234567', 'Tehran', '2024-01-01';

GO
DROP PROCEDURE IF EXISTS GetAllCustomers;
GO

CREATE PROCEDURE GetAllCustomers
AS 
BEGIN
    SELECT * FROM Customer;
END;
GO
DROP PROCEDURE IF EXISTS GetCustomerById ;
GO
CREATE PROCEDURE GetCustomerById
    @customer_id INT
AS
BEGIN
    SELECT * FROM Customer WHERE customer_id = @customer_id;
END;



EXEC GetAllCustomers;
EXEC GetCustomerById 1;

GO
DROP PROCEDURE IF EXISTS UpdateCustomer;
GO

CREATE PROCEDURE UpdateCustomer
    @customer_id INT,
    @name NVARCHAR(100),
    @email NVARCHAR(100),
    @phone NVARCHAR(15),
    @address NVARCHAR(255)
AS
BEGIN
    UPDATE Customer
    SET name = @name, email = @email, phone = @phone, address = @address
    WHERE customer_id = @customer_id;
END;



EXEC UpdateCustomer 1, 'Ali Reza', 'ali_reza@example.com', '09121234568', 'Mashhad';
GO
DROP PROCEDURE IF EXISTS DeleteCustomer;
GO
CREATE PROCEDURE DeleteCustomer
    @customer_id INT
AS
BEGIN
    DELETE FROM Customer WHERE customer_id = @customer_id;
END;



EXEC DeleteCustomer 1;


GO
DROP PROCEDURE IF EXISTS Add_Order ;
GO

CREATE PROCEDURE Add_Order
    @order_id INT,
    @customer_id INT,
    @order_date DATE,
    @total_amount DECIMAL(10, 2),
    @status NVARCHAR(50),
    @payment_status NVARCHAR(50)
AS
BEGIN
    INSERT INTO [Order] (order_id, customer_id, order_date, total_amount, status, payment_status)
    VALUES (@order_id, @customer_id, @order_date, @total_amount, @status, @payment_status);
END;



EXEC AddOrder 101, 1, '2024-01-02', 250000, 'Processing', 'Paid';

GO
DROP PROCEDURE IF EXISTS GetAllOrders;
GO
CREATE PROCEDURE GetAllOrders
AS
BEGIN
    SELECT * FROM [Order];
END;



EXEC GetAllOrders;

GO
DROP PROCEDURE IF EXISTS AddFood;
GO
CREATE PROCEDURE AddFood
    @food_id INT,
    @category_id INT,
    @price DECIMAL(10, 2),
    @food_name NVARCHAR(100),
    @description NVARCHAR(255),
    @image_url NVARCHAR(255),
    @availability BIT
AS
BEGIN
    INSERT INTO Foods (food_id, category_id, price, food_name, description, image_url, availability)
    VALUES (@food_id, @category_id, @price, @food_name, @description, @image_url, @availability);
END;



EXEC AddFood 201, 1, 10000, 'Pizza', 'Delicious Cheese Pizza', 'http://example.com/pizza.jpg', 1;


GO
DROP PROCEDURE IF EXISTS GetAllFoods ;
GO
CREATE PROCEDURE GetAllFoods
AS
BEGIN
    SELECT * FROM Foods;
END;



EXEC GetAllFoods;

GO
DROP PROCEDURE IF EXISTS AddTransaction ;
GO

CREATE PROCEDURE AddTransaction
    @transaction_id INT,
    @order_id INT,
    @transaction_date DATE,
    @amount DECIMAL(10, 2),
    @type NVARCHAR(50),
    @description NVARCHAR(255)
AS
BEGIN
    INSERT INTO [Transaction] (transaction_id, order_id, transaction_date, amount, type, description)
    VALUES (@transaction_id, @order_id, @transaction_date, @amount, @type, @description);
END;


EXEC AddTransaction 301, 101, '2024-01-02', 250000, 'Online', 'Payment via credit card';


GO
DROP PROCEDURE IF EXISTS DeleteOrderAndItems ;
GO

CREATE PROCEDURE DeleteOrderAndItems
    @order_id INT
AS
BEGIN

    DELETE FROM OrderItems WHERE order_id = @order_id;

    DELETE FROM [Order] WHERE order_id = @order_id;
END;

EXEC DeleteOrderAndItems 101;


--تعداد سفارش های مشتری
GO
CREATE PROCEDURE GetCustomerOrderCount
AS
BEGIN
    SELECT 
        C.customer_id,
        C.name AS CustomerName,
        COUNT(O.order_id) AS OrderCount
    FROM Customer C
    LEFT JOIN [Order] O ON C.customer_id = O.customer_id
    GROUP BY C.customer_id, C.name
    ORDER BY OrderCount DESC;
END;


EXEC GetCustomerOrderCount;

-- میزان کل تراکنش‌ها در هر روز، هفته و ماه
GO
CREATE PROCEDURE GetTransactionSummary
AS
BEGIN
    SELECT 
        CONVERT(DATE, transaction_date) AS TransactionDate,
        SUM(amount) AS TotalAmount
    FROM [Transaction]
    GROUP BY CONVERT(DATE, transaction_date)
    ORDER BY TransactionDate;

    SELECT 
        DATEPART(YEAR, transaction_date) AS Year,
        DATEPART(WEEK, transaction_date) AS WeekNumber,
        SUM(amount) AS TotalAmount
    FROM [Transaction]
    GROUP BY DATEPART(YEAR, transaction_date), DATEPART(WEEK, transaction_date)
    ORDER BY Year, WeekNumber;

    SELECT 
        DATEPART(YEAR, transaction_date) AS Year,
        DATEPART(MONTH, transaction_date) AS MonthNumber,
        SUM(amount) AS TotalAmount
    FROM [Transaction]
    GROUP BY DATEPART(YEAR, transaction_date), DATEPART(MONTH, transaction_date)
    ORDER BY Year, MonthNumber;
END;



EXEC GetTransactionSummary;

-- آیتم‌هایی که بیشتر سفارش داده شدند

GO

CREATE PROCEDURE GetMostOrderedItems
AS
BEGIN
    SELECT 
        F.food_id,
        F.food_name,
        SUM(OI.quantity) AS TotalQuantityOrdered
    FROM OrderItems OI
    INNER JOIN Foods F ON OI.food_id = F.food_id
    GROUP BY F.food_id, F.food_name
    ORDER BY TotalQuantityOrdered DESC;
END;



EXEC GetMostOrderedItems;

-- مجموع کل فروش یک روز رستوران

GO

CREATE PROCEDURE GetDailySales
    @sales_date DATE
AS
BEGIN
    SELECT 
        @sales_date AS SalesDate,
        SUM(T.amount) AS TotalSales
    FROM [Transaction] T
    WHERE T.transaction_date = @sales_date;
END;



EXEC GetDailySales '2024-04-03';

-- بهترین ریویوها درباره هر غذا
GO
CREATE PROCEDURE GetBestReviews
AS
BEGIN
    SELECT 
        F.food_id,
        F.food_name,
        R.rating,
        R.comment,
        C.name AS CustomerName,
        R.review_date
    FROM Reviews R
    INNER JOIN Foods F ON R.food_id = F.food_id
    INNER JOIN Customer C ON R.customer_id = C.customer_id
    WHERE R.rating = 5
    ORDER BY F.food_name, R.review_date DESC;
END;

EXEC GetBestReviews;

GO
CREATE PROCEDURE CalculateProfit
AS
BEGIN
    -- سود روزانه
    SELECT 
        CONVERT(DATE, T.transaction_date) AS TransactionDate,
        SUM(T.amount) AS TotalSales,
        SUM(T.amount) * 0.3 AS Profit
    FROM 
        [Transaction] T
    GROUP BY 
        CONVERT(DATE, T.transaction_date)
    ORDER BY 
        TransactionDate;

    -- سود هفتگی
    SELECT 
        DATEPART(YEAR, T.transaction_date) AS Year,
        DATEPART(WEEK, T.transaction_date) AS Week,
        SUM(T.amount) AS TotalSales,
        SUM(T.amount) * 0.3 AS Profit
    FROM 
        [Transaction] T
    GROUP BY 
        DATEPART(YEAR, T.transaction_date),
        DATEPART(WEEK, T.transaction_date)
    ORDER BY 
        Year, Week;

    -- سود ماهانه
    SELECT 
        DATEPART(YEAR, T.transaction_date) AS Year,
        DATEPART(MONTH, T.transaction_date) AS Month,
        SUM(T.amount) AS TotalSales,
        SUM(T.amount) * 0.3 AS Profit
    FROM 
        [Transaction] T
    GROUP BY 
        DATEPART(YEAR, T.transaction_date),
        DATEPART(MONTH, T.transaction_date)
    ORDER BY 
        Year, Month;
END;

EXEC CalculateProfit;