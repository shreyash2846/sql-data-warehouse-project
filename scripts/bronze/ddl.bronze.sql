-- :::::::003000333333g585555555111
-- DDL Script: Create Bronze Tables

-- Script Purpose:
-- This script creates tables in the 'bronze' schema of the DataWarehouse database,
-- dropping existing tables if they already exist.
-- Run this script to re-define the DDL structure of 'bronze' tables.

-- STEP 1: Create and Use the Database
CREATE DATABASE IF NOT EXISTS DataWarehouse;
USE DataWarehouse;

-- STEP 2: Create Schema if Not Exists
CREATE SCHEMA IF NOT EXISTS bronze;

-- STEP 3: Drop and Create Bronze Tables

-- Table: bronze.crm_cust_info
DROP TABLE IF EXISTS bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);

-- Table: bronze.crm_prd_info
DROP TABLE IF EXISTS bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);

-- Table: bronze.crm_sales_details
DROP TABLE IF EXISTS bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- Table: bronze.erp_loc_a101
DROP TABLE IF EXISTS bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

-- Table: bronze.erp_cust_az12
DROP TABLE IF EXISTS bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
    cid VARCHAR(50),
    bdate DATE,
    gen VARCHAR(50)
);

-- Table: bronze.erp_px_cat_g1v2
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);
