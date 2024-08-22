CREATE FUNCTION instrutores_internos(id_instrutor INTEGER) RETURNS ?? AS $$
    DECLARE
        cursor_salario refcursor;
    BEGIN
        OPEN cursor_salario FOR SELECT instrutor.salario 
                                    FROM instrutor 
                                 WHERE id <> id_instrutor 
                                    AND salario > 0;
        
    END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION instrutores_internos(id_instrutor INTEGER) RETURNS refcursor AS $$
    DECLARE
        cursor_salario refcursor;
    BEGIN
        OPEN cursor_salario FOR SELECT instrutor.salario 
                                    FROM instrutor 
                                 WHERE id <> id_instrutor 
                                    AND salario > 0;                         
        RETURN cursor_salario;
    END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION cria_instrutor() RETURNS void AS $$ 
    DECLARE
        media_salarial DECIMAL;
        instrutor_recebe_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;
        percentual DECIMAL(5,2);
        cursor_salarios refcursor;
    BEGIN
        SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> NEW.id;

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores (informacao) VALUES (NEW.nome || ' recebe acima da média');
        END IF;

        SELECT instrutores_internos(NEW.id) INTO cursor_salarios; 
        LOOP
            FETCH cursor_salarios INTO salario;
            EXIT WHEN NOT FOUND;
            total_instrutores := total_instrutores + 1;

            IF NEW.salario > salario THEN
                instrutor_recebe_menos := instrutor_recebe_menos + 1;
            END IF;    
        END LOOP;

        percentual = instrutor_recebe_menos::DECIMAL / total_instrutores::DECIMAL * 100;
        ASSERT percentual < 100::DECIMAL, 'instrutores novos não podem receber mais do que todos os antigos';

        INSERT INTO log_instrutores (informacao, teste) 
            VALUES (NEW.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores','');

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;


INSERT INTO instrutor (nome, salario) VALUES ('João', 6000);