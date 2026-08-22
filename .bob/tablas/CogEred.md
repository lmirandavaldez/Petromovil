# CogEred — Detalles Entradas Recurrentes

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalles de las plantillas de entradas contables recurrentes. Contiene las líneas de cada asiento recurrente (cuenta, débito/crédito, monto) listas para su generación periódica.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 TDIERE         3      6      4   0    P   NUMERO SECUENCIAL RECURRENTE              NUMERO_SECUENCIAL_RECURRENTE
 DGESEC         7      9      3   0    P   SECUENCIA                                 SECUENCIA
 CTACVE        10     27     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        28     29      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        30     33      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        34     43     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 DGEDE1        44     83     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOVIMIENTO
 DGEVAL        84     91      8   2    P   VALOR DEL MOVIMIENTO                      VALOR_DEL_MOVIMIENTO
 DGEORI        92     92      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_DEL_MOVIMIENTO
 DGERE1        93    102     10        A   REFERENCIA 1                              REFERENCIA_1
 DGERE2       103    112     10        A   REFERENCIA 2                              REFERENCIA_2
 DGEDTO       113    114      2   0    P   DIA DE VENCIMIENTO                        DIA_DE_VENCIMIENTO
 DGEMTO       115    116      2   0    P   MES DE VENCIMIENTO                        MES_DE_VENCIMIENTO
 DGEATO       117    119      3   0    P   A#O DE VENCIMIENTO                        ANO_DE_VENCIMIENTO
 MONCVE       120    121      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 SECTAS       122    127      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEreh | — | Cabecera de entrada recurrente |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Detalle de asientos recurrentes; su cabecera es `CogEreh`. Ver también `CogRecd/Rech`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
