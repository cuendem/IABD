/*
Repasa el tablero y ejecuta una función en cada casilla del mismo
*/

CREATE OR REPLACE PROCEDURE GOL_STEP (v_steps NUMBER DEFAULT 1, v_survive VARCHAR DEFAULT '23', v_born VARCHAR DEFAULT '3') IS
    v_curStep NUMBER := 0;
    v_curFil NUMBER;
    v_curCol NUMBER;
BEGIN
    -- Repetir v_steps veces
    LOOP
        v_curFil := 1;
        v_curCol := 1;
    
        -- Guardar cambios en tabla aparte
        LOOP
            LOOP
                GOL_UPDATE_CELL(v_curFil, v_curCol, v_survive, v_born);
                EXIT WHEN v_curCol = 20;
                v_curCol := v_curCol + 1;
            END LOOP;
            EXIT WHEN v_curFil = 20;
            v_curFil := v_curFil + 1;
            v_curCol := 1;
        END LOOP;
        
        -- Pasar cambios de tabla temporal a definitiva
        GOL_CONFIRM_CHANGES();
        
        v_curStep := v_curStep + 1;
        EXIT WHEN v_curStep >= v_steps;
    END LOOP;
END;

CALL GOL_STEP();