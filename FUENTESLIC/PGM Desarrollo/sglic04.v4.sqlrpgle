     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SGLIC05                          *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 21 / 01 / 2026                   *
      *  DESCR:                                                          *
      *     Generador de Licencias                                       *
      *  ================================================================*
     fSegCtl    Uf a e           k Disk
      *
     d BaseStr         s             50a   Inz(*Blanks)
     d Suma            s              9  0 Inz(*Zeros)
     d Char            s              1a   Inz(*Blanks)
     d AscVal          s              3  0 Inz(*Zeros)
     d LicKey          s             64a   Inz(*Blanks)
     d CodigoAscii     s             10I 0
      *
     d Serial          s             10a
     d Model           s              8a
     d Srcp            s              8a
     d HostN           s             10a
      *
     d FechaCrt        s                   Like(SqlSegFec.FecYmd)
     d FechaExp        s                   Like(SqlSegFec.FecYmd)
      * Archivos Definidos Externamente
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **SGLIC05 Prototype
     d SGLIC05         Pr
     d InPSerial                     10
     d InPModel                       8
     d InPSrcP                        8
     d InpHostn                      15
     d InpCrtDate                     8
     d InpExpDate                     8
      *
      **SGLIC05 Program Interface
     d SGLIC05         Pi
     d InPSerial                     10
     d InPModel                       8
     d InPSrcP                        8
     d InpHostn                      15
     d InpCrtDate                     8
     d InpExpDate                     8
      *
      * Main Program
      *
      /Free

        // ------------------------------------------------------
        // Main Process
        // ------------------------------------------------------
        Exsr Initial ;
        Exsr Proceso ;
        Exsr EndProgram;
        // ------------------------------------------------------
        // Process Subroutine
        // ------------------------------------------------------
        Begsr Initial;

        Endsr;
        // ------------------------------------------------------
        // Imprimir Reporte
        // ------------------------------------------------------
        Begsr Proceso            ;
        //----

       //1. Construir cadena base

           BaseStr = %Trim(InpSerial) +
                     %Trim(InpModel)  +
                     %Trim(InpSrcp)   +
                     %Trim(InpHostn)  +
                     %Trim(InpCrtDate) +
                     %Trim(InpExpDate)            ;

       //2. Función simple de "hash" (ejemplo básico)
       //SUMA de códigos + MOD para reducir tamaño

           For i = 1 to %Len(%Trim(baseStr));
              Char = %Subst(baseStr:i:1);

              // Convertir el carácter a byte y luego a entero
              // Obtener ASCII mediante SQL
                 Exec Sql
                      Select Ascii(:Char)
                        Into :CodigoAscii
                      From SysIbm.SysDummy1;

              Suma += CodigoAscii ;
           EndFor;

           Suma = %REM(Suma:999999)         ;

       //3. Construir LICKEY (por ejemplo: BASE + '-' + número)
           licKey = %trim(baseStr) + '-' + %Char(suma);

       //Grabar en LICCTL
           SERIAL      = %Trim(INPSERIAL);
           MODEL       = %Trim(INPMODEL);
           TipPro      = %Trim(InPSrcP);
           HotNme      = %Trim(InpHostn);
           LICKEY      = licKey;
           crtDaTE     = %Date(FechaCrt:*Iso);
           EXPDATE     = %Date(FechaExp:*Iso);
           MAXUSERS    = 0;
           LASTCHECK   = %TimeStamp();
           COMMENTS    = 'Generada manualmente'    ;

           Write SegCtlr      ;
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
           FechaExp = %Dec(InPexpDate:8:0)  ;

       EndSr;
      /End-Free
       // ----------------------------------------------------------
