     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 2005')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
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
     fFacPar    If   e           k disk    Prefix(R_)
     fCxcCdo03  If   e           k disk    Prefix(L_)
     fInvTmo01  If   e           k disk    Rename(InvTmof:InvTmot) Prefix(Z_)
     fInvTmo03  If   e           k disk    Prefix(T_)
      *
     d ParCve          s              1    Inz('@')
     d FechaEur        s               d   DatFmt(*Eur)
     d FechaIso        s               d   DatFmt(*Iso)
     d NumDis          s                   Like(DisCve)
     d TipDoc          s                   Like(DtoTip)
     d NumDoc          s                   Like(DtoNro)
     d NumeroDoc       s                   Like(DtoNro)
     d NumeroNcf       s                   Like(Y_NcfNro)
     d FechaFac        s                   Like(DtoFec)
      *
     d  FacDtoh      e Ds                  ExtName(FacDtoh01)
     d  FacDed       e Ds                  ExtName(FacDed01) Prefix(Y_)
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
     c                   Parm                    TipDoc
     c                   Parm                    NumDoc
     c                   Parm                    FechaFac
     c                   Parm                    NumeroDoc
     c                   Parm                    NumeroNcf
      *
     c                   Exsr      Facturacion
     c                   Exsr      CtasPorCobrar
     c                   Exsr      Inventarios
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccionar informacion a transferir                     *
      * ----------------------------------------------------------*
     c     Facturacion   BegSr
      *
      * Datos de Cabecera de la Factura
     c/Exec Sql
     c+       Update FacDtoh01 Set DtoNro = :NumeroDoc
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (DtoTip = :TipDoc) And
     c+             (DtoNro = :NumDoc)
     c*       With NC
     c/End-Exec
      *
      * Datos de la Factura
     c/Exec Sql
     c+       Update FacDed01 Set DtoNro = :NumeroDoc, NcfNro = :NumeroNcf
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (DtoTip = :TipDoc) And
     c+             (DtoNro = :NumDoc)
     c*       With NC
     c/End-Exec
      *
      * Datos en Delatte de la Factura
     c/Exec Sql
     c+       Update FacDtod01 Set DtoNro = :NumeroDoc
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (DtoTip = :TipDoc) And
     c+             (DtoNro = :NumDoc)
     c*       With NC
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Actualizacion Cabecera de Ctas. x Cobrar                 *
      * ----------------------------------------------------------*
     c     CtasPorCobrar BegSr
      *
     c     R_ParCrf      Chain(n)  CxcCdof                            99
      *
      * Datos de Cabecera Documentos CXC
     c/Exec Sql
     c+       Update CxcDoch04 Set DocNum = :NumeroDoc
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (CdoCve = :L_CdoCve) And
     c+             (DocNum = :NumDoc) And
     c+             (FecDoc = :FechaFac)
     c*       With NC
     c/End-Exec
      *
     c                   EndSr
      * ----------------------------------------------------------*
      *  Actualizacion Transacciones en Inventarios               *
      * ----------------------------------------------------------*
     c     Inventarios   BegSr
      * Facturas
     c     R_ParTmf      Chain(n)  InvTmof                            99
      *
      * Datos de Cabecera Inventario
     c/Exec Sql
     c+       Update InvTrah01 Set TraNum = :NumeroDoc, TraNro = :NumeroDoc
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (TmoCve = :T_TmoCve) And
     c+             (TraNum = :NumDoc)
     c*       With NC
     c/End-Exec
      *
      * Datos de Cabecera Inventario
     c/Exec Sql
     c+       Update InvTrad01 Set TraNum = :NumeroDoc
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (TmoCve = :T_TmoCve) And
     c+             (TraNum = :NumDoc)
     c*       With NC
     c/End-Exec
      *
      *       Actualizar Compras Automaticas
      *
     c     TmoCompras    Chain(n)  InvTmot                            99
      *
      * Datos de Cabecera Inventario
     c/Exec Sql
     c+       Update InvTrah01 Set TraNum = :NumeroDoc, TraNro = :NumeroDoc
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (TmoCve = :Z_TmoCve) And
     c+             (TraNum = :NumDoc)
     c*       With NC
     c/End-Exec
      *
      * Datos de Detalle Inventario
     c/Exec Sql
     c+       Update InvTrad01 Set TraNum = :NumeroDoc
     c+       Where
     c+             (DisCve = :NumDis) And
     c+             (TmoCve = :Z_TmoCve) And
     c+             (TraNum = :NumDoc)
     c*       With NC
     c/End-Exec
      *
     c                   EndSr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
     c     *Like         Define    Z_TmoCve      TmoCompras
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
