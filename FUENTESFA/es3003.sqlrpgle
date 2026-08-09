     h   Datedit(*dmy)
     h   Copyright ('Miranda Valdez, S. A., 1999')
     H   Debug Option(*SRCSTMT:*NODEBUGIO)
      *  ================================================================*
      *  IDENTIFICACION:                                                 *
      *  ---------------                                                 *
      *  NOMBRE DEL PROGRAMA .........: ES3003                           *
      *  APLICACION...................: Estadisticas de ventas           *
      *  AUTOR .......................: Luis J. Miranda V.               *
      *  FECHA ESCRITURA .............: 28 / 05 / 2009                   *
      *  DESCR:                                                          *
      *                                                                  *
      *         Crea Archivo temporal                                    *
      *  ================================================================*
0012 fEstTvcp   Uf a e           k Disk
     fCxcCli01  If   e           k Disk    Prefix(X_)
     fInvArt01  If   e           k Disk    Prefix(J_)
     fCxcVen01  If   e           k Disk    Prefix(T_)
0019  *
0022 d Cf              s              8  0 Dim(12)
0022 d Cv              s             12  2 Dim(12)
0022 d Cu              s              7  0 Dim(12)
0030 d Ci              s             12  2 Dim(12)
      *
     d Dds1            s             50    Inz(*Blanks)
     d Dds2            s             50    Inz(*Blanks)
     d Niv001          s               n   Inz(*Off)
     d PrimerReg       s               n   Inz(*Off)
     d PrimerRegl1     s               n   Inz(*Off)
      *
     d CodSup          s                   Like(SqlCxcVen.SupCve)
      *
      * arreglo tcv acumula cantidad x vendedor y marca
     d               e ds                  Extname(EstTvcp)
     d  tcf                  194    277p 2
     d                                     Dim(12)
     d  tcv                  286    369p 2
     d                                     Dim(12)
     d  tcu                  377    424p 2
     d                                     Dim(12)
     d  tci                  430    513p 2
     d                                     Dim(12)
0042  *
     dSqlFacDto02jn  e Ds                  ExtName(FacDto02jn) Prefix(I_)
     d SqlCxcAdc     e Ds                  ExtName(CxcAdc) Qualified
     d SqlCxcVen     e Ds                  ExtName(CxcVen) Qualified
     d SqlCxcCla     e Ds                  ExtName(CxcCla) Qualified
      *------------------------------------------------------------
      * Inicio del proceso                                        -
      *------------------------------------------------------------
     c     *Entry        Plist
     c                   Parm                    DisCod            3
     c                   Parm                    SupCod            2
     c                   Parm                    VenCod            3
     c                   Parm                    CliCod            7
     c                   Parm                    CatCod            4
     c                   Parm                    FecDes            8
     c                   Parm                    FecHas            8
      *
     c     *Like         Define    I_DisCve      CodDis
     c     *Like         Define    I_VenCve      CodVen
     c     *Like         Define    I_CatCve      CodCat
     c     *Like         Define    I_CliCve      CodCli
     c     *Like         Define    I_DtoFec      FechaD
     c     *Like         Define    I_DtoFec      FechaH
      *
     c                   Eval      CodDis = %Dec(DisCod:3:0)
     c                   Eval      CodSup = %Dec(SupCod:2:0)
     c                   Eval      CodVen = %Dec(VenCod:3:0)
     c                   Eval      CodCli = %Dec(CliCod:7:0)
     c                   Eval      CodCat = %Dec(CatCod:4:0)
     c                   Eval      FechaD = %Dec(FecDes:8:0)
     c                   Eval      FechaH = %Dec(FecHas:8:0)
      *
     c                   Exsr      Seleccion_Reg
     c                   Eval      *InLr = *On
      * ----------------------------------------------------------*
      *  Seleccion de Registros                                   *
      * ----------------------------------------------------------*
     c     Seleccion_Reg BegSr
      *
     c                   Clear                   Dds1
     c                   Clear                   Dds2
     c     *Like         Define    I_DtoMes      Mes
     c     *Like         Define    I_DtoMes      DtoMes
     c     *Like         Define    I_DtoAno      DtoAno
     c     *Like         Define    I_DtoCua      DtoCua
     c     *Like         Define    I_DtoImp      DtoImp
     c     *Like         Define    T_VenCve      CveVen
     c     *Like         Define    X_CliCve      CveCli
     c     *Like         Define    J_ArtCve      CveArt
      *
     c                   Clear                   CanDoc            7 0
     c                   Clear                   TcfAacu           8 0
     c                   Clear                   TcvAacu          13 2
     c                   Clear                   TcuAacu           9 0
     c                   Clear                   TivAacu          13 2
      *
     c                   Eval      PrimerReg = *On
     c                   Eval      PrimerRegl1 = *On
     c/Exec Sql
     c+   Declare C1 cursor for
     c+   Select T1.VenCve, T1.CliCve, T1.ArtCve, T1.DtoAno,
     c+          T1.DtoMes, Count(*), Sum(T1.DtoCua),
     c+          Sum(T1.DtoImp - (T1.DtoMpd + T1.DtoMsd) +
     c+             (T1.DtoIm1 + T1.DtoIm2))
     c+     From FacDto02jn T1
     c+     Join CxcVen T2
     c+       On (T1.VenCve = T2.VenCve)
     c+    Where (T1.DisCve = :CodDis Or :CodDis = 0)
     c+      And (T2.SupCve = :CodSup Or :CodSup = 0)
     c+      And (T1.VenCve = :CodVen Or :CodVen = 0)
     c+      And (T1.CliCve = :CodCli Or :CodCli = 0)
     c+      And (T1.CatCve = :CodCat Or :CodCat = 0)
     c+      And (T1.DtoFec Between :FechaD And :FechaH)
     c+      And (T1.DtoSta = 'A')
     c+      And (T1.DtoTip <> 3)
     c+ Group by T1.VenCve, T1.CliCve, T1.ArtCve, T1.DtoAno, T1.DtoMes
     c+ Order by T1.VenCve, T1.CliCve, T1.ArtCve, T1.DtoAno, T1.DtoMes
     c+      For Read Only
     c/End-Exec
      *
     c/Exec Sql
     c+    Open C1
     c/End-Exec
      *
     c                   Dow       SqlCod = *Zeros
     c/Exec Sql Fetch C1 into :CveVen, :CveCli, :CveArt, :DtoAno, :DtoMes,
     c+                       :CanDoc, :DtoCua, :DtoImp
     c/End-Exec
      *
     c                   If        SqlCod <> *Zeros
     c                   Leave
     c                   EndIf
      * Si desea imprimir el reporte de registros seleccionados
     c                   Eval      Dds1 = %Editc(CveVen:'X') +
     c                                    %Trim(%Editc(CveCli:'X')) +
     c                                    %Trim(CveArt)
     c*                                   %Trim(%Editc(DtoAno:'X')) +
     c*                                   %Trim(%Editc(DtoMes:'X'))
      *
     c                   Eval      Niv001 = *Off
      * Verificar la ruptura de control
     c                   If        Dds1 <> Dds2
      * Verificar si el Nivel Cambio
     c                   If        %Subst(Dds1:1:30) <> %Subst(Dds2:1:30)
     c                   Eval      Niv001 = *On
     c                   EndIf
      *
     c                   Eval      Dds2 = Dds1
     c                   EndIf
      *
     c                   If        Niv001 And Not PrimerReg
     c                   Exsr      Sub_Total
      *
     c                   Clear                   Cf
     c                   Clear                   Cv
     c                   Clear                   Cu
     c                   Clear                   Ci
     c                   Clear                   TcfAacu
     c                   Clear                   TcvAacu
     c                   Clear                   TcuAacu
     c                   Clear                   TivAacu
     c                   EndIf
      *
      * Imprimir Total por Nivel
     c                   Eval      Vencve = CveVen
     c                   Eval      Clicve = CveCli
     c                   Eval      Artcve = CveArt
      *
     c                   Eval      Mes = DtoMes
      *
     c                   If        Mes = *Zeros
     c                   Eval      Mes = 01
     c                   Endif
      *
     c                   Exsr      Convertir
      *
     c                   Eval      Cf(Mes) += CanDoc
     c                   Eval      Cv(Mes) += Cantidad
     c                   Eval      Cu(Mes) += Unidades
     c                   Eval      Ci(Mes) += DtoImp
      *
     c                   Eval      TcfAacu += CanDoc
     c                   Eval      TcvAacu += Cantidad
     c                   Eval      TcuAacu += Unidades
     c                   Eval      TivAacu += DtoImp
      *
     c                   Eval      PrimerReg = *Off
     c                   EndDo
      *
     c                   If        TcvAacu <> *Zeros
     c                   Exsr      Sub_Total
     c                   EndIf
      *
     c/Exec SQL
     c+    Close C1
     c/End-exec
     c                   EndSr
      * ----------------------------------------------------------
      *  Para Grabar los registro en el Archivo                  -
      * ----------------------------------------------------------
     c     Sub_Total     Begsr
      *
     c     Clave_Tvcp    Klist
     c                   Kfld                    VenCve
     c                   Kfld                    CliCve
     c                   Kfld                    ArtCve
      *
     c     VenCve        Chain(n)  CxcVenf                            55
     c                   Eval      VenNom = %Trim(T_VenNom)
     c     CliCve        Chain(n)  CxcClif                            55
     c                   Eval      CliNom = %Trim(X_CliNom)
     c     ArtCve        Chain(n)  InvArtf                            55
     c                   Eval      ArtDes = %Trim(J_ArtDes)
      *
      * Buscar Agrupacion en cuentas por Cobrar Tipo Negocio
     c                   Clear                   SqlCxcAdc
     c/Exec Sql
     c+   Select *
     c+     Into :SqlCxcAdc
     c+     From CxcAdc
     c+    Where (CliCve = :CliCve)
     c+  Fetch First 1 Rows Only
     c/End-Exec
     c                   Clear                   SqlCod
      *
      * Buscar Descripcion de Agrupacion
     c                   Clear                   SqlCxcCla
     c/Exec Sql
     c+   Select *
     c+     Into :SqlCxcCla
     c+     From CxcCla
     c+    Where (ClaCve = :SqlCxcAdc.ClaCve)
     c+  Fetch First 1 Rows Only
     c/End-Exec
     c                   Clear                   SqlCod
     c                   Eval      ClaCve = SqlCxcAdc.ClaCve
     c                   Eval      ClaDes = SqlCxcCla.ClaDes
      *
     c                   If        TcvAacu <> *Zeros
     c     Clave_Tvcp    Chain     EstTvcpf                           55
     c                   Eval      TvmPe1 = Tcfaacu
     c                   Eval      TvmCe1 = Tcvaacu
     c                   Eval      TvmCs1 = Tcuaacu
     c                   Eval      TvmMa1 = Tivaacu
     c                   Eval      Tcf = Cf
     c                   Eval      Tcv = Cv
     c                   Eval      Tcu = Cu
     c                   Eval      Tci = Ci
     c                   Write     EstTvcpf
     c                   Endif
     c                   Clear                   EstTvcpf
     c                   Endsr
      * ----------------------------------------------------------
      *  Rutina para pasar cantidades y recibir cantidad y unidad-
      * ----------------------------------------------------------
     c     Convertir     Begsr
     c                   Clear                   Cantidad         12 2
     c                   Clear                   Unidades         12 0
     c                   Clear                   Existencia       12 2
     c                   Move      'V'           Almven            1
     c                   Eval(rh)  Existencia = DtoCua * 1
      *
     c                   Call      'IV7003'
     c                   Parm                    Artcve
     c                   Parm                    Existencia
     c                   Parm                    Cantidad
     c                   Parm                    Unidades
     c                   parm                    Almven
      *
     c                   Endsr
0247  *---------------------------------------------------------------
