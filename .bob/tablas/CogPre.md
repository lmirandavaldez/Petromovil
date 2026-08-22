# CogPre — Títulos de Presupuestos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de títulos de presupuestos contables. Define los presupuestos disponibles en el sistema con su descripción, año fiscal y estado de vigencia.

---

## Campos
------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PRECVE         1      2      2   0    P   NRO. DE PRESUPUESTO                       NUMERO_DEL_PRESUPUESTO
 PREDES         3     42     40        A   DESCRIPCION O TITULO                      DESCRIPCION_DEL_PRESUPUESTO
 PERANO        43     45      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de presupuesto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPcth | — | Cabecera cuentas de presupuesto |
| — | CogPrg | — | Grupos de presupuesto |

---

## Observaciones

- Catálogo maestro de presupuestos contables.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
