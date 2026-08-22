# SegTre — Tipo de Retención

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de tipos de retención fiscal. Define las categorías de retenciones aplicables (ISR, ITBIS retenido, etc.) con sus porcentajes y parámetros.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TRECVE         1      2      2   0    P   TIPO DE RETENCION                         TIPO_DE_RETENCION
 TREDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_TIPO_RETENCION
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de tipo de retención |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegImp | — | Impuesto asociado a la retención |

---

## Observaciones

- Define los tipos de retención aplicables según normativa fiscal vigente.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
