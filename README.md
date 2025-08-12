# Super-Store-EDA
SQL-first exploratory analysis of the Superstore dataset in MySQL 8: state/city leaders, 2017 margins &amp; loss makers, delivery speed by ship mode, ABC classification, and category YoY growth with window functions.


---

## ✨ Highlights
- Top state by **sales** since 2015
- Top 5 **cities by profit** (2017)
- **Category profit margin** and loss-making **sub-categories** (2017)
- **Average delivery time** by ship mode (uses `DATEDIFF`)
- **ABC classification** of products via cumulative sales (window `SUM`)
- **YoY sales & profit** by category with `LAG`

---

## 🧰 Tech & Requirements
- **Database:** MySQL **8.0+** (uses window functions)
- **Primary table:** `super_store`

### Expected columns
| column           | type (recommended) | notes                                |
|------------------|--------------------|--------------------------------------|
| `state`          | TEXT/VARCHAR       |                                      |
| `city`           | TEXT/VARCHAR       |                                      |
| `category`       | TEXT/VARCHAR       |                                      |
| `sub_category`   | TEXT/VARCHAR       |                                      |
| `product_id`     | TEXT/VARCHAR       |                                      |
| `product_name`   | TEXT/VARCHAR       |                                      |
| `customer_id`    | TEXT/VARCHAR       |                                      |
| `customer_name`  | TEXT/VARCHAR       |                                      |
| `sales`          | DECIMAL(10,2)      |                                      |
| `profit`         | DECIMAL(10,2)      |                                      |
| `discount`       | DECIMAL(5,3)       | 0–1                                  |
| `quantity`       | INT                |                                      |
| `ship_mode`      | TEXT/VARCHAR       |                                      |
| `order_date`     | **DATE**           |                                      |
| `ship_date`      | **DATE**           | used in `DATEDIFF`                   |

> If dates were loaded as text, convert them on ingest:
```sql
UPDATE super_store
SET order_date = STR_TO_DATE(order_date, '%Y-%m-%d'),
    ship_date  = STR_TO_DATE(ship_date , '%Y-%m-%d');




