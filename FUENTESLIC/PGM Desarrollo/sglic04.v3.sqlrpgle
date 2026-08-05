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
     d Part            s             10a
     d Err             s              8a   inz(*loval)
     d RcvVar          s            200a
     d FechaExp        s                   Like(SqlSegFec.FecYmd)
      * Archivos Definidos Externamente
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      * Eliminar digitos alfanumericos de un campo
     d QWCRSVAL        Pr                  ExtPgm('QWCRSVAL')
     d  RcvVar                      200a
     d  RcvVarLen                    10i 0 const
     d  Format                        8a   const
     d  SysValName                   10a   Const
     d  ErrorCode                     8a
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

           BaseStr = %Trim(InpSerial) + '-' +
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
        //    Byte1 = Char;
                // Obtener ASCII mediante SQL
                 EXEC SQL
                      SELECT ASCII(:Char)
                        INTO :CodigoAscii
                      FROM SYSIBM.SYSDUMMY1;

        //    AscVal = %int(%bitand(Byte1: x'FF'));
        //    CodigoAscii = %ASCII(Char)         ;

        //    Suma += AscVal;
              Suma += CodigoAscii ;
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

           QWCRSVAL(RcvVar: %size(RcvVar): 'RTVS0100': 'QSRLNBR': Err);
           Serial = %subst(RcvVar: 9: 10);

           QWCRSVAL(RcvVar: %size(RcvVar): 'RTVS0100': 'QMODEL': Err);
           model = %subst(RcvVar: 9: 8);

           QWCRSVAL(RcvVar: %size(RcvVar): 'RTVS0100': 'QSYSNAME': Err);
           part = %subst(RcvVar: 9: 10);

       EndSr;
      /End-Free
       // ----------------------------------------------------------
