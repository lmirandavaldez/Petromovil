**FREE
// ================================================================
// IDENTIFICACION:
// ---------------
// NOMBRE DEL PROGRAMA .........: FA7002
// APLICACION...................: Facturacion
// AUTOR .......................: Luis J. Miranda V.
// FECHA ESCRITURA .............: 04 / 10 / 99
// DESCR:
//         Proceso actualizacion de factura
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 02 / 05 / 2007
// DESCR: Se Agrego el archivo para controlar el costo Promedio
//         y el ultimo. Idef. L001
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 27 / 05 / 2008
// DESCR: Agregar Calculos Impuesto anticipo ventas al Gobierno
//         Idef. L004
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 25 / 06 / 2010
// DESCR: Agregar modificacion que permita facturar algunos
//         productos en otra empresa que no sea la asignada en los
//         parametros.  Idef. L099
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 25 / 06 / 2010
// DESCR: Agregar Condiciones para que los tipo de documentos
//         DtoTip = 4 y 5 los cuales son facturas emitidas por
//         una aplicacion Externa.  L006
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 21 / 04 / 2014
// DESCR: Agregar Archivo Datos Adicionales detalle de Factura
//        Inicialmente solo se esta grabando solo los productos
//        compensado, pero este archivo se puede usar para
//        cualquier otra informacion adicional en detalle. L007
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 15 / 02 / 2015
// DESCR: Se agrego una condicion para cuando las facturas sean
//        de Modulos externos (Pre-Pago-Tipo Documento = 5 y
//        Credito-Tipo Documento = 6 se puede usar el mismo
//        codigo de cliente con tipo de NCF diferente
//        Pre-Pago = 12 Unico Ingreso
//        Credito  = 01 Credito Fiscal                   L008
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 19 / 03 / 2018
// DESCR: Se Cambio la condicion para que las facturas-conduce
//        salida de Pre-Pagos/Cupones = Tipo Documento = 5
//        no asuma un Numero de Comprobante fiscal valido
//        para evitar que sea facturado dos Veces         L009
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 26 / 06 / 2018
// Codigo Modificacion..........: L001
// DESCR: Agregar Campos en los Parametros de envio
// ----------------------------------------------------------------
// Modificado por ..............: Francisco Solano
// Fecha de modificacion........: 27 / 04 / 2024
// Codigo Modificacion..........: M001
// DESCR: Llamar programa para envio de documento a DGII.
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 11 / 04 / 2025
// Codigo Modificacion..........: L007
// DESCR: Comentar actualizacion de los archivos de estadisticas
//         los cuales dejaron de ser necesarios
// ----------------------------------------------------------------
// Modificado por ..............: Luis J. Miranda V.
// Fecha de modificacion........: 04 / 12 / 2025
// Codigo Modificacion..........: L008
// DESCR: Verificar que cuando sea el Rnc de la empresa y el tipo
//         de comprobante sea E32 y sobre pasa el monto tope no
//         debera procesar el documento
// ================================================================
Ctl-Opt Datedit(*Dmy)
        Copyright('Miranda Valdez, S. A., 1998')
        Debug Option(*SrcStmt:*NoDebugIo);

// ----------------------------------------------------------------
// Archivos
// ----------------------------------------------------------------
Dcl-F FacOrdh06  Usage(*Update)     Keyed;
Dcl-F FacOrdd01  Usage(*Update)     Keyed;
Dcl-F FacDem01   Usage(*Update)     Keyed;
Dcl-F FacOrcd01  Usage(*Update)     Keyed;
Dcl-F FacDad     Usage(*Input)      Keyed  Prefix(e_);    // L006
Dcl-F FacOrhd    Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacPar     Usage(*Update)     Keyed;
Dcl-F CxcAdc01   Usage(*Update)     Keyed  Prefix(l);
Dcl-F CxcCli01   Usage(*Update)     Keyed  Prefix(o);
Dcl-F InvArt01   Usage(*Update)     Keyed  Prefix(x);
Dcl-F InvDad01   Usage(*Input)      Keyed  Prefix(J_);    // L004
Dcl-F InvUal01   Usage(*Update)     Keyed;
Dcl-F InvUnd01   Usage(*Update)     Keyed;
Dcl-F InvTmo03   Usage(*Update)     Keyed  Prefix(r);
Dcl-F FacDtoh01  Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacDtod01  Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacDtoda01 Usage(*Output:*Update:*Delete) Keyed;    // L007
Dcl-F FacDed01   Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacDpr01   Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacBorh01  Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacBord01  Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacTrth01  Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacTrtd01  Usage(*Output:*Update:*Delete) Keyed;
Dcl-F FacFol     Usage(*Output:*Update)         Keyed  UsrOpn;
Dcl-F EstGen01   Usage(*Output:*Update:*Delete) Keyed;
Dcl-F EstArt01   Usage(*Output:*Update:*Delete) Keyed;
Dcl-F EstCli01   Usage(*Output:*Update:*Delete) Keyed;
Dcl-F EstMar01   Usage(*Output:*Update:*Delete) Keyed;
Dcl-F EstPcl01   Usage(*Output:*Update:*Delete) Keyed;
Dcl-F EstVen01   Usage(*Output:*Update:*Delete) Keyed;

// ----------------------------------------------------------------
// Variables individuales cargadas via SQL en *InzSr.
// Tipos basados en definicion de tablas del sistema.
// ----------------------------------------------------------------
Dcl-S Ip_ParMti   Packed(15:2);  // ItePar.ParMti  — monto tope NCF E32
Dcl-S Sc_CiaRnc   Char(16);      // SegCia.CiaRnc  — RNC de la empresa
Dcl-S Sf_FecIso   Char(10);      // SegFec.FecIso  — formato fecha ISO

// ----------------------------------------------------------------
// Prototipos de programas externos
// ----------------------------------------------------------------
Dcl-Pr EliminarAlf  ExtPgm('SG7015');
  Campo_1   Like(w_CiaRnc);            // Char(16) declarado abajo
  Status_1  Like(StatusAlf);
End-Pr;

Dcl-Pr FA7003AS  ExtPgm('FA7003AS');
  p_DisCve  Like(DisCve);
  p_TraNro  Like(TraNro);
  p_TmoCve  Like(TmoCve);
End-Pr;

Dcl-Pr FA7050  ExtPgm('FA7050');
  p_OrdNum   Like(OrdNum);
  p_DisCve   Like(DisCve);
  p_TipDoc   Like(TipDoc);
  p_NumDoc   Like(NumDoc);
  p_PveArt   Like(PveArt);
End-Pr;

Dcl-Pr FA7052  ExtPgm('FA7052');
  p_Distrito  Like(Distrito);
  p_OrdNum    Like(OrdNum);
  p_Producto  Like(Producto);
End-Pr;

Dcl-Pr FA7054  ExtPgm('FA7054');
  p_Distrito      Like(Distrito);
  p_OrdNum        Like(OrdNum);
  p_PveArt        Like(PveArt);
  p_Factura_Cia3  Like(Factura_Cia3);
End-Pr;

Dcl-Pr FA7060  ExtPgm('FA7060');
  p_ArtCve  Like(ArtCve);
  p_FecTra  Like(FecTra);
  p_Costo   Like(Costo);
End-Pr;

Dcl-Pr FA7061  ExtPgm('FA7061');
  p_ArtCve    Like(ArtCve);
  p_FecAmd    Like(FecAmd);
  p_CostoPro  Like(CostoPro);
  p_CostoUlt  Like(CostoUlt);
  p_TotalCan  Like(Total_Can);
End-Pr;

Dcl-Pr IV7004  ExtPgm('IV7004');
  p_ArtCve      Like(ArtCve);
  p_FechaPrecio Like(FechaPrecio);
  p_Precio      Like(Precio);
End-Pr;

Dcl-Pr CC7001  ExtPgm('CC7001');
  p_CliCve  Like(CliCve);
  p_DtoNro  Like(DtoNro);
  p_DisCve  Like(DisCve);
  p_FecTra  Like(FecTra);
  p_DtoMne  Like(DtoMne);
  p_CpaCve  Like(CpaCve);
  p_VenCve  Like(VenCve);
  p_ParFcc  Like(ParFcc);
  p_DtoMbr  Like(DtoMbr);
  p_MonDes  Like(MonDes);
  p_MonImp  Like(MonImp);
  p_Refere  Char(10);
  p_NcfNro  Like(NcfNro);
  p_CliIde  Like(CliIde);
End-Pr;

Dcl-Pr SG7009  ExtPgm('SG7009');
  p_Sistema       Like(Sistema);
  p_CodParametro  Like(CodParametro);
  p_ValorNum      Like(ValorNum);
  p_ValorAlf      Like(ValorAlf);
End-Pr;

Dcl-Pr SG7011  ExtPgm('SG7011');
  p_Mcfcve       Packed(2:0);
  p_DisCve       Like(DisCve);
  p_lMonCve      Like(lMonCve);
  p_lTcfCve      Like(lTcfCve);
  p_NumNcf       Like(NumNcf);
  p_FechaFacIso  Like(FechaFacIso);
  p_FechaFinNcf  Like(FechaFinNcf);
  p_TipProNcf    Like(TipProNcf);
  p_StatusNcf    Like(StatusNcf);
End-Pr;

Dcl-Pr FE3003A  ExtPgm('FE3003A');
  p_DisCve         Like(DisCve);
  p_TipDoc         Like(TipDoc);
  p_DtoNro         Like(DtoNro);
  p_TipoDocInterno Like(TipoDocInterno);
End-Pr;

// ----------------------------------------------------------------
// Variables de trabajo
// ----------------------------------------------------------------
Dcl-S FolCve        Packed(3:0)  Inz(001);
Dcl-S Fecha         Date         Datfmt(*Iso);
Dcl-S ParCve        Char(1)      Inz('@');
Dcl-S Producto      Ind;
Dcl-S Factura_Cia3  Ind;                                 // L099
Dcl-S TipoDocInterno Char(4);                            // M001

// Campos enviados como parametros a subprogramas NCF
Dcl-S FechaFacIso   Like(Sf_FecIso);
Dcl-S FechaFinNcf   Like(Sf_FecIso);
Dcl-S TipProNcf     Char(1)   Inz('E');
Dcl-S StatusNcf     Ind       Inz(*Off);
Dcl-S CampoAlf      Char(20)  Inz(*Blanks);
Dcl-S StatusAlf     Ind       Inz(*Off);
Dcl-S w_CiaRnc      Char(16)  Inz(*Blanks);   // RNC limpio de la empresa

// L007 - Compensacion y codigos de articulos
Dcl-S Compen        Char(1)   Inz(*Blanks);
Dcl-S Cod001        Like(ArtCve)  Inz(*Blanks);
Dcl-S Cod002        Like(ArtCve)  Inz(*Blanks);
Dcl-S Cod003        Like(ArtCve)  Inz(*Blanks);
Dcl-S Cliente_Sind  Ind;

// Parametros del sistema (SG7009)
Dcl-S Sistema       Char(2)       Inz('FA');
Dcl-S CodParametro  Packed(4:0)   Inz(*Zeros);
Dcl-S ValorNum      Packed(30:15) Inz(*Zeros);
Dcl-S ValorAlf      Char(100)     Inz(*Blank);

// Variables de totales - cabecera documento
Dcl-S Tot_MonBru  Like(DtoMbr);
Dcl-S Tot_Descu1  Like(DtoMd1);
Dcl-S Tot_Descu2  Like(DtoMd2);
Dcl-S Tot_Impue1  Like(DtoMi1);
Dcl-S Tot_Impue2  Like(DtoMi2);
Dcl-S Tot_MonNet  Like(DtoMne);
Dcl-S Tot_CosPro  Like(DtoMpr);
Dcl-S Tot_CosUlt  Like(DtoMul);
Dcl-S Tot_ImpCos  Like(TraCos);

// Variables de totales - detalle documento
Dcl-S Dto_MonBru  Like(DtoMbr);
Dcl-S Dto_Descu1  Like(DtoMd1);
Dcl-S Dto_Descu2  Like(DtoMd2);
Dcl-S Dto_Impue1  Like(DtoMi1);
Dcl-S Dto_Impue2  Like(DtoMi2);
Dcl-S Dto_MonNet  Like(DtoMne);
Dcl-S Dto_CosPro  Like(DtoMpr);
Dcl-S Dto_CosUlt  Like(DtoMul);
Dcl-S Dto_DtoVc1  Like(DtoVc1);          // L004

// Variables monetarias auxiliares
Dcl-S MonDes      Like(DtoMd1);
Dcl-S MonImp      Like(DtoMi1);
Dcl-S MonDes_Dto  Like(DtoMd1);
Dcl-S MonImp_Dto  Like(DtoMi1);

// Variables estadisticas
Dcl-S AnoEst      Like(EstAno);
Dcl-S MesEst      Like(EstMes);

// Variables de costo/precio
Dcl-S CopUal      Like(DtoCop);
Dcl-S CouUal      Like(DtoCou);
Dcl-S CopCuv      Like(DtoCou);
Dcl-S CouCuv      Like(DtoCou);
Dcl-S TotLib      Like(DtoCup);
Dcl-S TotCaj      Like(DtoCan);
Dcl-S TotDes      Like(DtoMpd);
Dcl-S TotImp      Like(DtoIm1);
Dcl-S MonNet      Like(DtoMne);

// Variables de secuencia
Dcl-S Secuen      Like(DtoSec);
Dcl-S Secuen_b    Like(DtoSec);
Dcl-S Control     Packed(1:0);

// L006 - Facturas externas
Dcl-S ParFcc      Like(ParCrf);

// Variables derivadas de campos de archivo
Dcl-S FechaPrecio Like(FecTra);

// Variables NCF
Dcl-S NumNcf      Like(NcfNro);
Dcl-S ManejaExist Char(1);

// Variables de costo
Dcl-S Costo       Like(xArtCpl);
Dcl-S CostoPro    Like(xArtCpl);
Dcl-S CostoUlt    Like(xArtCul);
Dcl-S Total_Can   Packed(13:2);

// L004 - Impuesto anticipo
Dcl-S PorAnt      Packed(5:2);
Dcl-S Por_ImpAnt  Packed(7:4);

// Referencia a campos de archivo renombrados (parametros)
Dcl-S pCliCve     Like(CliCve);

// Referencia para foliador
Dcl-S FecAmd      Packed(8:0);

// Precio regulado
Dcl-S Precio      Like(xArtPml);

// Variables para PveArt (L099)
Dcl-S PveArt      Like(xArtPve);

// Variable auxiliar para llamada a CC7001
Dcl-S Refere      Char(10)    Inz(*Blanks);

// Variable auxiliar para llamada a SG7011
Dcl-S Mcfcve      Packed(2:0) Inz(01);

// Copy del servicio de globales
/Copy Fuentes,SG9001

// ----------------------------------------------------------------
// BLOQUE PRINCIPAL
// ----------------------------------------------------------------
Dcl-Pi *N;
  Distrito      Like(DisCve);
  OrdNum        Like(OrdNro);
  TipDoc        Like(DtoTip);
  NumCli        Like(CliCve);
  NumDoc        Like(DtoNro);
  FechaProceso  Packed(8:0);
End-Pi;

DtoTip = TipDoc;

// Buscar Parametros Generales
Exsr PrnGenerales;

// Proceso de actualizacion
Exsr Proceso;

// Solo envia a la DGII si la serie es de Comprobante Electronico
If %Subst(NumNcf:1:1) = 'E' And TipDoc <> 4;   // M001
  Exsr EnviarDGII;
EndIf;

*InLr = *On;

// ----------------------------------------------------------------
// Proceso de actualizacion de factura
// ----------------------------------------------------------------
BegSr Proceso;

  Do;
    Chain(N) ParCve    FacParF;
    Chain    %KList(Clave_Ordh)  FacOrdhF;
    Chain    %KList(Clave_Ordh)  FacDemF;
    Chain(N) CliCve    CxcCliF;
    Chain(N) CliCve    CxcAdcF;

    // Si el Monto Neto es cero o el Rnc es el de la empresa
    // y el tipo de comprobante = E32 y el monto supera el tope, no procesar
    If OrdTin = *Zeros
       Or (w_CiaRnc = oCliRnc And lTcfCve = 32 And OrdTin > Ip_ParMti);
      Leave;
    EndIf;

    // Buscar el numero de documento
    FechaFacIso = %Char(%Dec(FechaProceso:8:0):*Eur);
    Exsr Foliador;

    // Buscar numero de NCF segun tipo de documento
    Select;
      // Facturas normales
      When DtoTip < 4 Or DtoTip > 5;
        Exsr Buscar_Ncf;
      // Factura realizada por modulo externo con NCF asignado
      When DtoTip = 4;
        Chain %KList(Clave_Ordh) FacDadF;
        If %Found(FacDad);
          NumNcf = e_NcfNro;
        EndIf;
      // Conduce de salida para registrar los cupones (Pre-Pagos)
      When DtoTip = 5;
        Clear NumNcf;
    EndSl;

    NcfNro = NumNcf;

    // Verifica si la factura tiene productos facturados por CIA3 (L099)
    Exsr Verifica_Cia3;

    // Si no maneja existencia o es factura CIA3, genera compra automatica
    If ManejaExist = 'N' Or Factura_Cia3 = *On;
      Exsr Aplicar_Compra;
    EndIf;

    // Capturar hora de proceso
    AplHor = %Time();
    TraHor = %Time();

    // Usuario y estacion de trabajo
    If User = *Blanks And Wsid = *Blanks;
      User = wAplUsr;
      Wsid = 'PROCESOBAT';
    EndIf;

    AplUsr = User;
    TraUsr = User;
    AplWsi = Wsid;
    TraWsi = Wsid;

    // Buscar tipo de movimiento segun tipo de documento
    Select;
      When DtoTip = 1;                     // Factura
        Chain(N) ParTmf InvTmoF;
        ParFcc = ParCrf;
      When DtoTip = 3;                     // Promocion
        Chain(N) ParTmp InvTmoF;
      When DtoTip = 4;                     // Factura Externa NCF
        Chain(N) ParTfe InvTmoF;
        ParFcc = ParRfe;
      When DtoTip = 5;                     // Factura Externa Ticket Pre-Pago
        Chain(N) ParTft InvTmoF;
        ParFcc = ParRft;
      When DtoTip = 6;                     // Factura Externa a Credito (L008)
        Chain(N) ParTcf InvTmoF;
        ParFcc = ParRfc;
    EndSl;

    TmoCve = rTmoCve;
    TraOrc = OrdNum;
    TraDre = %EditC(CliCve:'X');
    TraDes = %Trim(CliNom);

    // Fechas de proceso
    Fecha       = %Date(%Dec(FechaProceso:8:0):*Eur);
    FechaFacIso = %Char(Fecha:*Iso);
    FecTra      = Fecha;
    FecDre      = Fecha;
    DtoFec      = Fecha;
    FecAmd      = %Dec(%Char(Fecha:'*YYMD'):8:0);

    AnoEst = %SubDt(Fecha:*Years);
    MesEst = %SubDt(Fecha:*Months);

    Fecha  = %Date(FecOrd:*Eur);
    OrdFec = Fecha;

    DtoSta = 'A';
    DtoTas = OrdTas;

    // Grabar cabecera de documento
    Write FacDtohF;

    // Tipo comprobante Gubernamental (L004)
    If lTcfCve = 15 Or lTcfCve = 54 Or lTcfCve = 45;
      MsgCve = 99;
    EndIf;

    If CliIde = *Blanks;
      CliIde = oCliRnc;
    EndIf;

    // Grabar datos de envio del documento
    Write FacDedF;

    // Si es una promocion graba en archivo de descuentos
    If DtoTip = 3;
      pCliCve = NumCli * 1;
      Write FacDprF;
    EndIf;

    // Grabar cabecera de inventarios si hay productos con existencia
    If Producto = *On Or ManejaExist = 'S';
      Write FacTrthF;
    EndIf;

    // Actualizar planillas y transferencias en detalle
    Exsr Planillas;
    Exsr Transferencias;

    // Trabajar con el detalle del pedido
    Exsr Detalle;

    // Calcular totales de monto neto, descuentos e impuestos
    Clear Tot_Descu2;
    Clear Dto_Descu2;
    MonDes     = Tot_Descu1 + Tot_Descu2;
    MonImp     = Tot_Impue1 + Tot_Impue2;
    MonDes_Dto = Dto_Descu1 + Dto_Descu2;
    MonImp_Dto = Dto_Impue1 + Dto_Impue2;
    Tot_MonNet = Tot_MonBru - MonDes + MonImp;
    Dto_MonNet = Dto_MonBru - MonDes + MonImp;

    // Actualizar cabecera de factura
    Chain %KList(Clave_Dtoh) FacDtohF;
    If %Found(FacDtoh01);
      DtoMbr = Dto_MonBru * 1;
      DtoMd1 = Dto_Descu1 * 1;
      DtoMd2 = Dto_Descu2 * 1;
      DtoMi1 = Dto_Impue1 * 1;
      DtoMi2 = Dto_Impue2 * 1;
      DtoMne = Dto_MonNet * 1;
      DtoMpr = Dto_CosPro * 1;
      DtoMul = Dto_CosUlt * 1;
      DtoVc1 = Dto_DtoVc1 * 1;   // L004
      DtoCbu = TotCaj * 1;
      DtoCrp = TotLib * 1;
      Update FacDtohF;
    EndIf;

    Delete FacDemF;
    Delete FacOrdhF;

    // Actualizar cabecera de inventario
    Chain %KList(Clave_Trth) FacTrthF;
    If %Found(FacTrth01);
      // Nivel de situacion
      If Tot_ImpCos <> *Zeros;
        tSitCve = '1';
      Else;
        tSitCve = '7';
      EndIf;
      TraCos = Tot_ImpCos * 1;
      Update FacTrthF;
    EndIf;

    // Actualizar inventario si tiene producto con existencia
    If Producto = *On Or ManejaExist = 'S';
      Exsr Actualiza_Inv;
    EndIf;

    // Si DtoTip = 5 son Pre-Pagos, no enviar a CXC
    If DtoTip <> 5;
      Exsr Actualiza_Cxc;
    EndIf;

    // Estadisticas en resumen (L007 - comentado: ya no necesario)
    // Exsr Estadis_Res;

  EndDo;

EndSr;

// ----------------------------------------------------------------
// Actualizar documentos de inventario
// ----------------------------------------------------------------
BegSr Actualiza_Inv;

  Close FacTrth01;
  Close FacTrtd01;

  CallP FA7003AS(DisCve : TraNro : TmoCve);

  Open FacTrth01;
  Open FacTrtd01;

  // Solo copia conduce en empresas que manejan existencia
  If ManejaExist = 'S';
    Exsr CopiaConduce;
  EndIf;

EndSr;

// ----------------------------------------------------------------
// Actualizar Cuentas por Cobrar
// ----------------------------------------------------------------
BegSr Actualiza_Cxc;

  // Si la zona de venta es menor al campo ParZop, envia a CXC
  Chain(N) CliCve CxcAdcF;
  If lZonCve < ParZop;
    Refere = *Blanks;
    CallP CC7001(CliCve  : DtoNro  : DisCve : FecTra
               : DtoMne  : CpaCve  : VenCve : ParFcc
               : DtoMbr  : MonDes  : MonImp : Refere
               : NcfNro  : CliIde);                   // L001
  EndIf;

EndSr;

// ----------------------------------------------------------------
// Trabajar con el detalle del pedido
// ----------------------------------------------------------------
BegSr Detalle;

  Clear Secuen;
  Clear Secuen_b;
  Clear Tot_MonBru;
  Clear Tot_Descu1;
  Clear Tot_Descu2;
  Clear Tot_Impue1;
  Clear Tot_Impue2;
  Clear Tot_MonNet;
  Clear Tot_CosPro;
  Clear Tot_CosUlt;
  Clear Tot_ImpCos;
  Clear Dto_MonBru;
  Clear Dto_Descu1;
  Clear Dto_Descu2;
  Clear Dto_Impue1;
  Clear Dto_Impue2;
  Clear Dto_MonNet;
  Clear Dto_CosPro;
  Clear Dto_CosUlt;
  Clear Dto_DtoVc1;    // L004
  Clear MonDes;
  Clear MonImp;
  Clear MonDes_Dto;
  Clear MonImp_Dto;
  Clear TotLib;
  Clear TotCaj;
  Clear Control;

  SetLL %KList(Clave_Ordh) FacOrddF;

  Dow *In22 = *Off;
    ReadE %KList(Clave_Ordh) FacOrdd01 %Ind(*In22);

    If Not *In22;

      // Descartar registros eliminados
      If OrdSta = 'E';
        Delete FacOrddF;
        Iter;
      EndIf;

      // Si cantidad a despachar es cero, pasa a backorder
      If OrdCde <> *Zeros;

        Chain(N) ArtCve InvArtF;

        // Si la unidad es diferente a la de almacenamiento
        If OrdUnd <> xArtUve;
          Chain(N) %KList(Clave_Rau) InvUalF;
        Else;
          Chain(N) OrdUnd InvUndF;
          UalCon = xArtCuv;
        EndIf;

        // Si el articulo no maneja existencia y costo es cero
        If xArtMce = 'N' And (xArtCpl + xArtCul) = *Zeros;
          xArtCpl = .001;
          xArtCul = .001;
        EndIf;

        // Si es articulo de precio regulado o no maneja existencia
        If xArtPpr = 'S'
           Or (xArtMce = 'N' And xArtPml = *Zeros);
          Exsr Buscar_Precio;
          xArtPml = Precio * 1;
        EndIf;

        // Convertir precio en moneda extranjera
        If MonCve <> *Zeros;
          Eval(Rh) xArtPml = xArtPml / DtoTas;
        EndIf;

        // Buscar costo segun tipo de empresa (L099)
        If ManejaExist = 'N' Or Factura_Cia3 = *On;
          Exsr Buscar_Costo;
          If xArtCpl <> Costo;
            xArtCpl = Costo * 1;
          EndIf;
          If xArtCul <> Costo;
            xArtCul = Costo * 1;
          EndIf;
        Else;                              // L001
          Exsr Buscar_Costo_E;
          If xArtCpl <> CostoPro;
            xArtCpl = CostoPro * 1;
          EndIf;
          If xArtCul <> CostoUlt;
            xArtCul = CostoUlt * 1;
          EndIf;
        EndIf;

        // Costo en unidad de almacenamiento y alterna
        CopUal = xArtCpl;
        CouUal = xArtCul;
        Eval(Rh) CopCuv = ((xArtCpl / xArtCuv) * UalCon);
        Eval(Rh) CouCuv = ((xArtCul / xArtCuv) * UalCon);

        // Acumular peso / bultos
        If OrdCud <> *Zeros;
          TotLib += OrdCud;
          TotCaj += 1;
        Else;
          TotCaj += OrdCde;
        EndIf;

        // Definir costo en unidad del pedido
        If OrdUnd = xArtUve;
          DtoCop = CopUal * 1;
          DtoCou = CouUal * 1;
        Else;
          DtoCop = CopCuv * 1;
          DtoCou = CouCuv * 1;
        EndIf;

        // Asignar campos de detalle del documento
        Secuen  += 1;
        DtoSec  = Secuen  * 1;
        DtoUde  = OrdUnd  * 1;
        DtoCan  = OrdCde  * 1;
        DtoCua  = OrdCdx  * 1;
        DtoCup  = OrdCud  * 1;
        DtoPve  = OrdPve  * 1;
        DtoPor  = xArtPml * 1;
        Eval(Rh) DtoImp = OrdCde * OrdPve;
        DtoPd1  = OrdDpe  * 1;
        DtoMpd  = OrdId1  * 1;
        DtoPd2  = *Zeros;
        DtoMsd  = *Zeros;
        DtoIm1  = OrdIi1  * 1;
        DtoIm2  = OrdIi2  * 1;
        Eval(Rh) DtoMcp = OrdCde * DtoCop;
        Eval(Rh) DtoMcu = OrdCde * DtoCou;

        // Tipo comprobante Gubernamental (L004)
        If lTcfCve = 15;
          Select;
            When xArtPpr = 'S';
              Chain ArtCve InvDadF;
              Eval(Rh) DtoVd1 = DtoCan * (J_ArtVmd * Por_ImpAnt);
              DtoVd5 = J_ArtVmd * 1;
            When xArtPpr = 'N';
              Eval(Rh) DtoVd1 = DtoImp * Por_ImpAnt;
          EndSl;
        EndIf;

        Write FacDtodF;

        // Grabar datos adicionales de compensacion (L007)
        If Compen = 'S'
           And (ArtCve = Cod002 Or ArtCve = Cod003);
          Write FacDtodaF;
        EndIf;

        // Si el producto maneja existencia: grabar detalle de inventario
        If xArtMce = 'S';
          TraSec = Secuen * 1;
          TraUnd = OrdUnd * 1;
          CcoCve = *Blanks;
          TraCan = OrdCde * 1;
          TraCud = OrdCud * 1;
          TraCun = DtoCop * 1;
          Eval(Rh) TraIco = TraCan * DtoCop;
          Write FacTrtdF;

          // Estadisticas en detalle (L007 - comentado: ya no necesario)
          // Exsr Estadis_Det;

          Tot_ImpCos += TraIco;
          Tot_MonBru += DtoImp;
          Tot_CosPro += DtoMcp;
          Tot_CosUlt += DtoMcu;
        EndIf;

        Tot_Descu1 += DtoMpd;
        Tot_Impue1 += DtoIm1;
        Tot_Impue2 += DtoIm2;
        Dto_MonBru += DtoImp;
        Dto_Descu1 += DtoMpd;
        Dto_Impue1 += DtoIm1;
        Dto_Impue2 += DtoIm2;
        Dto_CosPro += DtoMcp;
        Dto_CosUlt += DtoMcu;
        Dto_DtoVc1 += DtoVd1;    // L004

        Delete FacOrddF;

      Else;
        // Backorder: cantidad = cero
        Control += 1;
        If Control = 1;
          Write FacBorhF;
        EndIf;
        Secuen_b  += 1;
        yOrdSec    = Secuen_b * 1;
        Write FacBordF;
        Delete FacOrddF;

      EndIf;
    EndIf;

  EndDo;

EndSr;

// ----------------------------------------------------------------
// Actualizar estadisticas en detalle (L007 - actualmente no activo)
// ----------------------------------------------------------------
BegSr Estadis_Det;

  Clear TotDes;
  Clear TotImp;
  Clear MonNet;

  TotDes = DtoMpd;
  TotImp = DtoIm1 + DtoIm2;
  MonNet = DtoImp - TotDes + TotImp;

  // Acumulados por articulo
  Chain %KList(Clave_EstArt) EstArtF;
  If %Found(EstArt01);
    EstCua += OrdCdx;
    EstCud += DtoCup;
    EstIbv += DtoImp;
    EstIdv += TotDes;
    EstIiv += TotImp;
    EstInv += MonNet;
    EstCpr += DtoMcp;
    EstCul += DtoMcu;
    Update EstArtF;
  Else;
    EstAno = AnoEst * 1;
    EstMes = MesEst * 1;
    EstCua = OrdCdx * 1;
    EstCud = DtoCup * 1;
    EstIbv = DtoImp * 1;
    EstIdv = TotDes * 1;
    EstIiv = TotImp * 1;
    EstInv = MonNet * 1;
    EstCpr = DtoMcp * 1;
    EstCul = DtoMcu * 1;
    Write EstArtF;
  EndIf;

  // Acumulados por marca
  Chain %KList(Clave_EstMar) EstMarF;
  If %Found(EstMar01);
    EstCua += OrdCdx;
    EstCud += DtoCup;
    EstIbv += DtoImp;
    EstIdv += TotDes;
    EstIiv += TotImp;
    EstInv += MonNet;
    EstCpr += DtoMcp;
    EstCul += DtoMcu;
    Update EstMarF;
  Else;
    MarCve = xMarCve;
    EstAno = AnoEst * 1;
    EstMes = MesEst * 1;
    EstCua = OrdCdx * 1;
    EstCud = DtoCup * 1;
    EstIbv = DtoImp * 1;
    EstIdv = TotDes * 1;
    EstIiv = TotImp * 1;
    EstInv = MonNet * 1;
    EstCpr = DtoMcp * 1;
    EstCul = DtoMcu * 1;
    Write EstMarF;
  EndIf;

  // Acumulados por articulo y cliente
  Chain %KList(Clave_EstPcl) EstPclF;
  If %Found(EstPcl01);
    EstCua += OrdCdx;
    EstCud += DtoCup;
    EstIbv += DtoImp;
    EstIdv += TotDes;
    EstIiv += TotImp;
    EstInv += MonNet;
    EstCpr += DtoMcp;
    EstCul += DtoMcu;
    Update EstPclF;
  Else;
    EstAno = AnoEst * 1;
    EstMes = MesEst * 1;
    EstCua = OrdCdx * 1;
    EstCud = DtoCup * 1;
    EstIbv = DtoImp * 1;
    EstIdv = TotDes * 1;
    EstIiv = TotImp * 1;
    EstInv = MonNet * 1;
    EstCpr = DtoMcp * 1;
    EstCul = DtoMcu * 1;
    Write EstPclF;
  EndIf;

EndSr;

// ----------------------------------------------------------------
// Actualizar estadisticas en resumen (L007 - actualmente no activo)
// ----------------------------------------------------------------
BegSr Estadis_Res;

  // Acumulados generales - solo si zona de venta < ParZop
  If lZonCve < ParZop;

    Chain %KList(Clave_EstGen) EstGenF;
    If %Found(EstGen01);
      EstIbv += Tot_MonBru;
      EstIdv += MonDes;
      EstIiv += MonImp;
      EstInv += Tot_MonNet;
      EstCpr += Tot_CosPro;
      EstCul += Tot_CosUlt;
      Update EstGenF;
    Else;
      EstAno = AnoEst * 1;
      EstMes = MesEst * 1;
      EstIbv = Tot_MonBru * 1;
      EstIdv = MonDes     * 1;
      EstIiv = MonImp     * 1;
      EstInv = Tot_MonNet * 1;
      EstCpr = Tot_CosPro * 1;
      EstCul = Tot_CosUlt * 1;
      Write EstGenF;
    EndIf;

    // Acumulados por vendedor
    Chain %KList(Clave_EstVen) EstVenF;
    If %Found(EstVen01);
      EstIbv += Tot_MonBru;
      EstIdv += MonDes;
      EstIiv += MonImp;
      EstInv += Tot_MonNet;
      EstCpr += Tot_CosPro;
      EstCul += Tot_CosUlt;
      Update EstVenF;
    Else;
      EstAno = AnoEst * 1;
      EstMes = MesEst * 1;
      EstIbv = Tot_MonBru * 1;
      EstIdv = MonDes     * 1;
      EstIiv = MonImp     * 1;
      EstInv = Tot_MonNet * 1;
      EstCpr = Tot_CosPro * 1;
      EstCul = Tot_CosUlt * 1;
      Write EstVenF;
    EndIf;

  EndIf;

  // Acumulados por cliente
  Chain %KList(Clave_EstCli) EstCliF;
  If %Found(EstCli01);
    EstIbv += Tot_MonBru;
    EstIdv += MonDes;
    EstIiv += MonImp;
    EstInv += Tot_MonNet;
    EstCpr += Tot_CosPro;
    EstCul += Tot_CosUlt;
    Update EstCliF;
  Else;
    EstAno = AnoEst * 1;
    EstMes = MesEst * 1;
    EstIbv = Tot_MonBru * 1;
    EstIdv = MonDes     * 1;
    EstIiv = MonImp     * 1;
    EstInv = Tot_MonNet * 1;
    EstCpr = Tot_CosPro * 1;
    EstCul = Tot_CosUlt * 1;
    Write EstCliF;
  EndIf;

EndSr;

// ----------------------------------------------------------------
// Buscar el numero consecutivo del foliador
// ----------------------------------------------------------------
BegSr Foliador;

  Open FacFol;
  Chain %KList(Clave_Fol) FacFolF;
  If %Found(FacFol);
    FolDef += 1;
    Update FacFolF;
  Else;
    yDisCve = DisCve;
    yDtoTip = DtoTip;
    FolDef += 1;
    If DtoTip = 1 Or DtoTip > 3;
      FolDes = 'Numero secuencial de facturas   ';
    Else;
      FolDes = 'Numero sec. conduce de promocion';
    EndIf;
    Write FacFolF;
  EndIf;
  Close FacFol;

  DtoNro = FolDef * 1;
  NumDoc = FolDef * 1;
  TraNro = FolDef * 1;

EndSr;

// ----------------------------------------------------------------
// Aplicar la entrada de esta venta (compra automatica)
// ----------------------------------------------------------------
BegSr Aplicar_Compra;

  Producto = *Off;

  Close FacOrdh06;
  Close FacDem01;
  Close FacPar;

  CallP FA7052(Distrito : OrdNum : Producto);

  If Producto = *On;
    CallP FA7050(OrdNum : DisCve : TipDoc : NumDoc : PveArt);  // L099
  EndIf;

  Open FacOrdh06;
  Open FacDem01;
  Open FacPar;

  Chain(N) ParCve        FacParF;
  Chain    %KList(Clave_Ordh) FacOrdhF;
  Chain    %KList(Clave_Ordh) FacDemF;

EndSr;

// ----------------------------------------------------------------
// Verificar productos facturados por CIA3 (L099)
// ----------------------------------------------------------------
BegSr Verifica_Cia3;

  Factura_Cia3 = *Off;

  Close FacOrdh06;
  Close FacDem01;
  Close FacPar;

  CallP FA7054(Distrito : OrdNum : PveArt : Factura_Cia3);

  Open FacOrdh06;
  Open FacDem01;
  Open FacPar;

  Chain(N) ParCve        FacParF;
  Chain    %KList(Clave_Ordh) FacOrdhF;
  Chain    %KList(Clave_Ordh) FacDemF;

EndSr;

// ----------------------------------------------------------------
// Copiar conduce al archivo historico
// ----------------------------------------------------------------
BegSr CopiaConduce;

  SetLL %KList(Clave_Ordh) FacOrcdF;

  Dow Not %EOF(FacOrcd01);
    ReadE %KList(Clave_Ordh) FacOrcdF;
    If Not %EOF(FacOrcd01);
      Write  FacOrhdF;
      Delete FacOrcdF;
    EndIf;
  EndDo;

EndSr;

// ----------------------------------------------------------------
// Buscar Numero de NCF (L002)
// ----------------------------------------------------------------
BegSr Buscar_Ncf;

  Clear NumNcf;

  Chain(N) CliCve CxcAdcF;

  // L008 - Pre-Pagos usan tipo NCF 12 (Unico Ingreso)
  If TipDoc = 5;
    lTcfCve = 12;
  EndIf;

  Mcfcve = 01;
  CallP SG7011(Mcfcve      : DisCve      : lMonCve
             : lTcfCve     : NumNcf       : FechaFacIso
             : FechaFinNcf : TipProNcf    : StatusNcf);

EndSr;

// ----------------------------------------------------------------
// Buscar el costo en empresas que no manejan existencia (L003)
// ----------------------------------------------------------------
BegSr Buscar_Costo;

  Clear Costo;
  CallP FA7060(ArtCve : FecTra : Costo);

EndSr;

// ----------------------------------------------------------------
// Buscar precio de la semana de los productos regulados (L003)
// ----------------------------------------------------------------
BegSr Buscar_Precio;

  Clear Precio;

  // Pre-Pago o Credito externo: usar fecha de la orden
  If TipDoc = 5 Or TipDoc = 6;
    FechaPrecio = FecOrd;
  Else;
    FechaPrecio = FecTra;
  EndIf;

  CallP IV7004(ArtCve : FechaPrecio : Precio);

EndSr;

// ----------------------------------------------------------------
// Buscar el costo en empresas que manejan existencia (L001)
// ----------------------------------------------------------------
BegSr Buscar_Costo_E;

  Clear CostoPro;
  Clear CostoUlt;
  Clear Total_Can;

  CallP FA7061(ArtCve : FecAmd : CostoPro : CostoUlt : Total_Can);

EndSr;

// ----------------------------------------------------------------
// Buscar Parametros Generales del sistema
// ----------------------------------------------------------------
BegSr PrnGenerales;

  Clear ManejaExist;

  // Parametro 0051: Codigo trans. entrada inventario Automatica
  CodParametro = 0051;
  Exsr Parametros;
  ManejaExist = %SubSt(ValorAlf:1:1);

  // Parametro 0052: Compensacion activado (L007)
  Sistema      = 'FA';
  CodParametro = 0052;
  Exsr Parametros;
  Compen = ValorAlf;

  // Parametro 0053: Codigo Articulo Diesel Regular
  Sistema      = 'FA';
  CodParametro = 0053;
  Exsr Parametros;
  Cod001 = ValorAlf;

  // Parametro 0054: Codigo Articulo Diesel Regular Compensado
  Sistema      = 'FA';
  CodParametro = 0054;
  Exsr Parametros;
  Cod002 = ValorAlf;

  // Parametro 0055: Porciento descuento impuesto anticipo Gobierno (L004)
  Clear PorAnt;
  Clear Por_ImpAnt;
  Sistema      = 'FA';
  CodParametro = 0055;
  Exsr Parametros;
  PorAnt = ValorNum;
  Eval(Rh) Por_ImpAnt = PorAnt / 100;

  // Parametro 0062: Codigo Articulo Diesel Optimo Compensado (L007)
  Sistema      = 'FA';
  CodParametro = 0062;
  Exsr Parametros;
  Cod003 = ValorAlf;

EndSr;

// ----------------------------------------------------------------
// Llamar parametros del sistema (SG7009) (L001)
// ----------------------------------------------------------------
BegSr Parametros;

  CallP SG7009(Sistema : CodParametro : ValorNum : ValorAlf);

EndSr;

// ----------------------------------------------------------------
// Enviar el documento para crear el QR para la DGII (M001)
// ----------------------------------------------------------------
BegSr EnviarDGII;

  // Tipos de documento internos de la interfaz de Facturacion Electronica
  //   FACP = Factura de Productos
  //   FACS = Factura de Servicios
  //   NCRD = Nota de Credito por Devolucion
  //   NCRA = Nota de Credito Administrativa
  TipoDocInterno = 'FACP';

  CallP FE3003A(DisCve : TipDoc : DtoNro : TipoDocInterno);

EndSr;

// ----------------------------------------------------------------
// Actualizar el detalle de la planilla
// ----------------------------------------------------------------
BegSr Planillas;

  Exec Sql
    Update FacPlad
       Set PlaOri = 'F'
     Where (DisCve = :Distrito)
       And (OrdNro = :OrdNum)
       And (OrdAmd = :OrdFec)
       And (CliCve = :CliCve)
       And (PlaOri = 'P')
       And (PlaSta = 'A');

EndSr;

// ----------------------------------------------------------------
// Actualizar el detalle de la Transferencia
// ----------------------------------------------------------------
BegSr Transferencias;

  Exec Sql
    Update FacTddd
       Set TddOri = 'F'
     Where (DisCve = :Distrito)
       And (OrdNro = :OrdNum)
       And (OrdAmd = :OrdFec)
       And (CliCve = :CliCve)
       And (TddOri = 'P');

EndSr;

// ----------------------------------------------------------------
// Subrutina de inicializacion
// ----------------------------------------------------------------
BegSr *InzSr;

  // Buscar monto tope de ItePar (campo ParMti)
  Ip_ParMti = *Zeros;
  Exec Sql
    Select ParMti
      Into :Ip_ParMti
      From ItePar
     Where (ParCve = :ParCve)
    Fetch First 1 Rows Only;

  If SqlCod <> 0 And SqlCod <> 100;
    // Error leyendo ItePar — continua con cero
  EndIf;
  SqlCod = *Zeros;

  // Buscar RNC de la empresa en SegCia (campo CiaRnc)
  Sc_CiaRnc = *Blanks;
  Exec Sql
    Select CiaRnc
      Into :Sc_CiaRnc
      From SegCia
     Where (CiaCve = :NumCia)
    Fetch First 1 Rows Only;

  If SqlCod <> 0 And SqlCod <> 100;
    // Error leyendo SegCia — continua con blancos
  EndIf;
  SqlCod = *Zeros;

  CampoAlf = %Trim(Sc_CiaRnc);
  EliminarAlf(CampoAlf : StatusAlf);
  w_CiaRnc = %Trim(CampoAlf);

EndSr;
