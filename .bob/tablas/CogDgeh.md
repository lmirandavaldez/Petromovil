# CogDgeh — Cabecera Diario de Transacciones

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera del diario de transacciones contables. Registra los datos de encabezado de cada asiento contable: tipo de diario, fecha, descripción y estado.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 PERANO         3      5      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM         6      7      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 DGEDOC         8     11      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO
 DGEDIA        12     13      2   0    P   DIA TRANSACCION                           DIA_DE_LA_TRANSACCION
 DGEMES        14     15      2   0    P   MES TRANSACCION                           MES_DE_LA_TRANSACCION
 DGEANO        16     18      3   0    P   ANO TRANSACCION                           ANO_DE_LA_TRANSACCION
 DGEDES        19     58     40        A   DESCRIPCION                               DESCRIPCION_DE_LA_TRANSACCION
 DGEDR1        59     68     10        A   DOCUMENTO DE REFERENCIA 1                 DOCUMENTO_REFERENCIA_1
 DGEDR2        69     78     10        A   DOCUMENTO DE REFERENCIA 2                 DOCUMENTO_REFERENCIA_2
 DGEDEB        79     87      9   2    P   TOTAL DEBITO                              TOTAL_DEBITO
 DGECRE        88     96      9   2    P   TOTAL CREDITO                             TOTAL_CREDITO
 CONCVE        97     99      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOVIMIENT
 SITCVE       100    100      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION
 DGEBAN       101    103      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO_DGEH
 DCDCVE       104    106      3   0    P   CODIGO DISTRIBUCION CONTABLE              CODIGO_DISTRIBUCION_CONTABLE
 DGEVTR       107    114      8   2    P   VALOR TRANSACCION                         VALOR_TRANSACCION
 USRCVE       115    124     10        A   ID DE USUARIO                             ID_DEL_USUARIO
 DGETVI       125    133      9   2    P   TOTAL IMPUESTO                            TOTAL_IMPUESTO_DGEH
 DGETIR       134    142      9   2    P   TOTAL IMPUESTO RETENIDO                   TOTAL_IMPUESTO_RETENIDO_DGEH
 DGETOI       143    151      9   2    P   TOTAL OTRO IMPUESTO                       TOTAL_OTRO_IMPUESTO_DGEH
 DGETOR       152    160      9   2    P   TOTAL OTRO IMPUESTO RETENIDO              TOTAL_OTRO_IMPUESTO_RET_DGEH
 DGETFS       161    169      9   2    P   TOTAL MONTO SERVICIOS                     TOTAL_MONTO_SERVICIOS
 DGETFB       170    178      9   2    P   TOTAL MONTO BIENES                        TOTAL_MONTO_BIENES
 DGETIS       179    187      9   2    P   TOTAL IMPUESTO SERVICIOS                  TOTAL_IMPUESTO_SERVICIOS
 DGETIB       188    196      9   2    P   TOTAL IMPUESTO BIENES                     TOTAL_IMPUESTO_BIENES
 DGETIC       197    205      9   2    P   TOTAL MONTO IMPUESTO COSTO                TOTAL_IMPUESTO_COSTO
 DGETIP       206    214      9   2    P   TOTAL IMPUESTO PROPORCIONALIDAD           TOTAL_IMPUESTO_PROPORCION
 DGETIE       215    223      9   2    P   TOTAL MONTO IMPUESTO SELECTIVO            TOTAL_IMPUESTO_SELECTIVO
 DGETIO       224    232      9   2    P   TOTAL OTROS IMPUESTO                      TOTAL_OTROS_IMPUESTOS
 DGETPL       233    241      9   2    P   TOTAL PROPINA LEGAL                       TOTAL_PROPINA_LEGAL


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de asiento |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogDged | — | Detalles del asiento |
| — | CogTdi | — | Tipo de diario |
| — | CogPer | — | Período contable |

---

## Observaciones

- Cabecera principal de asientos contables; su detalle es `CogDged`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
