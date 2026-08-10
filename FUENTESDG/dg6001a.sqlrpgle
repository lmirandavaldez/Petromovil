     h   Copyright ('Miranda Valdez, S. A., 2004')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: DG6001A                          *
      *  APLICACION...................: Informe DGII 606                 *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 11 / 02 / 2007                   *
      *                                                                  *
      *       Seleccion transacciones para archivo 606 DGII              *
      *  ================================================================*
      * Campos Usado en el programa
     d Valor_RetItb    s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_RetIsr    s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Ret01     s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Ret02     s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Itb       s                   Like(SqlCxpDpeh.DpeVal)
     d Valor_Isr       s                   Like(SqlCxpDpeh.DpeVal)
      *
     d ProDes_01       s                   Like(SqlCxpCri.CriPre)
     d ProDes_02       s                   Like(SqlCxpCri.CriPre)
     d Gis01           s                   Like(SqlCxpCri.CriGis)
     d Gis02           s                   Like(SqlCxpCri.CriGis)
     d Tig01           s                   Like(SqlCxpCri.CriTig)
     d Tig02           s                   Like(SqlCxpCri.CriTig)
     d Tre01           s                   Like(SqlCxpCri.TreCve)
     d Tre02           s                   Like(SqlCxpCri.TreCve)
      *
      * Campos Intermedio
     d CriCve          s                   Like(SqlCxpTrah.CriCve)
     d CriCv2          s                   Like(SqlCxpTrah.CriCv2)
     d FseSrp          s                   Like(SqlCxpTrah.FseSrp)
     d FseTas          s                   Like(SqlCxpTrah.FseTas)
     d DpeIm1          s                   Like(SqlCxpDpeh.DpeIm1)
     d DpeIm2          s                   Like(SqlCxpDpeh.DpeIm2)
     d DpeVbr          s                   Like(SqlCxpDpeh.DpeVbr)
     d DpeMif          s                   Like(SqlCxpDpeh.DpeMif)
      *
     d SqlCxpDpeh    e Ds                  ExtName(CxpDpeh08) Qualified
     d SqlCxpTrah    e Ds                  ExtName(CxpTrah01) Qualified
     d SqlCxpDped    e Ds                  ExtName(CxpDped07) Qualified
     d SqlCxpCri     e Ds                  ExtName(CxpCri) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **DG6001A Prototype
     d DG6001A         Pr
     d  Proveedor                          Like(SqlCxpDpeh.ProCve)
     d  NumDoc                             Like(SqlCxpDpeh.DpeDoc)
     d  TipMov                             Like(SqlCxpDpeh.MovCve)
     d  FechaPago                          Like(SqlCxpDpeh.FecPag)
     d  ValorItb                           Like(SqlCxpDpeh.DpeVal)
     d  ValorIsr                           Like(SqlCxpDpeh.DpeVal)
     d  TipTre                             Like(SqlCxpCri.TreCve)
      *
      **DG6001A Program Interface
     d DG6001A         Pi
     d  Proveedor                          Like(SqlCxpDpeh.ProCve)
     d  NumDoc                             Like(SqlCxpDpeh.DpeDoc)
     d  TipMov                             Like(SqlCxpDpeh.MovCve)
     d  FechaPago                          Like(SqlCxpDpeh.FecPag)
     d  ValorItb                           Like(SqlCxpDpeh.DpeVal)
     d  ValorIsr                           Like(SqlCxpDpeh.DpeVal)
     d  TipTre                             Like(SqlCxpCri.TreCve)
      *
      * Main Program
      *
      /Free
        // ------------------------------------------------------
        // Main Process                                         -
        // ------------------------------------------------------
        Exsr Ejecuta;
        Exsr EndProgram;
        // ------------------------------------------------------
        // Seleccionar las informaciones                        -
        // ------------------------------------------------------
           BegSr Ejecuta;

        // Leer Archivo
           Exec Sql
              Declare C1 cursor for
                Select *
                  From CxpDped07 T1
                  Join CxpTrah01 T2
                    On (T1.ProCve = T2.ProCve)
                   And (T1.TdiCve = T2.TdiCve)
                   And (T1.DgeDoc = T2.DgeDoc)
                   And (T1.DpeMot = T2.DpeMot)
                   And (T1.Fecha = T2.FseFtr)
                  Join CxpDpeh08 T3
                    On (T1.ProCve = T3.ProCve)
                   And (T1.DpeDoc = T3.DpeDoc)
                   And (T1.MovCve = T3.MovCve)
                 Where (T1.ProCve = :Proveedor)
                   And (T1.DpeDoc = :NumDoc)
                   And (T1.MovCve = :TipMov)
                   And (T1.Fecha = :FechaPago)
                   And (T2.FseSrp = 'S')
              For Read Only ;

        Exec Sql
          Open c1;

        Dow True;

          Exec Sql
            Fetch Next From c1 Into :SqlCxpDped, :SqlCxpTrah, :SqlCxpDpeh;

          If SqlCod <> *Zeros;
            Leave;
          Endif;

         CriCve = SqlCxpTrah.CriCve ;
         CriCv2 = SqlCxpTrah.CriCv2 ;
         FseSrp = SqlCxpTrah.FseSrp ;
         FseTas = SqlCxpTrah.FseTas ;
         DpeIm1 = SqlCxpDpeh.DpeIm1 ;
         DpeIm2 = SqlCxpDpeh.DpeIm2 ;
         DpeVbr = SqlCxpDpeh.DpeVbr ;
         DpeMif = SqlCxpDpeh.DpeMif ;


         ValorItb = *Zeros;
         ValorIsr = *Zeros;

       // Para Calcular Las retenciones
         Exsr Retenciones  ;

         If FseTas = *Zeros  ;
            ValorItb = Valor_RetItb * 1 ;
            ValorIsr = Valor_RetIsr * 1 ;
         Else;
            Eval(Rh) ValorItb = Valor_RetItb * FseTas ;
            Eval(Rh) ValorIsr = Valor_RetIsr * Fsetas ;
         EndIf;

       EndDo ;

        Exec Sql
          Close c1;

        Endsr;
       // --------------------------------------------------------
       // Para Calcular las retenciones                          -
       // --------------------------------------------------------
        BegSr Retenciones ;

         ProDes_01 = *Zeros;
         ProDes_02 = *Zeros;
         Gis01 = 'N' ;
         Gis02 = 'N' ;
         Tig01 = 'N' ;
         Tig02 = 'N' ;
         TipTre = *Zeros;
         Tre01 = *Zeros;
         Tre02 = *Zeros;

         Valor_Ret01  = *Zeros ;
         Valor_Ret02  = *Zeros ;
         Valor_RetItb = *Zeros ;
         Valor_RetIsr = *Zeros ;

       // Buscar informaciones para poder hacer los calculos
           Exec Sql
             Select CriPre, CriGis, CriTig, TreCve
               Into :ProDes_01, :Gis01, :Tig01, :Tre01
               From CxpCri
              Where (CriCve = :CriCve)
         Fetch First 1 Rows Only       ;
         SqlCod = *Zeros ;

        If ProDes_01 <> *Zeros ;
           ProDes_01 = (Prodes_01 / 100);
        EndIf;

       // Buscar informaciones para poder hacer los calculos
           Exec Sql
             Select CriPre, CriGis, CriTig, TreCve
               Into :ProDes_02, :Gis02, :Tig02, :Tre02
               From CxpCri
              Where (CriCve = :CriCv2)
         Fetch First 1 Rows Only       ;
         SqlCod = *Zeros ;

        If ProDes_02 <> *Zeros ;
           ProDes_02 = (Prodes_02 / 100);
        EndIf;

        If Gis01 = 'S' ;
          Select;
            When Tig01 = 'M' ;
              Eval(Rh) Valor_Ret01 = DpeVbr * ProDes_01 ;
              Eval     Valor_Isr += Valor_Ret01    ;
              TipTre = Tre01    ;

            When Tig01 = 'I' And (DpeIm1 + DpeIm2) = DpeMif  ;
              Eval(Rh) Valor_Ret01 = (DpeIm1 + DpeIm2) * ProDes_01 ;
              Eval     Valor_Itb += Valor_Ret01 ;
              // TipTre = *Zeros   ;

            When Tig01 = 'I' And (DpeIm1 + DpeIm1) <> DpeMif ;
              Eval(Rh) Valor_Ret01 = DpeMif * ProDes_01  ;
              Eval     Valor_Itb += Valor_Ret01 ;
              // TipTre = *Zeros   ;
          EndSl;

        EndIf ;

        If Gis02 = 'S'  ;
          Select ;
            When Tig02 = 'M'   ;
              Eval(Rh) Valor_Ret02 = DpeVbr * ProDes_02  ;
              Eval     Valor_Isr += Valor_Ret02 ;
              TipTre = Tre02    ;

            When Tig02 = 'I' And (DpeIm1 + DpeIm2) = DpeMif ;
              Eval(Rh) Valor_Ret02 = (DpeIm1 + DpeIm2) * ProDes_02 ;
              Eval     Valor_Itb += Valor_Ret02   ;
              // TipTre = *Zeros   ;

            When Tig02 = 'I' And (DpeIm1 + DpeIm1) <> DpeMif ;
              Eval(Rh) Valor_Ret02 = DpeMif * ProDes_02   ;
              Eval     Valor_Itb += Valor_Ret02 ;
              // TipTre = *Zeros   ;
          EndSl ;
        EndIf ;

        Valor_RetItb = Valor_Itb ;
        Valor_RetIsr = Valor_Isr ;

       EndSr;
        //------------------------------------------------------
        // End Program Subroutine                              -
        // -----------------------------------------------------
        Begsr EndProgram;

          *Inlr = *On;
          Return;

        Endsr;
      /End-Free
        // -----------------------------------------------------
