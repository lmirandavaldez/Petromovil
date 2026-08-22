# NomEmp — Maestro de Empleados

**Biblioteca:** DATOS02  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Empleados  
**Descripción:** Tabla central del sistema de nómina. Contiene un registro por cada
empleado activo o inactivo de la empresa, con sus datos personales, laborales,
de contacto y fechas clave.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 EMPNOM         5     24     20        A   NOMBRES EMPLEADO                          NOMBRE_EMPLEADO
 EMPAPE        25     44     20        A   APELLIDOS EMPLEADO                        APELLIDOS_EMPLEADO
 EMPCED        45     50      6   0    P   CEDULA IDENTIDAD Y ELECTORAL              CEDULA_IDENTIDAD_ECLECT
 EMPCAN        51     54      4   0    P   CEDULA ANTERIOR                           CEDULA_ANTERIOR
 EMPSER        55     56      2   0    P   SERIE CEDULA ANTERIOR                     SERIE_CEDULA_ANTERIOR
 CNOCVE        57     58      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 DEPCVE        59     60      2   0    P   CODIGO DE DEPARTAMENTO                    CODIGO_DEPARTAMENTO
 SECCVE        61     62      2   0    P   CODIGO DE SECCION                         CODIGO_SECCION
 CATCVE        63     65      3   0    P   CODIGO DE CATEGORIA                       CODIGO_CATEGORIA
 CARCVE        66     68      3   0    P   CODIGO DE CARGO                           CODIGO_CARGO
 UBICVE        69     70      2   0    P   CODIGO DE UBICACION                       CODIGO_UBICACION
 PLACVE        71     72      2   0    P   PLANTA PRODUCCION                         PLANTA_EMPLEADO
 EMPSEX        73     73      1        A   SEXO                                      SEXO_EMPLEADO
 EMPTE1        74     93     20        A   TELEFONO 1                                TELEFONO_1
 EMPTD1        94    113     20        A   DESCRIPCION TELEFONO 1                    DESC_TELEFONO_1
 EMPTE2       114    133     20        A   TELEFONO 2                                TELEFONO_2
 EMPTD2       134    153     20        A   DESCRIPCION TELEFONO 2                    DESC_TELEFONO_2
 EMPTE3       154    173     20        A   TELEFONO 3                                TELEFONO_3
 EMPTD3       174    193     20        A   DESCRIPCION TELEFONO 3                    DESC_TELEFONO_3
 EMPDI1       194    233     40        A   DIRECCION                                 DIRECCION_EMPLEADO_1
 EMPDI2       234    273     40        A   DIRECCION                                 DIRECCION_EMPLEADO_2
 EMPEMA       274    323     50        A   DIRECCION EMAIL                           DIRECCION_EMAIL
 EMPND1       324    326      3        A   NOMBRE DOCTO. 1                           DOCUMENTO_1
 EMPDD1       327    341     15        A   DESCRIPCION DOCTO. 1                      DECRIPCION_DOCTO_1
 EMPND2       342    344      3        A   NOMBRE DOCTO. 2                           DOCUMENTO_2
 EMPDD2       345    359     15        A   DESCRIPCION DOCTO. 2                      DECRIPCION_DOCTO_2
 PROCVE       360    361      2   0    P   CODIGO DE PROFESION                       CODIGO_PROFESION
 NACCVE       362    363      2   0    P   CODIGO DE NACIONALIDAD                    CODIGO_NACIONALIDAD
 EMPLNA       364    388     25        A   LUGAR DE NACIMIENTO                       LUGAR_NACIMIENTO
 EMPESC       389    389      1        A   ESTADO CIVIL                              ESTADO_CIVIL
 EMPDEP       390    391      2   0    P   CANTIDAD DEPENDIENTES                     CANTIDAD_DEPENDIENTES
 EMPTSA       392    395      4        A   TIPO DE SANGRE                            TIPO_DE_SANGRE
 EMPRNC       396    410     15        A   R.N.C.                                    REG_NAC_CONTRIB
 EMPRSS       411    425     15        A   REGISTRO SEG. SOCIAL                      REG_SEG_SOCIAL
 EMPPES       426    428      3   2    P   PESO                                      PESO
 EMPEST       429    430      2   2    P   ESTATURA                                  ESTATURA
 EMPCPE       431    440     10        A   COLOR DEL PELO                            COLOR_PELO
 EMPTEZ       441    450     10        A   COLOR DE LA PIEL                          COLOR_DE_LA_PIEL
 EMPSBA       451    457      7   2    P   SALARIO MENSUAL                           SALARIO_MENSUAL
 EMPSBP       458    464      7   2    P   SALARIO MENSUAL OTRO PATRON               SALARIO_MENSUAL_PATRON
 EMPSAL       465    471      7   2    P   SALARIO ORDINARIO                         SALARIO_ORDINARIO
 EMPSOP       472    478      7   2    P   SALARIO OTRO PATRON                       SALARIO_OTRO_PATRON
 EMPSHR       479    485      7   4    P   SALARIO POR HORA                          SALARIO_POR_HORA
 EMPFPG       486    486      1        A   FORMA DE PAGO                             FORMA_PAGO
 BANCVE       487    489      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 EMPCBA       490    504     15        A   CUENTA BANCARIA                           CUENTA_BANCARIA
 EMPTCB       505    505      1   0    P   TIPO CUENTA BANCARIA                      TIPO_CUENTA_BANCARIA
 EMPTIP       506    506      1   0    P   TIPO DE EMPLEADO                          TIPO_DE_EMPLEADO
 EMPTSL       507    507      1   0    P   TIPO DE SALARIO                           TIPO_DE_SALARIO
 EMPEVA       508    508      1   0    P   ESTADO DE VACACIONES                      ESTADO_VACACIONES
 CTACVE       509    526     18        A   NUMERO CUENTA CONTABLE                    NUMERO_CUENTA_CONTABLE
 AUXCVE       527    530      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE       531    540     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_DE_CENTRO_COSTOS
 EMPCES       541    541      1   0    P   CODIGO ESTADO EMPLEADO                    CODIGO_ESTADOA_EMPLEADO
 EMPSTA       542    542      1        A   STATUS                                    STATUS_EMPLEADO
 EMPANA       543    545      3   0    P   ANO DE NACIMIENTO                         ANO_NACIMIENTO
 EMPMNA       546    547      2   0    P   MES DE NACIMIENTO                         MES_NACIMIENTO
 EMPDNA       548    549      2   0    P   DIA DE NACIMIENTO                         DIA_NACIMIENTO
 EMPAIN       550    552      3   0    P   ANO INGRESO                               ANO_INGRESO
 EMPMIN       553    554      2   0    P   MES INGRESO                               MES_INGRESO
 EMPDIN       555    556      2   0    P   DIA INGRESO                               DIA_INGRESO
 EMPAFI       557    559      3   0    P   ANO FIJACION                              ANO_FIJACION
 EMPMFI       560    561      2   0    P   MES FIJACION                              MES_FIJACION
 EMPDFI       562    563      2   0    P   DIA FIJACION                              DIA_FIJACION
 EMPASA       564    566      3   0    P   ANO DE SALIDA                             ANO_SALIDA
 EMPMSA       567    568      2   0    P   MES DE SALIDA                             MES_SALIDA
 EMPDSA       569    570      2   0    P   DIA DE SALIDA                             DIA_SALIDA
 EMPAEV       571    573      3   0    P   ANO DE EVALUACION                         ANO_EVALUACION
 EMPMEV       574    575      2   0    P   MES DE EVALUACION                         MES_EVALUACION
 EMPDEV       576    577      2   0    P   DIA DE EVALUACION                         DIA_EVALUACION
 EMPAUN       578    580      3   0    P   ANO DE ULTIMA NOMINA                      ANO_ULTIMA_NOMINA
 EMPMUN       581    582      2   0    P   MES DE ULTIMA NOMINA                      MES_ULTIMA_NOMINA
 EMPDUN       583    584      2   0    P   DIA DE ULTIMA NOMINA                      DIA_ULTIMA_NOMINA
 EMPAVA       585    587      3   0    P   ANO DE INICIO VACACIONES                  ANO_INICIO_VACACIONES
 EMPMVA       588    589      2   0    P   MES DE INICIO VACACIONES                  MES_INICIO_VACACIONES
 EMPDVA       590    591      2   0    P   DIA DE INICIO VACACIONES                  DIA_INICIO_VACACIONES
 EMPAFV       592    594      3   0    P   ANO FIN VACACIONES                        ANO_FIN_VACACIONES
 EMPMFV       595    596      2   0    P   MES FIN VACACIONES                        MES_FIN_VACACIONES
 EMPDFV       597    598      2   0    P   DIA FIN VACACIONES                        DIA_FIN_VACACIONES
 EMPAIL       599    601      3   0    P   ANO INICIO LICENCIA                       ANO_INICIO_LICENCIA
 EMPMIL       602    603      2   0    P   MES INICIO LICENCIA                       MES_INICIO_LICENCIA
 EMPDIL       604    605      2   0    P   DIA INICIO LICENCIA                       DIA_INICIO_LICENCIA
 EMPAFL       606    608      3   0    P   ANO FIN LICENCIA                          ANO_FIN_LICENCIA
 EMPMFL       609    610      2   0    P   MES FIN LICENCIA                          MES_FIN_LICENCIA
 EMPDFL       611    612      2   0    P   DIA FIN LICENCIA                          DIA_FIN_LICENCIA
 EMPESS       613    613      1   0    P   EXONERADO ISS                             EXONERADO_ISS
 EMPEIS       614    614      1   0    P   EXONERADO ISR                             EXONERADO_ISR
 EMPEBO       615    615      1   0    P   EXONERADO BONOS                           EXONERADO_BONOS
 EMPEAD       616    616      1   0    P   EXONERADO DIAS ADICIONALES                EXONERADO_DIAS_ADICIONALES
 EMPEX1       617    617      1   0    P   EXONERADO UNO                             EXONERADO_UNO
 EMPEX2       618    618      1   0    P   EXONERADO DOS                             EXONERADO_DOS
 EMPEX3       619    619      1   0    P   EXONERADO TRES                            EXONERADO_TRES
 EMPPBO       620    620      1        A   PRORRATEA BONOS                           PRORRATEA_BONOS
 EMPCCD       621    621      1        A   C. COSTOS DISTRIBUIDO                     C_COSTO_DISTRIBUIDO
 EMPCSP       622    624      3   0    P   CONC. SALARIO OTROS PATRONOS              CONC_SALARIO_OTROS_PATRONO
 USRCRE       625    634     10        A   USUARIO QUE CREO                          USUARIO_QUE_CREO
 WSICRE       635    644     10        A   TERMINAL DONDE SE CREO                    TERMINAL_DONDE_SE_CREO
 FECCRE       645    649      5   0    P   FECHA QUE SE CREO                         FECHA_QUE_SE_CREO
 HORCRE       650    653      4   0    P   HORA QUE SE CREO                          HORA_QUE_SE_CREO
 USRUCA       654    663     10        A   USUARIO QUE ACTUALIZO                     USUARIO_QUE_ACTUALIZO
 WSIUCA       664    673     10        A   TERMINAL DONDE SE ACTUALIZO               TERMINAL_DONDE_ACTUALIZO
 FECUCA       674    678      5   0    P   FECHA QUE SE ACTUALIZO                    FECHA_QUE_ACTUALIZO
 HORUCA       679    682      4   0    P   HORA QUE SE ACTUALIZO                     HORA_QUE_ACTUALIZO
 CMCCVE       683    685      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
---

## Claves e Índices

| Tipo | Campos | Descripción                  |
|------|--------|------------------------------|
| PK   | EmpCve | CODIGO EMPLEADO|

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| DepCve | NomDep | DepCve | Departamento del empleado |
| CarCve | NomCar | CarCve | Cargo / Puesto |
| CatCve | NomCat | CatCve | Categoría laboral |
| CmcCve | NomCmc | CmcCve | Centro de costo de nómina |
| CnoCve | NomCno | CnoCve | Concepto / Ciclo de nómina |
| NacCve | NomNac | NacCve | Nacionalidad |
| UbiCve | NomUbi | UbiCve | Ubicación física |
| ProCve | NomPro | ProCve | Provincia |
| CcoCve | CogCco | CcoCve | Centro de costo contable |

---

## Observaciones

- Es la tabla de mayor uso en el módulo NOM. Casi todas las vistas parten de ella.
- Los campos de fecha (`EmpFin`, `EmpFnc` y otros similares) están en formato
  DECIMAL 8,0 (AAAAMMDD). Para convertirlos a DATE usar `LEFT JOIN SegFec`
  con centinela `DATE('1900-01-01')`.
- La cédula (`EmpCed`) se usa para generar el código único en `NomCui`.
- Referenciada en programas RPG mediante `ExtName(NomEmp) Qualified`.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
