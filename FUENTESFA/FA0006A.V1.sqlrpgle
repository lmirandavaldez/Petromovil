     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0006a                          *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Jose Antonio Tiburcio G.         *
      *  FECHA ESCRITURA .............: 01 / 12 / 99                     *
      *  DESCR:                                                          *
      *         Mantenimiento devolucion de mercancias                   *
      *  ================================================================*
     fFacNcdh01 Uf a e           k Disk
     fInvAlm01  If   e           k Disk
     fSegDis01  If   e           k Disk
     fCxcCli01  If   e           k Disk
     fCxcAdc01  If   e           k Disk
     fCxcDoch06 If   e           k Disk
     fCxcVen01  If   e           k Disk
     fCxcFol    Uf a e           k Disk    usropn
     fFacpar    If   e           k Disk
     fCxcCdo03  If   e           k Disk    prefix(x)
     fCogPer01  Uf   e           k Disk
     fFA0006afm cf   e             workstn
      *
     d tx              s             40    dim(02) ctdata perrcd(1)
      *
     d parcve          s              1    Inz('@')
     d folcve          s              3  0 Inz(004)
L004 d FacturaDis      s               n
L004 d CodigoDis       s                   Like(DisCve) Inz(*Zeros)
      *
     d NroNda          s                   Like(NcdNda)
     d FecFda          s                   Like(FecDre)
      *
L001  * Parametros
 ''  d SistemaCC       s              2    Inz('CC')
 ''  d SistemaFA       s              2    Inz('FA')
 ''  d CodParametro    s              4  0 Inz(*Zeros)
 ''  d ValorNum        s             30 15 inz(*Zeros)
 ''  d ValorAlf        s            100    inz(*Blank)
L002 d Status_Ide      S               n
      *
     dSqlFacDto      e Ds                  ExtName(FacDtoh01) Inz
 ''   *
L001  /Copy Fuentes,SG9001
 ''   *
     iCxcAdcf
     i              DisCve                      wDisCve
 ''   *
     iCxcDochf
     i              DisCve                      xDisCve
      * --------------------------------------------------------
      *                  BLOQUE PRINCIPAL                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    Numero
     c                   Parm                    tib               1 0
     c                   Parm                    wf03              3
      *
     c     Clave_Alm     Klist
     c                   Kfld                    Distrito
     c                   Kfld                    AlmCve
      *
     c     Clave_Ncd     Klist
     c                   Kfld                    Distrito
     c                   Kfld                    TipDoc
     c                   Kfld                    Numero
      *
     c     Clave_Fol     Klist
     c                   Kfld                    Distrito
     c                   Kfld                    FolCve
      *
     c     Clave_Per     Klist
     c                   Kfld                    PerAno
     c                   Kfld                    PerNum
      *
     c     Clave_Doch    Klist
     c                   Kfld                    CliCve
     c                   Kfld                    PerAno
     c                   Kfld                    PerNum
     c                   Kfld                    xCdoCve
     c                   Kfld                    NcdNda
     c                   Kfld                    Distrito
      *
     c     *Like         Define    FecDre        FechaDoc
     c     *Like         Define    NcdNro        Numero
     c     *Like         Define    DisCve        Distrito
     c     *Like         Define    NcdTip        TipDoc
      *
     c                   Exsr      PrnGenerales
      *
     c     Distrito      Chain(n)  SegDisf                            98
     c     ParCve        Chain(n)  FacParf                            98
      *
     c                   Exsr      Consta
     c                   Exsr      Bloque
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     Consta        BegSr
      *
      * Si tib = 1 indica que se esta modificando el registro
      *   y el programa debe finalizar inmediatamente sea modificado
      *
      * Si tib = 2 indica que se esta adicionando registro
      *
     c                   If        tib = 2
     c                   Move      'PANTA1  '    flag1             8
     c                   Movel     tx(1)         wtxt
     c                   Eval      *In44 = *On
     c                   Eval      FecDre = *Date
     c                   Else
      *
     c                   Movel     tx(2)         wtxt
      *
     c                   Exsr      chenea
     c     CliCve        Chain(n)  CxcClif                            90
     c                   Eval      NomCli = %Trim(CliNom)
     c     CliCve        Chain(n)  CxcAdcf                            90
     c     Clave_Alm     Chain(n)  InvAlmf                            90
      *
     c                   Eval      NroNda = NcdDre
     c                   Eval      FecFda = %Dec(%Date(FecDre:*Eur):*Iso)
      *
     c                   Write     FA0006a01
     c                   Move      'PANTA1  '    flag1             8
     c                   EndIf
     c                   EndSr
      * ----------------------------------------------------------
      *      Ciclo de formatos de pantallas                      -
      * ----------------------------------------------------------
     c     bloque        BegSr
     c                   Dow       flag1 <> 'FIN     '
     c                   Exsr      panta1
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           Desplegar 1er. panel                           -
      * ----------------------------------------------------------
     c     panta1        BegSr
     c                   Dow       flag1 = 'PANTA1  '
     c                   exfmt     FA0006a01
      *
     c                   Exsr      error_clr
     c     *In04         caseq     *On           listaf4
     c                   EndCs
      *
     c                   If        *In03 = *On or *In12 = *On
     c                   Eval      flag1 = 'FIN     '
     c                   EndIf
      *
     c                   If        Not *In03 And Not *In12
     c                             And Not *In04
     c                   Exsr      valid1
     c                   EndIf
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           Valida  1er. panel                             -
      * ----------------------------------------------------------
     c     valid1        BegSr
     c                   Setoff                                       303132
     c                   Setoff                                       337172
     c                   Setoff                                       347435
     c                   Setoff                                       367576
     c                   Setoff                                       6970
     c                   Do
      *
     c     Clave_Alm     Chain(n)  InvAlmf                            30
      *
     c                   If        *In30 = *On
     c                   Eval      *In70 = *On
     c                   Eval      msgid = 'INV0001'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c     Clicve        Chain(n)  CxcClif                            31
     c     Clicve        Chain(n)  CxcAdcf                            31
      *
     c                   If        ManVen = 'I'
 ''  c                   Exsr      Busca_Vendedor
     c                   EndIf
      *
      * Cliente no Existe
     c                   If        *In31 = *On Or CliCve = *Zeros
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CXC0016'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Cliente Esta Eliminado
     c                   If        CliSta = 'E'
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CXC0060'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Cliente no se le puede despachar esta suspendido
     c                   If        AdcDcr = ParDcr
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'FAC0001'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Documento para ser afectado <= Cero
     c                   If        NcdDre <= *Zeros
     c                   Eval      *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      msgid = 'CMN0039'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Documento de referencia > Cero y fecha es = cero no debe ser
     c                   If        NcdDre > *Zeros And FecDre <= *zeros
     c                             Or NcdDre <= *Zeros and FecDre > *Zeros
     c                   Eval      *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      msgid = 'CMN0039'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * fecha de documento referencia
     c     *Eur          Test(d)                 FecDre                 34
     c                   If        *In34 = *On
     c                   Eval      *In74 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      FechaDoc = %Dec(%Date(FecDre:*Eur):*Iso)
      *
     c                   Clear                   Existe            1 0
     c                   If        NcdDre > *Zeros
      * Determina si exisisten registros relacionados
     c/Exec Sql
     c+   Select DtoTip Into :Existe From FacDtoh01
     c+    Where (DisCve = :Distrito)
     c+      And (CliCve = :CliCve)
     c+      And (DtoNro = :NcdDre)
     c+      And (DtoFec = :FechaDoc)
     c+      And (DtoTip <> 2)
     c+      And (DtoSta = 'A')
     c/End-Exec
     c                   Clear                   SqlCod
      *
      * Documento de referencia > Cero y fecha es = cero no debe ser
     c                   If        Existe = *Zeros
     c                   Eval      *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      msgid = 'CMN0025'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
     c                   EndIf
      *
      * Si Cambio el numero de documento la fecha debe borrar los registros
     c                   If        NroNda <> NcdDre Or FechaDoc <> FecFda
     c                   Exsr      Eliminar_Det
     c                   EndIf


      * Para Aplicar la nota de credito
     c                   Eval      DtoTip = Existe
     c                   Exsr      TipoDoc_CXC
     c                   Eval      NcdNda = NcdDre
     c                   Eval      FecDap = FecDre
      *
      * Documento que aplica > cero y fecha es = cero no debe ser
     c                   If        NcdNda > *zeros and fecdap <= *zeros
     c                             or ncdnda <= *zeros and fecdap > *zeros
     c                   Eval      *In35 = *On
     c                   Eval      *In36 = *On
     c                   Eval      *In75 = *On
     c                   Eval      msgid = 'CMN0039'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * fecha la fecha del documento aplicar
     c     *Eur          test(d)                 FecDap                 69
     c                   If        *In69 = *On and fecdap > *zeros
     c                   Eval      *In36 = *On
     c                   Eval      *In76 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      * Para validar si existe y tiene balance el documento
     c                   If        NcdNda > *Zeros And FecDap > *Zeros
     C                   Eval      ProFec = FecDap
     c                   Exsr      Periodo
     c     Clave_doch    Chain(n)  CxcDochf
     c                   EndIf
      *
     c                   If        Not %Found(CxcDoch06)
     c                             And NcdNda > *Zeros And FecDap > *Zeros
     c                   Eval      *In35 = *On
     c                   Eval      *In36 = *On
     c                   Eval      *In75 = *On
     c                   Eval      msgid = 'CXC0063'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c     *In44         CasEq     *On           Wrt
     c     *In44         CasEq     *Off          Upd
     c                   EndCs
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *           Adición al archivo cabecera                    -
      * ----------------------------------------------------------
     c     Wrt           BegSr
      *
      * Buscar nro. temporal de notas de credito
     c                   Exsr      Foliador
     c                   Eval      DisCve = Distrito
     c                   Eval      NcdTip = TipDoc
     c                   Eval      NcdNro = Foltem * 1
     c                   Write     FacNcdhf
      *
     c                   Close     FacNcdh01
     c                   Exsr      Detalle
     c                   Exsr      Detalle_Com
     c                   Exsr      Blanco
     c                   EndSr
      * ----------------------------------------------------------
      *           Modificar archivo cabecera                    -
      * ----------------------------------------------------------
     c     Upd           BegSr
      *
     c                   Update    FacNcdhf
     c                   Close     FacNcdh01
     c                   Exsr      Detalle
     c                   Exsr      Detalle_Com
     c                   Eval      Flag1 = 'FIN     '
     c                   EndSr
      * ----------------------------------------------------------
      *     trabajar con detalle de la pedido                   -
      * ----------------------------------------------------------
     c     Detalle       BegSr
     c                   Call      'FA0007'                               60
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    NcdNro
     c                   Parm                    wf03              3
      *
     c                   If        wf03 = 'F03'
     c                   Eval      flag1 = 'FIN     '
     c                   Clear                   wf03
     c                   Else
      *
     c                   Open      facncdh01
     c                   Exsr      chenea
      *
     c                   Move      'PANTA1  '    flag1
     c                   Write     FA0006a01
     c                   EndIf
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar y verificar registro en cabecera               -
      * ----------------------------------------------------------
     c     Chenea        BegSr
     c     Clave_Ncd     Chain     FacNcdhf                           44
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar el numero concecutivo de la orden              -
      * ----------------------------------------------------------
     c     Foliador      BegSr
      *
     c                   Open      cxcfol
     c     Clave_Fol     Chain     cxcfolf                            39
     c                   If        *In39 = *Off
     c                   Eval      foltem = foltem + 1
     c                   Update    cxcfolf
     c                   Else
      *
      * Si no existe lo crea
     c                   Eval      DisCve = Distrito
     c                   Eval      FolTem = 1
     c                   Eval      FolDes = 'Numero secuencial notas de credito'
     c                   Write     CxcFolf
     c                   EndIf
     c                   Close     CxcFol
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar codigos                                         -
      * ----------------------------------------------------------
     c     listaf4       BegSr
      *
     c                   setoff                                       303132
     c                   setoff                                       333471
     c                   setoff                                       727374
     c                   setoff                                       353675
     c                   setoff                                       76
      *
     c                   select
      *
     c                   when      campo = 'ALMCVE'
     c                   call      'IV2001'
     c                   parm                    distrito
     c                   parm                    almcve
      *
     c                   If        almcve > *zeros
     c                   Eval      *In71 = *On
     c                   EndIf
     c     clave_alm     chain(n)  invalmf                            90
      *
     c                   when      campo = 'CLICVE'
      *
L004 c                   If        FacturaDis = *Off
 ''  c                   Clear                   CodigoDis
 ''  c                   Else
 ''  c                   Eval      CodigoDis = Distrito
 ''  c                   EndIf
      *
     c                   close     cxccli01
     c                   call      'CC2098'
     c*                  parm                    Distrito
L004 c                   parm                    CodigoDis
     c                   parm                    clicve
     c                   open      cxccli01
      *
     c     clicve        chain(n)  cxcclif                            90
      *
     c                   If        ManVen = 'I'
 ''  c                   Exsr      Busca_Vendedor
     c                   EndIf
      *
     c                   If        clicve > *zeros
     c                   Eval      *In73 = *On
     c                   EndIf
     c                   write     FA0006A01
      *
     c                   when      campo = 'VENCVE'
     c                             And ManVen = 'G'
     c     clicve        chain(n)  cxcadcf                            90
      *
     c                   close     cxcven01
     c                   call      'FA2007'
     c                   parm                    vencve
     c                   parm                    zoncve
     c                   open      cxcven01
      *
     c                   If        vencve <> *zeros
     c                   Eval      *In74 = *On
     c                   EndIf
     c     vencve        chain(n)  cxcvenf                            90
      *
     c                   write     FA0006A01
      *
     c                   other
     c                   Eval      msgid = 'CMN0002'
     c                   Exsr      error_snd
      *
     c                   endsl
     c                   EndSr
      * --------------------------------------------------------
      *                BORRADO DE CAMPOS                       -
      * --------------------------------------------------------
     c     blanco        BegSr
     c                   clear                   fecdre
     c                   clear                   almcve
     c                   clear                   clicve
     c                   clear                   vencve
     c                   clear                   almdes
     c                   clear                   clinom
     c                   clear                   vennom
     c                   clear                   ncdnda
     c                   clear                   fecdap
     c                   EndSr
      * ----------------------------------------------------------
      * Detalle Para crear los reg. en el comentario             -
      * ----------------------------------------------------------
     c     Detalle_Com   BegSr
      *
     c                   Call      'FA0006CD'                             60
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    NcdNro
      *
     c                   EndSr
      * -----------------------------------------------------------
      *  para deternimar el periodo que coresponde la transaccion -
      * -----------------------------------------------------------
     c     Periodo       BegSr
      *
      * la fecha debe ser dd/mm/aaaa
      *
     c     *Like         Define    PerAno        PerAno_9
     c     *Like         Define    PerNum        PerNum_9
     c     *Like         Define    IniPer        ProFec
      *
     c                   Call      'SG7003'                               68
     c                   Parm                    ProFec
     c                   Parm                    PerAno_9
     c                   Parm                    PerNum_9
      *
     c                   Eval      PerAno = PerAno_9
     c                   Eval      PerNum = PerNum_9
      *
     c                   Clear                   PerAno_9
     c                   Clear                   PerNum_9
     c     Clave_Per     Chain(n)  CogPerf                            99
      *
     c                   EndSr
 ''   * ----------------------------------------------------------
 ''   * Buscar Codigo del Vendedor Individual                    -
 ''   * ----------------------------------------------------------
 ''  c     Busca_VendedorBegSr
 ''  c                   Call      'CC7006'                             60
 ''  c                   Parm                    CliCve
 ''  c                   Parm                    VenCve
 ''   *
     c     VenCve        Chain     CxcVenf                            55
 ''   *
L001 c                   EndSr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
L001  *  Para identificar si el manejo de los vendedores es individual
 ''   *  o general
L001 c                   Clear                   ManVen            1
     c                   Eval      Sistema = SistemaCc
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
 ''  c     Parametros    BegSr
 ''  c                   Call      'SG7009'                             60
 ''  c                   Parm                    Sistema           2
 ''  c                   Parm                    CodParametro
 ''  c                   Parm                    ValorNum
 ''  c                   Parm                    ValorAlf
 ''   *
L001 c                   EndSr
L001  * ----------------------------------------------------------
 ''   * Buscar el tipo de documento para valiar en CXC           -
 ''   * ----------------------------------------------------------
 ''  c     TipoDoc_CXC   BegSr
L006 c     *Like         Define    ParCrf        ParFcc
      * Factura
     c                   Select
     c                   When      DtoTip = 1
L006 c                   Eval      ParFcc = ParCrf
      * Factura Externa NCF
L006 c                   When      DtoTip = 4
 ''  c                   Eval      ParFcc = ParRfe
      * Factura Externa Ticket Pre-Pago
L006 c                   When      DtoTip = 5
 ''  c                   Eval      ParFcc = ParRft
      * Factura Externa a Credito Modulo externo
L008 c                   When      DtoTip = 6
 ''  c                   Eval      ParFcc = ParRfc
L008 c                   EndSl
      * Buscar Codigo Del Documento
     c     ParFcc        Chain(n)  CxcCdof                            90
L001 c                   EndSr
      * ----------------------------------------------------------
      *  Borrar el detalle si cambia del documento que afecta    -
      * ----------------------------------------------------------
     c     Eliminar_Det  BegSr
      *
     c/Exec Sql
     c+   Delete From FacNcdd
     c+    Where (DisCve = :Distrito)
     c+      And (NcdTip = :TipDoc)
     c+      And (NcdNro = :NcdNro)
     c+  With NC
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        BegSr
      *
     c*                  Clear                   NcdNro
     c*                  Clear                   NcdNda
     c*                  Clear                   FecDap
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
     c                   EndSr
      * -----------------------------------------------------------
      *  Limpiar cola de mensaje                                  -
      * -----------------------------------------------------------
     c     error_clr     BegSr
      * Limpiar mensaje
     c                   call      'SEGMSGJ2'    msgclr
     c                   write     msgctl
     c                   EndSr
      * -----------------------------------------------------------
      *  Subrutina para retornar la descripcion de un mensaje     -
      *  desde un archivo de mensaje
      * -----------------------------------------------------------
     c     error_snd     BegSr
     c                   call      'SEGMSGJ1'    MSGLIS
     c                   write     msgctl
     c                   EndSr
      * ----------------------------------------------------------
**
        Alta a devolucion
       Cambio a devolucion
