     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0009c                          *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 04 / 10 / 99                     *
      *  DESCR:                                                          *
      *         Copiar el pedido                                         *
      *  --------------------------------------------------------------- *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 21 / 09 / 2002                   *
      *  Descripcion:                                                    *
      *          Agregar el manejo de las listas de precios.             *
      *  --------------------------------------------------------------- *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 26 / 07 / 2014                   *
      *  Descripcion:                                                    *
      *          Eliminar los registros de las autorizaciones            *
      *  ================================================================*
     ffacdtoh01 uf   e           k disk
     ffacdtod01 uf   e           k disk
     ffacded01  uf   e           k disk
     ffacborh01 uf   e           k disk    prefix(t)
     ffacbord01 uf   e           k disk    prefix(t)
     fcxcadc01  uf   e           k disk    prefix(x)
     ffacdem01  o  a e           k disk
     ffacordh01 uf a e           k disk
     ffacordd01 o  a e           k disk
     fsegfol    uf a e           k disk    usropn
      *
     d fecha           s               d   datfmt(*eur)
     d folcve          s              3  0 inz(400)
 ''   *
L001  /Copy Fuentes,SG9001
      *
     iFacDtohf
     i              OrdNro                      xOrdNro
      * --------------------------------------------------------
      *                  BLOQUE PRINCIPAL                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    distrito
     c                   Parm                    tipdoc
     c                   parm                    numdoc
      *
     c     *like         Define    discve        distrito
     c     *like         Define    dtotip        tipdoc
     c     *like         Define    dtonro        numdoc
      *
     c     clave_dtoh    Klist
     c                   Kfld                    distrito
     c                   Kfld                    tipdoc
     c                   Kfld                    numdoc
      *
     c     Clave_Ordh    Klist
     c                   Kfld                    Distrito
     c                   Kfld                    xOrdNro
      *
     c     clave_fol     Klist
     c                   Kfld                    ciacve
     c                   Kfld                    folcve
      *
     c                   Eval      CiaCve = NumCia
     c                   Exsr      Cabecera
     c                   Exsr      back_order
     c                   Exsr      Detalle
     c                   Exsr      Reversion
     c                   Exsr      Borrar_Aut
      *
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *  Proceso copidado reg. cabecera                          -
      * ----------------------------------------------------------
     c     Cabecera      Begsr
     c     clave_dtoh    Chain(n)  facdtohf                           20
     c     clave_dtoh    Chain(n)  facdedf                            20
     c     clicve        Chain(n)  cxcadcf
      *
     c     Clave_Ordh    Chain     facordhf                           44
      *
     c                   If        *in44 = *Off
     c                   Exsr      foliador
     c                   Eval      ordnro = foltem * 1
     c                   Else
     c                   Eval      ordnro = xordnro * 1
     c                   EndIf
      *
     c                   Eval      sitcve = '9'
      *
     c                   Eval      FecApl = %Dec(%Date(SysFecDmy:*Dmy):*Eur)
     c                   Time                    aplhor
     c                   Movel     user          aplusr
     c                   Movel     wsid          aplwsi
      *
     c     *iso          Move      ordfec        fecha
     c                   Move      fecha         fecord
     c                   Eval      ordtib = dtombr * 1
     c                   Eval      ordtd1 = dtomd1 * 1
     c                   Eval      ordtd2 = dtomd2 * 1
     c                   Eval      ordti1 = dtomi1 * 1
     c                   Eval      ordti2 = dtomi2 * 1
     c                   Eval      ordtin = dtomne * 1
     c                   Eval      adcclp = xadcclp
      *
     c                   Write     facordhf
      *
     c                   Write     facdemf
     c                   EndSr
      * ----------------------------------------------------------
      *  Proceso copidado reg. Detalle                           -
      * ----------------------------------------------------------
     c     Detalle       Begsr
      *
     c                   Eval      *In22 = *Off
     c     clave_dtoh    Setll     facdtodf
      *
     c                   Dow       *In22 = *Off
     c     clave_dtoh    Reade(n)  facdtodf                               22
      *
     c                   If        Not *In22
     c                   Eval      ordsec = dtosec
     c                   Eval      ordund = dtoude
     c                   Eval      ordcex = dtocua
     c                   Eval      ordcan = dtocan
     c                   Eval      ordpve = dtopve
     c                   Eval      ordimp = dtoimp
     c                   Eval      ordii1 = dtoim1
     c                   Eval      ordii2 = dtoim2
     c                   Eval      ordid1 = dtompd
     c                   Eval      ordid2 = dtomsd
     c                   Eval      orddpe = dtopd1
     c                   Eval      ordsta = 'A'
      *
     c                   Eval      ordcde = *zeros
     c                   Eval      ordcdx = *zeros
     c                   Eval      ordcud = *zeros
     c                   Write     facorddf
      *
     c                   EndIf
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *  Reversion de pedido autorizado                          -
      * ----------------------------------------------------------
     c     Reversion     Begsr
      *
     c                   Call      'FA0003RE'
     c                   Parm                    Distrito
     c                   Parm                    OrdNro
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar el numero concecutivo de la orden               -
      * ----------------------------------------------------------
     c     Foliador      Begsr
      *
     c                   Open      segfol
     c     clave_fol     Chain     segfolf                            39
     c                   If        *in39 = *Off
     c                   Eval      foltem = foltem + 1
     c                   Update    segfolf
     c                   Else
     c                   Eval      foltem = foltem + 1
     c                   Eval      foldes = 'Numero sec. pedidos x ventanilla'
     c                   Write     segfolf
     c                   EndIf
     c                   Close     segfol
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar el numero concecutivo de la orden               -
      * ----------------------------------------------------------
     c     back_order    begsr
      *
     c                   setoff                                       2324
     c     Clave_Ordh    setll     facbordf
     c                   dow       *in23 = *Off
     c     Clave_Ordh    reade     facbordf                               23
      *
     c                   if        *in23 = *Off
     c                   delete    facbordf
     c                   else
      *
     c     Clave_Ordh    chain     facbordf                           24
     c                   if        *in24 = *Off
     c                   delete    facborhf
     c                   endif
      *
     c                   eval      *in23 = *On
     c                   endif
     c                   enddo
      *
     c                   endsr
      * ----------------------------------------------------------
      *  Reversion de pedido autorizado                          -
      * ----------------------------------------------------------
     c     Borrar_Aut    Begsr
      *
     c/Exec Sql
     c+   Delete From FacPau
     c+    Where (DisCve = :Distrito)
     c+      And (OrdNro = :xOrdNro)
     c+      And (CliCve = :CliCve)
     c+      And (OrdFec = :OrdFec)
     c*  With NC
     c/End-Exec
      *
     c                   EndSr
      * ----------------------------------------------------------
