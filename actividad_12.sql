SELECT 
    t.transaction_id,
    t.account_id,
    t.tx_type,
    t.amount,
    (SELECT AVG(t2.amount) 
     FROM core.transactions t2 
     WHERE t2.account_id = t.account_id) AS avg_account_amount
FROM core.transactions t;

SELECT 
    t.transaction_id,
    t.account_id,
    t.tx_type,
    t.amount,
    (SELECT AVG(t2.amount) 
     FROM core.transactions t2 
     WHERE t2.account_id = t.account_id) AS avg_account_amount
FROM core.transactions t
WHERE t.amount > (
    SELECT AVG(t2.amount) 
    FROM core.transactions t2 
    WHERE t2.account_id = t.account_id
);

SELECT 
    a.account_number, 
    a.is_active
FROM core.accounts a
WHERE NOT EXISTS (
    SELECT 1 
    FROM core.transactions t 
    WHERE t.account_id = a.account_id
);

--Al no existir registros asociados en la tabla core.transactions (como ocurre con las cuentas ACCT-3002 o ACCT-1002), 
--la función de agregación AVG() no procesa ningún valor numérico
--El filtro con NOT EXISTS opera directamente sobre la existencia de tuplas en la tabla core.accounts, 
--evaluando la carencia de actividad sin depender de que exista un promedio calculado.