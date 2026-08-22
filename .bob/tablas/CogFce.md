# CogFce — Foliadores Comprobantes Especiales

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Foliadores para comprobantes especiales. Controla la secuencia numérica de los comprobantes de tipos especiales (ajustes, cierres, reaperturas, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 FOLCVE         1      2      2   0    P   COGIDO DE FOLIADOR                        COGIDO_DE_FOLIADOR
 FOLDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_DEL_FOLIADOR
 FOLTEM        43     48      6   0    P   NUMERO TEMPORAL                           NUMERO_TEMPORAL_FOLIADOR
 FOLDEF        49     54      6   0    P   NUMERO DEFINITIVO                         NUMERO_DEFINITIVO_FOLIADOR
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — tipo de comprobante especial |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogFol | — | Foliador general |
| — | CogTdi | — | Tipo de diario |

---

## Observaciones

- Foliadores para tipos especiales de comprobantes; ver `CogFol` para el foliador general.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
