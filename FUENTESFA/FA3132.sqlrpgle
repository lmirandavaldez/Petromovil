     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3132                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 24 / 07 / 2012                   *
      *  DESCR:                                                          *
      *       Seleccion Supervisor, Vendedor a Una Fecha                 *
      *  ================================================================*
     fCxcSup01  If   e           k disk
     fCxcVen01  If   e           k disk
     fFA3132fm  cf   e             workstn
      *
      *
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
     c                   Parm                    titulo
     c                   Parm                    programa         10
      *
     c                   exsr      consta
     c                   exsr      bloque
     c                   eval      *inlr = *on
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     consta        begsr
     c                   move      'PANTA1  '    flag1             8
     c                   endsr
      * ----------------------------------------------------------
      *          Ciclo de formatos de pantallas                  -
      * ----------------------------------------------------------
     c     bloque        begsr
     c     flag1         downe     'FIN     '
     c                   exsr      panta1
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *  Desplegar sflctl                                        -
      * ----------------------------------------------------------
     c     panta1        begsr
      *
     c     flag1         doweq     'PANTA1  '
      *
     c                   exfmt     FA313201
      *
     c                   exsr      error_clr
     c     *in04         caseq     *on           listaf4
     c                   endcs
      *
     c                   if        *in03 = *on or *in12 = *on
     c                   move      'FIN     '    flag1
     c                   endif
      *
     c                   if        *in12 = *off and *in03 = *off
     c                             and *in04 = *off
     c                   exsr      valida
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------

      * ----------------------------------------------------------
     c     valida        begsr
      *
     c                   setoff                                       303132
     c                   setoff                                       337071
     c                   setoff                                       7273
     c                   Do
      *
      * validar el codigo del Distrito
      *
     c                   If        CodSup <> *zeros
     c     CodSup        Chain(n)  CxcSupf                            30
     c                   EndIf
     c                   If        *In30 = *On
     c                   Eval      *In70 = *On
     c                   Eval      msgid = 'CXC0014'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Validar codigo del vendedor
      *
     c                   If        CodVen <> *Zeros
     c     CodVen        Chain(n)  CxcVenf                            31
     c                   EndIf
      *
     c                   If        *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CXC0016'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Validar fecha hasta
      *
     c     *Eur          Test(d)                 Fechas                 33
      *
     c                   if        *in33 = *on
     c                   eval      msgid = 'CMN0004'
     c                   eval      *in73 = *on
     c                   exsr      error_snd
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
              *In33 = *On                    ;
              *In73 = *On                    ;
              Msgid = 'CMN0004'              ;
              Exsr Error_snd                 ;
             Leave                           ;
            EndIf                            ;
      *
     c                   Eval      FecHasIso = %Date(FecHas:(*Eur))
     c                   Eval      FecHas = %Dec(FechasIso)
      *
     c                   exsr      imprimir
      *
     c                   EndDo
      *
     c                   endsr
      * ----------------------------------------------------------
      * consulta                                                 -
      * ----------------------------------------------------------
     c     imprimir      begsr
      *
     c                   Eval      SupCod = %Editc(CodSup:'X')
     c                   Eval      VenCod = %Editc(CodVen:'X')
     c                   Eval      HasFec = %Editc(FecHas:'X')
      *
     c                   call      programa
     c                   parm                    SupCod            2
     c                   parm                    VenCod            3
     c                   parm                    hasfec            8
      *
     c                   eval      msgid = 'CAJ0018'
     c                   exsr      error_snd
     c                   move      'FIN     '    flag1             8
      *
     c                   endsr
      * ----------------------------------------------------------
      *   Buscar lista para desplegar                            -
      * ----------------------------------------------------------
     c     listaf4       begsr
     c                   setoff                                       303170
     c                   setoff                                       71
      *
     c                   select
     c                   when      Campo = 'CODSUP'
     c                   Close     CxcSup01
     c                   Call      'CC2004'
     c                   Parm                    CodSup
     c                   Open      CxcSup01
      *
     c                   If        CodSup <> *zeros
     c                   Eval      *in71 = *on
     c                   EndIf
      *
     c                   When      campo = 'CODVEN'
     c                   Close     CxcVen01
     c                   Call      'CC2007'
     c                   Parm                    CodVen
     c                   Open      CxcVen01
      *
     c                   If        CodVen <> *zeros
     c                   Eval      *In72 = *on
     c                   EndIf
      *
     c                   Other
     c                   Eval      msgid = 'CMN0002'
     c                   Exsr      error_snd
      *
     c                   EndSl
     c                   EndSr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *inzsr        begsr
      *
      * Enviar mensaje de error
     c     msglis        plist
     c                   parm                    msgid             7
     c                   parm                    msgpgm           10
     c                   parm                    msgdta           80
      *
      * Borrar mensaje de error
     c     msgclr        plist
     c                   parm                    msgpgm
     c                   movel     '*'           @msgq
      *
     c                   eval       *in80 = *on
     c                   write     msgctl
      *
     c                   call      'QCIEQINJ1'
     c                   parm                    resp              1
     c                   endsr
      * -----------------------------------------------------------
      *  Limpiar cola de mensaje                                  -
      * -----------------------------------------------------------
     c     error_clr     begsr
      * Limpiar mensaje
     c                   call      'SEGMSGJ2'    msgclr
     c                   write     msgctl
     c                   endsr
      * -----------------------------------------------------------
      *  Subrutina para retornar la descripcion de un mensaje     -
      *  desde un archivo de mensaje
      * -----------------------------------------------------------
     c     error_snd     begsr
      * Limpiar mensaje
      *
     c                   call      'SEGMSGJ1'    MSGLIS
     c                   write     msgctl
     c                   endsr
      * -----------------------------------------------------------
