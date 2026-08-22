# CogSecd — Detalle Solicitud Emisión Cheques

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalle de las solicitudes de emisión de cheques. Contiene el desglose de cada solicitud: cuentas a debitar, montos, retenciones y documentos de respaldo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SECCVE         1      4      4   0    P   NUMERO SOLICITUD DE CHEQUE                NUMERO_DE_SOLICITUD_CHEQUE
 SECSEC         5      6      2   0    P   SECUENCIA                                 SECUENCIA_DEL_REGISTRO_SOLICI
 CTACVE         7     24     18        A   CUENTA CONTABLE                           NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        25     26      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        27     30      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        31     40     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 SECDES        41     80     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOV_DE_SOLICI
 SECVAL        81     86      6   2    P   VALOR DEL MOVIMIENTO                      VALOR_DEL_MOVIMIENTO_SOLICITU
 SECORI        87     87      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_CONT_DEBITO_CREDITO
 SECVID        88     94      7   2    P   VALOR IMPUESTO DETALLE                    VALOR_IMPUESTO_SECD
 SECVIR        95    101      7   2    P   VALOR IMPUESTO RETENIDO DETA              VALOR_IMPUESTO_RETENIDO_SECD
 SECVOI       102    108      7   2    P   VALOR OTRO IMPUESTO                       VALOR_OTRO_IMPUESTO_SECD
 SECVOR       109    115      7   2    P   VALOR OTRO IMPUESTO RETENIDO              VALOR_OTRO_IMPUESTO_RET_SECD
 SECMFS       116    122      7   2    P   MONTO FACTURADO SERVICIOS                 MONTO_FACT_SERVICIOS_SECD
 SECMFB       123    129      7   2    P   MONTO FACTURADO BIENES                    MONTO_FACTURADO_BIENES_SECD
 SECIFS       130    136      7   2    P   IMPUESTO FACTURADO SERVICIOS              IMPUESTO_FACT_SERVICIOS_SECD
 SECIFB       137    143      7   2    P   IMPUESTO FACTURADO BIENES                 IMPUESTO_FACT_BIENES_SECD
 SECMIC       144    150      7   2    P   MONTO IMPUESTO COSTO                      MONTO_IMPUESTO_COSTO_SECD
 SECMIP       151    157      7   2    P   MONTO IMPUESTO PROPORCIONALIDAD           MONTO_IMP_PROPORCION_SECD
 SECMIS       158    164      7   2    P   MONTO IMPUESTO SELECTIVO                  MONTO_IMPUESTO_SELECTIVO_SECD
 SECMIO       165    171      7   2    P   MONTO OTROS IMPUESTO                      MONTO_OTROS_IMPUESTOS_SECD
 SECMPL       172    178      7   2    P   MONTO PROPINA LEGAL                       MONTO_PROPINA_LEGAL_SECD
 CFACVE       179    181      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 TSECVE       182    184      3   0    P   CODIGO TIPO SERVICIO                      CODIGO_TIPO_SERVICIO_TSE
 DGETID       185    185      1        A   TIPO DE IDENTIFICACION                    TIPO_IDENTIFICACION_DGE
 DGEIDE       186    200     15        A   REGISTRO FISCAL                           REGISTRO_FISCAL_DGE
 NCFNRO       201    219     19        A   NUMERO DEL NCF                            NUMERO_DE_COMPROBANTE_FISCAL

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogSech | — | Cabecera solicitud de emisión |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Detalle de solicitudes de cheque; su cabecera es `CogSech`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
