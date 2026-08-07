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
     d CliCve          s                   Like(SqlFacDtod.CliCve)
     d CodCli          s                   Like(SqlFacDtod.CliCve)
     d DisCve          s                   Like(SqlFacDtod.DisCve)
     d DtoTip          s                   Like(SqlFacDtod.DtoTip)
     d DtoNro          s                   Like(SqlFacDtod.DtoNro)
     d DtoFec          s                   Like(SqlSegFec.FecIso)
     d DtoCan          s                   Like(SqlFacDtod.DtoCan)
     d DtoCua          s                   Like(SqlFacDtod.DtoCua)
     d DpfDtf          s                   Like(SqlFacDpf.DpfDtf)
     d CreTst          s                   Like(SqlCxcCli.CreTst)
     d ArtCve          s                   Like(SqlInvArt.ArtCve)
     d CodArt          s                   Like(SqlInvArt.ArtCve)
     d CanReg          s             10  0 Inz(*Zeros)
     d CanFac          s              5  0 Inz(25)
      *
     d Dds1            s             50    Inz(*Blanks)
     d Dds2            s             50    Inz(*Blanks)
     d ContReg         s             10  0 Inz(*Zeros)
     d CanPro          s             12  2 Inz(*Zeros)
     d DiasPromedio    s                   Like(SqlFacDpf.DpfDtf)
     d ImpCli          s               n   Inz(*Off)
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

           Clear Dds1  ;
           Clear Dds2  ;

           Exec Sql
             Declare C1 cursor for
              Select T1.CliCve, T1.ArtCve, T1.DisCve, T1.DtoTip, T1.DtoNro,
                     T9.FecIso, Sum(T1.DtoCan), Sum(T1.DtoCua), T2.CreTst
                From FacDtod T1
                Left Outer Join CxcCli T2 On(T1.CliCve = T2.CliCve)
                Left Outer Join InvArt T3 On(T1.ArtCve = T3.ArtCve)
                Left Outer Join SegDis T4 On(T1.DisCve = T4.DisCve)
                Join SegFec T9
                  On (T1.DtoAno = T9.FecAno)
                 And (T1.DtoMes = T9.FecMes)
                 And (T1.DtoDia = T9.FecDia)
               Where (T1.DtoTip In(1, 4, 6))
                 And (T3.ArtPpr = 'S')
                 And (T3.ArtSta = 'A')
                 And (T9.FecIso >= Date(T2.CreTst))
                 And (T4.DisTip = 'N')
            Group By T1.CliCve, T1.ArtCve, T1.DisCve, T1.DtoTip, T1.DtoNro,
                     T9.FecIso, T2.CreTst
            Order By T1.CliCve, T1.ArtCve, T1.DisCve, T1.DtoTip, T1.DtoNro,
                     T9.FecIso
            For Read Only ;

           Exec Sql
              Open C1  ;
           Dow True;

           Exec Sql
             Fetch Next From c1 Into :CliCve, :ArtCve, :DisCve, :DtoTip,
                                     :DtoNro, :DtoFec, :DtoCan, :DtoCua,
                                     :CreTst                              ;
           If SqlCod <> *Zeros      ;
              Leave;
            EndIf;

        // Control para cuando cambie el cliente y el Producto
           Dds1 = %Editc(CliCve:'X') +
                  %Trim(ArtCve)          ;

           ImpCli = *Off  ;

        // Verificar la ruptura de control
           If Dds1 <> Dds2 ;

        // Verificar Cambio el cliente y el Producto
           If %Subst(Dds1:1:27) <> %Subst(Dds2:1:27) ;
              ImpCli = *On ;
              FecIngIso = %Date(CreTst)  ;
            EndIf   ;

           Dds2 = Dds1  ;
           EndIf  ;

           FecDocIso = DtoFec ;

           If ImpCli = *On   ;
              FechaIso = FecIngIso  ;
            Else  ;
              FechaIso = FecAntDoc  ;
            EndIf  ;

            DpfDtf = %Diff(FecDocIso :FechaIso :*Days)  ;

        // Insertar Registros cuando no existe
            Exec Sql
               Merge Into FacDpf As T1
               Using ( Values(:CliCve, :DisCve, :DtoTip, :DtoNro,
                              :ArtCve, :DtoFec, :DtoCan, :DtoCua, :DpfDtf) )
                     As T2(CliCve, DisCve, DtoTip, DtoNro,
                           ArtCve, DtoFec, DtoCan, DtoCua, DpfDtf)
                  On (T1.CliCve = T2.CliCve)
                 And (T1.DisCve = T2.DisCve)
                 And (T1.DtoTip = T2.DtoTip)
                 And (T1.DtoNro = T2.DtoNro)
                 And (T1.ArtCve = T2.ArtCve)
                 And (T1.DtoFec = T2.DtoFec)
               When Not Matched Then
                    Insert (CliCve, DisCve, DtoTip, DtoNro,
                            DtoCan, DtoCua, DtoFec, ArtCve, DpfDtf)
                    Values (T2.CliCve, T2.DisCve, T2.DtoTip, T2.DtoNro,
                            T2.DtoCan, T2.DtoCua, T2.DtoFec, T2.ArtCve,
                            T2.DpfDtf);
           SqlCod = *Zeros ;

           FecAntDoc = DtoFec  ;

           EndDo ;

           Exec Sql
              Close c1;

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Seleccionar Los Clientes con mas de XX facturas      -
        // ------------------------------------------------------
           Begsr BorrarDoc     ;

           Exec Sql
             Declare C2 Cursor for
              Select CliCve, ArtCve, Count(*)
                From FacDpf
               Group By CliCve, ArtCve
              Having Count(*) > :CanFac
               Order By CliCve, ArtCve
            For Read Only ;

           Exec Sql
              Open C2 ;

           Dow True;

           Exec Sql
             Fetch Next From c2 Into :CodCli, :CodArt, :CanReg        ;

           If SqlCod <> *Zeros      ;
              Leave;
            EndIf;

           Exsr Borrar_Reg  ;

           EndDo ;

           Exec Sql
              Close c2;

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Borrar Todas las Facturas que pasen de XX            -
        // ------------------------------------------------------
           Begsr Borrar_Reg    ;

           Clear ContReg  ;

           Exec Sql
             Declare C3 Cursor for
              Select *
                From FacDpf
               Where (CliCve = :CodCli)
                 And (ArtCve = :CodArt)
            Order By CliCve, ArtCve, DtoFec Desc
            For Read Only ;

           Exec Sql
              Open C3  ;
           Dow True;

           Exec Sql
             Fetch Next From c3 Into :SqlFacDpf                       ;

           If SqlCod <> *Zeros      ;
              Leave;
            EndIf;

           ContReg += 1  ;

        // Borrar los documentos que pasen de XX
           If ContReg > CanFac  ;
           Exec Sql
             Delete FacDpf
              Where (CliCve = :SqlFacDpf.CliCve)
                And (ArtCve = :SqlFacDpf.ArtCve)
                And (DisCve = :SqlFacDpf.DisCve)
                And (DtoTip = :SqlFacDpf.DtoTip)
                And (DtoNro = :SqlFacDpf.DtoNro)
                And (DtoFec = :SqlFacDpf.DtoFec)
               With NC  ;

           SqlCod = *Zeros ;
           EndIf  ;

           EndDo ;

           Exec Sql
              Close c3;

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Actualizar la Frecuencia de Compra                   -
        // ------------------------------------------------------
           Begsr ActualizaFre  ;

        // Leer Tabla
           Exec Sql
              Declare C4 cursor for
                Select CliCve, ArtCve, Count(*), Avg(DpfDtf), Avg(DtoCan)
                  From FacDpf
                 Group By CliCve, ArtCve
                 Order By CliCve, ArtCve
                For Read Only ;

           Exec Sql
             Open c4;

           Dow True;

           Exec Sql
             Fetch Next From c4 Into :CliCve, :ArtCve, :ContReg,
                                     :DiasPromedio, :CanPro       ;

           If SqlCod <> *Zeros      ;
              Leave;
            EndIf;

        //Asignar los dias Promedio de Compra
           Select  ;
             When ContReg < 4 And DiasPromedio < 30  ;
                  DiasPromedio = 30  ;

             When ContReg < 4 And DiasPromedio > 90  ;
                  DiasPromedio = 30  ;

             When ContReg < 4 And DiasPromedio > 90  ;
                  DiasPromedio = 30  ;

             When ContReg > 3 And DiasPromedio < 1   ;
                  DiasPromedio = 07  ;

             When ContReg > 3 And DiasPromedio > 1 And DiasPromedio < 20 ;
                  DiasPromedio = 15  ;

             When ContReg > 3 And DiasPromedio > 21 And DiasPromedio < 30 ;
                  DiasPromedio = 25  ;

             When ContReg > 3 And DiasPromedio > 30 And DiasPromedio < 40 ;
                  DiasPromedio = 35  ;

             When ContReg > 3 And DiasPromedio > 40 And DiasPromedio < 50 ;
                  DiasPromedio = 45  ;

             When ContReg > 3 And DiasPromedio > 50 And DiasPromedio < 60 ;
                  DiasPromedio = 55  ;

             When ContReg > 3 And DiasPromedio > 60 And DiasPromedio < 90 ;
                  DiasPromedio = 75  ;

             When ContReg > 3 And DiasPromedio > 90                       ;
                  DiasPromedio = 120 ;
           EndSl ;

        //Actualizar la Tabla de Cuota Productos Clientes
           Exec Sql
              Merge Into FacCpc As T1
              Using ( Values(:CliCve, :ArtCve, :DiasPromedio, :CanPro) )
                    As T2(CliCve, ArtCve, Dias, Cant)
                 On T1.CliCve = T2.CliCve
                And T1.ArtCve = T2.ArtCve
              When Matched Then
                   Update Set CpcCdd = T2.Dias,
                              CpcCvp = T2.Cant
              When Not Matched Then
                   Insert (CliCve, ArtCve, CpcCvc, CpcCvm, CpcCvt,
                           CpcCdd, CpcCvp)
                   Values (T2.CliCve, T2.ArtCve, 0, 0, 0, T2.Dias, T2.Cant) ;

           SqlCod = *Zeros ;

           EndDo ;

           Exec Sql
              Close c4;

           SqlCod = *Zeros ;
           EndSr ;
        // -----------------------------------------------------
        // Borrar Registros                                    -
        // -----------------------------------------------------
           Begsr Borrar_Arc  ;

           Exec Sql
              Delete FacDpf
              With NC  ;

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
              Update FacCpc Set CpcCdd = 0, CpcCvp = 0
              With NC ;
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
