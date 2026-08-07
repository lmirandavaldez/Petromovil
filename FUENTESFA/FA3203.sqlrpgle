     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 2005')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3203                           *
      *  APLICACION...................: facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 01 / 09 / 2012                   *
      *  DESCR:                                                          *
      *            Proceso Crear Datos Cuotas de ventas clientes         *
      *==================================================================*
     d FechaDes        s               d   DatFmt(*Iso)
     d FechaHas        s               d   DatFmt(*Iso)
     d Meses           s              8s 0 Inz(*Zeros)
     d FecDes          s                   Like(SqlSegFec.FecYmd)
     d FecHas          s                   Like(SqlSegFec.FecYmd)
     d CuoPro          s                   Like(DtoCua)
     d CuoMax          s                   Like(DtoCua)
     d CuoAvg          s                   Like(DtoCua)
      *
     d FechaInicio     s              8s 0 Inz(20210101)
     d FechaIni        s               d   DatFmt(*Iso)
     d FechaDia        s               d   DatFmt(*Iso)
     d MesesTra        s             10  0 Inz(*Zeros)
     d Status          s               n   Inz(*Off)
      *
      **Archivos Externos
     dSqlFacDtod     e Ds                  ExtName(FacDtod)
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Copiar Presupesto Clientes Migrados
     d ClientesMig     Pr                  ExtPgm('FA3299')
      *
      **FA3203 Prototype
     d FA3203          Pr
     d  FechaD                        8
     d  FechaH                        8
      *
      **FA3203 Program Interface
     d FA3203          Pi
     d  FechaD                        8
     d  FechaH                        8
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------

        // Proceso Para crear Tabla Temporal
           Exsr Crear_Tabla ;

        // Proceso de Actualizacion
           Exsr Proceso ;

        // Proceso Para Borrar Tabla Temporal
           Exsr Borrar_Tabla ;

        //Para Copiar el Presupuesto de clientes Migrado
           If Status = *On ;
              Exsr Copia_Presu ;
           EndIf  ;

           Exsr EndProgram;
        // ------------------------------------------------------
        // Seleccionar Registros para Procesar                  -
        // ------------------------------------------------------
           Begsr Proceso       ;

           Exec Sql
           Insert Into Ventas_Clientes
           (Select T1.Clicve,
                   T9.FecAno,
                   T9.FecMes,
                   T1.ArtCve,
                   Sum(T1.DtoCua)
              From FacDtod T1
              Join CxcCli T2
                On (T1.CliCve = T2.CliCve)
              Join InvArt T3
                On (T1.ArtCve = T3.ArtCve)
              Join SegDis T4
                On (T1.DisCve = T4.DisCve)
              Join SegFec T9
                On (T1.DtoAno = T9.FecAno)
               And (T1.DtoMes = T9.FecMes)
               And (T1.DtoDia = T9.FecDia)
             Where (T2.CliSta = 'A')
               And (T3.ArtPpr = 'S')
               And (T3.ArtSta = 'A')
               And (T4.DisTip = 'N')
               And (T9.FecYmd Between :FecDes And :FecHas)
          Group By T1.CliCve, T9.FecAno, T9.FecMes, T1.ArtCve)  ;

          SqlCod = *Zeros ;

          //  Select Cli, Art, Round(Sum(Can),-2), Round((Avg(Can)/:Meses),-2),

           Exec Sql
            Declare C1 Cursor for
              Select Cli As CliCve,
                     Art As ArtCve,
                     Round(Sum(Can),-0) As DtoCuo,
                     Round((Sum(Can)/:Meses),-0) As CuaPro,
                     Round(Max(Can),-0) As CuoMax,
                     Round(Avg(Can),-0) As CuoAvg
              From Ventas_Clientes
              Group By Cli, Art
              Order By Cli, Art
            For Read Only           ;

          Exec Sql
            Open c1;

          Dow True;

          Exec Sql
            Fetch Next From c1 Into :CliCve, :ArtCve, :DtoCua, :CuoPro,
                                    :CuoMax, :CuoAvg                   ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        //Si El Campo CuoPro viene en cero, Usar CuoAvg
            If CuoPro = *Zeros;
               CuoPro = CuoAvg;
            EndIf;

        //Crear Cuota de Ventas por Clientes y Productos
           Exec Sql
             Insert Into FacCpc
                  (CliCve, ArtCve, CpcCvc, CpcCvm, CpcCvt,
                   CpcCdd, CpcCvp)
             Select :CliCve, :ArtCve, :CuoPro, :CuoMax, :DtoCua,
                     0, 0
               From Sysibm/Sysdummy1
                Where Not Exists (
                        Select 1
                           From FacCpc
                          Where (CliCve = :CliCve)
                            And (ArtCve = :ArtCve));

           SqlCod = *Zeros ;

           EndDo ;

           Exec Sql
           Close c1;

           SqlCod = *Zeros ;
           EndSr ;
        // ------------------------------------------------------
        // Crear Tabla Temporal                                 -
        // ------------------------------------------------------
           Begsr Crear_Tabla   ;

           Exec Sql
           Declare Global Temporary Table Ventas_Clientes
           (Cli Dec(7), Ano Dec(4),  Mes dec(02), art varchar(20),
            Can Dec(12, 2))  ;

           SqlCod = *Zeros ;

           EndSr ;
        // ------------------------------------------------------
        // Borrar Tabla Temporal                                -
        // ------------------------------------------------------
           Begsr Borrar_Tabla  ;

           Exec Sql
           Drop Table Ventas_Clientes  ;

           SqlCod = *Zeros ;

           EndSr ;
        // -----------------------------------------------------
        // Para Copiar Presupesto Clientes Migrado             -
        // -----------------------------------------------------
           Begsr Copia_Presu ;

           ClientesMig( );

           EndSr ;
        // -----------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
           Begsr EndProgram;

           *Inlr = *On;
           Return;

           Endsr;
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
           BegSr *Inzsr;

           FecDes = %Dec(FeChaD:8:0)  ;
           FecHas = %Dec(FeChaH:8:0)  ;

           FecDes = %Dec(%Date(FecDes:*Eur):*Iso) ;
           FecHas = %Dec(%Date(FecHas:*Eur):*Iso) ;
           FechaDes = %Date(FecDes)               ;
           FechaHas = %Date(FecHas)               ;
           Meses = %Diff(FechaHas :FechaDes :*Months) + 1 ;

           FechaIni = %Date(FechaInicio:*Iso)      ;
           FechaDia = %Date(*Date)  ;
           MesesTra = %Diff(FechaDia:FechaIni:*Months);

        //Si transcurrieron 12 Meses significa que tiene hitoria en Petromovil

           If MesesTra < 12   ;
              Status = *On     ;
            Else ;
              Status = *Off    ;
           EndIf;

        // Borrar la Tabla
           Exec Sql
               Delete From FACCPC
                 With NC;

           EndSr;
      /End-Free
        // -----------------------------------------------------
