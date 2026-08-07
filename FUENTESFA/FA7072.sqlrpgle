     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1999')
     h   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: FA7072                           *
      *  APLICACION...................: Sistema de Facturación           *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 23 / 11 / 1999                   *
      *  DESCR:                                                          *
      *    Re-Calcular el Costo x Documento Emp. Manejan Existencia      *
      *  ================================================================*
     fFacDtoh01 Uf   e           k Disk
     fFacDtod01 Uf   e           k Disk
     fInvArt01  If   e           k Disk
     fInvUal01  If   e           k Disk
     fFacPar    If   e           k Disk
 ''   *
     d Registros       S               n
     d FechaEur        s               d   Datfmt(*Eur)
     d FechaIso        s               d   Datfmt(*Iso)
     d FechaInicio     s                   Like(DtoFec) Inz(*Zeros)
     d FechaTra        s                   Like(DtoFec) Inz(*Zeros)
     d ParCve          s              1    inz('@')
      *
     dSqlFacDtoh     e Ds                  ExtName(FacDtoh04) Prefix(Y_)
 ''   *
L001  /Copy Fuentes,SG9001
      *
     d                 Ds
     d FechaCierre             1      8  0
     d  AnoCierre              1      4  0
     d  MesCierre              5      6  0
     d  DiaCierre              7      8  0
 ''   *
     iFacDtodf
     i              DtoFec                      X_DtoFec
      * --------------------------------------------------------
      *                  Bloque Principal                      -
      * --------------------------------------------------------
     c     Clave_Dtoh    Klist
     c                   Kfld                    Y_DisCve
     c                   Kfld                    Y_DtoTip
     c                   Kfld                    Y_DtoNro
      *
     c     Clave_Rau     Klist
     c                   Kfld                    ArtCve
     c                   Kfld                    DtoUde
      *
     c                   Exsr      Proceso
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------
      *  Desplegar 1ra. pantalla                                 -
      * ----------------------------------------------------------
     c     Proceso       BegSr
      *
     c/Exec Sql
     c+   Declare C1 Cursor For
     c+       Select *
     c+       From FacDtoh04
     c+       Where (DtoFec >= :FechaInicio)
     c+       Order by DisCve, DtoTip, DtoFec, DtoNro, CliCve
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
     c                   Dow       SqlCod = 0
     c/Exec Sql Fetch C1 Into :SqlFacDtoh
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   Endif
      *
     c                   Eval      FechaTra = Y_DtoFec
      * Ejecutar Detalle
     c                   Exsr      Detalle
      *
     c                   If        Registros = *On
     c     Clave_Dtoh    Chain     FacDtohf                           55
     c                   If        %Found(FacDtoh01)
     c                   Eval      DtoMpr = DtoMpr - CosPro + Total_CosPro
     c                   Eval      DtoMul = DtoMul - CosUlt + Total_CosUlt
     c                   Update    FacDtohf
     c                   EndIf
     c                   EndIf
      *
     c                   EndDo
      *
     c/Exec SQL
     c+    Close C1
     c/End-Exec
     c                   EndSr
      * ----------------------------------------------------------
      *  Detalle                                                 -
      * ----------------------------------------------------------
     c     Detalle       BegSr
     c                   Eval      *In23 = *Off
      *
     c                   Clear                   Total_CosPro
     c                   Clear                   Total_CosUlt
      *
     c                   Clear                   CosPro
     c                   Clear                   CosUlt
     c                   Eval      Registros = *Off
      *
     c     *Like         Define    DtoMcp        CosPro
     c     *Like         Define    DtoMcu        CosUlt
      *
     c     *Like         Define    DtoMpr        Total_CosPro
     c     *Like         Define    DtoMul        Total_CosUlt
      *
     c     Clave_Dtoh    Setll     FacDtodf
     c                   Dow       Not *In23
     c     Clave_Dtoh    Reade     FacDtodf                               23
     c                   If        Not *In23
      *
     c     ArtCve        Chain     InvArtf                            55
     c                   If        %Found(InvArt01)
     c                             And TiiCve <> 1
     c                   Iter
     c                   Endif
      *
     c                   Eval      Registros = *On
      *
     c                   If        ArtPpr = 'S'
     c                   Exsr      Cos_Regulado
     c                   Else
 ''   *
 ''  c                   Clear                   CostoPro
 ''  c                   Clear                   CostoUlt
     c                   Eval      CostoPro = ArtCpl * 1
     c                   Eval      CostoUlt = ArtCul * 1
     c                   EndIf
      *
     c                   If        DtoUde = ArtUal
     c                   Eval      DtoCop = CostoPro * 1
     c                   Eval      DtoCou = CostoUlt * 1
     c                   Else
     c     Clave_Rau     Chain(n)  InvUalf                            31
     c                   Eval(rh)  DtoCop = (CostoPro / ArtCua) * UalCon
     c                   Eval(rh)  DtoCou = (CostoUlt / ArtCua) * UalCon
     c                   EndIf
      *
     c                   Eval      CosPro = CosPro + DtoMcp
     c                   Eval      CosUlt = CosUlt + DtoMcu
      *
     c                   Eval(Rh)  DtoMcp = DtoCan * DtoCop
     c                   Eval(Rh)  DtoMcu = DtoCan * DtoCou
     c                   Eval      Total_CosPro = Total_CosPro + DtoMcp
     c                   Eval      Total_CosUlt = Total_CosUlt + DtoMcu
     c                   Update    FacDtodf
      *
     c                   EndIf
     c                   EndDo
     c                   EndSr
L001  *-------------------------------------------------------------
 ''   *  Buscar El costo en las empresas que no manejan existencia -
 ''   *-------------------------------------------------------------
 ''  c     Cos_Regulado  BegSr
 ''  c     *Like         Define    ArtCpl        CostoPro
 ''  c     *Like         Define    ArtCul        CostoUlt
 ''  c                   Clear                   CostoPro
 ''  c                   Clear                   CostoUlt
 ''  c                   Clear                   Total_Can        13 2
 ''   *
 ''  c                   Call      'FA7061'
 ''  c                   Parm                    ArtCve
 ''  c                   Parm                    FechaTra
 ''  c                   Parm                    CostoPro
 ''  c                   Parm                    CostoUlt
 ''  c                   Parm                    Total_Can
 ''   *
L001 c                   EndSr
      * ----------------------------------------------------------
      *   Subrutina Inicial                                      -
      * ----------------------------------------------------------
     c     *Inzsr        Begsr
      *
     c     ParCve        Chain(n)  FacParf                            99
     c                   If        %Found(FacPar)
     c                             And AnoUpc <> *Zeros
     c                             And NumUpc <> *Zeros
     c                   Eval      AnoCierre = AnoUpc
     c                   Eval      MesCierre = NumUpc
     c                   Eval      DiaCierre = 01
      *
     c     *Iso          Move      FechaCierre   FechaIso
     c                   AddDur    1:*M          FechaIso
     c*                  SubDur    1:*D          FechaIso
     c                   Move      FechaIso      FechaInicio
      *
     c                   Else
     c                   Eval      AnoCierre = *Year
     c                   Eval      MesCierre = *Month
     c                   Eval      DiaCierre = 01
      *
     c     *Iso          Move      FechaCierre   FechaIso
     c                   SubDur    1:*M          FechaIso
     c                   Move      FechaIso      FechaInicio
     c                   EndIf
      *
     c                   EndSr
      * -----------------------------------------------------------
