/*
Copia toda la tabla GAMEOFLIFETEMP a la tabla GAMEOFLIFE
*/

CREATE OR REPLACE PROCEDURE GOL_CONFIRM_CHANGES IS
    v_F GAMEOFLIFETEMP%rowtype;
    
    CURSOR cursorGOF IS
    SELECT *
    FROM GAMEOFLIFETEMP
    ORDER BY FILA;
BEGIN
    OPEN cursorGOF;
    LOOP
        FETCH cursorGOF INTO v_F;
        EXIT WHEN cursorGOF%notfound;
        UPDATE GAMEOFLIFE
        SET C1 = v_F.C1, C2 = v_F.C2, C3 = v_F.C3, C4 = v_F.C4, C5 = v_F.C5, C6 = v_F.C6, C7 = v_F.C7, C8 = v_F.C8, C9 = v_F.C9, C10 = v_F.C10, C11 = v_F.C11, C12 = v_F.C12, C13 = v_F.C13, C14 = v_F.C14, C15 = v_F.C15, C16 = v_F.C16, C17 = v_F.C17, C18 = v_F.C18, C19 = v_F.C19, C20 = v_F.C20
        WHERE FILA = v_F.FILA;
    END LOOP;
    CLOSE cursorGOF;
END;

CALL GOL_CONFIRM_CHANGES();