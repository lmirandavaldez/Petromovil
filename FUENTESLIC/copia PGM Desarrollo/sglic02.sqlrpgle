     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SGLIC02                          *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 21 / 01 / 2026                   *
      *  DESCR:                                                          *
      *     Generador de Licencias                                       *
      *  ================================================================*
      *  MODIFICACIONES:                                                 *
      *  ---------------                                                 *
      *  FECHA        AUTOR            DESCRIPCION                       *
      *  -----------  ---------------  --------------------------------- *
      *  (optimiz.)   IBM Bob          Reemplazar FOR+SQL por WITH       *
      *               (asistente)      RECURSIVE para calcular hash      *
      *               eliminando hasta 128 llamadas SQL por ejecucion.   *
      *  ================================================================*
     d BaseStr         s            128a   Inz(*Blanks)
     d Suma            s              9  0 Inz(*Zeros)
     d LicKey          s            128a   Inz(*Blanks)
      *
     d NSerial         s             10A
     d NModel          s              8A
     d ProcType        s              8A
     d HostName        s             25A
     d CtlCve          s              9  0
     d FecIni          s              5A
     d FecFin          s              5A
     d MaxUsr          s              5  0
      *
     d FechaCrt        s                   Like(SqlSegFec.FecYmd)
     d FechaCrj        s                   Like(SqlSegFec.FecJul)
     d FechaExp        s                   Like(SqlSegFec.FecYmd)
     d FechaExj        s                   Like(SqlSegFec.FecJul)
      * Archivos Definidos Externamente
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **SGLIC02 Prototype
     d SGLIC02         Pr
     d InpNSerial                    10
     d InpNModel                      8
     d InpProcType                    8
     d InpHostName                    8
     d InpCrtDate                     8
     d InpExpDate                     8
     d InpAbrev                      25
     d InpMaxUsr                      5
      *
      **SGLIC02 Program Interface
     d SGLIC02         Pi
     d InpNSerial                    10
     d InpNModel                      8
     d InpProcType                    8
     d InpHostName                    8
     d InpCrtDate                     8
     d InpExpDate                     8
     d InpAbrev                      25
     d InpMaxUsr                      5
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

       //1. Construir cadena base

           BaseStr = %Trim(InpAbrev) +
                     %Trim(NSerial) +
                     %Trim(NModel)  +
                     %Trim(ProcType)   +
                     %Trim(HostName)  +
                     %Trim(FecIni) +
                     %Trim(FecFin) +
                     %Trim(InpMaxUsr)  ;

       //2. Hash: Suma de ASCII mediante CTE recursiva (compatible IBM i 7.1+)
       // Sustituye el FOR con SELECT individual por caracter (hasta 128 SQLs)
       // por una sola consulta que genera la secuencia internamente.

           Exec Sql
              With Nums(N) As (
                Select 1 From SysIbm.SysDummy1
                Union All
                Select N + 1 From Nums
                 Where N < Length(Trim(:BaseStr)))
              Select Sum(Ascii(Substr(:BaseStr, N, 1)))
                Into :Suma
                From Nums                              ;
           SqlCod = *Zeros ;

           Suma = %Rem(Suma:999999)         ;

       //3. Construir LICKEY
           LicKey = %Trim(BaseStr) + %Char(Suma);

       //4. Hash sobre Abreviatura: CTE recursiva (1 SQL en lugar de N SQLs)
           Suma = *Zeros  ;
           Exec Sql
              With Nums(N) As (
                Select 1 From SysIbm.SysDummy1
                Union All
                Select N + 1 From Nums
                 Where N < Length(Trim(:InpAbrev)))
              Select Sum(Ascii(Substr(:InpAbrev, N, 1)))
                Into :Suma
                From Nums                              ;
           SqlCod = *Zeros ;

           Suma = %Rem(Suma:999999)         ;

       //Grabar en Tabla de Control
           FechaCrj = %Date(FechaCrt:*Iso);
           FechaExj = %Date(FechaExp:*Iso);
           CtlCve = Suma ;

           Exec sql
              Insert Into SegCtl (
                   CtlSrl,
                   CtlMod,
                   CtlPty,
                   CtlHtn,
                   CtlAbr,
                   CtlCve,
                   CtlFic,
                   CtlFtc,
                   CtlMus,
                   CtlFcr,
                   CtlFuv
              )
              Select
                     :nSerial,
                     :nModel,
                     :ProcType,
                     :HostName,
                     :InpAbrev,
                     :CtlCve,
                     :FechaCrj,
                     :FechaExj,
                     :InpMaxUsr,
                     Current Timestamp,
                     Current Timestamp
                   From Sysibm.Sysdummy1
                   Where Not Exists (
                        Select 1
                          From SegCtl
                         Where CtlSrl = :nSerial
                           And CtlHtn = :HostName
                   );

       //Grabar en Tabla de Licencia
           Exec sql
              Insert Into SegLic (
                   LicCve
              )
              Select
                   :LicKey
                From Sysibm.Sysdummy1
               Where Not Exists (
                   Select 1
                     From SegLic
                    Where LicCve = :LicKey
                   );
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

           NSerial = %Trim(InpNSerial)      ;
           NModel  = %Trim(InpNModel)       ;
           ProcType = %Trim(InpProcType)    ;
           HostName = %Trim(InpHostName)    ;

           FechaCrt = %Dec(InPCrtDate:8:0)  ;
           FechaCrj = %Date(FechaCrt:*Iso)  ;
           FechaExp = %Dec(InPexpDate:8:0)  ;
           FechaExj = %Date(FechaExp:*Iso)  ;
           FecIni = %Editc(%Dec(FechaCrj):'X')  ;
           FecFin = %Editc(%Dec(FechaExj):'X')  ;
           MaxUsr = %Dec(InPMaxUsr:5:0)  ;

       //Buscar Informaciones del Servidor
        //  Exec Sql
        //    Select
        //        Max(Case When SysValName = 'QSRLNBR'  Then CurcharVal End),
        //        Max(Case When SysValName = 'QMODEL'   Then Curcharval End),
        //        Max(Case When SysValName = 'QPRCFEAT' Then Curcharval End),
        //        B.Host_Name
        //      Into :NSerial, :NModel, :ProcType, :HostName
        //      From Qsys2.SysTem_Value_Info A, Qsys2.SysTem_Status_Info B
        //     Where A.SysValName IN ('QSRLNBR', 'QMODEL', 'QPRCFEAT')
        //     Group By B.Host_Name ;

        //     Nserial = %Trim(Nserial)   ;
        //     NModel = %Trim(NModel)     ;
        //     ProcType = %Trim(ProcType) ;
        //     HostName = %Trim(HostName) ;

        EndSr;
      /End-Free
       // ----------------------------------------------------------
