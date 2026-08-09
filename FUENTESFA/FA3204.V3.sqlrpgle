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
      *==================================================================*
     d SupCod          s                   Like(SqlCxcVen.SupCve)
     d VenCod          s                   Like(SqlCxcVen.VenCve)
      *
     d SupCve          s                   Like(SqlFac3204.SupCve)
     d SupNom          s                   Like(SqlFac3204.SupNom)
     d VenCve          s                   Like(SqlFac3204.VenCve)
     d VenNom          s                   Like(SqlFac3204.VenNom)
     d ClaCve          s                   Like(SqlFac3204.ClaCve)
     d ClaDes          s                   Like(SqlFac3204.ClaDes)
     d CliCve          s                   Like(SqlFac3204.CliCve)
     d CliNom          s                   Like(SqlFac3204.CliNom)
     d Feulco          s                   Like(SqlFac3204.Feulco)
     d DiasPr          s                   Like(SqlFac3204.DiasPr)
     d Diasco          s                   Like(SqlFac3204.Diasco)
     d Canu12          s                   Like(SqlFac3204.Canu12)
     d Monu12          s                   Like(SqlFac3204.Monu12)
     d Canu24          s                   Like(SqlFac3204.Canu24)
     d Monu24          s                   Like(SqlFac3204.Monu24)
     d Estado          s                   Like(SqlFac3204.Estado)
     d Varcan          s                   Like(SqlFac3204.VarCan)
     d PorCan          s                   Like(SqlFac3204.PorCan)
     d TenCli          s                   Like(SqlFac3204.TenCli)
      *
     d FechaPro        s               d   DatFmt(*Iso)
     d FechaDia        s               d   DatFmt(*Iso)
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

           SqlCod = *Zeros ;

        //Actualizar Ultima Compra
           Exec Sql
           Update Qtemp/Churnwk T1
               Set FechaUlt = (
               Select Max(T9.FecIso)
                 From FacDtoh T2
                 Join SegDis T3
                   On (T2.DisCve = T3.DisCve)
                 Join SegFec T9
                   On (T2.DtoAno = T9.FecAno)
                  And (T2.DtoMes = T9.FecMes)
                  And (T2.DtoDia = T9.FecDia)
                Where (T1.CliCve = T2.CliCve)
                  And (T9.FecIso <= :FechaPro)
                  And (T2.DtoSta = 'A')
                  And (T2.DtoTip Not In(2,8))
                  And (T3.DisTip = 'N'));

           SqlCod = *Zeros ;

        //Actualizar Ultima Compra
           Exec Sql
           Insert Into Qtemp/Promdias
             Select X.CliCve, Avg(X.DifDias) As PromDias
               From (Select
                     T2.CliCve,
                     Days(T9.FecIso) -
                     Days(Lag(T9.FecIso) Over (
                     Partition By T2.CliCve
                     Order By T9.FecIso)) As DifDias
             From FacDtoh T2
             Join SegDis T3
               On (T2.DisCve = T3.DisCve)
             Join SegFec T9
               On (T2.DtoAno = T9.FecAno)
              And (T2.DtoMes = T9.FecMes)
              And (T2.DtoDia = T9.FecDia)
            Where (T9.FecIso <= :FechaPro)
              And (T2.DtoSta = 'A')
              And (T2.DtoTip Not In(2,8))
              And (T3.DisTip = 'N')) X
            Where X.DifDias Is Not Null
            Group By X.CliCve;

           SqlCod = *Zeros ;

        //Actualizar Dias Promedio de Compras Qtemp/Churnwk
           Exec Sql
             Update Qtemp/Churnwk T1
                Set PromDias = (
                    Select P.PromDias
                    From Qtemp/Promdias P
                    Where (P.CliCve = T1.CliCve));

           SqlCod = *Zeros ;

        //Actualizar Monto de Compras de los Ultimos 12 Meses
           Exec Sql
              Update Qtemp/Churnwk T
              Set Monto12 = (
                Select Sum(T1.DtoImp)
                  From FacDtod T1
                  Join InvArt T3
                    On T1.ArtCve = T3.ArtCve
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

           SqlCod = *Zeros ;

        //Actualizar Cantidad de Compras de los Ultimos 12 Meses
           Exec Sql
              Update Qtemp/Churnwk T
              Set Cantidad12 = (
                Select Sum(T1.DtoCan)
                  From FacDtod T1
                  Join InvArt T3
                    On T1.ArtCve = T3.ArtCve
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

           SqlCod = *Zeros ;

        //Actualizar Monto de Compras de los Ultimos 24 Meses
           Exec Sql
           Update Qtemp/Churnwk T
              Set Monto12Prev = (
           Select Sum(T1.DtoImp)
             From FacDtod T1
             Join InvArt T3
               On T1.ArtCve = T3.ArtCve
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

           SqlCod = *Zeros ;

        //Actualizar Cantidad de Compras de los Ultimos 24 Meses
           Exec Sql
           Update Qtemp/Churnwk T
              Set CantidadPrev12 = (
             Select Sum(T1.DtoCan)
               From FacDtod T1
               Join InvArt T3
                 On T1.ArtCve = T3.ArtCve
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

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Resumen por Supervisor, Vendedor y Clientes Detalle  -
        // ------------------------------------------------------
           Begsr Impresion     ;

           Exec Sql
            Declare C1 Cursor for
            Select T4.SupCve As Codigo_Del_Supervisor,
                   T5.SupNom As Nombre_Del_Supervisor,
                   T3.VenCve As Codigo_Del_Vendedor,
                   T4.VenNom As Nombre_Del_Vendedor,
                   T2.ClaCve As Codigo_De_La_Clasificacion,
                   T6.ClaDes As Descripcion_De_la_clasificacion,
                   T1.CliCve As Codigo_Del_Cliente,
                   T1.CliNom As Nombre_Del_Cliente,
                   Coalesce(T1.FechaUlt, Date('1900-01-01')) As
                   Fecha_Ultima_Compra,
                   Coalesce(T1.PromDias,0) As Dias_Promedio_Compra,
                   Coalesce(days(:FechaPro) - days(T1.FechaUlt), 99999)
                   As Dias_Sin_Comprar,
                   Coalesce(T1.Cantidad12,0) As Cantidad_Ultimos12_Meses,
                   Coalesce(T1.Monto12,0) As Monto_Ultimos12_Meses,
                   Coalesce(T1.CantidadPrev12,0) As Cantidad_Ultimos24_Meses,
                   Coalesce(T1.Monto12Prev,0) As Monto_Ultimos24_Meses,
        --Estado del cliente (KPI Churn)
                   Case When T1.FechaUlt Is Null
                             Or PromDias Is Null
                             Or PromDias = 0
                             Then 'SIN HISTORIAL'
                   When Days(:FechaPro) - Days(T1.FechaUlt) <= PromDias
                             Then 'ACTIVO'
                   When Days(:FechaPro) - Days(T1.FechaUlt) <= PromDias * 1.5
                             Then 'EN RIESGO'
                     Else 'CHURN' End As Estado,
        --Variación absoluta de cantidad
                   Coalesce(T1.Cantidad12,0) - Coalesce(T1.CantidadPrev12,0)
                   As VariacionCantidad,
        --Variación porcentual de cantidad
                   Dec(Case When Coalesce(T1.CantidadPrev12,0) = 0 Then 0
                        Else ((Coalesce(T1.Cantidad12,0) -
                               Coalesce(T1.CantidadPrev12,0)) * 100.0) /
                               Coalesce(Nullif(CantidadPrev12,0),1) End ,7,2)
                               As VariacionPorcCantidad,
        --Indicador textual de tendencia
                   Case When Coalesce(T1.CantidadPrev12,0) = 0
                         And Coalesce(T1.Cantidad12,0) > 0
                        Then 'Crecimiento Fuerte'

                        When Coalesce(T1.CantidadPrev12,0) = 0
                         And Coalesce(T1.Cantidad12,0) = 0
                        Then 'Estable'

                        When (((Coalesce(T1.Cantidad12,0) -
                               Coalesce(T1.CantidadPrev12,0)) * 100.0) /
                               Coalesce(Nullif(T1.CantidadPrev12,0),1)) > 10
                        Then 'Crecimiento fuerte'

                        When (((Coalesce(T1.Cantidad12,0) -
                               Coalesce(T1.CantidadPrev12,0)) * 100.0) /
                               Coalesce(Nullif(T1.CantidadPrev12,0),1)) > 0
                        Then 'Crecimiento leve'

                        When (((Coalesce(T1.Cantidad12,0) -
                               Coalesce(T1.CantidadPrev12,0)) * 100.0) /
                               Coalesce(Nullif(T1.CantidadPrev12,0),1)) = 0
                        Then 'Estable'

                        When (((Coalesce(T1.Cantidad12,0) -
                               Coalesce(T1.CantidadPrev12,0)) * 100.0) /
                               Coalesce(Nullif(T1.CantidadPrev12,0),1)) < -10
                        Then 'Caida fuerte'

                        Else 'Caida leve' End As Tendencia
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
             Order By T4.SupCve, T3.VenCve, T2.ClaCve,
                      Estado, T1.CliCve, Dias_Sin_Comprar Desc
            For Read Only           ;

          Exec Sql
            Open c1;

          Dow True;

          Exec Sql
            Fetch Next From c1 Into :SupCve, :SupNom, :VenCve, :VenNom, :ClaCve,
                                    :ClaDes, :CliCve, :CliNom, :FeulCo, :DiasPr,
                                    :DiaSco, :CanU12, :MonU12, :CanU24, :MonU24,
                                    :Estado, :VarCan, :PorCan, :TenCli         ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        //Crear Tabla para Exportar a Excel
           Exec Sql
             Insert Into Fac3204
                  (SupCve, SupNom, VenCve, VenNom, ClaCve,
                   ClaDes, CliCve, CliNom, Feulco, DiasPr,
                   DiaSco, Canu12, Monu12, Canu24, MonU24,
                   VarCan, PorCan, TenCli, Estado)
             Select :SupCve, :SupNom, :VenCve, :VenNom, :ClaCve,
                    :ClaDes, :CliCve, :CliNom, :FeulCo, :DiasPr,
                    :DiaSco, :CanU12, :MonU12, :CanU24, :MonU24,
                    :VarCan, :PorCan, :TenCli, :Estado
               From Sysibm/Sysdummy1
                Where Not Exists (
                        Select 1
                           From Fac3204
                          Where (SupCve = :SupCve)
                            And (VenCve = :VenCve)
                            And (ClaCve = :ClaCve)
                            And (CliCve = :CliCve)) ;

           SqlCod = *Zeros ;

           EndDo ;

           Exec Sql
           Close c1;

           SqlCod = *Zeros ;
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

           SqlCod = *Zeros ;

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
               PromDias      Dec(7,2),
               Cantidad12    Dec(12,2),
               Monto12       Dec(15,2),
               CantidadPrev12 Dec(12,2),
               Monto12Prev   Dec(15,2));

           SqlCod = *Zeros ;

        //Tabla temporal dias promedio de compras
           Exec Sql
           Create Table Qtemp/Promdias (
               CliCve Dec(7,0),
               PromDias Dec(7,2)) ;

           SqlCod = *Zeros ;

           EndSr ;
        // ------------------------------------------------------
        // Borrar Tabla Temporal                                -
        // ------------------------------------------------------
           Begsr Borrar_Tabla  ;

           Exec Sql
           Drop Table Qtemp/Churnwk  ;

           SqlCod = *Zeros ;

           Exec Sql
           Drop Table Qtemp/Promdias ;

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

        // Borrar la Tabla
           Exec Sql
               Delete From Fac3204
                 With NC;

        // Borrar la Tabla
           Exec Sql
               Delete From Fac3204RV
                 With NC;

           EndSr;
      /End-Free
        // -----------------------------------------------------
