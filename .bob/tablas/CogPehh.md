# CogPehh — Cabecera Pago Exterior Definitivo

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera definitiva de pagos al exterior. Registra los datos de cada pago realizado a proveedores o beneficiarios en el exterior: beneficiario, monto, moneda y retenciones aplicadas.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PGETDC         1      3      3        A   TIPO DE DOCUMENTO                         TIPO_DOCUMENTO_PGE
 PGENUM         4      9      6   0    P   NUMERO PAGO AL EXTERIOR DEFINITIVO        NRO_PAGO_EXTERIOR_DEFINITIVO
 PGENRO        10     15      6   0    P   NUMERO PAGO AL EXTERIOR TEMPORAL          NUMERO_PAGO_EXTERIOR_TEMPORAL
 PGEFDO        16     20      5   0    P   FECHA DEL DOCUMENTO PAGO AL EXTERIOR      FECHA_DOCUMENTO_PAGO_EXTERIOR
 PGEFTR        21     25      5   0    P   FECHA DE LA TRANSACCION PAGO AL EXTERIOR  FECHA_TRANSACCION_PAGO_EXTERI
 CONCVE        26     28      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_DEL_CONCEPTO
 PGEDES        29     68     40        A   DESCRIPCION                               DESCRIPCION_DEL_PAGO_EXTERIOR
 PERANO        69     71      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        72     73      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 MONCVE        74     75      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 PGETAS        76     81      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO_PAGO_EXTERIOR
 PGEVAL        82     88      7   2    P   VALOR DEL PAGO EXTERIOR                   VALOR_DEL_PAGO_EXTERIOR
 PGEMIP        89     95      7   2    P   MONTO IMPUESTO GRABADO                    MONTO_IMPUESTO_GRABADO_PGE
 PGEMND        96    102      7   2    P   MONTO NETO DEL DOCUMENTO                  MONTO_NETO_DOCUMENTO_PGE
 PGEVML       103    109      7   2    P   VALOR TRANSACCION MONEDA LOCAL            VALOR_TRANS_MONEDA_LOCAL_PGE
 PGEDEB       110    116      7   2    P   TOTAL DEBITO PAGO EXTERIOR                TOTAL_DEBITO_PAGO_INTERES
 PGECRE       117    123      7   2    P   TOTAL CREDITO PAGO EXTERIOR               TOTAL_CREDITO_PAGO_INTERES
 PGEDIF       124    130      7   2    P   TOTAL DIFERENCIA PAGO EXTERIOR            TOTAL_DIFERENCIA_PAGO_INTERES
 SITCVE       131    131      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION
 TDICVE       132    133      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 DGEDOC       134    137      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO
 DGINPE       138    143      6   0    P   NUMERO DOCUMENTO PAGO AL EXTERIOR DEFINI  NUMERO_DOC_DEFINITIVO_PE
 PGEREF       144    153     10        A   NUMERO DE REFERENCIA                      NUMERO_DE_REFERENCIA_PGE
 PGENID       154    168     15        A   NUMERO DE IDENTIFICACION                  NUMERO_DE_IDENTIFICACION_PGE
 NCFNRO       169    187     19        A   NUMERO DEL COMPROBANTE                    NUMERO_DE_COMPROBANTE_FISCAL
 CFACVE       188    190      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 CRICVE       191    192      2   0    S   CODIGO RETENCION                          CODIGO_RETENCION
 APLTST       193    218     26   0    Z   FECHA QUE SE APLICO                       FECHA_QUE_SE_APLICO
 APLUSR       219    228     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       229    238     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de pago exterior |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPehd | — | Detalles del pago |
| — | CogCrp | — | Control de reversales |
| — | CogBan | — | Banco emisor |

---

## Observaciones

- Cabecera de pagos al exterior; su detalle es `CogPehd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
