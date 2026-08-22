# CogRech — Cabecera Entradas Recurrentes (Histórico)

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera histórica de entradas recurrentes ejecutadas. Registra los encabezados de los asientos recurrentes que ya fueron generados y contabilizados en períodos anteriores.

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
 DGEDEB        59     67      9   2    P   TOTAL DEBITO                              TOTAL_DEBITO
 DGECRE        68     76      9   2    P   TOTAL CREDITO                             TOTAL_CREDITO
 CONCVE        77     79      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOVIMIENT
 SITCVE        80     80      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de ejecución |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogRecd | — | Detalles históricos |
| — | CogEreh | — | Plantilla de entrada recurrente |

---

## Observaciones

- Historial de cabeceras de asientos recurrentes ejecutados; su detalle es `CogRecd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
