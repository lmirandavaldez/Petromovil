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
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: IBM Bob (asistente)              *
      *  Fecha de modificacion........: 25 / 07 / 2026                   *
      *  DESCR: Sustituir Chain/Delete/Write por instrucciones SQL.      *
      *         SELECT INTO para detectar existencia (StaPro), luego     *
      *         DELETE si existe o INSERT si no existe. Se elimina        *
      *         F-spec SegCep (acceso nativo). SqlCod validado en        *
      *         cada sentencia DML.                                       *
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

      //Actualiza la Tabla Control
          TstApl = %Timestamp();

      //Verificar si el registro ya existe en SegCep
          StaPro = *Off ;
          Exec Sql
            Select 1
              Into :StaPro
              From SegCep
             Where (CiaCve = :CodCia)
               And (PgmCve = :CodPgm)
             Fetch First 1 Row Only ;
          If SqlCod = *Zeros ;
              StaPro = *On ;
          EndIf ;

      //Si existe: eliminar; si no existe: insertar
          If StaPro = *On ;
              Exec Sql
                Delete From SegCep
                 Where (CiaCve = :CodCia)
                   And (PgmCve = :CodPgm) ;

              If SqlCod < *Zeros ;
                  SqlMsgTxt = 'Ejecucion: DELETE SegCep' ;
                  Exsr ErrSql ;
              EndIf ;
          Else ;
              Exec Sql
                Insert Into SegCep (CiaCve, PgmCve, AplUsr, AplTst)
                Select :CodCia, :CodPgm, User, :TstApl
                  From SYSIBM.SYSDUMMY1
                 Where Not Exists (
                        Select 1
                          From SegCep
                         Where (CiaCve = :CodCia)
                           And (PgmCve = :CodPgm)) ;

              If SqlCod < *Zeros ;
                  SqlMsgTxt = 'Ejecucion: INSERT SegCep' ;
                  Exsr ErrSql ;
              EndIf ;
          EndIf ;

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
