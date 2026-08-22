# CogGmhh — Cabecera Gastos Menores Histórico

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera histórica de gastos menores (caja chica). Registra los datos generales de cada liquidación de caja chica confirmada y procesada contablemente.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 GMETDC         1      3      3        A   TIPO DE DOCUMENTO                         TIPO_DOCUMENTO_GME
 GMENUM         4      9      6   0    P   NUMERO GATOS MENOR DEFINITIVO             NUMERO_GASTO_MENOR_DEFINITIVO
 GMENRO        10     15      6   0    P   NUMERO GASTO MENOR TEMPORAL               NUMERO_GASTO_MENOR_TEMPORAL
 GMEFDO        16     20      5   0    P   FECHA DEL DOCUMENTO GASTO MENOR           FECHA_DOCUMENTO_GASTO_MENOR
 GMEFTR        21     25      5   0    P   FECHA DE LA TRANSACCION GASTO MENOR       FECHA_TRANSACCION_GASTO_MENOR
 CONCVE        26     28      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOVIMIENT
 GMEDES        29     68     40        A   DESCRIPCION                               DESCRIPCION_DEL_GASTO_MENOR
 PERANO        69     71      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        72     73      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 GMETAS        74     79      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO_GASTO_MENOR
 GMEVAL        80     86      7   2    P   VALOR                                     VALOR_DEL_GASTO_MENOR
 GMEVML        87     93      7   2    P   VALOR MONEDA LOCAL                        VALOR_TRANSACCIO_MONEDA_LOCAL
 GMEDEB        94    100      7   2    P   TOTAL DEBITO                              TOTAL_DEBITO_GASTO_MENOR
 GMECRE       101    107      7   2    P   TOTAL CREDITO                             TOTAL_CREDITO_GASTO_MENOR
 GMEDIF       108    114      7   2    P   TOTAL DIFERENCIA                          TOTAL_DIFERENCIA_GASTO_MENOR
 SITCVE       115    115      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION
 TDICVE       116    117      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 DGEDOC       118    121      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO
 DGINGM       122    127      6   0    P   NUMERO DOCUMENTO DEFINITIVO GASTO MENOR   NUMERO_DOC_DEFINITIVO_GM
 GMEREF       128    137     10        A   NUMERO DE REFERENCIA                      NUMERO_DE_REFERENCIA_GME
 GMENID       138    152     15        A   NUMERO DE IDENTIFICACION                  NUMERO_DE_IDENTIFICACION_GME
 NCFNRO       153    171     19        A   NUMERO DEL COMPROBANTE                    NUMERO_DE_COMPROBANTE_FISCAL
 GMEPIM       172    172      1        A   GRABADA DE IMPUESTOS                      GRABADA_DE_IMPUESTOS_GME
 CFACVE       173    175      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 TSECVE       176    178      3   0    P   CODIGO TIPO SERVICIO                      CODIGO_TIPO_SERVICIO_TSE
 GMEVBR       179    185      7   2    P   VALOR BRUTO                               VALOR_BRUTO_DOCUMENTO_GME
 GMEMDC       186    192      7   2    P   MONTO DESCUENTO DE FACTURA                MONTO_DESCUENTO_GASTO_MENOR
 GMEIM1       193    199      7   2    P   MONTO IMPUESTOS 1                         MONTO_IMPUESTOS_1_GME
 GMEIM2       200    206      7   2    P   MONTO IMPUESTOS 2                         MONTO_IMPUESTOS_2_GME
 GMEIM3       207    213      7   2    P   MONTO IMPUESTO TOTAL FACTURA              MONTO_TOTAL_IMPUESTO_GME
 GMEMIF       214    220      7   2    P   MONTO IMPUESTO FACTURA                    MONTO_IMPUESTO_GASTO_MENOR
 GMEMFS       221    227      7   2    P   MONTO FACTURADO SERVICIOS                 MONTO_FACTURADO_SERVICIOS_GME
 GMEMFB       228    234      7   2    P   MONTO FACTURADO BIENES                    MONTO_FACTURADO_BIENES_GME
 GMEIFS       235    241      7   2    P   IMPUESTO FACTURADO SERVICIOS              IMP_FACTURADO_SERVICIOS_GME
 GMEIFB       242    248      7   2    P   IMPUESTO FACTURADO BIENES                 IMPUESTO_FACTURADO_BIENES_GME
 GMEMIC       249    255      7   2    P   MONTO IMPUESTO COSTO                      MONTO_IMPUESTO_COSTO_GME
 GMEMIP       256    262      7   2    P   MONTO IMPUESTO PROPORCIONALIDAD           MONTO_IMPUESTO_PROPORCION_GME
 GMEMIS       263    269      7   2    P   MONTO IMPUESTO SELECTIVO                  MONTO_IMPUESTO_SELECTIVO_GME
 GMEMIO       270    276      7   2    P   MONTO OTROS IMPUESTO                      MONTO_OTROS_IMPUESTOS_GME
 GMEMPL       277    283      7   2    P   MONTO PROPINA LEGAL                       MONTO_PROPINA_LEGAL_GME
 APLTST       284    309     26   0    Z   FECHA QUE SE APLICO                       FECHA_QUE_SE_APLICO
 APLUSR       310    319     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       320    329     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de liquidación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogGmhd | — | Detalles gastos menores histórico |
| — | CogDgeh | — | Asiento contable generado |

---

## Observaciones

- Cabecera del histórico de caja chica; su detalle es `CogGmhd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
