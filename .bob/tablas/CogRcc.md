# CogRcc — Razón Cancelación del Cheque

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de razones de cancelación de cheques. Define los motivos válidos por los que un cheque puede ser cancelado o anulado en el sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RCCCVE         1      2      2   0    P   CLAVE RAZON CANCELACION                   CLAVE_RAZON_CANCELACION_CK
 RCCDES         3     32     30        A   DESCRIPCION                               DESCRIPCION_CANCELACION_CK
 RCCDCO        33     42     10        A   DESCRIPCION CORTA                         DESCRIPCION_COSTA_CANCELACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de razón de cancelación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCan | — | Cheques cancelados |

---

## Observaciones

- Catálogo de motivos de cancelación para auditoría de cheques anulados.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
