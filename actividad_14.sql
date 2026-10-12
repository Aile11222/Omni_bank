SELECT 
    t1.transaction_id AS tx_id_1,
    t2.transaction_id AS tx_id_2,
    t1.account_id,
    t1.tx_timestamp AS timestamp_1,
    t2.tx_timestamp AS timestamp_2
FROM core.transactions t1
JOIN core.transactions t2 
    ON t1.account_id = t2.account_id
    AND t1.transaction_id < t2.transaction_id;

WITH tipos_cuenta AS (
    SELECT unnest(enum_range(NULL::core.tipo_cuenta)) AS account_type
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    t.account_type
FROM core.customers c
CROSS JOIN tipos_cuenta t;

WITH tipos_cuenta AS (
    SELECT unnest(enum_range(NULL::core.tipo_cuenta)) AS account_type
),
matriz_posible AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        t.account_type
    FROM core.customers c
    CROSS JOIN tipos_cuenta t
)
SELECT 
    m.customer_id,
    m.first_name,
    m.last_name,
    m.account_type
FROM matriz_posible m
WHERE NOT EXISTS (
    SELECT 1 
    FROM core.accounts a 
    WHERE a.customer_id = m.customer_id 
      AND a.account_type = m.account_type
);

SELECT 
    c.first_name, 
    c.last_name, 
    a.account_number, 
    a.account_type 
FROM core.customers c
JOIN core.accounts a USING (customer_id)
WHERE c.customer_id = '11111111-1111-1111-1111-111111111111';

-- Comprobación directa de un caso ausente (Ej. Tipo CREDIT para John Doe)
SELECT 
    'John Doe' AS cliente, 
    'CREDIT' AS tipo_cuenta_ausente
WHERE NOT EXISTS (
    SELECT 1 
    FROM core.accounts a
    WHERE a.customer_id = '11111111-1111-1111-1111-111111111111'
      AND a.account_type = 'CREDIT'::core.tipo_cuenta
);
