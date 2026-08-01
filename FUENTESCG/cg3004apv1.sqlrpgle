     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1997')
     H   Debug Option(*SRCSTMT:*NODEBUGIO) Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: CG3004APV1                       *
      *  APLICACION...................: Contabilidad General             *
      *  AUTOR .......................: Jose Antonio Tiburcio G.         *
      *                                 y Luis Jose Miranda              *
      *  FECHA ESCRITURA .............: 22 / 09 / 97                     *
      *  DESCR:                                                          *
      *            Recontruccion de saldos                               *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Jose Ant. Tiburcio G.            *
      *  Fecha de modificacion........: 24 / 09 / 2002                   *
      *  DESCR: Tomar como archivo primario el historico detalles de     *
      *         transacciones para la reconstruccion de saldos.          *
      *         Se elimino la corrida del programa CG3004A.              *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 04 / 06 / 2003                   *
      *  DESCR: Agregar el control para crear la actulizacion en cascada *
      *         por centro de costo. Idef. L001                          *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 29 / 07 / 2004                   *
      *  DESCR: Evitar que no se dupliquen los registros ya pagados en   *
      *         el archivo de conciliacion. L002                         *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: (fecha actual)                   *
      *  DESCR: OPT1 - CtaMcc incluido en cursor C1 para evitar SELECT   *
      *         extra por cada registro procesado.                       *
      *         OPT2 - OPTIMIZE FOR ALL ROWS en cursor C1: plan optimo   *
      *         para lectura completa del periodo (100% de registros).   *
      *         OPT3 - Correccion de ENDDO comentado en Centro_Costo,    *
      *         el loop de cascada ahora se ejecuta correctamente.       *
      *  ================================================================*
     fCogCta01  if   e           k Disk    prefix(x)
L001 fCogCco01  If   e           k Disk    Prefix(x)
     f*ogMge01  Uf a e           k Disk
     f*ogBcc01  Uf a e           k Disk
      *
     d MonMov          S                   Like(SqlCogMge.MgeBal)
     d MonDeb          S                   Like(SqlCogMge.MgeDeb)
     d MonCre          S                   Like(SqlCogMge.MgeCre)
     d PerAno          S                   Like(SqlCogHdgd.PerAno)
     d PerNum          S                   Like(SqlCogHdgd.PerNum)
     d TdiCve          S                   Like(SqlCogHdgd.TdiCve)
     d DgeDoc          S                   Like(SqlCogHdgd.DgeDoc)
     d DgeSec          S                   Like(SqlCogHdgd.DgeSec)
     d DgeOri          S                   Like(SqlCogHdgd.DgeOri)
     d DgeVal          S                   Like(SqlCogHdgd.DgeVal)
     d AuxLis_1        S                   Like(SqlCogHdgd.AuxLis)
     d AuxLis          S                   Like(SqlCogHdgd.AuxLis)
     d AuxCve_1        S                   Like(SqlCogHdgd.AuxCve)
     d AuxCve          S                   Like(SqlCogHdgd.AuxCve)
     d CcoCve_1        S                   Like(SqlCogHdgd.CcoCve)
     d CcoCve          S                   Like(SqlCogHdgd.CcoCve)
     d Codigo_Cco      S                   Like(SqlCogHdgd.CcoCve)
     d CCo_Codigo      S                   Like(SqlCogHdgd.CcoCve)
     d CtaCve_1        S                   Like(SqlCogHdgd.CtaCve)
     d CtaCve          S                   Like(SqlCogHdgd.CtaCve)
     d Cuenta          S                   Like(SqlCogHdgd.CtaCve)
     d FecTra          S                   Like(SqlSegFec.FecDmy)
     d*FecEmi          S                   Like(SqlSegFec.FecYmd)
     d*FecCan          S                   Like(SqlSegFec.FecDmy)
     d CbaSta          S                   Like(SqlCogCbad.CbaSta)
     d Status          S                   Like(SqlCogCbad.CbaSta)
     d CbaVpa          S                   Like(SqlCogCbad.CbaVpa)
     d SecTtr          S                   Like(SqlCogCan.SecTtr)
     d BanCve          S                   Like(SqlCogBan.BanCve)
     d BanEmi          S                   Like(SqlCogBan.BanEmi)
     d CtaMcc          S                   Like(SqlCogCta.CtaMcc)
      *
     d MgeBip          S                   Like(SqlCogMge.MgeBip)
     d MgeDeb          S                   Like(SqlCogMge.MgeDeb)
     d MgeCre          S                   Like(SqlCogMge.MgeCre)
     d MgeBal          S                   Like(SqlCogMge.MgeBal)
      *
     d BccBip          S                   Like(SqlCogBcc.BccBip)
     d BccDeb          S                   Like(SqlCogBcc.BccDeb)
     d BccCre          S                   Like(SqlCogBcc.BccCre)
     d BccBal          S                   Like(SqlCogBcc.BccBal)
      *
l001 d Control         S               n
l002 d StaDoc          S               n
l002 d Existe_Cbah     S               n
      *
      * Tablas usadas en el programa
     dSqlCogHdgd     e Ds                  ExtName(CogHdgd) Qualified
     dSqlCogCbad     e Ds                  ExtName(CogCbad) Qualified
     dSqlCogCta      e Ds                  ExtName(CogCta) Qualified
     dSqlCogMge      e Ds                  ExtName(CogMge) Qualified
     dSqlCogBcc      e Ds                  ExtName(CogBcc) Qualified
     dSqlCogPer      e Ds                  ExtName(CogPer) Qualified
     dSqlCogBan      e Ds                  ExtName(CogBan) Qualified
     dSqlCogCan      e Ds                  ExtName(CogCan) Qualified
     dSqlCogTdi      e Ds                  ExtName(CogTdi) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
     d                 ds
     d FecEmi                  1      8  0
     d  CbaAem                 1      4  0
     d  CbaMem                 5      6  0
     d  CbaDem                 7      8  0
      *
     d                 ds
     d FecCan                  1      8  0
     d  CbaDca                 1      2  0
     d  CbaMca                 3      4  0
     d  CbaAca                 5      8  0
      *
      * Cerrar Periodo Contable
     d CierrePeriodo   Pr                  ExtPgm('CG3001A')
     d  PerAno_1                           Like(SqlCogMge.PerAno)
     d  PerNum_1                           Like(SqlCogMge.PerNum)
      *
      **CG3004AP Prototype
     d CG3004AP        Pr
     d  AnoPer                             Like(SqlCogMge.PerAno)
     d  NumPer                             Like(SqlCogMge.PerNum)
      *
      **CG3004AP Program Interface
     d CG3004AP        Pi
     d  AnoPer                             Like(SqlCogMge.PerAno)
     d  NumPer                             Like(SqlCogMge.PerNum)
      *
      * Main Program
      *
      /Free
       // ------------------------------------------------------
       // Main Process                                         -
       // ------------------------------------------------------
          Exsr Consta;
          Exsr EndProgram;
       // ------------------------------------------------------
       // Definicion de variables intermedias                  -
       // ------------------------------------------------------
          Begsr Consta;

          Exsr Proceso_Tra   ;                     //Saldos
          Exsr Cerrar_Periodo;                     //Cierre

          EndSr;
       // --------------------------------------------------------
       // Transacciones Historicas del Diario General            -
       // --------------------------------------------------------
          BegSr Proceso_Tra;

       // Leer Archivo
          Exec Sql
             Declare C1 cursor for
               Select T1.TdiCve, T1.DgeDoc, T1.PerAno, T1.PerNum, T1.CtaCve,
                      T1.AuxLis, T1.AuxCve, T1.CcoCve, T9.FecDmy,
                      (Case When T1.DgeOri = 1 Then T1.DgeVal Else 0 End) As
                       MonDeb,
                      (Case When T1.DgeOri = 2 Then T1.DgeVal Else 0 End) As
                       MonCre,
                      (Case When T1.DgeOri = 1 Then T1.DgeVal
                       Else T1.DgeVal * -1 End) As MonMov,
                       T9.FecYmd, T1.DgeOri, T1.DgeVal, T1.DgeSec, T2.*,
                       T3.CtaMcc                          -- OPT1: evita SELECT extra
                 From CogHdgd T1
                 Join CogTdi T2
                   On (T1.TdiCve = T2.TdiCve)
                 Join SegFec T9
                   On (T1.DgeDia = T9.FecDia)
                  And (T1.DgeMes = T9.FecMes)
                  And (T1.DgeAno = T9.FecAno)
                 Join CogCta T3
                   On (T1.CtaCve = T3.CtaCve)
                Where (T1.PerAno = :AnoPer)
                  And (T1.PerNum = :NumPer)
               Order By T1.CtaCve, T1.AuxLis, T1.AuxCve, T1.CcoCve,
                        T9.FecYmd, T1.TdiCve, T1.DgeDoc
               For Read Only                              -- OPT2: plan optimo lectura total
               Optimize For All Rows ;

          Exec Sql
            Open c1;

          Dow True;

          Exec Sql
            Fetch Next From c1 Into :TdiCve, :DgeDoc, :PerAno, :PerNum, :CtaCve,
                                    :AuxLis, :AuxCve, :CcoCve, :FecTra,
                                    :MonDeb, :MonCre, :MonMov, :FecEmi, :DgeOri,
                                    :DgeVal, :DgeSec,
                                    :SqlCogTdi, :CtaMcc                        ;

          If SqlCod <> *Zeros      ;
            Leave;
          EndIf;

      //Mover a Variables intermedias
          AuxLis_1 = AuxLis ;
          AuxCve_1 = AuxCve ;
          CcoCve_1 = CcoCve ;
          CtaCve_1 = CtaCve ;

          Exsr Concilia     ;
          Exsr Mayor_Gral   ;

          AuxLis = AuxLis_1 ;
          AuxCve = AuxCve_1 ;
          CcoCve = CcoCve_1 ;
          CtaCve = CtaCve_1 ;

      //CtaMcc ya viene del cursor C1 - OPT1 (SELECT extra eliminado)
           If CtaMcc = 'S'      ;
              Exsr Centro_Costo ;
            EndIf               ;

          EndDo ;

          Exec Sql
            Close c1;

          SqlCod = *Zeros ;

          EndSr ;
       // --------------------------------------------------------
       // Actualizacion conciliarion bancaria                    -
       // --------------------------------------------------------
          BegSr Concilia   ;

      //Buscar el Codigo del Banco Segun la cuenta contable
          Clear BanCve ;
          Clear BanEmi ;
          CbaVpa = *Zeros ;
          Exec Sql
             Select Coalesce(T1.BanCve,0),
                    Coalesce(T1.BanEmi,' ')
               Into :BanCve, :BanEmi
               From CogBan T1
          Left Join CogRbc T2
                 On (T1.BanCve = T2.BanCve)
              Where ((T1.CtaCve = :CtaCve)
                And (T1.AuxCve = :AuxCve))
                 Or ((T2.CtaCve = :CtaCve)
                And (T2.AuxCve = :AuxCve))
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

          If BanCve <> *Zeros And BanEmi = 'S' ;

             Select ;
               When SqlCogTdi.TdiTip = 0 ;
                    SecTtr = 2           ;
                    Status = 'T'         ;
                    CbaVpa = *Zeros ;

               When SqlCogTdi.TdiTip = 1 ;
                    SecTtr = 1           ;
                    Status = 'T'         ;
                    CbaVpa = *Zeros ;

               When SqlCogTdi.TdiTip = 2 ;
                    SecTtr = *Zeros      ;
                    Status = 'C'         ;
                    CbaVpa = DgeVal ;

              Other ;
                    SecTtr = *Zeros      ;
                    Status = 'T'         ;
                    CbaVpa = *Zeros ;
              EndSl    ;

      //Verificar el Documento esta Cancelado
          StaDoc = *Off;
          FecCan = *Zeros ;

          Exec Sql
             Select '1', Coalesce(T2.AplFec,0)
               Into :StaDoc, :FecCan
               From CogCheh T1
               Join CogCan01 T2
                 On (T1.BanCve = T2.BanCve)
                And (T1.SecTtr = T2.SecTtr)
                And (T1.BanNch = T2.BanNch)
              Where (T1.CheTdi = :TdiCve)
                And (T1.BanNch = :DgeDoc)
                And (T1.PerAno = :PerAno)
                And (T1.PerNum = :PerNum)
              Fetch First 1 Rows Only       ;

             Select;
               When StaDoc = *On
                And (SqlCogTdi.TdiTip = 0
                 Or  SqlCogTdi.TdiTip = 1) ;
                Status = 'C'    ;
                CbaVpa = DgeVal ;

               When StaDoc = *Off
                And SqlCogTdi.TdiTip = 2  ;
                Status = 'C'    ;
                CbaVpa = DgeVal ;
                FecCan = FecTra ;
              EndSl             ;

          SqlCod = *Zeros ;

      //Si No Existen en las tablas los crea Nuevos
          Exec Sql
             Merge Into CogCbad As D
             Using (Select :BanCve As BanCve,   -- Codigo del Banco
                           :TdiCve As TdiCve,   -- Tipo de Diario
                           :DgeDoc As DgeDoc,   -- Numero Documento
                           :DgeSec As DgeSec,   -- Secuencia
                           :PerAno As PerAno,   -- Ano Periodo
                           :PerNum As PerNum,   -- Numero Periodo
                           :DgeOri As DgeOri,   -- Origen Transaccion
                           :CbaDem As CbaDem,   -- Dia de emisión
                           :CbaMem As CbaMem,   -- Mes de emisión
                           :CbaAem As CbaAem,   -- Ano De emisión
                           :DgeVal As CbaVdc,   -- Valor del documento
                           :CbaVpa As CbaVpa,   -- Valor pagado
                           :CbaDca As CbaDca,   -- Fecha cancelación
                           :CbaMca As CbaMca,   -- Fecha cancelación
                           :CbaAca As CbaAca,   -- Fecha cancelación
                           :Status As CbaSta,   -- Estatus
                           ' '     As CbaPot,   -- Pot
                           ' '     As CbaPrc    -- Prc
                      From SYSIBM.SYSDUMMY1
                     Where Not Exists (
                               Select 1
                                 From CogCbahd H
                                Where (H.BanCve = :BanCve)
                                  And (H.TdiCve = :TdiCve)
                                  And (H.DgeDoc = :DgeDoc)
                                  And (H.CbaDem = :CbaDem)
                                  And (H.CbaMem = :CbaMem)
                                  And (H.CbaAem = :CbaAem)
                                  And (H.DgeOri = :DgeOri)
                                  And (H.CbaVdc = :DgeVal)
                                  And (H.DgeSec = :DgeSec)
                                  And (H.CbaSta = 'P'))) As S
                On (D.BanCve = S.BanCve)
               And (D.TdiCve = S.TdiCve)
               And (D.DgeDoc = S.DgeDoc)
               And (D.CbaDem = S.CbaDem)
               And (D.CbaMem = S.CbaMem)
               And (D.CbaAem = S.CbaAem)
               And (D.DgeOri = S.DgeOri)
               And (D.CbaVdc = S.CbaVdc)
               And (D.DgeSec = S.DgeSec)

              When Not Matched Then
                  Insert (BanCve, TdiCve, DgeDoc, DgeSec, PerAno, PerNum,
                          DgeOri, CbaDem, CbaMem, CbaAem, CbaVdc,  CbaVpa,
                          CbaDca, CbaMca, CbaAca, CbaSta, CbaPot, CbaPrc)
                  Values (S.BanCve, S.TdiCve, S.DgeDoc, S.DgeSec, S.PerAno,
                          S.PerNum, S.DgeOri, S.CbaDem, S.CbaMem, S.CbaAem,
                          S.CbaVdc, S.CbaVpa, S.CbaDca, S.CbaMca, S.CbaAca,
                          S.CbaSta, S.CbaPot, S.CbaPrc);

          SqlCod = *Zeros ;

          EndIf ;

          EndSr ;
       // --------------------------------------------------------
       // Actualizacion el Mayor General por Cuenta en Cascada   -
       // --------------------------------------------------------
          BegSr Mayor_Gral ;

          Cuenta = %Trim(CtaCve) ;
          Control = *On          ;

          Dow Cuenta <> *Blank ;

          Chain (Cuenta) CogCtaf ;
          Exec SQL
              Merge Into CogMge As T
              Using (Values(:AuxLis, :Cuenta, :AuxCve, :PerAno, :PerNum,
                            0, :MonDeb, :MonCre, :MonMov))
                 As S(AuxLis, Cuenta, AuxCve, PerAno, PerNum,
                      MgeBip, MonDeb, MonCre, MonMov)
                 On (T.AuxLis = S.AuxLis)
                And (T.CtaCve = S.Cuenta)
                And (T.AuxCve = S.AuxCve)
                And (T.PerAno = S.PerAno)
                And (T.PerNum = S.PerNum)
               When Matched Then
                 Update Set
                    T.MgeDeb = T.MgeDeb + S.MonDeb,
                    T.MgeCre = T.MgeCre + S.MonCre,
                    T.MgeBal = T.MgeBal + S.MonMov
               When Not Matched Then
                  Insert (AuxLis, CtaCve, AuxCve, PerAno, PerNum,
                          MgeBip, MgeDeb, MgeCre, MgeBal)
                  Values (S.AuxLis, S.Cuenta, S.AuxCve, S.PerAno, S.PerNum,
                          S.MgeBip, S.MonDeb, S.MonCre, S.MonMov);

          SqlCod = *Zeros ;

      //Para Controlar la actualizacion en casada de las cuentas
          If Control = *On And xCtaTip = 1 ;
            If xCtaMau = 'S' or xCtaMcc = 'S' ;
               xCtaAfe = Ctacve               ;
               Control = *Off                 ;
             Endif ;
           Endif  ;

          Cuenta = xCtaAfe ;
          MgeBal = *Zeros  ;
          MgeDeb = *Zeros  ;
          MgeCre = *Zeros  ;

          AuxLis = *Zeros  ;
          AuxCve = *Zeros  ;
          CcoCve = *Blanks ;
          Enddo  ;

          Endsr   ;
       // --------------------------------------------------------
       // Para Actualizar Por Centro de Costo en Cascada         -
       // --------------------------------------------------------
          BegSr Centro_Costo ;

          Codigo_Cco = %Trim(CcoCve) ;
          CCo_Codigo = %Trim(CcoCve) ;

      //Si la variable control es = *On es para que se ejecute una sola vez
           Control = *On ;

          Dow Codigo_Cco <> *Blanks  ;

          Chain (Codigo_Cco) CogCcof ;
          Exec SQL
              Merge Into CogBcc As T
              Using (Values(:Codigo_Cco, :AuxLis, :CtaCve, :AuxCve, :PerAno,
                            :PerNum, 0, :MonDeb, :MonCre, :MonMov))
                 As S(Codigo_Cco, AuxLis, CtaCve, AuxCve, PerAno, PerNum,
                      BccBip, MonDeb, MonCre, MonMov)
                 On (T.CcoCve = S.Codigo_Cco)
                And (T.AuxLis = S.AuxLis)
                And (T.CtaCve = S.CtaCve)
                And (T.AuxCve = S.AuxCve)
                And (T.PerAno = S.PerAno)
                And (T.PerNum = S.PerNum)
               When Matched Then
                 Update Set
                    T.BccDeb = T.BccDeb + S.MonDeb,
                    T.BccCre = T.BccCre + S.MonCre,
                    T.BccBal = T.BccBal + S.MonMov
               When Not Matched Then
                  Insert (CcoCve, AuxLis, CtaCve, AuxCve, PerAno, PerNum,
                          BccBip, BccDeb, BccCre, BccBal)
                  Values (S.Codigo_Cco, S.AuxLis, S.CtaCve, S.AuxCve, S.PerAno,
                          S.PerNum, S.BccBip, S.MonDeb, S.MonCre, S.MonMov);

          SqlCod = *Zeros ;

      //Controla la Actualizacion en Cascada del Centro de costo
           If Control = *On  ;
              Codigo_Cco = Cco_Codigo ;
              Control = *Off          ;
           Else ;
              Codigo_Cco = xCcoAfe    ;
           Endif  ;

          BccBal = *Zeros  ;
          BccDeb = *Zeros  ;
          BccCre = *Zeros  ;

          AuxLis = *Zeros  ;
          AuxCve = *Zeros  ;
          CtaCve = *Blanks ;
           Enddo             ;          // OPT3: ENDDO restaurado

          Endsr   ;
       // ------------------------------------------------------
       // Ejecuta el proceso cierre de periodos                -
       // ------------------------------------------------------
          BegSr Cerrar_Periodo;

          CierrePeriodo(AnoPer :NumPer);

          EndSr;
       //------------------------------------------------------
       // End Program Subroutine                              -
       //------------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
      /End-Free
       // ------------------------------------------------------
