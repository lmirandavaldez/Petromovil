# CogIep — Programas a Ejecutar en Impresión

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de programas de impresión de estados financieros. Define los programas RPG o de reporte que se ejecutan para imprimir cada tipo de estado financiero.

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
| PK | — | Clave primaria — código de programa de impresión |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogIef | — | Grupo de impresión |
| — | CogIne | — | Índice de impresión de estados |

---

## Observaciones

- Define los programas ejecutables asociados a cada proceso de impresión de estados.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
