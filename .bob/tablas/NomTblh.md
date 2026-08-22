# NomTblh — Tablas Cabecera

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera de tablas paramétricas de nómina. Define las tablas de valores usadas en los cálculos de nómina: tabla de ISR, sueldo mínimo, tasas de interés de préstamos, etc.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TBLCVE         1      3      3        A   CODIGO DE TABLA                           CODIGO_TABLA
 TBLDES         4     43     40        A   DESCRIPCION                               DESCR_TABLA
 CMCCVE        44     46      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de tabla |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTbld | — | Detalle de la tabla |

---

## Observaciones

- Tablas paramétricas maestras del módulo NOM; su detalle es `NomTbld`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
