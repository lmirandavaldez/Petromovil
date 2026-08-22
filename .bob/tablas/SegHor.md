# SegHor — Tabla de Horas

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de horas del sistema. Define las horas válidas utilizadas en procesos de control horario y programación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 HORFNU         1      4      4   0    P   HORA EN FORMATO NUMERICO                  HORA_EN_FORMATO_NUMERICO
 HORISO         5     12      8   0    T   HORA TIPO ISO                             HORA_TIPO_ISO
 HORUSA        13     20      8   0    T   HORA TIPO USA                             HORA_TIPO_USA
 HOREUR        21     28      8   0    T   HORA TIPO EUR                             HORA_TIPO_EUR
 HORJIS        29     36      8   0    T   HORA TIPO JIS                             HORA_TIPO_JIS
 HORHMS        37     44      8   0    T   HORA TIPO HMS                             HORA_TIPO_HMS
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — hora |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | — | — | — |

---

## Observaciones

- Tabla auxiliar análoga a SegFec pero para el componente de tiempo (hora).
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
