     h   Copyright ('Miranda Valdez, S. A., 2005')
     h   Datedit(*Dmy)
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3201                           *
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
      *
     d Dds1            s             50    Inz(*Blanks)
     d Dds2            s             50    Inz(*Blanks)
     d ContReg         s             10  0 Inz(*Zeros)
     d RfdCdd          s                   Like(SqlFacRfd.RfdCdd)
     d DiasPromedio    s                   Like(SqlFacDpf.DpfDtf)
     d CreTst          s                   Like(SqlCxcCli.CreTst)
     d ImpCli          s               n   Inz(*Off)
     d PrimerReg       s               n   Inz(*Off)
      *
     dSqlFacDpf      e Ds                  ExtName(FacDpf) Qualified
     dSqlInvArt      e Ds                  ExtName(InvArt) Qualified
     dSqlCxcCli      e Ds                  ExtName(CxcCli) Qualified
     dSqlFacDtod     e Ds                  ExtName(FacDtod) Qualified
     dSqlFacRfd      e Ds                  ExtName(FacRfd) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
      /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
      * Borrar los registros al inicio del proceso
     c                   Exsr      Borrar_Reg
      * Proceso Seleccion Datos
     c                   Exsr      Proceso
     c                   Exsr      BorrarDoc
     c                   Exsr      ActualizaFre
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
     c+      Select T1.CliCve, T1.DisCve, T1.DtoTip, T1.DtoNro, T9.FecIso,
     c+             Sum(T1.DtoCan), Sum(T1.DtoCua), T2.CreTst
     c+             From FacDtod T1
     c+  Left Outer Join CxcCli T2 On(T1.CliCve = T2.CliCve)
     c+  Left Outer Join InvArt T3 On(T1.ArtCve = T3.ArtCve)
     c+  Left Outer Join SegDis T4 On(T1.DisCve = T4.DisCve)
     c+             Join SegFec T9
     c+               On (T1.DtoAno = T9.FecAno)
     c+              And (T1.DtoMes = T9.FecMes)
     c+              And (T1.DtoDia = T9.FecDia)
     c+            Where (T1.DtoTip In (1, 2))
     c+              And (T3.ArtPpr = 'S')
     c+              And (T3.ArtSta = 'A')
     c+              And (T4.DisTip = 'N')
     c+              And (T9.FecIso >= Date(T2.CreTst))
     c+    Group By T1.CliCve, T1.DisCve, T1.DtoTip, T1.DtoNro, T9.FecIso,
     c+             T2.CreTst
     c+    Order By T1.CliCve, T1.DisCve, T1.DtoTip, T1.DtoNro, T9.FecIso
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 Into :CliCve, :DisCve, :DtoTip, :DtoNro, :DtoFec,
     c+                       :DtoCan, :DtoCua, :CreTst
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      * Si desea imprimir el reporte de registros seleccionados
     c                   Eval      Dds1 = %Editc(CliCve:'X')
      *
     c                   Eval      ImpCli = *Off
      * Verificar la ruptura de control
     c                   If        Dds1 <> Dds2
      * Verificar Cambio el cliente y el Producto
     c                   If        %Subst(Dds1:1:7) <> %Subst(Dds2:1:7)
     c                   Eval      ImpCli = *On
          FecIngIso = %Date(CreTst)         ;

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
      *  Borrar Todas las Facturas que pasen de 20                *
      * ----------------------------------------------------------*
     c     BorrarDoc     BegSr
     c                   Clear                   Dds1
     c                   Clear                   Dds2
      *
     c                   Eval      PrimerReg = *On
      *
     c/Exec Sql
     c+   Declare C2 Cursor for
     c+      Select *
     c+        From FacDpf
     c+    Order By CliCve, DtoFec Desc
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C2
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C2 Into :SqlFacDpf
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      * Si desea imprimir el reporte de registros seleccionados
     c                   Eval      Dds1 = %Editc(SqlFacDpf.CliCve:'X')
      *
     c                   Eval      ImpCli = *Off
      * Verificar la ruptura de control
     c                   If        Dds1 <> Dds2
      * Verificar Cambio el cliente
     c                   If        %Subst(Dds1:1:7) <> %Subst(Dds2:1:7)
     c                   Eval      ImpCli = *On
     c                   Clear                   ContReg
     c                   EndIf
      *
     c                   Eval      Dds2 = Dds1
     c                   EndIf
      *
     c                   Eval      ContReg += 1
      * Borrar los documentos que pasen de 25
     c                   If        ContReg > 25
     c/Exec Sql
     c+   Delete FacDpf
     c+    Where (CliCve = :SqlFacDpf.CliCve)
     c+      And (DisCve = :SqlFacDpf.DisCve)
     c+      And (DtoTip = :SqlFacDpf.DtoTip)
     c+      And (DtoNro = :SqlFacDpf.DtoNro)
     c+      And (DtoFec = :SqlFacDpf.DtoFec)
     c*  With NC
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndIf
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C2
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Actualizar la Frecuencia de Compra                       *
      * ----------------------------------------------------------*
     c     ActualizaFre  BegSr
      *
     c/Exec Sql
     c+   Declare C3 Cursor for
     c+      Select CliCve, Count(*), Avg(DpfDtf)
     c+        From FacDpf
     c+    Group By CliCve
     c+    Order By CliCve
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C3
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C3 Into :CliCve, :ContReg, :DiasPromedio
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif

        // Buscar Datos de la Moneda
          Clear RfdCdd ;
          Exec Sql
             Select RfdCdd Into :RfdCdd
               From FacRfd
              Where (:ContReg Between RfdMir And RfdMar)
                And (:DiasPromedio Between RfdMid And RfdMad)
              Fetch First 1 Row Only;

          SqlCod = *Zeros ;

        // Actualizar la Frecuencia de Compra
          Exec Sql
             Update CxcDgc Set DgcCdd = :RfdCdd
              Where (CliCve = :CliCve)     ;
         //   With NC                       ;

          SqlCod = *Zeros ;

     c                   EndDo
      *
     c/Exec SQL
     c+    Close C3
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------*
      *  Borrar Registros                                         *
      * ----------------------------------------------------------*
     c     Borrar_Reg    BegSr
      *
     c/Exec Sql
     c+   Delete FacDpf
     c*  With NC
     c/End-Exec
     c                   EndSr
      * -----------------------------------------------------------
