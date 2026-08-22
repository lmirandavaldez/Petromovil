# SegCsi — Tabla de Compañía / Sistemas

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Relación entre compañías y sistemas (módulos). Define qué sistemas están habilitados para cada compañía.

---

## Campos

| Campo | Tipo | Long | Dec | Descripción | Notas |
|-------|------|------|-----|-------------|-------|
| — | — | — | — | — | — |

> Completar con todos los campos reales de la tabla.

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta compañía + sistema |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCia | — | Compañía |
| — | SegSis | — | Sistema (módulo) |

---

## Observaciones

- Controla el acceso de cada compañía a los distintos módulos del sistema.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
