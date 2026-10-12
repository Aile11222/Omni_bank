--1- nunca se debe relajar la seguridad o integridad de un modelo productivo para complacer la pereza de las pruebas unitarias automáticas
--(donde muy bien pueden limpiar el entorno en orden inverso o usar sentencias TRUNCATE ... CASCADE aisladas al ambiente temporal efímero).
--Habilitar una restricción ON DELETE CASCADE sobre core.customers o core.accounts convertiría cualquier descuido de un operador administrativo del sistema
--o intento malintencionado en producción en un arma destructiva masiva que fulmina inexorablemente sin previa confirmación de seguridad

--2- un registro histórico de transacción y movimiento patrimonial es un documento legal civil inviolable, inalterable y perpetuo por mandato público legal.
-- Borrar ciegamente esas filas del motor (DELETE FROM core.transactions)ante la baja de una persona rompe el balance de comprobación general del libro contable mayor de OmniBank
-- derivando en sanciones multimillonarias, auditorías desaprobadas e intervenciones de organismos reguladores

--3- Jamás se emitirá una orden DELETE en caliente sobre tablas maestras transaccionales ni personales en nóminas comerciales
--Se implementa el proceso técnico de Baja Lógica: la inactivación oficial del usuario o el congelamiento final del cobro se ejecuta alterando y actualizando pacíficamente
--las banderas booleanas no funcionales proyectadas especialmente en nuestro esquema DDL en los pasados talleres

-- Instrucción estándar legítima ante un cierre bancario de un cliente comercial:
UPDATE core.customers SET is_active = false WHERE customer_id = 'c13c7f99-...';

-- Las cuentas asociadas cesan actividad cambiándose equivalentemente en la base:
UPDATE core.accounts SET is_active = false, updated_at = CURRENT_TIMESTAMP WHERE customer_id = 'c13c7f99-...';