--El incidente inaceptable en producción fue desencadenado directamente por un desconocimiento operativo y del motor en transiciones en caliente del DBA senior
--Cuando se ejecuta un mandato directo ADD CONSTRAINT ... CHECK (...) sobre una entidad que alberga ya transaccionadas en disco duro en vivacidad continua 75 millones de filas
--Para hacer eso en un motor ácido consistente, adquirió irrebatiblemente un bloqueo de nivel absoluto del sistema: un AccessExclusiveLock.

-- ejemplo en codigo sql
ALTER TABLE core.transactions 
    ADD CONSTRAINT chk_transactions_description_valid 
    CHECK (LENGTH(TRIM(description)) >= 5) NOT VALID;

ALTER TABLE core.transactions 
    VALIDATE CONSTRAINT chk_transactions_description_valid;
