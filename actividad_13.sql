CREATE OR REPLACE VIEW core.vw_reporte_actividad_cuentas AS

-- 1. CTE: Agregación de eventos e importes positivos (volumen bruto) por cuenta
WITH tx_resumen AS (
    SELECT 
        account_id,
        COUNT(*) AS recuento,
        SUM(amount) AS volumen_bruto
    FROM core.transactions[cite: 1]
    GROUP BY account_id
),

-- 2. CTE: Cuentas activas con LEFT JOIN, sustituyendo ausentes por cero y preservando el grano (account_id)
cuentas_activas AS (
    SELECT 
        a.account_id,
        a.customer_id,
        a.account_number,
        a.currency,
        COALESCE(t.recuento, 0) AS recuento,
        COALESCE(t.volumen_bruto, 0) AS volumen_bruto
    FROM core.accounts a[cite: 1]
    LEFT JOIN tx_resumen t ON a.account_id = t.account_id
    WHERE a.is_active = true[cite: 1]
)

-- 3. Enriquecimiento con customers, cálculo de banda de actividad y ordenamiento por account_number
SELECT 
    ca.account_number,
    cu.first_name || ' ' || cu.last_name AS titular,
    ca.currency,
    ca.recuento,
    ca.volumen_bruto AS volumen,
    CASE 
        WHEN ca.volumen_bruto = 0 THEN 'Sin Actividad'
        WHEN ca.volumen_bruto < 200 THEN 'Baja'
        WHEN ca.volumen_bruto < 500 THEN 'Media'
        ELSE 'Alta'
    END AS banda_de_actividad
FROM cuentas_activas ca
JOIN core.customers cu ON ca.customer_id = cu.customer_id[cite: 1]
ORDER BY ca.account_number;


-- =========================================================================
-- 4. CONSULTAS DE CONTRASTE DIRECTO
-- =========================================================================

-- Contraste del recuento total de cuentas activas
SELECT COUNT(*) AS total_cuentas_activas 
FROM core.accounts 
WHERE is_active = true;[cite: 1]

-- Contraste del volumen total de transacciones registradas
SELECT SUM(amount) AS volumen_total_transacciones 
FROM core.transactions;[cite: 1]