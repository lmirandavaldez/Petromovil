     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  Nombre del Programa .........: SQLFAR001                        *
      *  Aplicacion...................: Estadisticas de ventas           *
      *  Autor .......................: Luis J. Miranda V.               *
      *  Fecha Escritura .............: 13 / 06 / 2025                   *
      *  Descripcion:                                                    *
      *                                                                  *
      *      Proceso Creacion Tabla Clientes Inactivos                   *
      *  ================================================================*
     d Id_Cliente      s                   Like(SqlFacDtoh.CliCve)
     d Fecha_Compra    s                   Like(SqlSegFec.FecIso)
      *
     d SqlFacDtoh    e Ds                  ExtName(FacDtoh) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
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

         Exec Sql
            Insert Into Control_Rendimiento (Id_Proceso, Fecha_Inicio)
              Values ('@', Current_TimeStamp);

        // Leer Archivo
           Exec Sql
              Declare C1 cursor for
              Select T1.CliCve, T2.FecIso
                 From FacDtoh T1
                 Join SegFec T2
                   On (T1.DtoAno = T2.FecAno)
                  And (T1.DtoMes = T2.FecMes)
                  And (T1.DtoDia = T2.FecDia)
                Where (T1.DtoSta = 'A')
                  And (T1.DtoTip Not In (2, 8))
             Order by T1.CliCve, T2.FecIso
               For Read Only ;

        Exec Sql
          Open c1;

        Dow True;

          Exec Sql
            Fetch Next From c1 Into :Id_Cliente, :Fecha_Compra        ;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

         //Para Asignar el grupo que corresponde segun las informaciones

             Exec Sql
               Call Pro_Actualizar_Inactividad(:Id_Cliente, :Fecha_Compra);

         EndDo ;

        Exec Sql
          Close c1;
        SqlCod = *Zeros;


         Exec Sql
           Update Control_Rendimiento
             Set Fecha_Fin = Current_TimeStamp
           Where Id_Proceso = '@';

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

        // Borrar Tabla Control
        Exec Sql
             Delete From Control_rendimiento
               With NC;

        // Borrar Tabla Historica
        Exec Sql
             Delete From EstIcc
               With NC;

       EndSr;
      /End-Free
       // ----------------------------------------------------------
