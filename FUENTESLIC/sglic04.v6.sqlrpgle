     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SGLIC01                          *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 21 / 01 / 2026                   *
      *  DESCR:                                                          *
      *     Generador de Licencias                                       *
      *  ================================================================*
     d BaseStr         s            128a   Inz(*Blanks)
     d Suma            s              9  0 Inz(*Zeros)
     d Char            s              1a   Inz(*Blanks)
     d AscVal          s              3  0 Inz(*Zeros)
     d LicKey          s            128a   Inz(*Blanks)
     d CodigoAscii     s             10I 0
      *
     d NSerial         s             10A
     d NModel          s              8A
     d ProcType        s              8A
     d HostName        s             25A
     d Comments        s             50A
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
      **SGLIC01 Prototype
     d SGLIC01         Pr
     d InpCrtDate                     8
     d InpExpDate                     8
     d InpAbrev                      25
     d InpMaxUsr                      5
      *
      **SGLIC01 Program Interface
     d SGLIC01         Pi
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
        //----

       //1. Construir cadena base

           BaseStr = %Trim(InpAbrev) +
                     %Trim(NSerial) +
                     %Trim(NModel)  +
                     %Trim(ProcType)   +
                     %Trim(HostName)  +
                     %Trim(FecIni) +
                     %Trim(FecFin) +
                     %Trim(InpMaxUsr)  ;

       //2. Función simple de "hash" Suma de códigos + Mod para reducir tamaño

           For i = 1 to %Len(%Trim(BaseStr));
              Char = %Subst(BaseStr:i:1);

           // Obtener ASCII mediante SQL
                 Exec Sql
                      Select Ascii(:Char)
                        Into :CodigoAscii
                      From SysIbm.SysDummy1;

              Suma += CodigoAscii ;
           EndFor;

           Suma = %Rem(Suma:999999)         ;

       //3. Construir LICKEY
           LicKey = %Trim(BaseStr) + %Char(Suma);

       //Grabar en SegCtl
        // CrtDJul     = %Date(FechaCrt:*Iso);
        // ExpDjul     = %Date(FechaExp:*Iso);
           Comments    = %Trim('Generada Automaticamente') ;

           Exec sql
              Insert Into SegCtl (
                   CTLCVE,
                   CTLMUS,
                   CTLFCR,
                   CTLFUV,
                   CTLCOM
              )
              Select
                     :LicKey,
                     :MaxUsr,
                     Current Timestamp,
                     Current Timestamp,
                     :COMMENTS
                   From Sysibm.Sysdummy1
                   Where Not Exists (
                        Select 1
                          From SegCtl
                         Where CtlCve = :LicKey
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

           FechaCrt = %Dec(InPCrtDate:8:0)  ;
           FechaCrj = %Date(FechaCrt:*Iso)  ;
           FechaExp = %Dec(InPexpDate:8:0)  ;
           FechaExj = %Date(FechaExp:*Iso)  ;
           FecIni = %Editc(%Dec(FechaCrj):'X')  ;
           FecFin = %Editc(%Dec(FechaExj):'X')  ;
           MaxUsr = %Dec(InPMaxUsr:5:0)  ;

       //Buscar Informaciones del Servidor
            Exec Sql
              Select
                  Max(Case When SysValName = 'QSRLNBR'  Then CurcharVal End),
                  Max(Case When SysValName = 'QMODEL'   Then Curcharval End),
                  Max(Case When SysValName = 'QPRCFEAT' Then Curcharval End),
                  B.Host_Name
                Into :NSerial, :NModel, :ProcType, :HostName
                From Qsys2.SysTem_Value_Info A, Qsys2.SysTem_Status_Info B
               Where A.SysValName IN ('QSRLNBR', 'QMODEL', 'QPRCFEAT')
               Group By B.Host_Name ;

        EndSr;
      /End-Free
       // ----------------------------------------------------------
