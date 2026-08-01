     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1997')
     H   Debug Option(*SRCSTMT:*NODEBUGIO) Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: CG3001A                          *
      *  APLICACION...................: Contabilidad General             *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 27 / 09 / 97                     *
      *  DESCR:                                                          *
      *         Cierre del periodo                                       *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 14 / 07 / 2026                   *
      *  DESCR: Mejorar en General                                       *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 14 / 07 / 2026                   *
      *  DESCR: Eliminacion cursor C1 en Balance_Bcc - conversion a      *
      *         SQL set-based. Eliminacion INSERT CogMge en Balance_Bcc  *
      *         que generaba registros en cero incorrectamente.          *
      *  ================================================================*
      * Parametros Entrada Funcion
     d AnoPerPos       s             10I 0
     d NumPerPos       s             10I 0
     d PerStatus       s              1
     d FechaIniPer     s               d
     d FechaFinPer     s               d
      * Campos Usado en el programa
     d AnoPer_Act      s                   Like(SqlCogPer.PerAno) Inz(*Zeros)
     d NumPer_Act      s                   Like(SqlCogPer.PerNum) Inz(*Zeros)
     d AnoPer_Pos      s                   Like(SqlCogPer.PerAno) Inz(*Zeros)
     d NumPer_Pos      s                   Like(SqlCogPer.PerNum) Inz(*Zeros)
      *
     d PerAnoP         s                   Like(SqlCogPer.PerAno) Inz(*Zeros)
     d PerNumP         s                   Like(SqlCogPer.PerNum) Inz(*Zeros)
     d ProFec          s                   Like(SqlSegFec.FecDmy) Inz(*Zeros)
     d FinPer          s                   Like(SqlSegFec.FecDmy) Inz(*Zeros)
     d PerAbc          s                   Like(SqlCogPer.PerAno) Inz(*Zeros)
     d PerNbc          s                   Like(SqlCogPer.PerNum) Inz(*Zeros)
     d CuentaAfec      s                   Like(SqlCogCta.CtaAfe)
     d ListaAux        s                   Like(SqlCogCta.AuxLis)
     d CtaCve          s                   Like(SqlCogCta.CtaAfe)
     d AuxLis          s                   Like(SqlCogCta.AuxLis)
     d AuxCve          s                   Like(SqlCogMge.AuxCve)
     d CcoCve          s                   Like(SqlCogBcc.CcoCve)
     d AplUsr          s                   Like(SqlCogUpc.AplUsr)
     d AplWsi          s                   Like(SqlCogUpc.AplWsi)
     d AplHor          s                   Like(SqlCogUpc.AplHor)
     d MgeBip          s                   Like(SqlCogMge.MgeBip)
     d MgeDeb          s                   Like(SqlCogMge.MgeDeb)
     d MgeCre          s                   Like(SqlCogMge.MgeCre)
     d MgeBal          s                   Like(SqlCogMge.MgeBal)
     d BccBip          s                   Like(SqlCogBcc.BccBip)
     d BccDeb          s                   Like(SqlCogBcc.BccDeb)
     d BccCre          s                   Like(SqlCogBcc.BccCre)
     d BccBal          s                   Like(SqlCogBcc.BccBal)
      *
     d Fecha_Fin       s               d   Datfmt(*Iso)
     d Fecha_Pro       s               d   Datfmt(*Iso)
      *
      * Tablas usadas en el programa
     dSqlCogCta      e Ds                  ExtName(CogCta) Qualified
     dSqlCogMge      e Ds                  ExtName(CogMge) Qualified
     dSqlCogBcc      e Ds                  ExtName(CogBcc) Qualified
     dSqlCogUpc      e Ds                  ExtName(CogUpc) Qualified
     dSqlCogPer      e Ds                  ExtName(CogPer) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
     d                 ds
     d FecCie                  1      8  0
     d  AplDia                 1      2  0
     d  AplMes                 3      4  0
     d  AplAno                 5      8  0
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Buscar Periodo Contable
     d BuscaPeriodo    Pr                  ExtPgm('SG7003')
     d  ProFec_1                           Like(ProFec)
     d  PerAno_1                           Like(PerAnoP)
     d  PerNum_1                           Like(PerNumP)
      *
      **CG3004A Prototype
     d CG3001A         Pr
     d  AnoPer                             Like(SqlCogPer.PerAno)
     d  NumPer                             Like(SqlCogPer.PerNum)
      *
      **CG3001A Program Interface
     d CG3001A         Pi
     d  AnoPer                             Like(SqlCogPer.PerAno)
     d  NumPer                             Like(SqlCogPer.PerNum)
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

          Exsr StatusPerido ;                     //Status Periodo
          Exsr Borrar_Mge   ;                     //Borrar Registros  Mge
          Exsr Borrar_Bcc   ;                     //Borrar Registros  Bcc
          Exsr Balance_Mge  ;                     //Actualiza Balance Mge
          Exsr Balance_Bcc  ;                     //Actualiza Balance Bcc
          Exsr ControlCierre;                     //Crea Registro Control
          Exsr Cuentas_Cero ;                     //Crear Cuentas en Cero

          EndSr;
       // ------------------------------------------------------
       // Actualizar Status Periodo Contable                   -
       // ------------------------------------------------------
          Begsr StatusPerido;

      //Actualizar el Status del Periodo contable
          Exec sql
          Update CogPer
             Set PerSit = 'C'
           Where (PerAno = :AnoPer_Act)
             And (PerNum = :NumPer_Act);

          SqlCod = *Zeros    ;

          EndSr;
       // ------------------------------------------------------
       // Crear Registro Control Cierre Periodo contable       -
       // ------------------------------------------------------
          Begsr ControlCierre;

      //Crear Registro Control Cierre Periodo Contable
          Exec sql
          Merge Into CogUpc AS T
          Using (
              Select '*' As UpcCve,
                     :AnoPer_Act As PerAno,
                     :NumPer_Act As PerNum,
                     :AplUsr As AplUsr,
                     :AplWsi As AplWsi,
                     :AplHor As AplHor,
                     :AplDia As AplDia,
                     :AplMes As AplMes,
                     :AplAno As AplAno
               From SYSIBM.SYSDUMMY1) As S
          On T.UpcCve = S.UpcCve
          When Matched Then
              Update Set
                  T.PerAno = S.PerAno,
                  T.PerNum = S.PerNum,
                  T.AplUsr = S.AplUsr,
                  T.AplWsi = S.AplWsi,
                  T.AplHor = S.AplHor,
                  T.AplDia = S.AplDia,
                  T.AplMes = S.AplMes,
                  T.AplAno = S.AplAno
           When Not Matched Then
               Insert (UpcCve, PerAno, PerNum, AplUsr, AplWsi, AplHor,
                       AplDia, AplMes, AplAno)
               Values (S.UpcCve, S.PerAno, S.PerNum, S.AplUsr, S.AplWsi,
                       S.AplHor, S.AplDia, S.AplMes, S.AplAno);

          SqlCod = *Zeros    ;

          EndSr;
       // --------------------------------------------------------
       // Borra ctas. con debitos y creditos = Cero Mayor General-
       // --------------------------------------------------------
          BegSr Borrar_Mge  ;

          Exec sql
          Delete From CogMge
           Where (PerAno = :AnoPer_Pos)
             And (PerNum = :NumPer_Pos)
             And (MgeDeb = 0)
             And (MgeCre = 0) ;

          SqlCod = *Zeros    ;

          EndSr ;
       // --------------------------------------------------------
       // Borra Ctas. Con debitos y creditos = Cero Centro Costo -
       // --------------------------------------------------------
          BegSr Borrar_Bcc  ;

          Exec Sql
          Delete From CogBcc
           Where (PerAno = :AnoPer_Pos)
             And (PerNum = :NumPer_Pos)
             And (BccDeb = 0)
             And (BccCre = 0) ;

          SqlCod = *Zeros    ;

          EndSr ;
       // --------------------------------------------------------
       // Actualiza balance proximo periodo moyor general        -
       // --------------------------------------------------------
          BegSr Balance_Mge;

      //Crear Registros Periodo Posterior
          Exec sql
          Insert Into CogMge (
                 AuxLis, CtaCve, AuxCve, PerAno, PerNum, MgeBip,
                 MgeDeb, MgeCre, MgeBal)
          Select Act.AuxLis, Act.CtaCve, Act.AuxCve,
                 :AnoPer_Pos, :NumPer_Pos, 0, 0, 0, Act.MgeBal
            From CogMge Act
           Where (Act.PerAno = :AnoPer_Act)
             And (Act.PerNum = :NumPer_Act)
             And (Act.MgeBal <> 0)
             And Not Exists (
                  Select 1 From CogMge Pos
                   Where (Pos.PerAno = :AnoPer_Pos)
                     And (Pos.PerNum = :NumPer_Pos)
                     And (Pos.CtaCve = Act.CtaCve)
                     And (Pos.AuxLis = Act.AuxLis)
                     And (Pos.AuxCve = Act.AuxCve));

          SqlCod = *Zeros    ;

      //Actualiza el Balance Final del Periodo Posterior
          Exec Sql
             Update CogMge As Pos
                Set Pos.MgeBal = Coalesce((
                      Select Act.MgeBal + Pos.MgeDeb - Pos.MgeCre
                        From CogMge Act
                       Where (Act.PerAno = :AnoPer_Act)
                         And (Act.PerNum = :NumPer_Act)
                         And (Act.CtaCve = Pos.CtaCve)
                         And (Act.AuxLis = Pos.AuxLis)
                         And (Act.AuxCve = Pos.AuxCve)), 0)
              Where (Pos.PerAno = :AnoPer_Pos)
                And (Pos.PerNum = :NumPer_Pos);

          SqlCod = *Zeros    ;

          EndSr ;
       // --------------------------------------------------------
       // Actualiza balance proximo periodo en el centro costos  -
       // --------------------------------------------------------
          BegSr Balance_Bcc;

       //Insertar registros nuevos en CogBcc periodo posterior
          Exec Sql
             Insert Into CogBcc (
                    CcoCve, CtaCve, AuxLis, AuxCve, PerAno, PerNum,
                    BccBip, BccDeb, BccCre, BccBal)
             Select Act.CcoCve, Act.CtaCve, Act.AuxLis, Act.AuxCve,
                    :AnoPer_Pos, :NumPer_Pos, 0, 0, 0, Act.BccBal
               From CogBcc Act
              Where (Act.PerAno = :AnoPer_Act)
                And (Act.PerNum = :NumPer_Act)
                And (Act.BccBal <> 0)
                And Not Exists (
                     Select 1 From CogBcc Pos
                      Where (Pos.PerAno = :AnoPer_Pos)
                        And (Pos.PerNum = :NumPer_Pos)
                        And (Pos.CcoCve = Act.CcoCve)
                        And (Pos.CtaCve = Act.CtaCve)
                        And (Pos.AuxLis = Act.AuxLis)
                        And (Pos.AuxCve = Act.AuxCve));

          SqlCod = *Zeros    ;

       //Actualizar Balance registros ya existentes en CogBcc Periodo Posterior
          Exec Sql
             Update CogBcc As Pos
                Set Pos.BccBal = Coalesce((
                      Select Act.BccBal + Pos.BccDeb - Pos.BccCre
                        From CogBcc Act
                       Where (Act.PerAno = :AnoPer_Act)
                         And (Act.PerNum = :NumPer_Act)
                         And (Act.CcoCve = Pos.CcoCve)
                         And (Act.CtaCve = Pos.CtaCve)
                         And (Act.AuxLis = Pos.AuxLis)
                         And (Act.AuxCve = Pos.AuxCve)), 0)
              Where (Pos.PerAno = :AnoPer_Pos)
                And (Pos.PerNum = :NumPer_Pos);

          SqlCod = *Zeros    ;

          EndSr ;
       // --------------------------------------------------------
       // Proceso para Crear Las Cuentas Control que estan Cero  -
       // --------------------------------------------------------
          BegSr Cuentas_Cero  ;

       //Insertar cuentas de control (CtaAfe) en CogMge
       //que no existen en el periodo actual
          Exec Sql
             Insert Into CogMge (
                    AuxLis, CtaCve, AuxCve, PerAno, PerNum,
                    MgeBip, MgeDeb, MgeCre, MgeBal)
             Select T1.AuxLis, T1.CtaAfe, 0,
                    :AnoPer_Act, :NumPer_Act,
                    0, 0, 0, 0
               From CogCta T1
               Join CogMge T2
                 On (T1.CtaCve = T2.CtaCve)
              Where (T2.PerAno = :AnoPer_Act)
                And (T2.PerNum = :NumPer_Act)
                And (T1.CtaAfe <> '   ')
                And Not Exists (Select 1 From CogMge T3
              Where (T1.CtaAfe = T3.CtaCve)
                And (T3.PerAno = :AnoPer_Act)
                And (T3.PerNum = :NumPer_Act))
            Group By T1.AuxLis, T1.CtaAfe;

          SqlCod = *Zeros ;

          EndSr ;
       //------------------------------------------------------
       // End Program Subroutine                              -
       //------------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
       // ------------------------------------------------------
       // Buscar Periodo Contable                              -
       // ------------------------------------------------------
          BegSr Periodo ;

      //La fecha debe ser dd/mm/aaaa
          PerAnoP = *Zeros ;
          PerNumP = *Zeros ;

          BuscaPeriodo(ProFec :PerAnoP :PerNumP);
          //PerAno = PerAnoP ;
          //PerNum = PerNumP ;

          EndSr;
       // ------------------------------------------------------
       // Buscar el Proximo periodo contable                   -
       // ------------------------------------------------------
          BegSr Pos_Per  ;

        //Buscar el Periodo contable Anterior
           Exec SQL
              Select PerAno,
                     PerNum,
                     PerSit,
                     PerFip,
                     PerFfp
                Into :AnoPerPos,
                     :NumPerPos,
                     :PerStatus,
                     :FechaIniPer,
                     :FechaFinPer
                From Table(CG_PERIODO_POSTERIOR(:AnoPer_Act, :NumPer_Act)) X;

      //Si No Existe Debera Enviar a Crearlo Automaticamente
            If AnoPerPos <> *Zero And NumPerPos <> *Zeros ;
               AnoPer_Pos = AnoPerPos ;
               NumPer_Pos = NumPerPos ;
             Else ;

               Fecha_Pro = (Fecha_Fin + %Months(1))  ;
               ProFec = %Dec(Fecha_Pro:*Eur)         ;

      //Buscar Periodo Contable
               Exsr Periodo ;
               AnoPer_Pos = PerAnoP ;
               NumPer_Pos = PerNumP ;

            EndIf ;

          EndSr;
       // -----------------------------------------------------
       // Subrutina Inicial                                   -
       // -----------------------------------------------------
          BegSr *Inzsr;

          AnoPer_Act = AnoPer ;
          NumPer_Act = NumPer ;
          FecCie = *Date      ;
          AplHor = %Dec(%Time()) ;
          AplUsr = User       ;
          AplWsi = Wsid       ;

      //Buscar la Fecha Final Del Periodo
          Clear FinPer ;
          Exec Sql
             Select FinPer Into :FinPer
               From CogPer01
              Where (PerAno = :AnoPer_Act)
                And (PerNum = :NumPer_Act)
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

          Fecha_Fin = %Date(FinPer:*Eur)      ;

      //Buscar el proximo periodo Contable
          Exsr Pos_Per    ;

        EndSr;
      /End-Free
