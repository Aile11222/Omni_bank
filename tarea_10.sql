WITH muestra(val) AS (
    VALUES 
        (10000::numeric), 
        (0), 
        (0), 
        (NULL)
)
SELECT 
    AVG(val) AS promedio_estandar,
    COUNT(val) AS denominador_estandar, -- Omite el NULL (cuenta 3 elementos)
    AVG(COALESCE(val, 0)) AS promedio_con_coalesce,
    COUNT(COALESCE(val, 0)) AS denominador_con_coalesce -- Incluye el NULL transformado a 0 (cuenta 4 elementos)
FROM muestra;

SELECT 
    a.account_number,
    a.balance AS saldo_almacenado,
    COUNT(t.transaction_id) AS numero_movimientos,
    COALESCE(SUM(t.amount), 0) AS volumen_bruto_registrado
FROM core.accounts a
LEFT JOIN core.transactions t ON a.account_id = t.account_id
WHERE a.account_type = 'CREDIT' 
  AND a.is_active = true
GROUP BY a.account_id, a.account_number, a.balance
HAVING COUNT(t.transaction_id) = 0 OR COALESCE(SUM(t.amount), 0) >= 300;