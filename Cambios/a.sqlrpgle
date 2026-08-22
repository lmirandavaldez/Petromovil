     h   Copyright ('Miranda Valdez, S. A., 1997')
     h   Datedit(*Dmy) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  Nombre del Programa .........:                                  *
      *  Aplicacion...................:                                  *
      *  Autor .......................:                                  *
      *  Fecha Escritura .............: xx / xx / xxxx                   *
      *  Descripcion .................:                                  *
      *                                                                  *
      *  ================================================================*
      *  Modificaciones:                                                 *
      *  ---------------                                                 *
      *  Fecha        Autor            Descripcion                       *
      *  -----------  ---------------  --------------------------------- *
      *  xx/xx/xxxx                                                      *
      *                                                                  *
      *                                                                   *
      *==================================================================*
      **General Information
      *
     *-----------------------------------------------------------------*
      **General Information
    /Include FUENTES,SG9001       // Data Structure of PGM
    /Copy Fuentes,SG9001          // Data Structure of PGM
      *
      *
     d TextoCentrado   s            500
     d LongResultado   s              3  0
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
       //* --------------------+-----------------+
        //posicion de comentarios
                                                  //Message Display
                                                  //* Help
              //Timestamp
      //         sdfsdafsdafsdfsd
      //----
    *  xxx                        // Data Structure of PGM

        //Centralisar titulos logitudes variables

           LongResultado = %Len(Titulo) ;
           TextoCentrado = %Trim(Titulo) ;

           Exec Sql
             Select SEGLIB.SG_CENTER_TEXT(:TextoCentrado, :LongResultado)
               Into :Titulo
               From SysIbm.Sysdummy1;

