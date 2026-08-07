     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  Nombre del programa .........: FA8005C                          *
      *  Aplicacion...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 12 / 02 / 2026                   *
      *  Descripcion:                                                    *
      *         Pasar Parametros                                         *
      *  ================================================================*
      *
      * Campos Uso Parametros de Entrada
     d PlaDis          s                   Like(SqlFacPlah.PlaDis)
     d PlaNro          s                   Like(SqlFacPlah.PlaNro)
     d PlaFpl          s                   Like(SqlFacPlah.PlaFpl)
     d VehFic          s                   Like(SqlFacPlah.VehFic)
     d TcfCve          s                   Like(SqlSegNcf.TcfCve)
     d CanNcf          s                   Like(SqlSegNcf.NcfSec)
     d CanReg          s                   Like(SqlSegNcf.NcfSec)
      *
      * Campos que Son Enviados Como Parametros
      *
      * Campos Usados en el Programa
      *
      **Archivos Externos
     d SqlVwFac00009 e Ds                  ExtName(VwFac00009) Qualified
     d SqlFacPlah    e Ds                  ExtName(FacPlah) Qualified
     d SqlSegNcf     e Ds                  ExtName(SegNcf) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Buscar Comprobantes
     d BuscarComp      Pr                  ExtPgm('FA8005')
     d  PlaDis_1                           Like(SqlFacPlah.PlaDis)
     d  PlaNro_1                           Like(SqlFacPlah.PlaNro)
     d  PlaFpl_1                           Like(SqlFacPlah.PlaFpl)
     d  VehFic_1                           Like(SqlFacPlah.VehFic)
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
        // Seleccionar Registros                                -
        // ------------------------------------------------------
         BegSr Proceso;

           CanReg = *Zeros ;

        // Leer Archivo
           Exec Sql
              Declare C1 cursor for
              Select Ficha00001,
                     Codig00001,
                     Numer00001,
                     Fecha00001
                From VwFac00009
          //   Where (Tipo_00001 In (15, 45))
          //   Where (Ficha00001 In ('L125', 'L79', 'L94'))
          //     And (Codig00001 = :PlaCod)
          //     And (Numer00001 = :PlaNum)
          //     And (Fecha00001 = :PlaFec)
            Group By Ficha00001, Codig00001, Numer00001,
                     Fecha00001
            Order By Ficha00001, Codig00001, Numer00001,
                     Fecha00001
            For Read Only ;

        Exec Sql
          Open c1;

        Dow True;

          Exec Sql
            Fetch Next From c1 Into :VehFic, :PlaDis, :PlaNro, :PlaFpl ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

           CanReg += 1  ;

           If CanReg > 1 ;
              Leave ;
            Endif ;

       //Llamar Programa Buscar Comprobantes
          BuscarComp(PlaDis :PlaNro :PlaFpl :VehFic)                 ;

         EndDo ;

         Exec Sql
            Close c1;

         SqlCod = *Zeros;

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

       EndSr;
      /End-Free
       // ----------------------------------------------------------
