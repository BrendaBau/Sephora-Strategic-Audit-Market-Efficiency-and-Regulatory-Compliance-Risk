
-- Divide the prices in 3 categories (budget, mid-range and luxury)
SELECT
    CASE 
        WHEN CAST(price AS DECIMAL(10,2)) < 25 THEN 'Budget (<$25)'
        WHEN CAST(price AS DECIMAL(10,2)) BETWEEN 25 AND 60 THEN 'Mid-Range ($25-$60)'
        WHEN CAST(price AS DECIMAL(10,2)) > 60 THEN 'Luxury (>$60)'
    END AS price_tier,

    COUNT(*) AS total_products,
    ROUND(AVG(CAST(price AS DECIMAL(10,2))), 2) AS avg_price,
    ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_customer_rating

FROM dbo.sephora
-- GROUP BY debe tener la misma lógica del CASE
GROUP BY 
    CASE 
        WHEN CAST(price AS DECIMAL(10,2)) < 25 THEN 'Budget (<$25)'
        WHEN CAST(price AS DECIMAL(10,2)) BETWEEN 25 AND 60 THEN 'Mid-Range ($25-$60)'
        WHEN CAST(price AS DECIMAL(10,2)) > 60 THEN 'Luxury (>$60)'
    END
ORDER BY avg_price DESC;

-- compare ingredients

SELECT 
    'Hyaluronic Acid' AS active_ingredient,
    COUNT(*) AS product_count,
    ROUND(AVG(CAST(price AS DECIMAL(10,2))), 2) AS avg_price,
    ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM dbo.sephora
WHERE LOWER(ingredients) LIKE '%hyaluronic acid%' -- Search in lower case 

UNION ALL

SELECT 
    'Retinol' AS active_ingredient,
    COUNT(*) AS product_count,
    ROUND(AVG(CAST(price AS DECIMAL(10,2))), 2) AS avg_price,
    ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM dbo.sephora
WHERE LOWER(ingredients) LIKE '%retinol%'

UNION ALL

SELECT 
    'Vitamin C' AS active_ingredient,
    COUNT(*) AS product_count,
    ROUND(AVG(CAST(price AS DECIMAL(10,2))), 2) AS avg_price,
    ROUND(AVG(CAST(rating AS FLOAT)), 2) AS avg_rating
FROM dbo.sephora
WHERE LOWER(ingredients) LIKE '%vitamin c%' OR LOWER(ingredients) LIKE '%ascorbic acid%'; 


-- Compliance: restricted and banned ingredients
-- Correlation between compliance and retinol 
SELECT 
    -- Identify the high value product
    P.brand,
    P.name,
    P.price,
    'Retinol' AS active_ingredient, -- focus on retinol because it's expensive ($70)
    
    -- identify the compliance failure 
    B.inci_name AS banned_ingredient_found,
    B.category AS violation_category,
    B.restriction_level AS restriction_level
    
FROM dbo.sephora P
-- Join to find the banned stuff
INNER JOIN dbo.sephora_banned B
    ON LOWER(P.ingredients) LIKE '%' + LOWER(B.inci_name) + '%'
    
-- Filter, Only look for products that ALSO contain Retinol
WHERE LOWER(P.ingredients) LIKE '%retinol%'
ORDER BY P.price DESC;