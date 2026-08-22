# SegDms — Tabla de Distrito Municipal o Sectores

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de distritos municipales y sectores geográficos. Utilizado para clasificación territorial de registros del sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PRVCVE         1      2      2   0    P   CODIGO DE PROVINCIA                       CODIGO_DE_PROVINCIA
 MUNCVE         3      4      2   0    P   CODIGO DEL MUNICIPIO                      CODIGO_DEL_MUNICIPIO
 DMSCVE         5      6      2   0    P   CODIGO DEL DISTRITO MUNICIPAL             CODIGO_DEL_DISTRITO_MUNICIPAL
 DMSCPO         7     10      4   0    P   CODIGO POSTAL DM                          CODIGO_POSTAL_DM
 DMSSEC        11     12      2   0    P   SECUENCIA  DISTRITO MUNICIPAL             SECUENCIA_DISTRITO_MUNICIPAL
 DMSDES        13     52     40        A   DESCRIPCION DEL DISTRITO MUNICIPAL        DESCRIPCION_DISTRITO_MUNICIPA
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de distrito/sector |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegMun | — | Municipio al que pertenece |

---

## Observaciones

- Catálogo geográfico de distritos y sectores para clasificación territorial.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
