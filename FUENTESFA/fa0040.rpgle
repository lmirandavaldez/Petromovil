     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0040                           *
      *  APLICACION...................: Sistema de Facturación           *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 23 / 11 / 1999                   *
      *  DESCR:                                                          *
      *            Re-Impresion de documentos Cancelados                 *
      *  ================================================================*
     fSegDis01  If   e           k Disk
     fFacDtoh01 If   e           k Disk
     fFacDed01  If   e           K Disk
     fCxcCli01  If   e           K Disk    Prefix(X_)
     fSegCia01  If   e           k disk
     fFA0040fm  cf   e             workstn
      *
L002 d Status_Ide      S               n
     d ValC            S             20    Inz(*Blanks)
     d Caracter        Ds                  Inz
     d Vc                             1    Dim(20)
L004 d DidCve          s                   Like(SqlFacDid.DidCve)
 ''   *
L009 d SqlFacDid     e Ds                  ExtName(FacDid) Qualified
 ''   *
L001  /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c                   If        resp = *blanks
     c                   Exsr      consta
     c                   Exsr      bloque
     c                   Endif
     c                   Eval      *inlr = *on
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     consta        begsr
      *
     c     clave_dtoh    klist
     c                   kfld                    distrito
     c                   kfld                    tipdoc
     c                   kfld                    numdoc
      *
     c     Clave_Dtohc   klist
     c                   kfld                    CodDis
     c                   kfld                    DocTip
     c                   kfld                    DocNro
      *
     c                   move      'PANTA1  '    flag1             8
     c                   endsr
      * ----------------------------------------------------------
      *          Ciclo de formatos de pantallas                  -
      * ----------------------------------------------------------
     c     bloque        begsr
     c     flag1         downe     'FIN     '
     c                   exsr      panta1
     c                   exsr      panta2
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *  Desplegar 1ra. pantalla                                 -
      * ----------------------------------------------------------
     c     panta1        begsr
      *
     c     flag1         doweq     'PANTA1  '
      *
     c                   exfmt     FA004001
     c                   exsr      error_clr
      *
     c     *in04         caseq     *on           listaf4
     c                   endcs
      *
     c                   if        *in03 = *on or *in12 = *on
     c                   move      'FIN     '    flag1
     c                   endif
      *
     c                   if        *in12 = *off and *in03 = *off
     c                             and *in04 = *off
     c                   exsr      cheq
      *
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *  Desplegar 2da. pantalla                                 -
      * ----------------------------------------------------------
     c     panta2        begsr
      *
     c     flag1         doweq     'PANTA2  '
      *
     c                   exfmt     FA004002
     c                   exsr      error_clr
      *
     c                   if        *in03 = *on
     c                   move      'FIN     '    flag1
     c                   endif
      *
     c                   if        *in12 = *on
     c                   move      'PANTA1  '    flag1
     c                   endif
      *
     c                   if        *in12 = *off and *in03 = *off
     c                   exsr      valida01
      *
     c                   endif
      *
     c                   enddo
     c                   endsr
      * ----------------------------------------------------------
      *             Busca datos para desplegar                   -
      * ----------------------------------------------------------
     c     cheq          begsr
     c                   setoff                                       303132
     c                   setoff                                       707172
     c                   setoff                                       37
      *
     c                   Do
     c     distrito      chain(n)  segdisf                            30
      *
     c                   if        *in30 = *on
     c                   eval      *in70 = *on
     c                   eval      msgid = 'SEG0026'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c                   if        TipDoc <> 1
     c                             And TipDoc <> 4 and TipDoc <> 5
     c                             And TipDoc <> 6
     c                   eval      *in31 = *on
     c                   eval      *in71 = *on
     c                   eval      msgid = 'FAC0013'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c                   if        numdoc = *zeros
     c                   eval      *in32 = *on
     c                   eval      *in72 = *on
     c                   eval      msgid = 'CMN0017'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c     clave_dtoh    chain(n)  facdtohf                           99
      *
     c                   if        *in99 = *on
     c                   eval      *in70 = *on
     c                   eval      *in71 = *on
     c                   eval      *in72 = *on
     c                   eval      msgid = 'COG0048'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c                   if        dtosta = 'C'
     c                   eval      *in70 = *on
     c                   eval      *in71 = *on
     c                   eval      *in72 = *on
     c                   eval      msgid = 'CMN0001'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      * Para validar el documento cancelado
     c     CodDis        Chain(n)  Segdisf                            33
     c                   if        *in33 = *on
     c                   eval      *in73 = *on
     c                   eval      msgid = 'SEG0026'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c                   if        DocTip <> 1
     c                             And DocTip <> 4 and DocTip <> 5
     c                             And DocTip <> 6
     c                   eval      *in34 = *on
     c                   eval      *in74 = *on
     c                   eval      msgid = 'FAC0013'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c                   if        DocNro = *zeros
     c                   eval      *in35 = *on
     c                   eval      *in75 = *on
     c                   eval      msgid = 'CMN0017'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c     Clave_dtohc   Chain(n)  FacDtohf                           99
      *
     c                   if        *in99 = *on
     c                   eval      *in73 = *on
     c                   eval      *in74 = *on
     c                   eval      *in75 = *on
     c                   eval      msgid = 'COG0048'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c                   If        DtoSta <> 'C'
     c                   eval      *in73 = *on
     c                   eval      *in74 = *on
     c                   eval      *in75 = *on
     c                   eval      msgid = 'CMN0001'
     c                   exsr      error_snd
     c                   Leave
     c                   Endif
      *
     c                   move      'PANTA2  '    flag1
     c     Clave_Dtohc   Chain     FacDedf                            52
      *
      * Si Tipo de ncf = 12 y el Rnc Es diferente al de la cia
     c                   Eval      TipNcf = %Dec(%Subst(NcfNro:10:2):2:0)
      *
     c     CliCve        Chain(n)  CxcClif                            55
     c                   If        CliIde = *Blanks And %Found(CxcCli01)
     c                   Eval      CliIde = %Trim(X_CliRnc)
     c                   Eval      NomCli = %Trim(X_CliNom)
     c                   Eval      PnoCli = %Trim(X_CliPno)
     c                   EndIf
      *
     c                   EndDo
     c                   endsr
      * ----------------------------------------------------------
      *             Busca datos para desplegar                   -
      * ----------------------------------------------------------
     c     Valida01      begsr
     c                   setoff                                       303132
     c                   setoff                                       333435
     c                   setoff                                       3637
     c                   Do
      *
     c                   If        %Subst(CliNom:1:1) = *Blanks
     c                   Eval      *In30 = *On
     c                   Eval      Msgid = 'CXC0002'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(CliPno:1:1) = *Blanks
     c                   Eval      *In31 = *on
     c                   Eval      msgid = 'CXC0002'
     c                   Exsr      Error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(CliDir:1:1) = *Blanks
     c                   Eval      *In32 = *On
     c                   Eval      Msgid = 'CXC0002'
     c                   Exsr      Error_Snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(CliLoc:1:1) = *Blanks
     c                   Eval      *In33 = *On
     c                   Eval      Msgid = 'CXC0002'
     c                   Exsr      Error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        %Subst(CliCiu:1:1) = *Blanks
     c                   Eval      *In34 = *on
     c                   Eval      Msgid = 'CXC0002'
     c                   Exsr      Error_snd
     c                   Leave
     c                   EndIf
      * RNC o Cedula
     c                   Eval      ValC = %Trim(CliIde)
     c                   Exsr      Convertir
     c     ' '           Scan      ValC          T                 2 0
      * Rnc
     c                   If        (T -1) <> 9 And (T - 1) <> 11
     c                   Eval      *In37 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Select
     c                   When      (T - 1) <= 9
     c                   Exsr      Valida_RNC
     c                   Eval      *In37 = *on
     c                   Eval      msgid = 'CMN0043'
      *
     c                   When      (T - 1) >= 10
     c                   Exsr      Valida_Cedula
     c                   Eval      *In37 = *on
     c                   Eval      msgid = 'NOM0022'
     c                   EndSl
      *
     c                   If        DigVer <> VerDig Or
     c                             %Subst(Valc:1:1) = *Blanks
     c                   Eval      *In37 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   If        Valc = RncCia And
     c                             (TipNcf <> 12 And TipNcf <> 52)
     c                   Eval      *In37 = *on
     c                   Eval      msgid = 'CMN0043'
     c                   Exsr      error_snd
     c                   Leave
     c                   EndIf
      *
     c                   Eval      CliIde = %Trim(Valc)
     c                   Exsr      Emision
      *
     c                   Enddo
     c                   EndSr
      * ----------------------------------------------------------
      *  Emision de documento
      * ----------------------------------------------------------
     c     Emision       Begsr
      *
     c                   Clear                   Origen            1 0
     c                   Clear                   ParametrosPgm   256
     c                   Eval      Origen = 2
     c                   Move      'PANTA1  '    flag1
      *
     c                   Close     SegDis01
     c                   Close     FacDtoh01
     c                   Close     FacDed01
     c                   Close     CxcCli01
      *
     c                   Eval      ParametrosPgm = %Trim(%Editc(Distrito:'X')) +
     c                                             %Trim(%Editc(TipDoc:'X')) +
     c                                             %Trim(%Editc(NumDoc:'X')) +
     c                                             %Trim(%Editc(CodDis:'X')) +
     c                                             %Trim(%Editc(DocTip:'X')) +
     c                                             %Trim(%Editc(DocNro:'X')) +
     c                                             %Trim(%Editc(Origen:'X')) +
     c                                             %Trim(User)
     c                   Eval      Didcve = 998
      *
M001 c                   Eval      ParmCodigo = %Editc(%Dec(DidCve:4:0):'X')
      *
      * Si es una factura normal
     c                   Select
     c                   When      DocTip = 1 Or DocTip = 4 Or
     c                             DocTip = 5 Or DocTip = 6
     c                   Call      'FA7010'
     c                   Parm      'FA'          ModuloDid         2
     c                   Parm                    ParmCodigo        4
     c                   Parm                    ParametrosPgm
      *
     c*                  parm                    Distrito
     c*                  parm                    TipDoc
     c*                  parm                    Numero
     c*                  Parm                    CodDis
     c*                  Parm                    DocTip
     c*                  Parm                    DocNro
     c*                  Parm                    Origen            1 0
     c*                  Parm                    User
      *
     c                   EndSl
      *
     c                   Open      SegDis01
     c                   Open      FacDtoh01
     c                   Open      FacDed01
     c                   Open      CxcCli01
      *
     c                   Eval      msgid = 'CXP0015'
     c                   Exsr      error_snd
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar lista para desplegar                            -
      * ----------------------------------------------------------
     c     listaf4       begsr
     c                   setoff                                       303132
     c                   setoff                                       337071
     c                   setoff                                       727337
      *
     c                   select
      *
     c                   when      campo = 'DISTRITO'
     c                   close     segdis01
     c                   call      'SG2019'
     c                   parm                    distrito
     c                   open      segdis01
      *
     c                   if        distrito > *zeros
     c                   eval      *in71 = *on
     c                   endif
      *
     c                   other
     c                   eval      msgid = 'CMN0002'
     c                   exsr      error_snd
      *
     c                   endsl
      *
     c                   endsr
      *--------------------------------------------------------------
      *   Sub- Rutina para depurar los campos numericos             -
      *--------------------------------------------------------------
     c     Convertir     Begsr
     c                   Clear                   I                 3 0
     c                   Clear                   y                 3 0
     c                   Eval      Caracter = Valc
     c                   Clear                   Valc
      *
     c                   For       I = 1 to %Elem(Vc)
      *
     c                   If        Vc(I) < '0'
     c                   Iter
     c                   Endif
      *
     c                   Eval      Y = Y + 1
     c                   Eval       %Subst(Valc:y:1) = Vc(I)
     c                   EndFor
      *
     c                   Endsr
L001  * --------------------------------------------------------
 ''   *  Para validar el numero de la cedula                   -
 ''   * --------------------------------------------------------
 ''  c     Valida_Cedula Begsr
 ''  c                   Clear                   NumCed           11 0
 ''  c                   Movel(p)  Valc          NumCed
 ''  c                   Move      NumCed        Verdig            1 0
 ''   *
 ''  c                   Call      'DIGITOB10'
 ''  c                   Parm                    NumCed
 ''  c                   Parm                    Digver            1 0
L001 c                   Endsr
L001  * --------------------------------------------------------
 ''   *  Para validar el numero de RNC de la empresa           -
 ''   * --------------------------------------------------------
 ''  c     Valida_RNC    Begsr
 ''  c                   Clear                   NumRnc            9 0
 ''  c                   Movel(p)  Valc          NumRnc
 ''  c                   Move      NumRnc        Verdig            1 0
 ''   *
 ''  c                   Call      'DIGITORNC'
 ''  c                   Parm                    NumRnc
 ''  c                   Parm                    Digver            1 0
L001 c                   Endsr
      * ----------------------------------------------------------
      *   subrutina inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        begsr
     c     *Like         Define    CiaRnc        RncCia
     c                   Clear                   TipNcf            2 0
      *
     c     NumCia        Chain     SegCiaf
     c                   Eval      ValC = %Trim(CiaRnc)
     c                   Exsr      Convertir
     c                   Eval      RncCia = %Trim(Valc)
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
     c                   write     msgctl
     c                   endsr
      * -----------------------------------------------------------
