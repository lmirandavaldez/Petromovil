# NomHorh — Horas Trabajadas Cabecera

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera de horas trabajadas. Registra el encabezado del período de control de asistencia y horas trabajadas por grupo de empleados o ciclo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 CIPANO         5      7      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         8      9      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 EMPCVE        10     13      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 HORNOR        14     15      2   0    P   CANTIDAD HORAS NORMALES                   CANTIDAD_HORAS_NORMALES
 HOR035        16     17      2   0    P   CANTIDAD HORAS AL 35                      CANTIDAD_HORAS_AL_35
 HOR100        18     19      2   0    P   CANTIDAD HORAS AL 100                     CANTIDAD_HORAS_AL_100
 HORDIF        20     21      2   0    P   CANTIDAD HORAS DIAS FERIADOS              CANTIDAD_HORAS_DIAS_FERIADOS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — ciclo de horas |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomHord | — | Detalle de horas trabajadas |
| — | NomCih | — | Ciclo de horas extras |

---

## Observaciones

- Cabecera del registro de horas trabajadas; su detalle es `NomHord`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
