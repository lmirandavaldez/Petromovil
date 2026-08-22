# CogGmtd — Detalles Gastos Menores Temporal

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalles temporales de gastos menores (caja chica). Tabla de trabajo para el ingreso y edición de los detalles de una liquidación de caja chica antes de su confirmación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 GMENRO         1      6      6   0    P   NUMERO GASTOS MENOR TEMPORAL              NUMERO_GASTO_MENOR_TEMPORAL
 GMESEC         7      9      3   0    P   CONSECUTIVO                               SECUENCIA_DETALLE
 CTACVE        10     27     18        A   NUMERO DE CUENTA CONTABLE                 NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        28     29      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        30     33      4   0    P   NUMERO DE AUXILIAR                        CLAVE_AUXILIAR
 CCOCVE        34     43     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 GMEVTR        44     50      7   2    P   VALOR TRANSACCION                         VALOR_TRANSACCION_DESEMBOLSO
 GMEORI        51     51      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_CONT_TRANSACCION_D_C
 CONSEC        52     54      3   0    P   SECUENCIA DETALLE CONCEPTO                SECUENCIA_DETALLE_CONCEPTO
 MOVAXV        55     55      1        A   ES AUXILIAR VARIABLE                      ES_AUXILIAR_VARIABLE
 GMEDE1        56     95     40        A   DESCRIPCION                               DESCRIPCION_TRANSACCION_GME
 GMERAU        96     96      1        A   REGISTRO AUTOMATICO                       IDENTIFICACION_REGISTRO_AUT


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogGmth | — | Cabecera gastos menores temporal |
| — | CogCon | — | Concepto |

---

## Observaciones

- Tabla temporal de trabajo; al confirmar pasa a `CogGmhd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
