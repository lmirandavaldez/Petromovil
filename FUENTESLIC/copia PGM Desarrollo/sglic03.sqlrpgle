     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SGLIC03                          *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 27 / 01 / 2026                   *
      *  DESCR:                                                          *
      *            Captura Parametros Generador de Licencias             *
      *  ================================================================*
     fSGLIC03fm cf   e             workstn
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
     c                   Parm                    InpCtlSrl         8
     c                   Parm                    InpCtlMod         4
     c                   Parm                    InpCtlPty         4
     c                   Parm                    InpHostna         8
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
     c                   exfmt     SGLIC0301
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
     c                   setoff                                       33
     c                   setoff                                       707172
     c                   setoff                                       73
     c                   Do
      *
     c*                  If        %Subst(CiaNom:1:1) = *Blanks
     c*                  Eval      msgid = 'CMN0008'
     c*                  Eval      *in30 = *on
     c*                  Eval      *in70 = *on
     c*                  Exsr      error_snd
     c*                  Leave
     c*                  EndIf
      *
     c     *Eur          Test(d)                 FecIni                 31
     c                   If        *In31 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      FecDesIso = %Date(FecIni:*Eur)
     c                   Eval      FechaDes = %Dec(FecDesIso)
      *
     c     *Eur          Test(d)                 FecFin                 32
     c                   If        *In32 = *On
     c                   Eval      *In72 = *On
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
     c                   Eval      *In31 = *On
     c                   Eval      *In32 = *On
     c                   Eval      *In71 = *On
     c                   Eval      msgid = 'CMN0004'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
      * Determina si existe la empresa creada
     c                   Eval      Status = *Off
     c/Exec Sql
     c+   Select '1'
     c+     Into :Status
     c+     From SegCia
     c+    Where (CiaCve = '01')
     c+  Fetch First 1 Rows Only
     c/End-Exec
     c                   Clear                   SqlCod
     c                   If        Status = *Off
     c                   Eval      msgid = 'SEG0007'
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

        // Buscar Datos de la empresa
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
          Abrevi = *Blanks     ;  // %Triml((CiaNom):' ')     ;

            For i = 1 to 10 By 2;
               Abrevi = %Trim(Abrevi) + %Trim(%Subst(CiaNom:i:1));
            EndFor;

           Abrevi = %Trim(Abrevi) + %Trim(CiaRnc)  ;
      *
     c                   Eval      Abrev = %Trim(Abrevi)
     c                   Eval      FechaI = %Editc(FechaDes:'X')
     c                   Eval      FechaV = %Editc(FechaHas:'X')
     c                   Eval      UsrMax = %Editc(MaxUsr:'X')
      *
     c                   Call      Programa
     c                   Parm                    InpCtlSrl
     c                   Parm                    InpCtlMod
     c                   Parm                    InpCtlPty
     c                   Parm                    InpHostna
     c                   parm                    FechaI            8
     c                   parm                    FechaV            8
     c                   parm                    Abrev            25
     c                   parm                    UsrMax            5
      *
     c                   endsr
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
