# CogDged — Detalles Diario de Transacciones

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalles del diario de transacciones contables. Contiene cada línea (débito o crédito) de los asientos contables registrados en el sistema.

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
 DGESEC        12     14      3   0    P   SECUENCIA                                 SECUENCIA
 CTACVE        15     32     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        33     34      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        35     38      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        39     48     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 DGEDE1        49     88     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOVIMIENTO
 DGEVAL        89     96      8   2    P   VALOR DEL MOVIMIENTO                      VALOR_DEL_MOVIMIENTO
 DGEORI        97     97      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_DEL_MOVIMIENTO
 DGERE1        98    107     10        A   REFERENCIA 1                              REFERENCIA_1
 DGERE2       108    117     10        A   REFERENCIA 2                              REFERENCIA_2
 DGEDMO       118    119      2   0    P   DIA DEL MOVIMIENTO                        DIA_DEL_MOVIMIENTO
 DGEMMO       120    121      2   0    P   MES DEL MOVIMIENTO                        MES_DEL_MOVIMIENTO
 DGEAMO       122    124      3   0    P   A#O DEL MOVIMIENTO                        ANO_DEL_MOVIMIENTO
 DGEDTO       125    126      2   0    P   DIA DE VENCIMIENTO                        DIA_DE_VENCIMIENTO
 DGEMTO       127    128      2   0    P   MES DE VENCIMIENTO                        MES_DE_VENCIMIENTO
 DGEATO       129    131      3   0    P   A#O DE VENCIMIENTO                        ANO_DE_VENCIMIENTO
 MONCVE       132    133      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 SECTAS       134    139      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO
 CFACVE       140    142      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 TSECVE       143    145      3   0    P   CODIGO TIPO SERVICIO                      CODIGO_TIPO_SERVICIO_TSE
 DGETID       146    146      1        A   TIPO DE IDENTIFICACION                    TIPO_IDENTIFICACION_DGE
 DGEIDE       147    161     15        A   REGISTRO FISCAL                           REGISTRO_FISCAL_DGE
 NCFNRO       162    180     19        A   NUMERO DEL NCF                            NUMERO_DE_COMPROBANTE_FISCAL
 DGEVID       181    187      7   2    P   VALOR IMPUESTO DETALLE                    VALOR_IMPUESTO_DGED
 DGEVIR       188    194      7   2    P   VALOR IMPUESTO RETENIDO DETA              VALOR_IMPUESTO_RETENIDO_DGED
 DGEVOI       195    201      7   2    P   VALOR OTRO IMPUESTO                       VALOR_OTRO_IMPUESTO_DGED
 DGEVOR       202    208      7   2    P   VALOR OTRO IMPUESTO RETENIDO              VALOR_OTRO_IMPUESTO_RET_DGED
 DGEMFS       209    215      7   2    P   MONTO FACTURADO SERVICIOS                 MONTO_FACTURADO_SERVICIOS
 DGEMFB       216    222      7   2    P   MONTO FACTURADO BIENES                    MONTO_FACTURADO_BIENES
 DGEIFS       223    229      7   2    P   IMPUESTO FACTURADO SERVICIOS              IMPUESTO_FACTURADO_SERVICIOS
 DGEIFB       230    236      7   2    P   IMPUESTO FACTURADO BIENES                 IMPUESTO_FACTURADO_BIENES
 DGEMIC       237    243      7   2    P   MONTO IMPUESTO COSTO                      MONTO_IMPUESTO_COSTO
 DGEMIP       244    250      7   2    P   MONTO IMPUESTO PROPORCIONALIDAD           MONTO_IMPUESTO_PROPORCION
 DGEMIS       251    257      7   2    P   MONTO IMPUESTO SELECTIVO                  MONTO_IMPUESTO_SELECTIVO
 DGEMIO       258    264      7   2    P   MONTO OTROS IMPUESTO                      MONTO_OTROS_IMPUESTOS
 DGEMPL       265    271      7   2    P   MONTO PROPINA LEGAL                       MONTO_PROPINA_LEGAL
 DGEERR       272    273      2   0    P   CODIGO DE ERROR                           CODIGO_DE_ERROR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogDgeh | — | Cabecera del diario |
| — | CogCta | — | Cuenta contable |
| — | CogCco | — | Centro de costos |

---

## Observaciones

- Detalle de asientos contables; su cabecera es `CogDgeh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
