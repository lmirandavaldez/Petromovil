      //===================================================================*/
      // Program Name: FE8001                                              */
      //  Application: Facturacion Electronica                             */
      //  Description: Retrieves an invoice for products.                  */
      //      Authors: Luis J. Miranda V. (original version for Meyker)    */
      //               Francisco Solano - fsolano@dominisoft.com.do        */
      //               DominiSoft FSM Technology & Services SRL. Based on  */
      //               FA5013 by Luis J. Miranda V.                        */
      //               (adaptations for Facturacion Electronica marked     */
      //               with M001).                                         */
      //         Date: December 2023                                       */
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
      // M002  03-MAR-2025  F. Solano        Fix calculation of MontoItem: */
      //                                     Before this fix, it was being */
      // calculated as MontoItem = item amount - (discount + tax), which is*/
      // wrong for Petromovil's product invoicing.                         */
      //                                                                   */
      // M003  13-MAR-2025  F. Solano        Fix IndicadorFacturacion: it  */
      //                                     should take into account the  */
      // the customer's exempt flag, not only the item's taxed flag.       */
      //                                                                   */
      // M004  15-APR-2025  F. Solano        Changed logic to obtain the   */
      //                                     item's tax category (indicador*/
      // facturacion) for invoices with ECF type 46 (export).              */
      //===================================================================*/

     h Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
     h exprOpts(*alwBlankNum) actGrp('FAELAPP') bndDir('FAELAPP')

     fFacDtoh01 If   e           k disk
     fFacDtod01 If   e           k disk
     fFacDtoda01If   e           k disk    Prefix(q)
     fFacDed01  If   e           k disk
     fCxcCli01  If   e           k disk    Prefix(X_)
     fCxcCcl01  If   e           k disk    Prefix(X_)
     fCxcDgc01  If   e           k disk    Prefix(X_)
     fCxcAdc01  If   e           k disk    prefix(x)
     fCxcCpa01  If   e           k disk    Prefix(a)
     fInvArt01  If   e           k disk
     fInvDad01  If   e           k disk    Prefix(J_)
     fCxcVen01  If   e           k disk
     fCxcZon01  If   e           k disk    prefix(x)
     fInvUnd01  If   e           k disk
     fSegTcf01  If   e           k disk
     fSegCia01  If   e           k disk
     fSegDis01  If   e           k disk
     fFacPar    If   e           k disk
     fInvPar    If   e           k disk    prefix(t)
     fFacMsgd01 If   e           k disk    Prefix(l)
     fPelRes02jnIf   e           k disk    PreFix(z)
M001 fFE8001PT  o    e             printer usropn
      *
M001  /define STANDARD
M001  /define UTILITY
M001  /define TEXT_FOR_MESSAGES
M001  /define SERVICE
M001  /define APPLICATION_MESSAGES
M001  /include FUENTESFE,PROTOTYPES

      * Tablas
     d TexP            s             15    dim(4) ctdata perrcd(1)
     d Texd            s             55    Dim(3) ctdata perrcd(1)
      *
      * Compos usados en el Programa
     d Contador        s              2  0 Inz(*Zeros)
     d MarDet          s              7  2 Inz(*Zeros)
     d Parcve          s              1    inz('@')
     d Origen          s              1  0 Inz(*Zeros)
     d FechaEur        s               d   Datfmt(*Eur)
     d FechaIso        s               d   Datfmt(*Iso)
     d Fecha           s              8  0 Inz(*Zeros)
     d Len             s              3  0 Inz(*Zeros)
     d Log             s              3  0 Inz(*Zeros)
     d DdeMsg          s             20    Inz(*Blanks)
     d CampoAlf        s             20    Inz(*Blanks)
     d MsgDde1         s             60    Inz(*Blanks)
      *
     d CveTcf          S              2    Inz(*Blanks)
M001 d SecNcf          S             16    Inz(*Blanks)
     d NcfSec          s             13  0 Inz(*Zeros)
     d TcfCve          s                   Like(SqlSegNcf.TcfCve)
     d NumNcf          s                   Like(SqlFacDed.NcfNro) Inz(*Blanks)
     d McfCve          S                   Like(SqlSegNcf.McfCve)
      *
     d NumDis          s                   Like(SqlFacDtoh.DisCve) Inz(*Zeros)
     d TipDoc          s                   Like(SqlFacDtoh.DtoTip) Inz(*Zeros)
     d NumDoc          s                   Like(SqlFacDtoh.DtoNro) Inz(*Zeros)
     d Itbis           s                   Like(SqlFacDtoh.DtoMi1) Inz(*Zeros)
     d TotImp          s                   Like(SqlFacDtoh.DtoMne) Inz(*Zeros)
     d TotDes          s                   Like(SqlFacDtoh.DtoMne) Inz(*Zeros)
     d Sub_Tot         s                   Like(SqlFacDtoh.DtoMne) Inz(*Zeros)
     d Tot_Net         s                   Like(SqlFacDtoh.DtoMne) Inz(*Zeros)
     d Precio          s                   Like(SqlFacDtod.DtoPve) Inz(*Zeros)
      *
     d Cod001          s                   Like(SqlFacDtod.ArtCve) Inz(*Blanks)
     d Cod002          s                   Like(SqlFacDtod.ArtCve) Inz(*Blanks)
     d Cod003          s                   Like(SqlFacDtod.ArtCve) Inz(*Blanks)
     d MonDesSub       s             12  2 Inz(*Zeros)
      *
     d Gobierno        S               n
     d Cliente_Comp    s               n
     d Produc_Comp     s               n
      *
      * Campos que Son Enviados Como Parametros
     d FechaFacIso     s                   Like(SqlSegFec.FecIso)
     d FechaFinNcf     s                   Like(SqlSegFec.FecIso)
     d TipProNcf       s              1    Inz('P')
     d StatusNcf       s               n   Inz(*Off)
     d StatusAlf       s               n   Inz(*Off)
      *
      * Parametros
     d Sistema         s              2    Inz('FA')
     d CodParam        s              4  0 inz(*Zeros)
     d ValorNum        s             30 15 Inz(*Zeros)
     d ValorAlf        s            100    Inz(*Blank)
     d Compen          s              1    Inz(*Blanks)
      *
      /Copy *LIBL/FUENTESFE,FE800000
      *
      **Archivos Externos
     d SqlFacDtoh    e Ds                  ExtName(FacDtoh) Qualified
     d SqlFacDtod    e Ds                  ExtName(FacDtod) Qualified
     d SqlFacDed     e Ds                  ExtName(FacDed) Qualified
     d SqlCxcCli     e Ds                  ExtName(CxcCli) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
     d SqlSegNcf     e Ds                  ExtName(SegNcf) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Estructura de datos interfaz con Facturacion Electronica:
M001  /include FUENTESFE,STDFORMATS

      * Eliminar digitos alfanumericos de un campo
     d EliminarAlf     Pr                  ExtPgm('SG7015')
     d  Campo_1                            Like(SqlCxcCli.CliTe1)
     d  Status_1                           Like(StatusAlf)
      *
      * Buscar Parametros
     d BuscaPrm        Pr                  ExtPgm('SG7009')
     d  Sistema_1                          Like(Sistema)
     d  CodParam_1                         Like(CodParam)
     d  ValorNum_1                         Like(ValorNum)
     d  ValorAlf_1                         Like(ValorAlf)
      *
      * Buscar Comprobantes
     d BuscarComp      Pr                  ExtPgm('SG7011')
     d  McfCve_1                           Like(SqlSegNcf.McfCve)
     d  DisCve_1                           Like(SqlSegNcf.DisCve)
     d  MonCve_1                           Like(SqlSegNcf.MonCve)
     d  TcfCve_1                           Like(SqlSegNcf.TcfCve)
     d  NunNcf_1                           Like(SqlFacDed.NcfNro)
     d  FechaFacIso_1                      Like(SqlSegFec.FecIso)
     d  FechaFinNcf_1                      Like(SqlSegFec.FecIso)
     d  TipProNcf_1                        Like(TipProNcf)
     d  StatusNcf_1                        Like(StatusNcf)
      *
      **FE8001 Prototype
     d FE8001          Pr
     d  CodigoDis                          Like(SqlFacDtoh.DisCve)
     d  CodigoTip                          Like(SqlFacDtoh.DtoTip)
     d  NumeroDoc                          Like(SqlFacDtoh.DtoNro)
M001 d  documento                          likeds(
M001 d                                     TIPO_DOCUMENTO_ELECTRONICO_V10)
M001 d  isOK                           N
      *
      **FE8001 Program Interface
     d FE8001          Pi
     d  CodigoDis                          Like(SqlFacDtoh.DisCve)
     d  CodigoTip                          Like(SqlFacDtoh.DtoTip)
     d  NumeroDoc                          Like(SqlFacDtoh.DtoNro)
M001 d  documento                          likeds(
M001 d                                     TIPO_DOCUMENTO_ELECTRONICO_V10)
M001 d  isOK                           N

      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
M001    monitor ;
          Exsr Proceso     ;
          Exsr Ejecuta     ;
          Exsr EndProgram  ;
M001    on-error ;
M001     snd-msg ut_build_text_for_program_error_message(
M001       MsgPgm
M001     : %status()
M001     : ErrMsgId
M001     : ErrMsg) ;
M001     Exsr EndProgram  ;
M001    endmon;

        // -----------------------------------------------------
        // Proceso Busca Informaciones de la factura           -
        // -----------------------------------------------------
        BegSr Proceso ;

M001        if *off;
M001          open FE8001PT ;
M001        endif;

            Chain (ParCve) FacParf ;
            Chain (ParCve) InvParf ;
            Chain (DisCve :DtoTip :DtoNro) FacDtohf  ;
            isOK = %found(FacDtoh01) ;
            Chain (DisCve :DtoTip :DtoNro) FacDedf  ;
            Chain (CliCve) CxcClif ;
            Chain (CliCve) CxcAdcf ;
            Chain (CliCve) CxcDgcf ;
            Chain (CpaCve) CxcCpaf ;
            Chain (xZonCve) CxcZonf ;
            Chain (VenCve) CxcVenf ;
            Chain (DisCve) SegDisf ;
            Chain (CliCve :CclCve) CxcCclf  ;

       //Informacion de la Sucursal
           Sucursal = %Trim(DisDes)      ;

       //Informacion del Vendedor
           CodigoVendedor = %Trim(%Editc(VenCve:'X')) + ' ' +
                            %Trim(VenNom)    ;

       //Informacion de la Factura y el Pedido
           NumeroFacturaInterna = %Editc(DtoNro:'X')   ;
           NumeroPedidoInterno = %Editc(OrdNro:'X')    ;
           ZonaVenta = %Editc(xZonCve:'X')             ;
        // RutaVenta = %Editc(xZonCve:'X')             ;
           CodigoInternoComprador = %Editc(CliCve:'X')             ;

       //Verificar si el cliente esta autorizado en compensado
          If Compen = 'S'         ;
             Exsr Compensado      ;
           EndIf ;

           CveTcf = *Blanks  ;
M001       CveTcf = %Subst(NcfNro:2:2)  ;
M001       SecNcf = %Subst(NcfNro:4)    ;
           TcfCve = %Dec(CveTcf:2:0)    ;
           TipoeCF = %Dec(CveTcf:2:0)   ;
M001       NcfSec = %Dec(SecNcf:10:0)               ;
M001       eNcf = NcfNro ;

            Chain (TcfCve) SegTcff ;
               If Not %Found(SegTcf01)             ;
                  TcfDes = *Blanks ;
                Else  ;
                  TcfDes = %Trimr(TcfDes)          ;
                EndIf ;

           FechaFacIso = %Date(DtoFec:*Iso)        ;
           Exsr Buscar_Ncf                         ;
           FecFfp = %Dec(FechaFinNcf:*Eur)         ;
M001       FechaVencimientoSecuencia = FechaFinNcf ;

       //Para Identificar los clientes del Gobierno
          If TcfCve = 15 Or TcfCve = 45         ;
             Gobierno = *On                     ;
           EndIf                                ;

           NumFac = DtoNro                      ;
           FecOrd = %Dec(%Date(OrdFec:*Iso):*Eur)   ;
           FecDoc = %Dec(%Date(DtoFec:*Iso):*Eur)   ;

       //Fecha de Emision
M001       FechaEmision = %Date(DtoFec:*Iso) ;
M001       HoraEmision = %Time(APLHOR:*Iso) ;

       //Fecha Order de Compra
           If FeoRco <> *Zeros   ;
              FerDcp = %Dec(%Date(FeoRco:*Iso):*Eur)        ;
              FechaOrdenCompra = %Editw(FerDcp:'  /  /    ') ;
              NumeroOrdenCompra = %Editc(OrdOrc:'X')    ;
            Else  ;
              FerDcp = *Zeros ;
            EndIf      ;

       //Fecha Limite de Pago
           FechaEur = %Date(DtoFec:*Iso)     ;
           FechaEur += %Days(aCpaDcr)        ;
           Fecha = %Dec(FechaEur)            ;
M001       FechaLimitePago = FechaEur ;

       //Termino de Pago
           TerminoPago = %Trim(aCpaDes)     ;

       //Tipo de Pago
           If CpaCve < 3      ;
              DesPag = %Trim(TexP(1))       ;
            Else ;
              DesPag = %Trim(TexP(2))       ;
           Endif ;
M001       TipoPago = sv_dgii_get_payment_type(CpaCve) ;

       //Razon Social del Comprador
             RazonSocialComprador = %Trim(CliNom)     ;
             CorreoComprador = %Trim(X_CliEma)     ;

       //Contacto del Comprador
             If CclCve <> *Zeros                   ;
                ContactoComprador = %Trim(X_CclNom) + ', '  +
                                    %Trim(X_CclTel)   ;
             EndIf  ;

       //Para poner el Y/O en la impresion de la factura
          If X_DgcIyo = 'S'       ;
             NomCli = %Trim(CliNom) +
                      ' y/o ' + CliPno ;
           Else ;
             NomCli = %Trim(CliNom)    ;
          EndIf ;

       //Direccion y Ciudad
          Ciudad = %Trim(CliLoc) + ', ' + CliCiu  ;
          DireccionComprador = %Trim(Ciudad)      ;

       //Telefonos
          If CliTe2 <> *Blanks     ;
             Telefono = %Trim(CliTe1) + ' Otro: ' +
                        Clite2      ;
            Else ;
             Telefono = %Trim(CliTe1) ;
           EndIf ;

       //Poner a salir el RNC o Cedula en la factura
          Ide = %Trim(X_CliRnc)           ;
          CampoAlf = %Trim(Ide)  ;
          EliminarAlf(CampoAlf :StatusAlf);
          RNCComprador = %trimr(Ide) ;

        //  Select;
        //    When (TcfTds = 'R' Or TcfTds = 'E') And CliIde = *Blanks ;
        //         Ide = %Trim(X_CliRnc)           ;
        //         CampoAlf = %Trim(Ide)  ;
        //         EliminarAlf(CampoAlf :StatusAlf);
        //         RNCComprador = %trimr(Ide) ;

        //    When TcfTds = 'C' And CliIde = *Blanks   ;
        //         Ide = %Trim(X_CliCed)               ;
        //         CampoAlf = %Trim(Ide)  ;
        //         EliminarAlf(CampoAlf :StatusAlf);
        //         RNCComprador = %trimr(Ide) ;

        //    When (TcfTds = 'R' Or TcfTds = 'E') And CliIde <> *Blanks  ;
        //         Ide =  %Trim(CliIde)                ;
        //         CampoAlf = %Trim(Ide)  ;
        //         EliminarAlf(CampoAlf :StatusAlf);
        //         RNCComprador = %trimr(Ide) ;

        //    When TcfTds = 'C' And CliIde <> *Blanks  ;
        //         Ide = %Trim(CliIde)                 ;
        //         CampoAlf = %Trim(Ide)  ;
        //         EliminarAlf(CampoAlf :StatusAlf);
        //         RNCComprador = %trimr(Ide) ;

        //    Other;
        //         Ide = *Blanks     ;
        //  EndSl ;

       //Acumulados
          TotDes = *Zeros ;
          TotImp = *Zeros ;
          Sub_Tot = *Zeros ;

          Sub_Tot = DtoMbr * 1 ;
          TotDes = DtoMd1 + DtoMd2 ;
          TotImp = DtoMi1 + DtoMi2 ;

       //Totales
M004       asignarTotales(TipoEcf) ;
M001       IndicadorMontoGravado = INDICADOR_MONTO_GRAVADO_ITBIS_NO_INCLUIDO ;

       //Imprimir encabezados
          Contador = *Zeros   ;
M001      if *off;
            Write Titler        ;
M001      endif ;
M001      llenarEncabezadoInterfazFacturacionElectronica();
          *In99 = *On         ;

        EndSr               ;
        // -----------------------------------------------------
        // Ejecucion del programa                              -
        // -----------------------------------------------------
       BegSr Ejecuta  ;

         *In22 = *Off ;
        Setll (DisCve :DtoTip :DtoNro) FacDtodf  ;

           Dow Not *In22 ;
            Reade(n) (DisCve :DtoTip :DtoNro) FacDtodf    ;

            If Not %Eof(FacDtod01)  ;
               Exsr Factura_Detalle ;
             Else ;
              *In22 = *On  ;
             EndIf ;

           EndDo ;

            Exsr Factura_Totales  ;

        EndSr               ;
        // -----------------------------------------------------
        // Imprimir el detalle del documento                   -
        // -----------------------------------------------------
        BegSr Factura_Detalle ;

             MonDesSub = *Zeros                     ;

            Chain (DisCve :DtoTip :DtoNro :DtoSec) FacDtodaf ;
            If %Found(FacDtoda01)       ;

             If qResNro <> *HiVal         ;
               Chain (CliCve :qResNro :ArtCve) PelResdf  ;
              If %Found(PelRes02jn)                     ;
                 MonDesSub = zResMds * 1                ;
               Else ;
                 MonDesSub = *Zeros                     ;
               EndIf ;

             EndIf ;
            EndIf ;

           MarDet = *Zeros ;

       //Imprimir detalles
          Chain (ArtCve) InvArtf ;
          Descri = %Trim(ArtDes)    ;

       //Mover Margen del Detallista
          MarDet = DtoVd5 * 1         ;

          If DtoVd5 = *Zeros          ;
             Chain (ArtCve) InvDadf ;
             MarDet = J_ArtVmd * 1    ;
           EndIf  ;

       //Buscar Unidad del articulo
          Chain (DtoUde) InvUndf ;
            If %Found(InvUnd01) ;
               Unidad = %Trim(UndSig) ;
               UnidadMedida = UndCdg  ;
             Else ;
               Unidad = *Blanks  ;
               UnidadMedida = *Zeros  ;
            Endif ;
M001        if UnidadMedida = 0 ;
M001          UnidadMedida = UNIDAD_MEDIDA_UNIDAD_UND ; // se asigna como defaul
M001        endif;

       //No imprimir Cantidad y Precio productos no manejan Existencia
          Select  ;
            When ArtMce = 'S'            ;
                 Canti2 = DtoCan * 1  ;

            When ArtMce = 'N' And DtoCan > 1.00    ;
                 Canti2 = DtoCan * 1  ;

            When ArtMce = 'N' And DtoCan = 1.00    ;
                 Canti2 = *Zeros ;
                 DtoPve = *Zeros ;
          EndSl ;

          Itbis = *Zeros ;
          Precio = *Zeros ;

       //Producto Excento de Impuesto debe imprimir el * en Factura
          If ArtImp = 'N'   ;
            *In25 = *On    ;
          Else ;
            *In25 = *Off   ;
          EndIf   ;

M003      IndicadorFacturacion = obtenerIndicadorFacturacion( X_CLIEXE
M004                                                        : ArtImp
M004                                                        : TipoeCF ) ;

       //Para Incluir el itbis en el precio y el importe
          If tParPim = 'N'    ;
             Itbis = %Dech((DtoIm1 / DtoCan):12:2);
             Precio = DtoPve + Itbis  ;
             DtoImp += DtoIm1         ;
           Else ;
             Precio = DtoPve * 1      ;
             DtoImp += DtoIm1         ;
           EndIf  ;

          Contador += 1  ;

       //Imprime negrita los articulos con unidad despacho de unidad
          If DtoUde <> ArtUal         ;
             *In70 = *On              ;
           EndIf                      ;

       //Informaciones del Item
           NumeroLinea = DtoSec *  1  ;
           CodigoItem = %Trim(ArtCve) ;
           NombreItem = %Trim(ArtDes) ;
           IndicadorBienoServicio = 1  ;        // 1=Bien, 2=Servicio
           CantidadItem = DtoCan *  1  ;
           PrecioUnitarioItem = DtoPve *  1  ;

           DescuentoMonto = DtoMpd + DtoMsd ;
           TipoSubDescuento = %Trim('$')  ;
           MontoSubDescuento = DtoMpd *  1  ;

M002       MontoItem = DtoImp ;

M001       if *off;
             Write detal ;
M001       endif ;
M001       sv_adjust_item_attributes_for_DGII_rules( CantidadItem
M001                                               : PrecioUnitarioItem
M001                                               : MontoItem ) ;
M001       agregarItemInterfazFacturacionElectronica() ;
           *In70 = *Off             ;

          If Contador = 15  ;

M001         if *off ;
               Write Continua          ;
M001         endif ;

             *In28 = *Off            ;
M001         if *off ;
               Write Titler            ;
               Write Viene             ;
M001         endif ;
             Contador = *Zeros       ;
           EndIf  ;
        EndSr               ;
        // -----------------------------------------------------
        // Imprimir factura Totales                            -
        // -----------------------------------------------------
        BegSr Factura_Totales ;

          TexDes = *Blanks ;

          If Produc_Comp = *On                     ;
             TexDes = %Trim(Texd(2)) + ' ' + 'RD$' +
                      %Trim(%Editc(MonDesSub:'1')) + %Trim(Texd(3))    ;
             *In75 = *On    ;
           Else ;
             TexDes = %Trimr(Texd(1)) ;
             *In75 = *Off   ;
          EndIf ;

          *In28 = *On  ;
          Tot_Net = DtoMne * 1 ;

M001      if *off ;
            Write Nomas  ;
            Write Total  ;
M001      endif ;
M001      llenarTotalesInterfazFacturacionElectronica() ;
M001      if TotDes > 0 ;
M001        llenarDescuentoGlobalInterfazFacturacionElectronica(TotDes) ;
M001      endif;

        EndSr               ;
        // -----------------------------------------------------
        // Buscar Informaciones del Comprobante                -
        // -----------------------------------------------------
        BegSr Buscar_Ncf    ;

          NumNcf = NcfNro   ;
          McfCve = 01       ;

       //Llamar Programa Buscar Comprobantes
          BuscarComp(McfCve :DisCve :xMonCve :TcfCve :NumNcf :FechaFacIso
                     :FechaFinNcf :TipProNcf :StatusNcf)      ;

        EndSr               ;
        // -----------------------------------------------------
        // Verificar si el cliente tiene compensado            -
        // -----------------------------------------------------
        BegSr Compensado    ;

       //Determina si el Cliente esta como Compensado
            Cliente_Comp = *Off     ;

            Exec Sql
              Select '1'
                Into :Cliente_Comp
                From PelResd
               Where (CliCve = :CliCve)
               Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

       //Determina si esta factura tiene algun producto compensado
            Produc_Comp = *Off             ;

            Exec Sql
              Select '1'
                Into :Produc_Comp
                From FacDtod
               Where (DisCve = :DisCve)
                 And (DtoTip = :DtoTip)
                 And (DtoNro = :DtoNro)
                 And ((ArtCve = :Cod002 Or ArtCve = :Cod003))
               Fetch First 1 Rows Only      ;

          SqlCod = *Zeros ;

        EndSr;
        //------------------------------------------------------
        // Para Buscar Parametros Generales                    -
        //------------------------------------------------------
        BegSr PrnGenerales  ;

       //Compensacion Activado
           Sistema = 'FA'              ;
           CodParam = 0052             ;
           Exsr ParametrosPrn          ;
           Compen = %Trim(ValorAlf)    ;

       //Codigo Articulo Diesel Regular
           Sistema = 'FA'              ;
           CodParam = 0053             ;
           Exsr ParametrosPrn          ;
           Cod001 = %Trim(ValorAlf)    ;

       //Codigo Articulo Diesel Regular Compensado
           Sistema = 'FA'              ;
           CodParam = 0054             ;
           Exsr ParametrosPrn          ;
           Cod002 = %Trim(ValorAlf)    ;

       //Monto Descuento x Galon Subsidiado
           Sistema = 'FA'              ;
           CodParam = 0061             ;
           Exsr ParametrosPrn          ;
           MonDesSub= ValorNum * 1     ;

       //Codigo Articulo Diesel Optimo Compensado
           Sistema = 'FA'              ;
           CodParam = 0062             ;
           Exsr ParametrosPrn          ;
           Cod003 = %Trim(ValorAlf)    ;

        EndSr;
        //------------------------------------------------------
        // Parametros del sistema                              -
        //------------------------------------------------------
        BegSr ParametrosPrn          ;

          BuscaPrm(Sistema :CodParam :ValorNum :ValorAlf);

        EndSr;
        //------------------------------------------------------
        // End Program Subroutine                              -
        //------------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
        BegSr *Inzsr;

           clear documento ;
           DisCve = CodigoDis                       ;
           DtoTip = CodigoTip                       ;
           DtoNro = NumeroDoc                       ;
           Origen = 1                               ;

        // Si el origen es 1 = impresion normal y es 2 es una re-impresion
           If Origen = 1               ;
              *In59 = *Off             ;
            Else ;
              *In59 = *On              ;
            EndIf  ;

         Exsr PrnGenerales          ;

       //Buscar Informaciones de la Emperesa (Rnc)
           Chain (NumCia) SegCiaf ;
M001       if %found(SegCia01) ;
             CampoAlf = %Trim(CiaRnc)  ;
             EliminarAlf(CampoAlf :StatusAlf);
             RncEmisor = %Dec(CampoAlf:11:0)   ;
             RazonSocialEmisor = %Trim(CiaNom)   ;
             NombreComercial = %Trim(CiaGir)   ;
             DireccionEmisor = %Trim(CiaCal) + ', ' +
                               %Trim(CiaSec) + ', ' +
                               %Trim(CiaCiu)         ;
             CorreoEmisor = %Trim(CiaDem)           ;
             WebSite = %Trim(CiaDin)           ;
M001       endif;

       //Tipo de Ingresos
           TipoIngresos = TIPO_INGRESOS_POR_OPERACIONES ;

        EndSr;
        // -----------------------------------------------------
        //                SUB - PROCEDIMIENTOS
        // -----------------------------------------------------
      // -----------------------------------------------------
M003 p obtenerIndicadorFacturacion...
M003 p                 b
M003 d *n              pi                  like(IndicadorFacturacion)
M003 d  flagClienteExentoDeImpuestos...
M003 d                                     like(X_CLIEXE) const
M003 d  flagProductoPagaImpuestos...
M003 d                                     like(ArtImp) const
M004 d  tipoComprobante...
M004 d                                     like(TipoeCF) const
M003
M003   select ;
M004     when tipoComprobante = TIPO_ECF_COMPROBANTE_EXPORTACIONES_ELECTRONICO ;
M004       return INDICADOR_FACTURACION_ITBIS3_CERO_PORCIENTO ;
M003     when flagClienteExentoDeImpuestos = CLIENTE_EXENTO_DE_IMPUESTOS_SI ;
M003       return INDICADOR_FACTURACION_EXENTO ;
M003     when flagProductoPagaImpuestos = PRODUCTO_PAGA_IMPUESTOS_NO ;
M003       return INDICADOR_FACTURACION_EXENTO ;
M003     other ;
M003       return INDICADOR_FACTURACION_ITBIS1_18_PORCIENTO ;
M003   endsl;
M003 p                 e
      // -----------------------------------------------------
M004 p asignarTotales  b
M004 d *n              pi
M004 d  tipoComprobante...
M004 d                                     like(TipoeCF) const

M004   if tipoComprobante = TIPO_ECF_COMPROBANTE_EXPORTACIONES_ELECTRONICO ;
M004     MontoGravadoI1 = 0 ;
M004     MontoGravadoI2 = 0 ;
M004     MontoGravadoI3 = DtoMbr - TotDes ;
M001     MontoExento    = 0 ;
M004   else ;
M004     MontoGravadoI1 = DtoMi1 * 1      ;
M004     MontoGravadoI2 = DtoMi2 * 1      ;
M004     MontoGravadoI3 = *Zeros          ;
M004     MontoExento    = DtoMbr - TotDes ;
M004   endif ;

M004   MontoGravadoTotal = MontoGravadoI1 + MontoGravadoI2 + MontoGravadoI3 ;
M004   MontoTotal = (DtoMbr - TotDes + TotImp) ;
M004 p                 e
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
M001   documento.encabezado.idDoc.tipoIngresos = TipoIngresos ;
M001   documento.encabezado.idDoc.tipoPago = TipoPago ;
M001   documento.encabezado.idDoc.fechaLimitePago = FechaLimitePago ;

M001   // emisor
M001   documento.encabezado.emisor.rncEmisor = RncEmisor ;
M001   documento.encabezado.emisor.razonSocialEmisor =
M001    %trimr(RazonSocialEmisor);
M001   documento.encabezado.emisor.nombreComercial = %trimr(NombreComercial) ;
M001   documento.encabezado.emisor.sucursal = %trimr(Sucursal) ;
M001    documento.encabezado.emisor.direccionEmisor = %trimr(DireccionEmisor) ;
M001   documento.encabezado.emisor.codigoVendedor = %trimr(CodigoVendedor) ;
M001   documento.encabezado.emisor.numeroFacturaInterna =
M001     %trimr(NumeroFacturaInterna) ;
M001   documento.encabezado.emisor.fechaEmision = FechaEmision + HoraEmision ;

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
M001 p llenarDescuentoGlobalInterfazFacturacionElectronica...
M001 p                 b
M001 d *n              pi
M001 d  descuentoTotal...
M001 d                                     like(TotDes) const

M001   documento.descuentosORecargos.cantidadDescuentosORecargos += 1 ;

M001   documento.descuentosORecargos.descuentosORecargo(
M001     documento.descuentosORecargos.cantidadDescuentosORecargos).
M001       tipoAjuste = TIPO_AJUSTE_DESCUENTO ;

M001   documento.descuentosORecargos.descuentosORecargo(
M001      documento.descuentosORecargos.cantidadDescuentosORecargos).
M001        tipoValor = TIPO_VALOR_DESCUENTO_O_RECARGO_MONTO ;

M001   documento.descuentosORecargos.descuentosORecargo(
M001      documento.descuentosORecargos.cantidadDescuentosORecargos).
M001        montoDescuentoORecargo = descuentoTotal ;

M001   documento.descuentosORecargos.descuentosORecargo(
M001      documento.descuentosORecargos.cantidadDescuentosORecargos).
M001        indicadorFacturacionDescuentoORecargo =
M001        obtenerIndicadorFacturacionParaDescuentoGlobal() ;

M001   return ;
M001 p                 e
        // -----------------------------------------------------
M001 p obtenerIndicadorFacturacionParaDescuentoGlobal...
M001 p                 b
M001 d *n              pi                  like(IndicadorFacturacion)
M004   select ;
M004     when documento.encabezado.idDoc.tipoECF =
M004       TIPO_ECF_COMPROBANTE_EXPORTACIONES_ELECTRONICO ;
M004       return INDICADOR_FACTURACION_DESCUENTO_O_RECARGO_AFECTA_ITBIS3 ;
M004     when documento.encabezado.totales.montoGravado1 > 0 ;
M001       return INDICADOR_FACTURACION_DESCUENTO_O_RECARGO_AFECTA_ITBIS1 ;
M004     other;
M001       return INDICADOR_FACTURACION_DESCUENTO_O_RECARGO_AFECTA_EXENTO ;
M004   endsl;
M001 p                 e
        // -----------------------------------------------------
**  Tabla tipos de ventas
Contado
Credito
Promocion

**  Tabla Texto Descuentos
                                 Menos Descuento:
Descuento
/GLS por cobrar al MIC/INTRANT:
