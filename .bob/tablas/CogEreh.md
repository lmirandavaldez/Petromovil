# CogEreh — Cabecera Entradas Recurrentes

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de las plantillas de entradas contables recurrentes. Define los asientos que se generan automáticamente de forma periódica (mensual, anual, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 TDIERE         3      6      4   0    P   NUMERO SECUENCIAL RECURRENTE              NUMERO_SECUENCIAL_RECURRENTE
 DGEDES         7     46     40        A   DESCRIPCION                               DESCRIPCION_DE_LA_TRANSACCION
 DGEDEB        47     55      9   2    P   TOTAL DEBITO                              TOTAL_DEBITO
 DGECRE        56     64      9   2    P   TOTAL CREDITO                             TOTAL_CREDITO
 CONCVE        65     67      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOVIMIENT
 CREUSR        68     77     10        A   USUARIO QUE CREO REGISTRO                 USUARIO_QUE_CREO_REGISTRO
 MODUSR        78     87     10        A   USUARIO MODIFICO REGISTRO                 USUARIO_MODIFICO_REGISTRO
 CREWSI        88     97     10        A   TERMINAL DONDE SE CREO                    TERMINAL_DONDE_SE_CREO
 MODWSI        98    107     10        A   TERMINAL DONDE SE MODIFICO                TERMINAL_DONDE_SE_MODIFICO
 CRETST       108    133     26   0    Z   FECHA QUE SE CREO                         FECHA_QUE_SE_CREO
 MODTST       134    159     26   0    Z   FECHA QUE SE MODIFICO                     FECHA_QUE_SE_MODIFICO
 SITCVE       160    160      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de entrada recurrente |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEred | — | Detalles de la entrada recurrente |
| — | CogTdi | — | Tipo de diario |
| — | CogPlr | — | Planificación de entradas recurrentes |

---

## Observaciones

- Cabecera de asientos recurrentes; su detalle es `CogEred`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
