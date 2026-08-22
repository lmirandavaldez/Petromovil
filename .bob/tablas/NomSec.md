# NomSec — Secciones

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Catálogo de secciones o áreas organizativas. Define las secciones dentro de cada departamento para la clasificación y distribución de costos de nómina a nivel más granular.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SECCVE         1      2      2   0    P   CODIGO DE SECCION                         CODIGO_SECCION
 SECDES         3     32     30        A   DESCRIPCION                               DESCR_SECCION
 SECDCO        33     42     10        A   DESCRIPCION CORTA                         DESCR_CORTA_SECCION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de sección |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomDep | — | Departamento al que pertenece |
| — | NomEmp | — | Empleados de la sección |

---

## Observaciones

- Nivel organizativo por debajo del departamento para distribución de costos.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
