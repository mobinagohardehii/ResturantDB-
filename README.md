# ResturantDB-
This project is a **Restaurant Management System** built with SQL. It manages customers, orders, foods, transactions, reviews, and employees. Features include order tracking, food management, transaction processing, and profit analysis. Ideal for efficient restaurant operations.
Certainly! Here's the English version of the `description` section for your `README.md` file:

---

## Description

This project is a **Restaurant Management System** implemented using SQL database. The system includes various tables such as Customers, Orders, Foods, Transactions, Reviews, and Employees. Additionally, several stored procedures have been implemented to perform operations like adding customers, placing orders, managing food items, and calculating daily, weekly, and monthly profits.

The system is designed to help restaurant owners manage their operations efficiently by providing tools to track customer orders, manage inventory, process transactions, and analyze sales performance. It also allows customers to leave reviews for food items, helping the restaurant improve its services.

---

### Key Features:
- **Customer Management**: Add, edit, delete, and view customer information.
- **Order Management**: Place new orders, view order details, and delete orders.
- **Food Management**: Add, edit, and remove food items from the restaurant menu.
- **Transaction Management**: Record financial transactions related to orders.




# پروژه سیستم مدیریت رستوران (Restaurant Management System)

این پروژه یک سیستم مدیریت رستوران است که با استفاده از پایگاه داده SQL پیاده‌سازی شده است. این سیستم شامل جداول مختلفی مانند مشتریان، سفارشات، غذاها، تراکنش‌ها، نظرات و کارمندان است. همچنین، تعدادی stored procedure برای انجام عملیات‌های مختلف مانند افزودن مشتری، ثبت سفارش، مدیریت غذاها و محاسبه سود روزانه، هفتگی و ماهانه پیاده‌سازی شده است.

## ویژگی‌های پروژه

- **مدیریت مشتریان**: افزودن، ویرایش، حذف و مشاهده اطلاعات مشتریان.
- **مدیریت سفارشات**: ثبت سفارشات جدید، مشاهده سفارشات و حذف سفارشات.
- **مدیریت غذاها**: افزودن، ویرایش و حذف غذاها از منوی رستوران.
- **مدیریت تراکنش‌ها**: ثبت تراکنش‌های مالی مربوط به سفارشات.
- **مدیریت نظرات**: ثبت و مشاهده نظرات مشتریان درباره غذاها.
- **گزارش‌گیری**: محاسبه سود روزانه، هفتگی و ماهانه، مشاهده پرطرفدارترین غذاها و بررسی تراکنش‌ها.

## جداول پایگاه داده

- **Customer**: اطلاعات مشتریان.
- **Order**: اطلاعات سفارشات.
- **Transaction**: اطلاعات تراکنش‌های مالی.
- **Categories**: دسته‌بندی‌های غذاها.
- **Foods**: اطلاعات غذاها.
- **OrderItems**: آیتم‌های سفارش.
- **Reviews**: نظرات مشتریان درباره غذاها.
- **Employees_Categories**: دسته‌بندی‌های کارمندان.
- **Employees**: اطلاعات کارمندان.

## Stored Procedures

- **AddCustomer**: افزودن مشتری جدید.
- **GetAllCustomers**: دریافت لیست تمام مشتریان.
- **GetCustomerById**: دریافت اطلاعات یک مشتری بر اساس شناسه.
- **UpdateCustomer**: ویرایش اطلاعات مشتری.
- **DeleteCustomer**: حذف مشتری.
- **AddOrder**: ثبت سفارش جدید.
- **GetAllOrders**: دریافت لیست تمام سفارشات.
- **AddFood**: افزودن غذا به منو.
- **GetAllFoods**: دریافت لیست تمام غذاها.
- **AddTransaction**: ثبت تراکنش مالی.
- **DeleteOrderAndItems**: حذف سفارش و آیتم‌های مربوطه.
- **GetCustomerOrderCount**: تعداد سفارش‌های هر مشتری.
- **GetTransactionSummary**: خلاصه تراکنش‌ها در بازه‌های زمانی مختلف.
- **GetMostOrderedItems**: دریافت پرطرفدارترین غذاها.
- **GetDailySales**: محاسبه فروش روزانه.
- **GetBestReviews**: دریافت بهترین نظرات درباره غذاها.
- **CalculateProfit**: محاسبه سود روزانه، هفتگی و ماهانه.

## نحوه راه‌اندازی

1. **پایگاه داده**: ابتدا پایگاه داده `ResturantDB` را در SQL Server ایجاد کنید.
2. **اجرای اسکریپت‌ها**:
   - فایل `p1-resturantdb.sql` را اجرا کنید تا جداول و ساختار پایگاه داده ایجاد شود.
   - فایل `p1spl.sql` را اجرا کنید تا stored procedureها ایجاد شوند.
   - فایل `SQLQuery1.sql` را اجرا کنید تا داده‌های نمونه وارد پایگاه داده شوند.
3. **اتصال به پایگاه داده**: از طریق کدهای خود (مثلاً در #C یا هر زبان برنامه‌نویسی دیگر) به پایگاه داده متصل شوید و از stored procedureها استفاده کنید.

## نمونه‌های استفاده

- **افزودن مشتری جدید**:
  ```sql
  EXEC AddCustomer 4, 'Mohammad', 'mohammad@example.com', '09121234570', 'Isfahan', '2024-04-05';
