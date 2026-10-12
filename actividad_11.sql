SELECT 
    c.customer_id,
    c.email,
    UPPER(c.first_name || ' ' || c.last_name) || ' [' || RIGHT(a.account_number, 4) . ']' AS etiqueta_cuenta,
    a.account_number,
    a.account_type,
    a.balance,
    a.is_active,
    CASE 
        WHEN a.is_active = false THEN 'DESACTIVADA'
        WHEN NOT EXISTS (SELECT 1 FROM core.transactions t WHERE t.account_id = a.account_id) THEN 'ACTIVA - SIN MOVIMIENTOS'
        ELSE 'ACTIVA - CON MOVIMIENTOS'
    END AS estado_operativo
FROM core.accounts a
JOIN core.customers c ON a.customer_id = c.customer_id
ORDER BY c.customer_id, a.account_number;

SELECT 
    t.transaction_id,
    EXTRACT(YEAR FROM t.tx_timestamp) AS anio_evento,
    EXTRACT(MONTH FROM t.tx_timestamp) AS mes_evento,
    t.tx_timestamp AS marca_original,
    t.tx_timestamp + INTERVAL '15 days' AS fecha_revision,
    TO_CHAR(t.amount, 'FM999,999,990.00') AS importe_presentacion,
    t.tx_type,
    a.account_number
FROM core.transactions t
JOIN core.accounts a ON t.account_id = a.account_id
WHERE t.tx_timestamp < TIMESTAMP WITH TIME ZONE '2026-09-10 00:00+00'
ORDER BY t.tx_timestamp ASC, t.transaction_id ASC;

