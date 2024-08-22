/*
* Inserir instrutores (com salários).
* Se o salário for maior do que a média, salvar um log
* Salvar outro log dizendo que fulano recebe mais do que x% da grade de instrutores. 
*/

CREATE TABLE log_instrutores (
    id SERIA PRIMARY KEY,
    informacao VARCHAR(255),
    momento_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE FUNCTION cria_instrutor(nome_instrutor VARCHAR, salario_instrutor DECIMAL) RETURNS void AS $$ 
    DECLARE
        id_instrutor_inserido INTEGER;
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        INSERT INTO instrutor (nome, salario) VALUES (nome_instrutor, salario_instrutor) RETURNING id INTO id_instrutor_inserido;

        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> id_instrutor_inserido;

        IF salario_instrutor > media_salarial THEN
            INSERT INTO log_instrutores (informacao) VALUES (nome_instrutor || ' recebe acima da média');
        END IF;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> id_instrutor_inserido LOOP
            total_instrutores := total_instrutores + 1;

            IF salario_instrutor > salario THEN
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            END IF;    
        END LOOP;

        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;

        INSERT INTO log_instrutores (informacao) 
            VALUES (nome_instrutor || ' recebe mais do que ' || percentual || '% da grade de instrutores');
    END;
$$ LANGUAGE plpgsql;


SELECT * FROM instrutor;

SELECT cria_instrutor('Fulano de tal', 1000);

SELECT * FROM log_instrutores;

SELECT cria_instrutor('Outro instrutora', 400);

SELECT * FROM log_instrutores;