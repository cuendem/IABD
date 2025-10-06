/*
Devuelve la cantidad de casillas vivas que hay al lado de una casilla
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION GOL_COUNT_NEIGHBORS (v_fila NUMBER, v_col NUMBER)
RETURN NUMBER IS
    v_startFil NUMBER := GREATEST(v_fila - 1, 1);
    v_startCol NUMBER := GREATEST(v_col - 1, 1);
    
    v_endFil NUMBER := LEAST(v_fila + 1, 20);
    v_endCol NUMBER := LEAST(v_col + 1, 20);
    
    v_curFil NUMBER := v_startFil;
    v_curCol NUMBER := v_startCol;
    
    v_neighborCount NUMBER := 0;
BEGIN
    LOOP
        LOOP
            IF GOL_IS_ALIVE(v_curFil, v_curCol) AND (v_curFil != v_fila OR v_curCol != v_col) THEN
                v_neighborCount := v_neighborCount + 1;
            END IF;
            EXIT WHEN v_curCol = v_endCol;
            v_curCol := v_curCol + 1;
        END LOOP;
        EXIT WHEN v_curFil = v_endFil;
        v_curFil := v_curFil + 1;
        v_curCol := v_startCol;
    END LOOP;
    
    RETURN v_neighborCount;
END;

CREATE OR REPLACE PROCEDURE GOL_PRINT_COUNT_NEIGHBORS (v_fila NUMBER, v_col NUMBER) IS
BEGIN
    dbms_output.put_line(GOL_COUNT_NEIGHBORS(v_fila, v_col));
END;

CALL GOL_PRINT_COUNT_NEIGHBORS(16, 18);