# CogSreh — Cabecera Solicitud Cheques Recurrentes

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de solicitudes de cheques recurrentes. Define las plantillas de solicitudes de cheque que se generan de forma periódica, con su beneficiario, frecuencia y banco.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDIERE         1      4      4   0    P   NUMERO SECUENCIAL RECURRENTE              NUMERO_SECUENCIAL_RECURRENTE
 BANCVE         5      7      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 CONCVE         8     10      3   0    P   CODIGO CONCEPTO DEL CHEQUE                CODIGO_CONCEPTO_DEL_MOVIMIENT
 SECBE1        11     55     45        A   BENEFICIARIO 1                            BENEFICIARIO_1
 SECBE2        56    100     45        A   BENEFICIARIO 2                            BENEFICIARIO_2
 MONCVE       101    102      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 SECTAS       103    108      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO
 SECMCH       109    114      6   2    P   MONTO DEL CHEQUE                          MONTO_DEL_CHEQUE
 SECDEB       115    121      7   2    P   TOTAL DEBITOS                             TOTAL_DEBITO_SOLICITUD_CK
 SECCRE       122    128      7   2    P   TOTAL CREDITOS                            TOTAL_CREDITO_SOLICITUD_CK
 SECDIF       129    135      7   2    P   TOTAL DIFERENCIA                          TOTAL_DIFERENCIA_SOLICITUD_CK
 SITCVE       136    136      1        A   SITUACION                                 CLAVE_DE_SITUACION


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de plantilla recurrente |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogSred | — | Detalle de la solicitud recurrente |
| — | CogBan | — | Banco para emisión |
| — | CogDre | — | Descripción extendida recurrente |

---

## Observaciones

- Plantilla de solicitudes recurrentes de cheque; su detalle es `CogSred`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
