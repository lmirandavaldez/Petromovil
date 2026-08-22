# CogPcn — Tabla de Nuevo Período Contable

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Control del proceso de apertura de nuevo período contable. Registra los parámetros y estado del proceso de apertura de un nuevo período en el sistema contable.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PERANO         1      3      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM         4      5      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 PERDIN         6      7      2   0    P   DIA INICIAL DEL PERIODO                   DIA_INICIO_PERIODO_CONTABLE
 PERMIN         8      9      2   0    P   MES INICIAL DEL PERIODO                   MES_INICIO_PERIODO_CONTABLE
 PERAIN        10     12      3   0    P   ANO INICIAL DEL PERIODO                   ANO_INICIO_PERIODO_CONTABLE
 PERDFI        13     14      2   0    P   DIA FINAL DEL PERIODO                     DIA_FINAL_PERIODO_CONTABLE
 PERMFI        15     16      2   0    P   MES FINAL DEL PERIODO                     MES_FINAL_PERIODO_CONTABLE
 PERAFI        17     19      3   0    P   ANO FINAL DEL PERIODO                     ANO_FINAL_PERIODO_CONTABLE
 PERDES        20     34     15        A   DESCRIPCION                               DESCRIPCION_PERIODO_CONTABLE
 PERSIT        35     35      1        A   SITUACION                                 STATUS_PERIODO_CONTABLE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — compañía + período nuevo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPer | — | Período contable |
| — | SegCia | — | Compañía |

---

## Observaciones

- Controla el proceso de apertura de nuevos períodos contables.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
