# CogPar — Parámetros de Relación

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Parámetros generales del módulo de contabilidad. Almacena la configuración y parámetros operativos del módulo COG por compañía.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PARCVE         1      2      2        A   CLAVE DEL PARAMETRO                       CLAVE_ARCHIVO_DE_PARAMETRO
 PARDES         3     22     20        A   DESCRIPCION                               DESCRIPCION_DEL_PARAMETRO
 TDICVE        23     24      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — compañía |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCia | — | Compañía |

---

## Observaciones

- Tabla de configuración central del módulo COG por compañía.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
