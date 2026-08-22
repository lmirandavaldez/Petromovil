# SegMun — Tabla de Municipios

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de municipios. Define la división político-administrativa municipal utilizada para clasificación geográfica de registros.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PRVCVE         1      2      2   0    P   CODIGO DE PROVINCIA                       CODIGO_DE_PROVINCIA
 MUNCVE         3      4      2   0    P   CODIGO DEL MUNICIPIO                      CODIGO_DEL_MUNICIPIO
 MUNDES         5     39     35        A   DESCRIPCION DEL MUNICIPIO                 DESCRIPCION_DEL_MUNICIPIO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de municipio |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegDms | — | Distritos / sectores del municipio |

---

## Observaciones

- Catálogo geográfico de municipios; ver también `SegDms` para sectores dentro del municipio.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
