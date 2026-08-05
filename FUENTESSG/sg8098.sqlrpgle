     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Debug Option(*SRCSTMT:*NODEBUGIO) Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SG8098                           *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 19 / 08 / 2016                   *
      *                                                                  *
      *       Verifica si se esta ejecutando el proceso                  *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 04 / 08 / 2026                   *
      *  Codigo Modificacion..........:                                  *
      *  DESCR: Poner en Sql y formato Free                              *
      *  ================================================================*
     d StaPro          s               n   Inz(*Off)
      *
      * Archivos usado en el programa
     d SqlSegCep     e Ds                  ExtName(SegCep) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **SG8098 Prototype
     d SG8098          Pr
     d  CodCia                             Like(SqlSegCep.CiaCve)
     d  CodPgm                             Like(SqlSegCep.PgmCve)
     d  PgmSta                             Like(Ema)
      *
      **SG8098 Program Interface
     d SG8098          Pi
     d  CodCia                             Like(SqlSegCep.CiaCve)
     d  CodPgm                             Like(SqlSegCep.PgmCve)
     d  PgmSta                             Like(Ema)
      *
      * Main Program
      *
      /Free
       // ------------------------------------------------------
       // Main Process                                         -
       // ------------------------------------------------------
           Exsr Ejecucion ;
           Exsr EndProgram;
       // ------------------------------------------------------
       // Verifica el Status del Programa                      -
       // ------------------------------------------------------
           BegSr Ejecucion ;

      //Verifica si el Programa esta en Ejecucion
          StaPro = *Off ;

          Exec Sql
             Select '1' Into :StaPro
               From SegCep
              Where (CiaCve = :CodCia)
                And (PgmCve = :CodPgm)
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

         //Si StaPro = *On esta en Ejecucion
             If StaPro = *On ;
                PgmSta = 'S' ;
              Else ;
                PgmSta = 'N' ;
             EndIf   ;

        EndSr ;
       // ------------------------------------------------------
       // End Program Subroutine                              -
       // ------------------------------------------------------
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
       // -----------------------------------------------------
