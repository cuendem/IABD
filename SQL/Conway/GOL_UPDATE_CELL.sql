/*
Lógica para determinar si una casilla nace o muere o sigue viviendo
*/

CREATE OR REPLACE PROCEDURE GOL_UPDATE_CELL (v_fila NUMBER, v_col NUMBER, v_survive VARCHAR, v_born VARCHAR) IS
    v_neighbors NUMBER := GOL_COUNT_NEIGHBORS(v_fila, v_col);
    v_alive BOOLEAN := GOL_IS_ALIVE(v_fila, v_col);
    
    v_swap BOOLEAN;
    
    i NUMBER := 1;
    digit NUMBER;
BEGIN
    IF (v_alive) THEN
        v_swap := true; -- Muere por defecto
        
        LOOP
            digit := CAST(SUBSTR(v_survive, i, 1) AS NUMBER);
            
            IF (v_alive AND v_neighbors = digit) THEN
                v_swap := false; -- Ya no muere porque tiene los vecinos necesarios
            END IF;
            
            EXIT WHEN i = LENGTH(v_survive);
            i := i + 1;
        END LOOP;
        
        IF (v_swap) THEN
            GOL_SWAP_CELL(v_fila, v_col);
        END IF;
    ELSE
        v_swap := false; -- No nace por defecto
        
        LOOP
            digit := CAST(SUBSTR(v_born, i, 1) AS NUMBER);
            
            IF (NOT v_alive AND v_neighbors = digit) THEN
                v_swap := true; -- Nace porque tiene los vecinos necesarios
            END IF;
            
            EXIT WHEN i = LENGTH(v_born);
            i := i + 1;
        END LOOP;
        
        IF (v_swap) THEN
            GOL_SWAP_CELL(v_fila, v_col);
        END IF;
    END IF;
END;

CALL GOL_UPDATE_CELL(14, 1, '23', '3');