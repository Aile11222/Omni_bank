SELECT 
    a.account_number, 
    a.is_active
FROM core.accounts a
WHERE a.is_active = true
  AND NOT EXISTS (
    SELECT 1 
    FROM core.transactions t 
    WHERE t.account_id = a.account_id
);

SELECT 
    a.account_number, 
    a.is_active
FROM core.accounts a
WHERE NOT EXISTS (
    SELECT 1 
    FROM core.transactions t 
    WHERE t.account_id = a.account_id 
      AND t.tx_type = 'DEPOSIT'
);

--Una cuenta que ha realizado transferencias sí posee registros asociados en core.transactions, 
--por lo que queda excluida del primer conjunto (el cual exige ausencia total de filas). No obstante, como ninguno de esos movimientos corresponde a un DEPOSIT, 
--cumple estrictamente la condición del segundo conjunto, apareciendo en él.