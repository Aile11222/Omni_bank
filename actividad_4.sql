-- Monedas admitidas
CREATE TYPE core.tipo_moneda AS ENUM ('USD', 'EUR', 'MXN', 'GBP');

-- Tipos de cuentas de clientes
CREATE TYPE core.tipo_cuenta AS ENUM ('CHECKING', 'SAVINGS', 'CREDIT');

-- Categorizaciones transaccionales permitidas
CREATE TYPE core.tipo_transaccion AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER');

-- tabla cuentas modificaciones:
-- saldo_actual: NUMERIC(15, 2)
-- updated_at: TIMESTAMPTZ

-- y para las llaves primarias y las foraneas usar el tipo de UUID