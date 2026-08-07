     h   Copyright ('Miranda Valdez, S. A., 2005')
     h   Datedit(*Dmy)
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA3046                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 29 / 09 / 2021                   *
      *  DESCR:                                                          *
      *          Proceso Para Asignar NCF a Facturas                     *
      *  ================================================================*
     fSegDis01  If   e           k Disk
     fFac3046   Uf a e           k disk
      * Campos que Son Enviados Como Parametros
     d Mcfcve          s              2  0 Inz(01)
     d DisCve          s                   Like(SqlFacDtoH.DisCve)
     d DtoTip          s                   Like(SqlFacDtoH.DtoTip)
     d DtoNro          s                   Like(SqlFacDtoH.DtoNro)
     d DtoMne          s                   Like(SqlFacDtoH.DtoMne)
     d FecIso          s                   Like(SqlSegFec.FecIso)
     d NcfNro          s                   Like(SqlFacDed.NcfNro)
     d MonCve          s                   Like(SqlCxcAdc.MonCve)
     d TcfCve          s                   Like(SqlCxcAdc.TcfCve)
     d NumNcf          s                   Like(SqlFacDed.NcfNro)
      *
     d FechaFacIso     s                   Like(SqlSegFec.FecIso)
     d FechaFinNcf     s                   Like(SqlSegFec.FecIso)
     d TipProNcf       s              1    Inz('E')
     d StatusNcf       s               n   Inz(*Off)

     d SqlFacDtoh    e Ds                  ExtName(FacDtoh) Qualified
     d SqlFacDed     e Ds                  ExtName(FacDed) Qualified
     d SqlCxcAdc     e Ds                  ExtName(CxcAdc) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified

     d/Copy *Libl/Fuentes,sg9003

     d/Copy *Libl/Fuentes,sg9001
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
        Exsr CrearTablas  ;
        Exsr InsertarReg  ;
        Exsr Proceso01    ;
        Exsr Proceso02    ;
        Exsr Proceso03    ;
        Exsr Proceso04    ;
        Exsr BorrarTablas ;
        Exsr EndProgram   ;
        // ------------------------------------------------------
        // Seleccionar Registros                                -
        // ------------------------------------------------------
        BegSr Proceso01    ;

       //Seleccionar Registro
        Exec Sql
           Declare C1 cursor for
           Select T2.DisCve, T2.DtoTip, T2.DtoNro, T1.Ncfnro,
                  T9.FecIso, T3.DtoMne, T4.MonCve, T4.TcfCve
             From Duplicados T1
             Join FacDed T2
               On (T1.NcfNro = T2.NcfNro)
             Join FacDtoh T3
               On (T2.DisCve = T3.DisCve)
              And (T2.DtoTip = T3.DtoTip)
              And (T2.DtoNro = T3.DtoNro)
             Join CxcAdc T4
               On (T3.CliCve = T4.CliCve)
             Join SegFec T9
               On (T3.DtoAno = T9.FecAno)
              And (T3.DtoMes = T9.FecMes)
              And (T3.DtoDia = T9.FecDia)
            Where (T9.FecYmd > 20221225)
              And (T2.DtoTip = 4)
              And (T2.DisCve = 16)
              And Substring(T1.NcfNro,1,3) = 'B01'
           Order By T2.DisCve, T1.NcfNro
             For Read Only   ;

        Exec Sql
           Open C1 ;

        Dow True;

          Exec Sql
          Fetch Next From C1 Into :DisCve, :DtoTip, :DtoNro, :NcfNro,
                                  :FecIso, :DtoMne, :MonCve, :TcfCve   ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        // Mover Campos

        Chain (DisCve) SegDisf ;

        DocFec = FecIso ;
        NcfDup = NcfNro ;
        TcfCve = %Dec(%Subst(NcfNro:2:2):2:0) ;

        FechaFacIso = %Date() ;

        //Buscar numero el Numero de Comprobante y Actualizar
           Exsr Actualizar  ;

         Write Fac3046f ;
         Clear Fac3046f ;

        EndDo    ;

         Exec SQL
            Close C1   ;

         SqlCod = *Zeros   ;
        EndSr  ;
        // ------------------------------------------------------
        // Seleccionar Registros SS Santigo y Vicente Noble     -
        // ------------------------------------------------------
        BegSr Proceso02    ;

       //Seleccionar Registro
        Exec Sql
           Declare C2 cursor for
           Select T2.DisCve, T2.Dtotip, T2.DtoNro, T1.Ncfnro,
                  T9.FecIso, T2.DtoMne, T3.MonCve, T3.TcfCve
             From Duplicados01 T1
             Join FacDto14jn T2
               On (T1.NcfNro = T2.NcfNro)
              And (T1.DtoMne = T2.DtoMne)
             Join CxcAdc T3
               On (T2.CliCve = T3.CliCve)
             Join SegFec T9
               On (T2.DtoFec = T9.FecYmd)
            Where (T9.FecYmd > 20221225)
            Order By T1.NcfNro
              For Read Only   ;

        Exec Sql
           Open C2 ;

        Dow True;

          Exec Sql
          Fetch Next From C2 Into :DisCve, :DtoTip, :DtoNro, :NcfNro,
                                  :FecIso, :DtoMne, :MonCve, :TcfCve   ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        If NcfNro = 'B0101895496' And DisCve = 15 ;
           Iter ;
         EndIf ;

        // Mover Campos

        Chain (DisCve) SegDisf ;

        DocFec = FecIso ;
        NcfDup = NcfNro ;
        TcfCve = %Dec(%Subst(NcfNro:2:2):2:0) ;

        FechaFacIso = %Date() ;

        //Buscar numero el Numero de Comprobante y Actualizar
           Exsr Actualizar  ;

         Write Fac3046f ;
         Clear Fac3046f ;

        EndDo    ;

         Exec SQL
            Close C2   ;

         SqlCod = *Zeros   ;
        EndSr  ;
        // ------------------------------------------------------
        // Seleccionar Registros SS Imbert y Jacobo             -
        // ------------------------------------------------------
        BegSr Proceso03    ;

       //Seleccionar Registro
        Exec Sql
           Declare C3 cursor for
           Select T2.DisCve, T2.Dtotip, T2.DtoNro, T1.Ncfnro,
                  T9.FecIso, T2.DtoMne, T3.MonCve, T3.TcfCve
             From Duplicados02 T1
             Join FacDto14jn T2
               On (T1.NcfNro = T2.NcfNro)
              And (T1.DtoMne = T2.DtoMne)
             Join CxcAdc T3
               On (T2.CliCve = T3.CliCve)
             Join SegFec T9
               On (T2.DtoFec = T9.FecYmd)
            Where (T9.FecYmd > 20221225)
            Order By T1.NcfNro
              For Read Only   ;

        Exec Sql
           Open C3 ;

        Dow True;

          Exec Sql
          Fetch Next From C3 Into :DisCve, :DtoTip, :DtoNro, :NcfNro,
                                  :FecIso, :DtoMne, :MonCve, :TcfCve   ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        // Mover Campos

        Chain (DisCve) SegDisf ;

        DocFec = FecIso ;
        NcfDup = NcfNro ;
        TcfCve = %Dec(%Subst(NcfNro:2:2):2:0) ;

        FechaFacIso = %Date() ;

        //Buscar numero el Numero de Comprobante y Actualizar
           Exsr Actualizar  ;

         Write Fac3046f ;
         Clear Fac3046f ;

        EndDo    ;

         Exec SQL
            Close C3   ;

         SqlCod = *Zeros   ;
        EndSr  ;
        // ------------------------------------------------------
        // Seleccionar Registros SS Las Canas                   -
        // ------------------------------------------------------
        BegSr Proceso04    ;

       //Seleccionar Registro
        Exec Sql
           Declare C4 cursor for
           Select T2.DisCve, T2.Dtotip, T2.DtoNro, T1.Ncfnro,
                  T9.FecIso, T2.DtoMne, T3.MonCve, T3.TcfCve
             From Duplicados03 T1
             Join FacDto14jn T2
               On (T1.NcfNro = T2.NcfNro)
              And (T1.DtoMne = T2.DtoMne)
             Join CxcAdc T3
               On (T2.CliCve = T3.CliCve)
             Join SegFec T9
               On (T2.DtoFec = T9.FecYmd)
            Where (T9.FecYmd > 20221225)
            Order By T1.NcfNro
              For Read Only   ;

        Exec Sql
           Open C4 ;

        Dow True;

          Exec Sql
          Fetch Next From C4 Into :DisCve, :DtoTip, :DtoNro, :NcfNro,
                                  :FecIso, :DtoMne, :MonCve, :TcfCve   ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        // Mover Campos

        Chain (DisCve) SegDisf ;

        DocFec = FecIso ;
        NcfDup = NcfNro ;
        TcfCve = %Dec(%Subst(NcfNro:2:2):2:0) ;

        FechaFacIso = %Date() ;

        //Buscar numero el Numero de Comprobante y Actualizar
           Exsr Actualizar  ;

         Write Fac3046f ;
         Clear Fac3046f ;

        EndDo    ;

         Exec SQL
            Close C4   ;

         SqlCod = *Zeros   ;
        EndSr  ;
        // ------------------------------------------------------
        // Proceso para Crear Tablas
        // ------------------------------------------------------
        Begsr CrearTablas  ;

       //Declarar la tabla temporal del Intermedia
            Exec Sql
              Declare global temporary table Duplicados
              (NcfNro Varchar(19), Cantidad Dec(8))  ;

            SqlCod = *Zeros  ;

       //Declarar la tabla temporal del Intermedia
            Exec Sql
              Declare global temporary table Duplicados01
              (NcfNro Varchar(19), DtoMne Dec(12,2))  ;

            SqlCod = *Zeros  ;

       //Declarar la tabla temporal del Intermedia
            Exec Sql
              Declare global temporary table Duplicados02
              (NcfNro Varchar(19), DtoMne Dec(12,2))  ;

            SqlCod = *Zeros  ;

       //Declarar la tabla temporal del Intermedia
            Exec Sql
              Declare global temporary table Duplicados03
              (NcfNro Varchar(19), DtoMne Dec(12,2))  ;

            SqlCod = *Zeros  ;
        Endsr;
        // ------------------------------------------------------
        // Proceso para Insertar Los registros Duplicados
        // ------------------------------------------------------
        Begsr InsertarReg ;

       //Insertar Registros Duplicados Facturas
          Exec Sql
           Insert Into Duplicados
           Select NcfNro, Count(*)
             From FacDed
            Where NcfNro <> ' '
              And Substring(NcfNro,1,1) = 'B'
            Group by NcfNro
           Having Count(*) > 1    ;

            SqlCod = *Zeros  ;

       //Insertar Registros Duplicados Facturas Servicios
          Exec Sql
           Insert Into Duplicados
           Select T1.NcfNro, 0
             From FacDed T1
            Where T1.NcfNro <> ' '
              And Substring(T1.NcfNro,1,1) = 'B'
              And Exists(Select * From FpsFach T2
               Where (T1.Ncfnro = T2.NcfNro))     ;

            SqlCod = *Zeros  ;

       //Insertar Registros Duplicados Estaciones 08 y 15
          Exec Sql
           Insert Into Duplicados01
           Select T1.Ncfnro, Max(T3.DtoMne)
             From Duplicados T1
             Join FacDed T2
               On (T1.NcfNro = T2.NcfNro)
             Join FacDtoh T3
               On (T2.DisCve = T3.DisCve)
              And (T2.DtoTip = T3.DtoTip)
              And (T2.DtoNro = T3.DtoNro)
             Join SegFec T9
               On (T3.DtoAno = T9.FecAno)
              And (T3.DtoMes = T9.FecMes)
              And (T3.DtoDia = T9.FecDia)
            Where (T9.FecYmd > 20221225)
              And (T2.DtoTip = 4)
              And (T2.DisCve In(8, 15))
              And Not Exists(Select * From Duplicados01 T8
              Where (T1.NcfNro = T8.NcfNro)
                And (T3.DtoMne = T8.DtoMne))
          Group By T1.NcfNro                                                  ;

         SqlCod = *Zeros   ;

       //Insertar Registros Duplicados Estaciones 18 y 21
          Exec Sql
           Insert Into Duplicados02
           Select T1.Ncfnro, Max(T3.DtoMne)
             From Duplicados T1
             Join FacDed T2
               On (T1.NcfNro = T2.NcfNro)
             Join FacDtoh T3
               On (T2.DisCve = T3.DisCve)
              And (T2.DtoTip = T3.DtoTip)
              And (T2.DtoNro = T3.DtoNro)
             Join SegFec T9
               On (T3.DtoAno = T9.FecAno)
              And (T3.DtoMes = T9.FecMes)
              And (T3.DtoDia = T9.FecDia)
            Where (T9.FecYmd > 20221225)
              And (T2.DtoTip = 4)
              And (T2.DisCve In(18, 21))
              And Not Exists(Select * From Duplicados02 T8
              Where (T1.NcfNro = T8.NcfNro)
                And (T3.DtoMne = T8.DtoMne))
          Group By T1.NcfNro                                                  ;

         SqlCod = *Zeros   ;

       //Insertar Registros Duplicado Estacion 13
          Exec Sql
           Insert Into Duplicados03
           Select T1.Ncfnro, Max(T3.DtoMne)
             From Duplicados T1
             Join FacDed T2
               On (T1.NcfNro = T2.NcfNro)
             Join FacDtoh T3
               On (T2.DisCve = T3.DisCve)
              And (T2.DtoTip = T3.DtoTip)
              And (T2.DtoNro = T3.DtoNro)
             Join SegFec T9
               On (T3.DtoAno = T9.FecAno)
              And (T3.DtoMes = T9.FecMes)
              And (T3.DtoDia = T9.FecDia)
            Where (T9.FecYmd > 20221225)
              And (T2.DtoTip = 4)
              And (T2.DisCve In(13))
              And Not Exists(Select * From Duplicados03 T8
              Where (T1.NcfNro = T8.NcfNro)
                And (T3.DtoMne = T8.DtoMne))
          Group By T1.NcfNro                                                  ;

         SqlCod = *Zeros   ;

        Endsr;
        // ------------------------------------------------------
        // Proceso para Borrar Tablas
        // ------------------------------------------------------
        Begsr BorrarTablas ;

       //Borrar la tabla intermedia
              Exec Sql
               Drop Table Duplicados  ;

            SqlCod = *Zeros  ;

              Exec Sql
               Drop Table Duplicados01  ;

            SqlCod = *Zeros  ;

              Exec Sql
               Drop Table Duplicados02  ;

              Exec Sql
               Drop Table Duplicados03  ;

            SqlCod = *Zeros  ;

        Endsr;
        // -----------------------------------------------------
        // Buscar y Actualizar Numero de Comprobante           -
        // -----------------------------------------------------
        Begsr Actualizar ;

           NumNcf = *Blanks  ;

 ''        Exsr Buscar_Ncf     ;
           NcfNue = NumNcf     ;

        //Asginar el Numero de Comprobantes
           Exec Sql
             Update FacDed Set NcfNro = :NumNcf
              Where (DisCve = :DisCve)
                And (DtoTip = :DtoTip)
                And (DtoNro = :DtoNro) ;
        //      With NC     ;

         SqlCod = *Zeros   ;

        Endsr;
        //------------------------------------------------------
        // End Program Subroutine                              -
        //------------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
L002  *-----------------------------------------------------
 ''   *  Buscar Numero de Ncf                              -
 ''   *-----------------------------------------------------
 ''  c     Buscar_Ncf    BegSr
 ''   *
 ''  c                   Clear                   NumNcf
 ''   *
 ''  c                   Call      'SG7011'
 ''  c                   Parm      01            Mcfcve
 ''  c                   Parm                    DisCve
 ''  c                   Parm                    MonCve
 ''  c                   Parm                    TcfCve
 ''  c                   Parm                    NumNcf
      *
 ''  c                   Parm                    FechaFacIso
 ''  c                   Parm                    FechaFinNcf
 ''  c                   Parm                    TipProNcf
 ''  c                   Parm                    StatusNcf
 ''   *
L002 c                   EndSr
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
        Begsr *Inzsr;

        // Borrar Archivo de Log
          Exec Sql
               Delete From Fac3046
                 With NC;

        Endsr;
        // -----------------------------------------------------
