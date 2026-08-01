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
     d SupCod          s                   Like(SqlCxcVen.SupCve)
     d VenCod          s                   Like(SqlCxcVen.VenCve)
      *
     d FechaPro        s               d   DatFmt(*Iso)
     d FechaDia        s               d   DatFmt(*Iso)
      *
      **Archivos Externos
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
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **FA3205 Prototype
     d FA3205          Pr
     d  CodSup                        2
     d  CodVen                        3
     d  FechaP                        8
      *
      **FA3205 Program Interface
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
        // Proceso Creacion Tabla
           Exsr Proceso ;
           Exsr EndProgram;
        // ------------------------------------------------------
        // Proceso para la creacion de las Tablas Temporales    -
        // ------------------------------------------------------
           Begsr Proceso       ;

        //Crear Tabla para Exportar a Excel
           Exec Sql
            Insert Into Fac3205 (
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
            Select
                    T6.SupCve,
                    T7.SupNom,
                    T5.VenCve,
                    T6.VenNom,
                    T4.ClaCve,
                    T8.ClaDes,
                    T1.CliCve,
                    T1.CliNom,
                    C.CLASIFICACIOn,
                    P.PROMEDIO_DIAS,
                    DATE(T1.CreTst),
                    DATE(T1.ModTst),
                    COALESCE(H.FECHA_PRIMERA_COMPRA, DATE('0001-01-01')),
                    COALESCE(U.FECHA_ULTIMA, DATE('0001-01-01')),
                    COALESCE(CP.FECHA_PERIODO, DATE('0001-01-01'))
                From CxcCli T1
                Join CxcAdc T4
                  On T4.CliCve = T1.CliCve
                Join CxcRvc T5
                  On T5.CliCve = T1.CliCve
                Join CxcVen T6
                  On T6.VenCve = T5.VenCve
                Join CxcSup T7
                  On T6.SupCve = T7.SupCve
                Join CxcCla T8
                  On T4.ClaCve = T8.ClaCve

            /* CLASIFICACIÓN KPI Usando fecha tope */
            Join TABLE(FA_CLASIFICACION_CLIENTE(
                       T1.CliCve,
                       :FechaPro)) AS C
                    On 1 = 1

            /* PATRÓN DE COMPRA Usando fecha tope */
            Join TABLE(FA_PATRON_COMPRA_CLIENTE(
                       T1.CliCve,
                       :FechaPro,
                       'T')) AS P
                    On 1 = 1

            /* ÚLTIMA COMPRA <= FechaPro    */
            LEFT Join (Select T2.CliCve, MAX(T9.FecIso) AS FECHA_ULTIMA
                         From FacDtoh T2
                         Join SegDis T3
                           On T2.DisCve = T3.DisCve
                         Join SegFec T9
                           On T2.DtoAno = T9.FecAno
                          And T2.DtoMes = T9.FecMes
                          And T2.DtoDia = T9.FecDia
                        Where T2.DtoSta = 'A'
                          And T2.DtoTip NOT IN (2,8)
                    --    And T3.DisTip = 'N'
                          And T9.FecIso <= :FechaPro
                     Group By T2.CliCve) U On U.CliCve = T1.CliCve

            /* PRIMERA COMPRA DEL PERÍODO (mes de la fecha tope) */
            LEFT Join (Select T2.CliCve, MIN(T9.FecIso) AS FECHA_PERIODO
                         From FacDtoh T2
                         Join SegDis T3
                           On T2.DisCve = T3.DisCve
                         Join SegFec T9
                           On T2.DtoAno = T9.FecAno
                          And T2.DtoMes = T9.FecMes
                          And T2.DtoDia = T9.FecDia
                        Where T2.DtoSta = 'A'
                          And T2.DtoTip NOT IN (2,8)
                    --    And T3.DisTip = 'N'
                          And T9.FecIso Between
                              DATE(TO_CHAR(:FechaPro, 'YYYY-MM') || '-01')
                               And :FechaPro
                     Group By T2.CliCve) CP On CP.CliCve = T1.CliCve

            /* PRIMERA COMPRA HISTÓRICA <= último día del mes anterior */
            LEFT Join (Select T2.CliCve, MIN(T9.FecIso) AS FECHA_PRIMERA_COMPRA
                         From FacDtoh T2
                         Join SegDis T3
                           On T2.DisCve = T3.DisCve
                         Join SegFec T9
                           On T2.DtoAno = T9.FecAno
                          And T2.DtoMes = T9.FecMes
                          And T2.DtoDia = T9.FecDia
                        Where T2.DtoSta = 'A'
                          And T2.DtoTip NOT IN (2,8)
                     --   And T3.DisTip = 'N'
                          And T9.FecIso <= LAST_DAY( :FechaPro - 1 Month)
                     Group BY T2.CliCve) H On H.CliCve = T1.CliCve

            Where (T6.SupCve = :SupCod Or :SupCod = 0)
              And (T5.VenCve = :VenCod Or :VenCod = 0)
              And (T1.CliSta = 'A')
              And (T4.AdcDcr <> 998)
              And Not Exists (Select 1
                        From FAC3205 F
                       Where F.CliCve = T1.CliCve);

            SqlCod = *Zeros ;

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

           SupCod = %Dec(CodSup:2:0)  ;
           VenCod = %Dec(CodVen:3:0)  ;
           FechaPro = %Date(%Dec(FechaP:8:0):*Iso)  ;

           FechaDia = %Date(*Date)  ;

        // Borrar Tabla Detalle por Clientes
           Exec Sql
               Delete From Fac3205
                 With NC;

           EndSr;
      /End-Free
        // -----------------------------------------------------
