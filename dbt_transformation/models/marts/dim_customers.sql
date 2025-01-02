WITH 
customers as (
    SELECT * FROM {{ref("stg_customers")}}
),
orders as (
    SELECT * FROM {{ref("stg_orders")}}
),
customer_orders as(
    SELECT 
        c.customer_id,
        c.email,
        c.country,
        c.city,
        min(o.order_approved_at) AS first_order_date,
        max(o.order_approved_at) AS most_recent_order_date,
        count(o.order_id) AS number_of_orders
    FROM orders o
    INNER JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_id,c.email, c.country, c.city
)

SELECT * FROM customer_orders