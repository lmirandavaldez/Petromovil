     h   Copyright ('Miranda Valdez, S. A., 1998')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA0006CD                         *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 17 / 12 / 2015                   *
      *  DESCR:                                                          *
      *            Crear comentario con facturas aplicadas               *
      *  ================================================================*
     fFacNcdh01 If   e           k disk
     fFacNcdd02 If   e           k disk
     fCxcNott   Uf a e           k disk    Prefix(I_)
     fCxcCdo03  If   e           k disk
     fFacPar    If   e           k disk    Prefix(L_)
     fFacDed01  If   e           k disk    PreFix(y_)
      *
     d ParCve          s              1    inz('@')
     d NotDes          c                   'Documentos afectados:'
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    NumDis
     c                   Parm                    DocTra
     c                   Parm                    NumDoc
      *
     c     Clave_Nct     klist
     c                   kfld                    NumDis
     c                   kfld                    DocTra
     c                   kfld                    NumDoc
      *
     c     Clave_Not     klist
     c                   kfld                    DisCve
     c                   kfld                    CveCdo
     c                   kfld                    NumDoc
      *
     c                   Exsr      consta
     c                   Exsr      bloque
     c                   Move      *On           *Inlr
      * ----------------------------------------------------------
      *          Definición de variables intermedias             -
      * ----------------------------------------------------------
     c     consta        begsr
      *
     c     *Like         Define    DisCve        NumDis
     c     *Like         Define    NcdNro        NumDoc
     c     *Like         Define    CdoCve        CveCdo
     c     *Like         Define    NcdTip        DocTra
      *
     c                   Eval      DisCve = Numdis
     c                   Eval      NcdTip = DocTra
     c                   Eval      NcdNro = NumDoc
      *
     c     L_ParCrn      Chain     CxcCdof                            90
     c                   Eval      CveCdo = CdoCve
     c     Clave_Nct     Chain     FacNcdhf                           55
     c                   EndSr
      * ----------------------------------------------------------
      *          Ciclo de formatos de pantallas                  -
      * ----------------------------------------------------------
     c     Bloque        BegSr
      *
     c                   Exsr      Eliminar
     c                   Exsr      Crear_Com
      *
     c                   EndSr
      * ----------------------------------------------------------
      * Crear el comentario en Detalle                           -
      * ----------------------------------------------------------
     c     Crear_Com     BegSr
     c     *Like         Define    I_NotSec      NotSec
L006 c     *Like         Define    L_ParCrf      ParFcc
L006 c     *Like         Define    DisCve        CodDis
L006 c     *Like         Define    NcdNro        NroNcd
L006 c     *Like         Define    DtoNro        NroDto
L006 c     *Like         Define    OrdCex        CexOrd
     c                   Clear                   NotSec
      *
     c/Exec Sql
     c+   Declare C1 cursor for
     c+     Select DisCve, NcdNro, DtoNro, Sum(OrdCex)
     c+       From FacNcdd
     c+      Where (DisCve = :NumDis)
     c+        And (NcdTip = :DocTra)
     c+        And (NcdNro = :Numdoc)
     c+   Group by DisCve, NcdNro, DtoNro
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 into :CodDis, :NroNcd, :NroDto, :CexOrd
     c/end-exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   EndIf
      * Buscar el NCF de la factura que estan aplicando
     c                   Exsr      Buscar_FT
      *
     c                   Select
      * Factura
     c                   When      DtoTip = 1
L006 c                   Eval      ParFcc = L_ParCrf
      * Factura Externa NCF
L006 c                   When      DtoTip = 4
 ''  c                   Eval      ParFcc = L_ParRfe
      * Factura Externa Ticket Pre-Pago
L006 c                   When      DtoTip = 5
 ''  c                   Eval      ParFcc = L_ParRft
      * Factura Externa a Credito Modulo externo
L008 c                   When      DtoTip = 6
 ''  c                   Eval      ParFcc = L_ParRfc
L008 c                   EndSl
     c     ParFcc        Chain     CxcCdof                            55
      *
     c                   Eval      NotSec += 1
     c                   Eval      I_NotDes = CdoCve + '-' +
     c*                            %Editc(DtoNro:'X') +
     c                             %Editc(NcdDre:'X') +
     c                             '  Fecha: ' +
     c                             %Editw(FecDoc:'  /  /    ') +
     c                             '  Ncf: ' + NcfNro
     c                   Eval      I_NotVal = OrdTin * 1
     c                   Exsr      Agregar
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C1
     c/End-exec
      *
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------
      *   Agregar Registro comentario                            -
      * ----------------------------------------------------------
     c     Agregar       BegSr
      *
     c                   Eval      I_DisCve = DisCve
     c                   Eval      I_CdoCve = CveCdo
     c                   Eval      I_NotNum = NumDoc
     c                   Eval      I_NotSec = NotSec
     c                   Eval      I_NotReg = '*'
     c                   Write     CxcNottf
      *
     c                   EndSr
      * ----------------------------------------------------------
      *   Buscar Ncf de las facturas                             -
      * ----------------------------------------------------------
     c     Buscar_FT     BegSr
     c     *Like         Define    y_NcfNro      NcfNro
     c     *Like         Define    FecDre        FecDoc
      *
     c     *Like         Define    FecDre        FechaDoc
     c                   Eval      FechaDoc = %Dec(%Date(FecDre:*Eur):*Iso)
      *
      * Para Buscar el Ncf de cada Factura
     c                   Clear                   NcfNro
     c                   Clear                   FecDoc
     c                   Clear                   DtoTip            1 0
     c/Exec Sql
     c+   Select T1.NcfNro, T2.DtoFec, T1.DtoTip
     c+     Into :NcfNro, :FecDoc, :DtoTip
     c+     From FacDed T1
     c+     Join FacDtoh01 T2 On
     c+          (T1.DisCve = T2.DisCve) And
     c+          (T1.DtoTip = T2.DtoTip) And
     c+          (T1.DtoNro = T2.DtoNro)
     c+    Where (T1.DisCve = :DisCve)
     c+      And (T2.CliCve = :CliCve)
     c+      And (T1.DtoNro = :NcdDre)
     c+      And (T2.DtoFec = :FechaDoc)
     c/End-Exec
     c                   Clear                   SqlCod
     c                   Eval      FecDoc = %Dec(%Date(FecDoc:*Iso):*Eur)
      *
     c                   EndSr
      * ----------------------------------------------------------
      *  Eliminar Comentarios Fijos                              -
      * ----------------------------------------------------------
     c     Eliminar      Begsr
      *
     c/Exec Sql
     c+   Delete From CxcNott
     c+    Where (DisCve = :DisCve) And
     c+          (CdoCve = :CveCdo) And
     c+          (NotNum = :NumDoc) And
     c+          (NotReg = '*')
     c*  With NC
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr
      * Buscar parametros Facturas Productos
     c     ParCve        Chain(n)  FacParf                            99
      *
     c                   EndSr
      * ----------------------------------------------------------
