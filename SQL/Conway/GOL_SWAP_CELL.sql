/*
Si la casilla especificada está viva, se muere. Si está muerta, pasa a viva (los cambios los guarda en GAMEOFLIFETEMP)
*/

CREATE OR REPLACE PROCEDURE GOL_SWAP_CELL (v_fila NUMBER, v_col NUMBER) IS
    v_nuevaCasilla VARCHAR2(1);
BEGIN
    IF GOL_IS_ALIVE(v_fila, v_col) THEN
        v_nuevaCasilla := ' ';
    ELSE
        v_nuevaCasilla := '#';
    END IF;
    
    CASE v_col
        WHEN 1 THEN
            UPDATE GAMEOFLIFETEMP
            SET C1 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 2 THEN
            UPDATE GAMEOFLIFETEMP
            SET C2 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 3 THEN
            UPDATE GAMEOFLIFETEMP
            SET C3 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 4 THEN
            UPDATE GAMEOFLIFETEMP
            SET C4 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 5 THEN
            UPDATE GAMEOFLIFETEMP
            SET C5 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 6 THEN
            UPDATE GAMEOFLIFETEMP
            SET C6 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 7 THEN
            UPDATE GAMEOFLIFETEMP
            SET C7 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 8 THEN
            UPDATE GAMEOFLIFETEMP
            SET C8 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 9 THEN
            UPDATE GAMEOFLIFETEMP
            SET C9 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 10 THEN
            UPDATE GAMEOFLIFETEMP
            SET C10 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 11 THEN
            UPDATE GAMEOFLIFETEMP
            SET C11 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 12 THEN
            UPDATE GAMEOFLIFETEMP
            SET C12 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 13 THEN
            UPDATE GAMEOFLIFETEMP
            SET C13 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 14 THEN
            UPDATE GAMEOFLIFETEMP
            SET C14 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 15 THEN
            UPDATE GAMEOFLIFETEMP
            SET C15 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 16 THEN
            UPDATE GAMEOFLIFETEMP
            SET C16 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 17 THEN
            UPDATE GAMEOFLIFETEMP
            SET C17 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 18 THEN
            UPDATE GAMEOFLIFETEMP
            SET C18 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 19 THEN
            UPDATE GAMEOFLIFETEMP
            SET C19 = v_nuevaCasilla
            WHERE FILA = v_fila;
        WHEN 20 THEN
            UPDATE GAMEOFLIFETEMP
            SET C20 = v_nuevaCasilla
            WHERE FILA = v_fila;
    END CASE;
END;

CALL GOL_SWAP_CELL(3, 3);