# SegTcf — Tipo de Comprobante Fiscal

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de tipos de comprobante fiscal. Define los tipos de NCF (Número de Comprobante Fiscal) habilitados, conforme a la normativa de la autoridad tributaria.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TCFCVE         1      2      2   0    P   TIPO COMPROBANTE FISCAL                   TIPO_COMPROBANTE_FISCAL
 TCFDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_COMPROBA_FISCAL
 TCFCCL        43     43      1        A   CLASIFICACION DE CLIENTES                 CLASIFICACION_DE_CLIENTES
 TCFTDS        44     44      1        A   TIPO DE DOCUMENTO SOLICITA                TIPO_DE_DOCUMENTO_SOLICITA


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de tipo NCF |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegAcf | — | Anulaciones de este tipo |
| — | SegRcs | — | Series asignadas |
| — | SegMcf | — | Módulos que lo emiten |

---

## Observaciones

- Define los tipos de comprobante fiscal válidos según normativa DGII (República Dominicana).
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
