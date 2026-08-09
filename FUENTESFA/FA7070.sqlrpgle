     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA7070                           *
      *  APLICACION...................: Sistema de Facturación           *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 23 / 11 / 1999                   *
      *  DESCR:                                                          *
      *            Re-Asignar el Costo x Documento                       *
      *  ================================================================*
     fInvUal01  If   e           k Disk
     f*acPar    If   e           k Disk
      *
     d Registros       S               n
     d FechaEur        s               d   Datfmt(*Eur)
     d FechaIso        s               d   Datfmt(*Iso)
     d FechaInicio     s                   Like(SqlSegFec.FecYmd) Inz(*Zeros)
     d FechaTraAmd     s                   Like(SqlSegFec.FecYmd) Inz(*Zeros)
     d FechaTraDma     s                   Like(SqlSegFec.FecDmy) Inz(*Zeros)
     d ParCve          s              1    inz('@')
     d ManejaExist     s              1    Inz(*Blanks)
      * Parametros Entrada Funcion
     d AnoUpc          s             10I 0
     d NumUpc          s             10I 0
     d FechaIniAnt     s               d
     d FechaFinAnt     s               d
     d FechaIniAct     s               d
     d FechaFinAct     s               d
     d FechaDiaAct     s               d
      *
     d CostoPro        s                   Like(SqlInvArt.ArtCpl)
     d CostoUlt        s                   Like(SqlInvArt.ArtCul)
     d DtoCop          s                   Like(SqlFacDtod.DtoCop)
     d DtoCou          s                   Like(sqlFacDtod.DtoCou)
     d DtoMcp          s                   Like(SqlFacDtod.DtoMcp)
     d DtoMcu          s                   Like(sqlFacDtod.DtoMcu)
     d TotalCosPro     s                   Like(SqlFacDtoh.DtoMpr)
     d TotalCosUlt     s                   Like(sqlFacDtoh.DtoMul)
     d ArtCve          s                   Like(SqlFacDtod.ArtCve)
     d DtoUde          s                   Like(SqlFacDtod.DtoUde)
     d DisCve          s                   Like(SqlFacDtoh.DisCve)
     d DtoTip          s                   Like(SqlFacDtoh.DtoTip)
     d DtoNro          s                   Like(SqlFacDtoh.DtoNro)
      *
      * Parametros
     d Sistema         s              2    Inz('FA')
     d CodParametro    s              4  0 Inz(*Zeros)
     d ValorNum        s             30 15 Inz(*Zeros)
     d ValorAlf        s            100    Inz(*Blank)
      *
     dSqlFacDtoh     e Ds                  ExtName(FacDtoh) Qualified
     dSqlFacDtod     e Ds                  ExtName(FacDtod) Qualified
     dSqlInvArt      e Ds                  ExtName(InvArt) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
        Exsr Proceso;
        Exsr EndProgram;
        // ------------------------------------------------------
        // Definicion de variables intermedias                  -
        // ------------------------------------------------------
        Begsr Proceso;

        // Leer Archivo
           Exec Sql
              Declare C1 cursor for
                Select *
                  From FacDtoh T1
                  Join SegFec T9
                    On (T1.DtoAno = T9.FecAno)
                   And (T1.DtoMes = T9.FecMes)
                   And (T1.DtoDia = T9.FecDia)
                 Where (T9.FecYmd >= :FechaInicio)
                   And (T1.DtoSta = 'A')
              Order By T1.DisCve, T1.DtoTip, T9.FecYmd, T1.DtoNro, T1.CliCve
               For Read Only ;

        Exec Sql
          Open c1;

        Dow True;

          Exec Sql
            Fetch Next From c1 Into :SqlFacDtoh, :SqlSegFec            ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

       // Mover los campos a variables intermedias
       DisCve = SqlFacDtoh.DisCve   ;
       DtoTip = SqlFacDtoh.DtoTip   ;
       DtoNro = SqlFacDtoh.DtoNro   ;

       FechaTraAmd = SqlSegFec.FecYmd   ;
       FechaTraDma = SqlSegFec.FecDmy   ;

       // Ejecutar Detalle
       Exsr Detalle ;

       // Limpiar variables intermedias
          TotalCosPro = *Zeros ;
          TotalCosUlt = *Zeros ;

       // Sumar Detalle del Documento
              Exec Sql
                Select Sum(DtoMcp), Sum(DtoMcu)
                  Into :TotalCosPro, :TotalCosUlt
                  From FacDtod
                 Where (DisCve = :SqlFacDtoh.DisCve)
                   And (DtoTip = :SqlFacDtoh.DtoTip)
                   And (DtoNro = :SqlFacDtoh.DtoNro) ;

        SqlCod = *Zeros;

       // Actualizar Cabecera del Documento
          Exec Sql
           Update FacDtoh Set DtoMpr = :TotalCosPro,
                              DtoMul = :TotalCosUlt
           Where (DisCve = :SqlFacDtoh.DisCve)
             And (DtoTip = :SqlFacDtoh.DtoTip)
             And (DtoNro = :SqlFacDtoh.DtoNro) ;

        SqlCod = *Zeros;

        EndDo ;

        Exec Sql
          Close c1;
        SqlCod = *Zeros;

        Endsr;
        // ------------------------------------------------------
        // Seleccionar registros en Detalle                     -
        // ------------------------------------------------------
         BegSr Detalle ;

       // Limpiar variables intermedias
          DtoCop = *Zeros ;
          DtoCou = *Zeros ;
          DtoMcp = *Zeros ;
          DtoMcu = *Zeros ;

        // Leer Archivo
           Exec Sql
              Declare C2 cursor for
               Select *
                 From FacDtod T1
                 Join InvArt T2
                   On (T1.ArtCve = T2.ArtCve)
                Where (T1.DisCve = :SqlFacDtoh.DisCve)
                  And (T1.DtoTip = :SqlFacDtoh.DtoTip)
                  And (T1.DtoNro = :SqlFacDtoh.DtoNro)
                  And (T2.TiiCve <> 9)
               For Read Only ;

        Exec Sql
          Open c2;

        Dow True;

          Exec Sql
            Fetch Next From c2 Into :SqlFacDtod, :SqlInvArt            ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

       // Mover los campos a variables intermedias
       ArtCve = SqlFacDtod.ArtCve   ;
       DtoUde = SqlFacDtod.DtoUde   ;

       DtoCop = *Zeros   ;
       DtoCou = *Zeros   ;
       DtoMcp = *Zeros ;
       DtoMcu = *Zeros ;

       CostoPro = *Zeros   ;
       CostoUlt = *Zeros   ;

       Select ;
         When ManejaExist = 'N'  ;
              Exsr CostoNoExist  ;

         When ManejaExist = 'S'  ;
              Exsr CostoExist    ;
       EndSl   ;

       If SqlFacDtod.DtoUde = SqlInvArt.ArtUal   ;
          DtoCop = CostoPro * 1    ;
          DtoCou = CostoUlt * 1    ;

        Else ;

          Chain (ArtCve :DtoUde) InvUalf ;
          If %Found(InvUal01)    ;
             DtoCop = %Dech((CostoPro / SqlInvArt.ArtCua) * UalCon:15:6)  ;
             DtoCou = %Dech((CostoUlt / SqlInvArt.ArtCua) * UalCon:15:6)  ;
          EndIf ;

       EndIf  ;

       DtoMcp = %Dech(SqlFacDtod.DtoCan * DtoCop:12:2) ;
       DtoMcu = %Dech(SqlFacDtod.DtoCan * DtoCou:12:2) ;

       // Actualizar Detalle del Documento
          Exec Sql
           Update FacDtod Set DtoCop = :DtoCop,
                              DtoCou = :DtoCou,
                              DtoMcp = :DtoMcp,
                              DtoMcu = :DtoMcu
           Where (DisCve = :SqlFacDtod.DisCve)
             And (DtoTip = :SqlFacDtod.DtoTip)
             And (DtoNro = :SqlFacDtod.DtoNro)
             And (DtoSec = :SqlFacDtod.DtoSec) ;
        SqlCod = *Zeros;

         EndDo ;

        Exec Sql
          Close c2;
        SqlCod = *Zeros;

        Endsr;
        //------------------------------------------------------
        // End Program Subroutine                              -
        //------------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
      /End-Free
       // ----------------------------------------------------------
      *-------------------------------------------------------------
      *  Buscar El costo en las empresas que no manejan existencia -
      *-------------------------------------------------------------
     c     CostoNoExist  BegSr
     c                   Clear                   CostoPro
     c                   Clear                   CostoUlt
      *
     c                   Call      'FA7060'
     c                   Parm                    ArtCve
     c                   Parm                    FechaTraDma
     c                   Parm                    CostoPro
      *
     c                   Eval      CostoUlt = CostoPro
      *
     c                   EndSr
      *-------------------------------------------------------------
      *  Buscar El costo en las empresas que no manejan existencia -
      *-------------------------------------------------------------
     c     CostoExist    BegSr
     c                   Clear                   CostoPro
     c                   Clear                   CostoUlt
     c                   Clear                   Total_Can        13 2
      *
     c                   Call      'FA7061'
     c                   Parm                    ArtCve
     c                   Parm                    FechaTraAmd
     c                   Parm                    CostoPro
     c                   Parm                    CostoUlt
     c                   Parm                    Total_Can
      *
     c                   EndSr
      * ----------------------------------------------------------
      * Parametros del sistema                                   -
      * ----------------------------------------------------------
     c     Parametros    BegSr
     c                   Call      'SG7009'                             60
     c                   Parm                    Sistema
     c                   Parm                    CodParametro
     c                   Parm                    ValorNum
     c                   Parm                    ValorAlf
      *
     c                   Endsr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
     c                   Clear                   ManejaExist       1
      *  Para Definir si la empresa Maneja Existencia o No
     c                   Eval      CodParametro = 0051
     c                   Exsr      Parametros
     c                   Movel(p)  ValorAlf      ManejaExist
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr

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

             FechaInicio = %Dec(FechaIniAct)  ;
      *
      * Buscar Parametros Generales
     c                   Exsr      PrnGenerales
      *
     c                   EndSr
      * -----------------------------------------------------------
