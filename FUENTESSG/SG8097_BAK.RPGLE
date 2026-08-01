     h   Copyright ('Miranda Valdez, S. A., 2004')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
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
     d CmdTxt          S            512
     d CmdLng          S              15  5
      *
      * Enviar Mensaje al JobLog via QCMDEXC
     d EjeComandos     Pr                  ExtPgm('QCMDEXC')
     d  CmdTxt_1                      512
     d  CmdLng_1                       15  5

      **SG8097 Prototype
     d SG8097          Pr
     d  MsgCod                        100

      **SG8097 Program Interface
     d SG8097          Pi
     d  MsgCod                        100
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
           MsgJoblog = %Trim(MsgCod)            +
                       ' Fecha: '               +
                       %Char(FechaIni:*ISO)      +
                       ' Hora: '                +
                       %Char(HoraIni:*HMS)       ;

           // Armar el comando SNDPGMMSG para enviar al JobLog
           CmdTxt = 'SNDPGMMSG MSGID(CPF9898) MSGF(QCPFMSG) '  +
                    'MSGDTA(''' + %Trim(MsgJoblog) + ''') '      +
                    'TOPGMQ(*SAME) MSGTYPE(*INFO)'               ;

           CmdLng = %Len(%TrimR(CmdTxt)) ;

           // Ejecutar el Comando
           EjeComandos(CmdTxt :CmdLng) ;

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
