/*
Inicia el tablero con varias formas para probar el funcionamiento
*/

drop table gameoflife;

CREATE TABLE GAMEOFLIFE (
    FILA	NUMBER(2,0),
    C1		VARCHAR2(1),
    C2		VARCHAR2(1),
    C3		VARCHAR2(1),
    C4		VARCHAR2(1),
    C5  	VARCHAR2(1),
    C6		VARCHAR2(1),
    C7		VARCHAR2(1),
    C8		VARCHAR2(1),
    C9		VARCHAR2(1),
    C10		VARCHAR2(1),
    C11		VARCHAR2(1),
    C12		VARCHAR2(1),
    C13		VARCHAR2(1),
    C14		VARCHAR2(1),
    C15  	VARCHAR2(1),
    C16		VARCHAR2(1),
    C17		VARCHAR2(1),
    C18		VARCHAR2(1),
    C19		VARCHAR2(1),
    C20		VARCHAR2(1)
);

CREATE TABLE GAMEOFLIFETEMP (
    FILA	NUMBER(2,0),
    C1		VARCHAR2(1),
    C2		VARCHAR2(1),
    C3		VARCHAR2(1),
    C4		VARCHAR2(1),
    C5  	VARCHAR2(1),
    C6		VARCHAR2(1),
    C7		VARCHAR2(1),
    C8		VARCHAR2(1),
    C9		VARCHAR2(1),
    C10		VARCHAR2(1),
    C11		VARCHAR2(1),
    C12		VARCHAR2(1),
    C13		VARCHAR2(1),
    C14		VARCHAR2(1),
    C15  	VARCHAR2(1),
    C16		VARCHAR2(1),
    C17		VARCHAR2(1),
    C18		VARCHAR2(1),
    C19		VARCHAR2(1),
    C20		VARCHAR2(1)
);

CREATE OR REPLACE PROCEDURE GOL_START IS
    cont NUMBER(2,0) := 1;
    cas VARCHAR2(6);
BEGIN
    delete from GAMEOFLIFE;
    delete from GAMEOFLIFETEMP;

    LOOP
        INSERT INTO GAMEOFLIFE
        VALUES (cont, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
        INSERT INTO GAMEOFLIFETEMP
        VALUES (cont, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
        EXIT WHEN cont = 20;
        cont := cont + 1;
    END LOOP;
    
    -- GLIDERS
    GOL_SWAP_CELL(13, 2);
    GOL_SWAP_CELL(14, 3);
    GOL_SWAP_CELL(15, 1);
    GOL_SWAP_CELL(15, 2);
    GOL_SWAP_CELL(15, 3);
    
    -- BLOCK
    GOL_SWAP_CELL(2, 2);
    GOL_SWAP_CELL(2, 3);
    GOL_SWAP_CELL(3, 2);
    GOL_SWAP_CELL(3, 3);
    
    -- SPINNER
    GOL_SWAP_CELL(15, 18);
    GOL_SWAP_CELL(16, 18);
    GOL_SWAP_CELL(17, 18);
    
    -- LWSS
    GOL_SWAP_CELL(6, 11);
    GOL_SWAP_CELL(6, 14);
    GOL_SWAP_CELL(7, 10);
    GOL_SWAP_CELL(8, 10);
    GOL_SWAP_CELL(8, 14);
    GOL_SWAP_CELL(9, 10);
    GOL_SWAP_CELL(9, 11);
    GOL_SWAP_CELL(9, 12);
    GOL_SWAP_CELL(9, 13);
    
    /*
    -- REPLICATOR (HIGHLIFE)
    GOL_SWAP_CELL(10, 8);
    GOL_SWAP_CELL(11, 8);
    GOL_SWAP_CELL(12, 8);
    GOL_SWAP_CELL(12, 9);
    GOL_SWAP_CELL(12, 10);
    GOL_SWAP_CELL(12, 10);
    GOL_SWAP_CELL(11, 11);
    GOL_SWAP_CELL(9, 9);
    GOL_SWAP_CELL(8, 10);
    GOL_SWAP_CELL(8, 11);
    GOL_SWAP_CELL(8, 12);
    GOL_SWAP_CELL(9, 12);
    GOL_SWAP_CELL(10, 12);
    /*
    
    GOL_CONFIRM_CHANGES();
END;

CALL GOL_START();

SELECT * FROM GAMEOFLIFE;