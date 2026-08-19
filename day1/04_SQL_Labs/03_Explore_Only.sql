/*
================================================================================
  03_Explore_Only.sql
  Safe exploration helpers for students (NO cleaning / NO final answers).
  Run after 01 + 02.
================================================================================
*/
USE Abad_DataQuality_Lab;
GO

/* Quick inventory */
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM dbo.customers
UNION ALL SELECT 'orders', COUNT(*) FROM dbo.orders
UNION ALL SELECT 'order_lines', COUNT(*) FROM dbo.order_lines
UNION ALL SELECT 'products', COUNT(*) FROM dbo.products
UNION ALL SELECT 'payments', COUNT(*) FROM dbo.payments
UNION ALL SELECT 'employees', COUNT(*) FROM dbo.employees
UNION ALL SELECT 'customer_addresses', COUNT(*) FROM dbo.customer_addresses
UNION ALL SELECT 'ref_cities', COUNT(*) FROM dbo.ref_cities;
GO

/* Sample preview */
SELECT TOP (20) * FROM dbo.customers ORDER BY row_uid;
SELECT TOP (20) * FROM dbo.orders ORDER BY row_uid;
GO

/* Null / blank density for customers (starter profiling idea) */
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN full_name IS NULL OR LTRIM(RTRIM(full_name)) = N'' THEN 1 ELSE 0 END) AS missing_name,
    SUM(CASE WHEN email IS NULL OR LTRIM(RTRIM(email)) = '' THEN 1 ELSE 0 END) AS missing_email,
    SUM(CASE WHEN phone IS NULL OR LTRIM(RTRIM(phone)) = '' THEN 1 ELSE 0 END) AS missing_phone,
    SUM(CASE WHEN city IS NULL OR LTRIM(RTRIM(city)) = N'' THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN national_id IS NULL OR LTRIM(RTRIM(national_id)) = '' THEN 1 ELSE 0 END) AS missing_national_id
FROM dbo.customers;
GO
