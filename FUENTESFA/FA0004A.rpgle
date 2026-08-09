     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1999')
     H   DEBUG OPTION(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0004A                          *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 06 / 10 / 99                     *
      *  DESCR:                                                          *
      *            Alta a detalle de pedidos                             *
      *  --------------------------------------------------------------- *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 21 / 09 / 2002                   *
      *  Descripcion:                                                    *
      *          Agregar el manejo de las listas de precios.             *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 25 / 06 / 2010                   *
      *  DESCR: Agregar modificacion que permita facturar algunos        *
      *         productos en otra empresa que no sea la asignada en los  *
      *         parametros.  Idef. L099                                  *
      *  ----------------------------------------------------------------*
      * Modificado por ..............: Luis J. Miranda V.               *
      * Fecha de modificacion........: 11 / 20 / 2021                   *
      * DESCR: Agregar Validacion para que no puedan facturar producto  *
      *        compensado si no tiene disponible L008                   *
      *  ----------------------------------------------------------------*
      * Modificado por ..............: Luis J. Miranda V.               *
      * Fecha de modificacion........: 05 / 03 / 2024                   *
      * DESCR: Transparentar el Descuento en las facturas L009          *
      *  ================================================================*
     ffacordh01 uf   e           k disk
     ffacordd01 uf a e           k disk
     ffacdem01  uf   e           k disk
     fcxccli01  If   e           k disk
     fCxcAdc01  If   e           k disk    Prefix(x)
     finvart01  If   e           k disk
     finvalm01  If   e           k disk
     finvral01  If   e           k disk    prefix(y)
     finvual01  If   e           k disk
     finvund01  If   e           k disk
     finvexi01  uf   e           k disk
     finvext01  uf   e           k disk
     fsegdis01  If   e           k disk
     fFacPdu01  If   e           k disk
     ffaclpcd01 if   e           k disk    prefix(l)
     FCxcDpr01  If   e           k disk
     FCxcDpn01  If   e           k disk
L008 fPelAgrd02 If   e           k Disk    Prefix(C_)
L007 fPelRes01jnIf   e           k disk    PreFix(z)
     fFA0004Afm cf   e             workstn
      *
     d tx              s             40    dim(02) ctdata perrcd(1)
L099 d Factura_Cia3    S               n
        // Campos Usado en el programa
L008 d Cantidad_Comp   s             14  2 Inz(*Zeros)
L008 d Cantidad_Dife   s             14  2 Inz(*Zeros)
L008 d Cantidad_Asig   s             14  2 Inz(*Zeros)
L008 d MonDesSub       s             12  2 Inz(*Zeros)
L009 d MonDesDtf       s             12  2 Inz(*Zeros)
      *
L001  * Parametros
 ''  d Sistema         s              2    inz('FA')
 ''  d CodParametro    s              4  0 inz(*Zeros)
 ''  d ValorNum        s             30 15 inz(*Zeros)
 ''  d ValorAlf        s            100    inz(*Blank)
L008 d Compen          s              1    Inz(*Blanks)
L008 d Cod001          s             20    Inz(*Blanks)
L008 d Cod002          s             20    Inz(*Blanks)
 ''  d Cod003          s             20    Inz(*Blanks)
 ''  d Cod999          s             20    Inz(*Blanks)
L008 d Cliente_Sind    s               n
 ''   *
L001  /Copy Fuentes,SG9001
 ''   *
     iFacPduf
     i              DisCve                      wDisCve
     i              AlmCve                      wAlmCve
      * --------------------------------------------------------
      *                  BLOQUE PRINCIPAL                      -
      * --------------------------------------------------------
     c     *entry        plist
     c                   parm                    Distrito
     c                   parm                    numero
     c                   parm                    sec
     c                   parm                    tib               1 0
     c                   parm                    wf03              3
     c                   parm                    PgmOrigen         1 0
      *
     c     Clave_Ordh    Klist
     c                   Kfld                    Distrito
     c                   Kfld                    Numero
      *
     c     clave_ortd    klist
     c                   kfld                    Distrito
     c                   kfld                    ordnro
     c                   kfld                    secuen
      *
     c     clave_alm     klist
     c                   kfld                    distrito
     c                   kfld                    almcve
      *
     c     Clave_Pdu     Klist
     c                   Kfld                    User
     c                   Kfld                    Distrito
     c                   Kfld                    AlmCve
      *
     c     clave_exi     klist
     c                   kfld                    artcve
     c                   kfld                    discve
     c                   kfld                    almcve
      *
     c     clave_ral     klist
     c                   kfld                    artcve
     c                   kfld                    distrito_1
     c                   kfld                    almcve_1
      *
     c     clave_rau     klist
     c                   kfld                    artcve
     c                   kfld                    ordund
      *
     c     clave_lpcd    klist
     c                   kfld                    adcclp
     c                   kfld                    artcve
      *
     c     Clave_Dpr     klist
     c                   kfld                    CliCve
     c                   kfld                    ArtCve
      *
     c     Clave_Dpn     klist
     c                   kfld                    CliCve
     c                   kfld                    ArtCve
      *
     c     Clave_Resd    klist
     c                   kfld                    CliCve
     c                   kfld                    ResNro
     c                   kfld                    ArtCve
      *
     c                   exsr      consta
     c                   exsr      bloque
     c                   move      *on           *inlr
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     consta        begsr
     c     *like         define    discve        distrito
     c     *like         define    discve        distrito_1
     c     *like         define    almcve        almcve_1
     c     *like         define    exicdi        exist_real
     c     *like         define    exicdi        cantid_tra
     c     *like         define    ordcde        cantid_crt
     c     *like         define    ordcde        cantid_crt1
     c     *like         define    artcuv        cantid_alm
     c     *like         define    almcve        almacen
     c     *like         define    ordund        unidad_1
     c     *like         define    ordpve        difere
     c     *like         define    ordpve        precuv
     c     *like         define    ordpve        preual
     c     *like         define    ordpve        precio
     c     *like         define    ordpve        pmlart
     c     *like         define    ordnro        numero
     c     *like         define    ordsec        sec
     c     *like         define    ordsec        secuen
      *
      * Buscar Parametros Generales
     c                   Exsr      PrnGenerales
      *
     c                   eval      DisCve = Distrito
     c                   eval      ordnro = numero
     c                   exsr      chenea_1
      *
      * Si tib = 1 indica que se esta modificando el registro
      *   y el programa debe finalizar inmediatamente sea modificado
      *
      * Si tib = 2 indica que se esta adicionando registro
      *
     c                   if        tib = 2
     c     sec           add       1             secuen
     c                   move      'PANTA1  '    flag1             8
     c                   eval      wtxt = tx(1)
     c                   exsr      chenea
     c                   else
      *
     c                   eval      wtxt = tx(2)
     c                   eval      secuen = sec
     c                   exsr      chenea
L001  * Para proteger los campos de descuento
 ''  c                   If        PgmOrigen = 2
 ''  c                   Eval      *In47 = *On
 ''  c                   Else
 ''  c                   Eval      *In47 = *Off
L001 c                   Endif
      *
     c     artcve        chain(n)  invartf                            99
      *
      * Si es un producto regulado
     c                   If        ArtPpr = 'S'
     c                   Exsr      PrecioRegulado
     c                   Else
      * Para buscar el precio en la lista de precio
     c                   Exsr      Busca_Precio
     c                   Endif
      * Buscar Descuento en productos regulados o No regulados
     c                   Exsr      Buscar_Desc
      *
L001 c                   If        ArtMce = 'S'
     c                   Eval      OrdPve = PmlArt
L001 c                   Else
L001 c                   Eval      PmlArt = OrdPve
L001 c                   EndIf
      *
     c     ordund        chain(n)  invundf                            90
     c                   eval      unidad = undsig
     c                   eval      unidad_1 = ordund
     c                   exsr      buscar_exi
      *
     c                   write     FA0004A01
     c                   move      'PANTA2  '    flag1             8
      *
L008  * Si es compensado debe poner el descuento segun parametro
 ''  c                   If        Cliente_Sind = *On And Compen = 'S'
 ''  c                             And (Cod002 = ArtCve Or Cod003 = ArtCve)
 ''  c                   Clear                   OrdVde
 ''  c                   Clear                   OrdId1
 ''  c                   EndIf
      *
     c                   endif
      *
     c                   endsr
      * ----------------------------------------------------------
      *          CICLO DE FORMATOS DE PANTALLAS                  -
      * ----------------------------------------------------------
     c     bloque        begsr
     c     flag1         downe     'FIN     '
     c                   exsr      panta1
     c                   exsr      panta2
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           Desplegar 1er. panel                           -
      * ----------------------------------------------------------
     c     panta1        begsr
     c     flag1         doweq     'PANTA1  '
     c                   exfmt     FA0004A01
     c                   exsr      error_clr
      *
     c                   if        *in03 = *on or *in12 = *on
     c                   eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *in03
     c                   move      'F03'         wf03
     c                   endif
      *
     c     *in04         caseq     *on           listaf4
     c     *in10         caseq     *on           rel_art_alm
     c                   endcs
      *
     c                   if        not *in03 and not *in12
     c                             and not *in04 and not *in10
     c                   exsr      cheq
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           Desplegar 2do. panel                           -
      * ----------------------------------------------------------
     c     panta2        begsr
L008  *
 ''  c                   Clear                   OrdVde
 ''  c                   Clear                   OrdId1
L008  *
     c     flag1         doweq     'PANTA2  '
     c                   exfmt     FA0004A02
     c                   exsr      error_clr
      *
     c                   if        *in03 = *on or *in12 = *on
     c                   eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *in03 = *on or
     c                             *in12 = *on  and tib = 1
     c                   move      'F03'         wf03
     c                   eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *in12 = *on  and tib = 2
     c                   eval      flag1 = 'PANTA1  '
     c                   endif
      *
     c     *in04         caseq     *on           listaf4
     c                   endcs
      *
     c                   if        not *in03 and not *in12
     c                             and not *in04
     c                   exsr      valid1
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *             Validar datos                                -
      * ----------------------------------------------------------
     c     cheq          begsr
     c                   setoff                                       303132
     c                   setoff                                       337172
      *
      * Articulo no existe
     c     artcve        chain(n)  invartf                            30
      *
     c                   if        *in30 = *on
     c                   eval      msgid = 'INV0036'
     c                   exsr      error_snd
     c                   else
      *
      * Articulo no esta activo
     c                   if        artsta <> 'A'
     c                   eval      *in30 = *on
     c                   eval      msgid = 'INV0036'
     c                   exsr      error_snd
     c                   else
      *
      * Articulo no maneja control de existencia
     c                   if        artmce = 'N'
     c                   eval      *in30 = *on
     c                   eval      msgid = 'INV0022'
     c                   exsr      error_snd
     c                   else
      *
      * Articulo no esta relacionado al almacen
     c                   eval      distrito_1 = distrito
     c                   eval      almcve_1 = almcve
     c     clave_ral     chain(n)  invralf                            30
      *
     c                   if        *in30 = *on
     c                   eval      msgid = 'INV0023'
     c                   exsr      error_snd
     c                   else
      *
     c                   exsr      blanco
     c                   eval      *in72 = *on
     c                   eval      ordund = artuve
      *
      * Para buscar el precio en la lista de precio
     c                   exsr      busca_precio
      * Buscar Descuento en productos regulados o No regulados
     c                   Exsr      Buscar_Desc
      *
L001 c                   If        ArtMce = 'S'
     c                   Eval      OrdPve = PmlArt
L001 c                   Else
L001 c                   Eval      PmlArt = OrdPve
L001 c                   EndIf
      *
     c     artuve        chain(n)  invundf                            90
     c                   eval      unidad = undsig
     c                   exsr      buscar_exi
      *
L008  * Si es compensado debe poner el descuento segun parametro
 ''  c                   If        Cliente_Sind = *On And Compen = 'S'
 ''  c                             And (Cod002 = ArtCve Or Cod003 = ArtCve)
      *
 ''  c                   If        ResNro <> *HiVal
 ''  c     Clave_Resd    Chain     PelResdf                           35
 ''  c                   If        %Found(PelRes01jn)
     c                   Eval(Rh)  MonDesSub = zResMds * 1
 ''  c                   EndIf
 ''  c                   EndIf
L008  *
 ''  c                   Clear                   OrdVde
 ''  c                   Clear                   OrdId1
 ''  c                   EndIf
      *
     c                   move      'PANTA2  '    flag1             8
     c                   endif
     c                   endif
     c                   endif
     c                   endif
     c                   endsr
      * ----------------------------------------------------------
      *             Validar datos                                -
      * ----------------------------------------------------------
     c     valid1        begsr
     c                   setoff                                       303132
     c                   setoff                                       337172
     c                   setoff                                       353699
      *
     c                   Do
      *
      * Validar unidad
      * Si es diferente a la de almacenamiento debe
      * existir como unidad alterna
     c                   if        ordund <> artuve
     c     clave_rau     chain(n)  invualf                            31
     c                   eval      cantid_tra = ordcde * ualcon
     c                   eval      cantid_alm = ualcon
     c                   else
      *
     c     ordund        chain(n)  invundf                            31
     c                   eval      cantid_tra = ordcde * artcuv
     c                   eval      cantid_alm = artcuv
     c                   endif
      *
      * unidad no existe en el archivo
     c                   if        *in31 = *on
     c                   eval      *in71 = *on
     c                   eval      msgid = 'INV0017'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Validar cantidad
     c                   if        ordcde <= *zeros or
     c                             ordcde > ordcan and artrpd <> 'S'
L001 c                             And PgmOrigen = 1
     c                   eval      *in32 = *on
     c                   eval      *in72 = *on
     c                   eval      msgid = 'INV0024'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
L008 c                   If        Cliente_Sind = *On And Compen = 'S'
 ''  c                             And (ArtCve = Cod002 Or ArtCve = Cod003)
     c                   Eval      Cod999 = %Trim(ArtCve)
 ''  c                   Exsr      Disp_Comp
 ''   * La Cantidad no debe ser mayor que la disponible
 ''  c
 ''  c*                  If        (Cantidad_Comp + OrdCde) > Cantidad_Dife
 ''  c                   If        (Cantidad_Comp + OrdCan) > Cantidad_Asig
 ''  c                   eval      *in32 = *on
 ''  c                   eval      *in72 = *on
 ''  c                   eval      msgid = 'FAC0101'
 ''  c                   exsr      error_snd
 ''  c                   Leave
 ''  c                   EndIf
      *
 ''  c                   If        ResNro <> *HiVal
 ''  c     Clave_Resd    Chain     PelResdf                           35
 ''  c                   If        %Found(PelRes01jn)
     c                   Eval(Rh)  MonDesSub = zResMds * 1
 ''  c                   EndIf
 ''  c                   EndIf
 ''   *
L008 c                   EndIf
      *
      * Para validar la existencia actual
     c                   if        cantid_tra > exist_real
     c                   eval      *in32 = *on
     c                   eval      *in72 = *on
     c                   eval      msgid = 'INV0030'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Valida que el precio no exceda del % de descuento que el usuario
      * esta autorizado.
      *
     c                   clear                   porc_de1          5 2
     c                   clear                   porc_de2          5 2
      *
     c                   exsr      precios_unid
      *
      * Validar valor de descuento no > precio venta
     c                   if        ordvde >= ordpve
     c                   eval      *in33 = *on
     c                   eval      msgid = 'FAC0006'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * si ordpre < precio = que fue cambiado en pantalla y se debe
      * sacar el porciento de descuento otorgado.
     c                   if        precio < ordpve
     c                   eval      difere = ordpve - precio
     c                   eval(rh)  porc_de1 = (difere / ordpve) * 100
     c                   eval      porc_de2 = porc_de1 + orddpe
     c                   eval      ordpve = precio
     c                   else
      *
     c                   eval      porc_de2 = orddpe
     c                   endif
      *
     c     User          chain(n)  FacPduf                            45
     c*    Clave_Pdu     chain(n)  FacPduf                            45
     c                   if        not *in45 and porc_de2 > pdupdd
     c                   eval      *in33 = *on
     c                   eval      *in34 = *on
     c                   eval      msgid = 'FAC0005'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   exsr      descuentos
      *
      * calculo de impuesto
      *
     c                   If        ArtImp = 'S'
     c                   Exsr      impuesto
     c                   Eval(rh)  ordii1 = ordcde * impue1
     c                   Else
     c                   Clear                   ordii1
     c                   Clear                   ordii2
     c*                  Clear                   ordid1
     c*                  Clear                   ordid2
     c                   EndIf
      *
      * si el cliente esta exento de pagar impuesto limpiar impuesto
         If CliExe = 'S' And (xTcfCve = 14 Or xTcfCve = 44
                          Or  xTcfCve = 16 Or xTcfCve = 46)
         Or CliExe = 'N' And (xTcfCve = 14 Or xTcfCve = 44
                          Or  xTcfCve = 16 Or xTcfCve = 46)    ;
     c                   clear                   ordii1
     c                   clear                   ordii2
     c                   endif
      *
     c                   if        artrpd = 'S'
     c                   exsr      cantidad_und
     c                   endif
      *
      * Adicionar o modificar
      *
     c                   if        *in99 = *off
     c     *in44         caseq     *on           wrt
     c     *in44         caseq     *off          upd
     c                   endcs
     c                   endif
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *  Cantidad en unidades productos que requieren peso       -
      * ----------------------------------------------------------
     c     cantidad_und  begsr
     c                   clear                   swfin             8
     c                   clear                   wf03
     c                   eval      *in35 = *off
      *
     c     swfin         downe     'END     '
     c                   exfmt     FA0004a03
      *
     c                   if        *in03 = *on
     c                   eval      *in99 = *on
     c                   move      'FIN     '    flag1
     c                   move      'END     '    swfin
     c                   endif
      *
     c                   if        *in12 = *on
     c                   eval      *in99 = *on
     c                   move      'END     '    swfin
     c                   endif
      *
     c                   if        *in03 = *off and *in12 = *off
      *
     c                   if        ordcud = *zeros
     c                   eval      *in35 = *on
     c                   eval      msgid = 'INV0024'
     c                   exsr      error_snd
     c                   else
      *
     c                   move      'END     '    swfin
     c                   endif
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *   Buscar                                                 -
      * ----------------------------------------------------------
     c     listaf4       begsr
     c                   setoff                                       303132
     c                   setoff                                       337172
      *
     c                   select
     c                   when      record = 'FA0004A01' and campo = 'ARTCVE'
     c                   close     invart01
     c                   call      'IV2040'
     c                   parm                    artcve
     c                   open      invart01
      *
     c                   write     FA0004A01
      *
     c                   if        artcve <> *blanks
     c                   eval      *in71 = *on
     c                   endif
      *
     c                   when      campo = 'ORDUND'
     c                   call      'IV2018'
     c                   parm                    artcve
     c                   parm                    ordund
      *
     c                   if        ordund <> *zeros
     c                   eval      *in72 = *on
     c                   endif
      *
     c                   write     FA0004A01
      *
     c                   other
     c                   eval      msgid = 'CMN0002'
     c                   exsr      error_snd
      *
     c                   endsl
     c                   endsr
      * ----------------------------------------------------------
      * Chenea archivo detalle                                   -
      * ----------------------------------------------------------
     c     chenea        begsr
     c     clave_ortd    chain     facorddf                           44
     c                   endsr
      * ----------------------------------------------------------
      * Chenea archivo cabecera                                  -
      * ----------------------------------------------------------
     c     chenea_1      begsr
     c     Clave_Ordh    chain(n)  facordhf                           99
     c     distrito      chain(n)  segdisf                            90
     c     clave_alm     chain(n)  invalmf                            90
     c     Clave_Ordh    chain(n)  facdemf                            90
     c                   Eval      NomCli = %Trim(CliNom)
     c     Clicve        chain(n)  Cxcclif                            90
     c     Clicve        chain(n)  CxcAdcf                            90
      *
L008 c     CliCve        Chain(n)  PelAgrdf                           90
 ''  c                   If        %Found(PelAgrd02) And
 ''  c                             (xTcfCve <> 12 And xTcfCve <> 32)
 ''  c                   Eval      Cliente_Sind = *On
L008 c                   EndIf
      *
     c                   endsr
      * --------------------------------------------------------
      * Sub- Rutina para asignar el precio del producto        -
      * --------------------------------------------------------
     c     Busca_precio  Begsr
     c                   If        ArtPpr <> 'S'
     c     clave_lpcd    Chain(n)  FacLpcdf
     c                   If        %found(faclpcd01)
     c                   Eval      pmlart = llpdpml * 1
     c                   Else
     c                   Eval      pmlart = artpml * 1
     c                   EndIf
      *
     c                   If        MonCve <> *Zeros
     c                   Eval(Rh)  PmlArt = PmlArt / OrdTas
     c                   EndIf
     c                   EndIf
     c                   EndSr
      * ----------------------------------------------------------
      * Adicionar                                                -
      * ----------------------------------------------------------
     c     wrt           begsr
     c                   exsr      precios_unid
     c                   exsr      descuentos
      *
 ''  c                   Eval      OrdVde = *Zeros
 ''  c                   Eval      OrdId1 = *Zeros
      *
L008  * Si es compensado debe poner el descuento segun parametro
     c                   Select
 ''  c                   When      Cliente_Sind = *On And Compen = 'S'
 ''  c                             And (Cod002 = ArtCve Or Cod003 = ArtCve)
     c                             And DprDtf <> 'S'
 ''  c                   Eval(Rh)  OrdVde = OrdCan * MonDesSub
 ''  c                   Eval(Rh)  OrdId1 = OrdCan * MonDesSub
      *
L009  * Si el descuento es Transparentado en la factura
 ''  c                   When      DprDtf = 'S' And MonDesDtf <> *Zeros
     c                             And Cliente_Sind = *On
 ''  c                   Eval(Rh)  OrdVde = OrdCan * (MonDesDtf + MonDesSub)
 ''  c                   Eval(Rh)  OrdId1 = OrdCan * (MonDesDtf + MonDesSub)
      *
L009  * Si el descuento es Transparentado en la factura
 ''  c                   When      DprDtf = 'S' And MonDesDtf <> *Zeros
     c                             And Cliente_Sind = *Off
 ''  c                   Eval(Rh)  OrdVde = OrdCan * MonDesDtf
 ''  c                   Eval(Rh)  OrdId1 = OrdCan * MonDesDtf
 ''  c                   EndSl
L009  *
     c                   eval(rh)  ordimp = ordcde * ordpve
     c                   eval      ordcdx = cantid_tra
     c                   eval      ordsec = secuen
     c                   eval      ordnro =  numero
     c                   write     facorddf
      *
     c                   exsr      blanco
      *
     c                   eval      secuen = secuen + 1
     c                   exsr      chenea
     c                   eval      flag1 = 'PANTA1  '
     c                   endsr
      * ----------------------------------------------------------
      * Modificar
      * ----------------------------------------------------------
     c     upd           begsr
     c                   exsr      precios_unid
     c                   exsr      descuentos
      *
 ''  c                   Eval      OrdVde = *Zeros
 ''  c                   Eval      OrdId1 = *Zeros
      *
L008  * Si es compensado debe poner el descuento segun parametro
     c                   Select
 ''  c                   When      Cliente_Sind = *On And Compen = 'S'
 ''  c                             And (Cod002 = ArtCve Or Cod003 = ArtCve)
     c                             And DprDtf <> 'S'
 ''  c                   Eval(Rh)  OrdVde = OrdCan * MonDesSub
 ''  c                   Eval(Rh)  OrdId1 = OrdCan * MonDesSub
      *
L009  * Si el descuento es Transparentado en la factura
 ''  c                   When      DprDtf = 'S' And MonDesDtf <> *Zeros
     c                             And Cliente_Sind = *On
 ''  c                   Eval(Rh)  OrdVde = OrdCan * (MonDesDtf + MonDesSub)
 ''  c                   Eval(Rh)  OrdId1 = OrdCan * (MonDesDtf + MonDesSub)
      *
L009  * Si el descuento es Transparentado en la factura
 ''  c                   When      DprDtf = 'S' And MonDesDtf <> *Zeros
     c                             And Cliente_Sind = *Off
 ''  c                   Eval(Rh)  OrdVde = OrdCan * MonDesDtf
 ''  c                   Eval(Rh)  OrdId1 = OrdCan * MonDesDtf
 ''  c                   EndSl
L009  *
     c                   eval(rh)  ordimp = ordcde * ordpve
     c                   eval      ordcdx = cantid_tra
     c                   update    facorddf
     c                   move      'FIN     '    flag1
     c                   endsr
      * ----------------------------------------------------------
      *  Calcular precios en unidades de ventas y almacenamiento -
      * ----------------------------------------------------------
     c     precios_unid  begsr
     c                   if        ordund = artuve
     c                   eval      precio = (pmlart - ordvde)
     c*                  eval      precio = (pmlart - ordvde) + ordid2
     c                   else
     c                   eval(rh)  precio = ((pmlart / artcuv) - ordvde)
     c*                  eval(rh)  precio = ((pmlart / artcuv) - ordvde) +
     c*                            ordid2
     c                   endif
      *
     c                   eval      ordpve = precio
     c                   endsr
      * ----------------------------------------------------------
      *  Calcular los descuentos en detalles                     -
      * ----------------------------------------------------------
     c     descuentos    begsr
      *
      * calculo del descuento en detalle
     c                   Clear                   descue           16 6
     c                   Clear                   PorDes            7 4
     c                   if        orddpe <> *zeros
     c                   eval(rh)  pordes = orddpe / 100
     c                   eval(rh)  descue = precio * pordes
     c                   eval(rh)  ordid1 = ordcde * descue
     c                   else
     c                   clear                   ordid1
     c                   endif
     c                   endsr
      * ----------------------------------------------------------
      *   Relacion articulo almacen                              -
      * ----------------------------------------------------------
     c     rel_art_alm   begsr
     c                   if        *in30 = *on and artcve <> *blank
     c                   close     invart01
     c                   call      'IV0008M'
     c                   parm                    artcve
     c                   open      invart01
     c                   endif
      *
     c                   endsr
      * ----------------------------------------------------------
      * Buscar existencia del articulo                           -
      * ----------------------------------------------------------
     c     buscar_exi    begsr
L099  * Este Programa verifica si esta factura tiene productos que son
 ''   * facturados por la CIA3
 ''  c                   Exsr      Verifica_Cia3
      *
      * Existencia total
     c     artcve        chain(n)  invextf                            93
     c                   eval      exist_real = extcdi - (extcre + extcrt)
L001  *
L099 c*                  If        ManejaExist = 'N'
L099 c                   If        ManejaExist = 'N' Or Factura_Cia3 = *On
 ''  c                   Eval      Exist_Real = *Hival
L001 c                   EndIf
      *
     c                   if        exist_real > *zeros
     c                   eval      existencia = exist_real
     c                   exsr      convertir
     c                   eval      existe_tot = cantidad
     c                   eval      existe_unt= unidades
      *
     c                   else
     c                   clear                   existe_tot
     c                   clear                   existe_unt
     c                   endif
      *
     c     clave_exi     chain(n)  invexif                            93
      *
     c                   eval      exist_real = exicdi - (exicre + exicrt)
L001  *
L099 c*                  If        ManejaExist = 'N'
L099 c                   If        ManejaExist = 'N' Or Factura_Cia3 = *On
 ''  c                   Eval      Exist_Real = *Hival
L001 c                   EndIf
      * Para adicionar en el momento de modificar la cantidad que se habia
      * reservado anteriormente.
     c                   if        tib = 1
     c                   eval      exist_real = exist_real + cantid_crt
     c                   endif
      *
     c                   if        exist_real > *zeros
     c                   eval      existencia = exist_real
     c                   exsr      convertir
     c                   eval      existe_alm = cantidad * 1
     c                   eval      existe_und = unidades * 1
      *
     c                   else
     c                   clear                   existe_alm
     c                   clear                   existe_und
     c                   clear                   exist_real
     c                   endif
      *
     c                   endsr
      * ----------------------------------------------------------
      *  Rutina para pasar existencia y recibir cantidad y unidad-
      * ----------------------------------------------------------
     c     convertir     begsr
     c                   clear                   cantidad         12 2
     c                   clear                   unidades         12 0
     c                   move      'V'           almven            1
      *
     c                   call      'IV7003'
     c                   parm                    artcve
     c                   parm                    existencia       12 2
     c                   parm                    cantidad
     c                   parm                    unidades
     c                   parm                    almven
      *
     c                   endsr
      * --------------------------------------------------------
      * Para calcular los impuesto                             -
      * --------------------------------------------------------
     c     impuesto      begsr
      *
     c     *like         define    ordpve        predi1
     c     *like         define    ordpve        predi2
      *
     c                   clear                   predi1
     c                   clear                   predi2
     c                   clear                   impue1           16 6
     c                   clear                   impue2           16 6
      *
     c                   call      'SG7005'
     c                   parm                    artcve
     c                   parm                    precio
     c                   parm                    predi1
     c                   parm                    impue1
     c                   parm                    predi2
     c                   parm                    impue2
      *
     c                   endsr
      * --------------------------------------------------------
      * Borrar campos                                          -
      * --------------------------------------------------------
     c     blanco        begsr
     c                   clear                   ordund
     c                   clear                   ordcud
     c                   clear                   ordcdx
     c                   clear                   ordcde
     c                   clear                   ordpve
     c                   clear                   ordimp
     c                   clear                   ordii1
     c                   clear                   ordii2
     c*                  clear                   ordid1
     c*                  clear                   ordid2
     c                   clear                   orddpe
     c                   endsr
      * --------------------------------------------------------
      * Para buscar el precio de los productos regulados       -
      * --------------------------------------------------------
     c     PrecioReguladoBegsr
      *
     c     *Like         Define    ArtPml        PrecioReg
     c                   Clear                   PrecioReg
     c*                  Move      FecOrd        FecDia            8 0
     c                   Move      *Date         FecDia            8 0
      *
     c                   Call      'IV7004'                             60
     c                   Parm                    ArtCve
     c                   Parm                    FecDia
     c                   Parm                    PrecioReg
      *
     c                   Eval      PmlArt = PrecioReg * 1
      *
     c                   If        MonCve <> *Zeros
     c                   Eval(Rh)  PmlArt = PmlArt / OrdTas
     c                   EndIf
      *
     c                   EndSr
L008  * ----------------------------------------------------------
 ''   *  Buscar Cantidad Disponible Productos Compensando        -
 ''   * ----------------------------------------------------------
 ''  c     Disp_Comp     Begsr
 ''  c                   Clear                   Cantidad_Comp
 ''  c                   Clear                   Cantidad_Dife
 ''  c                   Clear                   Cantidad_Asig
 ''   *
 ''  c                   Call      'FA7012'
 ''  c                   Parm                    Distrito
 ''  c                   Parm                    Numero
 ''  c                   Parm                    CliCve
 ''  c                   Parm                    ResNro
 ''  c                   Parm                    Cod999
 ''  c                   Parm                    Cantidad_Comp
 ''  c                   Parm                    Cantidad_Dife
 ''  c                   Parm                    Cantidad_Asig
L008 c                   EndSr
      * --------------------------------------------------------
      * Para buscar los descuentos x clientes                  -
      * --------------------------------------------------------
     c     Buscar_Desc   Begsr
      *
     c     *Like         Define    OrdVde        ValorDesc
     c                   Clear                   ValorDesc
L009 c                   Clear                   MonDesDtf
      *
     c                   Select
     c                   When      ArtPpr = 'S'
     c     Clave_Dpr     Chain     CxcDprf                            55
     c                   If        %Found(CxcDpr01)
     c                   If        DprPde <> *Zeros
     c                   Eval(Rh)  ValorDesc = (PmlArt * DprPde) / 100
     c                   EndIf
      *
     c                   Eval      ValorDesc += DprVde
     c                   EndIf
      *
     c                   When      ArtPpr = 'N'
     c     Clave_Dpn     Chain     CxcDpnf                            55
     c                   If        %Found(CxcDpn01)
     c                   If        DpnPde <> *Zeros
     c                   Eval(Rh)  ValorDesc = (PmlArt * DpnPde) / 100
     c                   EndIf
      *
     c                   Eval      ValorDesc = ValorDesc + DpnVde
     c                   EndIf
      *
     c                   EndSl
      *
L009 c*                  Eval      PmlArt = (PmlArt + OrdId2) - ValorDesc
     c*                  Eval      PmlArt = PmlArt - ValorDesc
L009  *
 ''   * Si el descuento es transparente en la factura
 ''  c                   If        DprDtf = 'S'
 ''  c                   Eval      MonDesDtf = ValorDesc
 ''  c                   Else
 ''  c                   Clear                   MonDesDtf
L009 c                   Eval      PmlArt = (PmlArt + OrdId2) - ValorDesc
L009 c                   EndIf
     c                   EndSr
L099  *-----------------------------------------------------
 ''   *  Verifica productos facturados Cia3                -
 ''   *-----------------------------------------------------
 ''  c     Verifica_Cia3 BegSr
 ''   *
 ''  c     *Like         Define    ArtPve        PveArt
 ''  c                   Eval      Factura_Cia3 = *Off
 ''   * Verifica productos
 ''  c                   Close     FacOrdh01
 ''  c                   Close     FacDem01
 ''   *
 ''  c                   Call      'FA7054'
 ''  c                   Parm                    Distrito
 ''  c                   Parm                    Numero
 ''  c                   Parm                    PveArt
 ''  c                   Parm                    Factura_Cia3
 ''   *
 ''  c                   Open      FacOrdh01
 ''  c                   Open      FacDem01
 ''   *
 ''  c     Clave_Ordh    Chain     FacOrdhf                           02
 ''  c     Clave_Ordh    Chain     FacDemf                            02
L099 c                   EndSr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
     c                   Clear                   ManejaExist       1
L001  *  Codigo trans. entrada inventario Automatica Pelicano
 ''  c                   Eval      CodParametro = 0051
 ''  c                   Exsr      Parametros
 ''  c                   Movel(p)  ValorAlf      ManejaExist
L001  * Compensacion Activado
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0052
 ''  c                   Exsr      Parametros
 ''  c                   Eval      Compen = ValorAlf
 ''   * Codigo Articulo Diesel Regural
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0053
 ''  c                   Exsr      Parametros
 ''  c                   Eval      Cod001 = ValorAlf
 ''   * Codigo Articulo Diesel Regular Compensado
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0054
 ''  c                   Exsr      Parametros
 ''  c                   Eval      Cod002 = ValorAlf
L008  * Monto Descuento x Galon Subsidiado
 ''  c                   Eval      Sistema = 'FA'
 ''  c                   Eval      CodParametro = 0061
 ''  c                   Exsr      Parametros
L008 c                   Eval      MonDesSub= ValorNum * 1
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
 ''  c     Parametros    Begsr
 ''  c                   Call      'SG7009'                             60
 ''  c                   Parm                    Sistema
 ''  c                   Parm                    CodParametro
 ''  c                   Parm                    ValorNum
 ''  c                   Parm                    ValorAlf
 ''   *
L001 c                   Endsr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *inzsr        begsr
      *
      * Enviar mensaje de error
     c     msglis        plist
     c                   parm                    msgid             7
     c                   parm                    msgpgm           10
     c                   parm                    msgdta           80
      *
      * Borrar mensaje de error
     c     msgclr        plist
     c                   parm                    msgpgm
     c                   movel     '*'           @msgq
      *
     c                   eval       *in80 = *on
     c                   write     msgctl
     c                   endsr
      * -----------------------------------------------------------
      *  Limpiar cola de mensaje                                  -
      * -----------------------------------------------------------
     c     error_clr     begsr
      * Limpiar mensaje
     c                   call      'SEGMSGJ2'    msgclr
     c                   write     msgctl
     c                   endsr
      * -----------------------------------------------------------
      *  Subrutina para retornar la descripcion de un mensaje     -
      *  desde un archivo de mensaje
      * -----------------------------------------------------------
     c     error_snd     begsr
     c                   call      'SEGMSGJ1'    MSGLIS
     c                   write     msgctl
      *
     c                   endsr
      *
      * -----------------------------------------------------------
**
        Alta a detalle de pedido
       Cambio a detalle de pedido
