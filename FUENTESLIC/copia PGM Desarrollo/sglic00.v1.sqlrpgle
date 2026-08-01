     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SGLIC04                          *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 28 / 01 / 2026                   *
      *  DESCR:                                                          *
      *     Validar Licencia                                             *
      *  ================================================================*
      *
      * Campos Usado en el programa
     d BaseStr         s            128a   Inz(*Blanks)
     d Suma            s              9  0 Inz(*Zeros)
     d Char            s              1a   Inz(*Blanks)
     d AscVal          s              3  0 Inz(*Zeros)
     d LicKey          s            128a   Inz(*Blanks)
     d CodigoAscii     s             10I 0
     d Status          s               n   Inz(*Off)
      *
     d NSerial         s             10A
     d NModel          s              8A
     d ProcType        s              8A
     d HostName        s             25A
     d*CtlCve          s              9  0
     d FecIni          s              5A
     d FecFin          s              5A
     d*MaxUsr          s              5  0
      *
     d CiaNom          s                   Like(SqlSegCia.CiaNom)
     d CiaRnc          s                   Like(SqlSegCia.CiaRnc)
     d Abrevi          s             25a   Inz(*Blanks)
      *
     d FechaDia        s                   Like(SqlSegFec.FecJul)
     d FechaCrj        s                   Like(SqlSegFec.FecJul)
     d FechaExj        s                   Like(SqlSegFec.FecJul)
      * Tablas Definidas Externamente
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
     d SqlSegCtl     e Ds                  ExtName(SegCtl) Qualified
     d SqlSegLic     e Ds                  ExtName(SegLic) Qualified
     d SqlSegCia     e Ds                  ExtName(SegCia) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **SGLIC04 Prototype
     d SGLIC04         Pr
     d InpCtlSrl                      8
     d InpCtlMod                      4
     d InpCtlPty                      4
     d InpFecPro                      5
     d InpCtlSta                      1
      *
      **SGLIC04 Program Interface
     d SGLIC04         Pi
     d InpCtlSrl                      8
     d InpCtlMod                      4
     d InpCtlPty                      4
     d InpFecPro                      5
     d InpCtlSta                      1
      *
      * Main Program
      *
      /Free

        // ------------------------------------------------------
        // Main Process
        // ------------------------------------------------------
        Exsr Proceso ;
        Exsr EndProgram;
        // ------------------------------------------------------
        // Imprimir Reporte
        // ------------------------------------------------------
        Begsr Proceso            ;

       //Buscar Datos de la empresa
          Clear CiaNom ;
          Clear CiaRnc ;

          Exec Sql
             Select CiaNom, CiaRnc
               Into :CiaNom,
                    :CiaRnc
               From SegCia
              Where (CiaCve <> 'SG')
              Order By CiaCve
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;
          Abrevi = *Blanks     ;

            For i = 1 to 10 By 2;
               Abrevi = %Trim(Abrevi) + %Trim(%Subst(CiaNom:i:1));
            EndFor;

              If FechaDia > SqlSegCtl.CtlFtc  ;   //Periodo de Prueba
                  InpCtlSta = '2'      ;
               LeaveSr ;
             EndIf   ;

           Abrevi = %Trim(Abrevi) + %Trim(CiaRnc)  ;
           FecIni = %Editc(%Dec(SqlSegCtl.CtlFic):'X')  ;
           FecFin = %Editc(%Dec(SqlSegCtl.CtlFtc):'X')  ;

       //1. Construir cadena base

           BaseStr = %Trim(Abrevi) +
                     %Trim(NSerial) +
                     %Trim(NModel)  +
                     %Trim(ProcType)   +
                     %Trim(HostName)  +
                     %Trim(FecIni) +
                     %Trim(FecFin) +
                     %Trim(%Editc((SqlSegCtl.CtlMus):'X'))  ;

       //2. Función simple de "hash" Suma de códigos + Mod para reducir tamaño

           For i = 1 to %Len(%Trim(BaseStr));
              Char = %Subst(BaseStr:i:1);

           // Obtener ASCII mediante SQL
                 Exec Sql
                      Select Ascii(:Char)
                        Into :CodigoAscii
                      From SysIbm.SysDummy1;

              Suma += CodigoAscii ;
           EndFor;

           Suma = %Rem(Suma:999999)         ;

       //3. Construir LICKEY
           LicKey = %Trim(BaseStr) + %Char(Suma);

       //Buscar la licencia
          Status = *Off   ;

          Exec Sql
             Select '1'
               Into :Status
               From SegLic
              Where (LicCve = :LicKey)
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

       //Validar si la Licencia Existe o Valida
           Select ;
             When Status = *Off        ;          //Valida
                  InpCtlSta = '1'      ;
                  LeaveSr ;

             When Status = *On         ;          //No Valida
                  InpCtlSta = *Blanks  ;
           EndSl  ;

       //Actualizar fecha ultima Verificacion

          Exec Sql
           Update SegCtl Set CtlFuv = Current Timestamp
              Where (CtlSrl = :NSerial)
                And (CtlMod = :NModel)
                And (CtlPty = :ProcType)
                And (CtlHtn = :HostName) ;

          SqlCod = *Zeros ;

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

       //Recibir Patametros
           NSerial = %Trim(InpCtlSrl)        ;
           NModel = %Trim(InpCtlMod)         ;
           ProcType = %Trim(InpCtlPty)      ;
           FechaDia = %Date(%Dec(InpFecPro:5:0):*Jul)  ;

       //Buscar Informaciones del Servidor
            Exec Sql
              Select Host_Name
                Into :HostName
                From Qsys2.SysTem_Status_Info  ;

       //Buscar Datos Control de Licencia
          Clear SqlSegCtl ;

          Exec Sql
             Select *
               Into :SqlSegCtl
               From SegCtl
              Where (CtlSrl = :NSerial)
                And (CtlMod = :NModel)
                And (CtlPty = :ProcType)
                And (CtlHtn = :HostName)
              Fetch First 1 Rows Only       ;

          SqlCod = *Zeros ;

        EndSr;
      /End-Free
       // ----------------------------------------------------------
