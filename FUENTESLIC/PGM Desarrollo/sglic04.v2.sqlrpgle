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
     d Byte1           s              1a   Inz(x'00')
     d BaseStr         s             50a   Inz(*Blanks)
     d Suma            s              9  0 Inz(*Zeros)
     d Char            s              1a   Inz(*Blanks)
     d AscVal          s              3  0 Inz(*Zeros)
     d LicKey          s             64a   Inz(*Blanks)
      *
     d FechaIso        s               D   DatFmt(*Iso)
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
     d AppId                         10
     d InpSerial                     10
     d InpModel                       8
     d InPpart                       10
     d InpexpDate                     8
     d InpStatus                      1
      *
      **SGLIC05 Program Interface
     d SGLIC05         Pi
     d AppId                         10
     d InpSerial                     10
     d InpModel                       8
     d InPpart                       10
     d InpexpDate                     8
     d InpStatus                      1
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

           BASESTR = %Trim(InpSerial) + '-' +
                     %Trim(InpModel)  + '-' +
                     %Trim(InpPart)   + '-' +
                     %Trim(AppId)                  ;

       //2. Función simple de "hash" (ejemplo básico)
       //SUMA de códigos + MOD para reducir tamaño

          Suma = *Zeros;
        //  For i = 1 to %Len(%Trim(baseStr));
        //     Char = %Subst(baseStr:i:1);
        //     AscVal = %Int(%Bitand(Char: x'FF'));
        //     Suma += AscVal;
        //  endfor;

           For i = 1 to %Len(%Trim(baseStr));
              Char = %Subst(baseStr:i:1);

              // Convertir el carácter a byte y luego a entero
              Byte1 = Char;
              AscVal = %int(%bitand(Byte1: x'FF'));

              Suma += AscVal;
           EndFor;

           Suma = %REM(Suma:999999)         ;

       //3. Construir LICKEY (por ejemplo: BASE + '-' + número)
           licKey = %trim(baseStr) + '-' + %Char(suma);

       //Grabar en LICCTL
           APPID       = %Trim(APPID);
           SERIAL      = %trim(INPSERIAL);
           MODEL       = %trim(INPMODEL);
           PARTITION   = %trim(INPPART);
           LICKEY      = licKey;
           EXPDATE     = %Date(FechaExp:*Iso);
           STATUS      = INPSTATUS;
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

           FechaExp = %Dec(InPexpDate:8:0)  ;

       EndSr;
      /End-Free
       // ----------------------------------------------------------
