     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: NM7002                           *
      *  APLICACION...................: Sistema de nomina                *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 08 / 05 / 2026                   *
      *  DESCR:                                                          *
      *     Calcula FechaDesde y FechaHasta según Clase de Nomina        *
      *     Tipos: 12=Mensual, 24=Quincenal, 26=Bisemanal, 56=Semanal    *
      *                                                                  *
     *     Nota:                                                        *
     *        El calculo de las nominas semanales y bisemanales no      *
     *        esta validado por falta de informaciones al 12/05/2026    *
      *  ================================================================*
      *
      * Campos Usados en Programa
     d UltimoDia       s             10I 0
     d Dia             s             10I 0
     d Mes             s             10I 0
     d Ano             s             10I 0
      *
     d DiasDif         s             10I 0
     d OffSet          s             10I 0
     d DiaSemIni       s                   Like(SqlSegFec.FecIso)
     d DiaSemFin       s                   Like(SqlSegFec.FecIso)
     *         Para Nominas Semanales (56 ciclos)
     * Fecha Base si la semana Inicia Un Domingo debe ser Inz(D'1928-01-01')
     * Fecha Base si la semana Inicia Un Lunes debe ser Inz(D'1928-01-02')
     d FechaBase       s               d   Inz(D'1928-01-01')
      * Esta fecha es temporal es necesario buscar la fecha del primer ciclo
      * del ano para la clase de nomina - Bisemanal (26 ciclos)
     d FechaIniBise    s               d   Inz(D'2026-01-01')
     d FechaFinPer     s                   Like(SqlSegFec.FecIso)
     d FechaIniPer     s                   Like(SqlSegFec.FecIso)
     d IniAnterior     s                   Like(SqlSegFec.FecIso)
     d FinAnterior     s                   Like(SqlSegFec.FecIso)
      *
     d Fecha_Sal       s                   Like(SqlSegFec.FecIso)
     d Fecha_Ult       s                   Like(SqlSegFec.FecIso)
     d FechaIso        s                   Like(SqlSegFec.FecIso)
      *
     * Fecha Temporal Calculos
     d                 ds
     d  FecTemp                       8  0
     d  AnoTemp                1      4  0
     d  MesTemp                5      6  0
     d  DiaTemp                7      8  0
      *
     * Fecha Ultimo Dia del mes de Salida
     d                 ds
     d  FecFinSal                     8  0
     d  AnoFinSal              1      4  0
     d  MesFinSal              5      6  0
     d  DiaFinSal              7      8  0
      *
     d                 Ds
     d FechaS                  1      8  0
     d  AnoS                   1      4  0
     d  MesS                   5      6  0
     d  Dias                   7      8  0
      *
      * Archivos Definidos Externamente
     d SqlNomCno     e Ds                  ExtName(NomCno) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **NM7002  Prototype
     d NM7002          Pr
     d CnoCip                              Like(SqlNomCno.CnoCip)
     d FechaSal                            Like(SqlSegFec.FecIso)
     d FechaDes                            Like(SqlSegFec.FecIso)
     d FechaHas                            Like(SqlSegFec.FecIso)
      *
      **NM7002  Program Interface
     d NM7002          Pi
     d CnoCip                              Like(SqlNomCno.CnoCip)
     d FechaSal                            Like(SqlSegFec.FecIso)
     d FechaDes                            Like(SqlSegFec.FecIso)
     d FechaHas                            Like(SqlSegFec.FecIso)
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
           Exsr Proceso ;
           Exsr EndProgram;
        // ------------------------------------------------------
        // Imprimir Reporte                                     -
        // ------------------------------------------------------
           Begsr Proceso            ;

           Select;
        // ------------------------------------------------------
       //Nomina Mensual (12 ciclos)                           -
        // ------------------------------------------------------
           When CnoCip = 12;

             If Dia = UltimoDia;
                FechaHas = FechaSal;
                FecTemp = %Dec(FechaSal)  ;
                DiaTemp = 01             ;
                FechaIso = %Date(FecTemp:*Iso)     ;
                FechaDes = FechaIso - %Years(1) + %Months(1) ;
               Else;
                FecTemp = %Dec(FechaSal)  ;
                DiaTemp = 01             ;
                FechaIso = %Date(FecTemp:*Iso)     ;
                FechaHas = FechaIso - %Days(1)   ;
                FechaDes = FechaIso - %Years(1)  ;
              EndIf;

        // ------------------------------------------------------
       //Nomina Quicenal (24 ciclos)                          -
        // ------------------------------------------------------
           When CnoCip = 24;

             If Dia = 15;
                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = 15                       ;
                FechaHas = %Date(FecTemp:*Iso)     ;
                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = 16                       ;
                FechaIso = %Date(FecTemp:*Iso)     ;
                FechaDes = FechaIso - %Years(1)    ;

               ElseIf Dia = UltimoDia;

                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = UltimoDia                ;
                FechaHas = %Date(FecTemp:*Iso)     ;
                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = 01                       ;
                FechaIso = %Date(FecTemp:*Iso)     ;
                FechaDes = FechaIso - %Years(1)    ;

               ElseIf Dia < 15;

                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = 01                       ;
                FechaIso = %Date(FecTemp:*Iso)     ;
                FechaHas = FechaIso - %Days(1)     ;
                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = 01                       ;
                FechaIso = %Date(FecTemp:*Iso)     ;
                FechaDes = FechaIso - %Years(1)    ;
               Else;

                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = 15                       ;
                FechaHas = %Date(FecTemp:*Iso)     ;
                FecTemp = %Dec(FechaSal)           ;
                DiaTemp = 16                       ;
                FechaIso = %Date(FecTemp:*Iso)     ;
                FechaDes = FechaIso - %Years(1)    ;
              EndIf;

        // ------------------------------------------------------
       //Nomina Semanal (56 ciclos)                           -
        // ------------------------------------------------------
           When CnoCip = 56;

        //Diferencia en días entre la fecha de salida y Dia Inicio Semana
             DiasDif = %Diff(FechaSal: FechaBase: *D);

        //Offset dentro de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
             OffSet = %Rem(DiasDif: 7);

        //Dia de la Semana que Inicia (Domingo)
             DiaSemIni = FechaSal - %Days(offset);

        //Dia de la Semana que Finaliza (Sabado)
             DiaSemFin = DiaSemIni + %Days(6);

        //Determinar si se incluye la semana actual o la anterior
             If FechaSal = DiaSemFin ;
                FechaHas = DiaSemFin ;
               Else;
                FechaHas = DiaSemFin - %Days(7);
              EndIf;

        //56 semanas hacia atrás (incluyendo la última)
             FechaDes = FechaHas - %Days(7*56) + %Days(1);

        // ------------------------------------------------------
       //Nomina Bisemanal (26 ciclos)                         -
        // ------------------------------------------------------
           When CnoCip = 26;

        //Diferencia total de días entre la fecha de salida y la fecha ancla
           DiasDif = %Diff(FechaSal: FechaIniBise: *D);

        //Número de períodos completos transcurridos (división entera)
        //Ej: 0 = sigue en período 1, 1 = período 2, etc.
           OffSet = DiasDif / 14;

        //Inicio tentativo del período donde cae FechaSal
           FechaIniPer = FechaIniBise + %Days(OffSet * 14 - 1);
           FechaFinPer = FechaIniPer + %Days(13);

        //FechaHasta nunca puede pasar de la FechaSal
           If FechaFinPer > FechaSal;
              FechaHas = FechaSal;
             Else;
              FechaHas = FechaFinPer;
            EndIf;

        //Ahora FechaIniPer/FechaFinPer son el período "actual" (el 26)
           FechaDes = FechaIniPer - %Days(14 * 25 - 1);

           EndSl  ;

           Endsr;
        // ------------------------------------------------------
        // End Program Subroutine                               -
        // ------------------------------------------------------
           Begsr EndProgram;

            *Inlr = *On;
            Return;

           Endsr;
        // ------------------------------------------------------
        // Subrutina Inicial                                    -
        // ------------------------------------------------------
           BegSr *Inzsr;

       //Para Determinar el ultimo dia del mes de salida
           FechaS = %Dec(FechaSal)                     ;
           Dia = DiaS                                  ;
           Mes = MesS                                  ;
           Ano = AnoS                                  ;

           DiaS = 01                                   ;
           FechaIso = %Date(FechaS:*Iso)               ;
           FechaIso = FechaIso + %Months(1) - %Days(1) ;
           FecFinSal = %Dec(FechaIso)                  ;
           UltimoDia = DiaFinSal                       ;

          EndSr;
      /End-Free
       // ----------------------------------------------------------
