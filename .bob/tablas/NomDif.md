# NomDif — Días Feriados o No Laborables

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Catálogo de días feriados y no laborables. Define el calendario de días feriados nacionales y no laborables para el cálculo correcto de días trabajados, horas extras y vacaciones.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 DIFFEC         1      5      5   0    P   FECHA DIA FERIADO                         FECHA_DIA_FERIADO
 DIFDES         6     35     30        A   DESCRIPCION DEL DIA                       DESCRIPCION_DEL_DIA
 DIFTIP        36     36      1        A   TIPO DEL DIA                              TIPO_DEL_DIA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — fecha |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegFec | — | Fecha del día feriado |

---

## Observaciones

- Calendario de feriados nacionales y días no laborables según Código Laboral dominicano.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
