/*
================================================================================
  02_Seed_Dirty_Data.sql
  Loads intentionally dirty data covering ALL course dimensions:
  Accuracy, Completeness, Consistency, Timeliness, Validity, Uniqueness,
  Integrity, Conformity — plus multi-system / business-rule failures.
================================================================================
*/
USE Abad_DataQuality_Lab;
GO

DELETE FROM dbo.dq_exception_log;
DELETE FROM dbo.payments;
DELETE FROM dbo.order_lines;
DELETE FROM dbo.orders;
DELETE FROM dbo.customer_addresses;
DELETE FROM dbo.customers;
DELETE FROM dbo.products;
DELETE FROM dbo.employees;
DELETE FROM dbo.ref_segments;
DELETE FROM dbo.ref_cities;
GO

/* -------- Reference data (intentionally incomplete) -------- */
INSERT INTO dbo.ref_cities (city_code, city_ar, city_en, region_ar) VALUES
('RYD', N'الرياض', 'Riyadh', N'الوسطى'),
('JED', N'جدة', 'Jeddah', N'مكة'),
('DMM', N'الدمام', 'Dammam', N'الشرقية'),
('MAK', N'مكة', 'Makkah', N'مكة'),
('MED', N'المدينة', 'Madinah', N'المدينة');
-- Missing: Tabuk, Abha, Qassim, Khobar, etc. (customers will use them)

INSERT INTO dbo.ref_segments (segment_code, segment_name) VALUES
('VIP', N'VIP'),
('REGULAR', N'Regular'),
('NEW', N'New');
-- Missing: GOLD / Partner variants that appear in customers

/* -------- Employees -------- */
INSERT INTO dbo.employees (employee_id, full_name, email, phone, hire_date, is_active) VALUES
(101, N'سلمان الحربي', 'salman@abad.local', '0551112233', '2020-01-10', 'Yes'),
(102, N'نورة العتيبي', 'noura@abad.local', '+966552223344', '15/03/2019', 'Y'),
(103, N'فهد القحطاني', 'fahd@@abad.local', '053', '2021/07/01', '1'),
(104, NULL, 'ghost@abad.local', NULL, '2099-01-01', 'true'), -- future hire + missing name
(105, N'ريم الدوسري', 'reem@abad.local', '0566667777', '01-02-2022', 'No');
-- employee 999 will be referenced by orders but does not exist (orphan)

/* -------- Products -------- */
INSERT INTO dbo.products (product_id, product_name, category, unit_price, currency, is_active) VALUES
('P01', N'Laptop Pro 14', N'Electronics', 4500.00, 'SAR', 'Y'),
('P02', N'Wireless Mouse', N'Electronics', 85.00, 'SAR', 'Yes'),
('P03', N'Office Chair', N'Furniture', 650.00, 'SR', '1'),          -- currency non-standard
('P04', N'USB Hub', N'Electronics', -10.00, 'SAR', 'Y'),               -- negative price
('P05', NULL, N'Electronics', 120.00, 'SAR', 'Y'),                     -- missing name
('P06', N'Desk Lamp', NULL, 90.00, 'USD', 'Y'),                         -- mixed currency
('P07', N'Notebook Pack', N'Stationery', NULL, 'SAR', 'Y'),             -- missing price
('P08', N'Discontinued Phone', N'Electronics', 0.00, 'SAR', 'N');

/* -------- Customers (many DQ issues) -------- */
INSERT INTO dbo.customers
(customer_id, full_name, email, phone, city, national_id, segment, status, created_at, updated_at, credit_limit, source_system)
VALUES
-- Duplicate pair: same person, different IDs/formats
('C001', N'أحمد العتيبي', 'ahmad@mail.com', '0512345678', N'الرياض', '1002003001', 'VIP', 'Active', '2024-01-15', '2024-06-01', 20000, 'CRM'),
('C002', N'احمد العتيبي', 'ahmad@mail.com', '512345678', 'Riyadh', '1002003001', 'vip', 'active', '15/01/2024', '01-06-2024', 20000, 'WEB'),

('C003', N'سارة القحطاني', 'sara.q@mail.com', '+966501112233', N'جدة', '1002003002', 'REGULAR', 'Active', '2024-02-01', '2024-02-01', 5000, 'CRM'),
('C004', N'سارة القحطاني', NULL, '0501112233', N'جده', NULL, 'Regular', 'Active', '2024-02-01', NULL, 5000, 'PARTNER'), -- missing email/national_id, city spelling

('C005', N'خالد الشهري', 'khaled@@mail', '059999', N'الدمام', '1002003003', 'VIP', 'Closed', '2023-11-20', '2024-01-01', -1000, 'CRM'), -- bad email/phone/credit

('C006', N'نورة الدوسري', 'noura@mail.com', '0555555555', NULL, '1002003004', 'REGULAR', 'Active', '2024-03-10', '2024-03-10', 3000, 'WEB'), -- missing city

('C007', N'محمد الغامدي', 'm.ghamdi@mail.com', '+966557778899', N'الرياض', '1002003005', 'VIP', 'Active', '2024-03-12', '2024-03-12', 15000, 'CRM'),
('C008', 'Mohammed Al-Ghamdi', 'm.ghamdi@mail.com', '0557778899', 'Riyadh', '1002003005', 'Vip', 'ACTIVE', '12-03-2024', '12-03-2024', 15000, 'WEB'),

('C009', N'هند المطيري', 'hind@mail.com', '0533334444', N'مكة', '1002003006', 'REGULAR', 'Pending', '2024/04/01', '2024/04/01', 2000, 'CRM'),
('C010', NULL, 'unknown@mail.com', '0500000000', N'المدينة', '1002003007', 'REGULAR', 'Active', '2024-04-05', '2024-04-05', 1000, 'WEB'), -- missing name

('C011', N'فهد الحربي', 'fahd@mail.com', '0544443333', N'الرياض', '1002003008', 'REGULAR', 'Active', '2025-01-01', '2025-01-01', 4000, 'CRM'),
('C012', N'فهد حربي', 'fahd.harbi@mail.com', '0544443333', N'الرياض', '1002003008', 'REGULAR', 'Active', '2024-05-01', '2024-05-01', 4000, 'PARTNER'),

('C013', N'ريم العتيبي', 'reem@mail.com', '0566667777', N'الخبر', 'ABCDEFG', 'REGULAR', 'Inactive', '01-06-2024', '01-06-2024', 2500, 'CRM'), -- city not in ref, bad national_id

('C014', N'يوسف الزهراني', 'yousef@mail.com', NULL, N'أبها', '1002003010', 'VIP', 'Active', '2024-06-15', '2024-06-15', 12000, 'WEB'), -- missing phone

('C015', N'لينا الشهري', 'lina@mail.com', '0577778888', N'الدمام', '1002003011', 'GOLD', 'Active', '2024-07-01', '2024-07-01', 3500, 'CRM'), -- segment not in ref

('C016', 'Test User', 'test@test.com', '0111111111', 'TestCity', '0000000000', 'REGULAR', 'Active', '2099-01-01', '2099-01-01', 999999, 'WEB'), -- future date / fake

('C017', N'عبدالله السبيعي', 'abdullah@mail.com', '0588889999', N'القصيم', '1002003012', 'REGULAR', 'Active', '2024-08-20', '2024-08-20', 2800, 'CRM'),
('C018', N'عبد الله السبيعي', 'abdullah@mail.com', '+966588889999', N'قصيم', '1002003012', 'regular', 'active', '20/08/2024', '20/08/2024', 2800, 'WEB'),

('C019', N'منى العتيبي', 'mona@mail.com', '0591112222', N'تبوك', NULL, 'REGULAR', 'Active', '2024-09-01', '2024-09-01', 2200, 'PARTNER'),
('C020', N'سعيد الدوسري', 'said@mail.com', '0592223333', N'الرياض', '1002003014', 'VIP', 'Closed', '2024-09-10', '2024-09-10', 8000, 'CRM'),

-- Exact duplicate customer_id (uniqueness failure)
('C003', N'سارة القحطاني نسخة', 'sara.dup@mail.com', '0509998877', N'جدة', '1999999999', 'NEW', 'Active', '2024-10-01', '2024-10-01', 1000, 'WEB'),

-- Stale update (timeliness): created recently but updated_at old / null chaos
('C021', N'ماجد العمري', 'majed@mail.com', '0593334444', 'Jeddah', '1002003015', 'REGULAR', 'Actve', '2024-11-01', '2020-01-01', 1500, 'CRM'), -- status typo Actve

('C022', N'هدى الشمري', '', '05abcd', N'الرياض', '1002003016', 'REGULAR', 'Active', '2024-11-15', '2024-11-15', NULL, 'WEB'); -- empty email, bad phone, null credit

/* -------- Addresses -------- */
INSERT INTO dbo.customer_addresses (customer_id, address_line, city, postal_code, is_primary) VALUES
('C001', N'حي النرجس، شارع أنس', N'الرياض', '12345', 'Y'),
('C001', N'فرع ثاني بدون مدينة', NULL, NULL, 'N'),                 -- incomplete
('C003', N'حي الصفا', N'جدة', 'ABCDE', 'Yes'),                      -- bad postal
('C006', N'عنوان فقط', NULL, '21514', '1'),                          -- missing city
('C014', NULL, N'أبها', '62529', 'Y'),                               -- missing line
('C999', N'عنوان لعميل غير موجود', N'الرياض', '11111', 'Y'),         -- orphan customer
('C016', 'Somewhere', 'TestCity', '00000', 'Y');

/* -------- Orders -------- */
INSERT INTO dbo.orders (order_id, customer_id, order_date, status, total_amount, currency, sales_rep_id, channel) VALUES
('O1001', 'C001', '2024-02-10', 'Shipped', 1250.50, 'SAR', 101, 'Web'),
('O1002', 'C999', '2024-02-11', 'Shipped', 300.00, 'SAR', 101, 'Web'),          -- orphan customer
('O1003', 'C003', '11/02/2024', 'shipped', 450.00, 'SR', 102, 'Store'),         -- format/case/currency
('O1004', 'C005', '2024-02-12', 'Cancelled', 900.00, 'SAR', 102, 'Web'),
('O1005', 'C005', '2024-02-12', 'Shipped', 900.00, 'SAR', 102, 'Web'),          -- contradictory statuses same day
('O1006', 'C007', '2024-03-01', 'Open', -50.00, 'SAR', 103, 'Web'),             -- negative amount
('O1007', 'C010', '2024-03-05', 'Shipped', 120.00, 'SAR', 999, 'Partner'),      -- orphan sales_rep
('O1008', 'C014', '05-03-2024', 'Open', 700.00, 'SAR', 101, 'Web'),
('O1009', 'C015', '2024-07-02', 'Shipped', 220.00, 'USD', 105, 'Web'),          -- currency mismatch vs products SAR
('O1010', 'C016', '2024-07-03', 'Shipped', 1000000.00, 'SAR', 104, 'Web'),      -- outlier amount
('O1011', 'C020', '2024-09-11', 'Open', 500.00, 'SAR', 101, 'Web'),             -- closed customer still ordering
('O1012', NULL, '2024-09-12', 'Shipped', 80.00, 'SAR', 101, 'Web'),             -- missing customer_id
('O1001', 'C001', '2024-02-10', 'Shipped', 1250.50, 'SAR', 101, 'Web'),         -- duplicate order_id
('O1013', 'C017', '2025-12-31', 'Pending', 60.00, 'SAR', 102, 'Store'),         -- future order date
('O1014', 'C019', '2024-09-20', 'Delivered', NULL, 'SAR', 102, 'Web');          -- null amount

/* -------- Order lines -------- */
INSERT INTO dbo.order_lines (order_id, product_id, qty, unit_price, line_total) VALUES
('O1001', 'P01', 2, 4500.00, 9000.00),          -- inconsistent with order.total_amount
('O1001', 'P02', 1, 85.00, 85.00),
('O1003', 'P03', 0, 650.00, 0.00),              -- qty = 0
('O1006', 'P04', 1, -10.00, -10.00),
('O1007', 'P99', 2, 60.00, 120.00),             -- product not found
('O1008', 'P02', NULL, 85.00, NULL),            -- missing qty
('O1009', 'P06', 1, 90.00, 90.00),
('O1010', 'P01', 500, 4500.00, 2250000.00),     -- extreme qty; != order total
('O1011', 'P08', 1, 0.00, 0.00),                -- discontinued product sold
('O1014', 'P02', 2, 85.00, 170.00),
('O7777', 'P01', 1, 4500.00, 4500.00);          -- orphan order_id

/* -------- Payments (consistency issues) -------- */
INSERT INTO dbo.payments (payment_id, order_id, payment_date, amount, method, status) VALUES
('PAY01', 'O1001', '2024-02-11', 1250.50, 'Card', 'Captured'),
('PAY02', 'O1004', '2024-02-13', 900.00, 'Card', 'Captured'),   -- paid but order cancelled
('PAY03', 'O1006', '2024-03-02', 50.00, 'Cash', 'Captured'),    -- order amount was -50
('PAY04', 'O1010', '2024-07-04', 100.00, 'Card', 'Captured'),   -- huge underpayment vs order
('PAY05', 'O8888', '2024-08-01', 200.00, 'Transfer', 'Captured'), -- orphan order
('PAY06', 'O1011', '2099-01-01', 500.00, 'Card', 'Pending'),    -- future payment date
('PAY07', 'O1014', '2024-09-21', 170.00, 'Card', 'Captured');   -- order.total null but payment exists
GO

PRINT 'Dirty seed data loaded.';
PRINT 'Use Labs guide to explore issues — solutions are in a separate file.';
GO
