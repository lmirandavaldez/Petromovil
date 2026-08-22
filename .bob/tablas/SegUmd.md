# SegUmd — Unidad de Medida

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de unidades de medida. Define las unidades utilizadas para cuantificar artículos, servicios y recursos en los distintos módulos del sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 UMDCVE         1      2      2   0    P   CODIGO UNIDAD MEDIDA DGII                 CODIGO_UNIDAD_MEDIDA_DGII
 UMDDES         3     42     40        A   DESCRIPCION UNIDAD DGII                   DESCRIPCION_UNIDAD_MEDIDA_DGI
 UMDABG        43     62     20        A   ABREVIATURA UNIDAD DGII                   ABREVIATURA_UNIDAD_DGII

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de unidad de medida |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | — | — | — |

---

## Observaciones

- Tabla maestra de unidades de medida; utilizada por inventario y nómina, entre otros módulos.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
