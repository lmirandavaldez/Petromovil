     h   Copyright ('Miranda Valdez, S. A., 2004')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO) ActGrp(*CALLER)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: SG8097                           *
      *  APLICACION...................: Seguridad                        *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 20 / 07 / 2026                   *
      *                                                                  *
      *       Enviar Mensaje al JobLog                                   *
      *  ================================================================*
      * Campos de Parametros
     d FechaIni        S               D
     d HoraIni         S               T
     d MsgJoblog       S            512
      *
      * API QMHSNDPM - Enviar mensaje al JobLog directamente
     d SndPgmMsg       Pr                  ExtPgm('QMHSNDPM')
     d  MsgId_1                       7    Const
     d  MsgFile_1                    20    Const
     d  MsgData_1                   512    Const
     d  MsgDataLen                   10i 0 Const
     d  MsgType_1                    10    Const
     d  CallStkEnt                   10    Const
     d  CallStkCnt                   10i 0 Const
     d  MsgKey                        4
     d  ErrorDs                      15    Options(*NoPass)

      **SG8097 Program Interface
     d SG8097          Pi
     d  MsgCod                      100
      *
      * Campos de trabajo para QMHSNDPM
     d MsgKey          S              4
     d ErrorDs         S             15    Inz(*Allx'00')
      *
      * Main Program
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
           Exsr Process   ;
           Exsr EndProgram;
        // ------------------------------------------------------
        // Process Subroutine                                   -
        // ------------------------------------------------------
           Begsr Process   ;

           FechaIni = %Date()  ;
           HoraIni  = %Time()  ;

           // Construir el texto del mensaje: Texto + Fecha + Hora
           MsgJoblog = %TrimR(%Trim(MsgCod))         +
                       ' Fecha: '                    +
                       %TrimR(%Char(FechaIni:*ISO))  +
                       ' Hora: '                     +
                       %TrimR(%Char(HoraIni:*HMS))   ;

           // Enviar mensaje al JobLog usando API QMHSNDPM directamente
           SndPgmMsg( 'CPF9898'                      // MsgId
                    : 'QCPFMSG   *LIBL             ' // MsgFile (20 pos)
                    : MsgJoblog                       // MsgData
                    : %Len(%TrimR(MsgJoblog))         // MsgDataLen
                    : '*INFO     '                    // MsgType
                    : '*         '                    // CallStkEnt
                    : 0                               // CallStkCnt
                    : MsgKey                          // MsgKey (salida)
                    : ErrorDs                         // ErrorDs
                    ) ;

           Endsr;
        // -----------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
           Begsr EndProgram;

            *Inlr = *On;
            Return;
           Endsr;
        // -----------------------------------------------------
        // SubRutina Inicial                                   -
        // -----------------------------------------------------
           Begsr *Inzsr ;

           Endsr;
      /End-Free
