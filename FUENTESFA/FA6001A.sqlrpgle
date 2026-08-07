     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez
 S. A.
 1999')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: VenP3001                         *
      *  APLICACION...................: Ventas                           *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 22 / 10 / 2020                   *
      *  Desarrollado Para............: La Tabacalera
 S. A.             *
      *  DESCR:                                                          *
      *                                                                  *
      *   Transfiere registros horas extras Modulos Externos Kronos      *
      *  ================================================================*
     fVenlClc01 Uf a e           k Disk
      *
     dNumeroInc        c                   Const('INC3505148')
     dContaReg         s                   Like(SqlVenlmcSt.mCodClie)
     dMonLimite        s                   Like(SqlVenlmcSt.mLimCre)
      *
     d Ef              c                   Const(x'3F')
     d*Sp              c                   Const(x'05')
     d Sp              c                   Const('|')
      *
     d Len             s              3  0 Inz(*Zeros)
     d Log             s              3  0 Inz(*Zeros)
     d  Campo99        s                   Like(SqlVenlmlt.Campo) Inz(*Blanks)
      * Terririo Norte = 01
 Sur = 02
     d  Campo01        s              5    Inz(*Blanks)
      * Zona
     d  Campo02        s              2    Inz(*Blanks)
      * Ruta
     d  Campo03        s              5    Inz(*Blanks)
      * Codigo Cliente
     d  Campo04        s              7    Inz(*Blanks)
      * Monto Limite
     d  Campo05        s             12    Inz(*Blanks)
      *
     d  TerAbr         s              1    Inz(*Blanks)
     d  CodDis         s              2  0 Inz(*Zeros)
     d  CodZon         s              2  0 Inz(*Zeros)
     d  CodRut         s              3  0 Inz(*Zeros)
     d  CodCli         s              7  0 Inz(*Zeros)
     d  Monto          s             12  2 Inz(*Zeros)
      *
      * Archivos usado en el programa
     dSqlVenlmlt     e Ds                  ExtName(Venlmlt01) Qualified
     dSqlVenlmcSt    e Ds                  ExtName(VenlmcSt1) Qualified
     dSqlVenlmcSd    e Ds                  ExtName(VenlmcSd1) Qualified
     dSqlVwClientes  e Ds                  ExtName(VwClientes) Qualified
     dSqlSegFec      e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes
sg9003
      *
     d/Copy *Libl/Fuentes
sg9001
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

           Exsr ConvierteArchivo ;

        EndSr;
        // ------------------------------------------------------
        // Proceso Para la Conversion del Archivo Plano o Txt   -
        // ------------------------------------------------------
        BegSr ConvierteArchivo ;

        ContaReg = *Zeros  ;

        // Leer Archivo
          Exec Sql
             Declare C1 cursor for
              Select *
                From Venlmlt01
              For Read Only ;

        Exec Sql
          Open c1;

        Dow True;

        Exec Sql
         Fetch Next From c1 Into :SqlVenlmlt            ;                   ;

         If SqlCod <> *Zeros      ;
           Leave;
         EndIf;

         ContaReg += 1  ;

        // Mover campo a Variables Intermedias
          Exsr MoverCampos  ;

        //Buscar datos Maestro de Clientes
        Clear SqlVwClientes  ;
         Exec Sql
            Select * Into :SqlVwClientes
              From VwClientes
 ''          Where (vwmTerri = :DisCve)
 ''            And (vwmCodClie = :CodCli)
             Fetch First 1 Rows Only       ;

        SqlCod = *Zeros ;

        CliCve = CodCli   ;
        ZonCve = CodZon   ;
        RutCve = CodRut   ;
        ClcLan = SqlVwClientes.vwmLimCre * 1     ;
        ClcLca = Monto * 1     ;
        MonLimite = Monto * 1     ;

        Monitor   ;
         ClcPva = %Dech((((ClcLca - ClcLan) / ClcLan) * 100):7:2)   ;
          On-Error ;
            ClcPva = 100.00 ;
          EndMon ;
         ClcObs = %Trim('Cambio Limite Credito Incidente ' +
                  %Trim(NumeroInc))  ;

        AplUsr = JobUsr        ;
        AplWsi = JobName       ;
        AplTst = %TimeStamp()  ;

         If DisCve = 01   ;  // Norte
            Exsr Territori01;
           Else    ;
            Exsr Territori02; // Sur
         Endif  ;

        Write VenfClcf                          ;
          Clear VenfClcf                        ;

        EndDo                                   ;

        Exec Sql
          Close c1;

        SqlCod = *Zeros ;
        EndSr ;

        //------------------------------------------------------
        // Actualizar Limite Distrito Norte = 01               -
        //------------------------------------------------------
        Begsr Territori01;

      //Limte de Credito Maestro de Cliente
          Exec Sql
               Update VenLmcst1
                 Set mLimCre = :MonLimite
               Where (mCodClie = :CliCve)  ;
          //  With NC           ;

         SqlCod = *Zeros  ;

        EndSr ;
        //------------------------------------------------------
        // Actualizar Limite Distrito Norte = 02               -
        //------------------------------------------------------
        Begsr Territori02;

      //Limte de Credito Maestro de Cliente
          Exec Sql
               Update VenLmcsd1
                 Set mLimCre = :MonLimite
               Where (mCodClie = :CliCve)  ;
          //  With NC           ;

         SqlCod = *Zeros  ;

        EndSr ;
        //------------------------------------------------------
        // Mover Campos Intermedios                            -
        //------------------------------------------------------
        Begsr MoverCampos;

        Campo99 = *Blanks  ;
        Campo01 = *Blanks  ;
        Campo02 = *Blanks  ;
        Campo03 = *Blanks  ;
        Campo04 = *Blanks  ;
        Campo05 = *Blanks  ;
        Log = *Zeros   ;

        Log = %Len(SqlVenlmlt.Campo) ;
        Campo99 = %Trim(SqlVenlmlt.Campo)  ;

       //Territorio
         Len = %Scan(Sp:Campo99)  ;
          Campo01 = %Subst(Campo99:1:Len-1) ;
          TerAbr = %Trim(%Subst(Campo01:1:1)) ;
          If TerAbr = 'N' ;
            DisCve = 01  ;
           Else   ;
            DisCve = 02  ;
          Endif  ;

          Log -= Len  ;
          Campo99 = %Subst(Campo99:Len+1:Log)  ;

       //Zona
          Len = %Scan(Sp:Campo99)  ;
          Campo02 = %Subst(Campo99:1:Len-1)  ;
          CodZon = %Dec(Campo02:2:0)        ;

          Log -= Len  ;
          Campo99 = %Subst(Campo99:Len+1:Log)  ;

       //Ruta
          Len = %Scan(Sp:Campo99)  ;
          Campo03 = %Subst(Campo99:1:Len-1) ;
          CodRut = %Dec(Campo03:3:0) ;

          Log -= Len  ;
          Campo99 = %Subst(Campo99:Len+1:Log)  ;

       //Codigo Cliente
          Len = %Scan(Sp:Campo99)  ;
          Campo04 = %Subst(Campo99:1:Len-1) ;
          CodCli = %Dec(Campo04:7:0) ;

          Log -= Len  ;
          Campo99 = %Subst(Campo99:Len+1:Log)  ;

       //Monto
          Len = %Scan(Sp:Campo99)  ;
          If Len = *Zeros ;
            Len = %Scan(' ':Campo99)  ;
          EndIf ;
          Campo05 = %Subst(Campo99:1:Len-1) ;
          Monto = %Dec(Campo05:12:2) ;

        Endsr;
        //------------------------------------------------------
        // End Program Subroutine                              -
        //------------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
        // -----------------------------------------------------
        // Subrutina Inicial                                   -
        // -----------------------------------------------------
       BegSr *Inzsr;

        //Borrar Archivo
        // Exec Sql
        //    Delete From VenfClc
        //      With NC    ;
        // SqlCod = *Zeros;

       EndSr;
      /End-Free
       // ----------------------------------------------------------
