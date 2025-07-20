/*
===============================================================================
Script:       Create Database and Schemas
Purpose:      This script creates a new database named 'DataWarehouse'.
              - If the database already exists, it will be dropped and recreated.
              - It sets up three schemas: 'bronze', 'silver', and 'gold'.

WARNING:      Running this script will DROP the 'DataWarehouse' database if it exists.
              ⚠️ All data will be permanently deleted.
              ⚠️ Ensure you have proper backups before executing this script.
===============================================================================
*/

-- Step 1: Drop the existing database if it exists
DROP DATABASE IF EXISTS DataWarehouse;

-- Step 2: Create a fresh DataWarehouse database
CREATE DATABASE DataWarehouse;

-- Step 3: Switch to the newly created database
USE DataWarehouse;

-- Step 4: Create 'bronze' schema to store raw data from source systems
CREATE SCHEMA bronze;

-- Step 5: Create 'silver' schema to store cleaned and transformed data
CREATE SCHEMA silver;

-- Step 6: Create 'gold' schema for final, business-ready aggregated data
CREATE SCHEMA gold;
