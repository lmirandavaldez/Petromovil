     h   Copyright ('Miranda Valdez, S. A., 1997')
     H   DEBUG OPTION(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA1064A                          *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 08 / 04 / 2019                   *
      *  DESCR:                                                          *
      *      Actualiza la fecha de Ingreso con fecha primera factura     *
      *  ================================================================*
     fFac1064A  Uf a e           k Disk
      *
     d CliCve          s                   Like(SqlCxcCli.CliCve)
     d DtoFec          s                   Like(SqlSegFec.FecYmd)
     d IngFec          s                   Like(SqlSegFec.FecYmd)
      *
     dSqlFacDtod01   e Ds                  ExtName(FacDtod01) Qualified
     dSqlCxcCli      e Ds                  ExtName(CxcCli01) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
      /Copy Fuentes,SG9001
      *---------------------------------------------------------
      *               Inicio del Programa                      -
      *---------------------------------------------------------
     c                   Exsr      Proceso
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccion de Registros                                   *
      * ----------------------------------------------------------*
     c     Proceso       BegSr
      *
     c/Exec Sql
     c+   Declare C1 cursor for
     c+   Select CliCve, Min(DtoFec)
     c+    From FacDtod01
     c+   Group by CliCve
     c+   Order by CliCve
     c+   For Read Only
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 Into :CliCve, :DtoFec
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   EndIf
      * Buscar la fecha de Ingreso en el maestro
     c                   Clear                   SqlCxcCli
     c/Exec Sql
     c+   Select * Into :SqlCxcCli
     c+     From CxcCli01
     c+    Where (CliCve = :CliCve)
     c/End-Exec
     c                   Clear                   SqlCod

       IngFec = %Dec(%Date(SqlCxcCli.CreTst):*Iso) ;

        If IngFec < DtoFec ;
           IngFec = DtoFec ;
         EndIf ;

       FecIng = %Date(IngFec) ;
       FecPfa = %Date(DtoFec) ;

       Write Fac1064af ;
       Clear Fac1064af ;

       EndDo ;
      *
     c/Exec SQL
     c+    Close C1
     c/End-exec
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        BegSr

        // Borrar detalle Gastos
          Exec Sql
               Delete From Fac1064A
                 With NC;

     c                   EndSr
