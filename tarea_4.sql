-- Declaración del Dominio para blindaje monetario universal
CREATE DOMAIN monto_financiero AS NUMERIC(15, 2)
    CHECK (VALUE >= 0.00);

-- Declaración del Dominio para textos que repelen espacios en blanco o cadenas vacías ilegales
CREATE DOMAIN texto_obligatorio AS VARCHAR(100)
    CHECK (VALUE <> '' AND LENGTH(TRIM(VALUE)) > 0);

-- asi con el dominio de monto financiero se puede mejorar la arquitectura en la tabla cuentas y transacciones