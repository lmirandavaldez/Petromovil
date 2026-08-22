# CogEst — Estructura de la Cuenta

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Estructura del plan de cuentas contables. Define los niveles, segmentos y formato de codificación del catálogo de cuentas del módulo de contabilidad.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 ESTELE         1      2      2   0    P   ELEMENTO                                  CODIGO_DEL_ELEMENTO
 ESTDES         3     37     35        A   DESCRIPCION                               DESCRIPCION_DEL_ELEMENTO
 ESTINI        38     39      2   0    P   POSICION INICIAL                          POSICION_INICIAL_ELEMENTO
 ESTFIN        40     41      2   0    P   POSICION FINAL                            POSICION_INICIAL_FINAL
 ESTLON        42     43      2   0    P   LONGITUD                                  LONGITUD_DEL_ELEMENTO
 ESTSEP        44     44      1        A   SEPARADOR                                 SEPARADOR_DEL_ELEMENTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEcc | — | Estructura cuenta (configuración) |
| — | SegCia | — | Compañía |

---

## Observaciones

- Define la estructura jerárquica del plan de cuentas; ver también `CogEcc`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
