     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SGLIC01                          *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 27 / 01 / 2026                   *
      *  DESCR:                                                          *
      *            Captura Parametros Generador de Licencias             *
      *  ================================================================*
     fSGLIC01fm cf   e             workstn
      *
     d md              s             78    dim(02) ctdata perrcd(1)
     d tx              s             70    dim(03) ctdata perrcd(1)
      * Campos Usado en el programa
     d Status          s               n   Inz(*Off)
     d FechaDes        s              8  0 Inz(*Zeros)
     d FechaHas        s              8  0 Inz(*Zeros)
     d FechaIso        s               d   Datfmt(*Iso)
     d FecDesIso       s               d   Datfmt(*Iso)
     d FecHasIso       s               d   Datfmt(*Iso)
      *
     d CiaNom          s                   Like(SqlSegCia.CiaNom)
     d CiaRnc          s                   Like(SqlSegCia.CiaRnc)
     d Abrevi          s             25a   Inz(*Blanks)
      * Tablas usado en el programa
     d SqlSegCia     e Ds                  ExtName(SegCia) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Titulo
     c                   Parm                    programa         10
      *
     c                   Exsr      consta
     c                   Exsr      bloque
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     consta        begsr
      *
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
     c                   exfmt     SGLIC0101
      *
     c                   exsr      error_clr
      *
     c                   if        *in03 = *on or *in12 = *on
     c                   move      'FIN     '    flag1
     c                   endif
      *
     c                   if        *in12 = *off and *in03 = *off
     c                   exsr      valida
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *   Validar Pantalla 1
      * ----------------------------------------------------------
     c     valida        begsr
      *
     c                   setoff                                       303132
     c                   setoff                                       333435
     c                   setoff                                       363738
     c                   setoff                                       707172
     c                   setoff                                       737475
     c                   setoff                                       767778
     c                   Do
      *
     c                   If        %Subst(NomCia:1:1) = *Blanks
     c                   Eval      msgid = 'CMN0008'
     c                   Eval      *in30 = *on
     c                   Eval      *in70 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(IdeEmp:1:1) = *Blanks
     c                   Eval      msgid = 'CMN0008'
     c                   Eval      *in31 = *on
     c                   Eval      *in71 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(NSerial:1:1) = *Blanks
     c                   Eval      msgid = 'CMN0008'
     c                   Eval      *in32 = *on
     c                   Eval      *in72 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(NModel:1:1) = *Blanks
     c                   Eval      msgid = 'CMN0008'
     c                   Eval      *in33 = *on
     c                   Eval      *in73 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(ProcType:1:1) = *Blanks
     c                   Eval      msgid = 'CMN0008'
     c                   Eval      *in34 = *on
     c                   Eval      *in74 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(HostName:1:1) = *Blanks
     c                   Eval      msgid = 'CMN0008'
     c                   Eval      *in35 = *on
     c                   Eval      *in75 = *on
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c     *Eur          Test(d)                 FecIni                 36
     c                   If        *In36 = *On
     c                   Eval      *In76 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      FecDesIso = %Date(FecIni:*Eur)
     c                   Eval      FechaDes = %Dec(FecDesIso)
      *
     c     *Eur          Test(d)                 FecFin                 37
     c                   If        *In37 = *On
     c                   Eval      *In77 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      FecHasIso = %Date(FecFin:*Eur)
     c                   Eval      FechaHas = %Dec(FecHasIso)
      *
      * Si la fecha Desde es > a la Fecha Hasta
     c                   If        FecDesIso > FecHasIso
     c                   Eval      *In36 = *On
     c                   Eval      *In37 = *On
     c                   Eval      *In76 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Si la Cantidad usuararios es Cero debe poner 99999
     c                   If        MaxUsr = *Zeros
     c                   Eval      MaxUsr = *HiVal
     c                   EndIf
      *
     c                   Exsr      Proceso
     c                   Move      'FIN     '    flag1
     c                   Enddo
      *
     c                   endsr
      * ----------------------------------------------------------
      * Ejecuta Proceso                                          -
      * ----------------------------------------------------------
     c     Proceso       begsr

           Abrevi = *Blanks     ;  // %Triml((NomCia):' ')     ;

            For i = 1 to 10 By 2;
               Abrevi = %Trim(Abrevi) + %Trim(%Subst(NomCia:i:1));
            EndFor;

           Abrevi = %Trim(Abrevi) + %Trim(IdeEmp)  ;

           Abrev = %Trim(Abrevi)         ;
           FechaI = %Editc(FechaDes:'X') ;
           FechaV = %Editc(FechaHas:'X') ;
           UsrMax = %Editc(MaxUsr:'X')   ;
      *
     c                   Call      Programa
     c                   Parm                    NSerial
     c                   Parm                    NModel
     c                   Parm                    ProcType
     c                   Parm                    HostName
     c                   Parm                    FechaI            8
     c                   Parm                    FechaV            8
     c                   Parm                    Abrev            25
     c                   Parm                    UsrMax            5
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr
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
**
F3=Salir      F11=Datos adicionales       F12=Anterior       F14=Listar
F3=Salir                                           F12=Anterior
**
Presione Intro, continuar
