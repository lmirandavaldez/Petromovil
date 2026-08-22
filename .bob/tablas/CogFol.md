# CogFol — Foliador

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Control de foliadores de documentos contables. Mantiene y controla la secuencia numérica de los distintos tipos de documentos generados por el módulo de contabilidad.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 PERANO         3      5      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM         6      7      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 FOLNUM         8     11      4   0    P   NUMERO DE FOLIO                           NUMERO_DE_FOLIO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — tipo de documento + compañía |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogFce | — | Foliadores comprobantes especiales |
| — | SegCia | — | Compañía |

---

## Observaciones

- Control central de secuencias numéricas de documentos contables.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
