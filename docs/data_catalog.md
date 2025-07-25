# 🟡 **Data Catalog – Gold Layer**

### **Overview**

The **Gold Layer** is the business-level data representation, structured to support analytical and reporting use cases.
It consists of **dimension tables** and **fact tables** designed to track key business metrics.

---

## 🧑‍💼 1. `gold.dim_customers`

**Purpose**: Stores customer details enriched with demographic and geographic data.

| **Column Name**   | **Data Type** | **Description**                                                                 |
| ----------------- | ------------- | ------------------------------------------------------------------------------- |
| `customer_key`    | INT           | Surrogate key uniquely identifying each customer record in the dimension table. |
| `customer_id`     | INT           | Unique numerical identifier assigned to each customer.                          |
| `customer_number` | NVARCHAR(50)  | Alphanumeric identifier representing the customer, used for tracking.           |
| `first_name`      | NVARCHAR(50)  | The customer's first name, as recorded in the system.                           |
| `last_name`       | NVARCHAR(50)  | The customer's last name or family name.                                        |
| `country`         | NVARCHAR(50)  | The country of residence (e.g., 'Australia').                                   |
| `marital_status`  | NVARCHAR(50)  | Marital status (e.g., 'Married', 'Single').                                     |
| `gender`          | NVARCHAR(50)  | Gender of the customer (e.g., 'Male', 'Female', 'n/a').                         |
| `birthdate`       | DATE          | Date of birth formatted as YYYY-MM-DD (e.g., 1971-10-06).                       |
| `create_date`     | DATE          | Date when the customer record was created in the system.                        |

---

## 📦 2. `gold.dim_products`

**Purpose**: Provides information about the products and their attributes.

| **Column Name**        | **Data Type** | **Description**                                                             |
| ---------------------- | ------------- | --------------------------------------------------------------------------- |
| `product_key`          | INT           | Surrogate key uniquely identifying each product record.                     |
| `product_id`           | INT           | Unique identifier assigned to the product for internal tracking.            |
| `product_number`       | NVARCHAR(50)  | Alphanumeric code representing the product for categorization or inventory. |
| `product_name`         | NVARCHAR(50)  | Descriptive name including type, color, size, etc.                          |
| `category_id`          | NVARCHAR(50)  | Unique ID for the product's high-level classification.                      |
| `category`             | NVARCHAR(50)  | Broad classification (e.g., Bikes, Components).                             |
| `subcategory`          | NVARCHAR(50)  | Detailed classification within the category.                                |
| `maintenance_required` | NVARCHAR(50)  | Whether the product needs maintenance (e.g., 'Yes', 'No').                  |
| `cost`                 | INT           | Cost or base price in monetary units.                                       |
| `product_line`         | NVARCHAR(50)  | Product line or series (e.g., Road, Mountain).                              |
| `start_date`           | DATE          | Date when the product became available.                                     |

---

## 💰 3. `gold.fact_sales`

**Purpose**: Stores transactional sales data for analytical purposes.

| **Column Name** | **Data Type** | **Description**                                               |
| --------------- | ------------- | ------------------------------------------------------------- |
| `order_number`  | NVARCHAR(50)  | Unique alphanumeric ID for the sales order (e.g., 'SO54496'). |
| `product_key`   | INT           | Surrogate key linking to the product dimension.               |
| `customer_key`  | INT           | Surrogate key linking to the customer dimension.              |
| `order_date`    | DATE          | Date when the order was placed.                               |
| `shipping_date` | DATE          | Date when the order was shipped to the customer.              |
| `due_date`      | DATE          | Date when the payment was due.                                |
| `sales_amount`  | INT           | Total monetary value of the sale (e.g., 25).                  |
| `quantity`      | INT           | Number of product units ordered (e.g., 1).                    |
| `price`         | INT           | Price per unit for the product, in currency units (e.g., 25). |

---

