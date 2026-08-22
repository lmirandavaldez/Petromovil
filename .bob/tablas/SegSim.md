# SegSim — Tabla de Sistema / Menú (Módulo)

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Relación entre sistemas y menús. Define la estructura de acceso a los menús dentro de cada sistema (módulo) del sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SISCVE         1      2      2        A   CLAVE DE SISTEMA                          CLAVE_DEL_SISTEMA
 MENCVE         3      4      2        A   CLAVE DE MENU                             CODIGO_DEL_MENU


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta sistema + menú |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegSis | — | Sistema (módulo) |
| — | SegMen | — | Menú |

---

## Observaciones

- Define la pertenencia de menús a sistemas para el control de acceso.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
