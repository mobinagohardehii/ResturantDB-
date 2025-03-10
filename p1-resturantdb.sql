
USE ResturantDB;

-- ایجاد جدول Customer
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Customer' AND xtype='U')
BEGIN
    CREATE TABLE Customer (
        customer_id INT PRIMARY KEY,
        name NVARCHAR(100) NOT NULL,
        email NVARCHAR(100),
        phone NVARCHAR(15),
        address NVARCHAR(255),
        registered_date DATE NOT NULL
    );
END

-- ایجاد جدول Order
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Order' AND xtype='U')
BEGIN
    CREATE TABLE [Order] (
        order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE NOT NULL,
        total_amount DECIMAL(10, 2) NOT NULL,
        status NVARCHAR(50),
        payment_status NVARCHAR(50),
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    );
END

-- ایجاد جدول Transaction
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Transaction' AND xtype='U')
BEGIN
    CREATE TABLE [Transaction] (
        transaction_id INT PRIMARY KEY,
        order_id INT,
        transaction_date DATE NOT NULL,
        amount DECIMAL(10, 2) NOT NULL,
        type NVARCHAR(50),
        description NVARCHAR(255),
        FOREIGN KEY (order_id) REFERENCES [Order](order_id)
    );
END

-- ایجاد جدول Categories
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Categories' AND xtype='U')
BEGIN
    CREATE TABLE Categories (
        category_id INT PRIMARY KEY,
        category_name NVARCHAR(100) NOT NULL
    );
END

-- ایجاد جدول Foods
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Foods' AND xtype='U')
BEGIN
    CREATE TABLE Foods (
        food_id INT PRIMARY KEY,
        category_id INT,
        price DECIMAL(10, 2) NOT NULL,
        food_name NVARCHAR(100) NOT NULL,
        description NVARCHAR(255),
        image_url NVARCHAR(255),
        availability BIT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES Categories(category_id)
    );
END

-- ایجاد جدول OrderItems
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OrderItems' AND xtype='U')
BEGIN
    CREATE TABLE OrderItems (
        order_item_id INT PRIMARY KEY,
        order_id INT,
        food_id INT,
        quantity INT NOT NULL,
        item_price DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (order_id) REFERENCES [Order](order_id),
        FOREIGN KEY (food_id) REFERENCES Foods(food_id)
    );
END

-- ایجاد جدول Reviews
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reviews' AND xtype='U')
BEGIN
    CREATE TABLE Reviews (
        review_id INT PRIMARY KEY,
        customer_id INT,
        food_id INT,
        rating INT CHECK (rating BETWEEN 1 AND 5),
        comment NVARCHAR(255),
        review_date DATE NOT NULL,


FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
        FOREIGN KEY (food_id) REFERENCES Foods(food_id)
    );
END

-- ایجاد جدول Employees_Categories
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Employees_Categories' AND xtype='U')
BEGIN
    CREATE TABLE Employees_Categories (
        category_id INT PRIMARY KEY,
        category_name NVARCHAR(100) NOT NULL
    );
END

-- ایجاد جدول Employees
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Employees' AND xtype='U')
BEGIN
    CREATE TABLE Employees (
        employee_id INT PRIMARY KEY,
        category_id INT,
        name NVARCHAR(100) NOT NULL,
        phone NVARCHAR(15),
        email NVARCHAR(100),
        salary DECIMAL(10, 2) NOT NULL,
        hire_date DATE NOT NULL,
        active BIT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES Employees_Categories(category_id)
    );
END

