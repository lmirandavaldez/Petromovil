# CogSech — Cabecera Solicitud Emisión Cheques

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de solicitudes de emisión de cheques. Registra los datos generales de cada solicitud: beneficiario, banco, monto total, estado de aprobación y fecha.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SECCVE         1      4      4   0    P   NUMERO SOLICITUD DE CHEQUE                NUMERO_DE_SOLICITUD_CHEQUE
 BANCVE         5      7      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR         8      8      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 PERANO         9     11      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        12     13      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 CONCVE        14     16      3   0    P   CODIGO CONCEPTO DEL CHEQUE                CODIGO_CONCEPTO_DEL_MOVIMIENT
 SECBE1        17     61     45        A   BENEFICIARIO 1                            BENEFICIARIO_1
 SECBE2        62    106     45        A   BENEFICIARIO 2                            BENEFICIARIO_2
 MONCVE       107    108      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 SECTAS       109    114      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO
 SECMCH       115    120      6   2    P   MONTO DEL CHEQUE                          MONTO_DEL_CHEQUE
 SECDIA       121    122      2   0    P   DIA DE LA SOLICITUD                       DIA_DE_LA_SOLICITUD
 SECMES       123    124      2   0    P   MES DE LA SOLICITUD                       MES_DE_LA_SOLICITUD
 SECANO       125    127      3   0    P   ANO DE LA SOLICITUD                       ANO_DE_LA_SOLICITUD
 SECDEB       128    134      7   2    P   TOTAL DEBITOS                             TOTAL_DEBITO_SOLICITUD_CK
 SECCRE       135    141      7   2    P   TOTAL CREDITOS                            TOTAL_CREDITO_SOLICITUD_CK
 SECDIF       142    148      7   2    P   TOTAL DIFERENCIA                          TOTAL_DIFERENCIA_SOLICITUD_CK
 SECTVI       149    155      7   2    P   TOTAL IMPUESTO                            TOTAL_IMPUESTO_SECH
 SECTIR       156    162      7   2    P   TOTAL IMPUESTO RETENIDO                   TOTAL_IMPUESTO_RETENIDO_SECH
 SECTOI       163    169      7   2    P   TOTAL OTRO IMPUESTO                       TOTAL_OTRO_IMPUESTO_SECH
 SECTOR       170    176      7   2    P   TOTAL OTRO IMPUESTO RETENIDO              TOTAL_OTRO_IMPUESTO_RET_SECH
 SECTFS       177    183      7   2    P   TOTAL MONTO SERVICIOS                     TOTAL_MONTO_SERVICIOS_SECH
 SECTFB       184    190      7   2    P   TOTAL MONTO BIENES                        TOTAL_MONTO_BIENES_SECH
 SECTIS       191    197      7   2    P   TOTAL IMPUESTO SERVICIOS                  TOTAL_IMPUESTO_SERVICIOS_SECH
 SECTIB       198    204      7   2    P   TOTAL IMPUESTO BIENES                     TOTAL_IMPUESTO_BIENES_SECH
 SECTIC       205    211      7   2    P   TOTAL MONTO IMPUESTO COSTO                TOTAL_IMPUESTO_COSTO_SECH
 SECTIP       212    218      7   2    P   TOTAL IMPUESTO PROPORCIONALIDAD           TOTAL_IMP_PROPORCION_SECH
 SECTIE       219    225      7   2    P   TOTAL MONTO IMPUESTO SELECTIVO            TOTAL_IMPUESTO_SELECTIVO_SECH
 SECTIO       226    232      7   2    P   TOTAL OTROS IMPUESTO                      TOTAL_OTROS_IMPUESTOS_SECH
 SECTPL       233    239      7   2    P   TOTAL PROPINA LEGAL                       TOTAL_PROPINA_LEGAL_SECH
 DCDCVE       240    242      3   0    P   CODIGO DISTRIBUCION CONTABLE              CODIGO_DISTRIBUCION_CONTABLE
 DGEVTR       243    250      8   2    P   VALOR TRANSACCION                         VALOR_TRANSACCION
 USRCVE       251    260     10        A   ID DE USUARIO                             ID_DEL_USUARIO
 SECSTA       261    262      2   0    P   ESTATUS
 SITCVE       263    263      1        A   SITUACION                                 CLAVE_DE_SITUACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de solicitud |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogSecd | — | Detalles de la solicitud |
| — | CogBan | — | Banco para emisión |
| — | CogSecu | — | Datos de usuario de la solicitud |
| — | CogDex | — | Descripción extendida |

---

## Observaciones

- Cabecera del flujo de solicitud → emisión de cheques; su detalle es `CogSecd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
