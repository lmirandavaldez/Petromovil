# SegAcf — Anulación Comprobante Fiscal

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Registro de comprobantes fiscales anulados. Almacena el historial de anulaciones para control y auditoría fiscal.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 ACFCVE         1      2      2   0    P   ANULACION COMPROBANTE FISCAL              ANULACION_COMPROBANTE_FISCAL
 ACFDES         3     47     45        A   DESCRIPCION                               DESCRIPCION_TIPO_ANULACION_CF
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegTcf | — | Tipo de comprobante fiscal |

---

## Observaciones

- Registra los comprobantes fiscales que han sido anulados en el sistema.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
