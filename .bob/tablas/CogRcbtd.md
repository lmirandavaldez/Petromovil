# CogRcbtd — Resumen Conciliación Bancaria Temporal

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Resumen temporal de conciliación bancaria. Almacena los totales y resúmenes del proceso de conciliación en curso antes de su confirmación definitiva.

---

## Campos

-----------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 TDICVE         4      5      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 DGEDOC         6      9      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO
 DGESEC        10     12      3   0    P   SECUENCIA                                 SECUENCIA
 PERANO        13     15      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        16     17      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 DGEORI        18     18      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_DEL_MOVIMIENTO
 CBADEM        19     20      2   0    P   DIA DE EMISION                            DIA_DE_EMISION_CHEQUE
 CBAMEM        21     22      2   0    P   MES DE EMICION                            MES_DE_EMISION_CHEQUE
 CBAAEM        23     25      3   0    P   ANO DE EMICION                            ANO_DE_EMISION_CHEQUE
 CBAVDC        26     33      8   2    P   VALOR DEL DOCUMENTO                       VALOR_DE_DOCUMENTO
 CBAVPA        34     41      8   2    P   VALOR PAGADO                              VALOR_PAGADO
 CBADCA        42     43      2   0    P   DIA DE CANCELACION                        DIA_DE_LA_CANCELACION
 CBAMCA        44     45      2   0    P   MES DE CANCELACION                        MES_DE_LA_CANCELACION
 CBAACA        46     48      3   0    P   ANO DE CANCELACION                        ANO_DE_LA_CANCELACION
 CBASTA        49     49      1        A   STATU DEL MOVIMIENTO                      STATUS_DEL_DOCUMENTO
 CBASN3        50     50      1        A   APLICA LIBROS S/N                         APLICA_LIBROS_SN
 CBAGRU        51     52      2   0    P   CODIGO GRUPO RESUMEN                      CODIGO_GRUPO_RESUMEN

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — banco + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCbtd | — | Detalles temporales de conciliación |
| — | CogBan | — | Banco |

---

## Observaciones

- Resumen temporal de conciliación en proceso; al confirmar pasa a `CogRcbhd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
