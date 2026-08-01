     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: IV7011                           *
      *  APLICACION...................: Control de Inventario            *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 22 / 07 / 2018                   *
      *  DESCR:                                                          *
      *         Calcular Existencias de un Producto                      *
      *  --------------------------------------------------------------- *
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 06 / 07 / 2026                   *
      *  DESCR: Mejoras en la Programacion                               *
      *                                                                  *
      *  ================================================================*
      * Parametros Entrada Funcion
     d AnoUpc          s             10I 0
     d NumUpc          s             10I 0
     d FechaIniAnt     s               d
     d FechaFinAnt     s               d
     d FechaIniAct     s               d
     d FechaFinAct     s               d
     d FechaDiaAct     s               d
      * Campos de Intermedios
     d FechaInicio     s                   Like(SqlSegFec.FecYmd)
     d FechaFinMes     s                   Like(SqlSegFec.FecYmd)
     d DisCod          s                   Like(SqlInvTrad.DisCve)
     d AlmCod          s                   Like(SqlInvTrad.AlmCve)
      *
     d CantInic        s                   Like(SqlInvTrad.TraCan)
     d CantInicUrp     s                   Like(SqlInvTrad.TraCan)
     d CanEnt          s                   Like(SqlInvTrad.TraCan)
     d CanSal          s                   Like(SqlInvTrad.TraCan)
     d CanEntApl       s                   Like(SqlInvTrad.TraCan)
     d CanSalApl       s                   Like(SqlInvTrad.TraCan)
     d ArtUal          s                   Like(SqlInvArt.ArtUal)
     d UalCon          s                   Like(SqlInvUal.UalCon)
      *
     dSqlInvTrad     e Ds                  ExtName(InvTrad) Qualified
     dSqlInvTrth     e Ds                  ExtName(InvTrth) Qualified
     dSqlInvTrtd     e Ds                  ExtName(InvTrtd) Qualified
     dSqlInvTmo      e Ds                  ExtName(InvTmo) Qualified
     dSqlInvArt      e Ds                  ExtName(InvArt) Qualified
     dSqlInvUal      e Ds                  ExtName(InvUal) Qualified
     dSqlInvPar      e Ds                  ExtName(InvPar) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **IV7011 Prototype
     d IV7011          Pr
     d  CodDis                             Like(SqlInvTrad.DisCve)
     d  CodAlm                             Like(SqlInvTrad.AlmCve)
     d  CodArt                             Like(SqlInvTrad.ArtCve)
     d  TipoExi                            Like(SqlInvPar.ParCve)
     d  CantidadExi                        Like(SqlInvTrad.TraCan)
      *
      **IV7011 Program Interface
     d IV7011          Pi
     d  CodDis                             Like(SqlInvTrad.DisCve)
     d  CodAlm                             Like(SqlInvTrad.AlmCve)
     d  CodArt                             Like(SqlInvTrad.ArtCve)
     d  TipoExi                            Like(SqlInvPar.ParCve)
     d  CantidadExi                        Like(SqlInvTrad.TraCan)
      *
      * Main Program
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------

        // Mover Campos Intermedios
           DisCod = CodDis  ;
           AlmCod = CodAlm  ;

        // Si el Almacen es 99 debe sumar todos los almacenes
           If AlmCod = 99     ;
              AlmCod = *Zeros ;
              Exsr ExistenExt ;
            Else ;
              Exsr ExisteInicCme ;
           EndIf ;

        // Buscar Existencia por Distrito y Almacen
           If TipoExi = 'R' ;  // Existencia con Cantidad Reservada
             Exsr TransNoAplic  ;
           EndIf ;

             Exsr TransAplicada ;

           CantidadExi = *Zeros ;
           CantidadExi = (CantInic + CanEntApl - CanSalApl - CanSal) ;

           Exsr EndProgram;
        // ------------------------------------------------------
        // Buscar existencia inicio de mes en archivo InvCme    -
        // ------------------------------------------------------
           BegSr ExisteInicCme;

           CantInic = *Zeros ;
           CantInicUrp = *Zeros ;

        // Buscar la Existencia Al Cierre
           Exec Sql
             Select CmeCfi, CmeCrp Into :CantInic, :CantInicUrp
               From InvCme
              Where (AnoUpc = :AnoUpc)
                And (NumUpc = :NumUpc)
                And (DisCve = :DisCod)
                And (AlmCve = :AlmCod)
                And (ArtCve = :CodArt)
              Fetch First 1 Rows Only ;

           SqlCod = *Zeros ;

           If CantInic < *Zeros   ;
              CantInic = *Zeros   ;
           Endif ;

           If CantInicUrp < *Zeros  ;
              CantInicUrp = *Zeros  ;
           Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Buscar Existencia inicio de mes en archivo Total     -
        // ------------------------------------------------------
           BegSr ExistenExt;

           CantInic = *Zeros ;
           CantInicUrp = *Zeros ;

        // Buscar la Existencia Al Cierre
           Exec Sql
             Select Sum(CmeCfi), Sum(CmeCrp) Into :CantInic, :CantInicUrp
               From InvCme
              Where (AnoUpc = :AnoUpc)
                And (NumUpc = :NumUpc)
                And (DisCve = :DisCod)
                And (ArtCve = :CodArt) ;

           SqlCod = *Zeros ;

           If CantInic < *Zeros   ;
              CantInic = *Zeros   ;
           Endif ;

           If CantInicUrp < *Zeros  ;
              CantInicUrp = *Zeros  ;
           Endif ;

           EndSr ;
        // ------------------------------------------------------
        // Buscar las transacciones No Aplicada                 -
        // ------------------------------------------------------
           BegSr TransNoAplic ;

           CanEnt = *Zeros  ;
           CanSal = *Zeros  ;

        // Leer archivo a desplegar
           Exec Sql
              Declare c1 cursor for
              Select *
                From InvTrtd T1
                Join InvTmo T2
                  On (T1.TmoCve = T2.TmoCve)
                Join InvTrth T3
                  On (T1.DisCve = T3.DisCve)
                 And (T1.TmoCve = T3.TmoCve)
                 And (T1.TraNro = T3.TraNro)
                Join SegFec T9
                  On (T3.TraAtr = T9.FecAno)
                 And (T3.TraMtr = T9.FecMes)
                 And (T3.TraDtr = T9.FecDia)
               Where (T1.DisCve = :DisCod)
                 And (T3.AlmCve = :AlmCod Or :AlmCod = 0)
                 And (T1.ArtCve = :CodArt)
                 And (T9.FecYmd >= :FechaInicio)
           For Read Only ;

           Exec Sql
             Open c1;

           Dow True;

           Exec Sql
             Fetch Next From c1 into :SqlInvTrtd, :SqlInvTmo, :SqlInvTrth,
                                     :SqlSegFec                             ;

           If Sqlcod <> *Zeros;
             leave;
           Endif;

           Exsr Factor    ;

        //Buscar Entradas y Salida Sin Aplicar
              Select       ;
       //Sumar Entradas con Unidad de Almacenamiento = a la del Maestro
                When SqlInvTmo.TmoOri = 1
                 And SqlInvTrtd.TraUnd = ArtUal
                  Or (SqlInvTmo.TmoOri = 3 And SqlInvTmo.TmoCdt = *Blanks
                 And SqlInvTrtd.TraUnd = ArtUal) ;
                     CanEnt += SqlInvTrtd.TraCan   ;

       //Sumar Entradas con Unidad de Almacenamiento <> a la del Maestro
                When SqlInvTmo.TmoOri = 1
                 And SqlInvTrtd.TraUnd <> ArtUal
                  Or (SqlInvTmo.TmoOri = 3 And SqlInvTmo.TmoCdt = *Blanks
                 And SqlInvTrtd.TraUnd <> ArtUal) ;
                     CanEnt += SqlInvTrtd.TraCan * UalCon ;

       //Sumar Salidas con Unidad de Almacenamiento = a la del Maestro
                When SqlInvTmo.TmoOri = 2
                 And SqlInvTrtd.TraUnd = ArtUal
                  Or (SqlInvTmo.TmoOri = 3 And SqlInvTmo.TmoCdt <> *Blanks
                 And SqlInvTrtd.TraUnd = ArtUal) ;
                     CanSal += SqlInvTrtd.TraCan   ;

       //Sumar Salidas con Unidad de Almacenamiento <> a la del Maestro
                When SqlInvTmo.TmoOri = 2
                 And SqlInvTrtd.TraUnd <> ArtUal
                  Or (SqlInvTmo.TmoOri = 3 And SqlInvTmo.TmoCdt <> *Blanks
                 And SqlInvTrtd.TraUnd <> ArtUal) ;
                     CanSal += SqlInvTrtd.TraCan * UalCon ;
           EndSl ;

           EndDo ;

           Exec Sql
             Close c1;

           SqlCod = *Zeros;
           EndSr ;
        // ------------------------------------------------------
        // Buscar las transacciones Aplicada Hasta la Fecha     -
        // ------------------------------------------------------
           BegSr TransAplicada ;

           CanEntApl = *Zeros  ;
           CanSalApl = *Zeros  ;

        // Buscar Entradas y Salida Aplicadas
           Exec Sql
              Select
              IfNull (Sum(Case When T2.TmoOri = 1 Or T2.TmoOri = 3 And
                     T2.TmoCdt = '  ' Then T1.TraCex Else 0 End), 0),
              IfNull (Sum(Case When T2.TmoOri = 2 Or T2.TmoOri = 3 And
                     T2.TmoCdt <> '  ' Then T1.TraCex * -1 Else 0 End), 0)
                Into :CanEntApl, :CanSalApl
                From InvTrad T1
                Join InvTmo T2
                  On (T1.TmoCve = T2.TmoCve)
                Join SegFec T9
                  On (T1.TraAtr = T9.FecAno)
                 And (T1.TraMtr = T9.FecMes)
                 And (T1.TraDtr = T9.FecDia)
               Where (T1.DisCve = :DisCod)
                 And (T1.AlmCve = :AlmCod Or :AlmCod = 0)
                 And (T1.ArtCve = :CodArt)
                 And (T9.FecYmd Between :FechaInicio And :FechaFinMes) ;

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Buscar Factor de conversión                          -
        // ------------------------------------------------------
           BegSr Factor ;

        //Buscar la Unidad de Almacenamiento
           ArtUal = *Zeros   ;

           Exec Sql
            Select ArtUal
              Into :ArtUal
              From InvArt
             Where (ArtCve = :CodArt)
             Fetch First 1 Rows Only ;

           SqlCod = *Zeros;

        //Buscar la Unidad Altenar del Producto
           UalCon = *Zeros   ;

           Exec Sql
            Select UalCon
              Into :UalCon
              From InvUal
            Where (ArtCve = :CodArt)
              And (UndCve = :SqlInvTrtd.TraUnd)
            Fetch First 1 Rows Only ;

          SqlCod = *Zeros;

          EndSr ;
       // -----------------------------------------------------
       // Subrutina Inicial                                   -
       // -----------------------------------------------------
          BegSr *Inzsr ;

           FechaDiaAct = %Date(*Date)  ;

        // Buscar Unidad de Almacenamiento del Articulo (una sola vez)
           Exsr FactorArt ;

           Exec sql
              Select Ano_Upc,
                     Mes_Upc,
                     Fecha_Ini_Cerrado,
                     Fecha_Fin_Cerrado,
                     Fecha_Ini_Sig,
                     Fecha_Fin_Sig
                INTO :AnoUpc,
                     :NumUpc,
                     :FechaIniAnt,
                     :FechaFinAnt,
                     :FechaIniAct,
                     :FechaFinAct
                From Table(IV_ULTIMO_PERIODO_CERRADO()) AS P;

             // Validación opcional */
             If SqlCod <> *Zeros;
                dsply 'ERROR: No se pudo obtener el período contable.';
                *inlr = *on;
                Return;
             EndIf;

             If FechaDiaAct > FechaFinAct ;
                FechaFinAct = FechaDiaAct ;
              EndIf ;

        // Definir fecha inicio periodo y final
           FechaInicio = %Dec(FechaIniAct)          ;
           FechaFinMes = %Dec(FechaFinAct)          ;

           EndSr ;
        // -----------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
           Begsr EndProgram;

            *Inlr = *On;
            Return;
           Endsr;
      /End-Free
        // -----------------------------------------------------
