     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA4001                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 21 / 07 / 2023                   *
      *  DESCR:                                                          *
      *                                                                  *
      *       Programa para Crear el Mensaje Json De Factura            *
      *  ================================================================*
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
     fFA4001PT  o    e             printer
      *
      * Tablas
     d TexP            s             15    dim(4) ctdata perrcd(1)
     d Texd            s             55    Dim(3) ctdata perrcd(1)
      *
      * Compos usados en el Programa
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
     d SecNcf          S             13    Inz(*Blanks)
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
      * Campos que Son Enviados Como Parametros
     d FechaFacIso     s                   Like(SqlSegFec.FecIso)
     d FechaFinNcf     s                   Like(SqlSegFec.FecIso)
     d TipProNcf       s              1    Inz('P')
     d StatusNcf       s               n   Inz(*Off)
     d StatusAlf       s               n   Inz(*Off)
      *
      * Parametros
     d Sistema         s              2    Inz('FA')
     d CodParam        s              4  0 inz(*Zeros)
     d ValorNum        s             30 15 Inz(*Zeros)
     d ValorAlf        s            100    Inz(*Blank)
     d Compen          s              1    Inz(*Blanks)
      *
    /Copy *Libl/Fuentesfa,FA4000        // Data Structure of PGM
      *
      **Archivos Externos
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
      * Eliminar digitos alfanumericos de un campo
     d EliminarAlf     Pr                  ExtPgm('SG7015')
     d  Campo_1                            Like(SqlCxcCli.CliTe1)
     d  Status_1                           Like(StatusAlf)
      *
      * Buscar Parametros
     d BuscaPrm        Pr                  ExtPgm('SG7009')
     d  Sistema_1                          Like(Sistema)
     d  CodParam_1                         Like(CodParam)
     d  ValorNum_1                         Like(ValorNum)
     d  ValorAlf_1                         Like(ValorAlf)
      *
      * Buscar Comprobantes
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
      **FA4001 Prototype
     d FA4001          Pr
     d  CodigoDis                          Like(SqlFacDtoh.DisCve)
     d  CodigoTip                          Like(SqlFacDtoh.DtoTip)
     d  NumeroDoc                          Like(SqlFacDtoh.DtoNro)
      *
      **FA4001 Program Interface
     d FA4001          Pi
     d  CodigoDis                          Like(SqlFacDtoh.DisCve)
     d  CodigoTip                          Like(SqlFacDtoh.DtoTip)
     d  NumeroDoc                          Like(SqlFacDtoh.DtoNro)
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
        Exsr Proceso     ;
        Exsr Ejecuta     ;
        Exsr EndProgram  ;
        // -----------------------------------------------------
        // Proceso Busca Informaciones de la factura           -
        // -----------------------------------------------------
        BegSr Proceso ;

            Chain (ParCve) FacParf ;
            Chain (ParCve) InvParf ;
            Chain (DisCve :DtoTip :DtoNro) FacDtohf  ;
            Chain (DisCve :DtoTip :DtoNro) FacDedf  ;
            Chain (CliCve) CxcClif ;
            Chain (CliCve) CxcAdcf ;
            Chain (CliCve) CxcDgcf ;
            Chain (CpaCve) CxcCpaf ;
            Chain (xZonCve) CxcZonf ;
            Chain (VenCve) CxcVenf ;
            Chain (DisCve) SegDisf ;
            Chain (CliCve :CclCve) CxcCclf  ;

       //Informacion de la Sucursal
           Sucursal = %Trim(DisDes)      ;

       //Informacion del Vendedor
           CodigoVendedor = %Trim(%Editc(VenCve:'X')) + ' ' +
                            %Trim(VenNom)    ;

       //Informacion de la Factura y el Pedido
           NumeroFacturaInterna = %Editc(DtoNro:'X')   ;
           NumeroPedidoInterno = %Editc(OrdNro:'X')    ;
           ZonaVenta = %Editc(xZonCve:'X')             ;
        // RutaVenta = %Editc(xZonCve:'X')             ;
           CodigoInternoComprador = %Editc(CliCve:'X')             ;

       //Verificar si el cliente esta autorizado en compensado
          If Compen = 'S'         ;
             Exsr Compensado      ;
           EndIf ;

           CveTcf = *Blanks  ;
           Len = %Scan(' ':NcfNro)  ;
           Select  ;
             When Len= *Zeros                   ;
                  CveTcf = %Subst(NcfNro:10:2)  ;
                  SecNcf = %Subst(NcfNro:12:8)  ;

             When Len = 12                      ;
                  CveTcf = %Subst(NcfNro:2:2)   ;
                  SecNcf = %Subst(NcfNro:4:8)  ;

             Other  ;
                  CveTcf = '00'                 ;
                  SecNcf = '00000000'           ;
            Endsl ;

           TcfCve = %Dec(CveTcf:2:0)               ;
           TipoeCF = %Dec(CveTcf:2:0)              ;
           NcfSec = %Dec(SecNcf:8:0)               ;
           eNcf = %Editc(NcfSec:'X')               ;

            Chain (TcfCve) SegTcff ;
               If Not %Found(SegTcf01)             ;
                  TcfDes = *Blanks ;
                Else  ;
                  TcfDes = %Trimr(TcfDes)          ;
                EndIf ;

           FechaFacIso = %Date(DtoFec:*Iso)        ;
           Exsr Buscar_Ncf                         ;
           FecFfp = %Dec(FechaFinNcf:*Eur)         ;
           FechaVencimientoSecuencia = %Editw(FecFfp:'  /  /    ') ;

       //Para Identificar los clientes del Gobierno
          If TcfCve = 15 Or TcfCve = 45         ;
             Gobierno = *On                     ;
           EndIf                                ;

           NumFac = DtoNro                      ;
           FecOrd = %Dec(%Date(OrdFec:*Iso):*Eur)   ;
           FecDoc = %Dec(%Date(DtoFec:*Iso):*Eur)   ;

       //Fecha de Emision
           FechaEmision = %Editw(FecDoc:'  /  /    ') ;

       //Fecha Order de Compra
           If FeoRco <> *Zeros   ;
              FerDcp = %Dec(%Date(FeoRco:*Iso):*Eur)        ;
              FechaOrdenCompra = %Editw(FerDcp:'  /  /    ') ;
              NumeroOrdenCompra = %Editc(OrdOrc:'X')    ;
            Else  ;
              FerDcp = *Zeros ;
            EndIf      ;

       //Fecha Limite de Pago
           FechaEur = %Date(DtoFec:*Iso)     ;
           FechaEur += %Days(aCpaDcr)        ;
           Fecha = %Dec(FechaEur)            ;
           FechaLimitePago = %Editw(Fecha:'  /  /    ') ;

       //Termino de Pago
           TerminoPago = %Trim(aCpaDes)     ;

       //Tipo de Pago
           If CpaCve < 3      ;
              DesPag = %Trim(TexP(1))       ;
              TipoPago = 1                  ;
              FechaLimitePago = *Blanks                    ;
            Else ;
              DesPag = %Trim(TexP(2))       ;
              TipoPago = 2                  ;
           Endif ;

       //Razon Social del Comprador
             RazonSocialComprador = %Trim(CliNom)     ;
             CorreoComprador = %Trim(X_CliEma)     ;

       //Contacto del Comprador
             If CclCve <> *Zeros                   ;
                ContactoComprador = %Trim(X_CclNom) + ', '  +
                                    %Trim(X_CclTel)   ;
             EndIf  ;

       //Para poner el Y/O en la impresion de la factura
          If X_DgcIyo = 'S'       ;
             NomCli = %Trim(CliNom) +
                      ' y/o ' + CliPno ;
           Else ;
             NomCli = %Trim(CliNom)    ;
          EndIf ;

       //Direccion y Ciudad
          Ciudad = %Trim(CliLoc) + ', ' + CliCiu  ;
          DireccionComprador = %Trim(Ciudad)      ;
       // MunicipioComprador = xxx                ;
       // ProvinciaComprador = xxx                ;
       // PaisComprador = xxx                     ;

       //Telefonos
          If CliTe2 <> *Blanks     ;
             Telefono = %Trim(CliTe1) + ' Otro: ' +
                        Clite2      ;
            Else ;
             Telefono = %Trim(CliTe1) ;
           EndIf ;

       //Poner a salir el RNC o Cedula en la factura
          Select;
            When (TcfTds = 'R' Or TcfTds = 'E') And CliIde = *Blanks ;
                 Ide = %Trim(X_CliRnc)           ;
                 CampoAlf = %Trim(Ide)  ;
                 EliminarAlf(CampoAlf :StatusAlf);
                 RNCComprador = %Dec(CampoAlf:11:0)   ;

            When TcfTds = 'C' And CliIde = *Blanks   ;
                 Ide = %Trim(X_CliCed)               ;
                 CampoAlf = %Trim(Ide)  ;
                 EliminarAlf(CampoAlf :StatusAlf);
                 RNCComprador = %Dec(CampoAlf:11:0)   ;

            When (TcfTds = 'R' Or TcfTds = 'E') And CliIde <> *Blanks  ;
                 Ide =  %Trim(CliIde)                ;
                 CampoAlf = %Trim(Ide)  ;
                 EliminarAlf(CampoAlf :StatusAlf);
                 RNCComprador = %Dec(CampoAlf:11:0)   ;

            When TcfTds = 'C' And CliIde <> *Blanks  ;
                 Ide = %Trim(CliIde)                 ;
                 CampoAlf = %Trim(Ide)  ;
                 EliminarAlf(CampoAlf :StatusAlf);
                 RNCComprador = %Dec(CampoAlf:11:0)   ;

            Other;
                 Ide = *Blanks     ;
          EndSl ;

       //Acumulados
          TotDes = *Zeros ;
          TotImp = *Zeros ;
          Sub_Tot = *Zeros ;

          Sub_Tot = DtoMbr * 1          ;
          TotDes = DtoMd1 + DtoMd2 ;
          TotImp = DtoMi1 + DtoMi2 ;

       //Totales
           MontoGravadoTotal = TotImp * 1   ;
           MontoGravadoI1 = DtoMi1 * 1      ;
           MontoGravadoI2 = DtoMi2 * 1      ;
           MontoGravadoI3 = *Zeros          ;
           MontoExento = DtoMbr - TotDes    ;
           MontoTotal = (DtoMbr - TotDes + TotImp)    ;

       //Otra Moneda Emcabezado
        // TipoMoneda = %Trim(MonSib)  ;
        // TipoCambio = 1.00           ;

       //Imprimir encabezados
          Contador = *Zeros   ;
          Write Titler        ;
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

       //Imprimir detalles
          Chain (ArtCve) InvArtf ;
          Descri = %Trim(ArtDes)    ;

       //Mover Margen del Detallista
          MarDet = DtoVd5 * 1         ;

          If DtoVd5 = *Zeros          ;
             Chain (ArtCve) InvDadf ;
             MarDet = J_ArtVmd * 1    ;
           EndIf  ;

       //Buscar Unidad del articulo
          Chain (DtoUde) InvUndf ;
            If %Found(InvUnd01) ;
               Unidad = %Trim(UndSig) ;
               UnidadMedida = UndCdg  ;
             Else ;
               Unidad = *Blanks  ;
               UnidadMedida = *Zeros  ;
            Endif ;

       //No imprimir Cantidad y Precio productos no manejan Existencia
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
          // Import = *Zeros ;

       //Producto Excento de Impuesto debe imprimir el * en Factura
          If ArtImp = 'N'   ;
           IndicadorFacturacion = 4  ;        // Excento
             *In25 = *On    ;
            Else ;
             *In25 = *Off   ;
           IndicadorFacturacion = 1  ;        // Itbis
           EndIf   ;

       //Para Incluir el itbis en el precio y el importe
          If tParPim = 'N'    ;
             Itbis = %Dech((DtoIm1 / DtoCan):12:2);
             Precio = DtoPve + Itbis  ;
             DtoImp += DtoIm1         ;
           Else ;
             Precio = DtoPve * 1      ;
             DtoImp += DtoIm1         ;
           EndIf  ;

          Contador += 1  ;

       //Imprime negrita los articulos con unidad despacho de unidad
          If DtoUde <> ArtUal         ;
             *In70 = *On              ;
           EndIf                      ;

       //Informaciones del Item
           NumeroLinea = DtoSec *  1  ;
           CodigoItem = %Trim(ArtCve) ;
           NombreItem = %Trim(ArtDes) ;
           IndicadorBienoServicio = 1  ;        // 1=Bien, 2=Servicio
           CantidadItem = DtoCan *  1  ;
           PrecioUnitarioItem = DtoPve *  1  ;

           DescuentoMonto = DtoMpd + DtoMsd ;
           TipoSubDescuento = %Trim('$')  ;
           MontoSubDescuento = DtoMpd *  1  ;

           MontoItem = DtoImp - (DtoMpd + DtoMsd)   ;

           Write detal ;
             *In70 = *Off             ;

          If Contador = 15  ;
             Write Continua          ;

             *In28 = *Off            ;
             Write Titler            ;
             Write Viene             ;
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

          Write Nomas  ;
          Write Total  ;

       //Para Imprimir el Mensaje del descuento
          If MsgCve <> *Zeros        ;
             Exsr Mensaje            ;
          EndIf ;

        EndSr               ;
        // -----------------------------------------------------
        // Imprimir el Mensaje en la Factura                   -
        // -----------------------------------------------------
        BegSr Mensaje       ;

         *In54 = *Off ;

          Setll (MsgCve) FacMsgdf  ;

            Dow True          ;
              Reade(n) (MsgCve) FacMsgdf    ;

             If Not %Eof()           ;

               If lMsgSec > 5       ;
                  Leave  ;
               Endif  ;

              If lMsgDde <> *Blanks   ;
                  MsgDde = %Trim(lMsgDde)   ;
                  Write Msg  ;
                Else ;
                 Iter  ;
               Endif  ;

             EndIf ;

          EndDo ;

       //Para Imprimir el Monto del descuento
          If Gobierno = *On       ;
             *In54 = *On          ;
             DdeMsg = *Blanks ;
             MsgDde1 = *Blanks ;

             DdeMsg = %Editc(MarDet:'1')    ;
             MsgDde1 = %Trim('Margen Semana') + ' ' +
                       %Trim('RD$' ) + ' ' + %Trim(DdeMsg)    ;

             MsgDde = %Trim(MsgDde1)         ;
             DdeMsg = *Blanks ;
             DdeMsg = %Editc(DtoVc1:'1')     ;
             MsgDde1 = %Trim(', Monto Descontar') + ' ' +
                       %Trim('RD$' ) + ' ' + %Trim(DdeMsg)    ;
             MsgDde = %Trim(MsgDde) + %Trim(MsgDde1)          ;
             Write Msg     ;
          Endif ;

        EndSr               ;
        // -----------------------------------------------------
        // Buscar Informaciones del Comprobante                -
        // -----------------------------------------------------
        BegSr Buscar_Ncf    ;

          NumNcf = NcfNro   ;
          McfCve = 01       ;

       //Llamar Programa Buscar Comprobantes
          BuscarComp(McfCve :DisCve :xMonCve :TcfCve :NumNcf :FechaFacIso
                     :FechaFinNcf :TipProNcf :StatusNcf)      ;

        EndSr               ;
        // -----------------------------------------------------
        // Verificar si el cliente tiene compensado            -
        // -----------------------------------------------------
        BegSr Compensado    ;

       //Determina si el Cliente esta como Compensado
            Cliente_Comp = *Off     ;

            Exec Sql
              Select '1'
                Into :Cliente_Comp
                From PelResd
               Where (CliCve = :CliCve)
               Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

       //Determina si esta factura tiene algun producto compensado
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

       //Compensacion Activado
           Sistema = 'FA'              ;
           CodParam = 0052             ;
           Exsr ParametrosPrn          ;
           Compen = %Trim(ValorAlf)    ;

       //Codigo Articulo Diesel Regular
           Sistema = 'FA'              ;
           CodParam = 0053             ;
           Exsr ParametrosPrn          ;
           Cod001 = %Trim(ValorAlf)    ;

       //Codigo Articulo Diesel Regular Compensado
           Sistema = 'FA'              ;
           CodParam = 0054             ;
           Exsr ParametrosPrn          ;
           Cod002 = %Trim(ValorAlf)    ;

       //Monto Descuento x Galon Subsidiado
           Sistema = 'FA'              ;
           CodParam = 0061             ;
           Exsr ParametrosPrn          ;
           MonDesSub= ValorNum * 1     ;

       //Codigo Articulo Diesel Optimo Compensado
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

       //Buscar Informaciones de la Emperesa (Rnc)
           Chain (NumCia) SegCiaf ;

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

       //Tipo de Ingresos
           TipoIngresos = 01 ;

        EndSr;
        // -----------------------------------------------------
**  Tabla tipos de ventas
Contado
Credito
Promocion

**  Tabla Texto Descuentos
                                 Menos Descuento:
Descuento
/GLS por cobrar al MIC/INTRANT:
