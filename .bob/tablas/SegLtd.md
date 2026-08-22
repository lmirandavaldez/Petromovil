# SegLtd — Leyenda Tipo de Diario

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de leyendas por tipo de diario contable. Define los textos descriptivos asociados a cada tipo de asiento o diario.

---

## Campos

-----------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 LTDCVE         1      1      1   0    P   CLAVE                                     CLAVE_LELLENGA_TIPO_DIARIO
 LTDDES         2     21     20        A   DESCRIPCION                               DESC_LELLENGA_TIPO_DIARIO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — tipo de diario |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegLdm | — | Leyenda documentos y movimientos |

---

## Observaciones

- Define los textos de leyenda asociados a cada tipo de diario contable.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
