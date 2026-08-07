     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 2005')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3206                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. MirAnda V.               *
      *  FECHA ESCRITURA .............: 07 / 08 / 2026                   *
      *  DESCR:                                                          *
      *     Proceso Crear Archivo Temporal KPI Individual por choferes   *
      *  ================================================================*
      *  MODIFICACIONES:                                                 *
      *  ---------------                                                 *
      *  FECHA        AUTOR            DESCRIPCION                       *
      *  -----------  ---------------  --------------------------------- *
      *==================================================================*
      **Variables para manejo de errores SQL
     d SqlMsgTxt       s            256a
     d SqlErrCod       s             10i 0
     d ErrMsgKey       s              4a
     d ErrSqlState     s              5a
     d ErrCode         s             15a   Inz(*Blanks)
      *
     d FechaDes        s                   Like(SqlSegFec.FecYmd)
     d FechaHas        s                   Like(SqlSegFec.FecYmd)
      *
      **Prototipo QMHSNDPM (Send Program Message)
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
      **Archivos Externos
     dSqlFac3206     e Ds                  ExtName(Fac3206) Qualified
     dSqlFacPlah     e Ds                  ExtName(FacPlah) Qualified
     dSqlFacPlad     e Ds                  ExtName(FacPlad) Qualified
     dSqlFacCho      e Ds                  ExtName(FacCho) Qualified
     dSqlFacVeh      e Ds                  ExtName(FacVeh) Qualified
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
      **FA3206 Prototype
     d FA3206          Pr
     d  FechaP                        8
      *
      **FA3206 Program Interface
     d FA3206          Pi
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

        //Crear Tabla para Exportar a Excel
           Exec Sql
            Insert Into Fac3206 (
                        FECFAM,
                        CHOCVE,
                        CHONOM,
                        CHOTIP,
                        GRUCAP,
                        VIAJES,
                        DIASTR,
                        GLSCARG,
                        GLSENTR,
                        GLSNOEN,
                        CAPNOM,
                        KPIEFIC,
                        KPIINT,
                        KPIPROD,
                        KPIAPRO,
                        KPIMERM,
                        VOLPROM,
                        KPIEFIR,
                        KPIUTIL,
                        DESVVOL,
                        TOTENTR,
                        KPIENTR,
                        KPIGLSX,
                        KPIFRAG,
                        KPICUMB,
                        KPIFRAB)

            With Entregas As (
                  Select D.PlaDis,
                         D.PlaNro,
                         Count(*) AS Cantidad_Entregas,
                         Sum(D.Placbd) AS Bultos_Programados,
                         Sum(D.Placdc) AS Bultos_Entregados
                    From FacPlad D
                Group By D.PlaDis, D.PlaNro)
                  Select T9.FecFam,
                         T1.ChoCve,
                         C2.ChoNom,
                         C2.ChoTip,
               //  ===============================
               //  GRUPO DE CAPACIDAD DEL VEHÍCULO
               //  ===============================
            Case
                // COLAS (VEHTIP = 1) */
            When V.VehTip = 1 And C.Capacidad_Nominal < 12000
                 Then 'Cola Menor a 12,000'

            When V.VehTip = 1 And C.Capacidad_Nominal >= 12000
                 Then 'Cola Mayor a 12,000'

                // RÍGIDOS (VehTip = 2) */
            When V.VehTip = 2 And C.Capacidad_Nominal < 3000
                 Then 'Rigido Menor a 3,000'

            When V.VehTip = 2 And C.Capacidad_Nominal >= 3000
                 Then 'Rigido Mayor a 3,000'

              Else 'NO-CLASIFICADO' End As GRUCAP,

            Count(*) AS Viajes,
            Count(Distinct T1.PlaFpl) AS DiasTrab,

            Sum(T1.PlaCbu) As GlsCarg,
            Sum(T1.PlaTce) As GlsEntr,
            Sum(T1.PlaCbu - T1.PlaTce) As GlsNoEn,

         // Avg(C.Capacidad_Nominal) As CapNom

            Integer(Avg(C.Capacidad_Nominal)) As CapNom,

            Decimal((Sum(T1.PlaTce) * 100.0 / Avg(C.Capacidad_Nominal)),
              11,4) AS KPIEFIC,

            Decimal((Count(*) * 1.0 / Count(Distinct T1.PlaFpl)),
              11,4) AS KPIINT,

            Decimal((Sum(T1.PlaTce) * 1.0 / Count(Distinct T1.PlaFpl)),
              11,4) AS KPIPROD,

            Decimal((Sum(T1.PlaCbu) * 1.0 / Avg(C.Capacidad_Nominal)),
              11,4) As KPIAPRO,

            Decimal(Case When Sum(T1.PlaCbu) = 0 Then 0
                    Else ((Sum(T1.PlaCbu - T1.PlaTce) * 100.0)
                       / Sum(T1.PlaCbu)) End, 11,4) AS KPIMERM,

            Decimal((Sum(T1.PlaTce) * 1.0 / Count(*)),
              11,4) AS VOLPROM,

         // Decimal((Sum(T1.PlaTce) * 1.0 /
         //   (C.Capacidad_Nominal * Count(*))), 11,4) AS KPIEFIR,

            Decimal(Sum(T1.PlaTce) * 1.0 / (Avg(C.Capacidad_Nominal)
                  * Count(*)), 11,4) AS KPIEFIR,

            Decimal((Count(Distinct T1.PlaFpl) * 1.0 / 30.0),
              11,4) AS KPIUTIL,

            Decimal(Coalesce(STDDEV(T1.PlaTce),0), 11,4) AS DESVVOL,

         // Coalesce(Sum(E.Cantidad_Entregas), 0) AS TOTENTR,
            Integer(Coalesce(Sum(E.Cantidad_Entregas), 0)) AS TOTENTR,

         // Decimal((Sum(E.Cantidad_Entregas) * 1.0 / Count(*)),
         //   11,4) AS KPIENTR,

            Decimal((Coalesce(Sum(E.Cantidad_Entregas), 0) *
              1.0 / Count(*)), 11,4) AS KPIENTR,

         //   Decimal(Case When Sum(E.Cantidad_Entregas) = 0 Then 0
         //          Else (Sum(T1.PlaTce) * 1.0 / Sum(E.Cantidad_Entregas))
         //          End, 11,4) AS KPIGLSX,
               Decimal(Case When Coalesce(Sum(E.Cantidad_Entregas), 0) = 0
               Then 0 Else (Sum(T1.PlaTce) * 1.0 / Sum(E.Cantidad_Entregas))
               End, 11,4) AS KPIGLSX,

         //   Decimal(Case When Sum(T1.PlaTce) = 0 Then 0
         //           When Sum(E.Cantidad_Entregas) = 0 Then 0
         //           Else (Sum(E.Cantidad_Entregas) * 1.0 / Sum(T1.PlaTce))
         //           End, 11,4) AS KPIFRAG,
               Decimal(Case When Sum(T1.PlaTce) = 0 Then 0
                      When Coalesce(Sum(E.Cantidad_Entregas), 0) = 0 Then 0
                      Else (Sum(E.Cantidad_Entregas) * 1.0 / Sum(T1.PlaTce))
                      End, 11,4) AS KPIFRAG,

         //   Decimal(Case When Sum(E.Bultos_Programados) = 0 Then 0
         //           Else (Sum(E.Bultos_Entregados) * 100.0
         //           / Sum(E.Bultos_Programados)) END, 11,4) AS KPICUMB,
              Decimal(Case When Coalesce(Sum(E.Bultos_Programados), 0) = 0
                     Then 0 Else (Sum(E.Bultos_Entregados) * 100.0
                     / Sum(E.Bultos_Programados)) END, 11,4) AS KPICUMB,

         //   Decimal(Case When Sum(E.Bultos_Entregados) = 0 Then 0
         //           When Sum(E.Cantidad_Entregas) = 0 Then 0
         //           Else (Sum(E.Cantidad_Entregas) * 1.0
         //           / Sum(E.Bultos_Entregados)) END, 11,4) AS KPIFRAB
               Decimal(Case When Coalesce(Sum(E.Bultos_Entregados), 0) = 0
                     Then 0 When Coalesce(Sum(E.Cantidad_Entregas), 0) = 0
                     Then 0 Else (Sum(E.Cantidad_Entregas) * 1.0
                     / Sum(E.Bultos_Entregados)) END, 11,4) AS KPIFRAB

          From FacPlah T1
          // ÚNICO JOIN NECESARIO PARA CHOFERES */
          Join FacCho C2
            On (T1.ChoCve = C2.ChoCve)
          // JOIN VEHÍCULOS */
          Join FacVeh V
            On (T1.VehFic = V.VehFic)
          // CAPACIDAD NOMINAL */
          Join TABLE(SEGLIB.FA_Capa_Nominal_Vehiculos(T1.VehFic)) C
            On (T1.VehFic = C.VehFic)
          // FECHA */
          Join SegFec T9
            On (T1.PlaFpl = T9.FecYmd)
          // ENTREGAS */
          Left Join Entregas E
            On (T1.PlaDis = E.PlaDis)
           And (T1.PlaNro = E.PlaNro)
          Where (T1.PlaFpl Between :FechaDes And :FechaHas)
            And (T1.SitCve = 'Y')
            And (V.VehTip In(1,2))
            And (C.Origen = 'P')
            And Not Exists (Select 1
                              From FAC3206 X
                             Where (X.FecFam = T9.FecFam)
                               And (X.ChoCve = T1.ChoCve))
            Group By T1.ChoCve,
                     T9.FecFam,
                     C2.ChoTip,
                     C2.ChoNom,
                     V.VehTip,
                Case When V.VehTip = 1 And C.Capacidad_Nominal < 12000
                     Then 'Cola Menor a 12,000'
                     When V.VehTip = 1 And C.Capacidad_Nominal >= 12000
                     Then 'Cola Mayor a 12,000'
                     When V.VehTip = 2 And C.Capacidad_Nominal < 3000
                     Then 'Rigido Menor a 3,000'
                     When V.VehTip = 2 And C.Capacidad_Nominal >= 3000
                     Then 'Rigido Mayor a 3,000'
                     Else 'NO-CLASIFICADO'
                 End;

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Proceso: INSERT Fac3206' ;
              Exsr ErrSql ;
           Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Limpiar Tabla Destino                                -
        // ------------------------------------------------------
           Begsr Limpiar_Tabla ;

        //Borrar Tabla Detalle por Clientes
           Exec Sql
               Delete From Fac3206
                Where (FecFam = :FecFam)
                 With NC;

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Limpiar_Tabla: DELETE Fac3206' ;
              Exsr ErrSql ;
           Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Subrutina de error SQL                               -
        // ------------------------------------------------------
           Begsr ErrSql   ;

        //Capturar SQLCODE y SQLSTATE antes de ejecutar otra sentencia SQL
           SqlErrCod   = SqlCod ;
           ErrSqlState = SqlState ;

        //Construir texto del mensaje
           SqlMsgTxt = %TrimR(SqlMsgTxt) + ' | SQLCODE=' +
                       %Trim(%Char(SqlErrCod)) + ' SQLSTATE=' +
                       ErrSqlState;

           *InLr = *On ;

        //Enviar mensaje *ESCAPE al joblog via API RPG nativa
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

        //Validar parametro de fecha antes de la conversion
           If %Check('0123456789':FechaP) > 0 ;
              SqlMsgTxt = 'Inzsr: FechaP invalido: ' + FechaP ;
              Exsr ErrSql ;
           Endif ;

           FechaHas = %Dec(FechaP:8:0) ;
           FechaYmd = %Dec(FechaP:8:0) ;
           FecDia = 01 ;
           FechaDes = FechaYmd         ;

           EndSr;
      /End-Free
        // -----------------------------------------------------
