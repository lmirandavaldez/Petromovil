     h   Copyright ('Miranda Valdez, S. A., 1997')
     H   DEBUG OPTION(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA1064                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 04 / 09 / 2012                   *
      *  DESCR:                                                          *
      *        Listado comparativo cuota & ventas x cliente y vendedor   *
      *  ================================================================*
     fCxcVen01  If   e           k Disk
     fCxcCli01  If   e           k Disk
     fSegDis01  If   e           k Disk
     fInvArt01  If   e           k Disk
     fFAC1064   Uf a e             Disk
     fFA1064PT  O    e             Printer Oflind(*In66) UsrOpn
      *
     d Dds1            s             50    Inz(*Blanks)
     d Dds2            s             50    Inz(*Blanks)
     d Mes             s              7  0 Inz(*Zeros)
     d ImpN01          s               n   Inz(*Off)
     d ImpN02          s               n   Inz(*Off)
     d PrimerReg       s               n   Inz(*Off)
     d PrimerRegl1     s               n   Inz(*Off)
      *
     d FechaIso        s               d   Datfmt(*Iso)
     d FechaDesIso     s               d   Datfmt(*Iso)
     d FechaHasIso     s               d   Datfmt(*Iso)
     d FechaEur        s               d   Datfmt(*Eur)
      *
     dSqlCxcCli02jn  e Ds                  ExtName(CxcCli02Jn)
     dSqlFacDtod01   e Ds                  ExtName(FacDtod01) Prefix(X_)
     dSqlFac1064a    e Ds                  ExtName(Fac1064a) Qualified
      *
      /Copy Fuentes,SG9001
      *---------------------------------------------------------
      *               Inicio del Programa                      -
      *---------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    CodDis            3
     c                   Parm                    CodVen            3
     c                   Parm                    CodCli            7
     c                   Parm                    FecDes            8
     c                   Parm                    FecHas            8
      *
     c     *Like         Define    DisCve        DisCod
     c     *Like         Define    VenCve        VenCod
     c     *Like         Define    CliCve        CliCod
     c     *Like         Define    X_DtoFec      FechaD
     c     *Like         Define    X_DtoFec      FechaH
      *
     c                   Eval      DisCod = %Dec(CodDis:3:0)
     c                   Eval      VenCod = %Dec(CodVen:3:0)
     c                   Eval      CliCod = %Dec(CodCli:7:0)
     c                   Eval      FechaD = %Dec(FecDes:8:0)
     c                   Eval      FechaH = %Dec(FecHas:8:0)
      *
     c                   Eval      FechaDesIso = %Date(%Dec(FecDes:8:0))
     c                   Eval      FechaEur = FechaDesIso
     c                   Eval      FechaDes = %Dec(FechaEur:*Eur)
      *
     c                   Eval      FechaHasIso = %Date(%Dec(FecHas:8:0))
     c                   Eval      FechaEur = FechaHasIso
     c                   Eval      FechaHas = %Dec(FechaEur:*Eur)
      *
     c                   Eval      Mes = %Diff(FechaHasIso:FechaDesIso:*Months)
     c                   Eval      Mes += 1
      *
     c                   If        Mes = *Zeros
     c                   Eval      Mes = 1
     c                   EndIf
      *
      * Proceso de Reporte
     c                   Exsr      Proceso
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccion de Registros                                   *
      * ----------------------------------------------------------*
     c     Proceso       BegSr
     c                   Clear                   SqlCod
      *
     c                   Clear                   Dds1
     c                   Clear                   Dds2
     c                   Open      FA1064pt
     c
     c                   Eval      PrimerReg = *On
     c                   Eval      PrimerRegl1 = *On
      *
     c/Exec Sql
     c+   Declare C1 cursor for
     c+   Select T1.DisCve, T1.VenCve, T1.CliCve, T2.ArtCve, Sum(T2.DtoCan)
     c+    From CxcCli02jn T1
     c+    Join FacDtod01 T2 On (T1.CliCve = T2.CliCve)
     c+    Join Fac1064a T3 On (T1.CliCve = T3.CliCve)
     c+   Where (T1.DisCve = :DisCod Or :DisCod = 0)
     c+     And (T1.VenCve = :VenCod Or :VenCod = 0)
     c+     And (T1.CliCve = :CliCod Or :CliCod = 0)
     c+     And (T1.CliSta = 'A')
     c+     And (T3.FecIng Between :FechaDesIso And :FechaHasIso)
     c+     And (T2.DtoFec Between :FechaD And :FechaH)
     c+   Group by T1.DisCve, T1.VenCve, T1.CliCve, T2.ArtCve
     c+   Order by T1.DisCve, T1.VenCve, T1.CliCve, T2.ArtCve
     c+   For Read Only
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
     c*                  Clear                   ContaLr
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 Into :DisCve, :VenCve, :CliCve, :ArtCve, :DtoCan
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   EndIf
      * Si desea imprimir el reporte de registros seleccionados
     c                   Eval      Dds1 = %Editc(DisCve:'X') +
     c                             %Trim(%Editc(VenCve:'X')) +
     c                             %Trim(%Editc(CliCve:'X'))
      *
     c                   Eval      ImpN01 = *Off
     c                   Eval      ImpN02 = *Off
      * Verificar la ruptura de control
     c                   If        Dds1 <> Dds2
      * Verificar si cambio el Distrito y el vendedor
     c                   If        %Subst(Dds1:1:6) <> %Subst(Dds2:1:6)
     c                   Eval      ImpN01 = *On
     c                   Eval      ImpN02 = *On
     c     DisCve        Chain     SegDisf                            55
     c     VenCve        Chain(n)  CxcVenf                            55
     c                   EndIf
      *
      * Verificar Si cambio el cliente
     c                   If        %Subst(Dds1:1:13) <> %Subst(Dds2:1:13)
     c     CliCve        Chain(n)  CxcClif                            55
     c                   Eval      NomCli = %Subst(CliNom:1:38)
      *
      * Buscar la fecha de Ingreso archivo temporal
     c/Exec Sql
     c+   Select * Into :SqlFac1064a
     c+     From Fac1064a
     c+    Where (CliCve = :CliCve)
     c/End-Exec
     c                   Clear                   SqlCod
        FecIng = %Dec(SqlFac1064a.FecIng:*Eur)  ;
     c                   Eval      ImpN02 = *On
     c                   EndIf
      *
     c                   Eval      Dds2 = Dds1
     c                   EndIf
      * Imprimir Total por Cliente
     c                   If        ImpN02 And Not PrimerReg
     c                   Write     Total1
     c                   Clear                   ContaL1
     c                   Clear                   DtoCanL1
     c                   EndIf
      * Imprimir Total por Vendedor
     c                   If        ImpN01 And Not PrimerReg
     c                   Write     Total2
     c                   Clear                   Contal2
     c                   Clear                   DtoCanL2
     c                   EndIf
      * Imprimir el cabecera
     c                   If        ImpN01 = *On or *In66 = *on
     c                   Write     Header
     c                   Eval      ImpN02 = *On
     c                   Eval      *In66 = *Off
     c                   EndIf
      * Imprime Detalle L1
     c                   If        PrimerRegL1 Or ImpN02
     c                   Write     Detail1
     c                   EndIf
      *
     c     ArtCve        Chain(n)  InvArtf                            55
     c                   Eval      CodArt = %Subst(ArtCve:1:6)
     c                   Eval      DesArt = %Subst(ArtDes:1:32)

       IngIso = SqlFac1064a.FecIng  ;
     c                   Write     Detail
     c                   Write     Fac1064f
      *
     c                   Eval      PrimerReg = *Off
     c                   Eval      PrimerRegl1 = *Off
     c                   Eval      Contal1 += 1
     c                   Eval      DtoCanL1 += DtoCan
     c                   Eval      Contal2 += 1
     c                   Eval      DtoCanL2 += DtoCan
     c                   Eval      ContaLr += 1
     c                   Eval      DtoCanLr += DtoCan
      *
     c                   EndDo
      *
     c                   If        Contal1 > *Zeros
     c                   Write     Total1
     c                   EndIf
      *
     c                   If        Contal2 > *Zeros
     c                   Write     Total2
     c                   EndIf
      *
     c                   If        ContaLr > *Zeros
     c                   Write     Totalr
     c                   EndIf
      *
     c/Exec SQL
     c+    Close C1
     c/End-exec
     c                   Close     FA1064pt
     c                   EndSr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        BegSr
     c                   Call      'FA1064A'

        // Borrar el Archivo
          Exec Sql
               Delete From FAC1064
                 With NC;

     c                   EndSr
