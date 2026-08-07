     **FREE
         DCL-S ID_CLIENTE DEC(7,0);
         DCL-S FECHA_COMPRA DATE;
         DCL-S FIN_CURSOR IND;

         EXEC SQL DECLARE CURSOR_FACTURAS CURSOR FOR
         SELECT T1.CliCve, T2.FecIso
         FROM facdtoh T1
         JOIN SegFec T2
           ON (T1.DtoAno = T2.FecAno)
          AND (T1.DtoMes = T2.FecMes)
          AND (T1.DtoDia = T2.FecDia)
         ORDER BY T1.CliCve, T2.FecIso;

         EXEC SQL OPEN CURSOR_FACTURAS;

         DOU FIN_CURSOR;

             EXEC SQL FETCH CURSOR_FACTURAS INTO :ID_CLIENTE, :FECHA_COMPRA;

             IF SQLCODE = 100; // Fin del cursor
                  FIN_CURSOR = *ON;
              ELSE;
                  EXEC SQL CALL ACTUALIZAR_INACTIVIDAD(:ID_CLIENTE,
          :FECHA_COMPRA);
              ENDIF;

          ENDDO;

          EXEC SQL CLOSE CURSOR_FACTURAS;

          *INLR = *ON;

