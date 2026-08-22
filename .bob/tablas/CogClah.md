# CogClah — Clasificación Gastos Histórico

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Clasificación histórica de gastos. Almacena la clasificación definitiva de los gastos por período, utilizada para reportes de análisis de gastos históricos.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 PERANO         3      5      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM         6      7      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 DGEDOC         8     11      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO
 CFACVE        12     14      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 CHEIDE        15     29     15        A   REGISTRO FISCAL                           REGISTRO_FISCAL_CHE
 CHETID        30     30      1        A   TIPO DE IDENTIFICACION                    TIPO_IDENTIFICACION_CHE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período + clasificación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogClat | — | Clasificación temporal de gastos |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Versión histórica definitiva de la clasificación de gastos; ver `CogClat` para la temporal.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
