# SegLdm — Leyenda Documentos y Movimientos

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de leyendas para documentos y movimientos. Define los textos y leyendas estándar que se imprimen o muestran en documentos y registros de movimientos.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 LDMCVE         1      2      2        A   CLAVE                                     CLAVE_TIPO_DOC_MOV
 LDMDES         3     22     20        A   DESCRIPCION                               DESCRIPCION_TIPO_DOC_MOV
 LDMTIP        23     23      1        A   TIPO DE DOCUMENTO                         TIPO_DE_DOC_O_MOV
 SISCVE        24     25      2        A   CLAVE DE SISTEMA                          CLAVE_DEL_SISTEMA
 LDMTOR        26     26      1   0    P   TIPO DE ORIGEN                            TIPO_DE_ORIGEN
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de leyenda |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegLtd | — | Leyenda tipo de diario |

---

## Observaciones

- Define las leyendas y textos estándar utilizados en documentos y movimientos del sistema.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
