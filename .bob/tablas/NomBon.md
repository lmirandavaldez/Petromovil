# NomBon — Corte de Bonificación

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Control del corte de bonificación anual. Registra los parámetros y el estado del proceso de cálculo y pago de la bonificación anual (regalía pascual).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BONANO         1      3      3   0    P   ANO PERTENECE BONOS                       ANO_PERTENECE_BONOS
 CNOCVE         4      5      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 EMPCVE         6      9      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 BONSAL        10     16      7   2    P   SALARIO MENSUAL CORTE                     SALARIO_MENSUAL_CORTE
 BONSAC        17     23      7   2    P   SALARIO ACUMULADO DEL ANO                 SALARIO_ACUMULADO_DEL_ANO
 BONSPA        24     30      7   2    P   SALARIO ACUMULADO PROMEDIO                SALARIO_ACUMULADO_PROMEDIO
 BONSDI        31     37      7   2    P   SALARIO DIARIO CORTE                      SALARIO_DIARIO_CORTE
 BONBPA        38     44      7   2    P   BONO PAGADO ANO ANTERIOR                  BONO_PAGADO_ANO_ANTERIOR
 EMPFIE        45     54     10   0    L   FECHA INGRESO EMPRESA                     FECHA_INGRESO_EMPRESA_ISO
 BONFDC        55     64     10   0    L   FECHA DESDE CORTE                         FECHA_DESDE_CORTE
 BONFHC        65     74     10   0    L   FECHA HASTA CORTE                         FECHA_HASTA_CORTE
 BONCAN        75     76      2   0    P   CANTIDAD ANOS EN LA EMPRESA               ANOS_EN_LA_EMPRESA
 BONCME        77     78      2   0    P   CANTIDAD MESES EN LA EMPRESA              MESES_EN_LA_EMPRESA
 BONCDI        79     80      2   0    P   CANTIDAD DIAS EN LA EMPRESA               DIAS_EN_LA_EMPRESA
 BONLEY        81     87      7   2    P   VALOR BONIFICACION SEGUN LEY              VALOR_BONIFICACION_SEGUN_LEY
 BONVAL        88     94      7   2    P   VALOR DE LA BONIFICACION                  VALOR_BONIFICACION
 BONPOR        95    103      9   3    P   PORCIENTO PRORRATEO BONO                  PORCIENTO_PRORRATEO_BONO
 APLUSR       104    113     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       114    123     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLTST       124    149     26   0    Z   FECHA QUE SE APLICO                       FECHA_QUE_SE_APLICO_TST

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — período de bonificación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomBoe | — | Empleados excluidos |
| — | NomMpb | — | Monto prorrateo bonificación |

---

## Observaciones

- Control del proceso de bonificación anual (regalía pascual en República Dominicana).
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
