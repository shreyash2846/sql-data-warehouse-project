/*
--------------------------------------------------------------------------------
Stored Procedure: Load Silver Layer (Bronze → Silver)
--------------------------------------------------------------------------------
Script Purpose:
This stored procedure performs the ETL (Extract, Transform, Load) process
to populate the 'silver' schema tables from the 'bronze' schema.

Actions Performed:
- Truncates all relevant tables in the silver layer.
- Inserts transformed and cleansed data from the bronze layer into silver.
- Applies business rules like formatting, default handling, and data validation.

Parameters:
None.
This stored procedure does not accept any parameters or return any values.

Usage Example:
CALL silver_load_silver();

Author: [Your Name]
Last Modified: [YYYY-MM-DD]
--------------------------------------------------------------------------------
*/


DELIMITER $$

CREATE PROCEDURE silver.load_silver()
BEGIN

-- Load crm_cust_info
TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info (
  cst_id,
  cst_key,
  cst_firstname,
  cst_lastname,
  cst_marital_status,
  cst_gndr,
  cst_create_date
)
SELECT 
  cst_id,
  cst_key,
  TRIM(cst_firstname),
  TRIM(cst_lastname),
  CASE 
    WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
    WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
    ELSE 'n/a'
  END,
  CASE 
    WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
    WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
    ELSE 'n/a'
  END,
  cst_create_date
FROM (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag
  FROM bronze.crm_cust_info
) T
WHERE flag = 1;

-- Load crm_prd_info
TRUNCATE TABLE silver.crm_prd_info;

INSERT INTO silver.crm_prd_info (
  prd_id,
  cat_id,
  prd_key,
  prd_nm,
  prd_cost,
  prd_line,
  prd_start_dt,
  prd_end_dt
)
SELECT 
  prd_id,
  REPLACE(SUBSTRING(TRIM(prd_key), 1, 5), '-', '_'),
  SUBSTRING(TRIM(prd_key), 7, LENGTH(TRIM(prd_key))),
  prd_nm,
  IFNULL(prd_cost, 0),
  CASE UPPER(TRIM(prd_line))
    WHEN 'M' THEN 'Mountain'
    WHEN 'S' THEN 'Other Sales'
    WHEN 'R' THEN 'Road'
    WHEN 'T' THEN 'Touring'
    ELSE 'n/a'
  END,
  CAST(prd_start_dt AS DATE),
  CAST(DATE_SUB(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt), INTERVAL 1 DAY) AS DATE)
FROM bronze.crm_prd_info;

-- Load crm_sales_details
TRUNCATE TABLE silver.crm_sales_details;

INSERT INTO silver.crm_sales_details (
  sls_ord_num,
  sls_prd_key,
  sls_cust_id,
  sls_order_dt,
  sls_ship_dt,
  sls_due_dt,
  sls_sales,
  sls_quantity,
  sls_price
)
SELECT 
  sls_ord_num,
  sls_prd_key,
  sls_cust_id,
  CASE WHEN sls_order_dt = 0 OR LENGTH(sls_order_dt) != 8 THEN NULL ELSE CAST(sls_order_dt AS DATE) END,
  CASE WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt) != 8 THEN NULL ELSE CAST(sls_ship_dt AS DATE) END,
  CASE WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt) != 8 THEN NULL ELSE CAST(sls_due_dt AS DATE) END,
  CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
       THEN sls_quantity * ABS(sls_price) 
       ELSE sls_sales 
  END,
  sls_quantity,
  CASE WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales / NULLIF(sls_quantity, 0) ELSE sls_price END
FROM bronze.crm_sales_details;

-- Load erp_cust_az12
TRUNCATE TABLE silver.erp_cust_az12;

INSERT INTO silver.erp_cust_az12 (
  cid,
  bdate,
  gen
)
SELECT 
  CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid)) ELSE cid END,
  CASE WHEN bdate > CURDATE() THEN NULL ELSE bdate END,
  CASE 
    WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
    WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
    ELSE 'n/a'
  END
FROM bronze.erp_cust_az12;

-- Load erp_loc_a101
TRUNCATE TABLE silver.erp_loc_a101;

INSERT INTO silver.erp_loc_a101 (
  cid,
  cntry
)
SELECT 
  REPLACE(cid, '-', ''),
  CASE 
    WHEN TRIM(cntry) = 'DE' THEN 'Germany'
    WHEN TRIM(cntry) IS NULL OR TRIM(cntry) = '' THEN 'n/a'
    WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
    ELSE cntry
  END
FROM bronze.erp_loc_a101;

-- Load erp_px_cat_g1v2
TRUNCATE TABLE silver.erp_px_cat_g1v2;

INSERT INTO silver.erp_px_cat_g1v2 (
  id,
  cat,
  subcat,
  maintenance
)
SELECT 
  id,
  cat,
  subcat,
  maintenance
FROM bronze.erp_px_cat_g1v2;

END $$

DELIMITER ;
CALL silver_load_silver();
