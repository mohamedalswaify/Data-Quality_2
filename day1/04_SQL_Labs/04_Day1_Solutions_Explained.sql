/*
================================================================================
  Day 1 — SQL Solutions with explanations (run after 01 + 02)
  اليوم 1: حلول المعامل مع تعليقات الشرح
================================================================================
*/
USE Abad_DataQuality_Lab;
GO

/* ---------- Warm-up: SELECT basics ---------- */
-- SELECT = اختر أعمدة، FROM = من جدول، WHERE = صفِّ، TOP = أول N
SELECT TOP 5 customer_id, full_name, phone FROM dbo.customers;
GO

/* ---------- Lab A: counts ---------- */
-- UNION ALL يلصق نتائج العد في قائمة واحدة
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM dbo.customers
UNION ALL SELECT 'orders', COUNT(*) FROM dbo.orders
UNION ALL SELECT 'order_lines', COUNT(*) FROM dbo.order_lines
UNION ALL SELECT 'products', COUNT(*) FROM dbo.products
UNION ALL SELECT 'payments', COUNT(*) FROM dbo.payments
UNION ALL SELECT 'employees', COUNT(*) FROM dbo.employees
UNION ALL SELECT 'customer_addresses', COUNT(*) FROM dbo.customer_addresses
UNION ALL SELECT 'ref_cities', COUNT(*) FROM dbo.ref_cities;
GO

SELECT TOP 20 * FROM dbo.customers ORDER BY row_uid;
SELECT TOP 20 * FROM dbo.orders ORDER BY row_uid;
GO

/* ---------- Lab C: Completeness ---------- */
-- CASE يحسب 1 للمكتمل و 0 للناقص، ثم نحول إلى نسبة مئوية
SELECT
    COUNT(*) AS total_rows,
    CAST(100.0 * SUM(CASE WHEN full_name IS NOT NULL AND LTRIM(RTRIM(full_name)) <> N'' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS full_name_pct,
    CAST(100.0 * SUM(CASE WHEN email IS NOT NULL AND LTRIM(RTRIM(email)) <> '' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS email_pct,
    CAST(100.0 * SUM(CASE WHEN phone IS NOT NULL AND LTRIM(RTRIM(phone)) <> '' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS phone_pct,
    CAST(100.0 * SUM(CASE WHEN city IS NOT NULL AND LTRIM(RTRIM(city)) <> N'' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS city_pct,
    CAST(100.0 * SUM(CASE WHEN national_id IS NOT NULL AND LTRIM(RTRIM(national_id)) <> '' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS national_id_pct
FROM dbo.customers;
GO

/* ---------- Validity: bad emails ---------- */
SELECT row_uid, customer_id, email
FROM dbo.customers
WHERE email IS NOT NULL
  AND (email NOT LIKE '%_@_%._%' OR email LIKE '%@@%' OR email LIKE '% %');
GO

/* ---------- Uniqueness: duplicates ---------- */
SELECT LOWER(email) AS email_norm, COUNT(*) AS cnt
FROM dbo.customers
WHERE email IS NOT NULL AND LTRIM(RTRIM(email)) <> ''
GROUP BY LOWER(email)
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
GO

SELECT national_id, COUNT(*) AS cnt
FROM dbo.customers
WHERE national_id IS NOT NULL AND LTRIM(RTRIM(national_id)) <> ''
GROUP BY national_id
HAVING COUNT(*) > 1;
GO

SELECT customer_id, COUNT(*) AS cnt
FROM dbo.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
GO

/* ---------- Integrity preview: orphan orders ---------- */
SELECT o.order_id, o.customer_id, o.status, o.total_amount
FROM dbo.orders o
WHERE o.customer_id IS NULL
   OR NOT EXISTS (SELECT 1 FROM dbo.customers c WHERE c.customer_id = o.customer_id);
GO

PRINT 'Day 1 SQL solutions finished.';
GO
