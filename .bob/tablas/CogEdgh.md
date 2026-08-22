# CogEdgh — Cabecera Diario de Transacciones Eliminados

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de asientos contables eliminados. Registra los datos de encabezado de los asientos que han sido anulados, para trazabilidad y auditoría.

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
 DGETVI       115    123      9   2    P   TOTAL IMPUESTO                            TOTAL_IMPUESTO_DGEH
 DGETIR       124    132      9   2    P   TOTAL IMPUESTO RETENIDO                   TOTAL_IMPUESTO_RETENIDO_DGEH
 DGETOI       133    141      9   2    P   TOTAL OTRO IMPUESTO                       TOTAL_OTRO_IMPUESTO_DGEH
 DGETOR       142    150      9   2    P   TOTAL OTRO IMPUESTO RETENIDO              TOTAL_OTRO_IMPUESTO_RET_DGEH
 DGETFS       151    159      9   2    P   TOTAL MONTO SERVICIOS                     TOTAL_MONTO_SERVICIOS
 DGETFB       160    168      9   2    P   TOTAL MONTO BIENES                        TOTAL_MONTO_BIENES
 DGETIS       169    177      9   2    P   TOTAL IMPUESTO SERVICIOS                  TOTAL_IMPUESTO_SERVICIOS
 DGETIB       178    186      9   2    P   TOTAL IMPUESTO BIENES                     TOTAL_IMPUESTO_BIENES
 DGETIC       187    195      9   2    P   TOTAL MONTO IMPUESTO COSTO                TOTAL_IMPUESTO_COSTO
 DGETIP       196    204      9   2    P   TOTAL IMPUESTO PROPORCIONALIDAD           TOTAL_IMPUESTO_PROPORCION
 DGETIE       205    213      9   2    P   TOTAL MONTO IMPUESTO SELECTIVO            TOTAL_IMPUESTO_SELECTIVO
 DGETIO       214    222      9   2    P   TOTAL OTROS IMPUESTO                      TOTAL_OTROS_IMPUESTOS
 DGETPL       223    231      9   2    P   TOTAL PROPINA LEGAL                       TOTAL_PROPINA_LEGAL
 USRCVE       232    241     10        A   ID DE USUARIO                             ID_DEL_USUARIO
 APLUSR       242    251     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       252    261     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR       262    265      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO
 APLFEC       266    270      5   0    P   FECHA QUE APLICO AMD                      FECHA_QUE_APLICO_AMD


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de asiento eliminado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEdgd | — | Detalles del asiento eliminado |
| — | CogTdi | — | Tipo de diario |

---

## Observaciones

- Cabecera de registro de auditoría de asientos eliminados; su detalle es `CogEdgd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
