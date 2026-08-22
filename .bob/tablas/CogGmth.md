# CogGmth — Cabecera Gastos Menores Temporal

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera temporal de gastos menores (caja chica). Tabla de trabajo para el ingreso y edición del encabezado de una liquidación de caja chica en proceso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 GMENRO         1      6      6   0    P   NUMERO GASTOS MENOR TEMPORAL              NUMERO_GASTO_MENOR_TEMPORAL
 GMEFDO         7     11      5   0    P   FECHA DEL DOCUMENTO GASTOS MENOR          FECHA_DOCUMENTO_GASTO_MENOR
 GMEFTR        12     16      5   0    P   FECHA DE LA TRANSACCION GASTOS MENOR      FECHA_TRANSACCION_GASTO_MENOR
 CONCVE        17     19      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOVIMIENT
 GMEDES        20     59     40        A   DESCRIPCION                               DESCRIPCION_DEL_GASTO_MENOR
 PERANO        60     62      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        63     64      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 GMETAS        65     70      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO_GASTO_MENOR
 GMEVAL        71     77      7   2    P   VALOR                                     VALOR_DEL_GASTO_MENOR
 GMEVML        78     84      7   2    P   VALOR MONEDA LOCAL                        VALOR_TRANSACCIO_MONEDA_LOCAL
 GMEDEB        85     91      7   2    P   TOTAL DEBITO GASTOS MENOR                 TOTAL_DEBITO_GASTO_MENOR
 GMECRE        92     98      7   2    P   TOTAL CREDITO GASTOS MENOR                TOTAL_CREDITO_GASTO_MENOR
 GMEDIF        99    105      7   2    P   TOTAL DIFERENCIA GASTOS MENOR             TOTAL_DIFERENCIA_GASTO_MENOR
 SITCVE       106    106      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION
 GMEREF       107    116     10        A   NUMERO DE REFERENCIA                      NUMERO_DE_REFERENCIA_GME
 GMEPIM       117    117      1        A   GRABADA DE IMPUESTOS                      GRABADA_DE_IMPUESTOS_GME
 CFACVE       118    120      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 TSECVE       121    123      3   0    P   CODIGO TIPO SERVICIO                      CODIGO_TIPO_SERVICIO_TSE
 GMEVBR       124    130      7   2    P   VALOR BRUTO                               VALOR_BRUTO_DOCUMENTO_GME
 GMEMDC       131    137      7   2    P   MONTO DESCUENTO DE FACTURA                MONTO_DESCUENTO_GASTO_MENOR
 GMEIM1       138    144      7   2    P   MONTO IMPUESTOS 1                         MONTO_IMPUESTOS_1_GME
 GMEIM2       145    151      7   2    P   MONTO IMPUESTOS 2                         MONTO_IMPUESTOS_2_GME
 GMEIM3       152    158      7   2    P   MONTO IMPUESTO TOTAL FACTURA              MONTO_TOTAL_IMPUESTO_GME
 GMEMIF       159    165      7   2    P   MONTO IMPUESTO FACTURA                    MONTO_IMPUESTO_GASTO_MENOR
 GMEMFS       166    172      7   2    P   MONTO FACTURADO SERVICIOS                 MONTO_FACTURADO_SERVICIOS_GME
 GMEMFB       173    179      7   2    P   MONTO FACTURADO BIENES                    MONTO_FACTURADO_BIENES_GME
 GMEIFS       180    186      7   2    P   IMPUESTO FACTURADO SERVICIOS              IMP_FACTURADO_SERVICIOS_GME
 GMEIFB       187    193      7   2    P   IMPUESTO FACTURADO BIENES                 IMPUESTO_FACTURADO_BIENES_GME
 GMEMIC       194    200      7   2    P   MONTO IMPUESTO COSTO                      MONTO_IMPUESTO_COSTO_GME
 GMEMIP       201    207      7   2    P   MONTO IMPUESTO PROPORCIONALIDAD           MONTO_IMPUESTO_PROPORCION_GME
 GMEMIS       208    214      7   2    P   MONTO IMPUESTO SELECTIVO                  MONTO_IMPUESTO_SELECTIVO_GME
 GMEMIO       215    221      7   2    P   MONTO OTROS IMPUESTO                      MONTO_OTROS_IMPUESTOS_GME
 GMEMPL       222    228      7   2    P   MONTO PROPINA LEGAL                       MONTO_PROPINA_LEGAL_GME


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de liquidación temporal |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogGmtd | — | Detalles gastos menores temporal |
| — | CogGmhh | — | Cabecera gastos menores histórico |

---

## Observaciones

- Tabla temporal de cabecera; al confirmar pasa a `CogGmhh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
