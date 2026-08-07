     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S.A. 1999')
     H   DeBug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3045AP                         *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 25 / 10 / 2012                   *
      *  DESCR:                                                          *
      *         Proceso para Cancelar y Eliminar Facturas en Grupo       *
      *  ================================================================*
     fFacDtoh01 If   e           k Disk
     fCxcCli01  If   e           k Disk
     fCxcAdc01  If   e           k Disk    Prefix(l)
     fFacDed01  If   e           k Disk    Prefix(x)
     fFacPar    If   e           k Disk
      *
     d FechaEur        s               d   Datfmt(*Eur)
     d Programa        s             10    Inz(*Blanks)
     d ParCve          s              1    Inz('@')
     d FecFac          s                   Like(DtoFec)
 ''   *
     d Producto        S               n
L099 d Factura_Cia3    S               n
      *
L001  * Parametros
 ''  d Sistema         s              2    inz('FA')
 ''  d CodParametro    s              4  0 inz(*Zeros)
 ''  d ValorNum        s             30 15 inz(*Zeros)
 ''  d ValorAlf        s            100    inz(*Blank)
 ''   *
L001  /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    Numero
      *
     c     Clave_Dtoh    Klist
     c                   Kfld                    Distrito
     c                   Kfld                    TipDoc
     c                   Kfld                    Numero
      *
     c                   Exsr      Consta
     c                   Exsr      Proceso
     c                   Exsr      Borrar_Fisico
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     Consta        BegSr
      *
     c     *Like         Define    DtoNro        Numero
     c     *Like         Define    DisCve        Distrito
     c     *Like         Define    DtoTip        TipDoc
     c     *Like         Define    ParCrf        CodRel
      *
     c     *Like         Define    DtoNro        NumPrm
     c     *Like         Define    DisCve        DisPrm
      * Buscar Parametros Generales
     c                   Exsr      PrnGenerales
      *
     c     Clave_Dtoh    Chain(n)  FacDtohf                           90
     c     CliCve        Chain(n)  CxcClif                            30
     c     CliCve        Chain(n)  CxcAdcf                            30
      * Convertir fecha de factura
     c                   Eval      FecFac = %Dec(%Date(DtoFec):*Eur)
      *
     c                   EndSr
      * ----------------------------------------------------------
      *  Cancelacion del documento
      * ----------------------------------------------------------
     c     Proceso       BegSr
     c                   Clear                   Error
     c                   Do
      *
     c                   Close     CxcCli01
     c                   Close     FacDtoh01
      *
     c     ParCve        Chain(n)  FacParf                            99
     c                   Select
     c                   When      TipDoc = 1
     c                   Eval      CodRel = ParCrf
      *
     c                   When      TipDoc = 2
     c                   Eval      CodRel = ParCrn
      *
     c                   When      TipDoc = 3
     c                   Eval      CodRel = ParCrf
      *
     c                   When      TipDoc = 4
     c                   Eval      CodRel = ParRfe
     c                   EndSl
      *
      * Si la zona de venta es < que el campo parzop no tiene que cancelar
      * el registro de cuentas por cobrar
     c                   If        lZonCve < ParZop
      *
      * verificar y cancelar el documento en cuentas por cobrar
     c                   Call      'CC7002'                             60
     c                   Parm                    CliCve
     c                   Parm                    CodRel
     c                   Parm                    Numero
     c                   Parm                    FecFac
     c                   Parm                    Distrito
     c                   Parm                    Error             1
      *
     c                   Else
     c                   Eval      Error = '9'
     c                   EndIf
      *
      * Si el codigo de error es igual a 9 significa que el doc. fue
      * cancelado y se puede proceder con los otros procesos.
     c                   If        Error <> '9'
     c                   Leave
     c                   EndIf
      *
L099  * Este Programa verifica si esta factura tiene productos que son
 ''   * facturados por la CIA3
L099 c                   Exsr      Verifica_Cia3
      *
     c                   Eval      Producto = *Off
      * Para Identificar si tiene art. con manejo de existencia
     c                   Call      'FA7053'                             60
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    Numero
     c                   Parm                    Producto
      *
     c                   If        Producto = *On
      *
      * Proceso para cancelar un documento
     c                   Clear                   Programa
      * Si es una factura o una factura de promocion
     c                   Select
     c                   When      TipDoc <> 2
      * Si esta empresa no maneja existencia debe ejecutar este programa
L099 c                   If        ManejaExist = 'N' Or Factura_Cia3 = *On
     c                   Call      'FA7051'                             60
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    Numero
     c                   Parm      'C'           Control           1
      *
     c                   Parm                    DisPrm
     c                   Parm                    NumPrm
     c                   Parm                    TmoPrm            2
     c                   Parm                    Programa
      * Esto se ejecuta cuando es una cancelacion
     c                   Call      Programa                             60
     c                   Parm                    DisPrm
     c                   Parm                    NumPrm
     c                   Parm                    TmoPrm
     c                   EndIf
      *
     c                   Call      'FA7005'                             60
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    numero
     c                   Parm      04            AcfCve            2 0
      *
      * Si es una nota de credito por devolucion
     c                   When      TipDoc = 2
      * Si esta empresa no maneja existencia debe ejecutar este programa
L099 c                   If        ManejaExist = 'N' Or Factura_Cia3 = *On
     c                   Call      'FA7051'
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    numero
     c                   Parm      'C'           Control           1
      *
     c                   Parm                    DisPrm
     c                   Parm                    NumPrm
     c                   Parm                    TmoPrm            2
     c                   Parm                    Programa
     c                   EndIf
      *
     c                   Call      'FA7006'                             60
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    Numero
     c                   EndSl
      *
     c                   Else
      *
     c                   Call      'FA7007'                             60
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    Numero
     c                   Parm                    AcfCve
      *
     c                   EndIf
      *
     c                   EndDo
      *
     c                   Open      CxcCli01
     c                   Open      FacDtoh01
      *
     c                   EndSr
L099  *-----------------------------------------------------
 ''   *  Verifica productos facturados Cia3                -
 ''   *-----------------------------------------------------
 ''  c     Verifica_Cia3 BegSr
 ''   *
 ''  c                   Eval      Factura_Cia3 = *Off
 ''   * Verifica productos
 ''   *
 ''  c                   Call      'FA7055'                             60
 ''  c                   Parm                    Distrito
 ''  c                   Parm                    TipDoc
 ''  c                   Parm                    Numero
 ''  c                   Parm                    Factura_Cia3
 ''   *
L099 c                   EndSr
L099  *-----------------------------------------------------
 ''   *  Para Borrar Fisicamente los registros             -
 ''   *-----------------------------------------------------
 ''  c     Borrar_Fisico BegSr
     c     Clave_Dtoh    Chain(n)  FacDedf                            90
      *
     c/Exec Sql
     c+   Delete From Facdad01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (OrdNro = :OrdNro) And
     c+             (NcfNro = :xNcfNro)
     c*       With NC
     c/End-Exec
      *
     c/Exec Sql
     c+   Delete From FacNcfCe01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (NcfNro = :xNcfNro)
     c*       With NC
     c/End-Exec
 ''   *
 ''  c                   Call      'FA0055'                             60
 ''  c                   Parm                    Distrito
 ''  c                   Parm                    TipDoc
 ''  c                   Parm                    Numero
 ''   *
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
L001 c                   EndSr
      * ----------------------------------------------------------
