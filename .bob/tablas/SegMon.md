# SegMon — Tabla de Moneda

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de monedas del sistema. Define las monedas utilizadas en transacciones, con sus tasas de cambio y parámetros de conversión.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 MONCVE         1      2      2   0    P   CODIGO TIPO DE MONEDAS                    CODIGO_DE_MONEDA
 MONDES         3     32     30        A   DESCRIPCION                               DESCRIPCION_DE_LA_MONEDA
 MONSIM        33     37      5        A   SIMBOLO                                   SIMBOLO_DE_LA_MONEDA
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de moneda |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | — | — | — |

---

## Observaciones

- Tabla maestra de monedas; utilizada en todos los módulos que manejan transacciones financieras.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
