     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1998')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0021A                          *
      *  APLICACION...................: FACTURACION                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 01 / 10 / 99                     *
      *  DESCR:                                                          *
      *         Mantenimiento cabecera de ordenes de pedido              *
      *  --------------------------------------------------------------- *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 11 / 06 / 2007                   *
      *  Descripcion:                                                    *
      *          Modificaciones Generales para Pelicano                  *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 11 / 08 / 2015                   *
      *  DESCR: Si el Parametro FT-60 es si debe permitir facturar       *
      *         en distritos diferentes   Idef. L004                     *
      *  ================================================================*
     fFacOrth01 Uf a e           k Disk
     fFacDem01  Uf a e           k Disk    Prefix(M_)
     fFacDem02  If   e           k Disk    Rename(FacDemf:FacDemt) Prefix(I_)
     fFacDed03  If   e           k Disk    Prefix(I_)
     fDgiRnc01  If   e           k Disk    Prefix(I_)
     fFacOrtd01 Uf   e           k Disk    Prefix(H_)
     fInvAlm01  If   e           k Disk
     fSegDis01  If   e           k Disk
     fCxcCli01  If   e           k Disk    Prefix(x)
     fCxcCcl01  If   e           k Disk    Prefix(x)
     fCxcDdc01  If   e           k Disk    Prefix(A) UsrOpn
     fCxcAdc01  If   e           k Disk    Prefix(x)
     fCxcDgc01  If   e           k Disk    Prefix(x)
     fCxcAdc03  If   e           k Disk    Rename(CxcAdcf:CxcAdct) Prefix(x_)
     fCxcCpa01  If   e           k Disk    Prefix(t)
     fCxcVen01  If   e           k Disk    Prefix(x)
     fCxcRvz01  If   e           k Disk    Prefix(x)
     fCxcZon01  If   e           k Disk
     fFacPar    If   e           k Disk
     fFacFol    Uf a e           k disk    Usropn
     fFacMsgh01 If   e           k Disk    Prefix(l)
     fCogPer01  If   e           k Disk
     fSegCcp01  If   e           k Disk
     fSegCia01  If   e           k disk
     fSegPrv01  If   e           k disk
     fSegMun01  If   e           k disk
     fSegDms01  If   e           k disk
     fCajTpe01  If   e           k disk    Prefix(c)
     fFA0021afm cf   e             workstn
      *
     d tx              s             40    dim(02) ctdata perrcd(1)
      *
     d ParCve          s              1    Inz('@')
     d FolCve          s              3  0 inz(001)
     d FechaIso        s               d   Datfmt(*Iso)
     d FechaEur        s               d   Datfmt(*Eur)
L004 d FacturaDis      s               n
L004 d CodigoDis       s                   Like(DisCve) Inz(*Zeros)
     d Cliente         s                   Like(CliCve) Inz(*Zeros)
     d FechaPed        s                   Like(FecOrd) Inz(*Zeros)
     d FechaPedido     s                   Like(FecOrd) Inz(*Zeros)
     d FechaDia        s                   Like(FecOrd) Inz(*Zeros)
     d Programa        s                   Like(MsgPgm) Inz(*Blanks)
     d Pantalla        s               n
      *
L001  * Parametros
 ''  d SistemaFA       s              2    inz('FA')
 ''  d SistemaCC       s              2    inz('CC')
 ''  d CodParametro    s              4  0 inz(*Zeros)
 ''  d ValorNum        s             30 15 inz(*Zeros)
 ''  d ValorAlf        s            100    inz(*Blank)
      *
      * Para Validar el RNC o Cedula
L002 d Status_Ide      S               n
     d ValC            S             20    Inz(*Blanks)
     d Caracter        Ds                  Inz
     d Vc                             1    Dim(20)
 ''   *
L001  /Copy Fuentes,SG9001
      *
     iFacFolf
     i              DisCve                      yDisCve
     i              DtoTip                      yDtoTip
      * --------------------------------------------------------
      *                  BLOQUE PRINCIPAL                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Pedido
     c                   Parm                    Distrito
     c                   Parm                    Almacen
     c                   Parm                    Tib               1 0
     c                   Parm                    Wf03              3
      *
     c     Clave_Orth    Klist
     c                   Kfld                    Distrito
     c                   Kfld                    Codigo
      *
     c     clave_alm     Klist
     c                   Kfld                    Distrito
     c                   Kfld                    Almacen
      *
     c     clave_rvz     klist
     c                   kfld                    vencve
     c                   kfld                    xzoncve
      *
     c     Clave_Adc     klist
     c                   kfld                    Distrito
     c                   kfld                    CliCve
      *
     c     Clave_Ddc     klist
     c                   kfld                    CliCve
     c                   kfld                    CodDdc
      *
     c     Clave_Ccl     klist
     c                   kfld                    CliCve
     c                   kfld                    CclCve
      *
     c     Clave_Per     klist
     c                   kfld                    PerAno
     c                   kfld                    PerNum
      *
     c     Clave_Ccp     klist
     c                   kfld                    CiaCve
     c                   kfld                    SistemaFA
     c                   kfld                    PerAno
     c                   kfld                    PerNum
      *
     c     Clave_fol     Klist
     c                   Kfld                    DisCve
     c                   Kfld                    FolCve
     c                   Kfld                    DtoTip
      *
     c     Clave_Ded_Dem klist
     c                   kfld                    Distrito
     c                   kfld                    CedRnc
      * Municipios
     c     Clave_Mun     klist
     c                   kfld                    PrvCve
     c                   kfld                    MunCve
      * Distritos Municipales
     c     Clave_Dms     klist
     c                   kfld                    PrvCve
     c                   kfld                    MunCve
     c                   kfld                    DmsCve
     c                   kfld                    DmsCpo
     c                   kfld                    DmsSec
      *
     c     Clave_Tpe     klist
     c                   kfld                    xMonCve
     c                   kfld                    PerAno
     c                   kfld                    PerNum
      *
     c     *Like         Define    ordnro        pedido
     c     *Like         Define    ordnro        Codigo
     c     *Like         Define    discve        distrito
     c     *Like         Define    almcve        almacen
     c     *Like         Define    xCliPno       eCliPno
     c     *Like         Define    xCliRnc       NumIde
     c     *Like         Define    I_RncCed      DgiRncCed
     c     *Like         Define    aDdcCve       CodDdc
      *
     c                   Eval      DisCve = Distrito
     c                   Eval      AlmCve = Almacen
     c                   Eval      CiaCve = NumCia
      *
     c                   Exsr      PrnGenerales
      *
     c     DisCve        chain(n)  SegDisf                            98
     c     ParCve        chain(n)  FacParf                            98
     c     Clave_Alm     chain(n)  InvAlmf                            98
      *
     c                   Exsr      consta
     c                   Exsr      bloque
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
     c                   If        tib = 2
     c                   Move      'PANTA1  '    flag1             8
     c                   Movel     tx(1)         wtxt
     c                   Eval      FecOrd = *Date
     c                   Else
      *
     c                   Movel     tx(2)         wtxt
     c                   Eval      Codigo = Pedido
      *
     c                   Exsr      Chenea
      * Si la fecha de entrega es valida la convierte para grabarla
     c                   If        FeeNpe > *Zeros
     c                   Eval      FecEnt = %Dec(%Date(FeeNpe:*Iso):*Eur)
     c                   EndIf
      * Si la fecha de la orden es valida la convierte para grabarla
     c                   If        FeOrCo > *Zeros
     c                   Eval      FecOrc = %Dec(%Date(FeOrco:*Iso):*Eur)
     c                   EndIf
      *
     c                   Eval      Cliente = Clicve
     c                   Eval      FechaPed = FecOrd
      *
     c                   Eval      eCliNom = %Trim(M_CliNom)
     c                   Eval      eCliDir = %Trim(M_CliDir)
      *
     c                   Eval      eCliDi1 = %Trim(M_CliDi1)
     c                   Eval      eCliPrv = M_CliPrv
     c                   Eval      eCliMun = M_CliMun
     c                   Eval      eCliDms = M_CliDms
     c                   Eval      eCliCpo = M_CliCpo
     c                   Eval      eCliSec = M_CliSec
     c                   Eval      eDemLog = M_DemLog
     c                   Eval      eDemLat = M_DemLat
      *
     c                   Eval      PrvCve = M_CliPrv
     c                   Eval      MunCve = M_CliMun
     c                   Eval      DmsCve = M_CliDms
     c                   Eval      DmsCpo = M_CliCpo
     c                   Eval      DmsSec = M_CliSec
      *
     c*                  Eval      eCliLoc = %Trim(M_CliLoc)
     c*                  Eval      eCliCiu = %Trim(M_CliCiu)
     c                   Eval      eCliTe1 = %Trim(M_CliTe1)
     c                   Eval      eCliTe2 = %Trim(M_CliTe2)
     c                   Eval      eCliPno = %Trim(M_CliPno)
     c                   Eval      CclCve = M_CclCve
     c                   Eval      eDdcCve = M_DdcCve
     c                   Eval      MsgCve = M_MsgCve
     c                   Eval      ComPed = %Trim(M_ObsDem)
     c                   Eval      eCliIde = %Trim(M_CliIde)
     c                   Eval      NumIde = %Trim(M_CliIde)
      *
     c                   Exsr      Chenea_1
     c                   Write     FA0021a01
      * Para Manejar las pantallas
     c                   Exsr      ManejoPantalla
      *
     c                   Endif
     c                   EndSr
      * ----------------------------------------------------------
      *      Ciclo de formatos de pantallas                      -
      * ----------------------------------------------------------
     c     bloque        Begsr
     c                   Dow       flag1 <> 'FIN     '
     c                   Exsr      panta1
     c                   Exsr      panta2
     c                   Exsr      panta3
     c                   Exsr      panta4
     c                   Exsr      panta5
     c                   Exsr      panta6
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           DESPLEGA 1ER. PANEL                            -
      * ----------------------------------------------------------
     c     panta1        Begsr
      *
     c                   SetOff                                       30
      *
     c                   Dow       flag1 = 'PANTA1  '
     c                   Exfmt     FA0021a01
      *
     c                   Exsr      error_clr
     c     *In04         Caseq     *On           listaf4
     c                   EndCs
      *
     c                   If        *In03 = *On or *In12 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   EndIf
      *
     c                   If        *In03 = *Off and *In12 = *Off
     c*                            And Not *In04
     c                   Exsr      ValidaP1
     c                   EndIf
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           DESPLEGA 2DA. PANEL                            -
      * ----------------------------------------------------------
     c     panta2        begsr
      *
     c                   SetOff                                       303132
     c                   SetOff                                       337071
     c                   SetOff                                       727329
     c                   SetOff                                       693474
      *
     c                   dow       flag1 = 'PANTA2  '
     c                   exfmt     FA0021a02
      *
     c                   Exsr      error_clr
     c     *In04         Caseq     *On           listaf4
     c                   EndCs
      *
     c                   if        *In03 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In12 = *On and tib = 2
     c                   Move      'PANTA1  '    FLAG1
     c                   endif
      *
     c                   if        *In12 = *On and tib = 1
     c                   Move      'FIN     '    flag1
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c                             And Not *In04
     c                   Exsr      validaP2
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 3DA. PANEL                            -
      * ----------------------------------------------------------
     c     panta3        begsr
      *
     c                   SetOff                                       313271
     c                   SetOff                                       727333
      *
     c                   dow       flag1 = 'PANTA3  '
     c                   exfmt     FA0021a03
      *
     c                   Exsr      error_clr
     c     *In04         caseq     *On           listaf4
     c                   endcs
      *
     c                   if        *In03 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In12 = *On And Pantalla = *On
     c                   Move      'PANTA2  '    FLAG1
     c                   endif
      *
     c                   if        *In12 = *On And Not Pantalla
     c                   Move      'PANTA5  '    FLAG1
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c                             and *In04 = *Off
     c                   Exsr      validaP3
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 4ta. PANEL                            -
      * ----------------------------------------------------------
     c     panta4        begsr
      *
     c                   SetOff                                       333435
     c                   SetOff                                       737475
      *
     c                   dow       flag1 = 'PANTA4  '
     c                   exfmt     FA0021a04
      *
     c                   Exsr      error_clr
     c     *In04         caseq     *On           listaf4
     c                   endcs
      *
     c                   if        *In03 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In12 = *On
     c                   Move      'PANTA3  '    FLAG1
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c                             and *In04 = *Off
     c                   Exsr      validaP4
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 5ta. PANEL                            -
      * ----------------------------------------------------------
     c     panta5        begsr
      *
     c                   SetOff                                       04
     c                   SetOff                                       303132
     c                   SetOff                                       337071
     c                   SetOff                                       727329
     c                   SetOff                                       693474
      *
     c                   dow       flag1 = 'PANTA5  '
     c                   exfmt     FA0021a05
      *
     c                   Exsr      error_clr
     c     *In04         caseq     *On           listaf4
     c                   endcs
      *
     c                   if        *In03 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In12 = *On
     c                   Move      'PANTA1  '    FLAG1
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c*                            and *In04 = *Off
     c                   Exsr      validaP5
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 6ta. PANEL                            -
      * ----------------------------------------------------------
     c     panta6        begsr
      *
     c                   SetOff                                       303132
     c                   SetOff                                       337071
     c                   SetOff                                       727329
     c                   SetOff                                       693474
      *
     c                   dow       flag1 = 'PANTA6  '
     c                   exfmt     FA0021a06
      *
     c                   if        *In03 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        *In12 = *On
     c                   Move      'PANTA5  '    FLAG1
     c                   endif
      *
     c                   if        *In03 = *Off and *In12 = *Off
     c                   Exsr      validaP6
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *             Buscar datos para desplegar                  -
      * ----------------------------------------------------------
     c     ValidaP1      BegSr
      *
     c                   Exsr      Periodo
     c                   SetOff                                       30
      *
     c                   Do
      * Si la fecha de la orden es valida la convierte para grabarla
     c                   If        FecOrd > *Zeros
     c                   Eval      FechaPedido = %Dec(%Date(FecOrd:*Eur):*Iso)
     c                   EndIf
      *
     c*    *Eur          Move      *Date         FechaIso
     c*                  Move      FechaIso      FechaDia          8 0
     c                   Eval      FechaDia = %Dec(%Date(*Date:*Eur):*Iso)
      * La fecha de la orden no puede ser Posterior a la del dia
     c                   If        FechaPedido > FechaDia
     c                   Eval      *In30 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Exsr      Chenea_1
      *
      * Cliente no Existe
     c     CliCve        Chain(n)  CxcClif                            30
     c     CliCve        Chain(n)  CxcAdcf                            30
     c                   Eval      MonCve = xMonCve
      * Buscar la Tasa del Periodo
     c     Clave_Tpe     Chain     CajTpef
     c                   If        %Found(CajTpe01)
     c                   Eval      OrdTas = cTpeTas * 1
     c                   Else
     c                   Eval      OrdTas = 1.00000
     c                   EndIf
      *
     c     CliCve        Chain(n)  CxcDgcf                            30
     c                   If        *In30 = *On
     c                   Eval      *In70 = *On
     c                   Eval      msgid = 'CXC0016'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * cliente esta eliminado
     c                   If        xclista = 'E'
     c                   Eval      *In30 = *On
     c                   Eval      *In70 = *On
     c                   Eval      msgid = 'CXC0060'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Cliente no relacionado en distrito
     c     Clave_Adc     Chain     CxcAdct                            30
     c                   If        Not %Found(CxcAdc03) And FacturaDis = *On
     c                   Eval      *In30 = *On
     c                   Eval      msgid = 'FAC0023'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Cliente no se le puede despachar esta suspendido
     c                   If        xadcdcr = pardcr
     c                   Eval      *In30 = *On
     c                   Eval      msgid = 'FAC0001'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Vendedor esta Eliminado
     c                   if        xVenSta = 'E' Or xVenSta = 'S'
     c                   Eval      *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      msgid = 'CXC0058'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
L002  * Verificar si la cedulo o el RNC son validos
L002 c                   Exsr      Valida_Ide
      * Para validar el Numero de Ncf
L002 c                   If        xTcfCve = *Zeros Or Status_Ide = *Off
     c                   Exsr      Tiponcf
     c                   EndIf
L002  * Rnc o Cedula no Valido
     c                   If        xTcfCve = *Zeros Or Status_Ide = *Off
     c                   eval      *In31 = *On
     c                   eval      *In71 = *On
     c                   eval      msgid = 'CMN0043'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      * Periodo Contable Cerrado
     c                   If        Persit = 'C'
     c                   Eval      msgid = 'COG0018'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Periodo del Modulo
     c     Clave_Ccp     Chain(n)  SegCcpf                            99
      *
     c                   If        %Found(SegCcp01)
     c                   Eval      msgid = 'CXC0029'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Esta pendiente que el numero de orden no este pendiente procesar
      *
     c                   Exsr      Blanco
     c                   Exsr      Chenea
     c     *Eur          Move      FecOrd        FechaIso
     c                   Move      FechaIso      OrdFec
     c                   Write     FA0021a01
     c                   Exsr      Chenea_1
      *
      * Para Manejar las pantallas
     c                   Exsr      ManejoPantalla
      *
     c                   If        *In44 And Not Pantalla
     c                   Clear                   eCliNom
     c                   Clear                   eCliDir
     c                   Clear                   eCliDi1
      *
     c                   Clear                   eCliPrv
     c                   Clear                   eCliMun
     c                   Clear                   eCliDms
     c                   Clear                   eCliCpo
     c                   Clear                   eCliSec
     c                   Clear                   eDemLog
     c                   Clear                   eDemLat
      *
     c*                  Clear                   eCliLoc
     c*                  Clear                   eCliCiu
     c                   Clear                   eCliTe1
     c                   Clear                   eCliTe2
     c                   Clear                   eCliPno
     c                   Clear                   eCliIde
     c                   Else
      *
     c                   Eval      eCliNom = %Trim(xCliNom)
     c                   Eval      eCliDir = %Trim(xCliDir)
      *
     c                   Eval      eCliDi1 = %Trim(xCliDi1)
     c                   Eval      eCliPrv = xCliPrv
     c                   Eval      eCliMun = xCliMun
     c                   Eval      eCliDms = xCliDms
     c                   Eval      eCliCpo = xCliCpo
     c                   Eval      eCliSec = xCliSec
     c                   Eval      eDemLog = xDgcLog
     c                   Eval      eDemLat = xdgcLat
      *
     c                   Eval      PrvCve = xCliPrv
     c                   Eval      MunCve = xCliMun
     c                   Eval      DmsCve = xCliDms
     c                   Eval      DmsCpo = xCliCpo
     c                   Eval      DmsSec = xCliSec
     c                   Eval      eDemLog = xDgcLog
     c                   Eval      eDemLat = xdgcLat
      *
     c*                  Eval      eCliLoc = %Trim(xCliLoc)
     c*                  Eval      eCliCiu = %Trim(xCliCiu)
     c                   Eval      eCliTe1 = %Trim(xCliTe1)
     c                   Eval      eCliTe2 = %Trim(xCliTe2)
     c                   Eval      eCliPno = %Trim(xCliPno)
      *
     c                   If        xCliIdn = 'P'
     c                   Eval      eCliIde = %Trim(xCliRnc)
     c                   Else
      *
     c                   Eval      ValC = %Trim(xCliRnc)
     c                   Exsr      Convertir
     c                   Eval      eCliIde = %Trim(Valc)
     c                   EndIf
      *
     c                   EndIf
     c                   EndDo
      *
     c                   EndSr
      * ----------------------------------------------------------
      *           Valida  2da. panel                             -
      * ----------------------------------------------------------
     c     validaP2      begsr
     c                   SetOff                                       303132
     c                   SetOff                                       337071
     c                   SetOff                                       727329
     c                   SetOff                                       693474
      *
     c     *Eur          Move      *Date         FechaEur
     c                   Adddur    1:*D          FechaEur
     c                   Move      FechaEur      FecEnt
      *
     c                   Do
      *
     c                   If        %Subst(eCliNom:1:1) = *Blanks
     c                   eval      *In29 = *On
     c                   eval      *In69 = *On
     c                   eval      msgid = 'CXC0002'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        xCliIdn = 'P'
     c                   Eval      NumIde = %Trim(eCliIde)
     c                   Else
      * RNC o Cedula
     c                   Eval      NumIde = eCliIde
     c                   Eval      ValC = %Trim(NumIde)
     c                   Exsr      Convertir
     c     ' '           Scan      ValC          T                 2 0
      * Rnc
     c                   If        (T -1) <> 9 And (T - 1) <> 11
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
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
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Para Evitar que le sea facturado a la misma empresa
     c                   If        Valc = RncCia And
     c                             (xTcfcve <> 12 And xTcfCve <> 52
     c                             And xTcfcve <> 32)
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      NumIde = %Trim(Valc)
     c                   Eval      eCliIde = %Trim(Valc)
     c                   EndIf
      *
     c                   Eval      M_CliNom = eCliNom
     c                   Eval      M_CliDir = eCliDir
      *
     c                   Eval      M_CliDi1 = %Trim(eCliDi1)
     c                   Eval      M_CliPrv = eCliPrv
     c                   Eval      M_CliMun = eCliMun
     c                   Eval      M_CliDms = eCliDms
     c                   Eval      M_CliCpo = eCliCpo
     c                   Eval      M_CliSec = eCliSec
     c                   Eval      M_DemLog = eDemLog
     c                   Eval      M_DemLat = eDemLat
      *
     c*                  Eval      M_CliLoc = eCliLoc
     c*                  Eval      M_CliCiu = eCliCiu
     c                   Eval      M_CliTe1 = eCliTe1
     c                   Eval      M_CliTe2 = eCliTe2
     c                   Eval      M_CliIde = eCliIde
     c                   Eval      M_CliPno = eCliPno
     c                   Eval      M_DdcCve = eDdcCve
      *
     c     Clave_Ccl     Chain     CxcCclf                            99
      *
     c                   Move      'PANTA3  '    flag1
     c                   Eval      *In73 = *On
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           Valida  3ra. panel                             -
      * ----------------------------------------------------------
     c     validaP3      begsr
     c                   SetOff                                       313271
     c                   SetOff                                       727333
      *
     c                   Do
      *
      * Comentario
     c                   If        xAdcDcr < 999 And
     c                             (%Subst(ComPed:1:7) <> 'CONTADO' And
     c                             %Subst(ComPed:1:7) <> 'CREDITO')
     c                   Eval      *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      Msgid = 'CMN0037'
     c                   Exsr      Error_snd
     c                   Leave
     c                   EndIf
      *
      * Fecha de entrega
     c     *Eur          Test(d)                 FecEnt                 31
     c                   If        *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Si la fecha de entrega es valida la convierte gabarla
     c     *Eur          Move      FecEnt        FechaIso
     c                   Move      FechaIso      FeeNpe
      *
     c     *Eur          Move      *Date         FechaIso
     c                   Move      FechaIso      FechaDia          8 0
      * La fecha de entrega no puede ser menor a la fecha del dia
     c                   If        FeeNpe < FechaDia
     c                   Eval      *In31 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Codigo de Contacto no Existe
     c                   If        CclCve > *Zeros
     c     Clave_Ccl     Chain     CxcCclf                            32
     c                   If        Not %Found(CxcCcl01)
     c                   Eval      *In72 = *On
     c                   Eval      msgid = 'CXC0016'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
     c                   EndIf
      *
     c                   Eval      M_CclCve = CclCve
     c                   Move      'PANTA4  '    flag1
      *
     c                   EndDo
     c                   endsr
      * ----------------------------------------------------------
      *           Valida  4to. panel                             -
      * ----------------------------------------------------------
     c     validaP4      begsr
     c                   SetOff                                       333435
     c                   SetOff                                       737475
      *
     c                   Do
      *
      * Si la Orden de compra la fecha debe ser valida
     c     *Eur          Test(d)                 FecOrc                 99
     c                   If        *In99 = *On And FecOrc > *Zeros
     c                             Or *In99 = *On And OrdOrc > *Zeros
     c                   Eval      *In34 = *On
     c                   Eval      *In74 = *On
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
      * Condicion de Pago
     c                   Eval      Cpacve = xCpacve
      * Vendedor
     c                   Eval      VenCve = xVenCve
      *
     c     MsgCve        Chain     FacMsghf                           99
     c                   If        Not %Found(FacMsgh01) And MsgCve <> *Zeros
     c                   Eval      *In35 = *On
     c                   Eval      *In75 = *On
     c                   Eval      msgid = 'CMN0026'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      M_MsgCve = MsgCve
     c                   Eval      M_ObsDem = %Trim(ComPed)
      *
     c     *Eur          Move      FecOrd        FechaIso
     c                   Move      FechaIso      OrdFec
      *
     c     *In44         caseq     *On           wrt
     c     *In44         caseq     *Off          upd
     c                   endcs
      *
     c                   EndDo
     c                   endsr
      * ----------------------------------------------------------
      *           Valida  5to. panel                             -
      * ----------------------------------------------------------
     c     validaP5      begsr
     c                   SetOff                                       303132
     c                   SetOff                                       337071
     c                   SetOff                                       727329
     c                   SetOff                                       693474
      *
     c     *Eur          Move      *Date         FechaEur
     c                   Adddur    1:*D          FechaEur
     c                   Move      FechaEur      FecEnt
      *
     c                   Do
      * RNC o Cedula
     c                   Eval      NumIde = eCliIde
     c                   Eval      ValC = %Trim(NumIde)
     c                   Exsr      Convertir
     c     ' '           Scan      ValC          T                 2 0
      * Rnc
     c                   If        (T -1) <> 9 And (T - 1) <> 11
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
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
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Para Evitar que le sea facturado a la misma empresa
     c                   If        Valc = RncCia And
     c                             (xTcfcve <> 12 And xTcfCve <> 52
     c                             And xTcfcve <> 32)
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      NumIde = %Trim(Valc)
     c                   Eval      eCliIde = %Trim(Valc)
     c                   Movel(p)  eCliIde       DgiRncCed
     c                   Movel(p)  eCliIde       CedRnc           15
      *
     c     Clave_Ded_Dem Chain     FacDedf                            55
     c                   If        %Found(FacDed03)
     c                   Exsr      Mover_Datos
     c                   EndIf
      *
     c                   If        Not %Found(FacDed03)
     c     Clave_Ded_Dem Chain     FacDemt                            55
     c                   If        %Found(FacDem02)
     c                   Exsr      Mover_Datos
     c                   EndIf
     c                   EndIf
      *
     c                   If        Not %Found(FacDem02) And
     c                             Not %Found(FacDed03)
     c     DgiRncCed     Chain     DgiRnc01F                          55
     c                   If        %Found(DgiRnc01)
     c                   Exsr      Mover_Datos
     c                   EndIf
     c                   EndIf
      *
     c                   Move      'PANTA6  '    flag1
     c                   Eval      *In73 = *On
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           Valida  6to. panel                             -
      * ----------------------------------------------------------
     c     validaP6      begsr
     c                   SetOff                                       303132
     c                   SetOff                                       337071
     c                   SetOff                                       727329
     c                   SetOff                                       693474
      *
     c     *Eur          Move      *Date         FechaEur
     c                   Adddur    1:*D          FechaEur
     c                   Move      FechaEur      FecEnt
      *
     c                   Do
      *
     c                   If        %Subst(eCliNom:1:1) = *Blanks
     c                   eval      *In29 = *On
     c                   eval      *In69 = *On
     c                   eval      msgid = 'CXC0002'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      * RNC o Cedula
     c                   Eval      NumIde = eCliIde
     c                   Eval      ValC = %Trim(NumIde)
     c                   Exsr      Convertir
     c     ' '           Scan      ValC          T                 2 0
      * Rnc
     c                   If        (T -1) <> 9 And (T - 1) <> 11
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
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
     c                   Eval      *In34 = *on
     c                   Eval      *In74 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      NumIde = %Trim(Valc)
     c                   Eval      eCliIde = %Trim(Valc)
      *
     c                   Movel(p)  eCliNom       M_CliNom
     c                   Movel(p)  eCliDir       M_CliDir
      *
     c                   Eval      eCliDi1 = %Trim(M_CliDi1)
     c                   Eval      eCliPrv = M_CliPrv
     c                   Eval      eCliMun = M_CliMun
     c                   Eval      eCliDms = M_CliDms
     c                   Eval      eCliCpo = M_CliCpo
     c                   Eval      eCliSec = M_CliSec
     c                   Eval      eDemLog = M_DemLog
     c                   Eval      eDemLat = M_DemLat
      *
     c*                  Movel(p)  eCliLoc       M_CliLoc
     c*                  Movel(p)  eCliCiu       M_CliCiu
     c                   Movel(p)  eCliTe1       M_CliTe1
     c                   Movel(p)  eCliTe2       M_CliTe2
     c                   Movel(p)  eCliIde       M_CliIde
     c                   Move(p)   eCliPno       M_CliPno
     c                   Eval      M_DdcCve = eDdcCve
      *
     c     Clave_Ccl     Chain     CxcCclf                            99
      *
     c                   Move      'PANTA3  '    flag1
     c                   Eval      *In73 = *On
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar clientes                                        -
      * ----------------------------------------------------------
     c     listaf4       begsr
      *
     c                   SetOff                                       303132
     c                   SetOff                                       333435
     c                   SetOff                                       707172
     c                   SetOff                                       737475
      *
     c                   select
     c                   when      record = 'FA0021A01' and campo = 'CLICVE'
      *
L004 c                   If        FacturaDis = *Off
 ''  c                   Clear                   CodigoDis
 ''  c                   Else
 ''  c                   Eval      CodigoDis = Distrito
L004 c                   EndIf
      *
     c                   close     CxcCli01
     c                   call      'CC2098'
L004 c*                  parm                    Distrito
L004 c                   parm                    CodigoDis
     c                   parm                    clicve
     c                   open      CxcCli01
      *
     c     clicve        chain(n)  CxcClif                            30
     c     CliCve        Chain(n)  CxcDgcf                            30
      *
     c                   Eval      PrvCve = xCliPrv
     c                   Eval      MunCve = xCliMun
     c                   Eval      DmsCve = xCliDms
     c                   Eval      DmsCpo = xCliCpo
     c                   Eval      DmsSec = xCliSec
     c                   Eval      eDemLog = xDgcLog
     c                   Eval      eDemLat = xdgcLat
      *
     c     clicve        chain(n)  CxcAdcf                            30
     c     xzoncve       chain(n)  CxcZonf                            90
     c                   Eval      cpacve = xcpacve
     c                   Eval      adcclp = xadcclp
      *
     c                   If        ManVen = 'I'
 ''  c                   Exsr      Busca_Vendedor
     c                   EndIf
      *
     c                   if        clicve > *zeros
     c                   Eval      *In73 = *On
     c                   endif
      *
     c                   write     FA0021a01
      *
     c                   When      Record = 'FA0021A02' And Campo = 'ECLINOM'
     c                             Or Record = 'FA0021A02' And Campo = 'ECLIDIR'
     c                             Or Record = 'FA0021A02' And Campo = 'ECLIDI1'
     c*                            Or Record = 'FA0021A02' And Campo = 'ECLICIU'
     c                   Close     CxcCli01
     c                   Open      CxcDdc01
     c                   Call      'CC2042'
     c                   Parm                    CliCve
     c                   Parm                    CodDdc
     c                   Open      CxcCli01
      *
     c     Clave_Ddc     Chain     CxcDdcf
     c                   If        %Found(CxcDdc01)
     c                   Eval      ECliDir = aDdcDir
     c                   Eval      ECliDi1 = aDdcDi1
     c                   Eval      ECliPrv = aDdcPrv
     c                   Eval      ECliMun = aDdcMun
     c                   Eval      ECliDms = aDdcDms
     c                   Eval      ECliCpo = aDdcCpo
     c                   Eval      ECliSec = aDdcSec
     c                   Eval      EDemLog = aDdcLog
     c                   Eval      EDemLat = aDdcLat
      *
     c                   Eval      PrvCve = aDdCPrv
     c                   Eval      MunCve = aDdCMun
     c                   Eval      DmsCve = aDdCDms
     c                   Eval      DmsCpo = aDdCCpo
     c                   Eval      DmsSec = aDdCSec
      *
     c*                  Eval      ECliLoc = aDdCLoc
     c*                  Eval      ECLiCiu = aDdCCiu
     c                   Eval      ECLITE1 = aDdcTe1
     c                   Eval      ECLITE2 = aDdcTe2
     c                   Eval      M_DdcCve = CodDdc
     c                   Eval      eDdcCve = CodDdc
     c                   Endif
     c                   Close     CxcDdc01
     c                   Exsr      chenea_1
      *
     c                   Write     FA0021A01
     c                   Write     FA0021A02
      *
     c                   when      record = 'FA0021A03' and campo = 'CCLCVE'
     c                   close     CxcCcl01
     c                   call      'CC2041'
     c                   parm                    CliCve
     c                   parm                    CclCve
     c                   open      CxcCcl01
      *
     c                   Exsr      chenea_1
     c                   write     FA0021A01
     c                   write     FA0021A02
      *
     c                   When      campo = 'MSGCVE' and record = 'FA0021A04'
     c                   call      'FA2020'
     c                   parm                    MsgCve
      *
     c                   Exsr      chenea_1
     c                   write     FA0021A01
     c                   write     FA0021A02
      *
     c                   When      Record = 'FA0021A05' and campo = 'ECLIIDE'
     c                   Close     DgiRnc01
     c                   Call      'DG2099'
     c                   Parm                    ECliIde
     c                   Open      DgiRnc01
      *
     c                   Exsr      chenea_1
     c                   Write     FA0021A01
     c                   write     FA0021A05
      *
     c                   other
     c                   Eval      msgid = 'CMN0002'
     c                   Exsr      error_snd
      *
     c                   endsl
     c                   endsr
      * ----------------------------------------------------------
      *           Adición al archivo cabecera                    -
      * ----------------------------------------------------------
     c     wrt           begsr
      *
      * si el numero del pedido es igual a zero
     c                   If        Codigo = *Zeros
     c                   Exsr      Foliador
     c                   Eval      Codigo = Foltem * 1
     c                   EndIf
      *
     c                   Eval      OrdNro = Codigo
     c                   Eval      DisCve = Distrito
     c                   Eval      M_DisCve = Distrito
     c                   Eval      M_OrdNro = Codigo
     c                   Eval      Pedido = Codigo
     c                   Eval      UsrCve = User
     c                   Write     FacOrthf
     c                   write     FacDemf
      *
     c                   close     FacOrth01
     c                   close     FacDem01
     c                   Exsr      Detalle
     c                   EndSr
      * ----------------------------------------------------------
      *           Modificar archivo cabecera                    -
      * ----------------------------------------------------------
     c     upd           begsr
      *
     c                   Update    FacOrthf
      *
     c                   Update    FacDemf
     c                   Close     FacOrth01
     c                   Close     FacDem01
      * Si es cambiado el codigo del cliente o la fecha del pedido
      * debe borrar los registros en detalle.
     c                   If        Cliente <> CliCve Or FechaPed <> FecOrd
     c                   Exsr      Borrar_Detalle
     c                   EndIf
      *
     c                   Exsr      detalle
     c                   EndSr
      * ----------------------------------------------------------
      *     trabajar con detalle de la pedido                   -
      * ----------------------------------------------------------
     c     detalle       begsr
      *
     c                   Select
     c                   When      AlmTip = 'N' And CliCve <> 8819
     c                   Eval      Programa = 'FA0002'
      *
     c                   When      AlmTip = 'N' And CliCve = 8819
     c                   Eval      Programa = 'FA0026'
      *
     c                   When      AlmTip <> 'N' And
     c                             (xTcfCve = 12 Or xTcfCve = 52)
     c                   Eval      Programa = 'FA0002'
      *
     c                   When      AlmTip <> 'N' And xCpaCve < 3
     c                   Eval      Programa = 'FA0002'
      *
     c                   When      AlmTip <> 'N' And xCpaCve > 2
     c                             And (xTcfCve <> 12 Or xTcfCve <> 52)
     c                   Eval      Programa = 'FA0026'
     c                   EndSl
      *
     c                   call      Programa
     c                   Parm                    Distrito
     c                   Parm                    OrdNro
     c                   Parm                    wf03              3
      *
     c                   If        wf03 = 'F03'
     c                   Eval      flag1 = 'FIN     '
     c                   Clear                   wf03
     c                   Else
      *
     c                   Eval      Codigo = OrdNro
      *
     c                   Open      FacOrth01
     c                   Open      FacDem01
     c                   Exsr      Chenea
      *
     c                   Move      'PANTA2  '    flag1
     c                   Write     FA0021a01
     c                   EndIf
     c                   EndSr
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
     c     Chenea        Begsr
     c     Clave_Orth    Chain     FacOrthf                           44
     c     Clave_Orth    Chain     FacDemf                            44
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar el numero concecutivo de la orden              -
      * ----------------------------------------------------------
     c     Foliador      BegSr
      *
     c     *Like         Define    yDtoTip       DtoTip
     c                   Eval      DtoTip = 1
      *
     c                   Open      FacFol
     c     Clave_Fol     Chain     FacFolf                            39
     c                   If        Not *In39
     c                   Eval      FolTem = FolTem + 1
     c                   Update    FacFolf
     c                   Else
     c                   Eval      yDisCve = Distrito
     c                   Eval      yDtoTip = DtoTip
     c                   Eval      FolTem = FolTem + 1
      *
     c                   If        DtoTip = 1
     c                   Eval      FolDes = 'Numero secuencial de facturas   '
     c                   Else
     c                   Eval      FolDes = 'Numero sec. conduce de promocion'
     c                   EndIf
      *
     c                   Write     FacFolf
     c                   EndIf
     c                   Close     FacFol
      *
     c                   Endsr
      * ----------------------------------------------------------
      * Chenea archivo                                           -
      * ----------------------------------------------------------
     c     Chenea_1      Begsr
      *
     c     Clicve        Chain(n)  CxcClif                            31
     c     Clicve        Chain(n)  CxcAdcf                            31
     c     Clicve        Chain(n)  CxcDgcf                            31
      *
     c                   If        CpaCve = *Zeros Or Cpacve > xCpaCve
     c                   Eval      CpaCve = xCpaCve
     c                   Endif
      *
     c     Clave_Adc     Chain     CxcAdct                            99
     c     CpaCve        Chain(n)  CxcCpaf                            32
      *
     c                   If        CpaCve < 3
     c                   Eval      ConCre = %Trim('Contado')
     c                   Else
     c                   Eval      ConCre = %Trim('Credito')
     c                   EndIf
      *
     c                   If        ManVen = 'I'
 ''  c                   Exsr      Busca_Vendedor
     c                   EndIf
      *
     c     VenCve        Chain(n)  CxcVenf                            33
      *
     c                   If        ManVen = 'G'
     c     clave_rvz     Chain(n)  CxcRvzf                            69
     c                   Endif
     c     xzoncve       Chain(n)  CxcZonf                            90
     c                   Eval      adcclp = xadcclp
      *
     c     MsgCve        Chain(n)  FacMsghf                           90
     c                   If        Not %Found(FacMsgh01)
     c                   Clear                   MsgDes
     c                   Else
     c                   Eval      MsgDes = %Trim(lMsgDes)
     c                   Endif
      *
     c                   Eval      PrvCve = xCliPrv
     c                   Eval      MunCve = xCliMun
     c                   Eval      DmsCve = xCliDms
     c                   Eval      DmsCpo = xCliCpo
     c                   Eval      DmsSec = xCliSec
     c                   Eval      eDemLog = xDgcLog
     c                   Eval      eDemLat = xdgcLat
      * Contacto
     c     Clave_Ccl     Chain     CxcCclf                            98
      * Provincia
     c     PrvCve        Chain     SegPrvf                            98
      * Municipio
     c     Clave_Mun     Chain     SegMunf                            98
     c                   If        %Found(SegMun01)
     c                   Eval      MunPrv = %Trim(MunDes) + ',' + ' ' +
     c                                      %Trim(PrvDes)
     c                   Else
     c                   Clear                   MunPrv
     c                   EndIf
      * Distrito Municipal o Sector
     c     Clave_Dms     Chain     SegDmsf                            98
      *
     c                   EndSr
      * --------------------------------------------------------
      *                BORRADO DE CAMPOS                       -
      * --------------------------------------------------------
     c     blanco        Begsr
     c                   Clear                   FA0021a02
     c                   Clear                   FA0021a03
     c                   Clear                   FA0021a04
     c                   Clear                   FA0021a05
     c                   Clear                   FA0021a06
     c                   EndSr
 ''   * ----------------------------------------------------------
 ''   * Para Digitar el Tipo de Comprobante fiscal               -
 ''   * ----------------------------------------------------------
 ''  c     TipoNcf       Begsr
 ''  c                   Call      'CC0037'                             60
 ''  c                   Parm                    CliCve
     c                   Parm      *Blanks       Status            1
 ''   *
     c     CliCve        Chain     CxcAdcf                            31
L002  * Verificar si la cedulo o el RNC son validos
L002 c                   Exsr      Valida_Ide
      *
     c                   Write     FA0021a01
L001 c                   Endsr
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
      * -----------------------------------------------------------
      *  para deternimar el periodo que coresponde la transaccion -
      * -----------------------------------------------------------
     c     periodo       begsr
      *
      * la fecha debe ser dd/mm/aaaa
      *
     c     *Like         Define    perano        perano_9
     c     *Like         Define    pernum        pernum_9
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
      *   Mover datos del clientes que facturaron anterior       -
      * ----------------------------------------------------------
     c     Mover_Datos   Begsr
      *
     c                   Select
     c                   When      %Found(FacDed03) Or
     c                             %Found(FacDem02)
     c                   Movel(p)  I_CliNom      eCliNom
     c                   Movel(p)  I_CliDir      eCliDir
     c                   Movel(p)  I_CliDi1      eCliDi1
     c                   Move(p)   I_CliPrv      eCliPrv
     c                   Move(p)   I_CliMun      eCliMun
     c                   Move(p)   I_CliDms      eCliDms
     c                   Move(p)   I_CliCpo      eCliCpo
     c                   Move(p)   I_CliSec      eCliSec
     c                   Eval      EDemLog = I_DemLog
     c                   Eval      EDemLat = I_DemLat
     c*                  Movel(p)  I_CliLoc      eCliLoc
     c*                  Movel(p)  I_CliCiu      eCliCiu
     c                   Movel(p)  I_CliTe1      eCliTe1
     c                   Movel(p)  I_CliTe2      eCliTe2
     c                   Movel(p)  I_CliPno      eCliPno
     c                   Movel(p)  I_CliIde      eCliIde
      *
     c                   When      Not %Found(FacDed03) And
     c                             Not %Found(FacDem02) And
     c                             %Found(DgiRnc01)
     c                   Movel(p)  I_NomEmp      eCliNom
     c                   Movel(p)  I_Direc1      eCliDir
     c                   Movel(p)  I_Direc2      eCliDi1
     c*                  Movel(p)  I_Direc2      eCliLoc
     c*                  Movel(p)  I_Direc3      eCliCiu
     c                   Movel(p)  I_Tele01      eCliTe1
     c                   Clear                   eCliTe2
     c                   Clear                   eCliPno
      *
     c                   Other
     c                   Clear                   eCliNom
     c                   Clear                   eCliDir
     c                   Clear                   eCliDi1
     c                   Clear                   eCliPrv
     c                   Clear                   eCliMun
     c                   Clear                   eCliDms
     c                   Clear                   eCliCpo
     c                   Clear                   eCliSec
     c                   Clear                   eDemLog
     c                   Clear                   eDemLat
     c*                  Clear                   eCliLoc
     c*                  Clear                   eCliCiu
     c                   Clear                   eCliTe1
     c                   Clear                   eCliTe2
     c                   Clear                   eCliPno
     c                   EndSl
      *
     c                   EndSr
      * ----------------------------------------------------------
      *  Para Manejar las pnatalas dependiendo la condicion      -
      * ----------------------------------------------------------
     c     ManejoPantallaBegsr
      *
     c                   Eval      Pantalla = *Off
      *
     c                   Select
     c                   When      AlmTip = 'N'
     c                   Move      'PANTA2  '    flag1             8
     c                   Eval      Pantalla = *On
      *
     c                   When      AlmTip <> 'N' And xTcfCve = 12
     c                   Move      'PANTA2  '    flag1             8
     c                   Eval      Pantalla = *On
      *
     c                   When      AlmTip <> 'N' And xCpaCve < 3
     c                   Move      'PANTA5  '    flag1
     c                   Eval      Pantalla = *Off
      *
     c                   When      AlmTip <> 'N' And xCpaCve > 2
     c                             And xTcfCve <> 12
     c                   Move      'PANTA2  '    flag1
     c                   Eval      Pantalla = *On
     c                   EndSl
     c                   EndSr
      * ----------------------------------------------------------
      *   Subrutina inicial                                      -
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
     c                   Movel     '*'           @msgq
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
