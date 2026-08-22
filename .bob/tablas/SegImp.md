# SegImp — Tipos de Impuestos

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de tipos de impuestos del sistema. Define los impuestos aplicables (ITBIS, ISR, etc.) con sus tasas y parámetros de cálculo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 IMPCVE         1      3      3   0    P   CODIGO IMPUESTOS                          CODIGO_DE_IMPUESTO
 IMPDES         4     43     40        A   DESCRIPCION                               DESCRIPCION_IMPUESTO
 IMPDCO        44     53     10        A   DESCRIPCION CORTA                         DESC_CORTA_IMPUESTO
 IMPPOR        54     58      5   2    S   PORCIENTO DEL IMPUESTO                    PORCIENTO__IMPUESTO_APLICAR
 IMPVAL        59     70     12   2    S   VALOR QUE APLICA                          VALOR_IMPUESTO_APLICAR
 CTACVE        71     88     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXCVE        89     92      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de impuesto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegTig | — | Tipo de ingreso relacionado |

---

## Observaciones

- Tabla maestra de impuestos; usada por todos los módulos que generan documentos fiscales.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
