     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1999')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0002A                          *
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
      *  --------------------------------------------------------------- *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 28 / 05 / 2003                   *
      *  Descripcion:                                                    *
      *          Modificar control descuento por usuarios.               *
      *  --------------------------------------------------------------- *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 20 / 12 / 2007                   *
      *  Descripcion:                                                    *
      *          Agregar control para el manejo del combustible          *
      *          Compensado segun decreto 667-2007. L001                 *
      *  ----------------------------------------------------------------*
      * Modificado por ..............: Luis J. Miranda V.               *
      * Fecha de modificacion........: 21 / 04 / 2014                   *
      * DESCR: Agregar campo numero de resolucion para los productos    *
      *        Inicialmente solo se esta grabando los productos         *
      *        compensado, pero este archivo se puede usar para         *
      *        cualquier otra informacion adicional en detalle. L007    *
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
     ffacorth01 Uf   e           k disk
     ffacortd01 Uf a e           k disk
     ffacortd02 Uf   e           k disk    rename(facortdf:entrada) prefix(x)
     fFacDem01  If   e           k disk
     finvart01  If   e           k disk
L007 fPelRes01jnIf   e           k disk    PreFix(z)
     ffaclpcd01 If   e           k disk    prefix(l)
     fcxccli01  If   e           k disk
     fcxcadc01  If   e           k disk    prefix(t)
     finvalm01  If   e           k disk
     finvral01  If   e           k disk    prefix(y)
     finvual01  If   e           k disk
     finvund01  If   e           k disk
     finvexi01  Uf   e           k disk
     finvext01  Uf   e           k disk
     fsegdis01  If   e           k disk
     Ffacpdu01  If   e           k disk
     FCxcDpr01  If   e           k disk
     FCxcDpn01  If   e           k disk
     fInvRap01  If   e           k disk
L001 fPelAgrd02 If   e           k Disk    Prefix(C_)
     fFA0002Afm cf   e             workstn
      *
     d tx              s             40    dim(02) ctdata perrcd(1)
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
 ''  d Compen          s              1    Inz(*Blanks)
 ''  d Cod001          s             20    Inz(*Blanks)
 ''  d Cod002          s             20    Inz(*Blanks)
 ''  d Cod003          s             20    Inz(*Blanks)
 ''  d Cod999          s             20    Inz(*Blanks)
 ''  d Cliente_Sind    s               n
 ''  d FechaIso        s               d   Datfmt(*Iso)
 ''  d OrdFec_Amd      s              8  0 Inz(*Zeros)
 ''  d FecDia          s              8  0 Inz(*Zeros)
 ''   *
L001  /Copy Fuentes,SG9001
      *
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
      *
     c     Clave_Orth    Klist
     c                   Kfld                    Distrito
     c                   Kfld                    Numero
      *
     c     clave_ortd    klist
     c                   kfld                    DisCve
     c                   kfld                    ordnro
     c                   kfld                    secuen
      *
     c     clave_4       klist
     c                   kfld                    Distrito
     c                   kfld                    OrdNro
     c                   kfld                    ArtCve
     c                   kfld                    OrdUnd
      *
     c     Clave_Pdu     Klist
     c                   Kfld                    User
     c                   Kfld                    Distrito
     c                   Kfld                    AlmCve
      *
     c     clave_alm     klist
     c                   kfld                    distrito
     c                   kfld                    almcve
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
     c                   kfld                    tadcclp
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
     c     Clave_Rap     KList
     c                   Kfld                    ArtCve
     c                   Kfld                    ProCve
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
     c     *like         define    ordcan        cantid_crt
     c     *like         define    ordcan        cantid_crt1
     c     *like         define    artcuv        cantid_alm
     c     *like         define    almcve        almacen
     c     *like         define    ordund        unidad_1
     c     *like         define    ordpve        difere
     c     *like         define    ordpve        precuv
     c     *like         define    ordpve        preual
     c     *like         define    ordpve        precio
     c     *like         define    ordpve        prepml
     c     *like         define    ordpve        pmlart
     c*    *like         define    orddpe        pordes
     c     *like         define    ordnro        numero
     c     *like         define    ordsec        sec
     c     *like         define    ordsec        secuen
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
L001  *
 ''   * Para Controlar los clientes Compensados
 ''  c                   If        Cliente_Sind = *On And Compen = 'S'
     c                             And OrdFec_Amd > 20071219
 ''  c                   Eval      ArtCve = Cod002
 ''  c                   EndIf
L001  *
     c                   exsr      chenea
     c                   else
      *
     c                   eval      wtxt = tx(2)
     c                   eval      secuen = sec
     c                   exsr      chenea
      *
     c     ArtCve        chain(n)  invartf                            99
      *
     c                   If        ArtMce = 'N'
      *
     c                   Write     FA0002A01
     c                   Move      'PANTA4  '    flag1             8
     c                   Else
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
     c     artuve        chain(n)  invundf                            90
     c                   eval      unidad = undsig
     c                   eval      unidad_1 = ordund
      *
     c     ordund        chain(n)  invundf                            90
     c                   eval      desund = undsig
     c                   exsr      buscar_exi
      *
     c                   write     FA0002A01
      *
     c                   If        Cliente_Sind = *On And Compen = 'S'
     c                   Eval      Flag1 = 'PANTA5  '
     c                   Else
     c                   Eval      Flag1 = 'PANTA2  '
     c                   EndIf
      *
     c                   Endif
     c                   EndIf
      *
     c                   endsr
      * ----------------------------------------------------------
      *          CICLO DE FORMATOS DE PANTALLAS                  -
      * ----------------------------------------------------------
     c     bloque        Begsr
     c     flag1         Downe     'FIN     '
     c                   Exsr      panta1
     c                   Exsr      panta2
     c                   Exsr      panta4
     c                   Exsr      panta5
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           Desplegar 1er. panel                           -
      * ----------------------------------------------------------
     c     panta1        begsr
     c     flag1         doweq     'PANTA1  '
     c                   exfmt     FA0002A01
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
     c*                            and not *in04 and not *in10
     c                             and not *in10
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
     c                   exfmt     FA0002A02
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
      *   Desplegar 4to. panel                                   -
      * ----------------------------------------------------------
     c     Panta4        Begsr
     c     flag1         Doweq     'PANTA4  '
     c                   Exfmt     FA0002A04
     c                   Exsr      error_clr
      *
     c                   If        *In03 = *on or *In12 = *on
     c                   Eval      flag1 = 'FIN     '
     c                   Endif
      *
     c                   If        *in03 = *on or
     c                             *In12 = *on and tib = 1
     c                   Move      'F03'         wf03
     c                   Eval      flag1 = 'FIN     '
     c                   EndIf
      *
     c                   If        *In12 = *On  and tib = 2
     c                   Eval      flag1 = 'PANTA1  '
     c                   EndIf
      *
     c                   if        not *in03 and not *in12
     c                   exsr      Valida_P4
     c                   endif
      *
     c                   enddo
     c                   endsr
L007  * ----------------------------------------------------------
 ''   *   Desplegar 5ta. Pantalla                                -
 ''   * ----------------------------------------------------------
 ''  c     Panta5        Begsr
 ''  c     flag1         Doweq     'PANTA5  '
 ''  c                   Exfmt     FA0002A05
 ''  c                   Exsr      error_clr
 ''   *
 ''  c                   If        *In03 = *on or *In12 = *on
 ''  c                   Eval      flag1 = 'FIN     '
 ''  c                   Endif
 ''   *
 ''  c                   If        *in03 = *on or
 ''  c                             *In12 = *on and tib = 1
 ''  c                   Move      'F03'         wf03
 ''  c                   Eval      flag1 = 'FIN     '
 ''  c                   EndIf
 ''   *
 ''  c                   If        *In12 = *On  and tib = 2
 ''  c                   Eval      flag1 = 'PANTA1  '
 ''  c                   EndIf
 ''   *
 ''  c                   if        not *in03 and not *in12
 ''  c                   exsr      Valida_P5
 ''  c                   endif
 ''   *
 ''  c                   enddo
L007 c                   endsr
      * ----------------------------------------------------------
      *             Validar datos                                -
      * ----------------------------------------------------------
     c     cheq          begsr
     c                   setoff                                       303132
     c                   setoff                                       337172
     c                   setoff                                       29
      *
      * Articulo no existe
     c     ArtCve        Chain(n)  InvArtf                            30
      *
     c                   If        ArtMce = 'N'
     c                   Exsr      Valida_Serv
     c                   Else
      *
     c                   Do
     c                   If        *in30 = *on
     c                   Eval      msgid = 'INV0036'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Articulo no esta activo
     c                   If        artsta = 'B'
     c                   Eval      *in30 = *on
     c                   Eval      msgid = 'INV0036'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
L001  * Para Controlar los clientes Compensados
 ''  c                   If        Cliente_Sind = *On And Compen = 'S'
     c                             And OrdFec_Amd > 20071219
 ''   *
 ''  c                   If        (ArtCve <> Cod002 And ArtCve <> Cod003)
 ''  c                             And Not *In08
 ''  c                   Eval      *In30 = *On
     c                   Eval      *In29 = *On
 ''  c                   Eval      Msgid = 'FAC0100'
 ''  c                   Exsr      Error_Snd
 ''  c                   Leave
 ''  c                   EndIf
 ''  c
L001 c                   EndIf
L001  * Para Controlar los clientes no Compensados
 ''  c                   If        Cliente_Sind = *Off And Compen = 'S'
 ''   *
 ''  c                   If        (ArtCve = Cod002 Or ArtCve = Cod003)
 ''  c                   Eval      *In30 = *On
 ''  c                   Eval      Msgid = 'FAC0100'
 ''  c                   Exsr      Error_Snd
 ''  c                   Leave
 ''  c                   EndIf
 ''  c
L001 c                   EndIf
     c                   Eval      *In08 = *Off
      * Si es un producto regulado
     c                   If        ArtPpr = 'S'
     c                   Exsr      PrecioRegulado
     c                   Else
      * Buscar el costo para los productos no regulados
     c                   Exsr      Costo_NoReg
      * Articulo el precio de venta no debe ser igual a cero
     c                   If        Artpml = *Zeros And ArtPpr <> 'S'
     c                   Eval      *in30 = *on
     c                   Eval      msgid = 'FAC0009'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
     c                   EndIf
      *
      * Articulo el costo promedio no debe ser igual a cero
     c                   If        ArtCpl = *Zeros And ArtPpr <> 'S'
     c                             And CostoNoReg = *Zeros
     c                   Eval      *in30 = *on
     c                   Eval      msgid = 'FAC0011'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Articulo el costo ultimo no debe ser igual a cero
     c                   If        ArtCul = *Zeros And ArtPpr <> 'S'
     c                             And CostoNoReg = *Zeros
     c                   Eval      *in30 = *on
     c                   Eval      msgid = 'FAC0011'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Articulo no maneja control de existencia
     c                   If        ArtMce = 'N'
     c                   Eval      *in30 = *on
     c                   Eval      msgid = 'INV0022'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Articulo no esta relacionado al almacen
     c                   eval      distrito_1 = distrito
     c                   eval      almcve_1 = almcve
     c     clave_ral     chain(n)  invralf                            30
      *
     c                   If        *in30 = *on
     c                   Eval      msgid = 'INV0023'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   exsr      blanco
     c                   eval      *in72 = *on
     c                   eval      ordund = artuve
      *
      * Para buscar el precio en la lista de precio
     c                   Exsr      Busca_Precio
      * Buscar Descuento en productos regulados o No regulados
     c                   Exsr      Buscar_Desc
      *
      * si se le incrementa el precio al cliente
     c                   If        tAdcIfa = 'S' And tAdcPin <> *zeros
     c                   Eval(rh)  OrdPve = PmlArt + ((PmlArt * tAdcPin) / 100)
     c                   Else
     c                   Eval      OrdPve = PmlArt * 1
     c                   EndIf
      *
     c     artuve        chain(n)  invundf                            90
     c                   eval      unidad = undsig
     c                   exsr      buscar_exi
      *
     c                   If        Cliente_Sind = *On And Compen = 'S'
     c                   Eval      Flag1 = 'PANTA5  '
     c                   Else
     c                   Eval      Flag1 = 'PANTA2  '
     c                   EndIf
      *
     c                   EndDo
     c                   Endif
      *
     c                   EndSr
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
     c                   eval      cantid_tra = ordcan * ualcon
     c                   eval      cantid_alm = ualcon
     c                   Else
      *
     c     ordund        chain(n)  invundf                            31
     c                   eval      cantid_tra = ordcan * artcuv
     c                   eval      cantid_alm = artcuv
     c                   endif
      *
     c                   if        *in31 = *on
     c                   eval      *in71 = *on
     c                   eval      msgid = 'INV0017'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   eval      desund = undsig
      *
     c     clave_4       chain(n)  entrada                            38
     c                   if        *in38 = *off and *in44 = *on or
     c                             *in38 = *off and *in44 = *off and
     c                             ordund <> unidad_1
     c                   eval      *in31 = *on
     c                   eval      *in71 = *on
     c                   eval      msgid = 'INV0028'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Validar cantidad
     c                   if        ordcan <= *zeros
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
 ''  c*                  If        (Cantidad_Comp + OrdCan) > Cantidad_Dife
 ''  c                   If        (Cantidad_Comp + OrdCan) > Cantidad_Asig
 ''  c                   eval      *in32 = *on
 ''  c                   eval      *in72 = *on
 ''  c                   eval      msgid = 'FAC0101'
 ''  c                   exsr      error_snd
 ''  c                   Leave
 ''  c                   EndIf
 ''   *
L008 c                   EndIf
      *
      * Valida que el precio no exceda del % de descuento que el usuario
      * esta autorizado.
      *
     c                   clear                   porc_de1          5 2
     c                   clear                   porc_de2          5 2
     c                   clear                   prepml
      * para determinar el precio en unidad almacenamiento
      * y unidad alterna
      *
      * si se le incrementa el precio al cliente
     c                   if        tadcifa = 'S' and tadcpin <> *zeros
     c                   eval(rh)  prepml = pmlart + ((pmlart * tadcpin) / 100)
     c                   eval(rh)  preual = prepml
     c                   eval(rh)  precuv = (prepml / artcuv) * ualcon
     c                   else
     c                   eval(rh)  precuv = ((pmlart / artcuv) * ualcon)
     c                   eval      preual = pmlart
     c                   endif
      *
     c                   if        ordund = artuve
     c                   eval      ordpve = preual + ordid2
     c                   else
     c                   eval      ordpve = precuv + ordid2
     c                   endif
      *
      * Validar valor de descuento no > precio venta
     c                   if        ordvde >= ordpve
     c                   eval      *in33 = *on
     c                   eval      msgid = 'FAC0006'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   if        ordvde <> *zeros
     c                   eval      precio = ordpve - ordvde
     c                   else
     c                   eval      precio = ordpve
     c                   endif
      *
      * si ordpre < precio = que fue cambiado en pantalla y se debe
      * sacar el porciento de descuento otorgado.
     c                   if        precio < ordpve
     c                   eval      difere = ordpve - precio
     c                   eval(rh)  porc_de1 = (difere / ordpve) * 100
     c                   eval      porc_de2 = porc_de1 + orddpe
     c                   eval      ordpve = precio
     c                   else
     c                   eval      porc_de2 = orddpe
     c                   endif
      *
     c     user          chain(n)  facpduf                            45
     c*    Clave_Pdu     chain(n)  FacPduf                            45
l001 c*                  if        not *in45 and porc_de2 > pdupdd
l001 c                   If        not *in45 and porc_de2 > pdupdd
l001 c                              or *in45 and porc_de2 > *zeros
     c                   eval      *in33 = *on
     c                   eval      *in34 = *on
     c                   eval      msgid = 'FAC0005'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * calculo del descuento en detalle
     c                   clear                   Descue           16 6
     c                   Clear                   PorDes            7 4
     c                   if        OrdDpe <> *Zeros
     c                   eval(rh)  PorDes = OrdDpe / 100
     c                   eval(rh)  Descue = Precio * PorDes
     c                   eval      Precio = Precio - Descue
     c                   eval(rh)  Ordid1 = OrdCan * Descue
     c                   else
     c                   clear                   ordid1
     c                   endif
      *
      * calculo de impuesto
     c                   if        artimp = 'S'
     c                   exsr      impuesto
     c                   eval(rh)  ordii1 = ordcan * impue1
     c                   else
     c                   clear                   ordii1
     c                   endif
      *
      * si el cliente esta exento de pagar impuesto limpiar impuesto
         If CliExe = 'S' And (tTcfCve = 14 Or tTcfCve = 44
                          Or  tTcfCve = 16 Or tTcfCve = 46)
         Or CliExe = 'N' And (tTcfCve = 14 Or tTcfCve = 44
                          Or  tTcfCve = 16 Or tTcfCve = 46)    ;
            Clear ordii1      ;
            Clear ordii2      ;
          EndIf ;
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
     c                   endsr
      * ----------------------------------------------------------
      *  Validar articulos que no manejan existencia             -
      * ----------------------------------------------------------
     c     Valida_Serv   Begsr
     c                   setoff                                       303132
     c                   Setoff                                       337172
      *
     c                   Do
     c                   If        *In30 = *On
     c                   Eval      msgid = 'INV0036'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Articulo no esta activo
     c                   If        ArtSta = 'B'
     c                   Eval      *In30 = *on
     c                   Eval      msgid = 'INV0036'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Exsr      Blanco
     c                   Eval      *in72 = *on
     c                   eval      OrdUnd = ArtUve
     c                   Eval      OrdCan = 1
      *
     c                   Move      'PANTA4  '    flag1             8
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *             Validar datos                                -
      * ----------------------------------------------------------
     c     Valida_P4     begsr
     c                   setoff                                       303373
      *
     c                   Do
     c                   If        OrdCan <= *Zeros
     c                   Eval      *In30 = *on
     c                   Eval      msgid = 'INV0024'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        OrdPve <= *Zeros
     c                   Eval      *In33 = *on
     c                   Eval      *In73 = *on
     c                   Eval      msgid = 'INV0036'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      Cantid_Tra = OrdCan * ArtCuv
      *
     c                   If        MonCve <> *Zeros
     c                   Eval(Rh)  OrdPve = OrdPve / OrdTas
     c                   EndIf
      *
     c                   Eval      Precio = OrdPve * 1
      *
      * Calculo de impuesto
     c                   If        ArtImp = 'S'
     c                   Exsr      Impuesto
     c                   Eval(rh)  ordii1 = ordcan * impue1
     c                   Else
     c                   Clear                   Ordii1
     c                   EndIf
      *
      * Si el cliente esta exento de pagar impuesto limpiar impuesto
     c                   If        CliExe = 'S'
     c                   Clear                   ordii1
     c                   endif
      *
      * Adicionar o modificar
      *
     c     *In44         Caseq     *On           wrt
     c     *In44         Caseq     *Off          upd
     c                   Endcs
      *
     c                   EndDo
     c                   EndSr
L007  * ----------------------------------------------------------
 ''   *    Validar Datos Pantalla 5                              -
 ''   * ----------------------------------------------------------
 ''  c     Valida_P5     begsr
 ''  c                   SetOff                                       3547
 ''   *
     c                   Eval      zResMds = *Zeros
 ''   *
 ''  c                   Do
 ''  c                   If        ResNro <> *HiVal
 ''  c     Clave_Resd    Chain     PelResdf                           35
 ''  c                   If        Not %Found(PelRes01jn)
 ''  c                   Eval      *In35 = *On
 ''  c                   Eval      Msgid = 'FAC0102'
 ''  c                   Exsr      error_snd
 ''  c                   Leave
 ''  c                   EndIf
 ''  c                   EndIf
L008  *
     c                   Eval(Rh)  MonDesSub = zResMds * 1
L008  *
 ''  c                   Clear                   OrdVde
 ''  c                   Clear                   OrdId1
L008  *
 ''  c                   Eval      Flag1 = 'PANTA2  '
 ''  c                   Eval      *In47 = *On
 ''   *
 ''  c                   EndDo
L007 c                   EndSr
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
      * ----------------------------------------------------------
      *  Cantidad en unidades productos que requieren peso       -
      * ----------------------------------------------------------
     c     cantidad_und  begsr
     c                   clear                   swfin             8
     c                   clear                   wf03
     c                   eval      *in35 = *off
      *
     c     swfin         downe     'END     '
     c                   exfmt     FA0002a03
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
     c                   when      record = 'FA0002A01' and campo = 'ARTCVE'
     c                   close     invart01
     c                   call      'IV2040'                             60
     c                   parm                    artcve
     c                   open      invart01
      *
     c                   Write     FA0002A01
      *
     c                   If        ArtCve <> *Blanks
     c                   Eval      *In71 = *On
     c                   EndIf
      *
     c                   when      campo = 'ORDUND'
     c                   call      'IV2018'                             60
     c                   parm                    artcve
     c                   parm                    ordund
      *
     c                   if        ordund <> *zeros
     c                   eval      *in72 = *on
     c                   endif
      *
     c                   write     FA0002A01
      *
     c                   other
     c                   eval      msgid = 'CMN0002'
     c                   exsr      error_snd
     c                   endsl
      *
     c     ordund        chain(n)  invundf                            31
     c                   eval      desund = undsig
     c                   endsr
      * ----------------------------------------------------------
      * Chenea archivo detalle                                   -
      * ----------------------------------------------------------
     c     chenea        begsr
     c     clave_ortd    chain     facortdf                           44
     c                   endsr
      * ----------------------------------------------------------
      * Chenea archivo cabecera                                  -
      * ----------------------------------------------------------
     c     chenea_1      begsr
     c     Clave_Orth    chain(n)  facorthf                           99
     c     distrito      chain(n)  segdisf                            90
     c     clave_alm     chain(n)  invalmf                            90
     c     Clicve        chain(n)  CxcClif                            90
     c     Clicve        chain(n)  CxcAdcf                            90
     c     Clave_Orth    Chain(n)  FacDemf                            87
     c                   Eval      NomCli = %Trim(CliNom)
      *
L001 c     CliCve        Chain(n)  PelAgrdf                           90
 ''  c                   If        %Found(PelAgrd02) And
 ''  c*                            (tTcfCve <> 12 And tTcfCve <> 32)
 ''  c                             (tTcfCve <> 12)
 ''  c                   Eval      Cliente_Sind = *On
L001 c                   EndIf
      *
     c                   Eval      OrdFec_Amd = %Dec(%Date(FecOrd:*Eur):*Iso)
     c                   Eval      FecDia = FecOrd
     c                   endsr
      * ----------------------------------------------------------
      * Adicionar                                                -
      * ----------------------------------------------------------
     c     wrt           begsr
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
     c                   eval(rh)  ordimp = ordcan * ordpve
     c                   eval      ordcex = cantid_tra
     c                   eval      ordsec = secuen
     c                   eval      DisCve = Distrito
     c                   eval      ordnro = Numero
     c                   write     facortdf
      *
     c                   Exsr      Blanco
      *
     c                   eval      secuen = secuen + 1
     c                   exsr      chenea
     c                   eval      flag1 = 'PANTA1  '
     c                   endsr
      * ----------------------------------------------------------
      * Modificar
      * ----------------------------------------------------------
     c     upd           begsr
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
     c                   eval(rh)  ordimp = ordcan * ordpve
     c                   eval      ordcex = cantid_tra
     c                   update    facortdf
     c                   move      'FIN     '    flag1
     c                   endsr
      * ----------------------------------------------------------
      *   Relacion articulo almacen                              -
      * ----------------------------------------------------------
     c     rel_art_alm   begsr
     c                   if        *in30 = *on and artcve <> *blank
     c                   close     invart01
     c                   call      'IV0008M'                            60
     c                   parm                    artcve
     c                   open      invart01
     c                   endif
      *
     c                   endsr
      * ----------------------------------------------------------
      * Buscar existencia del articulo                           -
      * ----------------------------------------------------------
     c     buscar_exi    begsr
      *
      * Existencia total
     c     artcve        chain(n)  invextf                            93
     c                   eval      exist_real = extcdi - (extcre + extcrt)
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
     c                   call      'IV7003'                             60
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
     c                   call      'SG7005'                             60
     c                   parm                    artcve
     c                   parm                    precio
     c                   parm                    predi1
     c                   parm                    impue1
     c                   parm                    predi2
     c                   parm                    impue2
      *  Calculo de impuesto por al Funcion
       //   Exec SQL
       //     Select t.PREDI1, t.IMP1, t.PREDI2, t.IMP2
       //       Into :Predi1, :Impue1, :Predi2, :impue2
       //       From Table(SG_CALC_IMP_ARTICULO(:ArtCve, :Precio)) AS t;
      *
     c                   endsr
      * --------------------------------------------------------
      * Borrar campos                                          -
      * --------------------------------------------------------
     c     blanco        begsr
     c                   clear                   ordund
     c                   clear                   ordcud
     c                   clear                   ordcex
     c                   clear                   ordcan
     c                   clear                   ordpve
     c                   clear                   ordvde
     c                   clear                   ordimp
     c                   clear                   ordii1
     c                   clear                   ordii2
     c                   clear                   ordid1
     c                   clear                   ordid2
     c                   clear                   orddpe
     c                   endsr
      * --------------------------------------------------------
      * Sub- Rutina para asignar el precio del producto        -
      * --------------------------------------------------------
     c     Busca_precio  begsr
     c                   If        ArtPpr <> 'S'
     c     clave_lpcd    chain(n)  faclpcdf
     c                   if        %found(faclpcd01)
     c                   eval      pmlart = llpdpml * 1
     c                   else
     c                   eval      pmlart = artpml * 1
     c                   EndIf
      *
     c                   If        MonCve <> *Zeros
     c                   Eval(Rh)  PmlArt = PmlArt / OrdTas
     c                   EndIf
     c                   EndIf
      *
     c                   endsr
      * --------------------------------------------------------
      * Para buscar el precio de los productos regulados       -
      * --------------------------------------------------------
     c     PrecioReguladoBegsr
      *
     c     *Like         Define    ArtPml        PrecioReg
     c                   Clear                   PrecioReg
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
      * --------------------------------------------------------
      * Para buscar el costo de los productos no regulados     -
      * --------------------------------------------------------
     c     Costo_NoReg   Begsr
      *
     c     *Like         Define    ArtCpl        CostoNoReg
     c                   Clear                   CostoNoReg
     c     Clave_Rap     Chain     InvRapf                            55
     c                   If        %Found(InvRap01)
     c                   Eval      CostoNoReg = RapPco * 1
     c                   Else
     c                   Eval      CostoNoReg = ArtCul * 1
     c                   EndIf
      *
     c                   EndSr
      * --------------------------------------------------------
      * Para buscar los descuentos x clientes                  -
      * --------------------------------------------------------
     c     Buscar_Desc   Begsr
      *
     c     *Like         Define    OrdVde        ValorDesc
     c                   Clear                   ValorDesc
     c                   Clear                   MonDesDtf
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
      *
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
L009 c*                  Eval      PmlArt = PmlArt - ValorDesc
L009  *
 ''   * Si el descuento es transparente en la factura
 ''  c                   If        DprDtf = 'S'
 ''  c                   Eval      MonDesDtf = ValorDesc
 ''  c                   Else
 ''  c                   Clear                   MonDesDtf
L009 c                   Eval      PmlArt = PmlArt - ValorDesc
L009 c                   EndIf
     c                   EndSr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
     c     *Like         Define    ProCve        CodPro
     c                   Clear                   CodPro
      *
L001  *  Para Definir el codigo del proveedor especial solo en el caso de
 ''   *  pelicano
 ''  c                   Eval      Sistema = 'IV'
 ''  c                   Eval      CodParametro = 0050
 ''  c                   Exsr      Parametros
 ''  c                   Eval      CodPro = ValorNum
 ''   * Compensacion Activado
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
L001  *
 ''  c                   EndSr
 ''   * ----------------------------------------------------------
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
     c     *Inzsr        BegSr
      *
     c                   Exsr      PrnGenerales
     c                   Eval      ProCve = CodPro
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
