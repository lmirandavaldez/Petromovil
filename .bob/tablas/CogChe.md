# CogChe — Cronológico de Cheques

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Registro cronológico de cheques emitidos. Mantiene un historial ordenado por fecha de todos los cheques emitidos por el sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 BANNOM         4     38     35        A   NOMBRE                                    NOMBRE_DEL_BANCO
 SECTTR        39     39      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 BANNCH        40     43      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE
 CHEFTR        44     48      5   0    P   FECHA DEL CHEQUE                          FECHA_EMISION_CHEQUE_AMD
 CHENED        49     58     10        A   NUMERO ENTRADA DIARIO                     NUMERO_ENTRADA_DIARIO_DGD
 CONCVE        59     61      3   0    P   CODIGO CONCEPTO DEL CHEQUE                CODIGO_CONCEPTO_DEL_MOVIMIENT
 SECBE1        62    106     45        A   BENEFICIARIO 1                            BENEFICIARIO_1
 MONCVE       107    108      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 SECTAS       109    114      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO
 SECMCH       115    120      6   2    P   MONTO DEL CHEQUE                          MONTO_DEL_CHEQUE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta banco + fecha + número de cheque |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Banco emisor |
| — | CogCheh | — | Cabecera cheques emitidos |

---

## Observaciones

- Registro cronológico de todos los cheques; ver `CogCheh` para la cabecera detallada.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
