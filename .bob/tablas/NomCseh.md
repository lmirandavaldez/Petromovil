# NomCseh — Temporal Cabecera Cambio de Sueldos

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera temporal de cambios de sueldo. Tabla de trabajo para el encabezado del proceso de cambio masivo o individual de sueldos antes de su confirmación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CSECVE         1      4      4   0    P   NUMERO TEMPORAL                           NUMERO_TEMPORAL
 CSEFEC         5      9      5   0    P   FECHA DE CAMBIO                           FECHA_CIERRE
 CSEDES        10     49     40        A   DESCRIPCION CAMBIO                        DESCRIPCION_CAMBIO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de proceso |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCsed | — | Detalle temporal cambio de sueldos |
| — | NomCse | — | Registro definitivo de cambios de sueldo |

---

## Observaciones

- Cabecera temporal de cambios de sueldo; su detalle es `NomCsed`. Al confirmar pasa a `NomCse`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
