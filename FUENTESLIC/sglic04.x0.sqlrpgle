     H DFTACTGRP(*NO) ACTGRP(*CALLER)
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
     D* Definición de variables para la API QWCRSVAL
     D Receiver        S             50A
     D RecLen          S             10I 0 INZ(50)
     D NbrVals         S             10I 0 INZ(1)
     D SysValName      S             10A
      *
     D ErrorCode       DS
     D  BytesProv              1      4I 0 INZ(0)
     D  BytesAvail             5      8I 0

     D* Variables para almacenar resultados
     D Serial          S              8A
     D Model           S              4A
     D ProcType        S              4A
      *
     C* 1. Recuperar Número de Serie (QSRLNBR)
     C                   EVAL      SysValName = 'QSRLNBR'
     C                   CALL      'QWCRSVAL'
     C                   PARM                    Receiver
     C                   PARM                    RecLen
     C                   PARM                    NbrVals
     C                   PARM                    SysValName
     C                   PARM                    ErrorCode
     C                   EVAL      Serial = %Trim(%SUBST(Receiver:42:8))
     C* 2. Recuperar Modelo (QMODEL)
     C                   EVAL      SysValName = 'QMODEL'
     C                   CALL      'QWCRSVAL'
     C                   PARM                    Receiver
     C                   PARM                    RecLen
     C                   PARM                    NbrVals
     C                   PARM                    SysValName
     C                   PARM                    ErrorCode
     C                   EVAL      Model = %SUBST(Receiver:46:4)
     C* 3. Recuperar Tipo/Característica de Procesador (QPRCFEAT)
     C                   EVAL      SysValName = 'QPRCFEAT'
     C                   CALL      'QWCRSVAL'
     C                   PARM                    Receiver
     C                   PARM                    RecLen
     C                   PARM                    NbrVals
     C                   PARM                    SysValName
     C                   PARM                    ErrorCode
     C                   EVAL      ProcType = %SUBST(Receiver:46:4)
     C* Mostrar resultados en el log de mensajes
     C     Serial        DSPLY
     C     Model         DSPLY
     C     ProcType      DSPLY
     C                   SETON                                        LR

      *
      * Main Program
      *
      /Free


      /end-free

