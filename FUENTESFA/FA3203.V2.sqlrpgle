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
     fFacCpc01  Uf a e           k disk
      *
     d FechaDes        s               d   DatFmt(*Iso)
     d FechaHas        s               d   DatFmt(*Iso)
     d Meses           s              8s 0 Inz(*Zeros)
     d FecDes          s                   Like(FecYmd)
     d FecHas          s                   Like(FecYmd)
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
     dSqlFacDtod     e Ds                  ExtName(FacDtod)
     dSqlSegFec      e Ds                  ExtName(SegFec)
      *
      /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    FechaD            8
     c                   Parm                    FechaH            8
      *
     c                   Eval      FecDes = %Dec(FeChaD:8:0)
     c                   Eval      FecHas = %Dec(FeChaH:8:0)
      *
     c                   Eval      FecDes = %Dec(%Date(FecDes:*Eur):*Iso)
     c                   Eval      FecHas = %Dec(%Date(FecHas:*Eur):*Iso)
     c                   Eval      FechaDes = %Date(FecDes)
     c                   Eval      FechaHas = %Date(FecHas)
     c                   Eval      Meses = %Diff(FechaHas :FechaDes :*Months) +1
      *
      * Proceso Para crear Tabla Temporal
     c                   Exsr      Crear_Tabla
      * Proceso de Actualizacion
     c                   Exsr      Proceso
      * Proceso Para Borrar Tabla Temporal
     c                   Exsr      Borrar_Tabla
      *
    *  Para Copiar el Presupuesto de clientes Migrado
     c                   If        Status = *On
     c                   Exsr      Copia_Presu
     c                   EndIf
      *
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccionar documento para modificar                     *
      * ----------------------------------------------------------*
     c     Proceso       BegSr
      *
     c/Exec Sql
     c+ Insert Into Ventas_Clientes
     c+ (Select T1.Clicve, T9.FecAno, T9.FecMes, T1.ArtCve, Sum(T1.DtoCua)
     c+    From FacDtod T1
     c+    Join CxcCli T2
     c+      On (T1.CliCve = T2.CliCve)
     c+    Join InvArt T3
     c+      On (T1.ArtCve = T3.ArtCve)
     c+    Join SegDis T4
     c+      On (T1.DisCve = T4.DisCve)
     c+    Join SegFec T9
     c+      On (T1.DtoAno = T9.FecAno)
     c+     And (T1.DtoMes = T9.FecMes)
     c+     And (T1.DtoDia = T9.FecDia)
     c+   Where (T2.CliSta = 'A')
     c+     And (T3.ArtPpr = 'S')
     c+     And (T3.ArtSta = 'A')
     c+     And (T4.DisTip = 'N')
     c+     And (T9.FecYmd Between :FecDes And :FecHas)
     c+ Group By T1.CliCve, T9.FecAno, T9.FecMes, T1.ArtCve)
     c/End-Exec
      *
     c                   Clear                   SqlCod
      *
     c*       Select Cli, Art, Round(Sum(Can),-2), Round((Avg(Can)/:Meses),-2),
     c/Exec Sql
     c+   Declare C1 cursor for
     c+       Select Cli, Art, Round(Sum(Can),-0), Round((Sum(Can)/:Meses),-0),
     c+              Round(Max(Can),-0), Round(Avg(Can),-0)
     c+       From Ventas_Clientes
     c+       Group By Cli, Art
     c+       Order By Cli, Art
     c+     For Read Only
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 into :CliCve, :ArtCve, :DtoCua, :CuoPro, :CuoMax,
     c+                       :CuoAvg
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   EndIf

       // Actualizar la Tabla de Cuota Productos Clientes
        Chain (CliCve :ArtCve) FacCpcf ;
           If Not %Found(FacCpc01)  ;

              If CuoPro = *Zeros ;
                 CuoPro = CuoAvg ;
               EndIf  ;

              CpcCvc = CuoPro  ;
              CpcCvm = CuoMax  ;
              CpcCvt = DtoCua  ;
             Write FacCpcf                   ;
            EndIf;
         Clear FacCpcf                       ;
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C1
     c/End-exec
      *
     c                   EndSr
      * ----------------------------------------------------------*
      *  Crear Tabla Temporal                                     *
      * ----------------------------------------------------------*
     c     Crear_Tabla   BegSr
      *
     c/Exec Sql
     c+ Declare Global Temporary Table Ventas_Clientes
     c+ (Cli Dec(7), Ano Dec(4),  Mes dec(02), art varchar(20),
     c+  Can Dec(12, 2))
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Borrar Tabla Temporal                                    *
      * ----------------------------------------------------------*
     c     Borrar_Tabla  BegSr
      *
     c/Exec Sql
     c+ Drop Table Ventas_Clientes
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Ejecutar Programa Para Copiar Presupesto Clientes Migrado*
      * ----------------------------------------------------------*
     c     Copia_Presu   BegSr
      *
     c                   Call      'FA3299'
      *
     c                   EndSr
L005  /Free
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
       BegSr *Inzsr;

         FechaIni = %Date(FechaInicio:*Iso)      ;
L005     FechaDia = %Date(*Date)  ;
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
       // ----------------------------------------------------------
