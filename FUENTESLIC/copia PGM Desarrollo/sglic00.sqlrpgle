     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SGLIC00                          *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 28 / 01 / 2026                   *
      *  DESCR:                                                          *
      *     Validar Licencia                                             *
      *  ================================================================*
      *  MODIFICACIONES:                                                 *
      *  ---------------                                                 *
      *  FECHA        AUTOR            DESCRIPCION                       *
      *  -----------  ---------------  --------------------------------- *
      *  (optimiz.)   IBM Bob          Reemplazar FOR+SQL por WITH       *
      *               (asistente)      RECURSIVE para calcular hash      *
      *               eliminando hasta 128 llamadas SQL por ejecucion.   *
      *  ================================================================*
      *
     * Campos Usado en el programa
     d BaseStr         s            128a   Inz(*Blanks)
     d Suma            s              9  0 Inz(*Zeros)
     d LicKey          s            128a   Inz(*Blanks)
     d Status          s               n   Inz(*Off)
      *
     d NSerial         s             10A
     d NModel          s              8A
     d ProcType        s              8A
     d HostName        s             25A
     d*CtlCve          s              9  0
     d FecIni          s              5A
     d FecFin          s              5A
     d TiempoD         s              7  0
      *
     d CiaNom          s                   Like(SqlSegCia.CiaNom)
     d CiaRnc          s                   Like(SqlSegCia.CiaRnc)
     d Abrevi          s             25a   Inz(*Blanks)
      *
     d FechaDiaIso     s                   Like(SqlSegFec.FecIso)
     d FechaDia        s                   Like(SqlSegFec.FecJul)
     d FechaCrj        s                   Like(SqlSegFec.FecJul)
     d FechaExj        s                   Like(SqlSegFec.FecJul)
     d FechaExjIso     s                   Like(SqlSegFec.FecIso)
     * Tablas Definidas Externamente
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
     d SqlSegCtl     e Ds                  ExtName(SegCtl) Qualified
     d SqlSegLic     e Ds                  ExtName(SegLic) Qualified
     d SqlSegCia     e Ds                  ExtName(SegCia) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
     * SGLIC00 Prototype
     d SGLIC00         Pr
     d InpCtlSrl                      8
     d InpCtlMod                      4
     d InpCtlPty                      4
     d InpHostna                      8
     d InpFecPro                      5
     d InpTiempo                      9
     d InpCtlSta                      1
      *
     * SGLIC00 Program Interface
     d SGLIC00         Pi
     d InpCtlSrl                      8
     d InpCtlMod                      4
     d InpCtlPty                      4
     d InpHostna                      8
     d InpFecPro                      5
     d InpTiempo                      9
     d InpCtlSta                      1
      *
      * Main Program
      *
      /Free

        // ------------------------------------------------------
        // Main Process
        // ------------------------------------------------------
        Exsr Proceso ;
        Exsr EndProgram;
        // ------------------------------------------------------
        // Imprimir Reporte
        // ------------------------------------------------------
        Begsr Proceso            ;

      //Verificar la vigencia del Periodo de Prueba
              TiempoD = *Zeros  ;

              If FechaDia > SqlSegCtl.CtlFtc  ;
                  FechaDiaIso = FechaDia ;
                  FechaExjIso = SqlSegCtl.CtlFtc  ;
                  TiempoD = %Diff(FechaDiaIso: FechaExjIso: *Days);
                  InpCtlSta = '2'      ;          //Periodo de Prueba
                  InpTiempo = %Trim(%Editc(TiempoD:'1'))  ;
               LeaveSr ;
             EndIf   ;

      //Buscar Datos de la empresa
          Clear CiaNom ;
          Clear CiaRnc ;

          Exec Sql
             Select CiaNom, CiaRnc
               Into :CiaNom,
                    :CiaRnc
               From SegCia
              Where (CiaCve <> 'SG')
              Order By CiaCve
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;
          Abrevi = *Blanks     ;

            For i = 1 to 10 By 2;
               Abrevi = %Trim(Abrevi) + %Trim(%Subst(CiaNom:i:1));
            EndFor;

           Abrevi = %Trim(Abrevi) + %Trim(CiaRnc)  ;
           FecIni = %Editc(%Dec(SqlSegCtl.CtlFic):'X')  ;
           FecFin = %Editc(%Dec(SqlSegCtl.CtlFtc):'X')  ;

      //1. Construir cadena base

           BaseStr = %Trim(Abrevi) +
                     %Trim(NSerial) +
                     %Trim(NModel)  +
                     %Trim(ProcType)   +
                     %Trim(HostName)  +
                     %Trim(FecIni) +
                     %Trim(FecFin) +
                     %Trim(%Editc((SqlSegCtl.CtlMus):'X'))  ;

      //2. Hash: Suma de ASCII mediante CTE recursiva (compatible IBM i 7.1+)
      //   Sustituye el FOR con SELECT individual por caracter (hasta 128 SQLs)
      //   por una sola consulta que genera la secuencia internamente.

           Exec Sql
              With Nums(N) As (
                Select 1 From SysIbm.SysDummy1
                Union All
                Select N + 1 From Nums
                 Where N < Length(Trim(:BaseStr))
              )
              Select Sum(Ascii(Substr(:BaseStr, N, 1)))
                Into :Suma
                From Nums                              ;
           SqlCod = *Zeros ;

           Suma = %Rem(Suma:999999)         ;

      //3. Construir LICKEY
           LicKey = %Trim(BaseStr) + %Char(Suma);

      //Buscar la licencia
          Status = *Off   ;

          Exec Sql
             Select '1'
               Into :Status
               From SegLic
              Where (LicCve = :LicKey)
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

      //Validar si la Licencia es Valida o No
           Select ;
             When Status = *Off        ;          //Licencia No Valida
                  InpCtlSta = '1'      ;
                  LeaveSr ;

             When Status = *On         ;          //Licencia Valida
                  InpCtlSta = *Blanks  ;
           EndSl  ;

      //Actualizar fecha ultima Verificacion

          Exec Sql
           Update SegCtl Set CtlFuv = Current Timestamp
              Where (CtlSrl = :NSerial)
                And (CtlMod = :NModel)
                And (CtlPty = :ProcType)
                And (CtlHtn = :HostName) ;

          SqlCod = *Zeros ;

        Endsr;
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

      //Recibir Patametros
           NSerial = %Trim(InpCtlSrl)        ;
           NModel = %Trim(InpCtlMod)         ;
           ProcType = %Trim(InpCtlPty)      ;
           HostName = %Trim(InpHostna)      ;
           FechaDia = %Date(%Dec(InpFecPro:5:0):*Jul)  ;

      //Buscar Informaciones del Servidor
        //  Exec Sql
        //    Select Host_Name
        //      Into :HostName
        //      From Qsys2.SysTem_Status_Info  ;

      //Buscar Datos Control de Licencia
          Clear SqlSegCtl ;

          Exec Sql
             Select *
               Into :SqlSegCtl
               From SegCtl
              Where (CtlSrl = :NSerial)
                And (CtlMod = :NModel)
                And (CtlPty = :ProcType)
                And (CtlHtn = :HostName)
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

        EndSr;
      /End-Free
       // ----------------------------------------------------------
