/*
Devuelve true si la casilla está viva, false si está muerta
*/

CREATE OR REPLACE FUNCTION GOL_IS_ALIVE (v_fila NUMBER, v_col NUMBER)
RETURN BOOLEAN IS
    v_casilla VARCHAR2(1);
BEGIN
    SELECT CASE v_col
        WHEN 1 THEN C1
        WHEN 2 THEN C2
        WHEN 3 THEN C3
        WHEN 4 THEN C4
        WHEN 5 THEN C5
        WHEN 6 THEN C6
        WHEN 7 THEN C7
        WHEN 8 THEN C8
        WHEN 9 THEN C9
        WHEN 10 THEN C10
        WHEN 11 THEN C11
        WHEN 12 THEN C12
        WHEN 13 THEN C13
        WHEN 14 THEN C14
        WHEN 15 THEN C15
        WHEN 16 THEN C16
        WHEN 17 THEN C17
        WHEN 18 THEN C18
        WHEN 19 THEN C19
        WHEN 20 THEN C20
        ELSE ' ' END
    INTO v_casilla
    FROM GAMEOFLIFE
    WHERE FILA = v_fila;
    
    IF v_casilla = '#' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

CREATE OR REPLACE PROCEDURE GOL_PRINT_IS_ALIVE (v_fila NUMBER, v_col NUMBER) IS
BEGIN
    IF GOL_IS_ALIVE(v_fila, v_col) THEN
        dbms_output.put_line('Casilla viva');
    ELSE
        dbms_output.put_line('Casilla muerta');
    END IF;
END;

CALL GOL_PRINT_IS_ALIVE(2, 1);