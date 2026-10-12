-- 1. CONTEO CARTESIANO (MATRIZ SIN RELACIONES)
SELECT 
    (SELECT COUNT(*) FROM core.customers) AS total_customers,
    (SELECT COUNT(*) FROM core.accounts) AS total_accounts,
    (SELECT COUNT(*) FROM core.transactions) AS total_transactions,
    (SELECT COUNT(*) FROM core.customers CROSS JOIN core.accounts CROSS JOIN core.transactions) AS producto_cartesiano;

-- 2. REPORTE DE MOVIMIENTOS REPARADO Y FILTRADO
SELECT 
    c.email,
    a.account_number,
    t.tx_type,
    t.amount,
    t.tx_timestamp
FROM core.transactions t
INNER JOIN core.accounts a ON t.account_id = a.account_id
INNER JOIN core.customers c ON a.customer_id = c.customer_id
WHERE c.is_active = TRUE 
  AND t.amount >= 100
ORDER BY t.tx_timestamp ASC, t.transaction_id ASC;

-- faltaban varias cosas como Condiciones de Clave Faltantes Originalmente, el JOIN y el WHERE para una correcta separacion de todo