     h   Copyright ('Miranda Valdez, S. A., 2005')
     h   Datedit(*Dmy)
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA1055                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 04 / 09 / 2009                   *
      *  DESCR:                                                          *
      *         De Clientes con Pedidos Sugeridos                        *
      *==================================================================*
     fCxcVen01  If   e           k disk
     fCxcCli01  If   e           k disk
     fInvCat01  If   e           k disk
     fFacDto08jnIf   e           k disk
     fFacCpc01  If   e           k disk    Prefix(I_)
     fCxcDgc01  If   e           k Disk    Prefix(X_)
     fAcfAfi08  If   e           k Disk    Prefix(T_)
     fFA1055pt  o    e             Printer Oflind(*In66) UsrOpn
      *
     d FecDiaIso       s               d   DatFmt(*Iso)
     d FecDocIso       s               d   DatFmt(*Iso)
     d FechaEur        s               d   DatFmt(*Eur)
      *
     d Dds1            s             50    Inz(*Blanks)
     d Dds2            s             50    Inz(*Blanks)
     d ImpVen          s               n   Inz(*Off)
     d PrimerReg       s               n   Inz(*Off)
      *
      /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    CodDis            2
     c                   Parm                    CodVen            3
     c                   Parm                    CodCat            4
     c                   Parm                    FechaH            8
      *
     c     Clave_Cpc     Klist
     c                   Kfld                    CodCli
     c                   Kfld                    ArtCve
      *
     c     *Like         Define    DtoFec        FechaHasta
     c     *Like         Define    VenCve        CveVen
     c     *Like         Define    VenCve        VenCon
     c     *Like         Define    VenCve        VenCod
     c     *Like         Define    DisCve        DisCod
     c     *Like         Define    CatCve        Catego
      *
     c                   Clear                   DtoFec
     c                   Clear                   DtoCan
      *
     c                   Eval      DisCod = %Dec(CodDis:2:0)
     c                   Eval      VenCod = %Dec(CodVen:3:0)
     c                   Eval      Catego = %Dec(CodCat:3:0)
     c                   Eval      FechaHasta = %Dec(FechaH:8:0)
     c                   Eval      FecHas = %Dec(%Date(FechaHasta:*Iso):*Eur)
      *
     c                   Exsr      Proceso
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccionar informacion a transferir                     *
      * ----------------------------------------------------------*
     c     Proceso       BegSr
     c                   Clear                   Dds1
     c                   Clear                   Dds2
     c                   Open      FA1055pt
      *
     c                   Eval      PrimerReg = *On
      *
     c/Exec Sql
     c+   Declare C1 cursor for
     c+       Select
     c+             T1.VenCve, T2.CatCve, T1.CliCve, Max(T2.DtoFec)
     c+       From
     c+             CxcCli02jn T1,
     c+             FacDto08jn T2,
     c+             CxcVen01 T3
     c+       Where
     c+             (T1.CliSta = 'A') And
     c+             (T1.AdcDcr <> 998) And
     c+             (T2.ArtPpr = 'S') And
     c+             (T1.CliCve = T2.CliCve) And
     c+             (T1.VenCve = T3.VenCve) And
     c+             (T2.DtoTip = 1 Or T2.DtoTip > 3) And
     c+             (T3.VenSta <> 'S') And
     c+             (:DisCod = T2.DisCve Or :DisCod = 0) And
     c+             (:Catego = T2.CatCve Or :Catego = 0) And
     c+             (:VenCod = T1.VenCve Or :VenCod = 0)
     c+       Group By
     c+             T1.VenCve, T2.CatCve, T1.CliCve
     c+       Having
     c+             Max(T2.DtoFec) <= :FechaHasta
     c+       Order By
     c+             T1.VenCve, T2.CatCve, T1.CliCve
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
     c                   Clear                   CanVen
      *
     c                   Dow       SqlCod = 0
     c/Exec Sql Fetch C1 Into :VenCve, :CatCve, :CliCve, :DtoFec
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      * Si desea imprimir el reporte de registros seleccionados
     c                   Eval      Dds1 = %Editc(VenCve:'X') +
     c                                    %Trim(%Editc(CatCve:'X'))
      *
     c                   Eval      ImpVen = *Off
      * Verificar la ruptura de control
     c                   If        Dds1 <> Dds2
      * Verificar si el Vendedor o la Categoria
     c                   If        %Subst(Dds1:1:7) <> %Subst(Dds2:1:7)
     c                   Eval      ImpVen = *On
     c     VenCve        Chain     CxcVenf
     c     CatCve        Chain     InvCatf
     c                   EndIf
      *
     c                   Eval      Dds2 = Dds1
     c                   EndIf
      * Imprimir Total por Vendedor
     c                   If        ImpVen And Not PrimerReg
     c                   Write     TotOfic
     c                   Clear                   TotOfic
     c                   EndIf
      * Imprimir el cabecera
     c                   If        ImpVen = *On or *In66 = *on
     c                   Write     Header
     c                   Eval      *In66 = *Off
     c                   EndIf
      *
     c     *Like         Define    CliCve        CodCli
     c     *Like         Define    CatCve        CatCod
     c     *Like         Define    DtoFec        FechaDoc
      *
     c                   Eval      CatCod = CatCve
     c                   Eval      CodCli = CliCve
     c                   Eval      FechaDoc = DtoFec
      * Para Identificar los clientes que tienen activos asignados
     c     CliCve        Chain     AcfAfi08                           55
     c                   If        %Found(AcfAfi08)
     c                   Eval      *In58 = *On
     c                   Else
     c                   Eval      *In58 = *Off
     c                   EndIf
      *
     c                   Exsr      Detalle
      *
     c     CliCve        Chain     CxcDgcf                            55
     c                   If        %Found(CxcDgc01)
     c                             And X_DgcCdd = *Zeros
     c                   Eval      X_DgcCdd = 15
     c                   EndIf
      *
     c                   Eval      FecDocIso = %Date(DtoFec)
     c                   Eval      FecDiaIso = %Date(FechaHasta)
     c     FecDiaIso     SubDur    FecDocIso     Dias:*d           5 0
      *
     c                   AddDur    X_DgcCdd:*D   FecDocIso
     c     FecDiaIso     SubDur    FecDocIso     Diasult:*d        5 0
      *
     c*                  If        DiasUlt < X_DgcCdd
     c                   If        DiasUlt <= *Zeros
     c                   Iter
     c                   EndIf
      *
     c     CliCve        Chain     CxcClif
     c                   Eval      NomCli = %Trim(CliNom)
      *
     c                   Eval      FecDto = %Dec(%Date(DtoFec:*Iso):*Eur)
      *
     c                   Write     Detail
     c                   Eval      PrimerReg = *Off
     c                   Eval      CanVen += 1
     c                   Clear                   Detail
      *
     c                   EndDo
      *
     c                   Write     TotOfic
     c                   Clear                   TotOfic
      *
     c/Exec SQL
     c+    Close C1
     c/End-Exec
     c                   Close     FA1055pt
     c                   EndSr
      * ----------------------------------------------------------*
      *  Seleccionar Detalle de un Documento                      *
      * ----------------------------------------------------------*
     c     Detalle       BegSr
      *
     c/Exec Sql
     c+   Declare C2 cursor for
     c+       Select DtoCan, ArtCve
     c+         From FacDto08jn
     c+        Where (:CodCli = CliCve) And
     c+              (:CatCod = CatCve) And
     c+              (:FechaDoc = DtoFec)
     c*      With NC
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C2
     c/End-Exec
     c                   Dow       SqlCod = 0
     c/Exec Sql Fetch C2 Into :DtoCan, :ArtCve
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
     c     Clave_Cpc     Chain     FacCpcf                            55
     c                   If        Not %Found(FacCpc01)
     c                             Or I_CpcCvC = *Zeros
     c                   Eval      I_CpcCvc = DtoCan * 1
     c                   EndIf
      *
     c     DtoCan        Mult      1             CanDoc
     c*    DtoCan        Mult      1             CanSug
     c     I_CpcCvc      Mult      1             CanSug
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C2
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
      * -----------------------------------------------------------
