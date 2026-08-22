# SegTig — Tipo de Ingresos

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de tipos de ingresos. Define las categorías de ingresos utilizadas en la clasificación de transacciones financieras del sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TIGCVE         1      2      2   0    P   TIPO DE RETENCION                         TIPO_DE_INGRESOS
 TIGDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_TIPO_INGRESO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de tipo de ingreso |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegImp | — | Impuestos asociados al tipo de ingreso |

---

## Observaciones

- Clasifica los ingresos por categoría para propósitos fiscales y contables.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
