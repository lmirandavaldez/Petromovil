# CogPrg — Grupos de Presupuestos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Grupos de presupuestos contables. Define las secciones o categorías en que se organiza el presupuesto para facilitar el análisis y comparación presupuesto vs. real.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PERANO         1      3      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PRECVE         4      5      2   0    P   NRO. DE PRESUPUESTO                       NUMERO_DEL_PRESUPUESTO
 PRGCVE         6      7      2   0    P   GRUPO DE PRESUPUESTO                      GRUPO_DEL_PRESUPUESTO
 PRGDES         8     47     40        A   DESCRIPCION                               DESCRIPCION_GRUPO_PRESUPUESTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de grupo presupuestario |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPre | — | Título de presupuesto |

---

## Observaciones

- Agrupa las líneas del presupuesto para reportes de análisis.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
