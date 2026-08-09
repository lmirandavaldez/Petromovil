     h   Copyright ('Miranda Valdez, S. A., 2005')
     h   Datedit(*Dmy)
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
     h   Dftactgrp(*NO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA1055                           *
      *  APLICACION...................: Facturacion                      *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 04 / 09 / 2009                   *
      *  DESCR:                                                          *
      *         De Clientes con Pedidos Sugeridos                        *
      *==================================================================*
     fCxcVen01  If   e           k disk
     fCxcCli01  If   e           k disk
     fInvCat01  If   e           k disk
     fFacDto08jnIf   e           k disk
     fFacCpc01  If   e           k disk    Prefix(I_)
     fCxcDgc01  If   e           k Disk    Prefix(X_)
     fFac1055   Uf a e             Disk
     fFA1055pt  o    e             Printer Oflind(*In66) UsrOpn
      *
     d FecDiaIso       s               d   DatFmt(*Iso)
     d FecDocIso       s               d   DatFmt(*Iso)
     d FechaEur        s               d   DatFmt(*Eur)
      *
     d Dds1            s             50    Inz(*Blanks)
     d Dds2            s             50    Inz(*Blanks)
     d ImpVen          s               n   Inz(*Off)
     d PrimerReg       s               n   Inz(*Off)
L004 d Status          S               n
L004 d FacturaDis      s               n
      *
L001  * Parametros
 ''  d SistemaFA       s              2    inz('FA')
 ''  d SistemaCC       s              2    inz('CC')
 ''  d CodParametro    s              4  0 inz(*Zeros)
 ''  d ValorNum        s             30 15 inz(*Zeros)
 ''  d ValorAlf        s            100    inz(*Blank)
      *
      /Copy Fuentes,SG9001
      * --------------------------------------------------------
      *                  Bloque principal                      -
      * --------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    CodDis            3
     c                   Parm                    CodVen            3
     c                   Parm                    CodCat            4
     c                   Parm                    FechaH            8
      *
     c     Clave_Cpc     Klist
     c                   Kfld                    CodCli
     c                   Kfld                    ArtCve
      *
     c     *Like         Define    DtoFec        FechaHasta
     c     *Like         Define    VenCve        CveVen
     c     *Like         Define    VenCve        VenCon
     c     *Like         Define    VenCve        VenCod
     c     *Like         Define    DisCve        DisCod
     c     *Like         Define    CatCve        Catego
      *
     c                   Clear                   DtoFec
     c                   Clear                   DtoCan
      *
     c                   Eval      DisCod = %Dec(CodDis:3:0)
     c                   Eval      VenCod = %Dec(CodVen:3:0)
     c                   Eval      Catego = %Dec(CodCat:4:0)
     c                   Eval      FechaHasta = %Dec(FechaH:8:0)
     c                   Eval      FecHas = %Dec(%Date(FechaHasta:*Iso):*Eur)
      *
      * Empresa no valida el despacho por distrito no debe seleccionar distrito
     c                   If        FacturaDis = *Off
     c                   Clear                   DisCod
     c                   EndIf
      *
      * Proceso Para crear Tabla Temporal
     c                   Exsr      Crear_Tabla
      * Proceso Seleccion Datos
     c                   Exsr      Proceso
      * Reporte
     c                   Exsr      Reporte
      * Proceso Para Borrar Tabla Temporal
     c                   Exsr      Borrar_Tabla
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccionar datos                                        *
      * ----------------------------------------------------------*
     c     Proceso       BegSr
      *
     c/Exec Sql
     c+      Insert Into Facturas_Emitidas
     c+      (Select T1.VenCve, T2.CatCve, T1.CliCve, Max(T2.DtoFec)
     c+         From CxcCli02jn T1
     c+         Join FacDto08jn T2 On (T1.CliCve = T2.CliCve)
     c+         Join CxcVen T3 On (T1.VenCve = T3.VenCve)
     c+        Where (T1.CliSta = 'A')
     c+          And (T1.AdcDcr <> 998)
     c+          And (T2.ArtPpr = 'S')
     c+          And (T2.ArtSta = 'A')
     c+          And (T2.DtoTip = 1 Or T2.DtoTip > 3)
     c+          And (T3.VenSta <> 'S')
     c+          And (T2.DisCve = :DisCod Or :DisCod = 0)
     c+          And (T2.CatCve = :Catego Or :Catego = 0)
     c+          And (T1.VenCve = :VenCod Or :VenCod = 0)
     c+     Group By T1.VenCve, T2.CatCve, T1.CliCve
     c+       Having Max(T2.DtoFec) <= :FechaHasta)
     c/End-Exec
      *
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------*
      *  Seleccionar Informacion a Imprimir                       *
      * ----------------------------------------------------------*
     c     Reporte       BegSr
     c                   Clear                   Dds1
     c                   Clear                   Dds2
     c                   Open      FA1055pt
      *
     c                   Eval      PrimerReg = *On
      *
     c/Exec Sql
     c+   Declare C1 cursor for
     c+       Select *
     c+         From Facturas_Emitidas
     c+     Order By Ven, Cat, Fec, Cli
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
     c                   Clear                   CanVen
      *
     c                   Dow       SqlCod = 0
     c/Exec Sql Fetch C1 Into :VenCve, :CatCve, :CliCve, :DtoFec
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      * Si desea imprimir el reporte de registros seleccionados
     c                   Eval      Dds1 = %Editc(VenCve:'X') +
     c                                    %Trim(%Editc(CatCve:'X'))
      *
     c                   Eval      ImpVen = *Off
      * Verificar la ruptura de control
     c                   If        Dds1 <> Dds2
      * Verificar si el Vendedor o la Categoria
     c                   If        %Subst(Dds1:1:7) <> %Subst(Dds2:1:7)
     c                   Eval      ImpVen = *On
     c     VenCve        Chain     CxcVenf
     c     CatCve        Chain     InvCatf
     c                   EndIf
      *
     c                   Eval      Dds2 = Dds1
     c                   EndIf
      * Imprimir Total por Vendedor
     c                   If        ImpVen And Not PrimerReg
     c                   Write     TotOfic
     c                   Clear                   TotOfic
     c                   EndIf
      * Imprimir el cabecera
     c                   If        ImpVen = *On or *In66 = *on
     c                   Write     Header
     c                   Eval      *In66 = *Off
     c                   EndIf
      *
     c     *Like         Define    CliCve        CodCli
     c     *Like         Define    CatCve        CatCod
     c     *Like         Define    DtoFec        FechaDoc
      *
     c                   Eval      CatCod = CatCve
     c                   Eval      CodCli = CliCve
     c                   Eval      FechaDoc = DtoFec
      *
     c                   Eval      Status = *Off
      * Verifica si Tiene transacciones en el historico
     c/Exec Sql
     c+   Select '1' Into :Status From AcfAfi
     c+    Where (CliCve = :CliCve)
     c+      And (AfiSta <> 'B')
     c/End-Exec
      *
     c                   If        Status = *On
     c                   Eval      *In58 = *On
     c                   Eval      IdeAct = '*'
     c                   Else
     c                   Eval      *In58 = *Off
     c                   Eval      IdeAct = *Blanks
     c                   EndIf
      *
     c                   Exsr      Detalle
      *
     c     CliCve        Chain     CxcDgcf                            55
     c                   If        %Found(CxcDgc01)
     c                             And X_DgcCdd = *Zeros
     c                   Eval      X_DgcCdd = 21
     c                   EndIf
     c                   Eval      CpcCdd = X_DgcCdd
      *
     c                   Eval      FecDocIso = %Date(DtoFec)
     c                   Eval      FecDiaIso = %Date(FechaHasta)
     c     FecDiaIso     SubDur    FecDocIso     Dias:*d           5 0
     c                   Eval      DiaTra = Dias
      *
     c                   AddDur    X_DgcCdd:*D   FecDocIso
     c     FecDiaIso     SubDur    FecDocIso     Diasult:*d        5 0
      *
     c*                  If        DiasUlt < X_DgcCdd
     c                   If        DiasUlt <= *Zeros
     c                   Iter
     c                   EndIf
      *
     c     CliCve        Chain     CxcClif
     c                   Eval      NomCli = %Trim(CliNom)
      *
     c                   Eval      FecDto = %Dec(%Date(DtoFec:*Iso):*Eur)
     c                   Eval      FulDoc = %Date(DtoFec)
     c                   Eval      CulDes = CanDoc
     c                   Eval      CanPro = CanSug
      *
     c                   Write     Detail
     c                   Write     Fac1055f
     c                   Eval      PrimerReg = *Off
     c                   Eval      CanVen += 1
     c                   Clear                   Detail
      *
     c                   EndDo
      *
     c                   Write     TotOfic
     c                   Clear                   TotOfic
      *
     c/Exec SQL
     c+    Close C1
     c/End-Exec
     c                   Close     FA1055pt
     c                   EndSr
      * ----------------------------------------------------------*
      *  Seleccionar Detalle de un Documento                      *
      * ----------------------------------------------------------*
     c     Detalle       BegSr
      *
     c/Exec Sql
     c+   Declare C2 cursor for
     c+       Select DtoCan, ArtCve
     c+         From FacDto08jn
     c+        Where (:CodCli = CliCve) And
     c+              (:CatCod = CatCve) And
     c+              (:FechaDoc = DtoFec)
     c*      With NC
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C2
     c/End-Exec
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C2 Into :DtoCan, :ArtCve
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
     c     Clave_Cpc     Chain     FacCpcf                            55
     c                   If        Not %Found(FacCpc01)
     c                             Or I_CpcCvC = *Zeros
     c                   Eval      I_CpcCvc = DtoCan * 1
     c                   EndIf
      *
     c     DtoCan        Mult      1             CanDoc
     c*    DtoCan        Mult      1             CanSug
     c     I_CpcCvc      Mult      1             CanSug
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C2
     c/End-Exec
     c                   Clear                   SqlCod
     c                   EndSr
      * ----------------------------------------------------------*
      *  Crear Tabla Temporal                                     *
      * ----------------------------------------------------------*
     c     Crear_Tabla   BegSr
      *
     c/Exec Sql
     c+ Declare Global Temporary Table Facturas_Emitidas
     c+ (Ven Dec(3), Cat Dec(4), Cli Dec(7), Fec Dec(8))
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------*
      *  Borrar Tabla Temporal                                    *
      * ----------------------------------------------------------*
     c     Borrar_Tabla  BegSr
      *
     c/Exec Sql
     c+ Drop Table Facturas_Emitidas
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------
      *  Para Buscar Parametros Generales                        -
      * ----------------------------------------------------------
     c     PrnGenerales  BegSr
      *
L004  *  Para saber si se factura por el distrito de cliente o no
 ''  c                   Eval      Sistema = SistemaFa
 ''  c                   Clear                   FacDistrito       1
 ''   *
 ''  c                   Eval      CodParametro = 0060
 ''  c                   Exsr      Parametros
 ''  c                   Movel(p)  ValorAlf      FacDistrito
 ''   *
 ''  c                   If        FacDistrito = 'S'
 ''  c                   Eval      FacturaDis = *On
 ''  c                   Else
 ''  c                   Eval      FacturaDis = *Off
L004 c                   EndIf
      *
     c                   EndSr
L001  * ----------------------------------------------------------
 ''   * Parametros del sistema                                   -
 ''   * ----------------------------------------------------------
 ''  c     Parametros    Begsr
 ''  c                   Call      'SG7009'                             60
 ''  c                   Parm                    Sistema           2
 ''  c                   Parm                    CodParametro
 ''  c                   Parm                    ValorNum
 ''  c                   Parm                    ValorAlf
 ''   *
L001 c                   Endsr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        BegSr
      *
     c                   Exsr      PrnGenerales
      *

        // Borrar detalle Gastos
          Exec Sql
               Delete From Fac1055
                 With NC;

      *
     c                   EndSr
      * -----------------------------------------------------------
