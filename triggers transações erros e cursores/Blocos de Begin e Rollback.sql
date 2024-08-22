CREATE FUNCTION cria_instrutor() RETURNS void AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> NEW.id;

        BEGIN;
        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores (informacao) VALUES (NEW.nome || ' recebe acima da média');
        END IF;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> NEW.id LOOP
            total_instrutores := total_instrutores + 1;

            IF NEW.salario > salario THEN
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            END IF;    
        END LOOP;

        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;

        INSERT INTO log_instrutores (informacao) 
            VALUES (NEW.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores');
        COMMIT;

        RETURN NEW;    
    END;
$$ LANGUAGE plpgsql;



CREATE FUNCTION cria_instrutor() RETURNS void AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> NEW.id;

        START TRANSACTION;
        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores (informacao) VALUES (NEW.nome || ' recebe acima da média');
        END IF;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> NEW.id LOOP
            total_instrutores := total_instrutores + 1;

            IF NEW.salario > salario THEN
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            END IF;    
        END LOOP;

        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;

        INSERT INTO log_instrutores (informacao) 
            VALUES (NEW.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores');
        COMMIT;

        RETURN NEW;    
    END;
$$ LANGUAGE plpgsql;


INSERT INTO instrutor (nome, salario) VALUES ('Maria', 700);




CREATE FUNCTION cria_instrutor() RETURNS void AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> NEW.id;

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores (informacao) VALUES (NEW.nome || ' recebe acima da média');
        END IF;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> NEW.id LOOP
            total_instrutores := total_instrutores + 1;

            IF NEW.salario > salario THEN
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            END IF;    
        END LOOP;

        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;

        INSERT INTO log_instrutores (informacao) 
            VALUES (NEW.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores');

        RETURN NEW;    
    END;
$$ LANGUAGE plpgsql;

BEGIN;
INSERT INTO instrutor (nome, salario) VALUES ('Maria', 700);
ROLLBACK;


CREATE FUNCTION cria_instrutor() RETURNS void AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> NEW.id;

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores (informacao) VALUES (NEW.nome || ' recebe acima da média');
        END IF;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> NEW.id LOOP
            total_instrutores := total_instrutores + 1;

            IF NEW.salario > salario THEN
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            END IF;    
        END LOOP;

        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;

        INSERT INTO log_instrutores (informacao, teste) 
            VALUES (NEW.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores','');

        RETURN NEW;    
    END;
$$ LANGUAGE plpgsql;


INSERT INTO instrutor (nome, salario) VALUES ('João', 650);

SELECT * FROM instrutor;
