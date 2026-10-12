-- 1. Lista operativa de cuentas activas sin DEPOSIT (con número, tipo y titular)
SELECT 
    a.account_number,
    a.account_type,
    c.first_name || ' ' || c.last_name AS titular
FROM core.accounts a
JOIN core.customers c ON a.customer_id = c.customer_id
WHERE a.is_active = true
  AND NOT EXISTS (
      SELECT 1 
      FROM core.transactions t 
      WHERE t.account_id = a.account_id 
        AND t.tx_type = 'DEPOSIT'
  );

-- 2. Control de cardinalidad / Comprobación del recuento
SELECT COUNT(*) AS total_cuentas_sin_deposito
FROM core.accounts a
WHERE a.is_active = true
  AND NOT EXISTS (
      SELECT 1 
      FROM core.transactions t 
      WHERE t.account_id = a.account_id 
        AND t.tx_type = 'DEPOSIT'
  );

