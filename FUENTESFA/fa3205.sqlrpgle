     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 2005')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3205                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 28 / 07 / 2026                   *
      *  DESCR:                                                          *
      *            Proceso Crear Archivo Temporal KPI Clientes Nuevos    *
      *  ================================================================*
      *  MODIFICACIONES:                                                 *
      *  ---------------                                                 *
      *  FECHA        AUTOR            DESCRIPCION                       *
      *  -----------  ---------------  --------------------------------- *
      *  28/07/2026   L.Miranda        Correcciones: manejo errores SQL, *
      *                                unificar 3 LEFT JOIN en uno solo, *
      *                                validacion parametros entrada,     *
      *                                limpieza variables no usadas       *
      *  07/08/2026   L.Miranda        FA_PATRON_COMPRA_CLIENTE y         *
      *                                FA_FECHAS_CLIENTE cambiados a      *
      *                                LEFT JOIN para incluir clientes    *
      *                                nuevos sin historial de compras    *
      *==================================================================*
     d SupCod          s                   Like(SqlCxcVen.SupCve)
     d VenCod          s                   Like(SqlCxcVen.VenCve)
      *
      **Variables para manejo de errores SQL
     d SqlMsgTxt       s            256a
     d SqlErrCod       s             10i 0
     d ErrMsgKey       s              4a
     d ErrSqlState     s              5a
     d ErrCode         s             15a   Inz(*Blanks)
      *
     d FechaPro        s               d   DatFmt(*Iso)
      *
      **Prototipo QMHSNDPM (Send Program Message)
     d QMHSNDPM        Pr                  ExtPgm('QMHSNDPM')
     d  p_MsgId                       7a   Const
     d  p_MsgFile                    20a   Const
     d  p_MsgData                   512a   Const Options(*VarSize)
     d  p_MsgDataLen                 10i 0 Const
     d  p_MsgType                    10a   Const
     d  p_CallStkEnt                 10a   Const
     d  p_CallStkCnt                 10i 0 Const
     d  p_MsgKey                      4a
     d  p_ErrCode                    15a   Options(*VarSize)
      *
      **Archivos Externos
     dSqlFac3205     e Ds                  ExtName(Fac3205) Qualified
     dSqlFacDtoh     e Ds                  ExtName(FacDtoh) Qualified
     dSqlCxcCli      e Ds                  ExtName(CxcCli) Qualified
     dSqlCxcAdc      e Ds                  ExtName(CxcAdc) Qualified
     dSqlCxcRvc      e Ds                  ExtName(CxcRvc) Qualified
     dSqlCxcVen      e Ds                  ExtName(CxcVen) Qualified
     dSqlCxcSup      e Ds                  ExtName(CxcSup) Qualified
     dSqlCxcCla      e Ds                  ExtName(CxcCla) Qualified
     dSqlSegDis      e Ds                  ExtName(SegDis) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
     d                 ds
     dFechaYmd                 1      8  0
     d FecFam                  1      6  0
     d  FecAno                 1      4  0
     d  FecMes                 5      6  0
     d  FecDia                 7      8  0
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **FA3205 Prototype
     d FA3205          Pr
     d  CodSup                        2
     d  CodVen                        3
     d  FechaP                        8
      *
      **FA3205 Program Interface
     d FA3205          Pi
     d  CodSup                        2
     d  CodVen                        3
     d  FechaP                        8
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------

        // Limpiar Tabla destino
           Exsr Limpiar_Tabla ;

        // Proceso de insercion de datos
           Exsr Proceso ;

           Exsr EndProgram;
        // ------------------------------------------------------
        // Proceso para la insercion de datos KPI Clientes Nuevos-
        // ------------------------------------------------------
           Begsr Proceso       ;

        //Crear Tabla para Exportar a Excel
           Exec Sql
            Insert Into Fac3205 (
                        FECFAM,
                        SUPCVE,
                        SUPNOM,
                        VENCVE,
                        VENNOM,
                        CLACVE,
                        CLADES,
                        CliCve,
                        CliNom,
                        ESTADO,
                        DIASPR,
                        CLIFCR,
                        CLIFMO,
                        FEPRCO,
                        FEULCO,
                        FECOPE)
            Select :FECFAM,
                   T6.SupCve,
                   T7.SupNom,
                   T5.VenCve,
                   T6.VenNom,
                   T4.ClaCve,
                   T8.ClaDes,
                   T1.CliCve,
                   T1.CliNom,
                   C.CLASIFICACION,
                   Coalesce(P.PROMEDIO_DIAS, 0),
                   Date(T1.CreTst),
                   Date(T1.ModTst),
                   Coalesce(F.FECHA_PRIMERA_COMPRA_HIST, Date('1900-01-01')),
                   Coalesce(F.FECHA_ULTIMA_COMPRA,       Date('1900-01-01')),
                   Coalesce(F.FECHA_COMPRA_PERIODO,      Date('1900-01-01'))
              From CxcCli T1
              Join CxcAdc T4
                On (T4.CliCve = T1.CliCve)
              Join CxcRvc T5
                On (T5.CliCve = T1.CliCve)
              Join CxcVen T6
                On (T6.VenCve = T5.VenCve)
              Join CxcSup T7
                On (T6.SupCve = T7.SupCve)
              Join CxcCla T8
                On (T4.ClaCve = T8.ClaCve)

            /* CLASIFICACION KPI usando fecha tope - INNER JOIN:          */
            /* cliente sin clasificacion no es procesable en este KPI     */
              Join Table(FA_CLASIFICACION_CLIENTE(
                         T1.CliCve,
                         :FechaPro)) As C
                      On 1 = 1

            /* PATRON DE COMPRA usando fecha tope - LEFT JOIN:            */
            /* clientes nuevos sin historial deben aparecer con ceros     */
              Left Join Table(FA_PATRON_COMPRA_CLIENTE(
                         T1.CliCve,
                         :FechaPro,
                         'T')) As P
                      On 1 = 1

            /* FECHAS DE COMPRA - LEFT JOIN:                              */
            /* clientes nuevos sin compras deben aparecer con 1900-01-01  */
              Left Join Table(SEGLIB.FA_FECHAS_CLIENTE(
                         T1.CliCve,
                         :FechaPro,
                         'T')) AS F
                      On 1 = 1

             Where (T6.SupCve = :SupCod Or :SupCod = 0)
               And (T5.VenCve = :VenCod Or :VenCod = 0)
               And (T1.CliSta = 'A')
               And (T4.AdcDcr <> 998)
               And Not Exists (Select 1
                         From Fac3205 X
                        Where (X.FecFam = :FecFam)
                          And (X.CliCve = T1.CliCve));

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Proceso: INSERT Fac3205' ;
              Exsr ErrSql ;
           Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Limpiar Tabla Destino                                -
        // ------------------------------------------------------
           Begsr Limpiar_Tabla ;

        // FecFam = primeros 6 digitos de FechaYmd (DS superpuesta)
        //Borrar Tabla Detalle por Clientes
           Exec Sql
               Delete From Fac3205
                Where (FecFam = :FecFam)
                 With NC;

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Limpiar_Tabla: DELETE Fac3205' ;
              Exsr ErrSql ;
           Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Subrutina de error SQL                               -
        // ------------------------------------------------------
           Begsr ErrSql   ;

        //Capturar SQLCODE y SQLSTATE antes de ejecutar otra sentencia SQL
           SqlErrCod   = SqlCod ;
           ErrSqlState = SqlState ;

        //Construir texto del mensaje
           SqlMsgTxt = %TrimR(SqlMsgTxt) + ' | SQLCODE=' +
                       %Trim(%Char(SqlErrCod)) + ' SQLSTATE=' +
                       ErrSqlState;

           *InLr = *On ;

        //Enviar mensaje *ESCAPE al joblog via API RPG nativa
           CallP QMHSNDPM('CPF9898' : 'QCPFMSG   *LIBL' : SqlMsgTxt :
                 %Len(%TrimR(SqlMsgTxt)) : '*ESCAPE   ' :
                 '*         ' : 1 : ErrMsgKey : ErrCode);

           EndSr ;
        // -----------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
           Begsr EndProgram;

           *Inlr = *On;
           Return;

           Endsr;
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
           BegSr *Inzsr;

        //Validar parametro de fecha antes de la conversion
           If %Check('0123456789':FechaP) > 0 ;
              SqlMsgTxt = 'Inzsr: FechaP invalido: ' + FechaP ;
              Exsr ErrSql ;
           Endif ;

           SupCod   = %Dec(CodSup:2:0) ;
           VenCod   = %Dec(CodVen:3:0) ;
           FechaPro = %Date(%Dec(FechaP:8:0):*Iso) ;

           FechaYmd = %Dec(FechaP:8:0) ;

           EndSr;
      /End-Free
        // -----------------------------------------------------
