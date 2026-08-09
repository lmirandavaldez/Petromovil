     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1998')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0001a                          *
      *  APLICACION...................: FACTURACION                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 01 / 10 / 99                     *
      *  DESCR:                                                          *
      *         Mantenimiento cabecera de ordenes de pedido              *
      *  --------------------------------------------------------------- *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 21 / 09 / 2002                   *
      *  Descripcion:                                                    *
      *          Agregar el manejo de las listas de precios.             *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 06 / 07 / 2009                   *
      *  DESCR: Poner sub-rutina para validar si el RNC o la Cedula      *
      *         del cliente es valida.  Idef. L002                       *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 05 / 11 / 2010                   *
      *  DESCR: Agregar una pantalla para la digitacion de los datos     *
      *         de las ventas al contado  Idef. L003                     *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 11 / 08 / 2015                   *
      *  DESCR: Si el Parametro FT-60 es si debe permitir facturar       *
      *         en distritos diferentes   Idef. L004                     *
      *  ================================================================*
     ffacorth01 Uf a e           k disk
     ffacdem01  Uf a e           k disk
     fFacOrtd01 Uf   e           k Disk    Prefix(H_)
     f*FacDtoh98 If   e           k disk    Prefix(J_)
     finvalm01  If   e           k disk
     fsegdis01  If   e           k disk
L005 fFacRce01  If   e           k disk    Prefix(A_)
     fcxccli01  If   e           k disk    prefix(x)
     fcxcadc01  If   e           k disk    prefix(x)
     fCxcAdc03  If   e           k disk    Rename(CxcAdcf:CxcAdct) Prefix(x_)
     fcxccpa01  If   e           k disk    prefix(t)
     fcxcven01  If   e           k disk    prefix(x)
     fcxcrvz01  If   e           k disk    prefix(x)
     fcxczon01  If   e           k disk
     ffacpar    If   e           k disk
     fsegfol    Uf a e           k disk    usropn
     fFacMsgh01 If   e           k disk    Prefix(l)
     fCogPer01  If   e           k disk
     fSegCcp01  If   e           k disk
     fSegCia01  If   e           k disk
     fCajTpe01  If   e           k disk    Prefix(c)
     fFA0001afm cf   e             workstn
      *
     d tx              s             40    dim(02) ctdata perrcd(1)
      *
     d ParCve          s              1    inz('@')
     d FolCve          s              3  0 inz(400)
     d FechaIso        s               d   Datfmt(*Iso)
     d FechaEur        s               d   Datfmt(*Eur)
     d Cond_Dup        s               n
L004 d FacturaDis      s               n
L004 d CodigoDis       s                   Like(DisCve) Inz(*Zeros)
     d Cliente         s                   Like(Clicve) Inz(*Zeros)
     d FechaPed        s                   Like(FecOrd) Inz(*Zeros)
      *
L001  * Parametros
 ''  d SistemaFA       s              2    inz('FA')
 ''  d SistemaCC       s              2    inz('CC')
 ''  d CodParametro    s              4  0 inz(*Zeros)
 ''  d ValorNum        s             30 15 inz(*Zeros)
 ''  d ValorAlf        s            100    inz(*Blank)
L002 d Status_Ide      S               n
     d ValC            S             20    Inz(*Blanks)
      *
     d Caracter        Ds                  Inz
     d Vc                             1    Dim(20)
 ''   *
L001  /Copy Fuentes,SG9001
 ''   *
     iFacDemf
     i              DisCve                      wDisCve
      * --------------------------------------------------------
      *                  BLOQUE PRINCIPAL                      -
      * --------------------------------------------------------
     c     *entry        plist
     c                   parm                    pedido
     c                   parm                    distrito
     c                   parm                    almacen
     c                   parm                    tib               1 0
     c                   parm                    wf03              3
      *
     c     Clave_Orth    Klist
     c                   Kfld                    Distrito
     c                   Kfld                    Codigo
      *
     c     clave_alm     klist
     c                   kfld                    distrito
     c                   kfld                    almacen
      *
     c     clave_rvz     klist
     c                   kfld                    vencve
     c                   kfld                    xzoncve
      *
     c     clave_fol     klist
     c                   kfld                    ciacve
     c                   kfld                    folcve
      *
     c     Clave_Adc     klist
     c                   kfld                    Distrito
     c                   kfld                    CliCve
      *
     c     Clave_Dtoh    klist
     c                   kfld                    Distrito
     c                   kfld                    Codigo
     c                   kfld                    AnoPed
     c                   kfld                    MesPed
      *
     c     Clave_Per     klist
     c                   kfld                    PerAno
     c                   kfld                    PerNum
      *
     c     Clave_Ccp     klist
     c                   kfld                    CiaCve
     c                   kfld                    SistemaFa
     c                   kfld                    PerAno
     c                   kfld                    PerNum
      *
     c     Clave_Tpe     klist
     c                   kfld                    MonCve
     c                   kfld                    PerAno
     c                   kfld                    PerNum
      *
     c     *Like         Define    OrdNro        Pedido
     c     *Like         Define    OrdNro        Codigo
     c     *Like         Define    OrdNro        CodPed
     c     *Like         Define    DisCve        Distrito
     c     *Like         Define    AlmCve        Almacen
      *
     c                   Eval      DisCve = Distrito
     c                   Eval      AlmCve = Almacen
     c                   Eval      CiaCve = Numcia
      *
     c                   Exsr      PrnGenerales
      *
     c     discve        chain(n)  segdisf                            98
     c     parcve        chain(n)  facparf                            98
     c     clave_alm     chain(n)  invalmf                            98
      *
     c                   exsr      consta
     c                   exsr      bloque
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     consta        begsr
      *
      * Si tib = 1 indica que se esta modificando el registro
      *   y el programa debe finalizar inmediatamente sea modificado
      *
      * Si tib = 2 indica que se esta adicionando registro
      *
     c                   if        tib = 2
     c                   move      'PANTA1  '    flag1             8
     c                   movel     tx(1)         wtxt
     c                   else
      *
     c                   movel     tx(2)         wtxt
     c                   Eval      Codigo = pedido
     c                   Eval      CodPed = Pedido
      *
     c                   exsr      chenea
     c                   exsr      chenea_1
      * Si la fecha de la orden es valida la convierte para grabarla
     c                   If        FeOrCo > *Zeros
     c     *Iso          Move      FeOrco        FechaEur
     c                   Move      FechaEur      FecOrc
     c                   EndIf
      *
     c                   Eval      Cliente = Clicve
     c                   Eval      FechaPed = FecOrd
      *
     c                   write     fa0001a01
     c                   Eval      *In71 = *On
     c                   move      'PANTA2  '    flag1             8
     c                   endif
     c                   endsr
      * ----------------------------------------------------------
      *      Ciclo de formatos de pantallas                      -
      * ----------------------------------------------------------
     c     bloque        begsr
     c                   dow       flag1 <> 'FIN     '
     c                   exsr      panta1
     c                   exsr      panta2
     c                   exsr      panta3
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 1ER. PANEL                            -
      * ----------------------------------------------------------
     c     panta1        begsr
     c                   dow       flag1 = 'PANTA1  '
     c                   exfmt     FA0001a01
      *
     c                   exsr      error_clr
      *
     c                   if        *In03 = *On or *In12 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c*                            and codigo > *zeros
     c                   exsr      cheq
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *             Buscar datos para desplegar                  -
      * ----------------------------------------------------------
     c     Cheq          BegSr
      *
     c                   Eval      CodPed = Codigo
     c                   Exsr      Chenea
      *
     c                   Eval      FecOrd = *Date
     c     *Eur          Move      *Date         FechaIso
     c                   Extrct    FechaIso:*y   AnoPed            4 0
     c                   Extrct    FechaIso:*m   MesPed            2 0
      *
     c                   Exsr      Cond_Duplicado
     c                   Exsr      Periodo
     c                   Do
      *
      * Codigo no puede ser igual a cero
     c                   If        Codigo = *Zeros
     c                   Eval      msgid = 'CMN0017'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * registro existe
     c                   If        *In44 = *Off
     c                             or Cond_Dup = *On
     c                   Eval      msgid = 'SEG0009'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * periodo contable cerrado
     c                   If        Persit = 'C'
     c                   Eval      msgid = 'COG0018'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * periodo del modulo
     c     Clave_Ccp     Chain(n)  SegCcpf                            99
      *
     c                   If        %Found(SegCcp01)
     c                   Eval      msgid = 'CXC0029'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * esta pendiente que el numero de orden no este pendiente procesar
      *
     c                   Exsr      blanco
     c                   Write     fa0001a01
     c                   Eval      FecOrd = *Date
     c     *Eur          Move      FecOrd        FechaIso
     c                   Move      FechaIso      OrdFec
     c                   Eval      *In71 = *On
     c                   Move      'PANTA2  '    flag1
     c                   EndDo
      *
     c                   EndSr
      * ----------------------------------------------------------
      *           DESPLEGA 2DA. PANEL                            -
      * ----------------------------------------------------------
     c     panta2        begsr
     c                   dow       flag1 = 'PANTA2  '
     c                   exfmt     FA0001a02
      *
     c                   exsr      error_clr
     c     *In04         caseq     *On           listaf4
     c                   endcs
      *
     c                   if        *In03 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In12 = *On and tib = 2
     c                   move      'PANTA1  '    FLAG1
     c                   endif
      *
     c                   if        *In12 = *On and tib = 1
     c                   move      'FIN     '    flag1
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c                             and *In04 = *Off
     c                   exsr      valid1
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           Valida  2do. panel                             -
      * ----------------------------------------------------------
     c     valid1        begsr
     c                   setoff                                       303132
     c                   setoff                                       337172
     c                   setoff                                       733435
     c                   setoff                                       747536
     c                   setoff                                       76
     c                   exsr      chenea_1
      *
     c                   Do
      *
      * fecha de documento referencia
     c     *Eur          Test(d)                 FecOrd                 30
     c                   If        *In30 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Si la fecha de la orden es valida la convierte para grabarla
     c                   If        FecOrd > *Zeros
     c     *Eur          Move      FecOrd        FechaIso
     c                   Move      FechaIso      FechaPedido       8 0
     c                   EndIf
      *
     c     *Eur          move      *Date         FechaIso
     c                   Move      FechaIso      FechaDia          8 0
      * La fecha de la orden no puede ser Posterior a la del dia
     c                   If        FechaPedido > FechaDia
     c                   Eval      *In30 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * cliente no existe
     c                   If        *In31 = *On or CliCve = *Zeros
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CXC0016'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * cliente esta eliminado
     c                   if        xclista = 'E'
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CXC0060'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Cliente no relacionado en distrito
     c                   If        Not %Found(CxcAdc03) And FacturaDis = *On
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'FAC0023'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Buscar la Tasa del Periodo
     c     Clave_Tpe     Chain     CajTpef
     c                   If        %Found(CajTpe01)
     c                   Eval      OrdTas = cTpeTas * 1
     c                   Else
     c                   Eval      OrdTas = 1.00000
     c                   EndIf
      *
      * Para que no pueda ser trabajado en este programa
     c     CliCve        Chain(n)  FacRcef                            31
     c                   If        %Found(facRce01)
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CXC0020'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * cliente no se le puede despachar esta suspendido
     c                   if        xadcdcr = pardcr
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'FAC0001'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
L002  * Verificar si la cedulo o el RNC son validos
L002 c                   Exsr      Valida_Ide
      * Buscar el Tipo de comprobante fiscal
L002 c*                  If        xTcfCve = *Zeros
L002 c                   If        xTcfCve = *Zeros Or Status_Ide = *Off
      * Para validar el Numero de Ncf
     c                   Exsr      Tiponcf
     c                   EndIf
      * Rnc o Cedula no Valido
     c                   If        xTcfCve = *Zeros Or Status_Ide = *Off
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CMN0043'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Si la Orden de compra la fecha debe ser valdia
     c     *Eur          Test(d)                 FecOrc                 99
     c                   If        *In99 = *On And FecOrc > *Zeros
     c                             Or *In99 = *On And OrdOrc > *Zeros
     c                   Eval      *In35 = *On
     c                   Eval      *In75 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Si la fecha de la orden es valida la convierte para grabarla
     c                   If        FecOrc > *Zeros
     c     *Eur          Move      FecOrc        FechaIso
     c                   Move      FechaIso      FeOrCo
     c                   EndIf
      *
      * condicion de pago
     c                   If        cpacve = *zeros
     c                   Eval      cpacve = xcpacve
     c                   EndIf
      *
     c                   If        *In32 = *On or cpacve = *zeros
     c                   Eval      *In72 = *On
     c                   Eval      msgid = 'CXC0005'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * condicion no debe ser mayor que la asignada al cliente
     c                   if        cpacve > xcpacve
     c                   Eval      *In32 = *On
     c                   Eval      *In72 = *On
     c                   Eval      msgid = 'FAC0002'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * codigo del vendedor
     c                   if        *In33 = *On or cpacve = *zeros
     c                   Eval      *In73 = *On
     c                   Eval      msgid = 'CXC0034'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * vendedor esta eliminado
     c                   if        xVenSta = 'E' Or xVenSta = 'S'
     c                   Eval      *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      msgid = 'CXC0058'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * vendedor no esta relacionado con la zona del cliente
     c                   if        *In69 = *On
     c                   Eval      *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      msgid = 'FAC0007'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c     MsgCve        Chain     FacMsghf                           99
     c                   If        Not %Found(FacMsgh01) And MsgCve <> *Zeros
     c                   Eval      *In36 = *On
     c                   Eval      *In76 = *On
     c                   Eval      msgid = 'CMN0026'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Mover fecha pedido
     c     *Eur          Move      FecOrd        FechaIso
     c                   Move      FechaIso      OrdFec
      *
     c                   If        *In44
L004 c                             Or Cliente <> CliCve
     c                   Eval      CliNom = %Trim(xCliNom)
     c                   Eval      CliDir = %Trim(xCliDir)
     c                   Eval      CliLoc = %Trim(xCliLoc)
     c                   Eval      CliCiu = %Trim(xCliCiu)
     c                   Eval      CliTe1 = %Trim(xCliTe1)
     c                   Eval      CliTe2 = %Trim(xCliTe2)
     c                   Eval      CliPno = %Trim(xCliPno)
     c*                  Eval      ValC = %Trim(xCliRnc)
     c*                  Exsr      Convertir
     c*                  Eval      NumIde = %Trim(Valc)
     c                   Clear                   NumIde
     c                   Else
     c                   Eval      NumIde = %Trim(CliIde)
     c                   EndIf
      *
L003 c                   If        xCpaCve = 01 or tCpaDcr = *Zeros
L003 c                   Move      'PANTA3  '    flag1
L003 c                   Else
     c     *In44         caseq     *On           wrt
     c     *In44         caseq     *Off          upd
     c                   endcs
L003 c                   EndIf
      *
     c                   EndDo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 3ra. PANEL                            -
      * ----------------------------------------------------------
     c     panta3        begsr
     c                   setoff                                       3031
     c                   dow       flag1 = 'PANTA3  '
     c                   exfmt     FA0001a03
      *
     c                   exsr      error_clr
      *
     c                   if        *In03 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In12 = *On and tib = 2
     c                   move      'PANTA2  '    FLAG1
     c                   endif
      *
     c                   if        *In12 = *On and tib = 1
     c                   move      'FIN     '    flag1
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c                   exsr      valid2
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           Valida  3ra. panel                             -
      * ----------------------------------------------------------
     c     valid2        begsr
     c                   setoff                                       3031
      *
     c                   Do
      *
     c                   If        %Subst(CliNom:1:1) = *Blanks
     c                   Eval      *In30 = *On
     c                   Eval      msgid = 'CXC0002'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      * RNC o Cedula
     c                   Eval      ValC = %Trim(NumIde)
     c                   Exsr      Convertir
     c     ' '           Scan      ValC          T                 2 0
      * Rnc
     c                   If        (T -1) <> 9 And (T - 1) <> 11
     c                   Eval      *In31 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Select
     c                   When      (T - 1) <= 9
     c                   Exsr      Valida_RNC
     c                   Eval      msgid = 'CMN0043'
      *
     c                   When      (T - 1) >= 10
     c                   Exsr      Valida_Cedula
     c                   Eval      msgid = 'NOM0022'
     c                   EndSl
      *
     c                   If        DigVer <> VerDig Or
     c                             %Subst(Valc:1:1) = *Blanks
     c                   Eval      *In31 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        Valc = RncCia And
     c                             (xTcfcve <> 12 And xTcfCve <> 52
     c                             And xTcfcve <> 32)
     c                   Eval      *In31 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      NumIde = %Trim(Valc)
     c                   Eval      CliIde = %Trim(Valc)
     c     *In44         caseq     *On           wrt
     c     *In44         caseq     *Off          upd
     c                   endcs
      *
     c                   EndDo
     c                   EndSr
      *--------------------------------------------------------------
      *   Sub- Rutina para depurar los campos numericos             -
      *--------------------------------------------------------------
     c     Convertir     Begsr
     c                   Clear                   I                 3 0
     c                   Clear                   y                 3 0
     c                   Eval      Caracter = Valc
     c                   Clear                   Valc
      *
     c                   For       I = 1 to %Elem(Vc)
      *
     c                   If        Vc(I) < '0'
     c                   Iter
     c                   Endif
      *
     c                   Eval      Y = Y + 1
     c                   Eval       %Subst(Valc:y:1) = Vc(I)
     c                   EndFor
      *
     c                   Endsr
L001  * --------------------------------------------------------
 ''   *  Para validar el numero de la cedula                   -
 ''   * --------------------------------------------------------
 ''  c     Valida_Cedula Begsr
 ''  c                   Clear                   NumCed           11 0
 ''  c                   Movel(p)  Valc          NumCed
 ''  c                   Move      NumCed        Verdig            1 0
 ''   *
 ''  c                   Call      'DIGITOB10'
 ''  c                   Parm                    NumCed
 ''  c                   Parm                    Digver            1 0
L001 c                   Endsr
L001  * --------------------------------------------------------
 ''   *  Para validar el numero de RNC de la empresa           -
 ''   * --------------------------------------------------------
 ''  c     Valida_RNC    Begsr
 ''  c                   Clear                   NumRnc            9 0
 ''  c                   Movel(p)  Valc          NumRnc
 ''  c                   Move      NumRnc        Verdig            1 0
 ''   *
 ''  c                   Call      'DIGITORNC'
 ''  c                   Parm                    NumRnc
 ''  c                   Parm                    Digver            1 0
L001 c                   Endsr
      * ----------------------------------------------------------
      *   Buscar clientes                                        -
      * ----------------------------------------------------------
     c     listaf4       begsr
      *
     c                   setoff                                       303132
     c                   setoff                                       333471
     c                   setoff                                       727374
     c                   setoff                                       3575
      *
     c                   select
     c                   when      record = 'FA0001A02' and campo = 'CLICVE'
      *
L004 c                   If        FacturaDis = *Off
 ''  c                   Clear                   CodigoDis
 ''  c                   Else
 ''  c                   Eval      CodigoDis = Distrito
 ''  c                   EndIf
      *
     c                   close     cxccli01
     c                   call      'CC2098'
L004 c*                  parm                    Distrito
L004 c                   parm                    CodigoDis
     c                   parm                    clicve
     c                   open      cxccli01
      *
     c     clicve        chain(n)  cxcclif                            31
     c     clicve        chain(n)  cxcadcf                            31
     c     xzoncve       chain(n)  cxczonf                            90
     c                   Eval      cpacve = xcpacve
     c                   Eval      adcclp = xadcclp
     c                   Eval      CliNom = xCliNom
      *
     c                   If        ManVen = 'I'
 ''  c                   Exsr      Busca_Vendedor
     c                   EndIf
      *
     c                   if        clicve > *zeros
     c                   Eval      *In73 = *On
     c                   endif
      *
     c                   write     fa0001a01
      *
     c                   when      record = 'FA0001A02' and campo = 'CPACVE'
     c                   close     cxccpa01
     c                   call      'CC2008'
     c                   parm                    cpacve
     c                   open      cxccpa01
      *
     c                   exsr      chenea_1
     c                   if        cpacve <> *zeros
     c                   Eval      *In73 = *On
     c                   endif
      *
     c                   write     fa0001A01
      *
     c                   when      record = 'FA0001A02' and campo = 'VENCVE'
     c                             And ManVen = 'G'
      *
     c     clicve        chain(n)  cxcadcf                            90
     c                   close     cxcven01
     c                   call      'FA2007'
     c                   parm                    vencve
     c                   parm                    xzoncve
     c                   open      cxcven01
      *
     c                   exsr      chenea_1
     c                   if        vencve <> *zeros
     c                   Eval      *In74 = *On
     c                   endif
      *
     c                   write     fa0001A01
      *
     c                   When      campo = 'MSGCVE' and record = 'FA0001A02'
     c                   call      'FA2020'
     c                   parm                    MsgCve
      *
     c                   exsr      chenea_1
     c                   write     fa0001A01
      *
     c                   other
     c                   Eval      msgid = 'CMN0002'
     c                   exsr      error_snd
      *
     c                   endsl
     c                   endsr
      * ----------------------------------------------------------
      *           Adición al archivo cabecera                    -
      * ----------------------------------------------------------
     c     wrt           begsr
      *
      * si el numero del pedido es igual a zero
     c                   if        codigo = *zeros
     c                   exsr      foliador
     c                   Eval      codigo = foltem * 1
     c                   endif
      *
     c                   Eval      DisCve = Distrito
     c                   Eval      OrdNro = Codigo
     c                   Eval      UsrCve = User
      *
     c                   write     facorthf
      *
     c                   Eval      wDiscve = Distrito
     c                   write     facdemf
      *
     c                   close     facorth01
     c                   close     facdem01
     c                   exsr      detalle
     c                   endsr
      * ----------------------------------------------------------
      *           Modificar archivo cabecera                    -
      * ----------------------------------------------------------
     c     upd           begsr
      *
     c                   update    facorthf
      *
     c                   Eval      wDiscve = Distrito
      *
     c                   update    facdemf
     c                   close     facorth01
     c                   close     facdem01
      * Si es cambiado el codigo del cliente o la fecha del pedido
      * debe borrar los registros en detalle.
     c                   If        Cliente <> CliCve Or FechaPed <> FecOrd
     c                   Exsr      Borrar_Detalle
     c                   EndIf
      *
     c                   exsr      detalle
     c                   endsr
      * ----------------------------------------------------------
      *     trabajar con detalle de la pedido                   -
      * ----------------------------------------------------------
     c     detalle       begsr
     c                   call      'FA0002'
     c                   Parm                    Distrito
     c                   parm                    ordnro
     c                   parm                    wf03              3
      *
     c                   if        wf03 = 'F03'
     c                   Eval      flag1 = 'FIN     '
     c                   clear                   wf03
     c                   else
      *
     c                   Eval      codigo = ordnro
      *
     c                   open      facorth01
     c                   open      facdem01
     c                   exsr      chenea
      *
     c                   move      'PANTA2  '    flag1
     c                   write     fa0001a01
     c                   endif
     c                   endsr
      * ---------------------------------------------------------------
      *  Borrar los registros en detalle por cambio de client o fecha -
      * ---------------------------------------------------------------
     c     Borrar_DetalleBegSr
      *
     c                   Eval      *In22 = *Off
     c     Clave_Orth    Setll     FacOrtdf
      *
     c                   Dow       Not *In22
      *
     c     Clave_Orth    Reade     FacOrtdf                               22
     c                   If        Not *In22
     c                   Delete    FacOrtdf
     c                   EndIf
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar y verificar registro en cabecera               -
      * ----------------------------------------------------------
     c     chenea        begsr
     c     Clave_Orth    chain     facorthf                           44
     c     Clave_Orth    chain     facdemf                            44
     c                   endsr
      * ----------------------------------------------------------
      *   Buscar el numero concecutivo de la orden              -
      * ----------------------------------------------------------
     c     foliador      begsr
      *
     c                   open      segfol
     c     clave_fol     chain     segfolf                            39
     c                   if        *In39 = *Off
     c                   Eval      foltem = foltem + 1
     c                   update    segfolf
     c                   else
     c                   Eval      foltem = foltem + 0000001
     c                   Eval      foldes = 'Numero sec. pedidos x ventanilla'
     c                   write     segfolf
     c                   endif
     c                   close     segfol
     c                   endsr
      * ----------------------------------------------------------
      * Chenea archivo                                           -
      * ----------------------------------------------------------
     c     chenea_1      begsr
      *
     c     clicve        chain(n)  cxcclif                            31
     c                   If        Clinom = *Blanks
     c                   Eval      CliNom = xCliNom
     c                   EndIf
     c     clicve        chain(n)  cxcadcf                            31
      *
     c                   If        CpaCve = *Zeros Or Cpacve > xCpaCve
     c                   Eval      CpaCve = xCpaCve
     c                   Endif
      *
     c     Clave_Adc     Chain     CxcAdct                            99
     c     CpaCve        chain(n)  cxccpaf                            32
      *
     c                   If        ManVen = 'I'
 ''  c                   Exsr      Busca_Vendedor
     c                   EndIf
      *
     c     VenCve        chain(n)  CxcVenf                            33
      *
     c                   If        ManVen = 'G'
     c     clave_rvz     chain(n)  cxcrvzf                            69
     c                   Endif
     c     xzoncve       chain(n)  cxczonf                            90
     c                   Eval      adcclp = xadcclp
      *
     c     MsgCve        Chain(n)  FacMsghf                           90
     c                   If        Not %Found(FacMsgh01)
     c                   Clear                   MsgDes
     c                   Else
     c                   Movel     lMsgDes       MsgDes
     c                   Endif
     c                   endsr
      * --------------------------------------------------------
      *                BORRADO DE CAMPOS                       -
      * --------------------------------------------------------
     c     blanco        begsr
     c                   clear                   fa0001a02
     c                   endsr
 ''   * ----------------------------------------------------------
 ''   * Para Digitar el Tipo de Comprobante fiscal               -
 ''   * ----------------------------------------------------------
 ''  c     TipoNcf       Begsr
      *
     c                   Close     CxcCli01
     c                   Close     CxcAdc01
 ''  c                   Call      'CC0037'                             60
 ''  c                   Parm                    CliCve
     c                   Parm      *Blanks       Status            1
     c                   Open      CxcCli01
     c                   Open      CxcAdc01
 ''   *
     c     CliCve        Chain     CxcClif                            31
     c     CliCve        Chain     CxcAdcf                            31
L002  * Verificar si la cedulo o el RNC son validos
L002 c                   Exsr      Valida_Ide
      *
     c                   write     fa0001a01
L001 c                   Endsr
L002  * ----------------------------------------------------------
 ''   *  Validar RNC o Cedula del cliente                        -
 ''   * ----------------------------------------------------------
 ''  c     Valida_Ide    BegSr
 ''   *
     c                   Eval      Status_Ide = *Off
 ''  c                   Call      'SG7014'
 ''  c                   Parm                    CliCve
 ''  c                   Parm                    Status_Ide
 ''   *
L002 c                   EndSr
 ''   * ----------------------------------------------------------
 ''   * Buscar Codigo del Vendedor Individual                    -
 ''   * ----------------------------------------------------------
 ''  c     Busca_VendedorBegsr
 ''  c                   Call      'CC7006'                             60
 ''  c                   Parm                    CliCve
 ''  c                   Parm                    VenCve
 ''   *
L001 c                   Endsr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
L001  *  Para identificar si el manejo de los vendedores es individual
 ''   *  o general
L001 c                   Clear                   ManVen            1
     c                   Eval      Sistema = SistemaCc
      *
 ''  c                   Eval      CodParametro = 0001
 ''  c                   Exsr      Parametros
 ''  c                   Movel(p)  ValorAlf      ManVen
      *
 ''  c                   If        ManVen = 'G'
 ''  c                   Eval      *In68 = *Off
 ''  c                   Else
 ''  c                   Eval      *In68 = *On
L001 c                   EndIf
      *
L004  *  Para saber si se factura por el distrito de cliente o no
 ''  c                   Eval      Sistema = SistemaFa
 ''  c                   Clear                   FacDistrito       1
 ''   *
 ''  c                   Eval      CodParametro = 0060
 ''  c                   Exsr      Parametros
 ''  c                   Movel(p)  ValorAlf      FacDistrito
 ''   *
 ''  c                   If        FacDistrito = 'S'
 ''  c                   Eval      FacturaDis = *On
 ''  c                   Else
 ''  c                   Eval      FacturaDis = *Off
L004 c                   EndIf
      *
     c                   EndSr
L001  * ----------------------------------------------------------
 ''   * Parametros del sistema                                   -
 ''   * ----------------------------------------------------------
 ''  c     Parametros    Begsr
 ''  c                   Call      'SG7009'                             60
 ''  c                   Parm                    Sistema           2
 ''  c                   Parm                    CodParametro
 ''  c                   Parm                    ValorNum
 ''  c                   Parm                    ValorAlf
 ''   *
L001 c                   Endsr
L001  * ----------------------------------------------------------
 ''   * Para Definir si el conduce esta duplicado                -
 ''   * ----------------------------------------------------------
 ''  c     Cond_DuplicadoBegsr
 ''   *
     c                   Eval      Cond_Dup = *Off
      *
     c                   Clear                   Existe            1 0
      * Determina si existen Conduce Duplicado
     c/Exec Sql
     c+   Select 1 Into :Existe From FacDtoh
     c+            Where (DisCve = :Distrito)
     c+              And (OrdNro = :CodPed)
     c+              And (DtoAno = :AnoPed)
     c+              And (DtoMes = :MesPed)
     c+              And (DtoSta <> 'C')
     c/End-Exec
     c                   If        Existe > *Zeros
     c                   Eval      Cond_Dup = *On
     c                   Clear                   SqlCod
     c                   LeaveSr
     c                   EndIf
      *
     c                   Clear                   Existe
      * Determina si existen Conduce Duplicado
     c/Exec Sql
     c+   Select 1 Into :Existe From FacOrdh
     c+            Where (DisCve = :Distrito)
     c+              And (OrdNro = :CodPed)
     c/End-Exec
     c                   If        Existe > *Zeros
     c                   Eval      Cond_Dup = *On
     c                   LeaveSr
     c                   EndIf
     c                   Clear                   SqlCod
 ''   *
L001 c                   Endsr
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
     c                   parm                    FecOrd
     c                   parm                    perano_9
     c                   parm                    pernum_9
      *
     c                   Eval      perano = perano_9
     c                   Eval      pernum = pernum_9
      *
     c                   clear                   perano_9
     c                   clear                   pernum_9
     c     Clave_Per     Chain(n)  CogPerf                            99
      *
     c                   endsr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        begsr
     c     *Like         Define    CiaRnc        RncCia
      *
     c     NumCia        Chain     SegCiaf
     c                   Eval      ValC = %Trim(CiaRnc)
     c                   Exsr      Convertir
     c                   Eval      RncCia = %Trim(Valc)
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
     c                   Eval       *In80 = *On
     c                   write     msgctl
      *
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
     c                   endsr
      * ----------------------------------------------------------
**
        Alta a orden de pedido
       Cambio a orden de pedido
