     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Debug Option(*SRCSTMT:*NODEBUGIO) Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: IT8098                           *
      *  APLICACION...................: Transf. Modulos Externos         *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 19 / 09 / 2013                   *
      *                                                                  *
      *       Verifica si se esta ejecutando el proceso                  *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 05 / 08 / 2026                   *
      *  Codigo Modificacion..........:                                  *
      *  DESCR: Poner en Sql y formato Free                              *
      *  ================================================================*
     d StaPro          s               n   Inz(*Off)
     d CejCve          s              1    Inz('@')
      *
      * Archivos usado en el programa
     d SqlIteCej     e Ds                  ExtName(IteCej) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **IT8098 Prototype
     d IT8098          Pr
     d  PgmSta                             Like(Ema)
      *
      **IT8098 Program Interface
     d IT8098          Pi
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
               From IteCej
              Where (CejCve = :CejCve)
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
