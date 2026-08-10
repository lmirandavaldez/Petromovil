     h   Copyright ('Miranda Valdez, S. A., 2004')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: DG6001                           *
      *  APLICACION...................: Informe DGII 606                 *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 01 / 06 / 2018                   *
      *                                                                  *
      *   Seleccion transacciones para archivo 606 DGII Norma 07-2018    *
      *  ================================================================*
      *
     fDgiitd01  Uf a e           k Disk
     fDgiith    Uf a e           k Disk
     fDgiito    Uf a e           k Disk
      *
      * Campos Recibido como Parametros
     d ArcCod          s              3    Inz(*Blanks)
     d FecIso          s              8    Inz(*Blanks)
     d FechaD          s                   Like(SqlSegFec.FecYmd)
     d FechaH          s                   Like(SqlSegFec.FecYmd)
     d FecDoc          s                   Like(SqlSegFec.FecYmd)
      *
      * Campos Usado en el programa
     d Status          s               n   Inz(*Off)
     d ValorItb        s                   Like(SqlCxpDpeh.DpeVal) Inz(*Zeros)
     d ValorIsr        s                   Like(SqlCxpDpeh.DpeVal) Inz(*Zeros)
     d ProCve          s                   Like(SqlCxpDpeh.ProCve)
     d PerAno          s                   Like(SqlCxpDpeh.PerAno)
     d PerNum          s                   Like(SqlCxpDpeh.PerNum)
     d MovCve          s                   Like(SqlCxpDpeh.MovCve)
     d DpeDoc          s                   Like(SqlCxpDpeh.DpeDoc)
     d DpeRef          s                   Like(SqlCxpDpeh.DpeRef)
     d DpeDr1          s                   Like(SqlCxpDpeh.DpeDr1)
     d CfaCve          s                   Like(SqlCxpDpeh.CfaCve)
     d DpeFtr          s                   Like(SqlCxpDpeh.DpeFtr)
     d DpeVbr          s                   Like(SqlCxpDpeh.DpeVbr)
     d DpeVal          s                   Like(SqlCxpDpeh.DpeVal)
     d DpeVml          s                   Like(SqlCxpDpeh.DpeVml)
     d FseRi1          s                   Like(SqlCxpDped.FseRi1)
     d FseRi2          s                   Like(SqlCxpDped.FseRi2)
     d DpeIm1          s                   Like(SqlCxpDpeh.DpeIm1)
     d DpeIm2          s                   Like(SqlCxpDpeh.DpeIm2)
     d NcfNro          s                   Like(SqlCxpDpeh.NcfNro)
     d DpeTas          s                   Like(SqlCxpDpeh.DpeTas)
     d FecPag          s                   Like(SqlCxpDpeh.FecPag)
     d PagFec          s                   Like(SqlCxpDpeh.FecPag)
     d DpeBce          s                   Like(SqlCxpDpeh.DpeBce)
     d TdiCve          s                   Like(SqlCxpDpeh.TdiCve)
     d DgeDoc          s                   Like(SqlCxpDpeh.DgeDoc)
     d DpeMif          s                   Like(SqlCxpDpeh.DpeMif)
     d MifDpe          s                   Like(SqlCxpDpeh.DpeMif)
     d NcfFac          s                   Like(SqlCxpDpeh.NcfNro)
     d MonCve          s                   Like(SqlCxpDpeh.MonCve)
     d FecAmd          s                   Like(SqlCxpDpeh.FecAmd)
     d DgiFcm          s                   Like(SqlCxpDpeh.FecAmd)
     d MovTip          s                   Like(SqlCxpMov.MovTip)
      *
     d ProNom          s                   Like(SqlCxpPro.ProNom)
     d ProNid          s                   Like(SqlCxpPro.ProNid)
     d ProIde          s                   Like(SqlCxpPro.ProIde)
      *
     d DpeVtr          s                   Like(SqlCxpDped.DpeVtr)
     d FecTra          s                   Like(SqlCxpDped.FecTra)
     d DpeTca          s                   Like(SqlCxpDped.DpeTca)
     d DgeVal          s                   Like(SqlCogHdgd.DgeVal)
     d NcfDge          s                   Like(SqlCogHdgd.NcfNro)
     d DgeIde          s                   Like(SqlCogHdgd.DgeIde)
     d DgeTid          s                   Like(SqlCogHdgd.DgeTid)
     d CtaCve          s                   Like(SqlCogHdgd.CtaCve)
     d DgeVid          s                   Like(SqlCogHdgd.DgeVid)
     d DgeVir          s                   Like(SqlCogHdgd.DgeVir)
     d DgeVoi          s                   Like(SqlCogHdgd.DgeVoi)
     d DgeVor          s                   Like(SqlCogHdgd.DgeVor)
      *
     d CriCve          s                   Like(SqlCxpTrah.CriCve)
     d CriCv2          s                   Like(SqlCxpTrah.CriCv2)
     d FseSrp          s                   Like(SqlCxpTrah.FseSrp)
     d FseVri          s                   Like(SqlCxpTrah.FseVri)
     d FseVnt          s                   Like(SqlCxpTrah.FseVnt)
     d FseVal          s                   Like(SqlCxpTrah.FseVal)
     d FseVml          s                   Like(SqlCxpTrah.FseVml)
     d FseTas          s                   Like(SqlCxpTrah.FseTas)
      *
     d DgeDes          s                   Like(SqlCogHdgh.DgeDes)
      *
     d TdiTip          s                   Like(SqlCogTdi.TdiTip)
      * Campos Usado en el programa
     d Valor_RetItb    s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_RetIsr    s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Ret01     s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Ret02     s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Itb       s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Isr       s                   Like(SqlCxpDpeh.DpeVal)
     d  TipTre         s                   Like(SqlCxpCri.TreCve)
      *
     d ProDes_01       s                   Like(SqlCxpCri.CriPre)
     d ProDes_02       s                   Like(SqlCxpCri.CriPre)
     d Gis01           s                   Like(SqlCxpCri.CriGis)
     d Gis02           s                   Like(SqlCxpCri.CriGis)
     d Tig01           s                   Like(SqlCxpCri.CriTig)
     d Tig02           s                   Like(SqlCxpCri.CriTig)
     d Tre01           s                   Like(SqlCxpCri.TreCve)
     d Tre02           s                   Like(SqlCxpCri.TreCve)
      *
     d Total_Reg       s                   Like(SqlDgiIth.DgiCre) Inz(*Zeros)
     d Total_Monto     s                   Like(SqlDgiIth.DgiMfa) Inz(*Zeros)
     d Mon_Adelan      s                   Like(SqlDgiIth.DgiMif) Inz(*Zeros)
     d Mon_Pagado      s                   Like(SqlDgiIth.DgiMip) Inz(*Zeros)
     d Mon_Retenido    s                   Like(SqlDgiIth.DgiMir) Inz(*Zeros)
     d Mon_OtroIsr     s                   Like(SqlDgiIth.DgiMis) Inz(*Zeros)
      *
     d FechaIso        S               d   datfmt(*Iso)
     d CodCheque       s              2  0 Inz(*Zeros)
     d RestaImpuesto   s              1    Inz(*Blanks)
      *
     d Rnc             s              9  0 Inz(*Zeros)
     d Ced             s             11  0 Inz(*Zeros)
     d DocFec          s                   Like(SqlSegFec.FecYmd)
     d Ncf             s                   Like(NcfNro) Inz(*Blanks)
      *
     d CodArc          s                   Like(DgiCar) Inz(*Zeros)
      *
      * Parametros
     d Sistema         s              2    inz('CP')
     d CodParam        s              4  0 inz(*Zeros)
     d ValorNum        s             30 15 inz(*Zeros)
     d ValorAlf        s            100    inz(*Blank)
      *
      * Campos que Son Enviados Como Parametros
     d Len             s              2  0 Inz(*Zeros)
     d Log             s              2  0 Inz(*Zeros)
     d NcfSer          s                   Like(SqlSegNcf.NcfSer)
     d NcfDiv          s                   Like(SqlSegNcf.NcfDiv)
     d NcfZon          s                   Like(SqlSegNcf.NcfZon)
     d NcfCaj          s                   Like(SqlSegNcf.NcfCaj)
     d NcfTip          s                   Like(SqlSegNcf.NcfTip)
     d NcfSec          s                   Like(SqlSegNcf.NcfSec)
     d TcfCve          s                   Like(SqlSegNcf.TcfCve)
      *
     d                 Ds
     dSecNcf                         10  0 Inz
     d Sec10                   1     10  0
     d Sec08                   3     10  0
      *
     d SqlCxpDpeh    e Ds                  ExtName(CxpDpeh08) Qualified
     d SqlCxpDped    e Ds                  ExtName(CxpDped08) Qualified
     d SqlCxpTrah    e Ds                  ExtName(CxpTrah01) Qualified
     d SqlCxpMov     e Ds                  ExtName(CxpMov) Qualified
     d SqlCxpPro     e Ds                  ExtName(CxpPro) Qualified
     d SqlCxpCri     e Ds                  ExtName(CxpCri) Qualified
     d SqlCxpCfa     e Ds                  ExtName(CxpCfa) Qualified
     d SqlCogHdgd    e Ds                  ExtName(CogHdgd) Qualified
     d SqlCogHdgh    e Ds                  ExtName(CogHdgh) Qualified
     d SqlCogRcac    e Ds                  ExtName(CogRcac) Qualified
     d SqlCogTdi     e Ds                  ExtName(CogTdi) Qualified
     d SqlDgiiTh     e Ds                  ExtName(DgiiTh) Qualified
     d SqlDgiiTd     e Ds                  ExtName(DgiiTd) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
     d SqlSegNcf     e Ds                  ExtName(SegNcf) Qualified
      *
     d                 Ds
     dAnoNum                   1      6  0 Inz
     d AnoPer                  1      4  0
     d NumPer                  5      6  0
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Buscar Parametros
     d BuscaPrm        Pr                  ExtPgm('SG7009')
     d  Sistema_1                          Like(Sistema)
     d  CodParam_1                         Like(CodParam)
     d  ValorNum_1                         Like(ValorNum)
     d  ValorAlf_1                         Like(ValorAlf)
      *
      * Totalizar Archivos
     d TotCabec        Pr                  ExtPgm('DG0003DC')
     d  DgiCar_1                           Like(DgiCar)
     d  DgiPer_1                           Like(DgiPer)
      *
      * Calcular las Retenciones
     d CalReten        Pr                  ExtPgm('DG6001A')
     d  ProCve_1                           Like(ProCve)
     d  DpeDoc_1                           Like(DpeDoc)
     d  MovCve_1                           Like(MovCve)
     d  FecPag_1                           Like(FecPag)
     d  ValorItb_1                         Like(ValorItb)
     d  ValorIsr_1                         Like(ValorIsr)
     d  TipTre_1                           Like(TipTre)
      *
      **DG6001 Prototype
     d DG6001          Pr
     d  CodCar                             Like(ArcCod)
     d  FechaDesde                         Like(FecIso)
     d  FechaHasta                         Like(FecIso)
      *
      **DG6001 Program Interface
     d DG6001          Pi
     d  CodCar                             Like(ArcCod)
     d  FechaDesde                         Like(FecIso)
     d  FechaHasta                         Like(FecIso)
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
        Exsr Consta;
        Exsr EndProgram;
        // ------------------------------------------------------
        // Definicion de variables intermedias                  -
        // ------------------------------------------------------
        Begsr Consta;

        Total_Reg = *Zeros;
        Total_Monto = *Zeros;
        Mon_Adelan = *Zeros;
        Mon_Pagado = *Zeros;
        Mon_Retenido = *Zeros;
        Mon_OtroIsr = *Zeros;

        Exsr Borrar_Reg;
        Exsr Documentos;
        Exsr Transacciones;
        Exsr Pagos;
        Exsr Contabilidad;
        Exsr Cabecera;
        Exsr Totalizar;

       EndSr;
        // ------------------------------------------------------
        // Seleccionar Documentos registro en Cuentas x Pagar   -
        // ------------------------------------------------------
         BegSr Documentos;

        // Leer Archivo
           Exec Sql
              Declare C1 cursor for
               Select *
                 From CxpDpeh08 T1
                 Join CxpPro T2
                   On (T1.ProCve = T2.ProCve)
                Where (T1.FecAmd Between :FechaD And :FechaH) And
                      (T1.MovCve <> :CodCheque) And
                      (T2.ProTip <> 2)
             Order by T1.ProCve, T1.FecAmd
               For Read Only ;

        Exec Sql
          Open c1;

        Dow True;

          Exec Sql
            Fetch Next From c1 Into :SqlCxpDpeh, :SqlCxpPro            ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

       // Todos los campos a variables intermedias
          ProCve = SqlCxpDpeh.ProCve ;
          PerAno = SqlCxpDpeh.PerAno ;
          PerNum = SqlCxpDpeh.PerNum ;
          MovCve = SqlCxpDpeh.MovCve ;
          DpeDoc = SqlCxpDpeh.DpeDoc ;
          DpeRef = SqlCxpDpeh.DpeRef ;
          DpeDr1 = SqlCxpDpeh.DpeDr1 ;
          CfaCve = SqlCxpDpeh.CfaCve ;
          DocFec = SqlCxpDpeh.FecAmd ;
          DpeFtr = SqlCxpDpeh.DpeFtr ;
          DpeVbr = SqlCxpDpeh.DpeVbr ;
          DpeVal = SqlCxpDpeh.DpeVal ;
          DpeVml = SqlCxpDpeh.DpeVml ;
          DpeIm1 = SqlCxpDpeh.DpeIm1 ;
          DpeIm2 = SqlCxpDpeh.DpeIm2 ;

          DgiMfs = SqlCxpDpeh.DpeMfs ;
          DgiMfb = SqlCxpDpeh.DpeMfb ;
          DgiIfs = SqlCxpDpeh.DpeIfs ;
          DgiIfb = SqlCxpDpeh.DpeIfb ;
          DgiMic = SqlCxpDpeh.DpeMic ;
          DgiMip = SqlCxpDpeh.DpeMip ;
          DgiMis = SqlCxpDpeh.DpeMis ;
          DgiMio = SqlCxpDpeh.DpeMio ;
          DgiMpl = SqlCxpDpeh.DpeMpl ;

          NcfNro = SqlCxpDpeh.NcfNro ;
          DpeTas = SqlCxpDpeh.DpeTas ;
          PagFec = SqlCxpDpeh.FecPag ;
          DpeBce = SqlCxpDpeh.DpeBce ;
          TdiCve = SqlCxpDpeh.TdiCve ;
          DgeDoc = SqlCxpDpeh.DgeDoc ;
          DpeMif = SqlCxpDpeh.DpeMif ;
          ProNom = SqlCxpPro.ProNom ;
          ProNid = SqlCxpPro.ProNid ;
          ProIde = SqlCxpPro.ProIde ;

       // Mover el nombre del Proveedor a la Descripcion de la Transaccion
          DesDgi = %Trim(ProNom) ;

       // Mover la Fecha del Documento
          FecDoc = DocFec ;
          FDocum = DocFec ;

       // Convertir la fecha del Pago si Fue Paga en el Periodo
          Test(De) *Eur PagFec ;
            If  Not %Error;
              FecPag = %Dec(%Date(PagFec:*Eur):*Iso);

          // Buscar la Forma de Pago
              Exsr BuscarFpg ;
            Else;
              FecPag = *Zeros ;
              FpgCve = 4 ;    // Credito
            EndIf ;

       // Tasa de Cambio = Cero
            If DpeTas = *Zeros ;
             Eval DpeTas = 1.00000 ;
            Endif;

       // Convertir los impuestos a Moneda Local
            Eval(Rh) DpeIm1 = DpeIm1 * Dpetas;
            Eval(Rh) DpeIm2 = DpeIm2 * Dpetas;
       //   DpeIm1 = %Dech(DpeIm1 * Dpetas:12:2);
       //   DpeIm2 = %Dech(DpeIm2 * Dpetas:12:2);

       // Convertir el Valor Bruto del Documento en Moneda local
            Eval(Rh) DpeVbr = DpeVbr * DpeTas;

       // Convertir todos los campos del documento en Moneda local
          Eval(Rh) DgiMfs = DgiMfs * Dpetas;
          Eval(Rh) DgiMfb = DgiMfb * Dpetas;
          Eval(Rh) DgiIfs = DgiIfs * Dpetas;
          Eval(Rh) DgiIfb = DgiIfb * Dpetas;
          Eval(Rh) DgiMic = DgiMic * Dpetas;
          Eval(Rh) DgiMip = DgiMip * Dpetas;
          Eval(Rh) DgiMis = DgiMis * Dpetas;
          Eval(Rh) DgiMio = DgiMio * Dpetas;
          Eval(Rh) DgiMpl = DgiMpl * Dpetas;

       // Varifica Monto Bruto
          If DpeVbr <> (DgiMfs + DgiMfb) ;
             DpeVbr = (DgiMfs + DgiMfb) ;
          EndIf ;

       // Varifica Impuesto
         If DpeMif = *Zeros And DgiMic <> *Zeros   ;
            DpeMif = DgiMic ;
          EndIf ;

       // Mover Rnc o Cedula
            Exsr Mover_Campos;

       // Clasificacion de factura
            ClaFac = %Dec(%Subst(%Editc(CfaCve:'X'):3:2):2:0);

       // Validar el Numero de Comprobante
            Ncf = NcfNro ;
            Exsr MoverNcf;
            NroNcf = Ncf;

       // Tipo de Comprobante
            TcfCve = NcfTip  ;

       // Impuesto Adelantado o llevado al Costo
       //   If (DpeIm1 + DpeIm2) = *Zeros And DpeMif <> *Zeros  ;
            If (DpeIm1 + DpeIm2 + DgiMic) = *Zeros And DpeMif <> *Zeros  ;
               Eval(Rh) ImpAde = DpeMif * Dpetas ;
       //      ImpAde = %Dech(ImpAde * Dpetas:12:2);
               Mon_Adelan += ImpAde ;

       // Total Facturado
              Total_Monto += (DpeVbr - ImpAde);
              MonFac = (DpeVbr - ImpAde) * 1;

         // Monto del servicio o Bien sin el Impuesto
L006     // Select;
 ''      //   When DgiMfs <> *Zeros ;
 ''      //   DgiMfs = DgiMfs - ImpAde  ;
 ''
 ''      //   When DgiMfb <> *Zeros ;
 ''      //   DgiMfb = DgiMfb - ImpAde  ;
L006     // EndSl;

            Else;
              ImpAde = DpeIm1 + DpeIm2 + DgiMic ;
              Mon_Adelan += ImpAde        ;

       // Total Facturado
              Total_Monto += DpeVbr     ;
              MonFac = DpeVbr * 1       ;
            EndIf;

       // Calcular el impuesto retenido
            If FecPag <> *Zeros And FecPag <= FechaH  ;
               Exsr Cal_Retenido;
               TreCve = TipTre;
            Else;
               ImpRet = *Zeros ;
               FecPag = *Zeros;
            EndIf;

       // Fecha de Pago
            If FecPag > *Zeros ;
               FePago = FecPag ;
            Else;
               FePago = *Zeros;
            EndIf;

       // Acumular campos Cabecera

            ImpRet = ValorItb * 1  ;
            DgiDv1 = ValorIsr * 1  ;
            Mon_Retenido += ImpRet ;
            Mon_OtroIsr += DgiDv1  ;

       // En caso que al crear la factura no le marcaron que tenia ITBIS y
       // al pagar le descuentan
            If ImpRet <> *Zeros And ImpAde = *Zeros  ;
               ImpAde = DpeMif * 1  ;
               Mon_Adelan += ImpAde ;
            EndIf;

       // Campos Cabecera
          Total_Reg += 1   ;

          // Grabar Resgistro en Detalle
          DgiOri = 'CP' ;
          DgiRea = 'A'  ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitdf ;

          Clear Dgiitdf ;
          ValorItb = *Zeros;
          ValorIsr = *Zeros;

         EndDo ;

          // Grabar Resgistro por Modulo

          DgiOri = 'CP' ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitof ;


        Exec Sql
          Close c1;
        SqlCod = *Zeros;

        Endsr;
        // ------------------------------------------------------
        // Seleccionar Notas de Debito y Credito Cuentas x Pagar-
        // ------------------------------------------------------
         BegSr Transacciones;

        // Leer Archivo
           Exec Sql
              Declare C2 cursor for
               Select *
                 From CxpDped08 T1
                 Join CogHdgd T2
                   On (T1.TdiCve = T2.TdiCve)
                  And (T1.DgeDoc = T2.DgeDoc)
                  And (T1.PerAno = T2.PerAno)
                  And (T1.PerNum = T2.PerNum)
                 Join CxpTrah01 T3
                   On (T1.ProCve = T3.ProCve)
                  And (T1.TdiCve = T3.TdiCve)
                  And (T1.DgeDoc = T3.DgeDoc)
                  And (T1.DpeMot = T3.DpeMot)
                  And (T1.PerAno = T3.PerAno)
                  And (T1.PerNum = T3.PerNum)
                 Join CxpDpeh08 T4
                   On (T1.ProCve = T4.ProCve)
                  And (T1.DpeDoc = T4.DpeDoc)
                  And (T1.MovCve = T4.MovCve)
                 Join CxpPro T5
                   On (T1.ProCve = T5.ProCve)
                Where (T1.FecTra Between :FechaD And :FechaH)
                  And (T1.DpeMot Between 02 and 03)
                  And (T1.DpeVtr = T2.DgeVal)
                  And (T2.DgeSec = 1)
                  And (T5.ProTip <> 2)
             Order by T1.ProCve, T1.FecTra
             For Read Only ;

        Exec Sql
          Open c2;

        Dow True;

          Exec Sql
            Fetch Next From c2 Into :SqlCxpDped, :SqlCogHdgd, :SqlCxpTrah,
                                    :SqlCxpDpeh, :SqlCxpPro ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

       // Todos los campos a variables intermedias
          ProCve = SqlCxpDped.ProCve ;
          DpeDoc = SqlCxpDped.DpeDoc ;
          DpeVtr = SqlCxpDped.DpeVtr ;
          FecTra = SqlCxpDped.FecTra ;
          MovCve = SqlCxpDped.MovCve ;
          TdiCve = SqlCxpDped.TdiCve ;
          DgeDoc = SqlCxpDped.DgeDoc ;
          PerAno = SqlCxpDped.PerAno ;
          PerNum = SqlCxpDped.PerNum ;
          DpeTca = SqlCxpDped.DpeTca ;
          DgeVal = SqlCogHdgd.DgeVal ;
          NcfDge = SqlCogHdgd.NcfNro ;
          FseVri = SqlCxpTrah.FseVri ;
          FseVnt = SqlCxpTrah.FseVnt ;
          FseVal = SqlCxpTrah.FseVal ;
          FseVml = SqlCxpTrah.FseVml ;
          NcfFac = SqlCxpDpeh.NcfNro ;
          CfaCve = SqlCxpDpeh.CfaCve ;
          DpeTas = SqlCxpDpeh.DpeTas ;
          MonCve = SqlCxpDpeh.MonCve ;
          ProNom = SqlCxpPro.ProNom ;
          ProNid = SqlCxpPro.ProNid ;
          ProIde = SqlCxpPro.ProIde ;

        // Descripcion de la Transaccion
          DesDgi = %Trim(ProNom)   ;

        // Mover Rnc o Cedula
          Exsr Mover_Campos ;

       // Clasificacion de factura
            ClaFac = %Dec(%Subst(%Editc(CfaCve:'X'):3:2):2:0);

       // Forma de Pago
            FpgCve = 4;       // Nota de Credito

       // Mover Fechas
         FecDoc = FecTra  ;
         FDocum = FecDoc  ;
         DocFec = FecDoc  ;

       If DpeTca = *Zeros  ;
          DpeTca = 1.00000 ;
       Endif ;

         Eval(Rh) FseVri = FseVri * DpeTca    ;

        // Para determinar el Bruto del Documento
         If MonCve = *Zeros    ;
            FseVnt = FseVal - FseVri ;
         Else ;
            FseVnt = FseVml - FseVri ;
         EndIf ;

       // Impuesto Adelantado
         ImpAde = FseVri * 1   ;
         Mon_Adelan += FseVri  ;

       // Impuesto Retenido
         ImpRet = FseVri * 1  ;
         Mon_Retenido += ImpRet ;

       // Acumular campos Cabecera
         Total_Monto += FseVnt  ;
         MonFac = FseVnt * 1    ;

       // Numero Comprobante la Transaccion
         Ncf = NcfDge  ;
         Exsr MoverNcf ;
         NroNcf = Ncf  ;

       // Tipo de Comprobante
         TcfCve = NcfTip ;

       // Numero Comprobante del Documento
         Ncf = NcfFac  ;
         Exsr MoverNcf ;
         NcfMod = Ncf  ;

       // Campos Cabecera
         Total_Reg += 1  ;

          // Grabar Resgistro en Detalle
          DgiOri = 'TR' ;
          DgiRea = 'A'  ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitdf ;
          Clear Dgiitdf ;

         EndDo ;

          // Grabar Resgistro por Modulo

          DgiOri = 'TR' ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitof ;


        Exec Sql
          Close c2;
        SqlCod = *Zeros;

        Endsr;
        // ------------------------------------------------------
        // Sel. Documentos meses anteriores pagado el mes actual-
        // ------------------------------------------------------
         BegSr Pagos;

        // Leer Archivo
           Exec Sql
              Declare C3 cursor for
               Select *
                 From CxpDped08 T1
                 Join CxpTrah01 T3
                   On (T1.ProCve = T3.ProCve)
                  And (T1.TdiCve = T3.TdiCve)
                  And (T1.DgeDoc = T3.DgeDoc)
                  And (T1.DpeMot = T3.DpeMot)
                  And (T1.PerAno = T3.PerAno)
                  And (T1.PerNum = T3.PerNum)
                 Join CxpDpeh08 T4
                   On (T1.ProCve = T4.ProCve)
                  And (T1.DpeDoc = T4.DpeDoc)
                  And (T1.MovCve = T4.MovCve)
                 Join CxpPro T5
                   On (T1.ProCve = T5.ProCve)
                Where (T1.FecTra Between :FechaD And :FechaH)
                  And (T1.DpeMot Between 04 and 07)
                  And (T3.CriCve <> 0 Or T3.CriCv2 <> 0)
                  And (T4.FecAmd > 20061231)
                  And (T4.FecAmd < :FechaH)
                  And (T5.ProTip <> 2)
             Order by T1.ProCve, T1.FecTra
             For Read Only ;

        Exec Sql
          Open c3;

        Dow True;

          Exec Sql
            Fetch Next From c3 Into :SqlCxpDped, :SqlCxpTrah, :SqlCxpDpeh,
                                    :SqlCxpPro ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

       // Todos los campos a variables intermedias
          ProCve = SqlCxpDped.ProCve ;
          DpeDoc = SqlCxpDped.DpeDoc ;
          DpeVtr = SqlCxpDped.DpeVtr ;
          FecTra = SqlCxpDped.FecTra ;
          MovCve = SqlCxpDped.MovCve ;
          TdiCve = SqlCxpDped.TdiCve ;
          DgeDoc = SqlCxpDped.DgeDoc ;
          PerAno = SqlCxpDped.PerAno ;
          PerNum = SqlCxpDped.PerNum ;
          DpeTca = SqlCxpDped.DpeTca ;
          FseRi1 = SqlCxpDped.FseRi1 ;
          FseRi2 = SqlCxpDped.FseRi2 ;
          CriCve = SqlCxpTrah.CriCve ;
          CriCv2 = SqlCxpTrah.CriCv2 ;
          FseSrp = SqlCxpTrah.FseSrp ;
          FseTas = SqlCxpTrah.FseTas ;
          NcfFac = SqlCxpDpeh.NcfNro ;
          CfaCve = SqlCxpDpeh.CfaCve ;
          DpeTas = SqlCxpDpeh.DpeTas ;
          FecAmd = SqlCxpDpeh.FecAmd ;
          DpeIm1 = SqlCxpDpeh.DpeIm1 ;
          DpeIm2 = SqlCxpDpeh.DpeIm2 ;
          DpeVbr = SqlCxpDpeh.DpeVbr ;
          DpeMif = SqlCxpDpeh.DpeMif ;

          DgiMfs = SqlCxpDpeh.DpeMfs ;
          DgiMfb = SqlCxpDpeh.DpeMfb ;
          DgiIfs = SqlCxpDpeh.DpeIfs ;
          DgiIfb = SqlCxpDpeh.DpeIfb ;
          DgiMic = SqlCxpDpeh.DpeMic ;
          DgiMip = SqlCxpDpeh.DpeMip ;
          DgiMis = SqlCxpDpeh.DpeMis ;
          DgiMio = SqlCxpDpeh.DpeMio ;
          DgiMpl = SqlCxpDpeh.DpeMpl ;

          ProNom = SqlCxpPro.ProNom ;
          ProNid = SqlCxpPro.ProNid ;
          ProIde = SqlCxpPro.ProIde ;

       // Descripcion de la Transaccion
          DesDgi = %Trim(ProNom)   ;

       // Mover Rnc o Cedula
          Exsr Mover_Campos ;

       // Buscar el tipo de Clasificacion
              Exec Sql
                Select *
                  Into :SqlCxpCfa
                  From CxpCfa
                 Where (CfaCve = :CfaCve)
         Fetch First 1 Rows Only       ;

        SqlCod = *Zeros;

       // Clasificacion de factura
            ClaFac = %Dec(%Subst(%Editc(CfaCve:'X'):3:2):2:0);

       // Mover Fechas
         FecDoc = FecAmd  ;
         FDocum = FecDoc  ;
         FecPag = FecTra  ;
         DocFec = FecTra  ;

       // Fecha de Pago > *Zeros
         If FecPag > *Zeros   ;
            FePago = FecPag;

          // Buscar la Forma de Pago
              Exsr BuscarFpg ;

         Else ;
            FePago = *Zeros;
            FpgCve = 4;       // Credito
         EndIf ;

       // La Tasa de Cambio del Pago
       If DpeTca = *Zeros  ;
          DpeTca = 1.00000 ;
       Endif ;

       // La Tasa de Cambio del Documentos
       If DpeTas = *Zeros  ;
          DpeTas = 1.00000 ;
       Endif ;

       // La Tasa del Pago
       If FseTas = *Zeros  ;
          FseTas = 1.00000 ;
       Endif ;

       // Se debe enviar el Impuesto de la factura para que la DGII pueda
       // identificar que se esta pagando esta factura
         Eval(RH) DpeIm1 = DpeIm1 * Dpetas ;
         Eval(RH) DpeIm2 = DpeIm2 * Dpetas ;
         Eval(RH) DpeMif = DpeMif * Dpetas ;
         Eval(RH) FseRi1 = FseRi1 * DpeTca ;
         Eval(RH) FseRi2 = FseRi2 * DpeTca ;

       // Valor Bruto del Documento
         Eval(Rh) DpeVbr = DpeVbr * DpeTas ;

       // Convertir todos los campos del documento en Moneda local

          Eval(Rh) DgiMfs = DgiMfs * Dpetas;
          Eval(Rh) DgiMfb = DgiMfb * Dpetas;
          Eval(Rh) DgiIfs = DgiIfs * Dpetas;
          Eval(Rh) DgiIfb = DgiIfb * Dpetas;
          Eval(Rh) DgiMic = DgiMic * Dpetas;
          Eval(Rh) DgiMip = DgiMip * Dpetas;
          Eval(Rh) DgiMis = DgiMis * Dpetas;
          Eval(Rh) DgiMio = DgiMio * Dpetas;
          Eval(Rh) DgiMpl = DgiMpl * Dpetas;

       // Varifica Monto Bruto
          If DpeVbr <> (DgiMfs + DgiMfb) ;
             DpeVbr = (DgiMfs + DgiMfb) ;
          EndIf ;

       // Varifica Impuesto
         If DpeMif = *Zeros And DgiMic <> *Zeros   ;
            DpeMif = DgiMic ;
          EndIf ;

       // Impuesto Pagado
         ImpPag = *Zeros ;
         ImpPag = DpeIm1 + DpeIm2 ;
         Mon_Pagado += ImpPag ;

L005   // Monto Bruto
 ''       If (DpeIm1 + DpeIm2) = *Zeros And DpeMif <> *Zeros  ;
 ''    //  DpeVbr = DpeVbr - DpeMif ;
 ''        DpeVbr = (DgiMfs + DgiMfb) ;

         // Monto del servicio o Bien sin el Impuesto
L006     // Select;
 ''      //   When DgiMfs <> *Zeros ;
 ''      //   DgiMfs = DgiMfs - DpeMif  ;
 ''
 ''      //   When DgiMfb <> *Zeros ;
 ''      //   DgiMfb = DgiMfb - DpeMif  ;
L006     // EndSl;

L005    EndIf ;

       // Para Calcular Las retenciones
         // MifDpe = DpeMif  ;

        // If DpeMif <> (FseRi1 + FseRi2) ;
         //   DpeMif = (FseRi1 + FseRi2)  ;
         // EndIf;

        Exsr Retenciones;
        TreCve = TipTre ;
         //   DpeMif = MifDpe  ;

       // Si el pago no tiene retencion no debe ser incluido en el archivo
        If (Valor_RetItb + Valor_RetIsr) = *Zeros    ;
          Iter ;
        EndIf ;

       // Monto Retenciones ISR
         DgiDv1 = Valor_RetIsr  ;
         Mon_OtroIsr += DgiDv1  ;
       // Eval(Rh) DpeVtr = DpeVtr * DpeTca ;

       // Monto Retenciones ITBIS
         ImpRet = Valor_RetItb  ;
         Mon_Retenido += Valor_RetItb ;

       // Impuesto Adelantado
       // Eval(Rh) ImpAde = DpeMif * DpeTca   ;
         Eval(Rh) ImpAde = DpeMif * 1        ;
         Mon_Adelan += ImpAde  ;

       // Total Facturado
       // MonFac = (DpeVbr - ImpAde) * 1   ;
         MonFac = DpeVbr * 1   ;
         Total_Monto += MonFac  ;

         // Mover monto Bruto documento al campo que le corresponde
          Select;
          When SqlCxpCfa.CfaTca = 'B' And DgiMfb = *Zeros ;
               DgiMfb = DpeVbr ;

          When SqlCxpCfa.CfaTca = 'S' And DgiMfs = *Zeros ;
               DgiMfs = DpeVbr ;
          EndSl;

       // Numero Comprobante del Documento
         Ncf = NcfFac  ;
         Exsr MoverNcf ;
         NroNcf = Ncf  ;

       // Tipo de Comprobante
         TcfCve = NcfTip ;

       // Verifica si Existe el registro creado
         Status = *Off    ;
         DgiOri = 'CP'    ;

        Exec Sql
          Select '1' Into :Status
            From Dgiitd
           Where (DgiCar = :CodArc)
             And (DgiPer = :AnoNum)
             And (DgiOri = :DgiOri)
             And (NroIde = :NroIde)
             And (NroNcf = :NroNcf)
             And (DgiRea = 'A')    ;

        SqlCod = *Zeros;

       // Actualizar o Crear El Registro

        If Status = *On   ;

       // Si Para limpirar la fecha de pago
          If FecPag = *Zeros  ;
             FecPag = *Zeros ;
          EndIf ;

          Exec Sql
           Update Dgiitd Set ImpRet = :Valor_RetItb, DgiDv1 = :Valor_RetIsr,
                             FePago =: FecPag
           Where (DgiCar = :CodArc)
             And (DgiPer = :AnoNum)
             And (DgiOri = :DgiOri)
             And (NroIde = :NroIde)
             And (NroNcf = :NroNcf)
             And (DgiRea = 'A')    ;
        Else ;

       // Campos Cabecera
03862     MonFac = DpeVbr * 1 ;
          Total_Reg += 1  ;

          // Grabar Resgistro en Detalle
          DgiOri = 'PG' ;
          DgiRea = 'A'  ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitdf ;
        EndIf ;
          Clear Dgiitdf ;

         EndDo ;

          // Grabar Resgistro por Modulo

          DgiOri = 'PG' ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitof ;

        Exec Sql
          Close c3;
        SqlCod = *Zeros;

        Endsr;
        // ------------------------------------------------------
        // Sel. Transacciones desde la Contabilidad             -
        // ------------------------------------------------------
         BegSr Contabilidad;

        // Leer Archivo
           Exec Sql
              Declare C4 cursor for
               Select *
                 From CogRcac T1
                 Join CogHdgd T2
                   On (T1.CtaCve = T2.CtaCve)
                 Join CogTdi T3
                   On (T2.TdiCve = T3.TdiCve)
                 Join CogHdgh T4
                   On (T2.TdiCve = T4.TdiCve)
                  And (T2.PerAno = T4.PerAno)
                  And (T2.PerNum = T4.PerNum)
                  And (T2.DgeDoc = T4.DgeDoc)
                 Join SegFec T9
                   On (T2.DgeAno = T9.FecAno)
                  And (T2.DgeMes = T9.FecMes)
                  And (T2.DgeDia = T9.FecDia)
                Where (T9.FecYmd Between :FechaD And :FechaH)
                  And (T1.DgiCar = :CodArc)
                  And (T2.DgeOri = 1)
             Order by T2.NcfNro, T2.DgeIde, T2.CtaCve
             For Read Only ;

        Exec Sql
          Open c4;

        Dow True;

          Exec Sql
            Fetch Next From c4 Into :SqlCogRcac, :SqlCogHdgd, :SqlCogTdi,
                                    :SqlCogHdgh, :SqlSegFec;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        // Todos los campos a variables intermedias
          DgeDes = SqlCogHdgh.DgeDes ;
          TdiCve = SqlCogHdgd.TdiCve ;
          PerAno = SqlCogHdgd.PerAno ;
          PerNum = SqlCogHdgd.PerNum ;
          DgeDoc = SqlCogHdgd.DgeDoc ;
          TdiTip = SqlCogTdi.TdiTip ;
          FecAmd = SqlSegFec.FecYmd ;
          DgeVal = SqlCogHdgd.DgeVal ;
          NcfNro = SqlCogHdgd.NcfNro ;
          CfaCve = SqlCogHdgd.CfaCve ;
          DgeIde = SqlCogHdgd.DgeIde ;
          DgeTid = SqlCogHdgd.DgeTid ;
          CtaCve = SqlCogHdgd.CtaCve ;
          DgeVid = SqlCogHdgd.DgeVid ;
          DgeVir = SqlCogHdgd.DgeVir ;
          DgeVoi = SqlCogHdgd.DgeVoi ;
          DgeVor = SqlCogHdgd.DgeVor ;

          DgiMfs = SqlCogHdgd.DgeMfs ;
          DgiMfb = SqlCogHdgd.DgeMfb ;
          DgiIfs = SqlCogHdgd.DgeIfs ;
          DgiIfb = SqlCogHdgd.DgeIfb ;
          DgiMic = SqlCogHdgd.DgeMic ;
          DgiMip = SqlCogHdgd.DgeMip ;
          DgiMis = SqlCogHdgd.DgeMis ;
          DgiMio = SqlCogHdgd.DgeMio ;
          DgiMpl = SqlCogHdgd.DgeMpl ;

        // Descripcion de la Transaccion
          DesDgi = %Trim(DgeDes)   ;

      //Verifica si es un Gasto Menor / Nota credito no deben subir
         Status = *Off    ;

              Exec Sql
                Select '1' Into :Status
                 From CogHdgd T1
                Where Exists (Select * From CogGmhh T2
                 Where (T1.TdiCve = T2.TdiCve)
                  And (T1.DgeDoc = T2.DgeDoc)
                  And (T1.PerAno = T2.PerAno)
                  And (T1.PerNum = T2.PerNum))
                 And (T2.TdiCve = :TdiCve)
                 And (T2.Perano = :PerAno)
                 And (T2.PerNum = :PerNum)
                 And (T2.DgeDoc = :DgeDoc)  ;

        // Si Existe en Gastos menores no deben subir
             If Status = *On ;
                Iter ;
             EndIf ;

        // Verifica Si es Cheque o Transferencia y que no este cancelado
         Status = *Off    ;

         If TdiTip < 3  ;
              Exec Sql
                Select '1' Into :Status
                  From CogCheh
                 Where (CheTdi = :TdiCve)
                   And (BanNch = :DgeDoc)
                   And (PerAno = :PerAno)
                   And (PerNum = :PerNum)
                   And (SitCve = '5')    ;

        // Si Existe como cancelado no debe tomarlo en Cuenta
             If Status = *On ;
                Iter ;
             EndIf ;

         EndIf ;

        SqlCod = *Zeros;

       // Verifica Si es una Factura de Cuentas por Pagar
         Status = *Off    ;

            Exec Sql
              Select '1' Into :Status
                From CxpDpeh
               Where (TdiCve = :TdiCve)
                 And (DgeDoc = :DgeDoc)
                 And (PerAno = :PerAno)
                 And (PerNum = :PerNum);

        // Si Existe en Cuentas por Pagar no Debe ser incluida
           If Status = *On ;
              Iter ;
           EndIf ;

        SqlCod = *Zeros;

        // Verifica Si es una Transaccion de Cuentas por Pagar
         Status = *Off    ;

            Exec Sql
              Select '1' Into :Status
                From CxpDped
               Where (TdiCve = :TdiCve)
                 And (DgeDoc = :DgeDoc)
                 And (PerAno = :PerAno)
                 And (PerNum = :PerNum) ;

        // Si Existe en Cuentas por Pagar no Debe ser incluida
           If Status = *On ;
              Iter ;
           EndIf ;

        SqlCod = *Zeros;

        // Verifica Documentos Cancelado en Cuentas por Pagar
         Status = *Off    ;

            Exec Sql
              Select '1' Into :Status
                From CxpCrdh
               Where (PerAno = :PerAno)
                 And (PerNum = :PerNum)
                 And (TdiCve = :TdiCve)
                 And (DgeDoc = :DgeDoc);

        // Si Fue cancelado en cuentas por Pagar no Debe ser incluida
           If Status = *On ;
              Iter ;
           EndIf ;

        SqlCod = *Zeros;

        // Verifica Transacciones de Cuentas por Pagar ND, NC y Pagos
         Status = *Off    ;

            Exec Sql
              Select '1' Into :Status
                From CxpTrah
               Where (TdiCve = :TdiCve)
                 And (DgeDoc = :DgeDoc)
                 And (PerAno = :PerAno)
                 And (PerNum = :PerNum) ;

        // Si Fue cancelado en cuentas por Pagar no Debe ser incluida
           If Status = *On ;
              Iter ;
           EndIf ;
        SqlCod = *Zeros;

        // Mover Fecha de Documento
           FecDoc = FecAmd  ;
           FDocum = FecDoc  ;
           DocFec = FecDoc  ;

        // Verifica que sea un Cheque o Transferencia para buscar Fecha
           FecPag = *Zeros  ;

           If TdiTip < 2  ;  // Es Cheque o Transferencia
              Exec Sql
                Select T9.FecYmd Into :FecPag
                  From CogCheh T1
                  Join SegFec T9
                    On (T1.CheAno = T9.FecAno)
                   And (T1.CheMes = T9.FecMes)
                   And (T1.CheDia = T9.FecDia)
                 Where (CheTdi = :TdiCve)
                   And (BanNch = :DgeDoc)
                   And (PerAno = :PerAno)
                   And (PerNum = :PerNum)
                   And (SitCve = '2')    ;

         EndIf ;

        SqlCod = *Zeros;

         If FecPag > *Zeros  ;
            FePago = FecPag  ;
            FpgCve = 2 ;   // Cheque o Transferencia
         Else ;
            FePago = *Zeros ;
            FpgCve = *Zeros ;
         EndIf;

        // Clasificacion de factura
            ClaFac = %Dec(%Subst(%Editc(CfaCve:'X'):3:2):2:0);

        //  Establecer la forma de pago a Entradas al Diario en General
          Select;
             When ClaFac = 7 And FpgCve = *Zeros ;
             FpgCve = 2 ;  // Cheque o Transferencia

             When ClaFac = 2 And FpgCve = *Zeros ;
             FpgCve = 1 ;  // Efectivo

             When ClaFac <> 2 And ClaFac <> 7 And FpgCve = *Zeros ;
             FpgCve = 4 ;  // Credito
          EndSl;

        // Mover Rnc o Cedula
          ProIde = DgeTid ;
          ProNid = DgeIde ;
          Exsr Mover_Campos ;

       // Numero Comprobante del Documento
         Ncf = NcfNro  ;
         Exsr MoverNcf ;
         NroNcf = Ncf  ;

       // Tipo de Comprobante
         TcfCve = NcfTip ;

       // Verifica si Existe el registro creado
         Status = *Off    ;
         DgiOri = 'CG'    ;

        Exec Sql
          Select '1' Into :Status
            From Dgiitd
           Where (DgiCar = :CodArc)
             And (DgiPer = :AnoNum)
             And (DgiOri = :DgiOri)
             And (NroIde = :NroIde)
             And (NroNcf = :NroNcf)
             And (DgiRea = 'M')    ;

        // Si Una Transaccion Manual no debe hacer Nada
           If Status = *On ;
              Iter ;
           EndIf ;
        SqlCod = *Zeros;

       // Impuesto Pagado
         ImpAde = DgeVid ;

       // Monto Facturado
         If RestaImpuesto = 'S'  ; // Empresas que no Adelantan
            MonFac = DgeVal - ImpAde  ;
            DgiMic = ImpAde ;

         // Monto de la transaccion sin el Impuesto
          Select;
            When DgiMfs <> *Zeros ;
            DgiMfs = DgiMfs - ImpAde  ;

            When DgiMfb <> *Zeros ;
            DgiMfb = DgiMfb - ImpAde  ;
          EndSl;

         Else;
            MonFac = DgeVal ;
         EndIf;

       // Impuesto Adelantado
         ImpRet = DgeVir ;

       // Impuesto ISR Retenido
         DgiDv1 = DgeVor ;

       // Verifica si Existe el registro creado
         Status = *Off    ;
         DgiOri = 'CG'    ;

        Exec Sql
          Select '1' Into :Status
            From Dgiitd
           Where (DgiCar = :CodArc)
             And (DgiPer = :AnoNum)
             And (DgiOri = :DgiOri)
             And (NroIde = :NroIde)
             And (NroNcf = :NroNcf)
             And (DgiRea = 'A')    ;

        SqlCod = *Zeros;

       // Actualizar o Crear El Registro

        If Status = *On   ;

          Exec Sql
           Update Dgiitd Set ImpAde = (ImpAde + :DgeVid),
                             DgiDv1 = (DgiDv1 + :DgeVor),
                             ImpRet = (ImpRet + :DgeVir),
                             MonFac = (MonFac + :DgeVal),
                             DgiMfs = (DgiMfs + :DgiMfs),
                             DgiMfb = (DgiMfb + :DgiMfb),
                             DgiIfs = (DgiIfs + :DgiIfs),
                             DgiIfb = (DgiIfb + :DgiIfb),
                             DgiMic = (DgiMic + :DgiMic),
                             DgiMip = (DgiMip + :DgiMip),
                             DgiMis = (DgiMis + :DgiMis),
                             DgiMio = (DgiMio + :DgiMio),
                             DgiMpl = (DgiMpl + :DgiMpl)
           Where (DgiCar = :CodArc)
             And (DgiPer = :AnoNum)
             And (DgiOri = :DgiOri)
             And (NroIde = :NroIde)
             And (NroNcf = :NroNcf)
             And (DgiRea = 'A')    ;
        Else ;

       // Campos Cabecera
          Total_Reg += 1  ;

          // Grabar Resgistro en Detalle
          DgiOri = 'CG' ;
          DgiRea = 'A'  ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitdf ;
        EndIf ;
          Clear Dgiitdf ;

         EndDo ;

          // Grabar Resgistro por Modulo

          DgiOri = 'CG' ;
          DgiPer = AnoNum ;
          DgiCar = CodArc ;
          Write Dgiitof ;

        Exec Sql
          Close c4;
        SqlCod = *Zeros;

        Endsr;
       // ----------------------------------------------------------
       // Calcular las Retenciones                                 -
       // ----------------------------------------------------------
         BegSr Cal_Retenido ;

         ValorItb = *Zeros ;
         ValorIsr = *Zeros ;
         TipTre = *Zeros;

          CalReten(ProCve :DpeDoc :MovCve :FecPag :ValorItb :ValorIsr
                   :TipTre);
         EndSr;
       // --------------------------------------------------------
       // Para Calcular las retenciones                          -
       // --------------------------------------------------------
        BegSr Retenciones ;

         ProDes_01 = *Zeros;
         ProDes_02 = *Zeros;
         Gis01 = 'N' ;
         Gis02 = 'N' ;
         Tig01 = 'N' ;
         Tig02 = 'N' ;
         Tre01 = *Zeros;
         Tre02 = *Zeros;
         TipTre = *Zeros;

         Valor_Ret01  = *Zeros ;
         Valor_Ret02  = *Zeros ;
         Valor_RetItb = *Zeros ;
         Valor_RetIsr = *Zeros ;

         Valor_Itb = *Zeros ;
         Valor_Isr = *Zeros ;

       // Buscar informaciones para poder hacer los calculos
           Exec Sql
             Select CriPre, CriGis, CriTig, TreCve
               Into :ProDes_01, :Gis01, :Tig01, :Tre01
               From CxpCri
              Where (CriCve = :CriCve)
         Fetch First 1 Rows Only       ;
         SqlCod = *Zeros ;

        If ProDes_01 <> *Zeros ;
           ProDes_01 = (Prodes_01 / 100);
        EndIf;

       // Buscar informaciones para poder hacer los calculos
           Exec Sql
             Select CriPre, CriGis, CriTig, TreCve
               Into :ProDes_02, :Gis02, :Tig02, :Tre02
               From CxpCri
              Where (CriCve = :CriCv2)
         Fetch First 1 Rows Only       ;
         SqlCod = *Zeros ;

        If ProDes_02 <> *Zeros ;
           ProDes_02 = (Prodes_02 / 100);
        EndIf;

        If Gis01 = 'S' ;
          Select;
            When Tig01 = 'M' ;
              Eval(Rh) Valor_Ret01 = DpeVbr * ProDes_01 ;
              Eval     Valor_Isr += Valor_Ret01    ;
              TipTre = Tre01;

            When Tig01 = 'I' And (DpeIm1 + DpeIm2) = DpeMif  ;
              Eval(Rh) Valor_Ret01 = (DpeIm1 + DpeIm2) * ProDes_01 ;
              Eval     Valor_Itb += Valor_Ret01 ;
              // TipTre = *Zeros ;

            When Tig01 = 'I' And (DpeIm1 + DpeIm1) <> DpeMif ;
              Eval(Rh) Valor_Ret01 = DpeMif * ProDes_01  ;
              Eval     Valor_Itb += Valor_Ret01 ;
              // TipTre = *Zeros ;
          EndSl;

        EndIf ;

        If Gis02 = 'S'  ;
          Select ;
            When Tig02 = 'M'   ;
              Eval(Rh) Valor_Ret02 = DpeVbr * ProDes_02  ;
              Eval     Valor_Isr += Valor_Ret02 ;
              TipTre = Tre02;

            When Tig02 = 'I' And (DpeIm1 + DpeIm2) = DpeMif ;
              Eval(Rh) Valor_Ret02 = (DpeIm1 + DpeIm2) * ProDes_02 ;
              Eval     Valor_Itb += Valor_Ret02   ;
              // TipTre = *Zeros;

            When Tig02 = 'I' And (DpeIm1 + DpeIm1) <> DpeMif ;
              Eval(Rh) Valor_Ret02 = DpeMif * ProDes_02   ;
              Eval     Valor_Itb += Valor_Ret02 ;
              // TipTre = *Zeros;
          EndSl ;
        EndIf ;

        Valor_RetItb = Valor_Itb ;
        Valor_RetIsr = Valor_Isr ;

       EndSr;
       // --------------------------------------------------------
       //  Verificar el Rnc o La Cedula                          -
       // --------------------------------------------------------
        BegSr Mover_Campos;

        NroIde = *Blanks;
        Rnc = *Zeros;
        Ced = *Zeros;

         Len = %Scan(' ':ProNid) ;

         If ProNid <> *Blanks ;

           For Log = 1 To Len ;
             If %Subst(ProNid:Log:1) < '0' ;
                ProNid = %Trim(%Subst(ProNid:1:Log - 1)) +
                         %Trim(%Subst(ProNid:Log + 1: Len - Log));
             EndIf;

           EndFor;

         Rnc = *Zeros;
         Select ;
            When ProIde = 'R' ;
                 TipIde = '1' ;
                 Rnc = %Dec(%Trim(%Subst(ProNid:1:9)):9:0)  ;

                 NroIde = %Editc(Rnc:'X') ;
        //                Evalr     NroIde = %Char(Rnc)

            When ProIde = 'C'  ;
                 TipIde = '2'  ;
                 Ced = %Dec(%Trim(%Subst(ProNid:1:11)):11:0)  ;
                 NroIde = %Editc(Ced:'X') ;

            When ProIde = 'P'  ;
                 TipIde = '3'  ;
                 Ced = %Dec(%Trim(%Subst(ProNid:1:11)):11:0)  ;
                 NroIde = %Editc(Ced:'X') ;
            EndSl;
         Else;

            TipIde = '2'  ;
            NroIde = %Editc(Ced:'X') ;

         EndIf;

       EndSr ;
       // ----------------------------------------------------------
       // Para Grabar el Registro Cabecera                         -
       // ----------------------------------------------------------
         BegSr Cabecera ;

         DgiPer = AnoNum ;

            Chain (CodArc :DgiPer) DgiiThf ;
            If %Found(DgiIth)    ;
                DgiCre = Total_Reg * 1   ;
                DgiMfa = Total_Monto * 1  ;
                DgiMif = Mon_Adelan * 1  ;
                DgiMip = Mon_Pagado * 1   ;
                DgiMir = Mon_Retenido * 1 ;
                Update DgiIthf    ;
            Else;
                DgiCar = CodArc ;
                DgiCre = Total_Reg * 1  ;
                DgiMfa = Total_Monto * 1  ;
                DgiMif = Mon_Adelan * 1   ;
                DgiMip = Mon_Pagado * 1   ;
                DgiMir = Mon_Retenido * 1 ;
                Write Dgiithf ;
            EndIf ;

        EndSr ;
        // ---------------------------------------------------------
        // Totalizar Archivo Cabecera                              -
        // ---------------------------------------------------------
         BegSr Totalizar ;

         Close Dgiith ;
         Close Dgiitd01 ;

          TotCabec(DgiCar :DgiPer);

          Open Dgiith  ;
          Open Dgiitd01  ;

         EndSr ;
        // ---------------------------------------------------------
        // Buscar la Forma de pago                                 -
        // ---------------------------------------------------------
         BegSr BuscarFpg ;

         MovTip = *Zeros ;

         Exec Sql
            Select T2.MovTip
              Into :MovTip
              From CxpDped T1
              Join CxpMov T2
                On (T1.DpeMot = T2.MovCve)
             Where (T2.MovTip In(1, 2, 3, 4))
               And (T1.ProCve = :ProCve)
               And (T1.MovCve = :MovCve)
               And (T1.DpeDoc = :DpeDoc)
         Fetch First 1 Rows Only       ;

          SqlCod = *Zeros;

          Select;
             When MovTip = 1 Or MovTip = 2 ;
             FpgCve = 2 ;   // Cheque o Transferencia

             When MovTip = 3  ;
             FpgCve = 1 ;   // Efectivo

             When MovTip = 4  ;
             FpgCve = 6 ;   // Nota de Credito

           Other ;
             FpgCve = 4 ;   // Credito
          EndSl;

         EndSr ;
        // ----------------------------------------------------------
        // Borrar Registros                                         -
        // ----------------------------------------------------------
        BegSr Borrar_reg;

        // Borrar detalle de transacciones
        Exec Sql
             Delete From Dgiitd
              Where (DgiCar = :CodArc)
                And (DgiPer = :AnoNum)
                And (DgiRea = 'A')
               With NC;

        // Borrar Detalle por Modulos
        Exec Sql
             Delete From Dgiito
              Where (DgiCar = :CodArc)
                And (DgiPer = :AnoNum)
               With NC;

        // Borrar Detalle por Modulos
        Exec Sql
             Delete From Dgiith
              Where (DgiCar = :CodArc)
                And (DgiPer = :AnoNum)
               With NC;
        EndSr;
       // ----------------------------------------------------------
       //  Convertir y Verificar el Numero de Comprobante          -
       // ----------------------------------------------------------
        BegSr MoverNCF;

       // Para Identificar la Logitud del Comprobante

           NcfSer = *BLanks                       ;
           NcfDiv = *Zeros                        ;
           NcfZon = *Zeros                        ;
           NcfCaj = *Zeros                        ;
           NcfTip = *Zeros                        ;
           NcfSec = *Zeros                        ;

         NcfSer = %Subst(Ncf:1:1)                 ;
 ''
 ''    Select                                     ;
         When NcfSer = 'A'  ;
 ''        NcfDiv = %Dec(%Subst(Ncf:2:2):2:0)     ;
 ''        NcfZon = %Dec(%Subst(Ncf:4:3):3:0)     ;
 ''        NcfCaj = %Dec(%Subst(Ncf:7:3):3:0)     ;
 ''        NcfTip = %Dec(%Subst(Ncf:10:2):2:0)    ;
 ''        SecNcf = %Dec(%Subst(Ncf:12:8):8:0)    ;
 ''
 ''         Ncf = %Trim(NcfSer) +
 ''               %Trim(%Editc(NcfDiv:'X')) +
 ''               %Trim(%Editc(NcfZon:'X')) +
 ''               %Trim(%Editc(NcfCaj:'X')) +
 ''               %Trim(%Editc(NcfTip:'X')) +
 ''               %Trim(%Editc(Sec08:'X'))                         ;
 ''
         When NcfSer = 'B'  ;
 ''        NcfTip = %Dec(%Subst(Ncf:2:2):2:0)     ;
 ''        SecNcf = %Dec(%Subst(Ncf:4:8):8:0)     ;
 ''        NcfDiv = *Zeros                        ;
 ''        NcfZon = *Zeros                        ;
 ''        NcfCaj = *Zeros                        ;
 ''
 ''         Ncf = %Trim(NcfSer) +
 ''               %Trim(%Editc(NcfTip:'X')) +
 ''               %Trim(%Editc(Sec08:'X'))                         ;
 ''
         When NcfSer = 'E'  ;
 ''        NcfTip = %Dec(%Subst(Ncf:2:2):2:0)     ;
 ''        SecNcf = %Dec(%Subst(Ncf:4:13):10:0)     ;
 ''        NcfDiv = *Zeros                        ;
 ''        NcfZon = *Zeros                        ;
 ''        NcfCaj = *Zeros                        ;
 ''
 ''         Ncf = %Trim(NcfSer) +
 ''               %Trim(%Editc(NcfTip:'X')) +
 ''               %Trim(%Editc(Sec10:'X'))                         ;
 ''     Other                                     ;
 ''        Ncf = *Blanks                          ;
 ''
 ''    Endsl ;
       EndSr;
        //------------------------------------------------------
        // Parametros del sistema                              -
        //------------------------------------------------------
        BegSr Parametros;

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

         CodArc = %Dec(CodCar:3:0);
         FechaD = %Dec(FechaDesde:8:0);
         FechaH = %Dec(FechaHasta:8:0);

         FechaIso = %Date(FechaH:*Iso);
         AnoPer = %Subdt(FechaIso:*Years); // Extrct
         NumPer = %Subdt(FechaIso:*Months);

         DgiPer = AnoNum;

       // Buscar codigo de movimiento Cks cancelados luego de ser aplicados
         CodParam = 0007;
         Exsr Parametros;
         CodCheque = ValorNum * 1 ;

       // Idenf. si Resta impuesto adelantado en los registros de Contabilida d
         Sistema = 'DG';
         CodParam = 0001;
         Exsr Parametros ;
         Eval RestaImpuesto = %Trim(ValorAlf) ;

       EndSr;
      /End-Free
       // ----------------------------------------------------------
