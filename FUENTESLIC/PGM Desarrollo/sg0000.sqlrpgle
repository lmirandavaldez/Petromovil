     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SG0000                           *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 21 / 10 / 97                     *
      *  DESCR:                                                          *
      *            Seleccion de Compaias                                *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 23 / 06 / 2003                   *
      *  Codigo de modificacion.......: L001                             *
      *  DESCR: Modificar la forma de manejar el uso del sistema en otro *
      *         equipo.  Esto le permite al cliente utilizar el sistema  *
      *         por x dias pre-establecidos por la nuestra empresa.      *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 27 / 04 / 2004                   *
      *  Codigo de modificacion.......: L002                             *
      *  DESCR: Para corregir error en el bloqueo del Dataara cuando uno *
      *         usuario ejecuta el programa y no selecciona la compania  *
      *         con rapides.                                             *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 16 / 12 / 2011                   *
      *  Codigo de modificacion.......: L003                             *
      *  DESCR: Se Agrego que grabe en el Local el Mail de los usuario   *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 28 / 02 / 2014                   *
      *  Codigo de modificacion.......: L003                             *
      *  DESCR: Se Agrego que grabe en el Tipo de Spool para el Usuario  *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 28 / 01 / 2026                   *
      *  Codigo de modificacion.......: L004                             *
      *  DESCR: Cambio Validacion de Licencias                           *
      *  ================================================================*
     f*egCiu02  If   e           k Disk
     f*egCia01  If   e           k Disk
     fSG0000fm  Cf   e             Workstn
     f                                     Sfile(SG000001:lin)
      *
     d Md              S             78    Dim(01) Ctdata Perrcd(1)
     d Ctl             S              2    Dim(999)
      *
     d Msgpgm          S             10    Inz('SG0000')
      *
      * Campos Usado en el programa
     d NSerial         s              8A
     d NModel          s              4A
     d ProcType        s              4A
     d Hostn           s              8A
     d FecPro          s              5A
     d DiasPro         s              7A
     d CtlSta          s              1A
     d FechaDia        s                   Like(SqlSegFec.FecJul)
      *
     d CiaCve          s                   Like(SqlSegCia.CiaCve)
     d CiaNom          s                   Like(SqlSegCia.CiaNom)
     d CiaLib          s                   Like(SqlSegCia.CiaLib)
     d CiaMin          s                   Like(SqlSegCia.CiaMin)
     d CiaMfi          s                   Like(SqlSegCia.CiaMfi)
      *
    *  Equipo de Desarrollo
     d Modelo_Des      S              4    Inz(' 41A')
     d Serie_Des       S              8    Inz(' 78A826W')
    *  Equipo de Contingencia
     d Modelo_Con      S              4    Inz(' 41A')
     d Serie_Con       S              8    Inz(' 78B2BA0')
    *  Equipo de Produccion
     d Modelo_Pro      S              4    Inz(' 41B')
     d Serie_Pro       S              8    Inz(' 7875DE1')
      *
     dFecha_Dia        S               d   Datfmt(*Iso)
     dFecha_Fin        S               d   Datfmt(*Iso)
l001 d Control         S               n
      * Tablas usado en el programa
     d SqlSegCia     e Ds                  ExtName(SegCia) Qualified
     d SqlSegUsr     e Ds                  ExtName(SegUsr) Qualified
     d SqlSegCiu     e Ds                  ExtName(SegCiu) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
      * Validar la licencia
     d ValidaLic       Pr                  ExtPgm('SGLIC00')
     d  InpCtlSrl_1                        Like(NSerial)
     d  InpCtlMod_1                        Like(NModel)
     d  InpCtlPty_1                        Like(ProcType)
     d  InpCtlHtn_1                        Like(Hostn)
     d  InpFecPro_1                        Like(FecPro)
     d  InpTiempo_1                        Like(DiasPro)
     d  InpCtlSta_1                        Like(CtlSta)
      * --------------------------------------------------------
      *                   AREA DE TRABAJO                      -
      * --------------------------------------------------------
     d                Uds
     d  Fecha                100    105  0
     d  Empres               360    399
     d  Select               400    400
     d  Codigo               401    402
     d  Archiv               403    405
     d  Cierre               406    411
     d  Librer               412    422
     d  PrtNam               450    459
     d  Tspool               503    503
     d  Wsid                 551    560
     d  User                 561    570
     d  UsrMai               601    650
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Serie             8
     c                   Parm                    Modelo            4
     c                   Parm                    ProTyp            4
     c                   Parm                    Hostna            8
L001 c                   Parm                    FecDia            5
L001 c                   Parm                    DiasP             9
L001 c                   Parm                    Error             1
      *
L001 c                   If        Control = *On
     c                   Exsr      Consta
     c                   Exsr      Bloque
     c                   Endif
      *
     c                   Eval      *Inlr = *On
      * ----------------------------------------------------------
      *          Definicion de variables intermedias             -
      * ----------------------------------------------------------
     c     Consta        Begsr
     c                   Move      'PANTA1  '    Flag1             8
     c                   Exsr      llenar
     c                   Endsr
      * ----------------------------------------------------------
      *          Ciclo de formatos de pantallas                  -
      * ----------------------------------------------------------
     c     Bloque        Begsr
     c                   Dow       Flag1 <> 'FIN     '
     c                   Exsr      Panta1
     c                   Enddo
     c                   Endsr
      * ----------------------------------------------------------
      *  Desplegar sflctl                                        -
      * ----------------------------------------------------------
     c     Panta1        Begsr
      *
     c                   Dow       Flag1 = 'PANTA1  '
     c                   If        Lin <> *zeros
     c                   Eval      *In51 = *On
     c                   Else
     c                   Eval      *In51 = *Off
     c                   Endif
      *
     c                   Eval      *In50 = *On
     c                   Movel     md(1)         mdt
     c                   Write     SG000003
     c                   Exfmt     SG000002
     c                   Eval      *In50 = *Off
     c                   Eval      *In51 = *Off
      *
     c                   Exsr      Error_clr
     c     *In05         Caseq     *On           renueva
     c     *In07         CasEq     *On           InicioSfl
     c     *In08         CasEq     *On           FinalSfl
     c                   Endcs
      *
     c                   If        *In03 = *On or *In12 = *On
     c                   Eval      librer = *Blanks
     c                   Eval      select = *Blanks
     c                   Move      'FIN     '    Flag1
     c                   Endif
      *
     c                   If        *In12 = *Off and *In03 = *Off
     c                             And *In05 = *Off
     c                             And Lin > *zeros
     c                   Move      'PANTA2  '    Flag1
     c                   Exsr      panta2
     c                   Endif
      *
     c                   Enddo
     c                   Endsr
      * -----------------------------------------------------------
      * Llenar                                                    -
      * -----------------------------------------------------------
     c     llenar        BegSr
     c                   Clear                   Lin
     c                   Exsr      sflclr
     c                   Exsr      sflfil
     c                   If        Lin > *Zeros
     c                   Eval      Lin = 1
     c                   EndIf
      *
     c                   EndSr
      * ----------------------------------------------------------
      *  Verificar opciones                                      -
      * ----------------------------------------------------------
     c     Panta2        Begsr
     c                   Eval      *In23 = *Off
     c                   Dow       Flag1 = 'PANTA2  '
     c                   Move      *Blanks       swfin             8
      *
     c                   Readc     SG000001                               23
      *
     c                   If        *In23 = *Off
      *
     c                   If        Opc = 1
     c                   Eval      Codigo = CiaCve
     c                   Eval      Empres = CiaNom
     c                   Eval      Librer = CiaLib
     c                   Eval      Select = '@'
     c                   Eval      Archiv = %Trim(CiaCve)
     c                   Eval      Cierre = *Blanks
     c                   Eval      UsrMai = %Trim(SqlSegUsr.USrMai)
     c                   Eval      TSpool = %Trim(SqlSegUsr.UsrTsp)
     c                   Eval      PrtNam = %Trim(SqlSegUsr.UsrPrt)
      *
     c                   Eval      Flag1 = 'FIN     '
     c                   Endif
      *
     c                   Else
     c     Line          Chain     SG000001
     c                   Endif
      *
     c                   Enddo
     c                   Endsr
      * ----------------------------------------------------------
      *  Posicionar en inicio                                    -
      * ----------------------------------------------------------
     c     InicioSfl     BegSr
     c                   Eval      Line = 1
     c     Line          Chain     SG000001
     c                   EndSr
      * ----------------------------------------------------------
      *  Posicionar en Final                                     -
      * ----------------------------------------------------------
     c     finalSfl      BegSr
     c                   Eval      Line = Lin99
     c     Line          Chain     SG000001
     c                   EndSr
      * ----------------------------------------------------------
      *   Renueva el sub_file                                    -
      * ----------------------------------------------------------
     c     renueva       Begsr
     c                   Eval      *In23 = *Off
      *
     c                   Dow       *In23 = *Off  and Lin > *Zeros
     c                   Readc     SG000001                               23
      *
     c                   If        *In23 = *Off
     c                   Eval      Opc = *Zeros
     c                   Update    SG000001
     c                   EndIf
      *
     c                   EndDo
     c                   Endsr
      * ----------------------------------------------------------
      *          Limpiar sub-file                                -
      * ----------------------------------------------------------
     c     sflclr        Begsr
     c                   Eval      opc = *zeros
     c                   Eval      *In52 = *On
     c                   Eval      *In55 = *On
     c                   Write     SG000002
     c                   Eval      *In52 = *Off
     c                   Eval      *In55 = *Off
     c                   Clear                   Lin
     c                   Endsr
      * ----------------------------------------------------------*
      *  Llenar sub file                                          *
      * ----------------------------------------------------------*
     c     Sflfil        Begsr
     c                   Clear                   Lin99             4 0
     c                   Eval      *In22 = *Off
     c                   Eval      *In21 = *Off
     c/Exec Sql
     c+   Declare C1 cursor for
     c+    Select *
     c+      From SegCiu T1
     c+      Join SegCia T2
     c+        On (T1.CiaCve = T2.CiaCve)
     c+     Where (T1.UsrCve = :User)
     c+     Order by T1.CiaCve For Read Only
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 Into :SqlSegCiu, :SqlSegCia
     c/end-exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   EndIf
      *
     c                   Eval      CiaCve = SqlSegCia.CiaCve
     c                   Eval      CiaNom = SqlSegCia.CiaNom
     c                   Eval      CiaLib = SqlSegCia.CiaLib
     c                   Eval      CiaMin = SqlSegCia.CiaMin
     c                   Eval      CiaMfi = SqlSegCia.CiaMfi
      *
     c                   Eval      Lin += 1
     c                   Write     SG000001                               21
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
     c                   Endsr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr
L001       Control = *On    ;

       //Recibir Patametros
           NSerial = %Trim(Serie)         ;
           NModel = %Trim(Modelo)         ;
           ProcType = %Trim(ProTyp)       ;
           Hostn = %Trim(Hostna)          ;

          ValidaLic(NSerial :NModel :ProcType :Hostn :FecDia
                    :DiasP :CtlSta);

          If CtlSta = *Blanks ;
             Control = *On  ;
             CtlSta = *Blanks ;
           Else ;
             Control = *Off ;
             Error = CtlSta  ;
          EndIf ;

       //Buscar Datos del Usuario
          Clear SqlSegUsr ;

          Exec Sql
             Select *
               Into :SqlSegUsr
               From SegUsr
              Where (UsrCve = :User)
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;
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
     c                   Movel     '*'           @msgq
      *
     c                   Eval       *In80 = *On
     c                   Write     msgctl
      *
     c                   Endsr
      * -----------------------------------------------------------
      *  Limpiar cola de mensaje                                  -
      * -----------------------------------------------------------
     c     Error_clr     Begsr
      * Limpiar mensaje
     c                   call      'SEGMSGJ2'    msgclr
     c                   Write     msgctl
     c                   Endsr
      * -----------------------------------------------------------
      *  Subrutina para retornar la descripcion de un mensaje     -
      *  desde un archivo de mensaje
      * -----------------------------------------------------------
     c     Error_Snd     Begsr
     c                   call      'SEGMSGJ1'    MSGLIS
      *
     c                   Write     msgctl
     c                   Endsr
      * -----------------------------------------------------------
**
F3=Salir     F5=Renovar       F7=Inicio        F8=Final       F12=Anterior
