     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1997')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: CG3004AP                         *
      *  APLICACION...................: Contabilidad General             *
      *  AUTOR .......................: Jose Antonio Tiburcio G.         *
      *                                 y Luis Jose Miranda              *
      *  FECHA ESCRITURA .............: 22 / 09 / 97                     *
      *  DESCR:                                                          *
      *            Recontruccion de saldos                               *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Jose Ant. Tiburcio G.            *
      *  Fecha de modificacion........: 24 / 09 / 2002                   *
      *  DESCR: Tomar como archivo primario el historico detalles de     *
      *         transacciones para la reconstruccion de saldos.          *
      *         Se elimino la corrida del programa CG3004A.              *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 04 / 06 / 2003                   *
      *  DESCR: Agregar el control para crear la actulizacion en cascada *
      *         por centro de costo. Idef. L001                          *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 29 / 07 / 2004                   *
      *  DESCR: Evitar que no se dupliquen los registros ya pagados en   *
      *         el archivo de conciliacion. L002                         *
      *  ================================================================*
     fCogcta01  if   e           k disk    prefix(x)
L001 fCogcco01  If   e           k Disk    Prefix(x)
     fCoghdgd02 if   e           k disk
     fCogban02  if   e           k disk
     fCogCan01  if   e           k disk
     fCogban01  If   e           k Disk    rename(Cogbanf:Cogbanf1) prefix(z)
     fCogTdi01  If   e           k Disk
     fCogcbad01 uf a e           k disk
     fCogcbahd02If   e           k disk    prefix(j)
     fCogmge01  uf a e           k disk
     fCogbcc01  uf a e           k disk
     fCogrbc02  If   e           k Disk    prefix(y)
      *
     d monto_mov       S                   Inz(*Zeros) Like(DgeVal)
     d debito          S                   Inz(*Zeros) Like(DgeVal)
     d credito         S                   Inz(*Zeros) Like(DgeVal)
     d fecha           s               d   datfmt(*iso)
l001 d Control         S               n
l002 d Existe_Cbah     S               n
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Anoper
     c                   Parm                    Numper
      *
     c                   Exsr      Bloque
     c                   Eval      *inlr = *on
      * ----------------------------------------------------------
      *          Ciclo de formatos de procesos                   -
      * ----------------------------------------------------------
     c     bloque        begsr
     c     *Like         Define    PerAno        AnoPer
     c     *Like         Define    PerNum        NumPer
     c     *Like         Define    Auxlis        Auxlis_1
     c     *Like         Define    Auxcve        Auxcve_1
     c     *Like         Define    Ccocve        Ccocve_1
     c     *Like         Define    Ctacve        Ctacve_1
      *
     c     clave_dge     klist
     c                   kfld                    anoper
     c                   kfld                    numper
      *
     c     clave_my      klist
     c                   kfld                    auxlis
     c                   kfld                    cuenta
     c                   kfld                    auxcve
     c                   kfld                    perano
     c                   kfld                    pernum
      *
     c     clave_cco     klist
l001 c*                  Kfld                    Ccocve
l001 c                   Kfld                    Codigo_Cco
     c                   kfld                    auxlis
     c                   kfld                    ctacve
     c                   kfld                    auxcve
     c                   kfld                    perano
     c                   kfld                    pernum
      *
     c     clave_ban     klist
     c                   kfld                    ctacve
     c                   kfld                    auxcve
      *
     c     Clave_Can     klist
     c                   kfld                    BanCve
     c                   kfld                    SecTtr
     c                   kfld                    DgeDoc
      *
     c     clave_cba     klist
     c                   kfld                    bancve
     c                   kfld                    tdicve
     c                   kfld                    dgedoc
     c                   kfld                    fecemi
     c                   kfld                    dgeori
     c                   kfld                    dgeval
     c                   kfld                    dgesec
      *
l002 c     Clave_CbaH    Klist
l002 c                   Kfld                    BanCve
l002 c                   Kfld                    TdiCve
l002 c                   Kfld                    DgeDoc
l002 c                   Kfld                    FecEmi
l002 c                   Kfld                    DgeOri
l002 c                   Kfld                    DgeVal
      *
     c                   Exsr      detalles
     c                   Exsr      Ejecuta
     c                   Endsr
      * ----------------------------------------------------------
      * adicionar detalle historico diario general
      * ----------------------------------------------------------
     c     detalles      begsr
     c                   eval      *in22 = *off
      *
     c     clave_dge     setll     Coghdgdf
      *
     c                   dow       *in22 = *off
     c     clave_dge     reade(n)  Coghdgdf                               22
      *
     c                   if        *in22 = *off
      *
     c                   if        dgeori = 1
     c                   eval(rh)  monto_mov = dgeval * 1
     c                   eval      debito = dgeval
     c                   clear                   credito
     c                   else
     c                   eval(rh)  monto_mov = dgeval * -1
     c                   eval      credito = dgeval
     c                   clear                   debito
     c                   endif
      *
      * Mover a Variables intermedias
     c                   Eval      Auxlis_1 = Auxlis
     c                   Eval      Auxcve_1 = Auxcve
     c                   Eval      Ccocve_1 = Ccocve
     c                   Eval      Ctacve_1 = Ctacve
     c                   exsr      concilia
     c                   exsr      mayor_gral
      *
     c                   Eval      Auxlis = Auxlis_1
     c                   Eval      Auxcve = Auxcve_1
     c                   Eval      Ccocve = Ccocve_1
     c                   Eval      Ctacve = Ctacve_1
      *
     c     ctacve        chain(n)  Cogctaf                            97
     c                   if        xctamcc = 'S'
     c                   exsr      centro_costo
     c                   endif
      *
     c                   endif
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      * actualizacion conciliarion bancaria
      * ----------------------------------------------------------
     c     Concilia      Begsr
L001 c     *Like         Define    CbaSta        Status
      *
     c     *Eur          Move      Fectra        Fecha
     c                   Move      Fecha         Fecemi
      *
     c     Clave_Ban     Chain(n)  CogBanf                            45
     c                   If        *In45 = *On
     c                   Exsr      Relacion_Conc
     c                   Endif
      *
     c                   If        Not *In45 And
     c                             BanEmi = 'S'
      *
L001 c     TdiCve        Chain     CogTdif                            55
     c                   Select
     c                   When      TdiTip = 0
     c                   Eval      SecTtr = 2
 ''  c                   Eval      Status = 'T'
      *
 ''  c                   When      TdiTip = 2
 ''  c                   Eval      Status = 'C'
     c                   Clear                   SecTtr
      *
 ''  c                   Other
     c                   Eval      SecTtr = 1
 ''  c                   Eval      Status = 'T'
L001 c                   EndSl
      *
     c     Clave_Can     Chain     CogCanf                            55
     c                   If        %Found(CogCan01)
 ''  c                   Eval      Status = 'C'
     c                   EndIf
      *
      * Para Verificar si este registro ya existe en el Historico como pagado
l002 c                   Exsr      Concilia_His
      * Si Existe_Cbah = *On No debe Grabar
l002 c                   If        Existe_Cbah = *Off
      *
l002 c*    clave_cba     chain(n)  Cogcbahdf                          47
      *
     c     Clave_Cba     Chain     CogCbadf                           46
L002 c*                  if        *in46 = *on and *in47 = *on
     c                   If        Not %Found(CogCbad01)
     c                   Eval      CbaVdc = DgeVal
L001 c*                  Eval      CbaSta = 'T'
L001 c                   Eval      CbaSta = Status
     c                   Write     CogCbadf
     c                   EndIf
     c                   EndIf
     c                   EndIf
      *
     c                   Endsr
      * ----------------------------------------------------------
      * Buscar relacion de Cuentas que afectan conciliacion
      * ----------------------------------------------------------
     c     relacion_conc Begsr
      *
      * Si no existe como banco buscar en relacion Cuenta que afectan
      * conciliacion bancaria
     c     Clave_ban     Chain(n)  Cogrbcf                            48
     c                   If        *In48 = *Off
     c     ybancve       Chain(n)  Cogbanf1                           45
     c                   Eval      bancve = zbancve
     c                   Eval      banemi = zbanemi
     c                   Endif
      *
     c                   Endsr
L002  * ----------------------------------------------------------
 ''   * Confirmar si el documento existe en el Histotico         -
 ''   * ----------------------------------------------------------
 ''  c     Concilia_His  Begsr
 ''   *
 ''  c                   Eval      *In23 = *Off
 ''  c                   Eval      Existe_Cbah = *Off
 ''  c     Clave_Cbah    Setll     CogCbahdf
 ''  c                   Dow       Not *In23
 ''  c     Clave_Cbah    Reade     CogCbahdf                              23
 ''  c                   If        Not *In23 And
 ''  c                             jCbaSta = 'P'
 ''  c                   Eval      Existe_Cbah = *On
 ''  c                   EndIf
 ''  c                   EndDo
 ''   *
L002 c                   Endsr
      * ----------------------------------------------------------
      * actualizacion al mayor
      * ----------------------------------------------------------
     c     Mayor_Gral    Begsr
     c                   Movel     Ctacve        Cuenta           18
     c                   Eval      Control = *On
      *
     c                   Dow       Cuenta <> *Blank
     c     Cuenta        Chain(n)  Cogctaf                            97
     c     Clave_my      Chain     Cogmgef                            69
      *
     c                   If        *In69 = *On
     c                   Eval      Ctacve = Cuenta
     c                   Eval      mgebal = mgebal + monto_mov
     c                   Eval      mgedeb = debito
     c                   Eval      mgecre = credito
     c                   Write     Cogmgef
      *
     c                   Else
      *
     c                   Eval      mgebal = mgebal + monto_mov
     c                   Eval      mgedeb = mgedeb + debito
     c                   Eval      mgecre = mgecre + credito
     c                   Update    Cogmgef
     c                   Endif
      * Para Controlar la actualizacion en casada de las cuentas
     c                   If        Control = *On and xctatip = 1
     c                   If        xctamau = 'S' or xctamcc = 'S'
     c                   Eval      xctaafe = Ctacve
     c                   Eval      Control = *Off
     c                   Endif
     c                   Endif
      *
     c                   Eval      Cuenta = xCtaafe
     c                   Clear                   Mgebal
     c                   Clear                   Mgedeb
     c                   Clear                   Mgecre
      *
     c                   Clear                   Auxlis
     c                   Clear                   Auxcve
     c                   Clear                   Ccocve
     c                   Enddo
      *
     c                   Endsr
L001  * ----------------------------------------------------------
 ''   * Para Actualizar por centro de costo en Cascada           -
 ''   * ----------------------------------------------------------
 ''  c     Centro_Costo  Begsr
 ''   *
 ''  c     *Like         Define    Ccocve        Codigo_Cco
 ''  c     *Like         Define    Ccocve        CCo_Codigo
 ''  c                   Movel(p)  Ccocve        Codigo_Cco
 ''  c                   Movel(p)  Ccocve        CCo_Codigo
 ''   * Si la variable control es = *On es para que se ejecute una sola vez
 ''  c                   Eval      Control = *On
 ''   *
 ''  c                   Dow       Codigo_Cco <> *Blanks
 ''  c     Codigo_Cco    Chain(n)  Cogccof                            97
 ''  c     Clave_Cco     Chain     Cogbccf                            69
 ''   *
 ''  c                   If        Not %Found(Cogbcc01)
 ''  c                   Eval      Ccocve = Codigo_Cco
 ''  c                   Eval      Bccbal = Bccbal + Monto_mov
 ''  c                   Eval      Bccdeb = Debito
 ''  c                   Eval      Bcccre = Credito
 ''  c                   Write     Cogbccf
 ''   *
 ''  c                   Else
 ''  c                   Eval      Bccbal = Bccbal + Monto_mov
 ''  c                   Eval      Bccdeb = Bccdeb + Debito
 ''  c                   Eval      Bcccre = Bcccre + Credito
 ''  c                   Update    Cogbccf
 ''  c                   Endif
 ''   * Controla la Actualizacion en Cascada del Centro de costo
 ''  c                   If        Control = *On
 ''  c                   Eval      Codigo_Cco = Cco_Codigo
 ''  c                   Eval      Control = *Off
 ''  c                   Else
 ''  c                   Eval      Codigo_Cco = xCCoafe
 ''  c                   Endif
 ''   *
 ''  c                   Clear                   Bccbal
 ''  c                   Clear                   Bccdeb
 ''  c                   Clear                   Bcccre
 ''   *
 ''  c                   Clear                   Auxlis
 ''  c                   Clear                   Auxcve
 ''  c                   Clear                   Ctacve
 ''  c                   Enddo
L001 c                   Endsr
      * ----------------------------------------------------------
      *   Ejecuta el proceso cierre de periodos                  -
      * ----------------------------------------------------------
     c     ejecuta       begsr
      *
     c                   call      'CG3001A'
     c                   parm                    anoper
     c                   parm                    numper
      *
     c                   endsr
      * ----------------------------------------------------------
