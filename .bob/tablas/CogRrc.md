# CogRrc — Razón Retención del Cheque

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de razones de retención de cheques. Define los motivos válidos por los que un cheque emitido puede ser retenido antes de su entrega al beneficiario.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RRCCVE         1      2      2   0    P   CLAVE RAZON RETENCION                     CLAVE_RAZON_RETENCION_CK
 RRCDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_RETENCION_CK
 RRCDCO        43     52     10        A   DESCRIPCION CORTA                         DESCRIPCION_CORTA_RETENCION
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de razón de retención |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCheh | — | Cheque emitido retenido |

---

## Observaciones

- Catálogo de motivos de retención para control de cheques pendientes de entrega.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
