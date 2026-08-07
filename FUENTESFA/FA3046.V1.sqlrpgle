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
      * Campos que Son Enviados Como Parametros
     d Mcfcve          s              2  0 Inz(01)
     d DisCve          s                   Like(SqlFacDtoH.DisCve)
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
        Exsr Ejecuta ;
        Exsr EndProgram;
        // ------------------------------------------------------
        // Seleccionar Registros                                -
        // ------------------------------------------------------
        BegSr Ejecuta ;

        Exec Sql
           Declare C1 cursor for
               Select *
                 From FacDtoh T1
                 Join FacDed T2
                   On (T1.DisCve = T2.DisCve)
                  And (T1.DtoTip = T2.DtoTip)
                  And (T1.DtoNro = T2.DtoNro)
                 Join CxcAdc T3
                   On (T1.CliCve = T3.CliCve)
                 Join SegFec T10
                   On (T1.DtoDia = T10.FecDia)
                  And (T1.DtoMes = T10.FecMes)
                  And (T1.DtoAno = T10.FecAno)
                Where (FecYmd Between 20210101 and 20211231)
                  And (T2.NcfNro = ' ')
                  And (T1.DtoTip = 6)
             Order By T1.DisCve, T1.DtoTip, T1.DtoNro
             For Read Only   ;

        Exec Sql
           Open C1 ;

        Dow True;

          Exec Sql
          Fetch C1 Into :SqlFacDtoh, :SqlFacDed, :SqlCxcAdc,
                        :SqlSegFec                              ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

        // Mover Campos

        DisCve = SqlFacDtoh.DisCve    ;
        MonCve = SqlCxcAdc.MonCve     ;
        TcfCve = SqlCxcAdc.TcfCve     ;
        FechaFacIso = SqlSegFec.FecIso ;

L002    // Buscar numero de Ncf
 ''     Exsr Buscar_Ncf     ;

        // Asginar el Numero de Comprobantes
         Exec Sql
           Update FacDed Set NcfNro = :NumNcf
            Where (DisCve = :SqlFacDtoh.DisCve)
              And (DtoTip = :SqlFacDtoh.DtoTip)
              And (DtoNro = :SqlFacDtoh.DtoNro) ;
        //    With NC     ;

         SqlCod = *Zeros   ;

        EndDo    ;

         Exec SQL
            Close C1   ;
        EndSr  ;
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
        //------------------------------------------------------
        // End Program Subroutine                              -
        //------------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
        // -----------------------------------------------------
