/*
================================================================================
  ABAD Network for Training | معهد شبكة أباد للتدريب
  Course: Data Quality Management | إدارة جودة البيانات
  Instructor: Eng. Mohamed Alswaify

  Script: 01_Create_Database.sql
  Purpose: Create the training database schema (intentionally imperfect)
  Target: Microsoft SQL Server (2019+)
================================================================================
*/

IF DB_ID(N'Abad_DataQuality_Lab') IS NULL
BEGIN
    CREATE DATABASE Abad_DataQuality_Lab;
END
GO

USE Abad_DataQuality_Lab;
GO

/* Drop in dependency order if re-running */
IF OBJECT_ID('dbo.dq_exception_log','U') IS NOT NULL DROP TABLE dbo.dq_exception_log;
IF OBJECT_ID('dbo.payments','U') IS NOT NULL DROP TABLE dbo.payments;
IF OBJECT_ID('dbo.order_lines','U') IS NOT NULL DROP TABLE dbo.order_lines;
IF OBJECT_ID('dbo.orders','U') IS NOT NULL DROP TABLE dbo.orders;
IF OBJECT_ID('dbo.customer_addresses','U') IS NOT NULL DROP TABLE dbo.customer_addresses;
IF OBJECT_ID('dbo.customers','U') IS NOT NULL DROP TABLE dbo.customers;
IF OBJECT_ID('dbo.products','U') IS NOT NULL DROP TABLE dbo.products;
IF OBJECT_ID('dbo.employees','U') IS NOT NULL DROP TABLE dbo.employees;
IF OBJECT_ID('dbo.ref_cities','U') IS NOT NULL DROP TABLE dbo.ref_cities;
IF OBJECT_ID('dbo.ref_segments','U') IS NOT NULL DROP TABLE dbo.ref_segments;
GO

/* Reference: cities (incomplete on purpose — some customer cities will not match) */
CREATE TABLE dbo.ref_cities
(
    city_code   VARCHAR(10)  NOT NULL PRIMARY KEY,
    city_ar     NVARCHAR(50) NOT NULL,
    city_en     VARCHAR(50)  NOT NULL,
    region_ar   NVARCHAR(50) NULL
);

/* Reference: customer segments */
CREATE TABLE dbo.ref_segments
(
    segment_code VARCHAR(20)  NOT NULL PRIMARY KEY,
    segment_name NVARCHAR(50) NOT NULL
);

/* Employees — sales owners (some orphaned later in orders) */
CREATE TABLE dbo.employees
(
    employee_id   INT           NOT NULL PRIMARY KEY,
    full_name     NVARCHAR(100) NULL,
    email         VARCHAR(120)  NULL,
    phone         VARCHAR(30)   NULL,
    hire_date     VARCHAR(30)   NULL, -- stored as text on purpose (timeliness/validity issues)
    is_active     VARCHAR(10)   NULL  -- mixed Yes/Y/1/true
);

/* Products — catalog with price/code problems */
CREATE TABLE dbo.products
(
    product_id    VARCHAR(20)    NOT NULL PRIMARY KEY,
    product_name  NVARCHAR(120)  NULL,
    category      NVARCHAR(50)   NULL,
    unit_price    DECIMAL(18,2)  NULL,
    currency      VARCHAR(10)    NULL,
    is_active     VARCHAR(10)    NULL
);

/* Customers — main dirty master data */
CREATE TABLE dbo.customers
(
    customer_id     VARCHAR(20)    NOT NULL, -- NOT unique on purpose (duplicates)
    full_name       NVARCHAR(120)  NULL,
    email           VARCHAR(150)   NULL,
    phone           VARCHAR(40)    NULL,
    city            NVARCHAR(60)   NULL,
    national_id     VARCHAR(30)    NULL,
    segment         VARCHAR(30)    NULL,
    status          VARCHAR(30)    NULL,
    created_at      VARCHAR(40)    NULL, -- mixed date formats
    updated_at      VARCHAR(40)    NULL,
    credit_limit    DECIMAL(18,2)  NULL,
    source_system   VARCHAR(30)    NULL, -- CRM / WEB / PARTNER
    row_uid         INT IDENTITY(1,1) NOT NULL PRIMARY KEY -- technical key only
);

/* Addresses — free-text + missing parts */
CREATE TABLE dbo.customer_addresses
(
    address_id    INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    customer_id   VARCHAR(20)   NULL,
    address_line  NVARCHAR(200) NULL,
    city          NVARCHAR(60)  NULL,
    postal_code   VARCHAR(20)   NULL,
    is_primary    VARCHAR(10)   NULL
);

/* Orders — referential / status / amount issues */
CREATE TABLE dbo.orders
(
    order_id       VARCHAR(20)   NOT NULL, -- duplicates allowed intentionally
    customer_id    VARCHAR(20)   NULL,
    order_date     VARCHAR(40)   NULL,
    status         VARCHAR(30)   NULL,
    total_amount   DECIMAL(18,2) NULL,
    currency       VARCHAR(10)   NULL,
    sales_rep_id   INT           NULL,
    channel        VARCHAR(30)   NULL,
    row_uid        INT IDENTITY(1,1) NOT NULL PRIMARY KEY
);

/* Order lines — qty/price/product issues */
CREATE TABLE dbo.order_lines
(
    order_line_id  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    order_id       VARCHAR(20)    NULL,
    product_id     VARCHAR(20)    NULL,
    qty            INT            NULL,
    unit_price     DECIMAL(18,2)  NULL,
    line_total     DECIMAL(18,2)  NULL
);

/* Payments — consistency vs orders */
CREATE TABLE dbo.payments
(
    payment_id     VARCHAR(20)    NOT NULL PRIMARY KEY,
    order_id       VARCHAR(20)    NULL,
    payment_date   VARCHAR(40)    NULL,
    amount         DECIMAL(18,2)  NULL,
    method         VARCHAR(30)    NULL,
    status         VARCHAR(30)    NULL
);

/* Exception log table for labs (empty initially — used in monitoring labs) */
CREATE TABLE dbo.dq_exception_log
(
    exception_id   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    rule_id        VARCHAR(40)   NOT NULL,
    entity_name    VARCHAR(50)   NOT NULL,
    entity_key     VARCHAR(50)   NULL,
    field_name     VARCHAR(50)   NULL,
    bad_value      NVARCHAR(200) NULL,
    severity       VARCHAR(20)   NOT NULL,
    detected_at    DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
    status         VARCHAR(20)   NOT NULL DEFAULT 'Open', -- Open / InProgress / Closed
    assigned_to    NVARCHAR(100) NULL,
    notes          NVARCHAR(400) NULL
);
GO

PRINT 'Schema created successfully in Abad_DataQuality_Lab.';
GO
