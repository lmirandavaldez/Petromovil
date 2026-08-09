     h   Copyright ('Miranda Valdez, S. A., 2005')
     h   Datedit(*Dmy)
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3202                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 26 / 09 / 2017                   *
      *  DESCR:                                                          *
      *         Calcular los Dias Promedio entre facturas                *
      *==================================================================*
     d FecIngIso       s               d   DatFmt(*Iso)
     d FecDocIso       s               d   DatFmt(*Iso)
     d FecAntDoc       s               d   DatFmt(*Iso)
     d FechaIso        s               d   DatFmt(*Iso)
     d FechaIni        s               d   DatFmt(*Iso)
     d FechaDia        s               d   DatFmt(*Iso)
      *
     d FechaIniTst     s                   Like(SqlCxcCli.CreTst)
     d FechaFinTst     s                   Like(SqlCxcCli.CreTst)
     d Minutos         s             10  0 Inz(*Zeros)
      *
     d Status          s               n   Inz(*Off)
     d MesesTra        s             10  0 Inz(*Zeros)
     d FechaInicio     s              8s 0 Inz(20210101)
     d CanFac          s              5  0 Inz(25)
      *
      **Archivos Externos
     dSqlFacDpf      e Ds                  ExtName(FacDpf) Qualified
     dSqlInvArt      e Ds                  ExtName(InvArt) Qualified
     dSqlFacDtod     e Ds                  ExtName(FacDtod) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
     dSqlCxcCli      e Ds                  ExtName(CxcCli) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Copiar Presupesto Clientes Migrados
     d ClientesMig     Pr                  ExtPgm('FA3299')
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------

        // Borrar los registros al inicio del proceso
           Exsr Borrar_Arc   ;
           Exsr Limpiar_Campos ;

        // Proceso Seleccion Datos
           Exsr Proceso ;
           Exsr BorrarDoc ;
           Exsr ActualizaFre ;

        //Para Copiar el Presupuesto de clientes Migrado
           If Status = *On ;
              Exsr Copia_Presu ;
           EndIf  ;

           Exsr EndProgram;
        // ------------------------------------------------------
        // Seleccionar Registros para Procesar                  -
        // ------------------------------------------------------
           Begsr Proceso       ;

           Exec Sql
           Insert Into FacDpf
               (CliCve, DisCve, DtoTip, DtoNro,
                DtoCan, DtoCua, DtoFec, ArtCve, DpfDtf)
            With Mov As (
                Select
                    T1.CliCve,
                    T1.ArtCve,
                    T1.DisCve,
                    T1.DtoTip,
                    T1.DtoNro,
                    T9.FecIso as DtoFec,
                    Sum(T1.DtoCan) as DtoCan,
                    Sum(T1.DtoCua) as DtoCua,
                    T2.CreTst,
                    Lag(T9.FecIso) Over (
                        Partition By T1.CliCve, T1.ArtCve
                         Order By T9.FecIso
                            ) as FecAnt
                  From FacDtod T1
             Left Join CxcCli T2
                    On T1.CliCve = T2.CliCve
             Left Join InvArt T3
                    On T1.ArtCve = T3.ArtCve
             Left Join SegDis T4
                    On T1.DisCve = T4.DisCve
                  Join SegFec T9
                    On T1.DtoAno = T9.FecAno
                   And T1.DtoMes = T9.FecMes
                   And T1.DtoDia = T9.FecDia
                 Where T1.DtoTip In (1,4,6)
                   And T3.ArtPpr = 'S'
                   And T3.ArtSta = 'A'
                   And T9.FecIso >= Date(T2.CreTst)
                   And T4.DisTip = 'N'
              Group By T1.CliCve,
                       T1.ArtCve,
                       T1.DisCve,
                       T1.DtoTip,
                       T1.DtoNro,
                       T9.FecIso,
                       T2.CreTst)
                Select CliCve,
                       DisCve,
                       DtoTip,
                       DtoNro,
                       DtoCan,
                       DtoCua,
                       DtoFec,
                       ArtCve,
                  Case When FecAnt Is Null
                       Then Days(DtoFec) - Days(Date(CreTst))
                        Else Days(DtoFec) - Days(FecAnt)
                        End As DpfDtf
                  From Mov M
                 Where Not Exists (
                       Select 1
                         From FacDpf F
                        Where F.CliCve = M.CliCve
                          And F.DisCve = M.DisCve
                          And F.DtoTip = M.DtoTip
                          And F.DtoNro = M.DtoNro
                          And F.ArtCve = M.ArtCve
                          And F.DtoFec = M.DtoFec);

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Seleccionar Los Clientes con mas de XX facturas      -
        // ------------------------------------------------------
           Begsr BorrarDoc     ;

           Exec Sql
           Delete From FacDpf
            Where (CliCve, DisCve, DtoTip, DtoNro, ArtCve, DtoFec) In
            (Select CliCve, DisCve, DtoTip, DtoNro, ArtCve, DtoFec
               From (Select
                     CliCve,
                     DisCve,
                     DtoTip,
                     DtoNro,
                     ArtCve,
                     DtoFec,
                     Row_Number() Over (
                     Partition By CliCve, ArtCve
                      Order By DtoFec Desc) As RN
               From FacDpf) X
              Where RN > :CanFac);

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Actualizar la Frecuencia de Compra                   -
        // ------------------------------------------------------
           Begsr ActualizaFre  ;

           Exec Sql
           Merge Into FacCpc As T1
            Using (
                Select
                CliCve,
                ArtCve,
           Case
               When Count(*) < 4 And Avg(DpfDtf) < 30 Then 30
               When Count(*) < 4 And Avg(DpfDtf) > 90 Then 30
               When Count(*) > 3 And Avg(DpfDtf) < 1  Then 7
               When Count(*) > 3 And Avg(DpfDtf) Between 1  And 20 Then 15
               When Count(*) > 3 And Avg(DpfDtf) Between 21 And 30 Then 25
               When Count(*) > 3 And Avg(DpfDtf) Between 31 And 40 Then 35
               When Count(*) > 3 And Avg(DpfDtf) Between 41 And 50 Then 45
               When Count(*) > 3 And Avg(DpfDtf) Between 51 And 60 Then 55
               When Count(*) > 3 And Avg(DpfDtf) Between 61 And 90 Then 75
               Else 120
           End As Dias,
           Avg(DtoCan) As Cant
            From FacDpf
            Group By CliCve, ArtCve
                ) As T2 (CliCve, ArtCve, Dias, Cant)
            On T1.CliCve = T2.CliCve
            And T1.ArtCve = T2.ArtCve
            When Matched Then
            Update Set
                  CpcCdd = T2.Dias,
                  CpcCvp = T2.Cant
            When Not Matched Then
            Insert (CliCve, ArtCve, CpcCvc, CpcCvm, CpcCvt, CpcCdd, CpcCvp)
            Values (T2.CliCve, T2.ArtCve, 0, 0, 0, T2.Dias, T2.Cant);

           SqlCod = *Zeros ;
           EndSr ;
        // -----------------------------------------------------
        // Borrar Registros                                    -
        // -----------------------------------------------------
           Begsr Borrar_Arc  ;

           Exec Sql
              Delete FacDpf  ;

           EndSr ;
        // -----------------------------------------------------
        // Para Copiar Presupesto Clientes Migrado             -
        // -----------------------------------------------------
           Begsr Copia_Presu ;

           ClientesMig( );

           EndSr ;
        // -----------------------------------------------------
        // Limpiar Los campos                                  -
        // -----------------------------------------------------
           Begsr Limpiar_Campos ;

           Exec Sql
              Update FacCpc Set CpcCdd = 0, CpcCvp = 0  ;

           Endsr;
        // -----------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
           Begsr EndProgram;
           FechaFinTst = %TimeStamp()  ;

            Minutos = %Diff(FechaFinTst : FechaIniTst : *Minutes);

           *Inlr = *On;
           Return;

           Endsr;
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
           BegSr *Inzsr;
           FechaIniTst = %TimeStamp()  ;

           FechaIni = %Date(FechaInicio:*Iso)      ;
           FechaDia = %Date(*Date)  ;
           MesesTra = %Diff(FechaDia:FechaIni:*Months);

        //Si transcurrieron 12 Meses significa que tiene hitoria en Petromovil

           If MesesTra < 12   ;
              Status = *On     ;
            Else ;
              Status = *Off    ;
           EndIf;

           EndSr;
      /End-Free
       // ----------------------------------------------------------
