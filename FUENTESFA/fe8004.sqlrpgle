      //===================================================================*/
      // Program Name: FE8004                                              */
      //  Application: Facturacion Electronica                             */
      //  Description: Retrieves an invoice for services.                  */
      //      Authors: Luis J. Miranda V. (original version for Meyker)    */
      //               Francisco Solano - fsolano@dominisoft.com.do        */
      //               DominiSoft FSM Technology & Services SRL            */
      //               (adaptations for Facturacion Electronica, marked    */
      //               with M001).                                         */
      //         Date: March 2024                                          */
      //                                                                   */
      // Compile instructions:                                             */
      // ---------------------                                             */
      //    Command: CRTSQLRPGI                                            */
      // Parameters: DBGVIEW(*SOURCE) RPGPPOPT(*LVL2)                      */
      //===================================================================*/
      //                                                                   */
      // Modification History                                              */
      // --------------------                                              */
      // Code  Date         Author           Description                   */
      // ----  -----------  ---------------  ----------------------------- */
      // M002  13-MAR-2025  F. Solano        Fix IndicadorFacturacion: it  */
      //                                     should take into account the  */
      // the customer's exempt flag, not only the service's exempt flag.   */
      //                                                                   */
      // M003  01-JUL-2026  F. Solano        Changed logic to obtain the   */
      //                                     item's tax category (indicador*/
      // facturacion) for invoices with ECF type 46 (export).              */
      //===================================================================*/

M001 h Debug Option(*SRCSTMT:*NODEBUGIO) DftActGrp(*NO)
M001 h exprOpts(*alwBlankNum) actGrp('FAELAPP') bndDir('FAELAPP')

     fFpsFach01 If   e           k disk
     fFpsFacd01 If   e           k disk
     fFpsComh   If   e           k disk
     fFpsSer01  If   e           k disk
     fCxccli01  If   e           k disk
     fCxcAdc01  If   e           k disk    Prefix(J)
     fCxcCpa01  If   e           k disk    Prefix(l)
     fSegTcf01  if   e           k disk
     fFpspar    If   e           k disk
     fSegMon    if   e           k disk    prefix(x)
     fSegCia01  If   e           k disk
     fSegPrv01  If   e           k disk
     fSegMun01  If   e           k disk
     fSegDms01  If   e           k disk
M001 fFE8004pt  o    e             printer Oflind(*In66) usropn
      *
M001  /define STANDARD
M001  /define UTILITY
M001  /define TEXT_FOR_MESSAGES
M001  /define SERVICE
M001  /define APPLICATION_MESSAGES
M001  /include FUENTESFE,PROTOTYPES

     d parcve          s              1    inz('@')
     d conta           s              5  0 inz(*zeros)
      *
     d Temporal        S             50    Inz(*Blanks)
     d Temporal_1      S             50    Inz(*Blanks)
     d t               S              2  0 Inz(*Zeros)
     d p               S              2  0 Inz(*Zeros)
      *
      * Campos que Son Enviados Como Parametros
     d FechaFacIso     s                   Like(SqlSegFec.FecIso)
     d FechaFinNcf     s                   Like(SqlSegFec.FecIso)
     d TipProNcf       s              1    Inz('P')
     d StatusNcf       s               n   Inz(*Off)
      *
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified

M001 d distrito_t      S              3P 0 template
M001 d tipoDocumento_t...
M001 d                 S              1P 0 template
M001 d numeroDocumento_t...
M001 d                 S             10P 0 template
M001 d CodTip          s                   like(FacTip)
      *
      /Copy Fuentes,SG9001

      * Estructura de datos interfaz con Facturacion Electronica:
M001  /include FUENTESFE,STDFORMATS

M001  /Copy *LIBL/FUENTESFE,FE800000

M001  * Eliminar digitos alfanumericos de un campo
M001 d EliminarAlf     Pr                  ExtPgm('SG7015')
M001 d  Campo_1                      20A   const
M001 d  Status_1                       n   const

      **FE8004 Prototype
     d FE8004          Pr                  extpgm
M001 d  distrito                           Like(distrito_t)
M001 d  tipoDocumento                      Like(tipoDocumento_t)
M001 d  numeroDoc                          Like(numeroDocumento_t)
M001 d  documento                          likeds(
M001 d                                     TIPO_DOCUMENTO_ELECTRONICO_V10)
M001 d  isOK                           N
      *
      **FE8004 Program Interface
     d FE8004          Pi
M001 d  distrito                           Like(distrito_t)
M001 d  tipoDocumento                      Like(tipoDocumento_t)
M001 d  numeroDoc                          Like(numeroDocumento_t)
M001 d  documento                          likeds(
M001 d                                     TIPO_DOCUMENTO_ELECTRONICO_V10)
M001 d  isOK                           N

      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
      *
     c     *Like         Define    DisCve        CodDis
     c     *Like         Define    MonCve        CodMon
     c     *Like         Define    FacNro        NroFac
      *
M001 c                   Eval      CodDis = distrito
M001 c                   Eval      CodMon = MONEDA_LOCAL
M001 c                   Eval      CodTip = tipoDocumento
M001 c                   Eval      NroFac = numeroDoc
      *
     c     Clave_Fac     Klist
     c                   Kfld                    CodDis
     c                   Kfld                    CodMon
     c                   Kfld                    CodTip
     c                   Kfld                    NroFac
      *
     c     Clave_Comh    Klist
     c                   Kfld                    CodDis
     c                   Kfld                    CodMon
     c                   Kfld                    CodTip
     c                   Kfld                    NroFac
     c                   Kfld                    SerCve
     c                   Kfld                    FacSec
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
M001   monitor ;
     c                   Exsr      Proceso_Imp
     c                   Eval      *Inlr = *On
M001 c                   return
M001   on-error ;
M001     snd-msg ut_build_text_for_program_error_message(
M001       MsgPgm
M001     : %status()
M001     : ErrMsgId
M001     : ErrMsg) ;
     c                   Eval      *Inlr = *On
M001 c                   return
M001   endmon;

      * ----------------------------------------------------------
      * Impresion de Factura                                     -
      * ----------------------------------------------------------
     c     Proceso_Imp   Begsr
      *
M001        if *off;
M001          open FE8004PT ;
M001        endif;
     c                   Eval      *In99 = *Off
      *
     c     Clave_Fac     Chain(n)  FpsFachf                           32
M001   isOK = %found(FpsFach01) ;
     c     ParCve        Chain(n)  FpsParf                            91
     c     Clicve        Chain(n)  CxcClif                            91
     c     Clicve        Chain(n)  CxcAdcf                            91
     c     jCpaCve       Chain(n)  CxcCpaf                            91
     c                   Eval      DesCpa = %Trim(lCpaDes)
M001   TipoPago = sv_dgii_get_payment_type(jCpaCve) ;
     c     moncve        Chain(n)  Segmonf                            91
     c                   Eval      Simbolo = %Trim(xMonSim)
     c                   If        MonCve <> *Zeros
     c                   Eval      *In17 = *On
     c                   Else
     c                   Eval      *In17 = *Off
     c                   EndIf
      * Provincia
     c                   Eval      PrvCve = CliPrv
     c     PrvCve        Chain     SegPrvf                            99
     c                   If        Not %Found(SegPrv01)
     c                   Clear                   PrvDes
     c                   EndIf
      * Municipio
     c                   Eval      PrvCve = CliPrv
     c                   Eval      MunCve = CliMun
     c     Clave_Mun     Chain     SegMunf                            99
     c                   If        Not %Found(SegMun01)
     c                   Clear                   MunDes
     c                   EndIf
      * Distrito Municipal o Sector
     c                   Eval      PrvCve = CliPrv
     c                   Eval      MunCve = CliMun
     c                   Eval      DmsCve = CliDms
     c                   Eval      DmsCpo = CliCpo
     c                   Eval      DmsSec = CliSec
     c     Clave_Dms     Chain     SegDmsf                            99
     c                   If        Not %Found(SegDms01)
     c                   Clear                   DmsDes
     c                   EndIf
      *
M001 c                   Eval      TcfCve = obtenerTipoEcf(NCFNRO)
M001   eNcf = NCFNRO ;
M001   TipoeCF = TcfCve ;
     c     TcfCve        Chain(n)  SegTcff                            90
     c                   If        Not %Found(SegTcf01)
     c                   Clear                   TcfDes
     c                   Else
     c                   Eval      TcfDes = %Trimr(TcfDes)
     c                   EndIf
      *
     c                   Eval      FechaFacIso = FacFec
     c                   Exsr      Buscar_Ncf
     c                   Eval      FecFfp = %Dec(FechaFinNcf:*Eur)
M001   FechaVencimientoSecuencia = FechaFinNcf ;
M001   RNCComprador = obtenerRncComprador() ;
      *
      * Imprimir factura
      *
     c                   If        CliTe2 <> *Blanks
     c                   Eval      Telefono = %Trim(CliTe1) + ' Otro: ' +
     c                                              CliTe2
     c                   Else
     c                   Eval      Telefono = %Trim(CliTe1)
     c                   EndIf
      *
     c                   If        *In99 = *Off
M001 c                   if        *off
     c                   Write     header
M001 c                   endif
     c                   Eval      *In99 = *On
     c                   EndIf
M001   NumeroFacturaInterna = %Editc(FACNRO:'X')   ;
M001   FechaEmision = obtenerFechaEmision(FECFAC) ;
M001   RazonSocialComprador = %Trim(CliNom) ;
M001   DireccionComprador = %trimr(CLIDIR) + %trimr(CLIDI1) ;
M001   TerminoPago = DESCPA ;
M001   FechaLimitePago = obtenerFechaLimitePago(FechaEmision:LCPADCR) ;
M001   llenarEncabezadoInterfazFacturacionElectronica();
      *
      * Imprime detalles
      *
     c                   Eval      *In25 = *Off
      *
     c     Clave_Fac     Setll     FpsFacdf
      *
     c                   Dow       Not *In25
     c     Clave_Fac     Reade(n)  FpsFacdf                               25
      *
     c                   If        Conta = 14
M001 c                   if        *off
     c                   Write     Sigue
     c                   Write     Header
M001 c                   endif
     c                   Clear                   Conta
     c                   EndIf
      *
     c                   If        Not *In25
      *
     c     SerCve        Chain(n)  FpsSerf                            26
M001 c                   if        *off
     c                   Write     Detail
M001 c                   endif
M003   IndicadorFacturacion = obtenerIndicadorFacturacion( CLIEXE
M003                                                     : SEREI1
M003                                                     : TipoeCF ) ;
M001   NombreItem = %trimr(SERDES) ;
M001   IndicadorBienoServicio = INDICADOR_BIEN_O_SERVICIO_ES_SERVICIO ;
M001   CantidadItem = FACCAN ;
M001   PrecioUnitarioItem = FACPVS ;
M001   MontoItem = FACIMP ;
M001   asignarItbis(IndicadorFacturacion) ;
M001   UnidadMedida = UNIDAD_MEDIDA_UNIDAD_UND ;
M001   agregarItemInterfazFacturacionElectronica() ;
M001   TipoIngresos = obtenerTipoIngresos(TIGCVE:FACIMP) ;
     c                   Eval      Conta += 1
      *
     c                   Eval      *In26 = *Off
     c     Clave_Comh    Setll     FpsComhf
      *
     c                   Dow       Not *In26
     c     Clave_Comh    reade(n)  FpsComhf                               26
      *
     c                   If        Conta = 14
M001 c                   if        *off
     c                   Write     Sigue
     c                   Write     Header
M001 c                   endif
     c                   Clear                   Conta
     c                   EndIf
      *
     c                   If        Not *In26
      *
M001 c                   if        *off
     c                   Write     Coment
M001 c                   endif
     c                   Eval      Conta += 1
      *
     c                   EndIf
     c                   EndDo
      *
     c                   EndIf
     c                   EndDo
      *
     c                   If        Conta > 14
M001 c                   if        *off
     c                   Write     Header
M001 c                   endif
     c                   EndIf
      *
M001 c                   if        *off
     c                   Write     Total_1
M001 c                   endif

M001   IndicadorMontoGravado = INDICADOR_MONTO_GRAVADO_ITBIS_NO_INCLUIDO ;
M003   TotalItbis = TotalItbis1 + TotalItbis2 + TotalItbis3 ;
M003   MontoGravadoTotal = MontoGravadoI1 + MontoGravadoI2 + MontoGravadoI3 ;
M003   MontoTotal = MontoGravadoTotal + MontoExento + TotalItbis ;
M001   llenarTotalesInterfazFacturacionElectronica() ;
M001   actualizarEncabezadoInterfazFacturacionElectronica(TipoIngresos) ;
      *
     c                   EndSr
      *-----------------------------------------------------------
      * Centralizar un campos en una Variable                    -
      *-----------------------------------------------------------
     c     Centra        Begsr
      *  Titulo si es anexo o estado.
     c                   Clear                   t
     c                   Clear                   p
     c                   Clear                   Temporal_1
     c                   Eval      Temporal_1 = Temporal
     c                   Clear                   Temporal
      *
     c     ' '           Checkr    Temporal_1    t
     c                   If        t < %Size(Temporal_1) - 2
     c                   Eval      p = ((%Size(Temporal_1) - t) / 2) + 1
     c                   Else
     c                   Eval      p = 1
     c                   Endif
      *
     c     Temporal      Cat       Temporal_1:p  Temporal
     c                   Endsr
      *-----------------------------------------------------
      *  Buscar Numero de Ncf                              -
      *-----------------------------------------------------
     c     Buscar_Ncf    BegSr
      *
     c     *Like         Define    NcfNro        NumNcf
     c                   Clear                   NumNcf
      *
     c                   Call      'SG7011'
     c                   Parm      04            Mcfcve            2 0
     c                   Parm                    DisCve
     c                   Parm                    MonCve
     c                   Parm                    TcfCve
     c                   Parm      NcfNro        NumNcf
     c                   Parm                    FechaFacIso
     c                   Parm                    FechaFinNcf
     c                   Parm                    TipProNcf
     c                   Parm                    StatusNcf
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr
      *
M001   clear documento ;

     c     Numcia        Chain(n)  SegCiaf
M001   if %found(SegCia01) ;
M001     asignarValoresCompania() ;
M001   endif;
     c                   Eval      Temporal = Nomcia
     c                   Exsr      Centra
     c                   Eval      wCianom = Temporal
      *
     c                   Eval      Temporal = Ciacal
     c                   Exsr      Centra
     c                   Eval      wCiacal = Temporal
      *
     c                   Eval      Temporal = %Trim(CiaSec) + ', ' + CiaCiu
     c                   Exsr      Centra
     c                   Eval      wCiaciu = Temporal
      *
     c                   Eval      Temporal = CiaRnc
     c                   Exsr      Centra
     c                   Eval      wCiaIde = Temporal
      *
     c                   EndSr
      // -----------------------------------------------------
      //                SUB - PROCEDIMIENTOS
      // -----------------------------------------------------
M001 p asignarValoresCompania...
M001 p                 b
M001 d CampoAlf        s             20    Inz(*Blanks)
M001 d StatusAlf       s               n   Inz(*Off)
M001   CampoAlf = %Trim(CiaRnc)  ;
M001   EliminarAlf(CampoAlf :StatusAlf);
M001   RncEmisor = %Dec(CampoAlf:11:0)   ;
M001   RazonSocialEmisor = %Trim(CiaNom)   ;
M001   NombreComercial = %Trim(CiaGir)   ;
M001   DireccionEmisor = %Trim(CiaCal) + ', ' +
M001                     %Trim(CiaSec) + ', ' +
M001                     %Trim(CiaCiu)         ;
M001   CorreoEmisor = %Trim(CiaDem)           ;
M001   WebSite = %Trim(CiaDin)           ;
M001   return ;
M001 p                 e
      // -----------------------------------------------------
M001 p obtenerTipoEcf  b

M001 d *n              pi                  like(TipoEcf)
M001 d numeroNCF                           Like(NCFNRO) const
M001 d tipoNcf         s              2A
M001   tipoNcf = %subst(numeroNCF:2:2) ;
M001   monitor ;
M001     return %Dec(tipoNcf:2:0) ;
M001   on-error ;
M001     return 0 ;
M001   endmon;
M001 p                 e
      // -----------------------------------------------------
M001 p obtenerRncComprador...
M001 p                 b
M001 d *n              pi                  like(RNCComprador)
M001   monitor ;
M001 c                   Select
M001 c*                  When      TcfTds = 'R'
M001 c*                  Eval      Ide = 'Rnc: ' + %Trim(CliRnc)
      *
M001 c                   When      CliIdn = 'R'
M001 c                   Eval      Ide = 'Rnc: ' + %Trim(CliRnc)
M001 c                   return    %Trim(CliRnc)
      *
M001 c*                  When      TcfTds = 'C'
M001 c*                  Eval      Ide = 'Cedula: ' + %Trim(CliCed)
      *
M001 c                   When      CliIdn = 'C'
M001 c                   Eval      Ide = 'Cedula: ' + %Trim(CliRnc)
M001 c                   return    %Trim(CliRnc)
      *
M001 c*                  When      TcfTds = 'E'
M001 c*                  Eval      Ide = 'Codigo: ' + %Trim(CliCex)
      *
M001 c                   When      CliIdn = 'P'
M001 c                   Eval      Ide = 'Pasaporte: ' + %Trim(CliRnc)
M001 c                   return    %Trim(CliRnc)

M001 c                   Other
M001 c                   Eval      Ide = *Blanks
M001 c                   return    ''
M001 c                   EndSl
M001   on-error ;
M001     return '' ;
M001   endmon ;
M001 p                 e
      // -----------------------------------------------------
M001 p obtenerFechaEmision...
M001 p                 b
M001 d *n              pi                  like(FechaEmision)
M001 d  fechaEmisionNumerica...
M001 d                                     like(FECFAC) const
M001   monitor ;
M001     return %date(FECFAC:*eur) ;
M001   on-error ;
M001     return d'0001-01-01' ;
M001   endmon;
M001 p                 e
      // -----------------------------------------------------
M001 p obtenerIndicadorFacturacion...
M001 p                 b
M001 d *n              pi                  like(IndicadorFacturacion)
M002 d  flagClienteExentoDeImpuestos...
M002 d                                     like(CLIEXE) const
M001 d  flagServicioExentoDeImpuestos...
M001 d                                     like(SEREI1) const
M003 d  tipoComprobante...
M003 d                                     like(TipoeCF) const

M002   select ;
M003     when tipoComprobante = TIPO_ECF_COMPROBANTE_EXPORTACIONES_ELECTRONICO ;
M003       return INDICADOR_FACTURACION_ITBIS3_CERO_PORCIENTO ;
M002     when flagClienteExentoDeImpuestos = CLIENTE_EXENTO_DE_IMPUESTOS_SI ;
M002       return INDICADOR_FACTURACION_EXENTO ;
M002     when flagServicioExentoDeImpuestos = SERVICIO_EXENTO_DE_IMPUESTOS_SI ;
M002       return INDICADOR_FACTURACION_EXENTO ;
M002     other ;
M002       return INDICADOR_FACTURACION_ITBIS1_18_PORCIENTO ;
M002   endsl;
M001 p                 e
      // -----------------------------------------------------
M001 p obtenerFechaLimitePago...
M001 p                 b
M001 d *n              pi                  like(FechaLimitePago)
M001 d  emision                            like(FechaEmision) const
M001 d  diasDeCredito                      like(LCPADCR) const
M001   monitor ;
M001     return emision + %Days(diasDeCredito) ;
M001   on-error ;
M001     return emision ;
M001   endmon;
M001 p                 e
      // -----------------------------------------------------
001  p obtenerTipoIngresos...
M001 p                 b
M001 d *n              pi                  like(TipoIngresos)
M001 d  tipoIngreso                        like(TIGCVE) const
M001 d  importe                            like(FACIMP) const
M001 d tipoIngresoAnterior...
M001 d                 s                   like(tipoIngreso) static
M001 d importeAnterior...
M001 d                 s                   like(importe) static
M001   if importe > importeAnterior ;
M001     importeAnterior = importe ;
M001     tipoIngresoAnterior = tipoIngreso ;
M001   endif;
M001   return tipoIngresoAnterior ;
M001 p                 e
      // -----------------------------------------------------
M001 p asignarItbis    b
M001 d *n              pi
M001 d  indFacturacion...
M001 d                                     like(IndicadorFacturacion) const
M001   select ;
M001     when indFacturacion = INDICADOR_FACTURACION_ITBIS1_18_PORCIENTO ;
M001       Itbis1 = TASA_ITBIS1 ;
M001       TotalItbis1 += FACII1 ;
M001       MontoGravadoI1 += FACIMP ;
M003     when indFacturacion = INDICADOR_FACTURACION_ITBIS3_CERO_PORCIENTO ;
M003       Itbis3 = TASA_ITBIS3 ;
M003       MontoGravadoI3 += FACIMP ;
M001     when indFacturacion = INDICADOR_FACTURACION_EXENTO ;
M001       MontoExento += FACIMP ;
M001   endsl ;
M001 p                 e
      // -----------------------------------------------------
M001 p llenarEncabezadoInterfazFacturacionElectronica...
M001 p                 b
M001   // ID del documento
M001   documento.encabezado.idDoc.tipoECF = TipoeCf ;
M001   documento.encabezado.idDoc.eNCF = %trimr(eNcf) ;
M001   documento.encabezado.idDoc.fechaVencimientoSecuencia =
M001     FechaVencimientoSecuencia ;
M001   documento.encabezado.idDoc.indicadorMontoGravado =
M001     %editc(IndicadorMontoGravado:'X') ;
M001   documento.encabezado.idDoc.tipoPago = TipoPago ;
M001   documento.encabezado.idDoc.fechaLimitePago = FechaLimitePago ;

M001   // emisor
M001   documento.encabezado.emisor.rncEmisor = RncEmisor ;
M001   documento.encabezado.emisor.razonSocialEmisor =
M001    %trimr(RazonSocialEmisor);
M001   documento.encabezado.emisor.nombreComercial = %trimr(NombreComercial) ;
M001    documento.encabezado.emisor.direccionEmisor = %trimr(DireccionEmisor) ;
M001   documento.encabezado.emisor.numeroFacturaInterna =
M001     %trimr(NumeroFacturaInterna) ;
M001   documento.encabezado.emisor.fechaEmision = %timestamp(FechaEmision) ;

M001   // comprador
M001   documento.encabezado.comprador.rncComprador = RncComprador ;
M001   documento.encabezado.comprador.razonSocialComprador =
M001     %trimr(RazonSocialComprador) ;
M001   documento.encabezado.comprador.direccionComprador =
M001     %trimr(DireccionComprador) ;

M001   return ;
M001 p                 e
        // -----------------------------------------------------
M001 p agregarItemInterfazFacturacionElectronica...
M001 p                 b
M001   documento.detallesItem.cantidadItems += 1 ;
M001   documento.detallesItem.item(documento.detallesItem.cantidadItems).
M001     indicadorFacturacion = IndicadorFacturacion ;
M001   documento.detallesItem.item(documento.detallesItem.cantidadItems).
M001     nombreItem = %trimr(NombreItem) ;
M001   documento.detallesItem.item(documento.detallesItem.cantidadItems).
M001     indicadorBienOservicio = IndicadorBienoServicio ;
M001   documento.detallesItem.item(documento.detallesItem.cantidadItems).
M001     cantidadItem = CantidadItem ;
M001   documento.detallesItem.item(documento.detallesItem.cantidadItems).
M001     unidadMedida = UnidadMedida ;
M001   documento.detallesItem.item(documento.detallesItem.cantidadItems).
M001     precioUnitarioItem = PrecioUnitarioItem ;
M001   documento.detallesItem.item(documento.detallesItem.cantidadItems).
M001     montoItem = MontoItem ;
M001   return ;
M001 p                 e
        // -----------------------------------------------------
M001 p llenarTotalesInterfazFacturacionElectronica...
M001 p                 b
M001   // totales
M001   documento.encabezado.totales.montoGravadoTotal = MontoGravadoTotal ;
M001   documento.encabezado.totales.montoGravado1 = MontoGravadoI1 ;
M001   documento.encabezado.totales.montoGravado2 = MontoGravadoI2 ;
M001   documento.encabezado.totales.montoGravado3 = MontoGravadoI3 ;
M001   documento.encabezado.totales.montoExento = MontoExento ;
M001   documento.encabezado.totales.itbis1 = Itbis1 ;
M001   documento.encabezado.totales.itbis2 = Itbis2 ;
M001   documento.encabezado.totales.itbis3 = Itbis3 ;
M001   documento.encabezado.totales.totalITBIS = TotalITBIS ;
M001   documento.encabezado.totales.totalITBIS1 = TotalITBIS1 ;
M001   documento.encabezado.totales.totalITBIS2 = TotalITBIS2 ;
M001   documento.encabezado.totales.totalITBIS3 = TotalITBIS3 ;
M001   documento.encabezado.totales.montoTotal = MontoTotal ;
M001   documento.encabezado.totales.valorPagar =
M001     documento.encabezado.totales.montoTotal ;
M001   return ;
M001 p                 e
        // -----------------------------------------------------
M001 p actualizarEncabezadoInterfazFacturacionElectronica...
M001 p                 b
M001 d *n              pi
M001 d  tipoIngreso                        like(TipoIngresos) const
M001   documento.encabezado.idDoc.tipoIngresos = tipoIngreso ;
M001 p                 e
        // -----------------------------------------------------
