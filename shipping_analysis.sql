-- ==========================================================
-- CLIPBOARD E-COMMERCE SHIPPING ANALYSIS
-- ==========================================================

-- 1. Overall Delivery Delay Rate
SELECT 
    "c12" AS is_delayed,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shipping_data), 2) AS percentage
FROM shipping_data
GROUP BY "c12";


-- 2. Analysis by Shipment Mode
SELECT 
    "c3" AS shipment_mode,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS delay_rate_percentage
FROM shipping_data
WHERE "c3" IN ('Flight', 'Ship', 'Road')
GROUP BY "c3"
ORDER BY delay_rate_percentage DESC;


-- 3. Analysis by Warehouse Block
SELECT 
    "c2" AS warehouse_block,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS delay_rate_percentage
FROM shipping_data
WHERE "c2" IN ('A', 'B', 'C', 'D', 'F')
GROUP BY "c2"
ORDER BY delay_rate_percentage DESC;


-- 4. Analysis by Customer Service Calls
SELECT 
    "c4" AS customer_calls,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS delay_rate_percentage
FROM shipping_data
WHERE "c4" IN ('2', '3', '4', '5', '6', '7')
GROUP BY "c4"
ORDER BY "c4" ASC;


-- 5. Analysis by Product Importance (VIP Priority)
SELECT 
    "c8" AS product_importance,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(SUM(CASE WHEN "c12" = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS delay_rate_percentage
FROM shipping_data
WHERE "c8" IN ('low', 'medium', 'high', 'Low', 'Medium', 'High')
GROUP BY "c8"
ORDER BY delay_rate_percentage DESC;
