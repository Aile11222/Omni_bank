SELECT 
    account_type,
    COUNT(account_id) AS cantidad_cuentas,
    SUM(balance) AS suma_balance_almacenado,
    MIN(balance) AS min_balance_almacenado,
    MAX(balance) AS max_balance_almacenado,
    AVG(balance) AS avg_balance_almacenado
FROM core.accounts
WHERE is_active = true
GROUP BY account_type
ORDER BY suma_balance_almacenado DESC, account_type;

SELECT SUM(balance) AS total_balance_activas
FROM core.accounts
WHERE is_active = true;

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(t.transaction_id) AS total_movimientos,
    COALESCE(SUM(t.amount), 0) AS volumen_bruto
FROM core.customers c
LEFT JOIN core.accounts a ON c.customer_id = a.customer_id
LEFT JOIN core.transactions t ON a.account_id = t.account_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(t.transaction_id) >= 2 OR COALESCE(SUM(t.amount), 0) > 100
ORDER BY volumen_bruto DESC, c.email ASC;

SELECT 
    account_id,
    COUNT(transaction_id) AS recuento_movimientos,
    SUM(amount) AS volumen_transaccional
FROM core.transactions
GROUP BY account_id
ORDER BY account_id;