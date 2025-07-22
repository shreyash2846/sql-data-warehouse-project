DELIMITER $$

CREATE PROCEDURE bronze_load_bronze()
BEGIN
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    DECLARE batch_start_time DATETIME;
    DECLARE batch_end_time DATETIME;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        SELECT '==========================================' AS status;
        SELECT 'ERROR OCCURRED DURING LOADING BRONZE LAYER' AS status;
    END;

    SET batch_start_time = NOW();
    SELECT '================================================' AS status;
    SELECT 'Loading Bronze Layer' AS status;
    SELECT '================================================' AS status;

    -- ================== CRM TABLES ====================
    SELECT '------------------------------------------------' AS status;
    SELECT 'Loading CRM Tables' AS status;
    SELECT '------------------------------------------------' AS status;

    -- crm_cust_info
    SET start_time = NOW();
    SELECT '>> Truncating Table: bronze.crm_cust_info' AS status;
    TRUNCATE TABLE bronze.crm_cust_info;
    SELECT '>> Inserting Data Into: bronze.crm_cust_info' AS status;
    LOAD DATA INFILE '/sql/dwh_project/datasets/source_crm/cust_info.csv'
    INTO TABLE bronze.crm_cust_info
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS status;

    -- crm_prd_info
    SET start_time = NOW();
    TRUNCATE TABLE bronze.crm_prd_info;
    SELECT '>> Inserting Data Into: bronze.crm_prd_info' AS status;
    LOAD DATA INFILE '/sql/dwh_project/datasets/source_crm/prd_info.csv'
    INTO TABLE bronze.crm_prd_info
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS status;

    -- crm_sales_details
    SET start_time = NOW();
    TRUNCATE TABLE bronze.crm_sales_details;
    SELECT '>> Inserting Data Into: bronze.crm_sales_details' AS status;
    LOAD DATA INFILE '/sql/dwh_project/datasets/source_crm/sales_details.csv'
    INTO TABLE bronze.crm_sales_details
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS status;

    -- ================== ERP TABLES ====================
    SELECT '------------------------------------------------' AS status;
    SELECT 'Loading ERP Tables' AS status;
    SELECT '------------------------------------------------' AS status;

    -- erp_loc_a101
    SET start_time = NOW();
    TRUNCATE TABLE bronze.erp_loc_a101;
    SELECT '>> Inserting Data Into: bronze.erp_loc_a101' AS status;
    LOAD DATA INFILE '/sql/dwh_project/datasets/source_erp/loc_a101.csv'
    INTO TABLE bronze.erp_loc_a101
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS status;

    -- erp_cust_az12
    SET start_time = NOW();
    TRUNCATE TABLE bronze.erp_cust_az12;
    SELECT '>> Inserting Data Into: bronze.erp_cust_az12' AS status;
    LOAD DATA INFILE '/sql/dwh_project/datasets/source_erp/cust_az12.csv'
    INTO TABLE bronze.erp_cust_az12
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS status;

    -- erp_px_cat_g1v2
    SET start_time = NOW();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    SELECT '>> Inserting Data Into: bronze.erp_px_cat_g1v2' AS status;
    LOAD DATA INFILE '/sql/dwh_project/datasets/source_erp/px_cat_g1v2.csv'
    INTO TABLE bronze.erp_px_cat_g1v2
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    SET end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS status;

    SET batch_end_time = NOW();
    SELECT '==========================================' AS status;
    SELECT 'Loading Bronze Layer is Completed' AS status;
    SELECT CONCAT('Total Load Duration: ', TIMESTAMPDIFF(SECOND, batch_start_time, batch_end_time), ' seconds') AS status;
    SELECT '==========================================' AS status;

END$$

DELIMITER ;
