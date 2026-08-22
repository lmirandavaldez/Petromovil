# CogTdi — Tipos de Diario

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de tipos de diario contable. Define los distintos tipos de asientos (diario general, ajustes, cierres, apertura, provisiones, etc.) con sus parámetros de comportamiento.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 TDIDES         3     32     30        A   DESCRIPCION                               DESCRIPCION_TIPO_DE_DIARIO
 TDIDCO        33     42     10        A   DESCRIPCION CORTA                         DESCRIPCION_CORTA_TIPO_DIARIO
 TDITIP        43     43      1   0    P   TIPO DE DIARIO                            TIPO_DE_DIARIO
 TDIMFO        44     44      1        A   MANEJA FOLIADOR                           TIPO_DIAIRO_MANEJA_FOLIADOR
 TDIERE        45     48      4   0    P   NUMERO SECUENCIAL RECURENTE               NUMERO_SECUENCIAL_RECURRENTE
 TDIPMA        49     49      1        A   PROCESO MANUAL O AUTOMATICA               PROCESO_MANUAL_AUTOMATICA


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de tipo de diario |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogDgeh | — | Asientos de este tipo |
| — | CogRtu | — | Usuarios habilitados para este diario |
| — | SegLtd | — | Leyenda tipo de diario |

---

## Observaciones

- Tabla maestra de tipos de asiento contable; referenciada por todas las tablas de diario.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
