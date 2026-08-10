     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FS4001                           *
      *  APLICACION...................: Facturación de servicios         *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 30 / 07 / 2023                   *
      *  DESCR:                                                          *
      *     Programa para Crear el Mensaje Json Factura de Servicios    *
      *  ================================================================*
     fFpsFach01 If   e           k disk
     fFpsFacd01 If   e           k disk
     fFpsComh   If   e           k disk
     fFpsSer01  If   e           k disk
     fCxcCli01  If   e           k disk
     fCxcAdc01  If   e           k disk    Prefix(J)
     fCxcDgc01  If   e           k disk    Prefix(X_)
     fCxcVen01  If   e           k disk
     fCxcZon01  If   e           k disk    prefix(x)
     fSegDis01  If   e           k disk
     fCxcCpa01  If   e           k disk    Prefix(l)
     fSegTcf01  if   e           k disk
     fFpspar    If   e           k disk
     fSegMon    if   e           k disk    prefix(x)
     fSegCia01  If   e           k disk
     fFS4001pt  o    e             printer Oflind(*In66)
      *
      * Compos usados en el Programa
     d ParCve          s              1    Inz('@')
     d Conta           s              5  0 Inz(*Zeros)
     d Contador        s              5  0 Inz(*Zeros)
     d PrimerReg       s               n   Inz(*Off)
     d FechaEur        s               d   Datfmt(*Eur)
     d FechaIso        s               d   Datfmt(*Iso)
     d Fecha           s              8  0 Inz(*Zeros)
      *
     d CveTcf          S              2    Inz(*Blanks)
     d SecNcf          S             13    Inz(*Blanks)
     d NcfSec          s             13  0 Inz(*Zeros)
     d TcfCve          s                   Like(SqlSegNcf.TcfCve)
     d NumNcf          s                   Like(SqlFpsFach.NcfNro) Inz(*Blanks)
     d McfCve          S                   Like(SqlSegNcf.McfCve)
      *
     d Itbis           s                   Like(SqlFpsFach.FacTi1) Inz(*Zeros)
     d TotImp          s                   Like(SqlFpsFach.FacTin) Inz(*Zeros)
     d TotDes          s                   Like(SqlFpsFach.FacTd1) Inz(*Zeros)
     d Sub_Tot         s                   Like(SqlFpsFach.FacTin) Inz(*Zeros)
     d Tot_Net         s                   Like(SqlFpsFach.FacTin) Inz(*Zeros)
      *
      * Campos que Son Enviados Como Parametros
     d FechaFacIso     s                   Like(SqlSegFec.FecIso)
     d FechaFinNcf     s                   Like(SqlSegFec.FecIso)
     d TipProNcf       s              1    Inz('P')
     d StatusNcf       s               n   Inz(*Off)
      *
     d Len             s              3  0 Inz(*Zeros)
     d Log             s              3  0 Inz(*Zeros)
     d CampoAlf        s             20    Inz(*Blanks)
     d StatusAlf       s               n   Inz(*Off)
     d Campo01         s             50    Inz(*Blanks)
     d Campo02         s             50    Inz(*Blanks)
      *
    /Copy *Libl/Fuentesfa,FA4000        // Data Structure of PGM
      *
      **Archivos Externos
     d SqlFpsFach    e Ds                  ExtName(FpsFach) Qualified
     d SqlFpsFacd    e Ds                  ExtName(FpsFacd) Qualified
     d SqlCxcCli     e Ds                  ExtName(CxcCli) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
     d SqlSegNcf     e Ds                  ExtName(SegNcf) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Centralozar Titulos
     d CentrarCampo    Pr                  ExtPgm('CENTRA50')
     d  Campo_Envia                        Like(Campo01)
     d  Campo_Recibe                       Like(Campo02)
      *
      * Eliminar digitos alfanumericos de un campo
     d EliminarAlf     Pr                  ExtPgm('SG7015')
     d  Campo_1                            Like(SqlCxcCli.CliTe1)
     d  Status_1                           Like(StatusAlf)
      *
      * Buscar Comprobantes
     d BuscarComp      Pr                  ExtPgm('SG7011')
     d  McfCve_1                           Like(SqlSegNcf.McfCve)
     d  DisCve_1                           Like(SqlSegNcf.DisCve)
     d  MonCve_1                           Like(SqlSegNcf.MonCve)
     d  TcfCve_1                           Like(SqlSegNcf.TcfCve)
     d  NunNcf_1                           Like(SqlFpsFach.NcfNro)
     d  FechaFacIso_1                      Like(SqlSegFec.FecIso)
     d  FechaFinNcf_1                      Like(SqlSegFec.FecIso)
     d  TipProNcf_1                        Like(TipProNcf)
     d  StatusNcf_1                        Like(StatusNcf)
      *
      **FS4001 Prototype
     d FS4001          Pr
     d  CodigoDis                          Like(SqlFpsFach.DisCve)
     d  CodigoMon                          Like(SqlFpsFach.MonCve)
     d  NumeroDoc                          Like(SqlFpsFach.FacNro)
      *
      **FS4001 Program Interface
     d FS4001          Pi
     d  CodigoDis                          Like(SqlFpsFach.DisCve)
     d  CodigoMon                          Like(SqlFpsFach.MonCve)
     d  NumeroDoc                          Like(SqlFpsFach.FacNro)
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

            Chain (DisCve :MonCve :FacNro) FpsFachf  ;
            Chain (ParCve) FpsParf ;
            Chain (CliCve) CxcClif ;
            Chain (CliCve) CxcAdcf ;
            Chain (CliCve) CxcDgcf ;
            Chain (jCpaCve) CxcCpaf ;
            DesCpa = %Trim(lCpaDes)    ;
            Chain (VenCve) CxcVenf ;
            Chain (DisCve) SegDisf ;

            Chain (MonCve) SegMonf     ;
            Simbolo = %Trim(xMonSim)   ;
            If MonCve <> *Zeros        ;
               *In17 = *On             ;
             Else ;
               *In17 = *Off            ;
            EndIf ;

            PrimerReg = *Off    ;

       //Informacion de la Sucursal
           Sucursal = %Trim(DisDes)      ;

       //Informacion del Vendedor
           CodigoVendedor = %Trim(%Editc(VenCve:'X')) + ' ' +
                            %Trim(VenNom)    ;

       //Informacion de la Factura y el Pedido
           NumeroFacturaInterna = %Editc(FacNro:'X')   ;
        //   NumeroPedidoInterno = %Editc(OrdNro:'X')    ;
           ZonaVenta = %Editc(xZonCve:'X')             ;
        // RutaVenta = %Editc(xZonCve:'X')             ;
           CodigoInternoComprador = %Editc(CliCve:'X')             ;

           CveTcf = *Blanks  ;
           Len = %Scan(' ':NcfNro)  ;
           Select  ;
             When Len = *Zeros                  ;
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

           FechaFacIso = FacFec              ;
           Exsr Buscar_Ncf                         ;
           FecFfp = %Dec(FechaFinNcf:*Eur)         ;
           FechaVencimientoSecuencia = %Editw(FecFfp:'  /  /    ') ;

           // NumFac = FacNro                      ;
           // FecOrd = %Dec(%Date(OrdFec:*Iso):*Eur)   ;

       //Fecha de Emision
           FechaEmision = %Editw(FecFac:'  /  /    ') ;

       //Fecha Order de Compra
        //  If FeoRco <> *Zeros   ;
        //     FerDcp = %Dec(%Date(FeoRco:*Iso):*Eur)        ;
        //     FechaOrdenCompra = %Editw(FerDcp:'  /  /    ') ;
        //     NumeroOrdenCompra = %Editc(OrdOrc:'X')    ;
        //  Else  ;
        //     FerDcp = *Zeros ;
        //  EndIf      ;

       //Fecha Limite de Pago
           FechaEur = FacFec                 ;
           FechaEur += %Days(lCpaDcr)        ;
           Fecha = %Dec(FechaEur)            ;
           FechaLimitePago = %Editw(Fecha:'  /  /    ') ;

       //Termino de Pago
           TerminoPago = %Trim(lCpaDes)     ;

       //Tipo de Pago
           If jCpaCve < 3      ;
              TipoPago = 1                  ;
              FechaLimitePago = *Blanks                    ;
            Else ;
              TipoPago = 2                  ;
           Endif ;

       //Razon Social del Comprador
             RazonSocialComprador = %Trim(CliNom)     ;
             CorreoComprador = %Trim(CliEma)     ;

       //Contacto del Comprador
        //   If CclCve <> *Zeros                   ;
        //      ContactoComprador = %Trim(X_CclNom) + ', '  +
        //                          %Trim(X_CclTel)   ;
        //   EndIf  ;

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
            When TcfTds = 'R'              ;
                 Ide = %Trim(CliRnc)           ;
                 CampoAlf = %Trim(Ide)  ;
                 EliminarAlf(CampoAlf :StatusAlf);
                 Ide = 'Rnc: ' + %Trim(CampoAlf)     ;
                 RNCComprador = %Dec(CampoAlf:11:0)   ;

            When TcfTds = 'C'             ;
                 Ide = %Trim(CliCed)               ;
                 CampoAlf = %Trim(Ide)  ;
                 EliminarAlf(CampoAlf :StatusAlf);
                 Ide = 'Cedula: ' + %Trim(CampoAlf)     ;
                 RNCComprador = %Dec(CampoAlf:11:0)   ;

            When TcfTds = 'E'                ;
                 Ide =  %Trim(CliCex)                ;
                 CampoAlf = %Trim(Ide)  ;
                 EliminarAlf(CampoAlf :StatusAlf);
                 Ide = 'Codigo: ' + %Trim(CampoAlf)     ;
                 RNCComprador = %Dec(CampoAlf:11:0)   ;

            Other;
                 Ide = *Blanks     ;
          EndSl ;

       //Imprimir Cabecera de Factura

           If PrimerReg = *Off        ;
              Write header            ;
              PrimerReg = *On         ;
           EndIf                      ;

       //Acumulados
          TotDes = *Zeros ;
          TotImp = *Zeros ;
          Sub_Tot = *Zeros ;

          Sub_Tot = FacTib * 1          ;
          TotDes = FacTd1          ;
          TotImp = FacTi1          ;

       //Totales
           MontoGravadoTotal = TotImp * 1   ;
           MontoGravadoI1 = FacTd1 * 1      ;
           MontoGravadoI2 = *Zeros          ;
           MontoGravadoI3 = *Zeros          ;
           MontoExento = FacTib - TotDes    ;
           MontoTotal = FacTin              ;

       //Otra Moneda Emcabezado
        // TipoMoneda = %Trim(xMonSim)   ;
        // TipoCambio = FacTas * 1     ;

        EndSr               ;
        // -----------------------------------------------------
        // Impresion Detalle                                   -
        // -----------------------------------------------------
        BegSr Ejecuta  ;

         *In22 = *Off ;
        Setll (DisCve :MonCve :FacNro) FpsFacdf  ;

           Dow Not *In22 ;
            Reade(n) (DisCve :MonCve :FacNro) FpsFacdf    ;

            If Not %Eof(FpsFacd01)  ;

              If Conta = 14          ;
                 Write Sigue         ;
                 Write Header        ;
                 Conta = *Zeros      ;
              EndIf   ;

           Chain (SerCve) FpsSerf    ;

       //Informaciones del Item
           NumeroLinea = FacSec *  1  ;
           CodigoItem = %Trim(%Editc(SerCve:'X')) ;
           NombreItem = %Trim(SerDes) ;
           IndicadorBienoServicio = 2  ;        // 1=Bien, 2=Servicio
           CantidadItem = FacCan *  1  ;
           PrecioUnitarioItem = FacPvs *  1  ;

        // DescuentoMonto = DtoMpd + DtoMsd ;
        // TipoSubDescuento = %Trim('%')  ;
        // MontoSubDescuento = DtoMpd *  1  ;

           MontoItem = FacImp               ;

             Write Detail            ;
             Conta += 1              ;

           Exsr Comentarios   ;

             Else ;
              *In22 = *On  ;
             EndIf ;

           EndDo ;

       //Imprimir Totales

           If Conta > 14        ;
              Write Header      ;
            EndIf      ;

            Write Total_1       ;

        EndSr               ;
        // -----------------------------------------------------
        // Imprimir Comentarios de los Servicios               -
        // -----------------------------------------------------
        BegSr Comentarios   ;

       //Imprimir Comentarios del Detalle

           *In26 = *Off     ;
        Setll (DisCve :MonCve :FacNro :SerCve :FacSec) FpsComhf  ;

           Dow Not *In26 ;
            Reade(n) (DisCve :MonCve :FacNro :SerCve :FacSec) FpsComhf  ;

            If Not %Eof(FpsComh)  ;

             If Conta = 14     ;
                Write Sigue    ;
                Write Header   ;
                Conta = *Zeros  ;
             EndIf  ;

             Write Coment  ;
             Conta += 1    ;

             Else ;
              *In26 = *On  ;
             EndIf ;

           EndDo           ;

        EndSr               ;
        // -----------------------------------------------------
        // Buscar Informaciones del Comprobante                -
        // -----------------------------------------------------
        BegSr Buscar_Ncf    ;

          NumNcf = NcfNro   ;
          McfCve = 04       ;

       //Llamar Programa Buscar Comprobantes
          BuscarComp(McfCve :DisCve :MonCve :TcfCve :NumNcf :FechaFacIso
                     :FechaFinNcf :TipProNcf :StatusNcf)      ;

        EndSr               ;
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
           MonCve = CodigoMon                       ;
           FacNro = NumeroDoc                       ;

       //Buscar Informaciones de la Emperesa (Rnc)
           Chain (NumCia) SegCiaf ;

           CampoAlf = %Trim(CiaRnc)  ;
           EliminarAlf(CampoAlf :StatusAlf);
           CiaRnc = %Trim(CampoAlf)        ;
           RncEmisor = %Dec(CampoAlf:11:0)   ;
           RazonSocialEmisor = %Trim(CiaNom)   ;
           NombreComercial = %Trim(CiaGir)   ;
           DireccionEmisor = %Trim(CiaCal) + ', ' +
                             %Trim(CiaSec) + ', ' +
                             %Trim(CiaCiu)         ;
           CorreoEmisor = %Trim(CiaDem)           ;
           WebSite = %Trim(CiaDin)           ;

       //Centrar Texto Nombre de la Empresa
           Campo01 = %Trim(NomCia)          ;
           Campo02 = *Blanks                ;
           CentrarCampo(Campo01 :Campo02)   ;
           wCianom = Campo02                ;

       //Centrar Texto Nombre de la Calle
           Campo01 = %Trim(CiaCal)          ;
           Campo02 = *Blanks                ;
           CentrarCampo(Campo01 :Campo02)   ;
           wCiaCal = Campo02                ;

       //Centrar Texto Sector y Ciudad
           Campo01 = %Trim(CiaSec) + ', ' + %Trim(CiaCiu)       ;
           Campo02 = *Blanks                ;
           CentrarCampo(Campo01 :Campo02)   ;
           wCiaCiu = Campo02                ;

       //Centrar Texto el Rnc
           Campo01 = %Trim(CiaRnc)        ;
           Campo02 = *Blanks                ;
           CentrarCampo(Campo01 :Campo02)   ;
           wCiaIde = Campo02               ;

       //Tipo de Ingresos
           TipoIngresos = 01 ;

        EndSr;
        // -----------------------------------------------------
      /End-Free
