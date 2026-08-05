     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Debug Option(*SRCSTMT:*NODEBUGIO) Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SG8099                           *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 19 / 08 / 2016                   *
      *                                                                  *
      *       Actualizar control ejecucion procesos                      *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 04 / 08 / 2026                   *
      *  Codigo Modificacion..........:                                  *
      *  DESCR: Poner en Sql y formato Free                              *
      *  ================================================================*
     d StaPro          s               n   Inz(*Off)
     d TstApl          s                   Like(SqlSegCep.AplTst)
      *
      * Archivos usado en el programa
     d SqlSegCep     e Ds                  ExtName(SegCep) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **SG8099 Prototype
     d SG8099          Pr
     d  CodCia                             Like(SqlSegCep.CiaCve)
     d  CodPgm                             Like(SqlSegCep.PgmCve)
      *
      **SG8099 Program Interface
     d SG8099          Pi
     d  CodCia                             Like(SqlSegCep.CiaCve)
     d  CodPgm                             Like(SqlSegCep.PgmCve)
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
       // Actualiaza Control de Ejecucion                      -
       // ------------------------------------------------------
          BegSr Ejecucion ;

      //Si Existe el Registro lo debe Borrar de lo Contrario lo Crea
          TstApl = %Timestamp();

          Exec Sql
             Merge Into SegCep As Tgt
             Using (Values (:CodCia, :CodPgm)) As Src(CiaCve, PgmCve)
                On (Tgt.CiaCve = Src.CiaCve)
               And (Tgt.PgmCve = Src.PgmCve)
              When Matched Then
            Delete
              When Not Matched Then
            Insert (CiaCve, PgmCve, AplUsr, AplTst)
                    Values (:CodCia, :CodPgm, :User, :TstApl) ;

          SqlCod = *Zeros ;

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
