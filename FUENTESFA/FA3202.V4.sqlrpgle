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
     fFacDpf01  Uf a e           k Disk
      *
     d FecIngIso       s               d   DatFmt(*Iso)
     d FecDocIso       s               d   DatFmt(*Iso)
     d FecAntDoc       s               d   DatFmt(*Iso)
     d FechaIso        s               d   DatFmt(*Iso)
     d FechaIni        s               d   DatFmt(*Iso)
     d FechaDia        s               d   DatFmt(*Iso)
      *
     d Status          s               n   Inz(*Off)
     d MesesTra        s             10  0 Inz(*Zeros)
     d FechaInicio     s              8s 0 Inz(20210101)
     d CreTst          s                   Like(SqlCxcCli.CreTst)
     d ArtCve          s                   Like(SqlInvArt.ArtCve)
     d CliCve          s                   Like(SqlfacDtod.CliCve)
     d CodCli          s                   Like(SqlfacDtod.CliCve)
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
     d PrimerReg       s               n   Inz(*Off)
      *
     dSqlFacDpf      e Ds                  ExtName(FacDpf) Qualified
     dSqlInvArt      e Ds                  ExtName(InvArt) Qualified
     dSqlFacDtod     e Ds                  ExtName(FacDtod) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
     dSqlCxcCli      e Ds                  ExtName(CxcCli) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
      * Borrar los registros al inicio del proceso
     c                   Exsr      Borrar_Arc
     c                   Exsr      Limpiar_Campos
      * Proceso Seleccion Datos
     c                   Exsr      Proceso
     c                   Exsr      BorrarDoc
     c                   Exsr      ActualizaFre
    *  Para Copiar el Presupuesto de clientes Migrado
     c                   If        Status = *On
     c                   Exsr      Copia_Presu
     c                   EndIf
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccionar datos                                        *
      * ----------------------------------------------------------*
     c     Proceso       BegSr
     c                   Clear                   Dds1
     c                   Clear                   Dds2
      *
     c                   Eval      PrimerReg = *On
      *
     c/Exec Sql
     c+   Declare C1 cursor for
     c+      Select T1.CliCve, T1.ArtCve, T1.DisCve, T1.DtoTip, T1.DtoNro,
     c+             T9.FecIso, Sum(T1.DtoCan), Sum(T1.DtoCua), T2.CreTst
     c+             From FacDtod T1
     c+  Left Outer Join CxcCli T2 On(T1.CliCve = T2.CliCve)
     c+  Left Outer Join InvArt T3 On(T1.ArtCve = T3.ArtCve)
     c+  Left Outer Join SegDis T4 On(T1.DisCve = T4.DisCve)
     c+             Join SegFec T9
     c+               On (T1.DtoAno = T9.FecAno)
     c+              And (T1.DtoMes = T9.FecMes)
     c+              And (T1.DtoDia = T9.FecDia)
     c+            Where (T1.DtoTip In(1, 4, 6))
     c+              And (T3.ArtPpr = 'S')
     c+              And (T3.ArtSta = 'A')
     c+              And (T9.FecIso >= Date(T2.CreTst))
     c+              And (T4.DisTip = 'N')
     c+    Group By T1.CliCve, T1.ArtCve, T1.DisCve, T1.DtoTip, T1.DtoNro,
     c+             T9.FecIso, T2.CreTst
     c+    Order By T1.CliCve, T1.ArtCve, T1.DisCve, T1.DtoTip, T1.DtoNro,
     c+             T9.FecIso
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 Into :CliCve, :ArtCve, :DisCve, :DtoTip, :DtoNro,
     c+                       :DtoFec, :DtoCan, :DtoCua, :CreTst
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      * Si desea imprimir el reporte de registros seleccionados
     c                   Eval      Dds1 = %Editc(CliCve:'X') +
     c                                    %Trim(ArtCve)
      *
     c                   Eval      ImpCli = *Off
      * Verificar la ruptura de control
     c                   If        Dds1 <> Dds2
      * Verificar Cambio el cliente y el Producto
     c                   If        %Subst(Dds1:1:27) <> %Subst(Dds2:1:27)
     c                   Eval      ImpCli = *On
     c                   Eval      FecIngIso = %Date(CreTst)
     c                   EndIf
      *
     c                   Eval      Dds2 = Dds1
     c                   EndIf
      *
     c                   Eval      FecDocIso = DtoFec
      *
     c                   If        ImpCli = *On
     c                   Eval      FechaIso = FecIngIso
     c                   Else
     c                   Eval      FechaIso = FecAntDoc
     c                   EndIf
      *
     c                   Eval      DpfDtf = %Diff(FecDocIso :FechaIso :*Days)
      *
     c                   Write     FacDpff
     c                   Eval      FecAntDoc = DtoFec
     c                   Clear                   FacDpff
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C1
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------*
      *  Seleccionar Los Clientes con mas de XX facturas          *
      * ----------------------------------------------------------*
     c     BorrarDoc     BegSr
      *
     c/Exec Sql
     c+   Declare C2 Cursor for
     c+      Select CliCve, ArtCve, Count(*)
     c+        From FacDpf
     c+    Group By CliCve, ArtCve
     c+   Having Count(*) > :CanFac
     c+    Order By CliCve, ArtCve
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C2
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C2 Into :CodCli, :CodArt, :CanReg
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      *
     c                   Exsr      Borrar_Reg
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C2
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------*
      *  Borrar Todas las Facturas que pasen de XX                *
      * ----------------------------------------------------------*
     c     Borrar_Reg    BegSr
      *
     c                   Clear                   ContReg
      *
     c/Exec Sql
     c+   Declare C3 Cursor for
     c+      Select *
     c+        From FacDpf
     c+       Where (CliCve = :CodCli)
     c+         And (ArtCve = :CodArt)
     c+    Order By CliCve, ArtCve, DtoFec Desc
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C3
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C3 Into :SqlFacDpf
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      *
     c                   Eval      ContReg += 1
      * Borrar los documentos que pasen de XX
     c                   If        ContReg > CanFac
     c/Exec Sql
     c+   Delete FacDpf
     c+    Where (CliCve = :SqlFacDpf.CliCve)
     c+      And (ArtCve = :SqlFacDpf.ArtCve)
     c+      And (DisCve = :SqlFacDpf.DisCve)
     c+      And (DtoTip = :SqlFacDpf.DtoTip)
     c+      And (DtoNro = :SqlFacDpf.DtoNro)
     c+      And (DtoFec = :SqlFacDpf.DtoFec)
     c+  With NC
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndIf
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C3
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
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
      * ----------------------------------------------------------*
      *  Borrar Registros                                         *
      * ----------------------------------------------------------*
     c     Borrar_Arc    BegSr
      *
     c/Exec Sql
     c+   Delete FacDpf
     c+  With NC
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Ejecutar Programa Para Copiar Presupesto Clientes Migrado*
      * ----------------------------------------------------------*
     c     Copia_Presu   BegSr
      *
     c                   Call      'FA3299'
      *
     c                   EndSr
      * ----------------------------------------------------------*
      *  Limpiar Los campos                                       *
      * ----------------------------------------------------------*
     c     Limpiar_CamposBegSr
      *
     c/Exec Sql
     c+   Update FacCpc Set CpcCdd = 0, CpcCvp = 0
     c+  With NC
     c/End-Exec
     c                   EndSr
L005  /Free
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
       BegSr *Inzsr;

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
