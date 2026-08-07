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
     fFacCpc01  Uf a e           k disk    Prefix(Y_)
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
      /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
      *
     c     Clave_Cpc     Klist
     c                   Kfld                    CliCve
     c                   Kfld                    ArtCve
      *
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
      * ----------------------------------------------------------*
      *  Actualizar la Frecuencia de Compra                       *
      * ----------------------------------------------------------*
     c     ActualizaFre  BegSr
      *
     c/Exec Sql
     c+   Declare C4 Cursor for
     c+      Select CliCve, ArtCve, Count(*), Avg(DpfDtf), Avg(DtoCan)
     c+        From FacDpf
     c+    Group By CliCve, ArtCve
     c+    Order By CliCve, ArtCve
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C4
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C4 Into :CliCve, :ArtCve, :ContReg, :DiasPromedio,
     c+                       :CanPro
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      *
     c                   Select
     c                   When      ContReg < 4 And DiasPromedio < 30
     c                   Eval      DiasPromedio = 30
      *
     c                   When      ContReg < 4 And DiasPromedio > 90
     c                   Eval      DiasPromedio = 30
      *
     c                   When      ContReg < 4 And DiasPromedio > 90
     c                   Eval      DiasPromedio = 30
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio < 1
     c                   Eval      DiasPromedio = 07
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio > 1 And DiasPromedio < 20
     c                   Eval      DiasPromedio = 15
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio > 21 And DiasPromedio < 30
     c                   Eval      DiasPromedio = 25
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio > 30 And DiasPromedio < 40
     c                   Eval      DiasPromedio = 35
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio > 40 And DiasPromedio < 50
     c                   Eval      DiasPromedio = 45
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio > 50 And DiasPromedio < 60
     c                   Eval      DiasPromedio = 55
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio > 60 And DiasPromedio < 90
     c                   Eval      DiasPromedio = 75
      *
     c                   When      ContReg > 3 And
     c                             DiasPromedio > 90
     c                   Eval      DiasPromedio = 120
     c                   EndSl
      *
     c     Clave_Cpc     Chain     FacCpcf                            55
     c                   If        %Found(FacCpc01)
     c                   Eval      Y_CpcCdd = DiasPromedio * 1
     c                   Eval      Y_CpcCvp = CanPro * 1
     c                   Update    FacCpcf
     c                   Else
     c                   Eval      Y_CliCve = CliCve
     c                   Eval      Y_ArtCve = ArtCve
     c                   Eval      Y_CpcCdd = DiasPromedio * 1
     c                   Eval      Y_CpcCvp = CanPro * 1
     c                   Write     FacCpcf
     c                   EndIf
     c                   Clear                   FacCpcf
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C4
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
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
L005     FechaDia = %Date(*Date)  ;
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
