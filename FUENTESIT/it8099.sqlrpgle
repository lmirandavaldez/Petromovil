     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Debug Option(*SRCSTMT:*NODEBUGIO) Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: IT8099                           *
      *  APLICACION...................: Transf. Modulos Externos         *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 19 / 09 / 2013                   *
      *                                                                  *
      *       Actualizar control ejecucion de los procesos Externos      *
      *  ----------------------------------------------------------------*
      *  Modificado por ..............: Luis J. Miranda V.               *
      *  Fecha de modificacion........: 04 / 08 / 2026                   *
      *  Codigo Modificacion..........:                                  *
      *  DESCR: Poner en Sql y formato Free                              *
      *  ================================================================*

     d StaPro          s               n   Inz(*Off)
     d PgmSta          s                   Like(Ema)
     d TstApl          s                   Like(SqlIteCej.AplTst)
     d CejCve          s              1    Inz('@')
     d CveCpe01        s                   Like(SqlIteCpe.CpeCve)
     d CveCpe02        s                   Like(SqlIteCpe.CpeCve)
      *
      * Archivos usado en el programa
     d SqlIteCej     e Ds                  ExtName(IteCej) Qualified
     d SqlIteCpe     e Ds                  ExtName(IteCpe) Qualified
     d SqlTtvfPare   e Ds                  ExtName(TtvfPare) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Verificar si existe un Proceso activo
     d ValidaProceso   Pr                  ExtPgm('IT8098')
     d  PgmSta_1                           Like(PgmSta)
      *
      **IT8099 Prototype
     d IT8099          Pr
     d  CodPro01                      4
     d  CodPro02                      4
      *
      **IT8099 Program Interface
     d IT8099          Pi
     d  CodPro01                      4
     d  CodPro02                      4
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
       // Definicion order de Ejecucion de Procesos            -
       // ------------------------------------------------------
          Begsr Consta;

          Select ;
            When PgmSta = 'N'    ;
                 Exsr Agregar    ;

            When PgmSta = 'S'    ;
                 Exsr Borrar     ;
           EndSl ;

          Exsr Actualiza ;

          EndSr;
       // ------------------------------------------------------
       // Agregar Codigo de Procesos que no se ejecutaran      -
       // ------------------------------------------------------
          Begsr Agregar;

      //Insertar en ITECPE evitando duplicados
          Exec Sql
             Insert Into IteCpe (CpeCve)
             Select CodEnt
               From TtvfPare
              Where (CodEnt <> :CveCpe01)
                And (CodEnt <> :CveCpe02)
                And EstadoEnt <> 'I'
                And Not Exists (Select 1
                                  From IteCpe
                                 Where (CpeCve = TtvfPare.CodEnt));
          SqlCod = *Zeros ;

      //Actualizar TtvfPare solo para los registros insertados
          Exec Sql
             Update TtvfPare
                Set EstadoEnt = 'I'
              Where (CodEnt <> :CveCpe01)
                And (CodEnt <> :CveCpe02)
                And EstadoEnt <> 'I'
                And Exists (Select 1
                              From IteCpe
                             Where (CpeCve = TtvfPare.CodEnt));

          SqlCod = *Zeros ;

          EndSr;
       // ------------------------------------------------------
       // Borrar Codigo de Procesos que no se ejecutaran       -
       // ------------------------------------------------------
          Begsr Borrar ;

      //1. Actualizar TtvfPare según los registros que están en ITECPE
          Exec Sql
          Update TtvfPare
             Set EstadoEnt = 'A'
           Where CodEnt In (
                    Select CpeCve
                      From IteCpe);

          SqlCod = *Zeros ;

      //2. Borrar todos los registros de ITECPE
          Exec Sql
          Delete From IteCpe;

          SqlCod = *Zeros ;

          EndSr;
       // ------------------------------------------------------
       // Actualiaza Control de Ejecucion                      -
       // ------------------------------------------------------
          BegSr Actualiza ;

      //Si Existe el Registro lo debe Borrar de lo Contrario lo Crea
          TstApl = %Timestamp();

          Exec Sql
             Merge Into IteCej As Tgt
             Using (Values (:CejCve)) As Src(CejCve)
                On (Tgt.CejCve = Src.CejCve)
              When Matched Then
            Delete
              When Not Matched Then
            Insert (CejCve, AplUsr, AplTst)
                    Values (:CejCve, :User, :TstApl) ;

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

          CveCpe01 = %Dec(CodPro01:4:0) ;
          CveCpe02 = %Dec(CodPro02:4:0) ;

          PgmSta = *Blanks ;

          ValidaProceso(PgmSta);

          EndSr;
      /End-Free
       // -----------------------------------------------------
