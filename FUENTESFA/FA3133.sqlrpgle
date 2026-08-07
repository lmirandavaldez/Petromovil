     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3133                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 04 / 03 / 2004                   *
      *  DESCR:                                                          *
      *  Seleccion Distrito, Supverisor, Vendedor, cliente, Rango Fechas *
      *  ================================================================*
     fSegDis01  If   e           k Disk
     fCxcSup01  If   e           k Disk
     fCxcVen01  If   e           k Disk
     fCxcCli01  If   e           k Disk
     fInvCat01  If   e           k Disk
     fFA3133fm  Cf   e             Workstn
      *
      * Campos Usado en el programa
     d Status          s               n   Inz(*Off)
     d FechaIso        s               d   Datfmt(*Iso)
     d FecDesIso       s               d   Datfmt(*Iso)
     d FecHasIso       s               d   Datfmt(*Iso)
      *
     d DateVal         s               n   Inz(*Off)
      *
      **Archivos Externos
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Titulo
     c                   Parm                    Programa         10
      *
     c                   If        Resp = *Blanks
     c                   Exsr      Consta
     c                   Exsr      Bloque
     c                   Endif
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     Consta        Begsr
     c                   Move      'PANTA1  '    Flag1             8
     c                   Endsr
      * ----------------------------------------------------------
      *          Ciclo de formatos de pantallas                  -
      * ----------------------------------------------------------
     c     Bloque        Begsr
     c     Flag1         Downe     'FIN     '
     c                   Exsr      Panta1
     c                   Enddo
     c                   Endsr
      * ----------------------------------------------------------
      *  Desplegar sflctl                                        -
      * ----------------------------------------------------------
     c     panta1        Begsr
      *
     c     Flag1         Doweq     'PANTA1  '
      *
     c                   Exfmt     FA313301
      *
     c                   Exsr      Error_Clr
     c     *In04         Caseq     *On           Listaf4
     c                   Endcs
      *
     c                   If        *In03 = *On or *In12 = *On
     c                   Move      'FIN     '    Flag1
     c                   Endif
      *
     c                   If        *In12 = *Off and *In03 = *Off
     c                             and *In04 = *Off
     c                   Exsr      Valida
     c                   Endif
      *
     c                   Enddo
     c                   Endsr
      * ----------------------------------------------------------

      * ----------------------------------------------------------
     c     Valida        Begsr
      *
     c                   Setoff                                       303132
     c                   Setoff                                       333435
     c                   Setoff                                       3637
     c                   Setoff                                       707172
     c                   Setoff                                       737475
     c                   Setoff                                       7677
      *
     c                   Do
      *
      * Validar codigo de distrito
     c                   If        CodDis <> *Zeros
     c     CodDis        Chain(n)  SegDisf                            30
     c                   Endif
      *
     c                   If        *In30 = *On
     c                   Eval      *In70 = *On
     c                   Eval      msgid = 'SEG0026'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *
      * Validar codigo de Supervisor
     c                   If        CodSup <> *Zeros
     c     CodSup        Chain(n)  CxcSupf                            31
     c                   Endif
      *
     c                   If        *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      Msgid = 'CXC0014'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *
      * Validar codigo de vendedor
     c                   If        Codven <> *Zeros
     c     CodVen        Chain(n)  CxcVenf                            32
     c                   Endif
      *
     c                   If        *In32 = *On
     c                   Eval      *In72 = *On
     c                   Eval      Msgid = 'CXC0034'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *
      * Determina si existe relacion entre el supervisor y vendedor
     c                   Eval      Status = *Off
        If CodSup <> *Zeros And CodVen <> *Zeros  ;
     c/Exec Sql
     c+   Select '1'
     c+     Into :Status
     c+     From CxcVen
     c+    Where (VenCve = :CodVen)
     c+      And (SupCve = :CodSup)
     c+  Fetch First 1 Rows Only
     c/End-Exec
     c                   Clear                   SqlCod
     c                   If        Status = *Off
     c                   Eval      *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      *In32 = *On
     c                   Eval      msgid = 'CXC0074'
     c                   Exsr      error_snd
     c                   Leavesr
     c                   EndIf
     c                   EndIf
      *
      *
      * validar el codigo del vEndedor
     c                   If        CodCli <> *Zeros
     c     CodCli        chain(n)  CxcClif                            33
     c                   Endif
     c                   If        *In33 = *On
     c                   Eval      *In73 = *On
     c                   Eval      Msgid = 'CXC0016'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *
      * Determina si existe relacion entre el Vendedor y Cliente
     c                   Eval      Status = *Off
        If CodVen <> *Zeros And CodCli <> *Zeros  ;
     c/Exec Sql
     c+   Select '1'
     c+     Into :Status
     c+     From CxcRvc
     c+    Where (VenCve = :CodVen)
     c+      And (CliCve = :CodCli)
     c+  Fetch First 1 Rows Only
     c/End-Exec
     c                   Clear                   SqlCod
     c                   If        Status = *Off
     c                   Eval      *In32 = *On
     c                   Eval      *In72 = *On
     c                   Eval      *In33 = *On
     c                   Eval      msgid = 'CXC0075'
     c                   Exsr      error_snd
     c                   Leavesr
     c                   EndIf
     c                   EndIf
      *
      * Calidar el codigo del Categoria
     c                   If        CodCat <> *Zeros
     c     CodCat        chain(n)  InvCatf                            34
     c                   Endif
     c                   If        *In34 = *On
     c                   Eval      *In74 = *On
     c                   Eval      Msgid = 'INV0005'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *
      * Validar fecha desde
     c     *Eur          Test(d)                 Fecdes                 35
      *
     c                   If        *In35 = *On
     c                   Eval      *In75 = *On
     c                   Eval      Msgid = 'CMN0004'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *

       //Validar Fecha Desdes & Archivo de Fechas
           DateVal = *Off      ;
           Exec Sql
              Select '1' Into :DateVal
                From SegFec
               Where (FecDmy = :FecDes)
               Fetch First 1 Rows Only       ;

           SqlCod = *Zeros ;

           If DateVal = *Off                 ;
              *In35 = *On                    ;
              *In75 = *On                    ;
              Msgid = 'CMN0004'              ;
              Exsr Error_snd                 ;
             Leave                           ;
            EndIf                            ;
      *
     c                   Eval      FecDesIso = %Date(FecDes:(*Eur))
      *
      * Validar fecha hasta
     c     *Eur          Test(d)                 Fechas                 36
      *
     c                   If        *In36 = *On
     c                   Eval      *In76 = *On
     c                   Eval      Msgid = 'CMN0004'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *

       //Validar Fecha Hasta & Archivo de Fechas
           DateVal = *Off      ;
           Exec Sql
              Select '1' Into :DateVal
                From SegFec
               Where (FecDmy = :FecHas)
               Fetch First 1 Rows Only       ;

           SqlCod = *Zeros ;

           If DateVal = *Off                 ;
              *In36 = *On                    ;
              *In76 = *On                    ;
              Msgid = 'CMN0004'              ;
              Exsr Error_snd                 ;
             Leave                           ;
            EndIf                            ;
      *
     c                   Eval      FecHasIso = %Date(FecHas:(*Eur))
      *
      * Si la fecha Desde es > a la Fecha Hasta
     c                   If        FecDesIso > FecHasIso
     c                   Eval      *In35 = *On
     c                   Eval      *In75 = *On
     c                   Eval      *In36 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c     FecHasIso     Subdur    FecDesIso     Meses:*m          7 0
      * Si el resultado de la resta de la fecha es mayor a 12 meses error
     c                   If        Meses > 12
     c                   Eval      *In35 = *On
     c                   Eval      *In75 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Exsr      Imprimir
      *
     c                   EndDo
      *
     c                   Endsr
      * ----------------------------------------------------------
      * Ejecuta Programa                                         -
      * ----------------------------------------------------------
     c     Imprimir      Begsr
      *
     c                   Eval      CliCod = %Editc(CodCli:'X')
     c                   Eval      SupCod = %Editc(CodSup:'X')
     c                   Eval      VenCod = %Editc(CodVen:'X')
     c                   Eval      DisCod = %Editc(CodDis:'X')
     c                   Eval      DesFec = %Editc(FecDes:'X')
     c                   Eval      HasFec = %Editc(FecHas:'X')
     c                   Eval      CatCod = %Editc(CodCat:'X')
      *
     c                   Call      Programa
     c                   Parm                    clicod            7
     c                   Parm                    Vencod            3
     c                   Parm                    Desfec            8
     c                   Parm                    Hasfec            8
     c                   Parm                    DisCod            3
     c                   Parm                    CatCod            4
     c                   Parm                    SupCod            2
      *
     c                   Eval      Msgid = 'CAJ0018'
     c                   Exsr      Error_Snd
     c                   Move      'FIN     '    Flag1             8
      *
     c                   Endsr
      * ----------------------------------------------------------
      *   Buscar lista para desplegar                            -
      * ----------------------------------------------------------
     c     Listaf4       Begsr
     c                   Setoff                                       303132
     c                   Setoff                                       333435
     c                   Setoff                                       3637
     c                   Setoff                                       707172
     c                   Setoff                                       737475
     c                   Setoff                                       7677
      *
     c                   Select
      *
     c                   When      Campo = 'CODDIS'
     c                   Close     SegDis01
     c                   Call      'SG2019'
     c                   Parm                    CodDis
     c                   Open      SegDis01
      *
     c                   If        CodDis <> *Zeros
     c                   Eval      *In71 = *On
     c                   Endif
      *
     c                   When      Campo = 'CODSUP'
     c                   Close     CxcSup01
     c                   Call      'CC2004'
     c                   Parm                    CodSup
     c                   Open      CxcSup01
      *
     c                   If        CodSup <> *Zeros
     c                   Eval      *In72 = *On
     c                   Endif
      *
     c                   When      Campo = 'CODVEN'
     c                   Close     CxcVen01
     c                   Call      'CC2007'
     c                   Parm                    CodVen
     c                   Open      CxcVen01
      *
     c                   If        CodVen <> *Zeros
     c                   Eval      *In73 = *On
     c                   Endif
      *
     c                   When      campo = 'CODCLI'
     c                   Close     CxcCli01
     c                   Call      'CC2001'
     c                   Parm                    CodCli
     c                   Open      CxcCli01
      *
     c                   If        CodCli <> *Zeros
     c                   Eval      *In74 = *On
     c                   Endif
      *
     c                   When      campo = 'CODCAT'
     c                   Close     InvCat01
     c                   Call      'IV2003'
     c                   Parm                    CodCAT
     c                   Open      InvCat01
      *
     c                   If        CodCat <> *Zeros
     c                   Eval      *In75 = *On
     c                   Endif
      *
     c                   Other
     c                   Eval      Msgid = 'CMN0002'
     c                   Exsr      Error_Snd
      *
     c                   Endsl
     c                   Endsr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr
      *
      * Enviar mensaje de error
     c     msglis        Plist
     c                   Parm                    Msgid             7
     c                   Parm                    msgpgm           10
     c                   Parm                    msgdta           80
      *
      * Borrar mensaje de error
     c     msgclr        Plist
     c                   Parm                    msgpgm
     c                   Movel     '*'           @msgq
      *
     c                   Eval       *In80 = *On
     c                   Write     msgctl
      *
     c                   Call      'QCIEQINJ1'
     c                   Parm                    Resp              1
     c                   Endsr
      * -----------------------------------------------------------
      *  Limpiar cola de mensaje                                  -
      * -----------------------------------------------------------
     c     Error_Clr     Begsr
      * Limpiar mensaje
     c                   Call      'SEGMSGJ2'    msgclr
     c                   Write     msgctl
     c                   Endsr
      * -----------------------------------------------------------
      *  Subrutina para retornar la descripcion de un mensaje     -
      *  desde un archivo de mensaje
      * -----------------------------------------------------------
     c     Error_Snd     Begsr
      * Limpiar mensaje
      *
     c                   Call      'SEGMSGJ1'    MSGLIS
     c                   Write     msgctl
     c                   Endsr
      * -----------------------------------------------------------
