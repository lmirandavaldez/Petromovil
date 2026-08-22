# CogRecd — Detalles Entradas Recurrentes (Histórico)

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalles históricos de entradas recurrentes ejecutadas. Almacena el detalle de las líneas de los asientos recurrentes que ya fueron generados y contabilizados.

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

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera histórica + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogRech | — | Cabecera histórica entradas recurrentes |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Historial de detalles de asientos recurrentes ejecutados; su cabecera es `CogRech`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
