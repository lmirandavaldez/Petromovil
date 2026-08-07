     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 2005')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: Fa3040                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 13 / 01 / 2009                   *
      *  DESCR:                                                          *
      *         Cambiar fecha por lote a facturas                        *
      *==================================================================*
     fFacDtoH01 Uf   e           k disk
     fFacDtoD01 Uf   e           k disk    Prefix(X_)
     fCxcDocH04 Uf   e           k disk    Prefix(J_)
     fInvTraH01 Uf   e           k disk    Prefix(Y_)
     fInvTraD01 Uf   e           k disk    Prefix(W_)
     fFacPar    If   e           k disk    Prefix(R_)
     fCxcCdo03  If   e           k disk
     fInvTmo01  If   e           k disk    rename(InvTmof:InvTmot)
     fInvTmo03  If   e           k disk
     fCogPer01  If   e           k disk
      *
     d ParCve          s              1    Inz('@')
     d FechaEur        s               d   DatFmt(*Eur)
     d FechaIso        s               d   DatFmt(*Iso)
     d NumDis          s                   Like(DisCve)
     d NumIni          s                   Like(DtoNro)
     d NumFin          s                   Like(DtoNro)
     d NroInicial      s                   Like(DtoNro)
     d NroFinal        s                   Like(DtoNro)
     d FecDes          s                   Like(DtoFec)
     d FecHas          s                   Like(DtoFec)
     d FecNue          s                   Like(DtoFec)
      *
L001  * Parametros
 ''  d Sistema         s              2    inz('FA')
 ''  d CodParametro    s              4  0 inz(*Zeros)
 ''  d ValorNum        s             30 15 inz(*Zeros)
 ''  d ValorAlf        s            100    inz(*Blank)
      *
      /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    NumDis
     c                   Parm                    NumIni
     c                   Parm                    NumFin
     c                   Parm                    FecDes
     c                   Parm                    FecHas
     c                   Parm                    FecNue
      *
     c     Clave_Per     Klist
     c                   Kfld                    PerAno
     c                   Kfld                    PerNum
      *
     c     *Eur          Move      FecDes        FechaIso
     c                   Move      FechaIso      FechaDesde        8 0
      *
     c     *Eur          Move      FecHas        FechaIso
     c                   Move      FechaIso      FechaHasta        8 0
      *
     c     *Eur          Move      FecNue        FechaIso
     c                   Move      FechaIso      FechaReal         8 0
      *
     c                   Eval      NroInicial = NumIni
     c                   Eval      NroFinal =  NumFin
      *
     c                   Exsr      Cabecera
     c                   Exsr      Proceso
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccionar informacion a transferir                     *
      * ----------------------------------------------------------*
     c     Cabecera      BegSr
      *
     c/Exec Sql
     c+       Update FacDtoh01 Set DtoFec = :FechaReal
     c+       Where (DisCve = :NumDis) And
     c+             (DtoNro Between :NroInicial And :NroFinal) And
     c+             (DtoFec BetWeen :FechaDesde And :FechaHasta) And
     c+             (DtoTip = 1 Or DtoTip > 3)
     c*       With NC
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Seleccionar informacion a transferir                     *
      * ----------------------------------------------------------*
     c     Proceso       BegSr
      *
     c/Exec Sql
     c+   Declare C1 cursor for
     c+      Select DtoNro, DtoFec, DisCve, DtoTip, CliCve
     c+        From FacDtoH01
     c+       Where (DisCve = :NumDis) And
     c+             (DtoNro Between :NroInicial And :NroFinal) And
     c*             (DtoFec = :FechaReal) And
     c+             (DtoTip = 1 Or DtoTip > 3)
     c/End-exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-exec
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 into :DtoNro, :DtoFec, :DisCve, :DtoTip, :CliCve
     c/End-exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      *
     c     *Iso          Move      DtoFec        FechaEur
     c                   Move      FechaEur      FecDma            8 0
      *  periodo
     c                   move      FecDma        ProFec            8 0
     c                   Exsr      Periodo
      *
     c                   Exsr      Fact_Detalle
     c                   Exsr      Cxc
     c                   Exsr      Inv
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C1
     c/End-exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Actualizacion Detalle de Facturas                        *
      * ----------------------------------------------------------*
     c     Fact_Detalle  BegSr
      *
     c     Clave_DtoH    Klist
     c                   Kfld                    DisCve
     c                   Kfld                    DtoTip
     c                   Kfld                    DtoNro
      *
     c                   Eval      *In22 = *Off
     c     Clave_DtoH    Setll     FacDtodf
      *
     c                   Dow       Not *In22
     c     Clave_DtoH    Reade     FacDtodf                               22
     c                   If        Not *In22
     c                   Eval      X_DtoFec = DtoFec
     c                   Update    FacDtodf
     c                   EndIf
     c                   EndDo
      *
     c                   EndSr
      * ----------------------------------------------------------*
      *  Actualizacion Cabecera de Ctas. x Cobrar                 *
      * ----------------------------------------------------------*
     c     Cxc           BegSr
      *
     c     R_ParCrf      Chain(n)  CxcCdof                            99
      *
     c     Clave_Doch    Klist
     c                   Kfld                    CliCve
     c                   Kfld                    CdoCve
     c                   Kfld                    DtoNro
     c                   Kfld                    DisCve
      *
     c     Clave_DocH    Chain     CxcDochf                           55
     c                   If        %Found(CxcDoch04)
     c                   Eval      J_PerAno = PerAno
     c                   Eval      J_PerNum = PerNum
     c                   Eval      J_FecDoc = DtoFec
     c                   Eval      J_FecDes = DtoFec
     c                   Update    CxcDochf
     c                   EndIf
      *
     c                   EndSr
      * ----------------------------------------------------------*
      *  Actualizacion Transacciones en Inventarios               *
      * ----------------------------------------------------------*
     c     Inv           BegSr
      * Facturas
     c     R_ParTmf      Chain(n)  InvTmof                            99
      *
     c     Clave_Invh    Klist
     c                   Kfld                    DisCve
     c                   Kfld                    TmoCve
     c                   Kfld                    DtoNro
      *
     c                   Eval      *In22 = *Off
     c     Clave_InvH    Setll     InvTradf
      *
     c                   Dow       Not *In22
     c     Clave_InvH    Reade     InvTradf                               22
     c                   If        Not *In22
     c                   Eval      W_FecAmd = DtoFec
     c                   Update    InvTradf
     c                   EndIf
     c                   EndDo
      *
     c     Clave_InvH    Chain     InvTrahf                           55
     c                   If        %Found(InvTraH01)
     c                   Eval      Y_FecTra = FecDma
     c                   Eval      Y_FecDre = FecDma
     c                   Update    InvTraHf
     c                   EndIf
      * Compras Automaticas
     c     TmoCompras    Chain(n)  InvTmot                            99
      *
     c                   Eval      *In22 = *Off
     c     Clave_InvH    Setll     InvTradf
      *
     c                   Dow       Not *In22
     c     Clave_InvH    Reade     InvTradf                               22
     c                   If        Not *In22
     c                   Eval      W_FecAmd = DtoFec
     c                   Update    InvTradf
     c                   EndIf
     c                   EndDo
      *
     c     Clave_InvH    Chain     InvTrahf                           55
     c                   If        %Found(InvTraH01)
     c                   Eval      Y_FecTra = FecDma
     c                   Eval      Y_FecDre = FecDma
     c                   Update    InvTraHf
     c                   EndIf
      *
     c                   EndSr
      * -----------------------------------------------------------
      *  para deternimar el periodo que coresponde la transaccion -
      * -----------------------------------------------------------
     c     periodo       begsr
      *
      * la fecha debe ser dd/mm/aaaa
      *
     c     *like         define    perano        perano_9
     c     *like         define    pernum        pernum_9
      *
     c                   call      'SG7003'
     c                   parm                    profec
     c                   parm                    perano_9
     c                   parm                    pernum_9
      *
     c                   eval      perano = perano_9
     c                   eval      pernum = pernum_9
      *
     c                   clear                   perano_9
     c                   clear                   pernum_9
     c     clave_per     chain(n)  cogperf                            99
      *
     c                   endsr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
     c     *Like         Define    TmoCve        TmoCompras
L001  *  Codigo trans. entrada inventario Automatica Pelicano
 ''  c                   Eval      CodParametro = 0050
 ''  c                   Exsr      Parametros
 ''  c                   Movel(p)  ValorAlf      TmoCompras
      *
     c                   EndSr
L001  * ----------------------------------------------------------
 ''   * Parametros del sistema                                   -
 ''   * ----------------------------------------------------------
 ''  c     Parametros    Begsr
 ''  c                   Call      'SG7009'                             60
 ''  c                   Parm                    Sistema
 ''  c                   Parm                    CodParametro
 ''  c                   Parm                    ValorNum
 ''  c                   Parm                    ValorAlf
 ''   *
L001 c                   Endsr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr
      *
     c     ParCve        Chain(n)  FacParf                            99
     c                   Exsr      PrnGenerales
      *
     c                   EndSr
      * ----------------------------------------------------------*
