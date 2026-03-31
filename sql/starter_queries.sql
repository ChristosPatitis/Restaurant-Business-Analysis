-- Restaurant Business Analysis: Starter SQL Queries

-- 1) Monthly revenue
SELECT
  strftime('%Y-%m', order_date) AS month,
  ROUND(SUM(total_revenue_eur), 2) AS revenue
FROM orders
WHERE status = 'Completed'
GROUP BY 1
ORDER BY 1;

-- 2) Best-selling menu items by quantity
SELECT
  item_name,
  SUM(quantity) AS total_qty,
  ROUND(SUM(line_revenue_eur), 2) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY item_name
ORDER BY total_qty DESC
LIMIT 10;

-- 3) Profit by category
SELECT
  category,
  ROUND(SUM(line_profit_eur), 2) AS profit
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY category
ORDER BY profit DESC;

-- 4) Peak order hours
SELECT
  CAST(strftime('%H', order_datetime) AS INTEGER) AS hour_of_day,
  COUNT(*) AS num_orders
FROM orders
WHERE status = 'Completed'
GROUP BY 1
ORDER BY num_orders DESC;

-- 5) Average order value by channel
SELECT
  channel,
  ROUND(AVG(total_revenue_eur), 2) AS avg_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY channel
ORDER BY avg_order_value DESC;