     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 2005')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3204                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 24 / 06 / 2026                   *
      *  DESCR:                                                          *
      *            Proceso Crear Archivo Temporal KPI Churn              *
      *  ================================================================*
      *  MODIFICACIONES:                                                 *
      *  ---------------                                                 *
      *  FECHA        AUTOR            DESCRIPCION                       *
      *  -----------  ---------------  --------------------------------- *
      *  (optimiz.)   IBM Bob                                            *
      *               (asistente)                                        *
      *                                                                  *
      *  MEJORAS vs FA3204:                                              *
      *    1. Impresion: sustituido loop FETCH+INSERT fila-a-fila por    *
      *       un INSERT INTO ... SELECT masivo ? mucho mas eficiente     *
      *       en volumen y elimina variables host intermedias.           *
      *    2. Validacion de SqlCod despues de cada sentencia SQL         *
      *       critica; error llama a subrutina ErrSql que registra       *
      *       SQLCODE / SQLSTATE y termina el programa con *Inlr.        *
      *    3. DROP TABLE de QTEMP protegido: se verifica existencia      *
      *       antes de intentar borrar (evita SQLCODE -204 si el         *
      *       proceso aborto antes de crearlas).                         *
      *    4. Variables host del cursor removidas (ya no se necesitan).  *
      *                                                                  *
      *  -----------  ---------------  --------------------------------- *
      *  29/07/2026   L.Miranda        Sustituir tabla temporal Promdias *
      *                                por funcion                       *
      *                                FA_PATRON_COMPRA_CLIENTE          *
      *  -----------  ---------------  --------------------------------- *
      *  29/07/2026   L.Miranda        Correcciones: bug DELETE RC,      *
      *                                unificar UPDATE doble subconsulta,*
      *                                limpieza de codigo comentado,     *
      *                                validacion parametros entrada     *
      *==================================================================*
     d SupCod          s                   Like(SqlCxcVen.SupCve)
     d VenCod          s                   Like(SqlCxcVen.VenCve)
      *
      **Variables para manejo de errores SQL
     d SqlMsgTxt       s             80a
     d SqlErrCod       s             10i 0
     d ErrMsgKey       s              4a
     d ErrSqlState     s              5a
     d ErrCode         s             15a   Inz(*Blanks)
      *
     d FechaPro        s               d   DatFmt(*Iso)
     d FechaDia        s               d   DatFmt(*Iso)
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
     dSqlFac3204     e Ds                  ExtName(Fac3204) Qualified
     dSqlFacDtoh     e Ds                  ExtName(FacDtoh) Qualified
     dSqlFacDtod     e Ds                  ExtName(FacDtod) Qualified
     dSqlCxcCli      e Ds                  ExtName(CxcCli) Qualified
     dSqlCxcAdc      e Ds                  ExtName(CxcAdc) Qualified
     dSqlCxcRvc      e Ds                  ExtName(CxcRvc) Qualified
     dSqlCxcVen      e Ds                  ExtName(CxcVen) Qualified
     dSqlCxcSup      e Ds                  ExtName(CxcSup) Qualified
     dSqlCxcCla      e Ds                  ExtName(CxcCla) Qualified
     dSqlSegDis      e Ds                  ExtName(SegDis) Qualified
     dSqlInvArt      e Ds                  ExtName(InvArt) Qualified
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
      **FA3204 Prototype
     d FA3204          Pr
     d  CodSup                        2
     d  CodVen                        3
     d  FechaP                        8
      *
      **FA3204 Program Interface
     d FA3204          Pi
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

        // Proceso Para crear Tabla Temporal
           Exsr Crear_Tabla ;

        // Proceso de Actualizacion
           Exsr Proceso ;

        // Proceso Creacion Tabla Principal
           Exsr Impresion;

        // Proceso Creacion Tablas de Ranking
           Exsr Ranking   ;

        // Proceso Para Borrar Tabla Temporal
           Exsr Borrar_Tabla ;

           Exsr EndProgram;
        // ------------------------------------------------------
        // Proceso para la creacion de las Tablas temporales    -
        // ------------------------------------------------------
           Begsr Proceso       ;

        //Insertar clientes Activo solo Compras por Pedidos
           Exec Sql
           Insert Into Qtemp/Churnwk (CliCve, CliNom)
            Select
                T1.CliCve,
                T1.CliNom
            From CxcCli T1
            Join CxcAdc T2
              On (T1.CliCve = T2.CliCve)
           Where (T1.CliSta = 'A')
             And (T2.AdcDcr <> 998)
             And Exists (
                 Select 1
                   From FacDtoh T3
                   Join SegDis T4
                     On (T3.DisCve = T4.DisCve)
                   Join SegFec T9
                     On (T3.DtoAno = T9.FecAno)
                    And (T3.DtoMes = T9.FecMes)
                    And (T3.DtoDia = T9.FecDia)
                  Where (T1.CliCve = T3.CliCve)
                    And (T4.DisTip = 'N')
                    And (T3.DtoSta = 'A')
                    And (T9.FecIso <= :FechaPro));

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Proceso: INSERT Churnwk clientes' ;
              Exsr ErrSql ;
            Endif ;

        //Actualizar FechaUlt usando la función SEGLIB.FA_FECHAS_CLIENTE
           Exec Sql
           Update Qtemp/Churnwk T1
              Set FechaUlt =
                  Coalesce((
                    Select X.FECHA_ULTIMA_COMPRA
                      From Table(SEGLIB.FA_FECHAS_CLIENTE(T1.CliCve,
                                 :FechaPro, 'N')) X
                     Fetch First 1 Row Only ), Date('1900-01-01'));

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Proceso: UPDATE FechaUlt desde función';
              Exsr ErrSql ;
            Endif ;

        //Actualizar PromDias usando la función FA_PATRON_COMPRA_CLIENTE
            Exec Sql
            Update Qtemp/Churnwk T1
                 Set PromDias =
                Coalesce((
                Select X.PROMEDIO_DIAS
                  From Table(FA_PATRON_COMPRA_CLIENTE
                       (T1.CliCve, :FechaPro, 'N')) X
              Fetch First 1 Row Only), 0);

            If SqlCod < *Zeros ;
                SqlMsgTxt = 'Proceso: UPDATE PromDias desde función';
                Exsr ErrSql ;
             Endif ;

        //Actualizar Monto y Cantidad de los Ultimos 12 Meses
           Exec Sql
              Update Qtemp/Churnwk T
                 Set (Monto12, Cantidad12) = (
              Select Sum(T1.DtoImp),
                     Sum(T1.DtoCan)
                From FacDtod T1
                Join InvArt T3
                  On (T1.ArtCve = T3.ArtCve)
                Join SegDis T4
                  On (T1.DisCve = T4.DisCve)
                Join SegFec T9
                  On (T1.DtoAno = T9.FecAno)
                 And (T1.DtoMes = T9.FecMes)
                 And (T1.DtoDia = T9.FecDia)
               Where (T1.CliCve = T.CliCve)
                 And (T9.FecIso >= :FechaPro - 12 months)
                 And (T3.ArtPpr = 'S')
                 And (T4.DisTip = 'N'));

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Proceso: UPDATE Monto12/Cantidad12' ;
              Exsr ErrSql ;
            Endif ;

        //Actualizar Monto y Cantidad del Periodo Anterior (12-24 meses)
           Exec Sql
              Update Qtemp/Churnwk T
                 Set (Monto12Prev, CantidadPrev12) = (
              Select Sum(T1.DtoImp),
                     Sum(T1.DtoCan)
                From FacDtod T1
                Join InvArt T3
                  On (T1.ArtCve = T3.ArtCve)
                Join SegDis T4
                  On (T1.DisCve = T4.DisCve)
                Join SegFec T9
                  On (T1.DtoAno = T9.FecAno)
                 And (T1.DtoMes = T9.FecMes)
                 And (T1.DtoDia = T9.FecDia)
               Where (T1.CliCve = T.CliCve)
                 And (T9.FecIso Between (:FechaPro - 24 months)
                 And (:FechaPro - 12 months))
                 And (T3.ArtPpr = 'S')
                 And (T4.DisTip = 'N'));

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Proceso: UPDATE Monto12Prev/CantidadPrev12';
              Exsr ErrSql ;
            Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Resumen por Supervisor, Vendedor y Clientes Detalle  -
        // ------------------------------------------------------
           Begsr Impresion     ;

        //Crear Tabla para Exportar a Excel
           Exec Sql
             Insert Into Fac3204
                    (SupCve, SupNom, VenCve, VenNom, ClaCve,
                     ClaDes, CliCve, CliNom, Feulco, DiasPr,
                     DiaSco, Canu12, Monu12, Canu24, MonU24,
                     VarCan, PorCan, TenCli, Estado)
              Select T4.SupCve,
                     T5.SupNom,
                     T3.VenCve,
                     T4.VenNom,
                     T2.ClaCve,
                     T6.ClaDes,
                     T1.CliCve,
                     T1.CliNom,
                     Coalesce(T1.FechaUlt, Date('1900-01-01')),
                     Coalesce(T1.PromDias, 0),
                     Coalesce(Days(:FechaPro) - Days(T1.FechaUlt), 99999),
                     Coalesce(T1.Cantidad12, 0),
                     Coalesce(T1.Monto12, 0),
                     Coalesce(T1.CantidadPrev12, 0),
                     Coalesce(T1.Monto12Prev, 0),

          --Variacion absoluta de cantidad
            Coalesce(T1.Cantidad12, 0) - Coalesce(T1.CantidadPrev12, 0),

          --Variacion porcentual de cantidad
            Dec(Case When Coalesce(T1.CantidadPrev12, 0) = 0 Then 0
                Else ((Coalesce(T1.Cantidad12, 0) -
                Coalesce(T1.CantidadPrev12, 0)) * 100.0) /
                Coalesce(Nullif(T1.CantidadPrev12, 0), 1)
                End, 7, 2),

          --Indicador textual de tendencia
            Case When Coalesce(T1.CantidadPrev12, 0) = 0
                  And Coalesce(T1.Cantidad12, 0) > 0
                 Then 'Crecimiento Fuerte'
                 When Coalesce(T1.CantidadPrev12, 0) = 0
                  And Coalesce(T1.Cantidad12, 0) = 0
                 Then 'Estable'

                 When (((Coalesce(T1.Cantidad12, 0) -
                         Coalesce(T1.CantidadPrev12, 0)) * 100.0) /
                         Coalesce(Nullif(T1.CantidadPrev12, 0), 1)) > 10
                 Then 'Crecimiento fuerte'
                 When (((Coalesce(T1.Cantidad12, 0) -
                         Coalesce(T1.CantidadPrev12, 0)) * 100.0) /
                         Coalesce(Nullif(T1.CantidadPrev12, 0), 1)) > 0
                 Then 'Crecimiento leve'
                 When (((Coalesce(T1.Cantidad12, 0) -
                         Coalesce(T1.CantidadPrev12, 0)) * 100.0) /
                         Coalesce(Nullif(T1.CantidadPrev12, 0), 1)) = 0
                 Then 'Estable'
                 When (((Coalesce(T1.Cantidad12, 0) -
                         Coalesce(T1.CantidadPrev12, 0)) * 100.0) /
                         Coalesce(Nullif(T1.CantidadPrev12, 0), 1)) < -10
                 Then 'Caida fuerte'
                 Else 'Caida leve' End,

          --Estado del cliente (KPI Churn)
            Case When T1.FechaUlt Is Null
                      Or T1.PromDias Is Null
                      Or T1.PromDias = 0
                 Then 'SIN HISTORIAL'
                 When Days(:FechaPro) - Days(T1.FechaUlt) <= T1.PromDias
                      Then 'ACTIVO'
                 When Days(:FechaPro) - Days(T1.FechaUlt) <= T1.PromDias * 1.5
                 Then 'EN RIESGO'
                 Else 'CHURN'End
                From Qtemp/Churnwk T1
                Join CxcAdc T2
                  On (T1.CliCve = T2.CliCve)
                Join CxcRvc T3
                  On (T1.CliCve = T3.CliCve)
                Join CxcVen T4
                  On (T3.VenCve = T4.VenCve)
                Join CxcSup T5
                  On (T4.SupCve = T5.SupCve)
                Join CxcCla T6
                  On (T2.ClaCve = T6.ClaCve)
               Where (T4.SupCve = :SupCod Or :SupCod = 0)
                 And (T3.VenCve = :VenCod Or :VenCod = 0)
                 And Not Exists (
                         Select 1
                            From Fac3204
                           Where (SupCve = T4.SupCve)
                             And (VenCve = T3.VenCve)
                             And (ClaCve = T2.ClaCve)
                             And (CliCve = T1.CliCve));

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Impresion: INSERT masivo Fac3204' ;
              Exsr ErrSql ;
            Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Tablas Resumen de Ranking                            -
        // ------------------------------------------------------
           Begsr Ranking       ;

        //Ranking por Supervisor y Vendedor
           Exec Sql
             Insert Into FAC3204RV
                  (SUPCVE,
                   SUPNOM,
                   VENCVE,
                   VENNOM,
                   TOTCLI,
                   CLIACT,
                   CLIRIE,
                   CLICHU,
                   CLIHIS,
                   PORCHU,
                   RANKIN)
             Select
                   T1.SupCve,
                   T1.SupNom,
                   T1.VenCve,
                   T1.VenNom,
                   Count(*) as TotalClientes,

                   Sum(Case When Estado = 'ACTIVO' Then 1 Else 0 end)
                       As ClientesActivos,
                   Sum(Case When Estado = 'EN RIESGO' Then 1 Else 0 end)
                       As ClientesEnRiesgo,
                   Sum(Case When Estado = 'CHURN' Then 1 Else 0 end)
                       As ClientesChurn,
                   Sum(Case When Estado = 'SIN HISTORIAL' Then 1 Else 0 end)
                       As ClientesSinHistorial,
                   -- Porcentaje de churn
        --Porcentaje de churn
                   Dec((Sum(Case When Estado = 'CHURN' Then 1 Else 0 End)
                        * 100.0) / Nullif(Count(*),0),5,2) as PorcChurn,
        --Ranking por vendedor basado en % churn
                   Rank() over (Order by (Sum(case when Estado = 'CHURN'
                                Then 1 else 0 end) * 1.0)
                                / Nullif(Count(*),0)) as Ranking
             From Fac3204 T1
            Group by T1.SupCve, T1.SupNom, T1.VenCve, T1.VenNom;

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Ranking: INSERT FAC3204RV' ;
              Exsr ErrSql ;
            Endif ;

        //Ranking por Supervisor
           Exec Sql
             Insert Into FAC3204RS
                  (SUPCVE,
                   SUPNOM,
                   TOTCLI,
                   CLIACT,
                   CLIRIE,
                   CLICHU,
                   CLIHIS,
                   PORCHU,
                   RANKIN)
             Select
                   T1.SupCve,
                   T1.SupNom,
                   Count(*) as TotalClientes,

                   Sum(Case When Estado = 'ACTIVO' Then 1 Else 0 end)
                       As ClientesActivos,
                   Sum(Case When Estado = 'EN RIESGO' Then 1 Else 0 end)
                       As ClientesEnRiesgo,
                   Sum(Case When Estado = 'CHURN' Then 1 Else 0 end)
                       As ClientesChurn,
                   Sum(Case When Estado = 'SIN HISTORIAL' Then 1 Else 0 end)
                       As ClientesSinHistorial,
                   -- Porcentaje de churn
        --Porcentaje de churn
                   Dec((Sum(Case When Estado = 'CHURN' Then 1 Else 0 End)
                        * 100.0) / Nullif(Count(*),0),5,2) as PorcChurn,
        --Ranking por vendedor basado en % churn
                   Rank() over (Order by (Sum(case when Estado = 'CHURN'
                                Then 1 else 0 end) * 1.0)
                                / Nullif(Count(*),0)) as Ranking
             From Fac3204 T1
            Group by T1.SupCve, T1.SupNom;

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Ranking: INSERT FAC3204RS' ;
              Exsr ErrSql ;
            Endif ;

        //Ranking por Supervisor, Vendedor y Clasificacion
           Exec Sql
             Insert Into FAC3204RC
                  (SUPCVE,
                   SUPNOM,
                   VENCVE,
                   VENNOM,
                   ClaCve,
                   ClaDes,
                   TOTCLI,
                   CLIACT,
                   CLIRIE,
                   CLICHU,
                   CLIHIS,
                   PORCHU,
                   RANKIN)
             Select
                   T1.SupCve,
                   T1.SupNom,
                   T1.VenCve,
                   T1.VenNom,
                   T1.ClaCve,
                   T1.ClaDes,
                   Count(*) as TotalClientes,

                   Sum(Case When Estado = 'ACTIVO' Then 1 Else 0 end)
                       As ClientesActivos,
                   Sum(Case When Estado = 'EN RIESGO' Then 1 Else 0 end)
                       As ClientesEnRiesgo,
                   Sum(Case When Estado = 'CHURN' Then 1 Else 0 end)
                       As ClientesChurn,
                   Sum(Case When Estado = 'SIN HISTORIAL' Then 1 Else 0 end)
                       As ClientesSinHistorial,
                   -- Porcentaje de churn
        --Porcentaje de churn
                   Dec((Sum(Case When Estado = 'CHURN' Then 1 Else 0 End)
                        * 100.0) / Nullif(Count(*),0),5,2) as PorcChurn,
        --Ranking por vendedor basado en % churn
                   Rank() over (Order by (Sum(case when Estado = 'CHURN'
                                Then 1 else 0 end) * 1.0)
                                / Nullif(Count(*),0)) as Ranking
             From Fac3204 T1
            Group by T1.SupCve, T1.SupNom, T1.VenCve, T1.VenNom,
                     T1.ClaCve, T1.ClaDes                                  ;

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Ranking: INSERT FAC3204RC' ;
              Exsr ErrSql ;
            Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Crear Tabla Temporal                                 -
        // ------------------------------------------------------
           Begsr Crear_Tabla   ;

        //Tabla temporal KPI Churn
           Exec Sql
           Create Table Qtemp/Churnwk (
               CliCve        Dec(7,0),
               CliNom        Char(55),
               FechaUlt      Date,
               PromDias      Dec(10,4),
               Cantidad12    Dec(12,2),
               Monto12       Dec(15,2),
               CantidadPrev12 Dec(12,2),
               Monto12Prev   Dec(15,2));

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Crear_Tabla: CREATE TABLE Churnwk' ;
              Exsr ErrSql ;
            Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Borrar Tabla Temporal                                -
        // ------------------------------------------------------
           Begsr Borrar_Tabla  ;

           Exec Sql
           Drop Table If Exists Qtemp/Churnwk  ;

           If SqlCod < *Zeros ;
              SqlMsgTxt = 'Borrar_Tabla: DROP Churnwk' ;
              Exsr ErrSql ;
            Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Subrutina de error SQL                               -
        // ------------------------------------------------------
           Begsr ErrSql   ;

        // Capturar SQLCODE y SQLSTATE antes de ejecutar otra sentencia SQL
           SqlErrCod   = SqlCod ;
           ErrSqlState = SqlState ;

        // Construir texto del mensaje
           SqlMsgTxt = %TrimR(SqlMsgTxt) + ' | SQLCODE=' +
                       %Trim(%Char(SqlErrCod)) + ' SQLSTATE=' +
                       ErrSqlState;

        // Asegura cleanup de temporales antes de terminar
           Exsr Borrar_Tabla ;
           *InLr = *On  ;

        // Enviar mensaje *ESCAPE al joblog via API RPG nativa
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

           SupCod = %Dec(CodSup:2:0)  ;
           VenCod = %Dec(CodVen:3:0)  ;
           FechaPro = %Date(%Dec(FechaP:8:0):*Iso)  ;

           FechaYmd = FechaPro ;
           FechaDia = %Date(*Date)  ;

        //Borrar Tabla Detalle por Clientes
           Exec Sql
               Delete From Fac3204
                Where (FecFam = :FecFam)
                 With NC;

        //Borrar Tabla Ranking por Vendedor
           Exec Sql
               Delete From Fac3204RV
                Where (FecFam = :FecFam)
                 With NC;

        //Borrar Tabla Ranking por Supervisor
           Exec Sql
               Delete From Fac3204RS
                Where (FecFam = :FecFam)
                 With NC;

        //Borrar Tabla Ranking por Supervisor, Vendedor y Clasificacion
           Exec Sql
               Delete From Fac3204RC
                Where (FecFam = :FecFam)
                 With NC;

           EndSr;
      /End-Free
        // -----------------------------------------------------
