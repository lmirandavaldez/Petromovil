# SegLic — Control de Licencias (Detalle)

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Detalle del control de licencias del sistema. Registra las licencias asignadas a compañías y usuarios, con sus fechas de vigencia y límites de uso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 LICCVE         1    128    128        A   CODIGO DE LA LICENCIA                     CODIGO_DE_LA_LICENCIA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCtl | — | Control general de licencias |
| — | SegCia | — | Compañía licenciada |

---

## Observaciones

- Ver también `SegCtl` para el control global de licencias.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
