     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: Oc2015                           *
      *  APLICACION...................: Orden de Compras                 *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 12 / 05 / 2021                   *
      *  DESCR:                                                          *
      *           Consulta seleccion Puertos                             *
      *  ================================================================*
     fOcoPue    If   e           k Disk
     fOc2015fm  Cf   e             Workstn
     f                                     Sfile(Oc201501:lin)
      *
     d Ds              s             70    Dim(05)
     d Md              s             78    Dim(02) Ctdata Perrcd(1)
     d Nombre_1        s                   Like(Nombre) Inz(*Blanks)
     d Nombre_2        s                   Like(Nombre) Inz(*Blanks)
      *
      /Copy Fuentes,SG9001
      *-----------------------------------------------------------
      *                  Recibe y Desvuelve Valores              -
      *-----------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Codigo_Par
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     *Like         Define    PaiCve        Codigo_Par
      *
     c                   Exsr      Consta
     c                   Exsr      Bloque
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     Consta        BegSr
     c                   Move      'PANTA1  '    Flag1             8
     c                   Exsr      Llenar
     c                   EndSr
      * ----------------------------------------------------------
      *          Ciclo de formatos de pantallas                  -
      * ----------------------------------------------------------
     c     Bloque        BegSr
     c                   Dow       Flag1 <> 'FIN     '
     c                   Exsr      Panta1
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *  Desplegar sflctl                                        -
      * ----------------------------------------------------------
     c     Panta1        BegSr
      *
     c                   Dow       Flag1 = 'PANTA1  '
     c                   If        Lin <> *Zeros
     c                   Eval      *In51 = *On
     c                   Else
     c                   Eval      *In51 = *Off
     c                   EndIf
      *
     c                   Eval      *In50 = *On
     c                   Movel     Md(1)         Mdt
     c                   Write     Oc201503
     c                   Exfmt     Oc201502
     c                   Eval      *In50 = *Off
     c                   Eval      *In51 = *Off
      *
     c     *In05         CasEq     *On           Renueva
     c     *In07         CasEq     *On           InicioSfl
     c     *In08         CasEq     *On           FinalSfl
     c                   EndCs
      *
     c                   If        *In03 = *On Or *In12
     c                   Move      'FIN     '    Flag1
     c                   EndIf
      *
     c                   If        *In12 = *Off and *In03 = *Off
     c                             and *In05 = *Off
      *
     c                   If        Nombre = Nombre_2
      *
     c                   If        Lin > *Zeros
     c                   Exsr      Panta2
     c                   EndIf
      *
     c                   Else
     c                   Exsr      Llenar
     c                   EndIf
      *
     c                   EndIf
     c                   EndDo
     c                   EndSr
      * -----------------------------------------------------------
      * Llenar                                                    -
      * -----------------------------------------------------------
     c     llenar        BegSr
     c                   Clear                   Lin
     c                   Clear                   Nombre_1
      *
     c     ' '           Checkr    Nombre        y                 2 0
     c                   If        (Y + 2) >= (%Size(Nombre))
     c                   Eval      Y = Y - 3
     c                   Endif
      *
     c                   If        Nombre > *Blanks
     c                   Eval      Nombre_1 = '%' + %Trim(Nombre)
     c                   Eval      %Subst(Nombre_1:Y+2) = *All'%'
     c                   EndIf
      *
     c                   Eval      Nombre_2 = Nombre
     c                   Exsr      sflclr
     c                   Exsr      sflfil
      *
     c                   If        Lin > *Zeros
     c                   Eval      Lin = 1
     c                   EndIf
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Renueva el sub_file                                    -
      * ----------------------------------------------------------
     c     renueva       BegSr
     c                   Eval      *In23 = *Off
      *
     c                   Dow       *In23 = *Off  and Lin > *Zeros
     c                   Readc     Oc201501                               23
      *
     c                   If        *In23 = *Off
     c                   Eval      Opc = *Zeros
     c                   Update    Oc201501
     c                   EndIf
      *
     c                   EndDo
     c                   EndSr
      * ----------------------------------------------------------
      *  Verificar opciones                                      -
      * ----------------------------------------------------------
     c     Panta2        BegSr
     c                   Readc     Oc201501                               23
      *
     c                   If        *In23 = *Off
      *
     c                   If        Opc = 1
     c                   Move(p)   PaiCve        Codigo_par
     c                   Eval      Flag1 = 'FIN     '
     c                   EndIf
      *
     c                   Else
     c     Line          Chain     Oc201501
     c                   EndIf
     c                   EndSr
      * ----------------------------------------------------------
      *  Posicionar en inicio                                    -
      * ----------------------------------------------------------
     c     InicioSfl     BegSr
     c                   Eval      Line = 1
     c     Line          Chain     Oc201501
     c                   EndSr
      * ----------------------------------------------------------
      *  Posicionar en Final                                     -
      * ----------------------------------------------------------
     c     finalSfl      BegSr
     c                   Eval      Line = Lin99
     c     Line          Chain     Oc201501
     c                   EndSr
      * ----------------------------------------------------------
      *          Limpiar sub-file                                -
      * ----------------------------------------------------------
     c     sflclr        BegSr
     c                   Eval      Opc = *Zeros
     c                   Eval      *In52 = *On
     c                   Eval      *In55 = *On
     c                   Write     Oc201502
     c                   Eval      *In52 = *Off
     c                   Eval      *In55 = *Off
     c                   Clear                   lin
     c                   EndSr
      * ----------------------------------------------------------*
      *  Llenar sub file                                          *
      * ----------------------------------------------------------*
     c     sflfil        BegSr
     c                   Clear                   Lin99             4 0
     c                   Eval      *In22 = *Off
     c                   Eval      *In21 = *Off
     c/Exec Sql
     c+   Declare C1 cursor for
     c+   Select T1.PueCve, T1.PueDes, T1.PaiCve, T2.PaiDes
     c+          From OcoPue T1
     c+          Join OcoPai T2
     c+            On (T1.PaiCve = T2.PaiCve)
     c+          Where (PueDes like :Nombre_1 or :Nombre_1 = ' ')
     c+          Order by PueDes For Read Only
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
     c                   Dow       SqlCod = 0
     c/Exec Sql Fetch C1 into :PueCve, :PueDes, :PaiCve, :PaiDes
     c/end-exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   EndIf
      *
     c                   Eval      Lin = Lin + 1
     c                   Write     Oc201501                               21
     c                   Eval      Lin99 = Lin
      *
     c                   If        *In21 = *On
     c                   Leave
     c                   EndIf
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C1
     c/End-Exec
     c                   Eval      *In22 = *On
     c                   EndSr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        BegSr
      *
      * Enviar mensaje de error
     c     msglis        Plist
     c                   Parm                    msgid             7
     c                   Parm                    msgpgm           10
     c                   Parm                    msgdta           80
      *
      * Borrar mensaje de error
     c     msgclr        Plist
     c                   Parm                    msgpgm
     c                   Movel     '*'           @msgq
      *
     c                   Eval       *in80 = *on
     c                   Write     msgctl
      *
     c                   Call      'QCIEQINJ1'
     c                   Parm                    resp              1
      *
     c                   Endsr
      * -----------------------------------------------------------
      *  Limpiar cola de mensaje                                  -
      * -----------------------------------------------------------
     c     error_clr     BegSr
      * Limpiar mensaje
     c                   Call      'SEGMSGJ2'    msgclr
     c                   Write     msgctl
     c                   Endsr
      * -----------------------------------------------------------
      *  Subrutina para retornar la descripcion de un mensaje     -
      *  desde un archivo de mensaje
      * -----------------------------------------------------------
     c     error_snd     BegSr
      * Limpiar mensaje
      *
     c                   Call      'SEGMSGJ1'    MSGLIS
     c                   Write     msgctl
     c                   Endsr
      * ----------------------------------------------------------
**
F3=Salir     F5=Renovar       F7=Inicio        F8=Final       F12=Anterior
