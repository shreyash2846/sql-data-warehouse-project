/*
=====================================================
DDL Script: Create Gold Views
=====================================================

Script Purpose:
This script creates views for the **Gold Layer** in the data warehouse.
The Gold Layer represents the final **dimension** and **fact** tables 
following a **Star Schema** model.

Each view:
- Performs necessary data transformations.
- Combines and enriches data from the Silver Layer.
- Prepares business-ready datasets for reporting and analytics.

Usage:
- These views can be queried directly for dashboards, reporting tools, 
  or ad-hoc business analysis.

Author: [Yash]

*/

CREATE VIEW gold.dim_customers AS 

SELECT 
ROW_NUMBER() OVER(ORDER BY cst_id) AS Customer_Key,
	ci.cst_id AS Customer_Id,
	ci.cst_key as Customer_Number,
	ci.cst_firstname as First_Name,
	ci.cst_lastname as Last_Name,
     la.cntry as Country,
	ci.cst_marital_status as Marital_Status,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
     ELSE COALESCE(ca.gen,'n/a') 
     END AS Gender,
	ca.bdate as Birthdate,
	ci.cst_create_date as Create_Date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
============================================================================================
CREATE VIEW gold.dim_products AS 
SELECT 
ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt,pn.prd_key) AS Product_Key,
pn.prd_id AS Product_Id,
pn.prd_key AS Product_Number,
pn.prd_nm AS Product_Name,
pn.cat_id AS Category_Id,
pc.cat AS Category,
pc.subcat AS Subcategory,
pc.maintenance AS Maintenance,
pn.prd_cost AS Cost,
pn.prd_line AS Product_Line,
pn.prd_start_dt AS Start_Date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL

==========================================================================================================

CREATE VIEW gold.fact_sales AS
SELECT 
sd.sls_ord_num as Order_Number,
pr.Product_Key,
cu.Customer_Key,
sd.sls_order_dt as Order_Date,
sd.sls_ship_dt as Ship_Date,
sd.sls_due_dt as Due_Date,
sd.sls_sales as Sales_Amount,
sd.sls_quantity as Quantity,
sd.sls_price as Price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.Product_Number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id  = cu.Customer_Id




