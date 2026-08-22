# SegCvc — Control Versión Comprobantes

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Control de versiones de comprobantes fiscales. Gestiona las distintas versiones de formato y estructura de los comprobantes emitidos.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIACVE         1      2      2        A   CODIGO DE LA EMPRESA                      CODIGO_DE_LA_EMPRESA
 NCFSER         3      3      1        A   SERIE DEL COMPROBANTES                    SERIE_RELACIONADA
 CVCFIV         4     13     10   0    L   FECHA INICIO VERSION COMPROBANTE          FECHA_INICIO_VERSION_COMPROBA
 CVCFFV        14     23     10   0    L   FECHA FINAL VERSION COMPROBANTE           FECHA_FINAL_VERSION_COMPROBAN
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
| — | SegMcf | — | Módulo comprobante fiscal |

---

## Observaciones

- Controla la versión vigente de cada tipo de comprobante fiscal.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
