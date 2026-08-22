# SegMcf — Módulo Comprobante Fiscal

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Relación entre módulos del sistema y comprobantes fiscales. Define qué tipos de comprobante fiscal puede generar cada módulo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 MCFCVE         1      2      2   0    P   MODULO COMPROBANTE FISCAL                 MODULO_COMPROBANTE_FISCAL
 MCFDES         3     32     30        A   DESCRIPCION                               DESCRIPCION_COMPROB_FISCAL

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta módulo + tipo comprobante |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegSis | — | Sistema (módulo) |
| — | SegTcf | — | Tipo de comprobante fiscal |

---

## Observaciones

- Configura qué tipos de comprobante fiscal puede emitir cada módulo del sistema.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
