     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1998')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA7002                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 04 / 10 / 99                     *
      *  DESCR:                                                          *
      *         Proceso actualizacion de factura                         *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 02 / 05 / 2007                   *
      *  DESCR: Se Agrego el archivo para controlar el costo Promedio    *
      *         y el ultimo. Idef. L001                                  *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 27 / 05 / 2008                   *
      *  DESCR: Agregar Calculos Impuesto anticipo ventas al Gobierno    *
      *         Idef. L004                                               *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 25 / 06 / 2010                   *
      *  DESCR: Agregar modificacion que permita facturar algunos        *
      *         productos en otra empresa que no sea la asignada en los  *
      *         parametros.  Idef. L099                                  *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 25 / 06 / 2010                   *
      *  DESCR: Agregar Condiciones para que los tipo de documentos      *
      *         DtoTip = 4 y 5 los cuales son facturas emitidas por      *
      *         una aplicacion Externa.  L006                            *
      *  ----------------------------------------------------------------*
      * Modificado por ..............: Luis J. Miranda V.               *
      * Fecha de modificacion........: 21 / 04 / 2014                   *
      * DESCR: Agregar Archivo Datos Adicionales detalle de Factura     *
      *        Inicialmente solo se esta grabando solo los productos    *
      *        compensado, pero este archivo se puede usar para         *
      *        cualquier otra informacion adicional en detalle. L007    *
      *  ----------------------------------------------------------------*
      * Modificado por ..............: Luis J. Miranda V.               *
      * Fecha de modificacion........: 15 / 02 / 2015                   *
      * DESCR: Se agrego una condicion para cuando las facturas sean    *
      *        de Modulos externos (Pre-Pago-Tipo Documento = 5 y       *
      *        Credito-Tipo Documento = 6 se puede usar el mismo        *
      *        codigo de cliente con tipo de NCF diferente              *
      *        Pre-Pago = 12 Unico Ingreso                              *
      *        Credito  = 01 Credito Fiscal                   L008      *
      *  ----------------------------------------------------------------*
      * Modificado por ..............: Luis J. Miranda V.               *
      * Fecha de modificacion........: 19 / 03 / 2018                   *
      * DESCR: Se Cambio la condicion para que las facturas-conduce     *
      *        salida de Pre-Pagos/Cupones = Tipo Documento = 5         *
      *        no asuma un Numero de Comprobante fiscal valido          *
      *        para evitar que sea facturador dos Veces       L009      *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 26 / 06 / 2018                   *
      *  Codigo Modificacion..........: L001                             *
      *  DESCR: Agregar Campos en los Paramentros de envio               *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Francisco Solano                 *
      *  Fecha de modificacion........: 27 / 04 / 2024                   *
      *  Codigo Modificacion..........: M001                             *
      *  DESCR: Llamar programa para envio de documento a DGII.          *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 11 / 04 / 2025                   *
      *  Codigo Modificacion..........: L007                             *
      *  DESCR: Poner el comentario actualizacion de los archivos de     *
      *         estadisticas los cuales dejaron de ser necesarios        *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 04 / 12 / 2025                   *
      *  Codigo Modificacion..........: L008                             *
      *  DESCR: Verificar que cuando sea el Rnc de la empresa y el tipo  *
      *         de comprobante sea E32 y sobre pasa el monto tope no     *
      *         debera procesar el documento                             *
      *  ================================================================*
     fFacOrdh06 Uf   e           k Disk
     fFacOrdd01 Uf   e           k Disk
     fFacDem01  Uf   e           k Disk
     fFacOrcd01 Uf   e           k Disk
L006 fFacDad    If   e           k Disk    Prefix(e_)
     fFacOrhd   Uf a e           k Disk
     fFacPar    Uf   e           k Disk
     fCxcAdc01  Uf   e           k Disk    prefix(l)
     fCxcCli01  Uf   e           k Disk    prefix(o)
     fInvart01  Uf   e           k Disk    prefix(x)
L004 fInvDad01  If   e           k Disk    Prefix(J_)
     fInvUal01  Uf   e           k Disk
     fInvUnd01  Uf   e           k Disk
     fInvTmo03  Uf   e           k Disk    prefix(r)
     fFacDtoh01 Uf a e           k Disk
     fFacDtod01 Uf a e           k Disk
L007 fFacDtoda01Uf a e           k Disk
     fFacDed01  Uf a e           k Disk
     fFacDpr01  Uf a e           k Disk
     fFacBorh01 Uf a e           k Disk
     fFacBord01 Uf a e           k Disk
     fFacTrth01 Uf a e           k Disk
     fFacTrtd01 Uf a e           k Disk
     fFacFol    Uf a e           k Disk    usropn
     fEstGen01  Uf a e           k Disk
     fEstArt01  Uf a e           k Disk
     fEstCli01  Uf a e           k Disk
     fEstMar01  Uf a e           k Disk
     fEstPcl01  Uf a e           k Disk
     fEstVen01  Uf a e           k Disk
      *
     d FolCve          s              3  0 Inz(001)
     d Fecha           s               d   Datfmt(*Iso)
     d ParCve          s              1    Inz('@')
     d Producto        S               n
L099 d Factura_Cia3    S               n
 ''   *
M001 d TipoDocInterno  s              4a
      *
      * Campos que Son Enviados Como Parametros
     d FechaFacIso     s                   Like(SqlSegFec.FecIso)
     d FechaFinNcf     s                   Like(SqlSegFec.FecIso)
     d TipProNcf       s              1    Inz('E')
     d StatusNcf       s               n   Inz(*Off)
     d CampoAlf        s             20    Inz(*Blanks)
     d StatusAlf       s               n   Inz(*Off)
     d CiaRnc          s                   Like(SqlSegCia.CiaRnc)
      *
L007 d Compen          s              1    Inz(*Blanks)
L007 d Cod001          s                   Like(ArtCve) Inz(*Blanks)
L007 d Cod002          s                   Like(ArtCve) Inz(*Blanks)
L007 d Cod003          s                   Like(ArtCve) Inz(*Blanks)
L007 d Cliente_Sind    s               n
      *
L001  * Parametros
 ''  d Sistema         s              2    Inz('FA')
 ''  d CodParametro    s              4  0 Inz(*Zeros)
 ''  d ValorNum        s             30 15 Inz(*Zeros)
 ''  d ValorAlf        s            100    Inz(*Blank)
      *
      **Archivos Externos
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
     d SqlItePar     e Ds                  ExtName(ItePar) Qualified
     d SqlSegCia     e Ds                  ExtName(SegCia) Qualified
      *
      * Eliminar digitos alfanumericos de un campo
     d EliminarAlf     Pr                  ExtPgm('SG7015')
     d  Campo_1                            Like(SqlSegCia.CiaRnc)
     d  Status_1                           Like(StatusAlf)

L001  /Copy Fuentes,SG9001
 ''   *
     iFacBordf
     i              OrdSec                      yOrdSec
      *
     iFacFolf
     i              DisCve                      yDisCve
     i              DtoTip                      yDtoTip
      *
     iFacTrthf
     i              SitCve                      tSitCve
      *
     iFacDprf
     i              CliCve                      pCliCve
      *
     iFacOrdhf
     i              AplUsr                      WAplUsr
      *----------------------------------------------------
      *                BLOQUE PRINCIPAL                   -
      *----------------------------------------------------
     c     *entry        plist
     c                   Parm                    Distrito
     c                   Parm                    OrdNum
     c                   Parm                    TipDoc
     c                   Parm                    NumCli
     c                   Parm                    NumDoc
     c                   parm                    FechaProceso      8 0
      *
     c     Clave_Ordh    Klist
     c                   Kfld                    Distrito
     c                   Kfld                    OrdNum
      *
     c     Clave_fol     Klist
     c                   Kfld                    DisCve
     c                   Kfld                    folcve
     c                   Kfld                    DtoTip
      *
     c     Clave_dtoh    Klist
     c                   Kfld                    DisCve
     c                   Kfld                    DtoTip
     c                   Kfld                    DtoNro
      *
     c     Clave_trth    Klist
     c                   Kfld                    DisCve
     c                   Kfld                    TmoCve
     c                   Kfld                    TraNro
      *
     c     Clave_estart  Klist
     c                   Kfld                    ArtCve
     c                   Kfld                    AnoEst
     c                   Kfld                    MesEst
      *
     c     Clave_estgen  Klist
     c                   Kfld                    anoest
     c                   Kfld                    mesest
      *
     c     Clave_estcli  Klist
     c                   Kfld                    clicve
     c                   Kfld                    anoest
     c                   Kfld                    mesest
      *
     c     Clave_estmar  Klist
     c                   Kfld                    xmarcve
     c                   Kfld                    anoest
     c                   Kfld                    mesest
      *
     c     Clave_estpcl  Klist
     c                   Kfld                    ArtCve
     c                   Kfld                    clicve
     c                   Kfld                    anoest
     c                   Kfld                    mesest
      *
     c     Clave_estven  Klist
     c                   Kfld                    vencve
     c                   Kfld                    anoest
     c                   Kfld                    mesest
      *
     c     Clave_rau     Klist
     c                   Kfld                    ArtCve
     c                   Kfld                    ordund
      *
     c     *Like         Define    DisCve        Distrito
     c     *Like         Define    ordnro        ordnum
     c     *Like         Define    DtoNro        numdoc
     c     *Like         Define    clicve        NumCli
     c     *Like         Define    DtoTip        TipDoc
     c     *Like         Define    FecTra        FechaPrecio
     c     *Like         Define    dtosec        Secuen
     c     *Like         Define    dtosec        Secuen_b
      *
     c     *Like         Define    DtoMbr        Tot_MonBru
     c     *Like         Define    DtoMd1        Tot_Descu1
     c     *Like         Define    DtoMd2        Tot_Descu2
     c     *Like         Define    DtoMi1        Tot_Impue1
     c     *Like         Define    DtoMi2        Tot_Impue2
     c     *Like         Define    DtoMne        Tot_MonNet
     c     *Like         Define    DtoMpr        Tot_CosPro
     c     *Like         Define    DtoMul        Tot_CosUlt
      *
L004 c     *Like         Define    DtoVc1        Dto_DtoVc1
      *
     c     *Like         Define    DtoMbr        Dto_MonBru
     c     *Like         Define    DtoMd1        Dto_Descu1
     c     *Like         Define    DtoMd2        Dto_Descu2
     c     *Like         Define    DtoMi1        Dto_Impue1
     c     *Like         Define    DtoMi2        Dto_Impue2
     c     *Like         Define    DtoMne        Dto_MonNet
     c     *Like         Define    DtoMpr        Dto_CosPro
     c     *Like         Define    DtoMul        Dto_CosUlt
      *
     c     *Like         Define    tracos        Tot_impcos
     c     *Like         Define    dtomd1        mondes
     c     *Like         Define    dtomi1        monimp
     c     *Like         Define    dtomd1        MonDes_Dto
     c     *Like         Define    dtomi1        MonImp_Dto
     c     *Like         Define    estano        anoest
     c     *Like         Define    estmes        mesest
     c     *Like         Define    dtompd        totdes
     c     *Like         Define    dtoim1        totimp
     c     *Like         Define    dtomne        monnet
     c     *Like         Define    dtocop        copual
     c     *Like         Define    dtocou        couual
     c     *Like         Define    dtocou        copcuv
     c     *Like         Define    dtocou        coucuv
     c     *Like         Define    dtocup        totlib
     c     *Like         Define    dtocan        totcaj
L006 c     *Like         Define    ParCrf        ParFcc
      *
     c                   Eval      DtoTip = TipDoc
      * Buscar Parametros Generales
     c                   Exsr      PrnGenerales
      *
     c                   Exsr      Proceso
      * Solo envia a la Dgii si la serie es de Comprobante Electronico
     c                   If        %subst(NumNcf:1:1) = 'E' And TipDoc <> 4
M001 c                   Exsr      EnviarDGII
     c                   EndIf
      *
     c                   Eval      *Inlr = *On
      *---------------------------------------------------------------
      * Proceso de actulizacion de factura                           -
      *---------------------------------------------------------------
     c     Proceso       BegSr
      *
     c                   Do
     c     ParCve        Chain(n)  FacParf                            99
     c     Clave_Ordh    Chain     FacOrdhf                           02
     c     Clave_Ordh    Chain     FacDemf                            02
     c     CliCve        Chain     CxcClif                            99
 ''  c     CliCve        Chain     CxcAdcf                            99
      *
      //Si el Monto Neto es igual a cero o el Rnc es Igual al de la empresa
      //y el tipo de comprobante = E32 y el monto neto > al parametro no
      //debe de ejecutar
     c                   If        OrdTin = *Zeros
     c                             Or CiaRnc = oCliRnc And lTcfCve = 32
     c                             And OrdTin > SqlItePar.ParMti
     c                   Leave
     c                   EndIf
      *
      * Buscar el numero de documento
     c     *Eur          Move      FechaProceso  FechaFacIso
     c                   Exsr      Foliador
L002  * Buscar numero de Ncf
L006  * Si es tipo de documento DtoTip = 4 no debe buscar NCF ya que
L006  * fue asignado por la aplicacion Externa
L009 c                   Select
L009 c*                  If        DtoTip <> 4
      * Facturas Normales
L009 c                   When      DtoTip < 4 Or DtoTip > 5
L002 c                   Exsr      Buscar_Ncf
L006 c*                  Else
      * Facturas Realizada por Modulos Externos
L009 c                   When      DtoTip = 4
 ''  c     Clave_Ordh    Chain     FacDadf                            55
 ''  c                   If        %Found(FacDad)
 ''  c                   Eval      NumNcf = e_NcfNro
 ''  c                   EndIf
 ''  c*                  EndIf
      * Conduce de Salida para Registrar los Cupones
L009 c                   When      DtoTip = 5
 ''  c                   Clear                   NumNcf
L009 c                   EndSl
L006  *
L002 c                   Eval      NcfNro = NumNcf
L099  * Este Programa verifica si esta factura tiene productos que son
 ''   * facturados por la CIA3
 ''  c                   Exsr      Verifica_Cia3
 ''   * Esto solo ejecuta si en el parametro 0051 tiene una N, si tiene
 ''   * Una S no debe ejecutar ya que esa empresa si debe recibir existencia.
 ''   *
 ''   * Si Factura_Cia3 = *On significa que debe crear compra automatica
 ''  c*                  If        ManejaExist = 'N'
L099 c                   If        ManejaExist = 'N' Or Factura_Cia3 = *On
     c                   Exsr      Aplicar_Compra
     c                   EndIf
      *
      * Mover los datos necesarios
     c                   Time                    AplHor
     c                   Time                    TraHor
      *
     c                   If        User = *Blanks And Wsid = *Blanks
     c                   Eval      User = wAplUsr
     c                   Eval      Wsid = 'PROCESOBAT'
     c                   EndIf
      *
     c                   Eval      AplUsr = User
     c                   Eval      TraUsr = User
     c                   Eval      AplWsi = Wsid
     c                   Eval      TraWsi = Wsid
      * Factura
     c                   Select
     c                   When      DtoTip = 1
     c     ParTmf        Chain(n)  InvTmof                            99
L006 c                   Eval      ParFcc = ParCrf
      * Promocion
     c                   When      DtoTip = 3
     c     ParTmp        Chain(n)  InvTmof                            99
      * Factura Externa NCF
L006 c                   When      DtoTip = 4
 ''  c     ParTfe        Chain(n)  InvTmof                            99
 ''  c                   Eval      ParFcc = ParRfe
      * Factura Externa Ticket Pre-Pago
L006 c                   When      DtoTip = 5
 ''  c     ParTft        Chain(n)  InvTmof                            99
 ''  c                   Eval      ParFcc = ParRft
      * Factura Externa a Credito Modulo externo
L008 c                   When      DtoTip = 6
 ''  c     ParTcf        Chain(n)  InvTmof                            99
 ''  c                   Eval      ParFcc = ParRfc
L008 c                   EndSl
      *
     c                   Eval      TmoCve = rTmoCve
L005 c*                  Eval      traorc = *Zeros
L005 c*                  Eval      tradre = *Blanks
L005 c                   Eval      TraOrc = OrdNum
L005 c*                  Move(p)   CliCve        TraDre
     c*                  Movel(p)  CliNom        TraDes
L009 c                   Eval      TraDre = %Editc(CliCve:'X')
L009 c                   Eval      TraDes = %Trim(CliNom)
      *
     c     *Eur          Move      FechaProceso  Fecha
     c     *Eur          Move      FechaProceso  FechaFacIso
     c                   Move      FechaProceso  FecTra
     c                   Move      FechaProceso  FecDre
      *
     c*                  Move      *Date         Fecha
     c*                  Move      *Date         FecTra
     c*                  Move      *Date         FecDre
      *
     c                   Move      Fecha         DtoFec
     c                   Move      Fecha         FecAmd            8 0
      *
     c                   Extrct    Fecha:*y      AnoEst
     c                   Extrct    Fecha:*m      MesEst
      *
     c     *Eur          Move      FecOrd        Fecha
     c                   Move      Fecha         OrdFec
     c                   Eval      DtoSta = 'A'
     c                   Eval      DtoTas = OrdTas
      *
      * grabar cabecera de documento
     c                   Write     FacDtohf
L004  * Tipo comprobante Gubernamental
 ''  c                   If        lTcfCve = 15 Or lTcfCve = 54
     c                             Or lTcfCve = 45
 ''  c                   Eval      MsgCve = 99
L004 c                   EndIf
      *
     c                   If        CliIde = *Blanks
     c                   Eval      CliIde = oCliRnc
     c                   EndIf
      *
      * grabar datos de envios de documento
     c                   Write     FacDedf
      *
      * si es una promocion graba en este archivo
     c                   If        DtoTip = 3
     c                   Eval      pCliCve = NumCli * 1
     c                   Write     FacDprf
     c                   EndIf
      *
      * grabar cabecera de inventarios si por lo menos tiene un producto que
      * maneja existencia
L005 c                   If        Producto = *On Or ManejaExist = 'S'
     c                   Write     FacTrthf
L005 c                   EndIf

      //Actualizar las planillas en detalle si el conduce es facturado
          Exsr Planillas  ;

      //Actualizar las Transferencias en detalle si el conduce es facturado
          Exsr Transferencias ;

      *
      * trabajar con detalle
     c                   Exsr      Detalle
      *
      * monto neto, monto descuento, monto impuestos
      *
     c                   Clear                   Tot_Descu2
     c                   Clear                   Dto_Descu2
     c                   Eval      mondes = Tot_descu1 + Tot_descu2
     c                   Eval      monimp = Tot_impue1 + Tot_impue2
      *
     c                   Eval      MonDes_Dto = Dto_descu1 + Dto_descu2
     c                   Eval      MonImp_Dto = Dto_impue1 + Dto_impue2
      *
     c                   Eval      Tot_monnet = Tot_monbru - mondes + monimp
     c                   Eval      Dto_MonNet = Dto_MonBru - mondes + monimp
      *
      * Actualizar cabecera de factura
     c     Clave_dtoh    Chain     facdtohf                           44
     c                   If        Not *In44
      *
     c                   Eval      dtombr = Dto_monbru * 1
     c                   Eval      dtomd1 = Dto_descu1 * 1
     c                   Eval      dtomd2 = Dto_descu2 * 1
     c                   Eval      dtomi1 = Dto_impue1 * 1
     c                   Eval      dtomi2 = Dto_impue2 * 1
     c                   Eval      dtomne = Dto_monnet * 1
     c                   Eval      dtompr = Dto_cospro * 1
     c                   Eval      dtomul = Dto_cosult * 1
      *
L004 c                   Eval      DtoVc1 = Dto_DtoVc1 * 1
      *
     c                   Eval      dtocbu = totcaj * 1
     c                   Eval      dtocrp = totlib * 1
     c                   Update    facdtohf
     c                   EndIf
      *
     c                   Delete    facdemf
      *
     c                   Delete    FacOrdhf
      *
      * Actualizar cabecera de inventario
     c     Clave_trth    Chain     factrthf                           45
     c                   If        not *In45
      * Nivel de situacion
     c                   If        Tot_impcos <> *zeros
     c                   Eval      tsitcve = '1'
     c                   Else
     c                   Eval      tsitcve = '7'
     c                   EndIf
      *
     c                   Eval      tracos = Tot_impcos * 1
     c                   Update    factrthf
     c                   EndIf
      * Solo Actualiza el inventario si tiene producto con exitencia
     c                   If        Producto = *On Or ManejaExist = 'S'
     c                   Exsr      Actualiza_Inv
     c                   EndIf
      * Si DtoTip = 5 Son Pre-Pagos no debe enviarlos a CXC
     c                   If        DtoTip <> 5
      * Para Actualizar Cuentas por Cobrar
     c                   Exsr      Actualiza_Cxc
     c                   EndIf
      * Actualizar las estadisticas en resumen
L007 c*                  Exsr      Estadis_Res
      *
     c                   EndDo
     c                   EndSr
      *-----------------------------------------------------
      *  Actualizar los ducumentos definitivos             -
      *-----------------------------------------------------
     c     Actualiza_Inv BegSr
      *
      * actualizacion de inventarios
     c                   Close     factrth01
     c                   Close     factrtd01
      *
     c                   Call      'FA7003AS'
     c                   Parm                    DisCve
     c                   Parm                    TraNro
     c                   Parm                    TmoCve
      *
     c                   Open      factrth01
     c                   Open      factrtd01
      * Solo Copia detalle de los conduce en las empresas que manejan
      * existencia ya que deben cuadrar con las otras.
     c                   If        ManejaExist = 'S'
     c                   Exsr      CopiaConduce
     c                   EndIf
      *
     c                   EndSr
      *-----------------------------------------------------
      *  Actualizar los ducumentos definitivos             -
      *-----------------------------------------------------
     c     Actualiza_Cxc BegSr
      *
      * Si la zona de venta es < que el campo parzop pasa el registro a
      * cuentas por cobrar
     c     CliCve        Chain(n)  CxcAdcf                            99
     c                   If        lZonCve < ParZop
      *
      * actualizacion de cuentas por cobrar
     c                   Call      'CC7001'
     c                   Parm                    Clicve
     c                   Parm                    DtoNro
     c                   Parm                    DisCve
     c                   Parm                    Fectra
     c                   Parm                    DtoMne
     c                   Parm                    Cpacve
     c                   Parm                    Vencve
L006 c*                  Parm                    ParCrf
L006 c                   Parm                    ParFcc
     c                   Parm                    Dtombr
     c                   Parm                    Mondes
     c                   Parm                    Monimp
     c                   Parm      *Blanks       Refere           10
      *
L001 c                   Parm                    NcfNro
L001 c                   Parm                    CliIde
      *
     c                   EndIf
      *
     c                   EndSr
      *------------------------------------------------------
      *  Trabajar con el detalle del pedido                 -
      *------------------------------------------------------
     c     Detalle       BegSr
      *
     c                   Clear                   Secuen
     c                   Clear                   Secuen_b
     c                   Clear                   Tot_monbru
     c                   Clear                   Tot_descu1
     c                   Clear                   Tot_descu2
     c                   Clear                   Tot_impue1
     c                   Clear                   Tot_impue2
     c                   Clear                   Tot_monnet
     c                   Clear                   Tot_cospro
     c                   Clear                   Tot_cosult
     c                   Clear                   Tot_impcos
      *
     c                   Clear                   Dto_monbru
     c                   Clear                   Dto_descu1
     c                   Clear                   Dto_descu2
     c                   Clear                   Dto_impue1
     c                   Clear                   Dto_impue2
     c                   Clear                   Dto_monnet
     c                   Clear                   Dto_cospro
     c                   Clear                   Dto_cosult
      *
L004 c                   Clear                   Dto_DtoVc1
      *
     c                   Clear                   mondes
     c                   Clear                   monimp
      *
     c                   Clear                   MonDes_Dto
     c                   Clear                   MonImp_Dto
      *
     c                   Clear                   totlib
     c                   Clear                   totcaj
     c                   Clear                   Control           1 0
      *
     c                   Eval      *In22 = *Off
     c     Clave_Ordh    Setll     FacOrddf
      *
     c                   Dow       *In22 = *Off
     c     Clave_Ordh    Reade     FacOrdd01                              22
      *
     c                   If        Not *In22
      * Los registros eliminado lo descarta
     c                   If        OrdSta = 'E'
     c                   Delete    FacOrddf
     c                   Iter
     c                   EndIf
      *
      * Si Cantidad a Despachar es igual a ceros el renglon pasa a backorder
     c                   If        OrdCde <> *zeros
      *
     c     ArtCve        Chain(n)  InvArtf                            55
      * Si es diferente a la de almacenamiento debe
      * existir como unidad alterna
     c                   If        OrdUnd <> xArtUve
     c     Clave_rau     Chain(n)  InvUalf                            31
     c                   Else
     c     ordund        Chain(n)  InvUndf                            31
     c                   Eval      ualcon = xartcuv
     c                   EndIf
      * Si es un articulo que no manena Existencia
     c                   If        xArtMce = 'N'
     c                             And (xArtCpl + xArtCul) = *Zeros
     c*                  Eval      xArtCpl = OrdPve * 1
     c*                  Eval      xArtCul = OrdPve * 1
     c                   Eval      xArtCpl = .001
     c                   Eval      xArtCul = .001
     c                   EndIf
      * Si es un articulo con precio regulado o no maneja existencia
     c*                  If        xArtPpr = 'S' And xArtPml = *Zeros
     c                   If        xArtPpr = 'S'
     c                             or xArtMce = 'N' And xArtPml = *Zeros
      *
     c                   Exsr      Buscar_Precio
     c                   Eval      xArtPml = Precio * 1
     c                   EndIf
     * Para Convertir el precio en Moneda extranjera
     c                   If        MonCve <> *Zeros
     c                   Eval(Rh)  xArtPml = xArtPml / DtoTas
     c                   EndIf
L003  * Para Buscar el costo Ultimo en las empresas que no manejan existencia
 ''  c*                  If        ManejaExist = 'N'
L099 c                   If        ManejaExist = 'N' Or Factura_Cia3 = *On
 ''  c                   Exsr      Buscar_Costo
 ''   *
 ''  c                   If        xArtCpl <> Costo
 ''  c                   Eval      xArtCpl = Costo * 1
 ''  c                   EndIf
 ''   *
 ''  c                   If        xArtCul <> Costo
 ''  c                   Eval      xArtCul = Costo * 1
 ''  c                   EndIf
L001  * Para Buscar el costo en las empresas que manejan existencia
 ''  c                   Else
 ''  c                   Exsr      Buscar_Costo_E
 ''   *
 ''  c                   If        xArtCpl <> CostoPro
 ''  c                   Eval      xArtCpl = CostoPro * 1
 ''  c                   EndIf
 ''   *
 ''  c                   If        xArtCul <> CostoUlt
 ''  c                   Eval      xArtCul = CostoUlt * 1
 ''  c                   EndIf
 ''   *
L003 c                   EndIf
      * Determinar el costo en unidad de almacenamiento y unidad alterna
     c                   Eval      copual = xartcpl
     c                   Eval      couual = xartcul
      *
     c                   Eval(rh)  copcuv = ((xartcpl / xartcuv) * ualcon)
     c                   Eval(rh)  coucuv = ((xartcul / xartcuv) * ualcon)
      *
      * si el producto req. peso al despacho
     c                   If        ordcud <> *zeros
     c                   Eval      totlib = totlib + ordcud
      * para sumar un bulto por cada paquete de producto que requiere peso
     c                   Eval      totcaj = totcaj + 1
     c                   Else
     c                   Eval      totcaj = totcaj + ordcde
     c                   EndIf
      *
     c                   If        ordund = xartuve
     c                   Eval      dtocop = copual * 1
     c                   Eval      dtocou = couual * 1
     c                   Else
     c                   Eval      dtocop = copcuv * 1
     c                   Eval      dtocou = coucuv * 1
     c                   EndIf
      *
      * detalle de documento
     c                   Eval      secuen = secuen + 1
     c                   Eval      dtosec = secuen * 1
     c                   Eval      dtoude = ordund * 1
     c                   Eval      dtocan = ordcde * 1
     c                   Eval      dtocua = ordcdx * 1
     c                   Eval      dtocup = ordcud * 1
     c                   Eval      dtopve = ordpve * 1
     c                   Eval      dtopor = xartpml * 1
     c                   Eval(rh)  dtoimp = ordcde * ordpve
     c                   Eval      dtopd1 = orddpe * 1
     c                   Eval      dtompd = ordid1 * 1
     c                   Eval      dtopd2 = *zeros
     c*                  Eval      dtomsd = ordid2 * 1
     c                   Eval      dtomsd = *zeros
     c                   Eval      dtoim1 = ordii1 * 1
     c                   Eval      dtoim2 = ordii2 * 1
     c                   Eval(rh)  dtomcp = ordcde * dtocop
     c                   Eval(rh)  dtomcu = ordcde * dtocou
      *
L004  * Tipo comprobante Gubernamental
 ''  c                   If        lTcfCve = 15
 ''   *
 ''  c                   Select
 ''  c                   When      xArtPpr = 'S'
 ''  c     ArtCve        Chain     InvDadf                            55
 ''  c                   Eval(Rh)  DtoVd1 = DtoCan * (J_ArtVmd * Por_ImpAnt)
     c                   Eval      DtoVd5 = J_ArtVmd * 1
 ''   *
 ''  c                   When      xArtPpr = 'N'
 ''  c                   Eval(Rh)  DtoVd1 = DtoImp * Por_ImpAnt
 ''  c                   EndSl
 ''  c                   EndIf
L004  *
     c                   Write     FacDtodf
      *
L007  * Grabar registros Archivo Datos Adionales
 ''  c                   If        Compen = 'S'
     c                             And (ArtCve = Cod002 Or ArtCve = Cod003)
 ''  c                   Write     FacDtodaf
 ''  c                   EndIf
L007  *
      * Si el producto maneja existencia
     c                   If        XArtMce = 'S'
      * detalle de inventario
     c                   Eval      trasec = secuen * 1
     c                   Eval      traund = ordund * 1
     c                   Eval      ccocve = *blanks
     c                   Eval      tracan = ordcde * 1
     c                   Eval      tracud = ordcud * 1
     c                   Eval      tracun = dtocop * 1
     c                   Eval(rh)  traico = tracan * dtocop
     c                   Write     FacTrtdf
      *
      * Actualizar las estadisticas en detalle
L007 c*                  Exsr      Estadis_det
      *
      *  sumar datos de cabecera de inventario
     c                   Eval      Tot_impcos = Tot_impcos + traico
      *
      *  sumar datos de cabecera de documento
     c                   Eval      Tot_monbru = Tot_monbru + dtoimp
     c                   Eval      Tot_cospro = Tot_cospro + dtomcp
     c                   Eval      Tot_cosult = Tot_cosult + dtomcu
     c                   EndIf
      *
     c                   Eval      Tot_descu1 = Tot_descu1 + dtompd
     c*                  Eval      Tot_descu2 = Tot_descu2 + dtomsd
     c                   Eval      Tot_impue1 = Tot_impue1 + dtoim1
     c                   Eval      Tot_impue2 = Tot_impue2 + dtoim2
      *
      *  sumar datos de cabecera de documento
     c                   Eval      Dto_monbru = Dto_monbru + dtoimp
     c                   Eval      Dto_descu1 = Dto_descu1 + dtompd
     c*                  Eval      Dto_descu2 = Dto_descu2 + dtomsd
     c                   Eval      Dto_impue1 = Dto_impue1 + dtoim1
     c                   Eval      Dto_impue2 = Dto_impue2 + dtoim2
     c                   Eval      Dto_cospro = Dto_cospro + dtomcp
     c                   Eval      Dto_cosult = Dto_cosult + dtomcu
      *
L004 c                   Eval      Dto_DtoVc1 = Dto_DtoVc1 + DtoVd1
      *
     c                   Delete    FacOrddf
      *
      * Backup order
     c                   Else
      *
      * si control > cero debe
     c                   Eval      Control += 1
      *
     c                   If        Control = 1
     c                   Write     FacBorhf
     c                   EndIf
      *
     c                   Eval      Secuen_b += 1
     c                   Eval      yordsec = Secuen_b * 1
     c                   Write     FacBordf
     c                   Delete    FacOrddf
      *
     c                   EndIf
     c                   EndIf
      *
     c                   EndDo
     c                   EndSr
      *-----------------------------------------------------
      *  Actualizar las estadisticas en detalle            -
      *-----------------------------------------------------
     c     estadis_det   BegSr
     c                   Clear                   totdes
     c                   Clear                   totimp
     c                   Clear                   monnet
      *
     c                   Eval      totdes = dtompd
     c                   Eval      totimp = dtoim1 + dtoim2
     c                   Eval      monnet = dtoimp - totdes + totimp
      *
      * Acumulados por articulos
     c     Clave_estart  Chain     estartf                            60
     c                   If        not *In60
     c                   Eval      estcua += ordcdx
     c                   Eval      estcud += dtocup
     c                   Eval      estibv += dtoimp
     c                   Eval      estidv += totdes
     c                   Eval      estiiv += totimp
     c                   Eval      estinv += monnet
     c                   Eval      estcpr += dtomcp
     c                   Eval      estcul += dtomcu
     c                   Update    estartf
      *
     c                   Else
     c                   Eval      estano = anoest * 1
     c                   Eval      estmes = mesest * 1
     c                   Eval      estcua = ordcdx * 1
     c                   Eval      estcud = dtocup * 1
     c                   Eval      estibv = dtoimp * 1
     c                   Eval      estidv = totdes * 1
     c                   Eval      estiiv = totimp * 1
     c                   Eval      estinv = monnet * 1
     c                   Eval      estcpr = dtomcp * 1
     c                   Eval      estcul = dtomcu * 1
     c                   Write     estartf
     c                   EndIf
      *
      * Acumulados por marca
     c     Clave_estmar  Chain     estmarf                            64
     c                   If        not *In64
     c                   Eval      estcua += ordcdx
     c                   Eval      estcud += dtocup
     c                   Eval      estibv += dtoimp
     c                   Eval      estidv += totdes
     c                   Eval      estiiv += totimp
     c                   Eval      estinv += monnet
     c                   Eval      estcpr += dtomcp
     c                   Eval      estcul += dtomcu
     c                   Update    estmarf
      *
     c                   Else
     c                   Eval      marcve = xmarcve
     c                   Eval      estano = anoest * 1
     c                   Eval      estmes = mesest * 1
     c                   Eval      estcua = ordcdx * 1
     c                   Eval      estcud = dtocup * 1
     c                   Eval      estibv = dtoimp * 1
     c                   Eval      estidv = totdes * 1
     c                   Eval      estiiv = totimp * 1
     c                   Eval      estinv = monnet * 1
     c                   Eval      estcpr = dtomcp * 1
     c                   Eval      estcul = dtomcu * 1
     c                   Write     estmarf
     c                   EndIf
      *
      * Acumulados por articulos y clientes
     c     Clave_estpcl  Chain     estpclf                            61
     c                   If        not *In61
     c                   Eval      estcua += ordcdx
     c                   Eval      estcud += dtocup
     c                   Eval      estibv += dtoimp
     c                   Eval      estidv += totdes
     c                   Eval      estiiv += totimp
     c                   Eval      estinv += monnet
     c                   Eval      estcpr += dtomcp
     c                   Eval      estcul += dtomcu
     c                   Update    estpclf
      *
     c                   Else
     c                   Eval      estano = anoest * 1
     c                   Eval      estmes = mesest * 1
     c                   Eval      estcua = ordcdx * 1
     c                   Eval      estcud = dtocup * 1
     c                   Eval      estibv = dtoimp * 1
     c                   Eval      estidv = totdes * 1
     c                   Eval      estiiv = totimp * 1
     c                   Eval      estinv = monnet * 1
     c                   Eval      estcpr = dtomcp * 1
     c                   Eval      estcul = dtomcu * 1
     c                   Write     estpclf
     c                   EndIf
      *
     c                   endsr
      *-----------------------------------------------------
      *  Actualizar las estadisticas en resumen            -
      *-----------------------------------------------------
     c     estadis_res   BegSr
      *
      * Acumulados generales
      *
      * Si la zona de venta es < que el campo parzop acumula los registros
      *
     c                   If        lzoncve < parzop
     c     Clave_estgen  Chain     estgenf                            65
     c                   If        not *In65
     c                   Eval      estibv = estibv + Tot_monbru
     c                   Eval      estidv = estidv + mondes
     c                   Eval      estiiv = estiiv + monimp
     c                   Eval      estinv = estinv + Tot_monnet
     c                   Eval      estcpr = estcpr + Tot_cospro
     c                   Eval      estcul = estcul + Tot_cosult
     c                   Update    estgenf
      *
     c                   Else
     c                   Eval      estano = anoest * 1
     c                   Eval      estmes = mesest * 1
     c                   Eval      estibv = Tot_monbru * 1
     c                   Eval      estidv = mondes * 1
     c                   Eval      estiiv = monimp * 1
     c                   Eval      estinv = Tot_monnet * 1
     c                   Eval      estcpr = Tot_cospro * 1
     c                   Eval      estcul = Tot_cosult * 1
     c                   Write     estgenf
     c                   EndIf
      *
      * Acumulados por vendedor
     c     Clave_estven  Chain     estvenf                            63
     c                   If        not *In63
     c                   Eval      estibv = estibv + Tot_monbru
     c                   Eval      estidv = estidv + mondes
     c                   Eval      estiiv = estiiv + monimp
     c                   Eval      estinv = estinv + Tot_monnet
     c                   Eval      estcpr = estcpr + Tot_cospro
     c                   Eval      estcul = estcul + Tot_cosult
     c                   Update    estvenf
      *
     c                   Else
     c                   Eval      estano = anoest * 1
     c                   Eval      estmes = mesest * 1
     c                   Eval      estibv = Tot_monbru * 1
     c                   Eval      estidv = mondes * 1
     c                   Eval      estiiv = monimp * 1
     c                   Eval      estinv = Tot_monnet * 1
     c                   Eval      estcpr = Tot_cospro * 1
     c                   Eval      estcul = Tot_cosult * 1
     c                   Write     estvenf
     c                   EndIf
      *
     c                   EndIf
      *
      * Acumulados por clientes
     c     Clave_estcli  Chain     estclif                            62
     c                   If        not *In62
     c                   Eval      estibv = estibv + Tot_monbru
     c                   Eval      estidv = estidv + mondes
     c                   Eval      estiiv = estiiv + monimp
     c                   Eval      estinv = estinv + Tot_monnet
     c                   Eval      estcpr = estcpr + Tot_cospro
     c                   Eval      estcul = estcul + Tot_cosult
     c                   Update    estclif
      *
     c                   Else
     c                   Eval      estano = anoest * 1
     c                   Eval      estmes = mesest * 1
     c                   Eval      estibv = Tot_monbru * 1
     c                   Eval      estidv = mondes * 1
     c                   Eval      estiiv = monimp * 1
     c                   Eval      estinv = Tot_monnet * 1
     c                   Eval      estcpr = Tot_cospro * 1
     c                   Eval      estcul = Tot_cosult * 1
     c                   Write     estclif
     c                   EndIf
      *
     c                   endsr
      * ----------------------------------------------------------
      *   Buscar el numero concecutivo de la orden              -
      * ----------------------------------------------------------
     c     Foliador      BegSr
      *
     c                   Open      facfol
     c     Clave_fol     Chain     facfolf                            39
     c                   If        *In39 = *Off
     c                   Eval      foldef = foldef + 1
     c                   Update    facfolf
     c                   Else
     c                   Eval      yDisCve = DisCve
     c                   Eval      yDtoTip = DtoTip
     c                   Eval      foldef = foldef + 1
      *
L006 c*                  If        DtoTip = 1
L006 c                   If        DtoTip = 1 Or DtoTip > 3
     c                   Eval      foldes = 'Numero secuencial de facturas   '
     c                   Else
     c                   Eval      foldes = 'Numero sec. conduce de promocion'
     c                   EndIf
      *
     c                   Write     facfolf
     c                   EndIf
     c                   Close     facfol
      *
      * numero de documento
     c                   Eval      DtoNro = foldef * 1
     c                   Eval      numdoc = foldef * 1
     c                   Eval      TraNro = foldef * 1
     c                   Endsr
      *-----------------------------------------------------
      *  Aplicar la entrada de esta venta.                 -
      *-----------------------------------------------------
     c     Aplicar_CompraBegSr
      *
     c                   Eval      Producto = *Off
      * actualizacion de inventarios
     c                   Close     FacOrdh06
     c                   Close     FacDem01
     c                   Close     FacPar
      *
     c                   Call      'FA7052'
     c                   Parm                    Distrito
     c                   Parm                    OrdNum
     c                   Parm                    Producto
      *
     c                   If        Producto = *On
     c                   Call      'FA7050'
     c                   Parm                    OrdNum
     c                   Parm                    DisCve
     c                   Parm                    TipDoc
     c                   Parm                    NumDoc
L099 c                   Parm                    PveArt
     c                   EndIf
      *
     c                   Open      FacOrdh06
     c                   Open      FacDem01
     c                   Open      FacPar
      *
     c     ParCve        Chain(n)  FacParf                            99
     c     Clave_Ordh    Chain     FacOrdhf                           02
     c     Clave_Ordh    Chain     FacDemf                            02
     c                   EndSr
L099  *-----------------------------------------------------
 ''   *  Verifica productos facturados Cia3                -
 ''   *-----------------------------------------------------
 ''  c     Verifica_Cia3 BegSr
 ''   *
 ''  c     *Like         Define    xArtPve       PveArt
 ''  c                   Eval      Factura_Cia3 = *Off
 ''   * Verifica productos
 ''  c                   Close     FacOrdh06
 ''  c                   Close     FacDem01
 ''  c                   Close     FacPar
 ''   *
 ''  c                   Call      'FA7054'
 ''  c                   Parm                    Distrito
 ''  c                   Parm                    OrdNum
 ''  c                   Parm                    PveArt
 ''  c                   Parm                    Factura_Cia3
 ''   *
 ''  c                   Open      FacOrdh06
 ''  c                   Open      FacDem01
 ''  c                   Open      FacPar
 ''   *
 ''  c     ParCve        Chain(n)  FacParf                            99
 ''  c     Clave_Ordh    Chain     FacOrdhf                           02
 ''  c     Clave_Ordh    Chain     FacDemf                            02
L099 c                   EndSr
      * ----------------------------------------------------------
      *  Copia los conduce a un archivo historico                -
      * ----------------------------------------------------------
     c     CopiaConduce  BegSr
      *
     c                   Eval      *In23 = *Off
     c     Clave_Ordh    setll     FacOrcdf
      *
     c                   Dow       Not *In23
      *
     c     Clave_Ordh    Reade     FacOrcdf                               23
     c                   If        Not *In23
     c                   Write     FacOrhdf
     c                   Delete    FacOrcdf
     c                   EndIf
      *
     c                   EndDo
     c                   EndSr
L002  *-----------------------------------------------------
 ''   *  Buscar Numero de Ncf                              -
 ''   *-----------------------------------------------------
 ''  c     Buscar_Ncf    BegSr
 ''   *
 ''  c     *Like         Define    NcfNro        NumNcf
 ''  c                   Clear                   NumNcf
 ''   *
 ''  c     CliCve        Chain     CxcAdcf                            99
L008  *
 ''  c                   If        TipDoc = 5
 ''  c                   Eval      lTcfCve = 12
L008 c                   EndIf
 ''   *
 ''  c                   Call      'SG7011'
 ''  c                   Parm      01            Mcfcve            2 0
 ''  c                   Parm                    DisCve
 ''  c                   Parm                    lMonCve
 ''  c                   Parm                    lTcfCve
 ''  c                   Parm                    NumNcf
 ''  c                   Parm                    FechaFacIso
 ''  c                   Parm                    FechaFinNcf
 ''  c                   Parm                    TipProNcf
 ''  c                   Parm                    StatusNcf
 ''   *
L002 c                   EndSr
L003  *-------------------------------------------------------------
 ''   *  Buscar El costo en las empresas que no manejan existencia -
 ''   *-------------------------------------------------------------
 ''  c     Buscar_Costo  BegSr
 ''  c     *Like         Define    xArtCpl       Costo
     c                   Clear                   Costo
 ''   *
 ''  c                   Call      'FA7060'
 ''  c                   Parm                    ArtCve
 ''  c                   Parm                    Fectra
 ''  c                   Parm                    Costo
 ''   *
L003 c                   EndSr
L003  *-------------------------------------------------------------
 ''   *  Buscar precio de la semana de los productos regulados     -
 ''   *-------------------------------------------------------------
 ''  c     Buscar_Precio BegSr
 ''  c     *Like         Define    xArtPml       Precio
     c                   Clear                   Precio
 ''   *
      //Si es un pre-pago debe buscar el precio de la Orden
     c                   If        TipDoc = 5 Or TipDoc = 6
     c                   Eval      FechaPrecio = FecOrd
     c                   Else
     c                   Eval      FechaPrecio = FecTra
     c                   EndIf
 ''   *
 ''  c                   Call      'IV7004'
 ''  c                   Parm                    ArtCve
 ''  c*                  Parm                    Fectra
 ''  c                   Parm                    FechaPrecio
 ''  c                   Parm                    Precio
 ''   *
L003 c                   EndSr
L001  *-------------------------------------------------------------
 ''   *  Buscar El costo en las empresas que no manejan existencia -
 ''   *-------------------------------------------------------------
 ''  c     Buscar_Costo_EBegSr
 ''  c     *Like         Define    xArtCpl       CostoPro
 ''  c     *Like         Define    xArtCul       CostoUlt
 ''  c                   Clear                   CostoPro
 ''  c                   Clear                   CostoUlt
 ''  c                   Clear                   Total_Can        13 2
 ''   *
 ''  c                   Call      'FA7061'
 ''  c                   Parm                    ArtCve
 ''  c                   Parm                    FecAmd
 ''  c                   Parm                    CostoPro
 ''  c                   Parm                    CostoUlt
 ''  c                   Parm                    Total_Can
 ''   *
L001 c                   EndSr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
     c                   Clear                   ManejaExist       1
L001  *  Codigo trans. entrada inventario Automatica Pelicano
 ''  c                   Eval      CodParametro = 0051
 ''  c                   Exsr      Parametros
 ''  c                   Movel(p)  ValorAlf      ManejaExist
L001  *
L007  * Compensacion Activado
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0052
 ''  c                   Exsr      Parametros
 ''  c                   Eval      Compen = ValorAlf
 ''   *
 ''   * Codigo Articulo Diesel Regural
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0053
 ''  c                   Exsr      Parametros
 ''  c                   Eval      Cod001 = ValorAlf
 ''   *
 ''   * Codigo Articulo Diesel Regular Compensado
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0054
 ''  c                   Exsr      Parametros
 ''  c                   Eval      Cod002 = ValorAlf
L007  *
L004  *  Porciento descuento impuesto anticipo ventas al Gobierno
 ''  c                   Clear                   PorAnt            5 2
 ''  c                   Clear                   Por_ImpAnt        7 4
 ''   *
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0055
 ''  c                   Exsr      Parametros
 ''  c                   Eval      PorAnt = ValorNum
L004 c                   Eval(Rh)  Por_ImpAnt = PorAnt / 100
L007  *
 ''   * Codigo Articulo Diesel Optimo Compensado
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0062
 ''  c                   Exsr      Parametros
 ''  c                   Eval      Cod003 = ValorAlf
      *
     c                   EndSr
L001  * ----------------------------------------------------------
 ''   * Parametros del sistema                                   -
 ''   * ----------------------------------------------------------
 ''  c     Parametros    BegSr
 ''  c                   Call      'SG7009'                             60
 ''  c                   Parm                    Sistema
 ''  c                   Parm                    CodParametro
 ''  c                   Parm                    ValorNum
 ''  c                   Parm                    ValorAlf
 ''   *
L001 c                   Endsr
M001  *-----------------------------------------------------
 ''   *  Enviar el Documento para Crear el QR para la DGII -
 ''   *-----------------------------------------------------
 ''  c     EnviarDGII    BegSr
 ''
 ''   // Tipo de documento internto de la interfaz de Facturacion Electronica
 ''   //  (definidos en FE_TIPOS_DOCUMENTO -FETIPDOC-) :
 ''   //
 ''   //  FACP = Factura de Productos
 ''   //  FACS = Factura de Servicios
 ''   //  NCRD = Nota de Crédito por Devolución
 ''   //  NCRA = Nota de Crédito Administrativa
 ''  c                   Eval      TipoDocInterno = 'FACP'
 ''   // tipoDocInterno definido como alfanumerico de longitud 4
 ''   *
 ''  c                   Call      'FE3003A'                              60
 ''  c                   Parm                    DisCve
 ''  c                   Parm                    TipDoc
 ''  c                   Parm                    DtoNro
 ''  c                   Parm                    TipoDocInterno
 ''   *
M001 c                   EndSr
        // -----------------------------------------------------
        // Actualiar el detalle de la planilla                 -
        // -----------------------------------------------------
       BegSr Planillas;

          Exec Sql
           Update FacPlad Set PlaOri = 'F'
            Where (DisCve = :Distrito)
              And (OrdNro = :OrdNum)
              And (OrdAmd = :OrdFec)
              And (CliCve = :CliCve)
              And (PlaOri = 'P')
              And (PlaSta = 'A')      ;

       EndSr;
        // -----------------------------------------------------
        // Actualiar el detalle de la Transferencia            -
        // -----------------------------------------------------
       BegSr Transferencias ;

          Exec Sql
           Update FacTddd Set TddOri = 'F'
            Where (DisCve = :Distrito)
              And (OrdNro = :OrdNum)
              And (OrdAmd = :OrdFec)
              And (CliCve = :CliCve)
              And (TddOri = 'P')      ;

       EndSr;
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
       BegSr *Inzsr;

      //Buscar Informaciones de Parametros
          SqlItePar = *Blanks    ;

              Exec Sql
                Select *
                  Into :SqlItePar
                  From ItePar
                 Where (ParCve = :ParCve)
         Fetch First 1 Rows Only       ;

        SqlCod = *Zeros;

      //Buscar Informaciones de la Compañia
          SqlSegCia = *Blanks    ;

              Exec Sql
                Select *
                  Into :SqlSegCia
                  From SegCia
                 Where (CiaCve = :NumCia)
         Fetch First 1 Rows Only       ;

        SqlCod = *Zeros;

           CampoAlf = %Trim(SqlSegcia.CiaRnc)  ;
           EliminarAlf(CampoAlf :StatusAlf);
           CiaRnc = %Trim(CampoAlf)        ;

       EndSr;
       // ----------------------------------------------------------
