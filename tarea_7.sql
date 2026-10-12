Colapso de Latencia por Doble Viaje Continuo (Round-Trip Amplified latency): Enviar 1 millón de consultas previas por la red exclusivamente para averiguar ("leer") 
si el usuario radicaba antes en disco, solo para después procesar y disparar un millón de escrituras condicionales por separado, infligirá al sistema 2 millones de idas 
y vueltas al motor computacional por sobrecarga en sockets e hilos del sistema.
La Trinchera de Vulnerabilidad: Condiciones de Carrera (Race Conditions): Una consulta de lectura (SELECT) anterior y desconectada del paso de escritura no bloquea la fila
transaccional del disco (salvo que impliques bloqueos intensivos como SELECT FOR UPDATE).

INSERT INTO core.customers (first_name, last_name, email, phone_number, tax_id)
VALUES 
    ('Humberto', 'López', 'hlopez@email.com', '+52-55-4433-2211', 'TAX-990011')
ON CONFLICT (email) 
DO UPDATE SET 
    first_name   = EXCLUDED.first_name,
    last_name    = EXCLUDED.last_name,
    phone_number = EXCLUDED.phone_number,
    -- (Es vital dejar intacta y no tocar deliberadamente nuestra fecha de alta created_at ni su UUID)
    is_active    = true
RETURNING customer_id, email, is_active;
