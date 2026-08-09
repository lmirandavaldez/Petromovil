     h   Datedit(*Dmy)
     h   Copyright ('Miranda Valdez, S. A., 2005')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: Fa0055                           *
      *  APLICACION...................: Implantacion                     *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 05 / 05 / 2007                   *
      *  DESCR:                                                          *
      *    Borrar fisicamente los registros de documentos cancelados     *
      *==================================================================*
     d  FacDtoh      e Ds                  ExtName(FacDtoh01)
      *
      /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    Distrito
     c                   Parm                    TipDoc
     c                   Parm                    Numero
      *
     c     *Like         Define    DtoNro        Numero
     c     *Like         Define    DisCve        Distrito
     c     *Like         Define    DtoTip        Tipdoc
      *
     c                   Exsr      Borrar_Reg
     c                   Eval      *InLr = *On
      * -----------------------------------------------------------
      *  Borrar registros viejos                                  -
      * -----------------------------------------------------------
     c     Borrar_reg    BegSr
      *
     c/Exec Sql
     c+   Delete From FacDtoh01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (DtoTip = :TipDoc) And
     c+             (DtoNro = :Numero)
     c*       With NC
     c/End-Exec
      *
     c/Exec Sql
     c+   Delete From FacDed01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (DtoTip = :TipDoc) And
     c+             (DtoNro = :Numero)
     c*       With NC
     c/End-Exec
      *
     c/Exec Sql
     c+   Delete From FacCcd01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (DtoTip = :TipDoc) And
     c+             (DtoNro = :Numero)
     c*       With NC
     c/End-Exec
      *
     c/Exec Sql
     c+   Delete From InvTrah01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (TraNum = :Numero) And
     c+             ((TmoCve = 'CA' Or TmoCve = 'VE' Or
     c+              TmoCve = 'DC' Or TmoCve = 'CF'  Or
     c+              TmoCve = 'CT' Or TmoCve = 'CC'  Or
     c+              TmoCve = 'FT' Or TmoCve = 'FC'  Or
     c+              TmoCve = 'FE' Or TmoCve = 'CE'))
     c*       With NC
     c/End-Exec
      *
     c/Exec Sql
     c+   Delete From InvTraD01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (TraNum = :Numero) And
     c+             ((TmoCve = 'CA' Or TmoCve = 'VE' Or
     c+              TmoCve = 'DC' Or TmoCve = 'CF'  Or
     c+              TmoCve = 'CT' Or TmoCve = 'CC'  Or
     c+              TmoCve = 'FT' Or TmoCve = 'FC'  Or
     c+              TmoCve = 'FE' Or TmoCve = 'CE'))
     c*       With NC
     c/End-Exec
      *
     c/Exec Sql
     c+   Delete From FacTrth01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (TraNro = :Numero) And
     c+             ((TmoCve = 'CA' Or TmoCve = 'VE' Or
     c+              TmoCve = 'DC' Or TmoCve = 'CF'  Or
     c+              TmoCve = 'CT' Or TmoCve = 'CC'  Or
     c+              TmoCve = 'FT' Or TmoCve = 'FC'  Or
     c+              TmoCve = 'FE' Or TmoCve = 'CE'))
     c*       With NC
     c/End-Exec
      *
     c/Exec Sql
     c+   Delete From FacTrtD01
     c+       Where
     c+             (DisCve = :Distrito) And
     c+             (TraNro = :Numero) And
     c+             ((TmoCve = 'CA' Or TmoCve = 'VE' Or
     c+              TmoCve = 'DC' Or TmoCve = 'CF'  Or
     c+              TmoCve = 'CT' Or TmoCve = 'CC'  Or
     c+              TmoCve = 'FT' Or TmoCve = 'FC'  Or
     c+              TmoCve = 'FE' Or TmoCve = 'CE'))
     c*       With NC
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
