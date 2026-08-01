     h   Copyright ('Miranda Valdez, S. A., 1997')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: CG3004                           *
      *  APLICACION...................: Contabilidad General             *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 03 / 10 / 97                     *
      *  DESCR:                                                          *
      *            Proceso recontruccion de saldos                       *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Jose Ant. Tiburcio G.            *
      *  Fecha de modificacion........: 24 / 09 / 2002                   *
      *  DESCR: Se elimino la corrida del programa CG3004A.              *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 19 / 10 / 2002                   *
      *  DESCR: Agregar el Prompt de la linea de comando del As/400      *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 10 / 02 / 2018                   *
      *  DESCR: Agregar Validar para Registro Contable & Cuentas x Pagar *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 14 / 07 / 2026                   *
      *  DESCR: Mejorar en General                                       *
      *  ================================================================*
     fCogPer01  Uf   e           k disk
     fCG3004fm  cf   e             workstn
      *
     d Status          s               n   Inz(*Off)
     d AnoPer          S                   Like(Perano)
     d NumPer          S                   Like(Pernum)
     d AnoPer_Act      S                   Inz(*Zeros) Like(Perano)
     d NumPer_Act      S                   Inz(*Zeros) Like(Pernum)
      *
     d AnoPer_Ant      S                   Inz(*Zeros) Like(Perano)
     d NumPer_Ant      S                   Inz(*Zeros) Like(Pernum)
      * Parametros Entrada Funcion
     d AnoPerAnt       s             10I 0
     d NumPerAnt       s             10I 0
     d PerStatus       s              1
     d FechaIniPer     s               d
     d FechaFinPer     s               d
      *
     d flag1           S              8    Inz(*blanks)
      *
     d FechaIni        S               d
     d HoraIni         S               t
     d FechaFin        S               d
     d HoraFin         S               t
     d MsgJoblog       S             52
      *
      /Copy Fuentes,SG9001
      * ----------------------------------------------------------
      *                  BLOQUE PRINCIPAL                        -
      * ----------------------------------------------------------
     c     clave_per     klist
     c                   kfld                    AnoPer
     c                   kfld                    NumPer
      *
     c                   if        resp = *blanks
     c                   exsr      consta
     c                   exsr      bloque
     c                   endif
     c                   eval      *inlr = *on
      * ----------------------------------------------------------
      *          DEFINICION DE VARIABLES INTERMEDIAS             -
      * ----------------------------------------------------------
     c     consta        begsr
      *
     c                   eval      sn = 'N'
     c                   eval      flag1 = 'PANTA1  '
      *
     c                   endsr
      * ----------------------------------------------------------
      *          CICLO DE FORMATOS DE PANTALLAS                  -
      * ----------------------------------------------------------
     c     bloque        begsr
     c                   dow       flag1 <> 'FIN     '
     c                   exsr      panta1
     c                   exsr      panta2
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 1ER. PANEL                            -
      * ----------------------------------------------------------
     c     panta1        begsr
     c                   dow       flag1 = 'PANTA1  '
     c                   exfmt     CG300401
     c                   eval      *in99 = *off
      *
     c                   exsr      error_clr
      *
     c                   if        *in03 = *on or *in12 = *on
     c                   eval      flag1 = 'FIN     '
     c                   endif
      *
     c     *in04         caseq     *on           listaf4
     c     *in21         Caseq     *On           Prompt
     c                   endcs
      *
     c                   if        not *in03 and not *in12
     c                             and Not *In21 And Not *In04
     c                   eval      sn = 'N'
     c                   exsr      cheq
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *           DESPLEGA 2ER. PANEL                            -
      * ----------------------------------------------------------
     c     panta2        begsr
     c                   dow       flag1 = 'PANTA2  '
     c                   exfmt     cg300402
      *
     c                   exsr      error_clr
      *
     c     *in21         Caseq     *On           Prompt
     c                   endcs
      *
     c                   if        *in03 = *on or *in12 = *on
     c                   eval      flag1 = 'FIN     '
     c                   endif
      *
     c                   if        not *in03 and not *in12
     c                             and Not *In21
      *
     c                   if        sn = 'S'
      *
     c                   write     cg300403
      *
     c                   exsr      InicioProc
     c                   exsr      borrar
     c                   exsr      cierra
     c                   exsr      ejecuta
     c                   Exsr      SaldoAnterior
     c                   exsr      FinProc
     c                   eval      msgid = 'COG0035'
     c                   exsr      error_snd
     c                   eval      flag1 = 'PANTA1  '
      *
     c                   else
      *
     c                   move      'PANTA1  '    FLAG1
     c                   endif
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *             BUSCA DATOS PARA DESPLEGAR                   -
      * ----------------------------------------------------------
     c     cheq          begsr
      *
     c                   exsr      ult_per
     c                   Setoff                                       30
     c                   Do
      *
     c                   if        PerStatus <> 'C'
     c                   Eval      *In30 = *On
     c                   eval      msgid = 'COG0034'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   exsr      chenea
      *
     c                   if        *in44 = *on
     c                   Eval      *In30 = *On
     c                   eval      msgid = 'COG0017'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   if        persit = 'C'
     c                   Eval      *In30 = *On
     c                   eval      msgid = 'COG0018'
     c                   exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      Status = *Off
      * Verifica todas las entrada de CXP esten aplicadas en Contabilidad
     c/Exec Sql
     c+   Select '1' Into :Status
     c+     From CxpDpeh T1
     c+    Where Not Exists(Select * From CogHdgd01 T2
     c+    Where (T1.TdiCve = T2.TdiCve)
     c+      And (T1.DgeDoc = T2.DgeDoc)
     c+      And (T1.PerAno = T2.PerAno)
     c+      And (T1.PerNum = T2.PerNum))
     c+     And (T1.PerAno = :AnoPer)
     c+     And (T1.PerNum = :NumPer)
     c/End-Exec
     c                   Clear                   SqlCod
     c                   If        Status = *On
     c                   Eval      *In30 = *On
     c                   Eval      msgid = 'CXP7000'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   eval      flag1 = 'PANTA2  '
     c                   EndDo
     c                   endsr
      * ----------------------------------------------------------
      * Chenea archivo
      * ----------------------------------------------------------
     c     chenea        begsr
     c     clave_per     chain     CogPerf                            44
     c                   endsr
      * ----------------------------------------------------------
      *   Cierra periodo anterior                                -
      * ----------------------------------------------------------
     c     Cierra        Begsr
      *
     c                   Close     CogPer01
     c                   Call      'CG3001A'
     c                   Parm                    AnoPer_Ant
     c                   Parm                    NumPer_Ant
     c                   Open      CogPer01
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Ejecuta el proceso cierre de periodos                  -
      * ----------------------------------------------------------
     c     ejecuta       BegSr
      *
     c                   Close     CogPer01
     c                   Call      'CG3004AP'
     c                   Parm                    AnoPer
     c                   Parm                    NumPer
     c                   Open      CogPer01
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Ejecuta el proceso para Actualizar el Saldo Anterior   -
      * ----------------------------------------------------------
     c     SaldoAnterior Begsr
      *
     c                   Close     CogPer01
      *
     c                   Call      'CG3004AB'
     c                   Parm                    AnoPer_Ant
     c                   Parm                    NumPer_Ant
     c                   Parm                    AnoPer
     c                   Parm                    NumPer
      *
     c                   Open      CogPer01
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Borra los saldos en el mayor y centro de costos        -
      * ----------------------------------------------------------
      * ----------------------------------------------------------
      *   Envia al Joblog la fecha y hora de inicio del proceso  -
      * ----------------------------------------------------------
     c     InicioProc    Begsr
      *
     c                   eval      FechaIni = %date()
     c                   eval      HoraIni  = %time()
     c                   eval      MsgJoblog = 'INI CG3004 '
     c                           + %char(FechaIni:*ISO)
     c                           + ' '
     c                           + %char(HoraIni:*HMS)
     c                   dsply                   MsgJoblog
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Envia al Joblog la fecha y hora de fin del proceso     -
      * ----------------------------------------------------------
     c     FinProc       Begsr
      *
     c                   eval      FechaFin = %date()
     c                   eval      HoraFin  = %time()
     c                   eval      MsgJoblog = 'FIN CG3004 '
     c                           + %char(FechaFin:*ISO)
     c                           + ' '
     c                           + %char(HoraFin:*HMS)
     c                   dsply                   MsgJoblog
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Borra los saldos en el mayor y centro de costos        -
      * ----------------------------------------------------------
     c     Borrar        Begsr
      *
      * Borra los registro del periodo seleccionado en el mayor
      *
     c/Exec Sql
     c+   Delete From CogMge
     c+    Where (PerAno = :AnoPer)
     c+      And (PerNum = :NumPer)
     c/End-Exec
     c                   Clear                   SqlCod
      *
      * Borra los registro del periodo seleccionado en el centro costos
      *
     c/Exec Sql
     c+   Delete From CogBcc
     c+    Where (PerAno = :AnoPer)
     c+      And (PerNum = :NumPer)
     c/End-Exec
     c                   Clear                   SqlCod
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar lista para desplegar                            -
      * ----------------------------------------------------------
     c     listaf4       begsr
     c                   Setoff                                       30
      *
     c                   Select
     c                   When      Record = 'CG300401' and Campo = 'ANOPER'
     c                   eval      sit = *blanks
     c                   close     CogPer01
     c                   call      'CG2007'
     c                   parm                    anoper
     c                   parm                    numper
     c                   parm                    sit               1
     c                   open      CogPer01
      *
     c                   write     CG300401
      *
     c                   When      Record = 'CG300401' and Campo = 'NUMPER'
     c                   eval      sit = *blanks
     c                   close     CogPer01
     c                   call      'CG2007'
     c                   parm                    anoper
     c                   parm                    numper
     c                   parm                    sit               1
     c                   open      CogPer01
      *
     c                   write     CG300401
      *
     c                   Other
     c                   eval      msgid = 'CMN0002'
     c                   exsr      error_snd
      *
     c                   EndSl
      *
     c                   endsr
       // -----------------------------------------------------
       // Buscar El Periodo Contable Anterior                 -
       // -----------------------------------------------------
          BegSr Ult_Per  ;

        //Buscar el Periodo contable Anterior
           Exec SQL
              Select PerAno,
                     PerNum,
                     PerSit,
                     PerFip,
                     PerFfp
                Into :AnoPerAnt,
                     :NumPerAnt,
                     :PerStatus,
                     :FechaIniPer,
                     :FechaFinPer
                From Table(CG_PERIODO_ANTERIOR(:AnoPer, :NumPer)) X;

             // Validación opcional */
             If SqlCod <> *Zeros;
                Dsply 'ERROR: No se pudo obtener el período contable.';
                *Inlr = *On;
                Return;
             EndIf;

            AnoPer_Ant = AnoPerAnt ;
            NumPer_Ant = NumPerAnt ;

           EndSr ;
      * ----------------------------------------------------------
      * Prompt para desplegar la linea de comando                -
      * ----------------------------------------------------------
     c     Prompt        Begsr
     c                   Call      'QUSCMDLN'
     c                   Endsr
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
      *
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
     c                   call      'SEGMSGJ1'    MSGLIS
      *
     c                   write     msgctl
     c                   endsr
      * -----------------------------------------------------------
