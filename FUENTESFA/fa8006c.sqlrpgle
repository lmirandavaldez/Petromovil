     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  Nombre del programa .........: FA8006C                          *
      *  Aplicacion...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 08 / 08 / 2026                   *
      *  Descripcion:                                                    *
      *         Buscar 5 fichas para casos de ejemplos                   *
      *  ================================================================*
      *
      * Campos Usados en el Programa
     d Existe          s               n   Inz(*Off)
      * Campos Uso Parametros de Entrada
     d VehFic          s                   Like(SqlFacPlah.VehFic)
     d PlaDis          s                   Like(SqlFacPlah.PlaDis)
     d PlaNro          s                   Like(SqlFacPlah.PlaNro)
     d PlaFpl          s                   Like(SqlFacPlah.PlaFpl)
     d SitCve          s                   Like(SqlFacPlah.SitCve)
     d VehOri          s                   Like(SqlFacVeh.VehOri)
     d VehTip          s                   Like(SqlFacVeh.VehTip)
     d Rn              s                   Like(SqlFacPlah.PlaNro)
      *
      * Campos que Son Enviados Como Parametros
      *
      **Archivos Externos
     d SqlFacVeh     e Ds                  ExtName(FacVeh) Qualified
     d SqlFacPlah    e Ds                  ExtName(FacPlah) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      * Buscar Parametros Generales
     d PasarFicha      Pr                  ExtPgm('FA8006')
     d  VehFic_1                           Like(SqlFacPlah.VehFic)
      *
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
        // Seleccionar Tipo de Comprobantes Usados              -
        // ------------------------------------------------------
           BegSr Proceso;

        // Leer Archivo
           Exec Sql
              Declare C1 cursor for
         // 1. Identificar planillas con más de un conduce
              WITH MULTI AS (
                  SELECT PlaDis,
                         PlaNro,
                         COUNT(*) AS Cant_Conduces
                  FROM FacPlad
                  GROUP BY PlaDis, PlaNro
                  HAVING COUNT(*) > 2),
          // 2. Base original pero filtrando solo las planillas con múltiples
          //conduces
            BASE AS (
                SELECT DISTINCT
                    T3.VehTip,
                    T3.VehFic,
                    T1.PlaDis,
                    T1.PlaNro,
                    T1.PlaFpl
                FROM Facplah T1
                JOIN FacVeh T3
                  ON T1.VehFic = T3.VehFic
                JOIN MULTI M
                  ON T1.PlaDis = M.PlaDis
                 AND T1.PlaNro = M.PlaNro
                WHERE T1.PlaDis = 01
                  AND T1.PlaFpl BETWEEN 20260801 AND 20260831
                  AND T1.SitCve <> 'Y'
                  AND T3.VehOri = 'P'
                  AND T3.VehTip IN (1, 2)),
             -- 3. Tomar los primeros 5 por tipo de vehículo
             RANKED AS (
                 SELECT
                     VehTip,
                     VehFic,
                     PlaDis,
                     PlaNro,
                     PlaFpl,
                     ROW_NUMBER() OVER(
                         PARTITION BY VehTip
                         ORDER BY VehFic) AS RN
                 FROM BASE)

             SELECT *
             FROM RANKED
             WHERE RN <= 3
             ORDER BY VehTip, RN
            For Read Only ;

           Exec Sql
             Open c1;

           Dow True;

            Exec Sql
              Fetch Next From c1 Into :VehTip, :VehFic, :PlaDis, :PlaNro,
                                      :PlaFpl, :Rn                        ;

            If SqlCod <> *Zeros;
              Leave;
            Endif;

        //Solicitar la Asginacion de Comprobantes

           PasarFicha(VehFic)     ;

           EndDo ;

           Exec Sql
              Close c1;

           SqlCod = *Zeros;

           Endsr;
        // -----------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
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
