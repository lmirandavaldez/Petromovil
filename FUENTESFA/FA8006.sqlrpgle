     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  Nombre del programa .........: FA8006                           *
      *  Aplicacion...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 12 / 02 / 2026                   *
      *  Descripcion:                                                    *
      *         Asginar Carga Inicial de Comprobante por Fichas          *
      *  ================================================================*
      *
      * Campos Usados en el Programa
     d Existe          s               n   Inz(*Off)
      * Campos Uso Parametros de Entrada
     d PlaDis          s                   Like(SqlFacPlah.PlaDis)
     d PlaNro          s                   Like(SqlFacPlah.PlaNro)
     d PlaFpl          s                   Like(SqlFacPlah.PlaFpl)
     d VehFic          s                   Like(SqlFacPlah.VehFic)
      * Parametros
     d Sistema         s              2    Inz('FA')
     d CodParametro    s              4  0 Inz(*Zeros)
     d ValorNum        s             30 15 Inz(*Zeros)
     d ValorAlf        s            100    Inz(*Blanks)
      *
      * Campos de Parametros Generales
     d ModuloFa        s              2  0 Inz(*Zeros)
     d ModuloNc        s              2  0 Inz(*Zeros)
     d SerieVig        s              1    Inz(*Blanks)
     d CantAsig        s             10  0 Inz(*Zeros )
      *
      * Campos que Son Enviados Como Parametros
     d NumNcf          s                   Like(SqlFacDed.NcfNro)
     d FechaFacIso     s                   Like(SqlSegFec.FecIso)
     d FechaFinNcf     s                   Like(SqlSegFec.FecIso)
     d TipProNcf       s              1    Inz('E')
     d StatusNcf       s               n   Inz(*Off)
      *
      * Campos Intermedios
     d TcfCve          s                   Like(SqlSegNcf.TcfCve)
     d CanNcf          s                   Like(SqlSegNcf.NcfSec)
     d Cont            s                   Like(SqlSegNcf.NcfSec)
     d MonCve          S                   Like(SqlSegNcf.MonCve)
     d McfCve          S                   Like(SqlSegNcf.McfCve)
     d ScpIni          S                   Like(SqlSegNcf.NcfIni)
     d ScpFin          S                   Like(SqlSegNcf.NcfFin)
     d ScpSer          S                   Like(SqlFacScp.ScpSer)
     d ScpFfp          S                   Like(SqlFacScp.ScpFfp)
     d TcfTco          s                   Like(SqlSegRcs.RcsTco)
     d TcfTcd          s                   Like(SqlSegRcs.RcsTcd)
     d SerNcf          s                   Like(SqlFacScp.ScpSer)
     d FecTra          s                   Like(SqlSegNcf.NcfFip)
      *
      * Campos que Son Enviados Como Parametros
      *
      **Archivos Externos
     d SqlSegNcf     e Ds                  ExtName(SegNcf) Qualified
     d SqlFacVeh     e Ds                  ExtName(FacVeh) Qualified
     d SqlFacPlah    e Ds                  ExtName(FacPlah) Qualified
     d SqlFacScp     e Ds                  ExtName(FacScp) Qualified
     d SqlFacDed     e Ds                  ExtName(FacDed) Qualified
     d SqlSegRcs     e Ds                  ExtName(SegRcs) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Buscar Parametros Generales
     d ParametrosGen   Pr                  ExtPgm('SG7009')
     d  Sistema_1                          Like(Sistema)
     d  Parametro_1                        Like(CodParametro)
     d  ValorNum_1                         Like(ValorNum)
     d  ValorAlf_1                         Like(ValorAlf)
      * Buscar los Tipos de Comprobantes Segun la Serie
     d TipoComproban   Pr                  ExtPgm('SG7012')
     d  FecTra_1                           Like(FecTra)
     d  TcfTco_1                           Like(TcfTco)
     d  TcfTcd_1                           Like(TcfTcd)
      *
      * Buscar Comprobantes
     d BuscarComp      Pr                  ExtPgm('SG7018')
     d  McfCve_1                           Like(SqlSegNcf.McfCve)
     d  DisCve_1                           Like(SqlSegNcf.DisCve)
     d  MonCve_1                           Like(SqlSegNcf.MonCve)
     d  TipProNcf_1                        Like(TipProNcf)
     d  TcfCve_1                           Like(SqlSegNcf.TcfCve)
     d  CanNcf_1                           Like(SqlSegNcf.NcfSec)
     d  FechaFacIso_1                      Like(SqlSegFec.FecIso)
     d  SerNcf_1                           Like(SqlFacScp.ScpSer)
     d  ScpIni_1                           Like(SqlSegNcf.NcfIni)
     d  ScpFin_1                           Like(SqlSegNcf.NcfFin)
     d  FechaFinNcf_1                      Like(SqlSegFec.FecIso)
     d  StatusNcf_1                        Like(StatusNcf)
      *
      **FA8006  Prototype
     d FA8006          Pr
     d  FichaV                             Like(SqlFacPlah.VehFic)
      *
      **FA8006C Program Interface
     d FA8006          Pi
     d  FichaV                             Like(SqlFacPlah.VehFic)
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
           Exsr Proceso ;
           Exsr EndProgram;
        // ------------------------------------------------------
        // Seleccionar Tipo de Comprobantes Usados              -
        // ------------------------------------------------------
           BegSr Proceso;

        // Leer Archivo
           Exec Sql
              Declare C1 cursor for
              Select *
                From SegNcf
               Where (McfCve In(:ModuloFa, :ModuloNc))
                 And (NcfSer = :SerieVig)
                 And (NcfSta = ' ')
                 And (TcfCve Not In(46))
            Order By McfCve, NcfTip, NcfFip
            For Read Only ;

           Exec Sql
             Open c1;

           Dow True;

            Exec Sql
              Fetch Next From c1 Into :SqlSegNcf                      ;

            If SqlCod <> *Zeros;
              Leave;
            Endif;

        //Buscar las fichas a las que le asginaremos los comprobantes
           Exsr Procesos_Fichas ;

           EndDo ;

           Exec Sql
              Close c1;

           SqlCod = *Zeros;

           Endsr;
        // ------------------------------------------------------
        // Seleccionar las Fechas que asignamos secuencia       -
        // ------------------------------------------------------
           BegSr Procesos_Fichas ;

        // Leer Archivo
           Exec Sql
              Declare C2 cursor for
              Select VehFic
                From FacVeh
               Where (VehFic = :FichaV Or :FichaV = ' ')
                 And (VehOri = 'P')
                 And (VehSta = 'A')
                 And (VehTip In(1, 2))
            Order By VehFic
            For Read Only ;

           Exec Sql
             Open c2;

           Dow True;

            Exec Sql
              Fetch Next From c2 Into :VehFic                         ;

            If SqlCod <> *Zeros;
              Leave;
            Endif;

        //Asignar Datos Fijos Para Carga Inicial
           PlaDis = *HiVal ;
           PlaNro = *Hival ;
           PlaFpl = %Dec(%Date(*Date):*Iso)  ;

        //Buscar el tipo de comprobante que corresponde segun la serie activa
           TcfCve = SqlSegNcf.TcfCve                    ;
           TcfTco = SqlSegNcf.TcfCve                    ;
           TcfTcd = *Zeros                              ;
           FecTra = %Date(PlaFpl:*Iso)                  ;

           TipoComproban(FecTra :TcfTco :TcfTcd)        ;

        //Si el Tipo de Comprobante es diferente debe cambiarse
           If TcfTcd <> TcfCve         ;
              TcfCve = TcfTcd          ;
            EndIf                      ;

       //Verifica Que No Exista
           Existe = *Off    ;
           Exec Sql
             Select '1' Into :Existe
               From FacScp
              Where (PlaDis = :PlaDis)
                And (PlaNro = :PlaNro)
                And (PlaFpl = :PlaFpl)
                And (VehFic = :VehFic)
                And (ScpTcf = :TcfCve)
           Fetch First 1 Rows Only       ;

           SqlCod = *Zeros;

           If Existe = *On ;
              Iter;
            EndIf ;

           McfCve = SqlSegNcf.McfCve               ;
           MonCve = *Zeros                         ;
           CanNcf = CantAsig                       ;
           FechaFacIso = %Date(PlaFpl:*Iso)        ;
           ScpIni = *Zeros                         ;
           ScpFin = *Zeros                         ;

       //Llamar Programa Buscar Comprobantes
           BuscarComp(McfCve :PlaDis :MonCve :TipProNcf :TcfCve :CanNcf
                      :FechaFacIso :SerNcf :ScpIni :ScpFin :FechaFinNcf
                      :StatusNcf)      ;

           ScpFfp = FechaFinNcf       ;
           ScpSer = SerNcf            ;

       //Grabar en Tabla de Control
           Exec sql
              Insert Into FacScp (
                   PlaDis,
                   PlaNro,
                   PlaFpl,
                   VehFic,
                   ScpTcf,
                   ScpSer,
                   ScpIni,
                   ScpFin,
                   ScpCan,
                   ScpFfp,
                   ScpTst)
              Select
                     :PlaDis,
                     :PlaNro,
                     :PlaFpl,
                     :VehFic,
                     :TcfCve,
                     :ScpSer,
                     :ScpIni,
                     :ScpFin,
                     :CanNcf,
                     :ScpFfp,
                     Current Timestamp
                   From Sysibm.Sysdummy1
                   Where Not Exists (
                        Select 1
                          From FacScp
                         Where (PlaDis = :PlaDis)
                           And (PlaNro = :PlaNro)
                           And (PlaFpl = :PlaFpl)
                           And (VehFic = :VehFic)
                           And (ScpTcf = :TcfCve));

           SqlCod = *Zeros;

           EndDo ;

           Exec Sql
              Close c2;

           SqlCod = *Zeros;

           Endsr;
        // -----------------------------------------------------
        // Parametros del sistema                              -
        // -----------------------------------------------------
           Begsr Parametros  ;

           ParametrosGen(Sistema :CodParametro :ValorNum :ValorAlf)     ;

           Endsr;
        // -----------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
           Begsr EndProgram;

           *Inlr = *On;
           Return;

           Endsr;
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
           BegSr *Inzsr;

        //Módulo Comprobante Fiscal Facturas
           CodParametro = 1000   ;
           Exsr Parametros ;
           ModuloFa = ValorNum   ;

        //Módulo Comprobante Fiscal Notas Credito
           CodParametro = 1001   ;
           Exsr Parametros ;
           ModuloNc = ValorNum   ;

        //Serie de comprobante vigente
           CodParametro = 1002   ;
           Exsr Parametros ;
           SerieVig = %Trim(ValorAlf)          ;

        //Cantidad de Comprobante Carga Inicial
           CodParametro = 1003   ;
           Exsr Parametros ;
           CantAsig = ValorNum   ;

           EndSr;
      /End-Free
       // ----------------------------------------------------------
