CREATE OR REPLACE VIEW core.vw_finanzas_resumen_moneda AS

-- 1. CTE: Agregación inicial de transacciones por cuenta (volumen bruto)
WITH tx_resumen AS (
    SELECT 
        account_id,
        COUNT(*) AS recuento_tx,
        SUM(amount) AS volumen_bruto
    FROM core.transactions
    GROUP BY account_id
),

-- 2. CTE intermedia: Cuentas activas conservando volumen cero para las sin eventos
cuentas_activas_con_volumen AS (
    SELECT 
        a.account_id,
        a.customer_id,
        a.account_number,
        a.currency,
        COALESCE(t.recuento_tx, 0) AS recuento_tx,
        COALESCE(t.volumen_bruto, 0) AS volumen_bruto
    FROM core.accounts a
    LEFT JOIN tx_resumen t ON a.account_id = t.account_id
    WHERE a.is_active = true
)

-- 3. Etapa de agregación por currency (cambio de grano a nivel moneda)
SELECT 
    currency AS moneda,
    COUNT(account_id) AS numero_cuentas_activas,
    SUM(volumen_bruto) AS volumen_bruto_total,
    ROUND(AVG(volumen_bruto), 2) AS promedio_volumen_por_cuenta
FROM cuentas_activas_con_volumen
GROUP BY currency
ORDER BY currency;


-- =========================================================================
-- 4. VERIFICACIONES INDEPENDIENTES SOLICITADAS
-- =========================================================================

-- A. ¿Cuántas cuentas activas hay en total?
SELECT COUNT(*) AS total_cuentas_activas 
FROM core.accounts 
WHERE is_active = true;

-- B. ¿Cuánto suman los cuatro movimientos iniciales registrados?
SELECT SUM(amount) AS suma_total_cuatro_movimientos 
FROM core.transactions;

-- C. ¿Qué aporta la cuenta ACCT-3002 al denominador en su moneda?
-- (Permite ver su saldo, estado y moneda para entender su peso en el promedio de su respectiva divisa)
SELECT 
    account_number,
    currency,
    account_type,
    balance,
    is_active
FROM core.accounts
WHERE account_number = 'ACCT-3002';