# QuickMart Retail Store Database System

## Overview
This repository contains the Relational Database Management System (RDBMS) design and 
PostgreSQL script for **QuickMart Retail Store**. The project migrates QuickMart's 
operations from flat spreadsheets into a fully structured, normalized database.

## Database Architecture

The schema is built around three core entities connected via relational keys:

*   **Customers**: Stores contact details, locations, and registration dates.

*   **Products**: Stores inventory items, categories, pricing, stock levels, and brands.

*   **Sales**: Transaction ledger linking customers and products via Foreign Key constraints.

```
Customers (1) <---> (N) Sales (N) <---> (1) Products
```

## Setup & Installation

1. Install [PostgreSQL](https://www.postgresql.org/) and pgAdmin/psql.


2. Clone this repository:

   ```bash

   git clone [https://github.com/your-username/quickmart-db-project.git](https://github.com/your-username/quickmart-db-project.git)
   cd quickmart-db-project

   ```

3. Initialize the database schema and populate data:

   ```bash

   psql -U postgres -d quickmart_db -f quickmart_db.sql
   ```


## Folder Structure
```text

quickmart-retail-store-database/
├── quickmart_retail_store.sql  # SQL Script (DDL, DML, DQL, and Upsert operations)
├── README.md         # Project documentation
└── screenshots/      # Query execution output images
    ├── table_creation.png
    ├── select_queries.png
    └── final_challenges.png


```

