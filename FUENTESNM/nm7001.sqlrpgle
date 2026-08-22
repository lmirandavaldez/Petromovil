     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Datedit(*Ymd) Debug Option(*SrcStmt:*NoDebugIO) DftActGrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: NM7001                           *
      *  APLICACION...................: Sistema de nomina                *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 04 / 02 / 2026                   *
      *  DESCR:                                                          *
      *     Generador Codigo Unico por Empleado y Nomina                 *
      *  ================================================================*
     d BaseStr         s            200a   Varying
     d Char            s              1a   Inz(*Blanks)
      * Digito de 8
     d*Hash            s             10u 0 Inz(5381)
      * Digito de 10
     d Hash            s             20u 0 Inz(5381)
     d CharVal         s             10u 0
     d y               s             10I 0
      *
     d EmpCve          s                   Like(SqlNomEmp.EmpCve)
     d EmpCed          s                   Like(SqlNomEmp.EmpCed)
     d CnoCve          s                   Like(SqlNomCip.CnoCve)
     d TnoCve          s                   Like(SqlNomCip.TnoCve)
     d CipAno          s                   Like(SqlNomCip.CipAno)
     d CipNum          s                   Like(SqlNomCip.CipNum)
     d FecIcp          s                   Like(SqlSegFec.FecYmd)
     d FecFcp          s                   Like(SqlSegFec.FecYmd)
     d CodAsc          s                   Like(SqlNomCui.CuiIde)
     d CuiIde          s                   Like(SqlNomCui.CuiIde)
     d IcpFec          s                   Like(SqlSegFec.FecYmd)
     d FcpFec          s                   Like(SqlSegFec.FecYmd)
      *
      * Archivos Definidos Externamente
     d SqlNomCip     e Ds                  ExtName(NomCip) Qualified
     d SqlNomEmp     e Ds                  ExtName(NomEmp) Qualified
     d SqlNomCui     e Ds                  ExtName(NomCui) Qualified
     d SqlNomNgeh    e Ds                  ExtName(NomNgeh) Qualified
     d SqlSegFec     e Ds                  ExtName(SegFec) Qualified
      *
     d/Copy *Libl/Fuentes,sg9003
      *
     d/Copy *Libl/Fuentes,sg9001
      *
      **NM7001  Prototype
     d NM7001          Pr
     d InpEmpCve                      7
     d InpEmpCed                     11
     d InpCnoCve                      2
     d InpTnoCve                      2
     d InpCipAno                      4
     d InpCipNum                      2
     d InpFecIcp                      8
     d InpFecFcp                      8
     d InpCodAsc                     10
      *
      **NM7001  Program Interface
     d NM7001          Pi
     d InpEmpCve                      7
     d InpEmpCed                     11
     d InpCnoCve                      2
     d InpTnoCve                      2
     d InpCipAno                      4
     d InpCipNum                      2
     d InpFecIcp                      8
     d InpFecFcp                      8
     d InpCodAsc                     10
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

       //1. Construir cadena base

           BaseStr = %Trim(InpEmpCve) +
                     %Trim(InpEmpCed) +
                     %Trim(InpCnoCve) +
                     %Trim(InpTnoCve) +
                     %Trim(InpCipAno) +
                     %Trim(InpCipNum) +
                     %Trim(InpFecIcp) +
                     %Trim(InpFecFcp) ;

       //2. Algoritmo FNV-1a compatible con V7R4

           For y = 1 to %Len(%Trim(BaseStr));

       //Extraer 1 carácter
              Char = %Subst(BaseStr:y:1);

       //Convertirlo a entero ASCII (0-255)
              CharVal = %Bitand(%int(Char): 255);

       //Hash estilo DJB2 y Reducir a 8 dígitos
        //    Hash = %Rem((Hash * 33) + CharVal : 1000000);

       //Hash estilo DJB2 y reducir a 10 dígitos
              Hash = %rem((Hash * 33) + CharVal : 10000000000)  ;
           EndFor;

           CuiIde = Hash ;
           InPCodAsc = %Editc(CuiIde:'X') ;

       //Grabar en Codigo Unico

           Exec sql
              Insert Into NomCui (
                   EmpCve,
                   CnoCve,
                   TnoCve,
                   CipAno,
                   CipNum,
                   CuiIde,
                   CuiTst
              )
              Select
                     :EmpCve,
                     :CnoCve,
                     :TnoCve,
                     :CipAno,
                     :CipNum,
                     :CuiIde,
                     Current Timestamp
                   From Sysibm.Sysdummy1
                   Where Not Exists (
                        Select 1
                          From NomCui
                         Where (EmpCve = :EmpCve)
                           And (CnoCve = :CnoCve)
                           And (TnoCve = :TnoCve)
                           And (CipAno = :CipAno)
                           And (CipNum = :CipNum)
                           And (CuiIde = :CuiIde)
                   );

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

           EmpCve = %Dec(InpEmpCve:7:0)   ;
           EmpCed = %Dec(InpEmpCed:11:0)  ;
           CnoCve = %Dec(InpCnoCve:2:0)   ;
           TnoCve = %Dec(InpTnoCve:2:0)   ;
           CipAno = %Dec(InpCipAno:4:0)   ;
           CipNum = %Dec(InpCipNum:2:0)   ;
           FecIcp = %Dec(InpFecIcp:8:0)   ;
           FecFcp = %Dec(InpFecFcp:8:0)   ;
           // CodAsc = %Dec(InPCodAsc:10:0)  ;

        EndSr;
      /End-Free
       // ----------------------------------------------------------
