SELECT 
    COUNT(*) AS cuentas_totales,
    COUNT(*) FILTER (WHERE NOT is_active) AS cuentas_desactivadas,
    ROUND(
        (COUNT(*) FILTER (WHERE NOT is_active)::NUMERIC / COUNT(*)::NUMERIC) * 100, 
        2
    ) as porcentaje_desactivadas
FROM core.accounts;

SELECT 
    transaction_id,
    tx_timestamp,
    TIMESTAMP '2026-10-01 00:00+00' AS fecha_revision,
    AGE(TIMESTAMP '2026-10-01 00:00+00', tx_timestamp) AS antiguedad_evento
FROM core.transactions
WHERE tx_timestamp >= TIMESTAMP '2026-10-01 00:00+00' - INTERVAL '15 days'
  AND tx_timestamp <= TIMESTAMP '2026-10-01 00:00+00'
ORDER BY tx_timestamp ASC, transaction_id ASC;

--El cálculo de la antigüedad utiliza un corte explícito y estático (2026-10-01 00:00+00) en lugar de funciones dinámicas como CURRENT_TIMESTAMP o NOW().
--Del mismo modo, los datos de las transacciones (tx_timestamp) y los estados de las cuentas (is_active) son marcas de tiempo históricas almacenadas de forma fija 
--en la base de datos