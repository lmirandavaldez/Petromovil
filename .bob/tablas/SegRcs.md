# SegRcs — Relación Comprobantes Series

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Relación entre comprobantes fiscales y sus series. Administra las series numéricas asignadas a cada tipo de comprobante fiscal por compañía.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 NCFSER         1      1      1        A   SERIE DEL COMPROBANTES                    SERIE_RELACIONADA
 RCSTCO         2      3      2   0    S   TIPO COMPROBANTE ORIGEN                   TIPO_COMPROBANTE_ORIGEN
 RCSTCD         4      5      2   0    S   TIPO COMPROBANTE DESTINO                  TIPO_COMPROBANTE_DESTINO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta comprobante + serie |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegTcf | — | Tipo de comprobante fiscal |
| — | SegCia | — | Compañía |

---

## Observaciones

- Administra las series numéricas (secuencias) de cada tipo de comprobante fiscal.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
