--CL: CHGLIBL LIBL(QTEMP DATOS92 faclib.v2);

--CL: CHGCURLIB CURLIB(DATOS92) ;

/* Código SQL con Cursor para ejecutar el procedimiento  */



CREATE OR REPLACE PROCEDURE PRO_POBINA()  

LANGUAGE SQL

BEGIN

    -- Variables

    DECLARE V_CODIGO DECIMAL(7,0);

    DECLARE V_FECHA DATE;

    DECLARE FIN_CURSOR INT DEFAULT 0;



    -- **Declaración del Cursor antes de abrirlo**

    DECLARE CURSOR_FACTURAS CURSOR FOR 

    SELECT T1.CliCve, T2.FecIso

    FROM Facdtoh T1

    JOIN SegFec T2

      ON T1.DtoAno = T2.FecAno

     AND T1.DtoMes = T2.FecMes

     AND T1.DtoDia = T2.FecDia

    WHERE T1.DtoSta = 'A'

    ORDER BY T1.CliCve, T2.FecIso;



    -- **Manejador para detectar el fin del cursor**

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIN_CURSOR = 1;



    -- **Eliminar registros anteriores de CONTROL_RENDIMIENTO**

    DELETE FROM CONTROL_RENDIMIENTO WHERE ID_PROCESO = 'P';



    -- **Registrar inicio del proceso**

    INSERT INTO CONTROL_RENDIMIENTO (ID_PROCESO, FECHA_INICIO)

    VALUES ('P', CURRENT_TIMESTAMP);



    -- **Abrir el Cursor**

    OPEN CURSOR_FACTURAS;



    -- **Recorrer el Cursor**

    REPEAT

        FETCH CURSOR_FACTURAS INTO V_CODIGO, V_FECHA;

        

        IF FIN_CURSOR = 0 THEN

            CALL PRO_ACTUALIZAR_INACTIVIDAD(V_CODIGO, V_FECHA);

        END IF;

        

    UNTIL FIN_CURSOR = 1

    END REPEAT;



    -- **Cerrar el Cursor**

    CLOSE CURSOR_FACTURAS;



    -- **Registrar finalización del proceso**

    UPDATE CONTROL_RENDIMIENTO

    SET FECHA_FIN = CURRENT_TIMESTAMP

    WHERE ID_PROCESO = 'P';



END;





