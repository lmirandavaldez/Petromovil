# CogTec — Temporal para Impresión de Cheques

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Tabla temporal para el proceso de impresión de cheques. Almacena los cheques seleccionados para impresión en una sesión de trabajo antes de ejecutar el proceso de impresión.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TECNRO         1      4      4   0    P   NRO. TEMPORAL
 TECBAN         5      7      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 TECTIT         8      8      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 TECNCK         9     12      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCheh | — | Cheque emitido a imprimir |

---

## Observaciones

- Tabla de trabajo temporal para la cola de impresión de cheques; se limpia al finalizar el proceso.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
