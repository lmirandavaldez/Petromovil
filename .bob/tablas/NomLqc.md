# NomLqc — Liquidación Cabecera

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera de liquidación de empleados. Registra los datos generales de cada proceso de liquidación: empleado, fecha de salida, tipo de liquidación y estado.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 LQCSAA         5     11      7   2    P   SALARIO  ACTUAL                           SALARIO_ACTUAL
 LQCSAP        12     18      7   2    P   SALARIO  PROMEDIO                         SALARIO_PROMEDIO
 LQCUSA        19     19      1        A   SALARIO  A USAR                           SALARIO_A_USAR
 LQCIOI        20     20      1        A   INCLUIR OTROS INGRESOS                    INCLUIR_OTROS_INGRESOS
 LQCTOI        21     27      7   2    P   TOTAL OTROS INGRESOS                      TOTAL_OTROS_INGRESOS
 EMPAIN        28     30      3   0    P   ANO INGRESO                               ANO_INGRESO
 EMPMIN        31     32      2   0    P   MES INGRESO                               MES_INGRESO
 EMPDIN        33     34      2   0    P   DIA INGRESO                               DIA_INGRESO
 EMPASA        35     37      3   0    P   ANO DE SALIDA                             ANO_SALIDA
 EMPMSA        38     39      2   0    P   MES DE SALIDA                             MES_SALIDA
 EMPDSA        40     41      2   0    P   DIA DE SALIDA                             DIA_SALIDA
 CNOCVE        42     43      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 LQCTSA        44     44      1        A   TIPO SALIDA                               TIPO_SALIDA
 RAZCVE        45     46      2   0    P   RAZON DE SALIDA                           RAZON_SALIDA
 LQCCPR        47     47      1        A   CALCULO PREAVISO                          CALCULO_PREAVISO
 LQCCCE        48     48      1        A   CALCULO CESANTIA                          CALCULO_CESANTIA
 LQCCRE        49     49      1        A   CALCULO REGALIA                           CALCULO_REGALIA
 LQCCBO        50     50      1        A   CALCULO BONIFICACION                      CALCULO_BONIFICACION
 LQCTVA        51     51      1        A   TOMO VACACIONES                           TOMO_VACACIONES
 LQCCVA        52     53      2   0    P   CALCULO DIAS VACACIONES                   CALCULO_DIAS_VACACIONES
 LQCCPV        54     55      2   0    P   CALCULO PREMIO VACACIONES                 CALCULO_PREMIO_VACACIONES
 LQCCDT        56     58      3   2    P   CALCULO DIAS TRABAJADOS                   CALCULO_DIAS_TRABAJADOS
 LQCDIN        59     59      1        A   DESCUENTO INFOTEP                         DESCUENTO_INFOTEP
 LQCDIS        60     60      1        A   DESCUENTO ISR                             DESCUENTO_ISR
 LQCTIN        61     67      7   2    P   TOTAL INGRESO                             TOTAL_INGRESO
 LQCTIG        68     74      7   2    P   TOTAL INGRESO GRABABLE                    TOTAL_INGRESO_GRAVABLE
 LQCTEG        75     81      7   2    P   TOTAL EGRESO                              TOTAL_ENGRESO
 LQCPRO        82     84      3   4    P   CALCULO PROPORCION ANUAL                  CALCULO_PROPORCION_ANUAL
 LQCAT1        85     86      2   0    P   ANOS DE TRABAJO LEY/92                    ANOS_TRABAJO_LEY_92
 LQCMT1        87     88      2   0    P   MESES TRABAJO LEY/92                      MESES_TRABAJO_LEY_92
 LQCDT1        89     90      2   0    P   DIAS TRABAJO LEY/92                       DIAS_TRABAJO_LEY_92
 LQCAT2        91     92      2   0    P   ANOS DE TRABAJO                           ANOS_TRABAJO
 LQCMT2        93     94      2   0    P   MESES TRABAJO                             MESES_TRABAJO
 LQCDT2        95     96      2   0    P   DIAS TRABAJO                              DIAS_TRABAJO_
 LQCAT3        97     98      2   0    P   ANOS DE TRABAJO TOTAL                     ANOS_TRABAJO_TOTAL
 LQCMT3        99    100      2   0    P   MESES TRABAJO TOTAL                       MESES_TRABAJO_TOTAL
 LQCDT3       101    102      2   0    P   DIAS TRABAJO TOTAL                        DIAS_TRABAJO_TOTAL
 LQCSTS       103    103      1        A   STATUS LIQUIDACION                        STATUS_LIQUIDACION
 USRCRE       104    113     10        A   USUARIO QUE CREO                          USUARIO_QUE_CREO
 WSICRE       114    123     10        A   TERMINAL DONDE SE CREO                    TERMINAL_DONDE_SE_CREO
 FECCRE       124    128      5   0    P   FECHA QUE SE CREO                         FECHA_QUE_SE_CREO
 HORCRE       129    132      4   0    P   HORA QUE SE CREO                          HORA_QUE_SE_CREO
 APLUSR       133    142     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       143    152     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR       153    156      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO
 APLDIA       157    158      2   0    P   DIA QUE SE APLICO                         DIA_QUE_SE_APLICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de liquidación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomLqd | — | Detalle de liquidación |
| — | NomEmp | — | Empleado liquidado |
| — | NomRaz | — | Razón de salida |

---

## Observaciones

- Cabecera del proceso de liquidación de empleados; su detalle es `NomLqd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
