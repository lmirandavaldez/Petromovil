# CogCon — Tabla de Conceptos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de conceptos contables. Define los conceptos o descripciones estándar utilizados en los asientos contables y documentos del módulo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CONCVE         1      3      3   0    P   CODIGO CONCEPTO                           CODIGO_CONCEPTO_DEL_MOVIMIENT
 CONDES         4     33     30        A   DESCRIPCION                               DESCRIPCION_CONCEPTO_MOVIMIEN
 CONDCO        34     43     10        A   DESCRIPCION CORTA                         DESCRIPCION_COSTA_CONCEPTO_MO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de concepto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCond | — | Distribución contable del concepto |
| — | CogConh | — | Concepto de gastos menores |

---

## Observaciones

- Catálogo de conceptos estándar para asientos; ver `CogCond` para la distribución.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
