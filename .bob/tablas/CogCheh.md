# CogCheh — Cabecera Cheques Emitidos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de cheques emitidos. Registra los datos principales de cada cheque emitido: beneficiario, banco, monto, fecha y estado.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR         4      4      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 BANNCH         5      8      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE
 PERANO         9     11      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        12     13      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 SECCVE        14     17      4   0    P   NUMERO SOLICITUD DE CHEQUE                NUMERO_DE_SOLICITUD_CHEQUE
 SECDIA        18     19      2   0    P   DIA DE LA SOLICITUD                       DIA_DE_LA_SOLICITUD
 SECMES        20     21      2   0    P   MES DE LA SOLICITUD                       MES_DE_LA_SOLICITUD
 SECANO        22     24      3   0    P   ANO DE LA SOLICITUD                       ANO_DE_LA_SOLICITUD
 CHEDIA        25     26      2   0    P   DIA EMISION DEL CHEQUE                    DIA_EMISION_DEL_CHEQUE
 CHEMES        27     28      2   0    P   MES EMISION DEL CHEQUE                    MES_EMISION_DEL_CHEQUE
 CHEANO        29     31      3   0    P   ANO EMISION DEL CHEQUE                    ANO_EMISION_DEL_CHEQUE
 CONCVE        32     34      3   0    P   CODIGO CONCEPTO DEL CHEQUE                CODIGO_CONCEPTO_DEL_MOVIMIENT
 SECBE1        35     79     45        A   BENEFICIARIO 1                            BENEFICIARIO_1
 MONCVE        80     81      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 SECTAS        82     87      6   5    P   TASA DE CAMBIO                            TASA_DE_CAMBIO
 SECMCH        88     93      6   2    P   MONTO DEL CHEQUE                          MONTO_DEL_CHEQUE
 SECDEB        94    100      7   2    P   TOTAL DEBITOS                             TOTAL_DEBITO_SOLICITUD_CK
 SECCRE       101    107      7   2    P   TOTAL CREDITOS                            TOTAL_CREDITO_SOLICITUD_CK
 CHETDI       108    109      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO_CKS
 CHEPGM       110    119     10        A   PROGRAMA QUE EMITIO CK.                   PROGRAMA_EMITIO_CKS
 CHEMOD       120    121      2        A   MODULO QUE EMITIO CK.                     MODULO_EMITIO_CKS
 CHECBE       122    125      4   0    P   CODIGO BENEFICIARIO                       CODIGO_DEL_BENEFICIARIO
 DCDCVE       126    128      3   0    P   CODIGO DISTRIBUCION CONTABLE              CODIGO_DISTRIBUCION_CONTABLE
 DGEVTR       129    136      8   2    P   VALOR TRANSACCION                         VALOR_TRANSACCION
 USRCVE       137    146     10        A   ID DE USUARIO CREO                        ID_DEL_USUARIO
 CFACVE       147    149      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 CHEIDE       150    164     15        A   REGISTRO FISCAL                           REGISTRO_FISCAL_CHE
 CHETID       165    165      1        A   TIPO DE IDENTIFICACION                    TIPO_IDENTIFICACION_CHE
 SECTVI       166    172      7   2    P   TOTAL IMPUESTO                            TOTAL_IMPUESTO_SECH
 SECTIR       173    179      7   2    P   TOTAL IMPUESTO RETENIDO                   TOTAL_IMPUESTO_RETENIDO_SECH
 SECTOI       180    186      7   2    P   TOTAL OTRO IMPUESTO                       TOTAL_OTRO_IMPUESTO_SECH
 SECTOR       187    193      7   2    P   TOTAL OTRO IMPUESTO RETENIDO              TOTAL_OTRO_IMPUESTO_RET_SECH
 SECTFS       194    200      7   2    P   TOTAL MONTO SERVICIOS                     TOTAL_MONTO_SERVICIOS_SECH
 SECTFB       201    207      7   2    P   TOTAL MONTO BIENES                        TOTAL_MONTO_BIENES_SECH
 SECTIS       208    214      7   2    P   TOTAL IMPUESTO SERVICIOS                  TOTAL_IMPUESTO_SERVICIOS_SECH
 SECTIB       215    221      7   2    P   TOTAL IMPUESTO BIENES                     TOTAL_IMPUESTO_BIENES_SECH
 SECTIC       222    228      7   2    P   TOTAL MONTO IMPUESTO COSTO                TOTAL_IMPUESTO_COSTO_SECH
 SECTIP       229    235      7   2    P   TOTAL IMPUESTO PROPORCIONALIDAD           TOTAL_IMP_PROPORCION_SECH
 SECTIE       236    242      7   2    P   TOTAL MONTO IMPUESTO SELECTIVO            TOTAL_IMPUESTO_SELECTIVO_SECH
 SECTIO       243    249      7   2    P   TOTAL OTROS IMPUESTO                      TOTAL_OTROS_IMPUESTOS_SECH
 SECTPL       250    256      7   2    P   TOTAL PROPINA LEGAL                       TOTAL_PROPINA_LEGAL_SECH
 SITCVE       257    257      1        A   SITUACION                                 CLAVE_DE_SITUACION
 APLUSR       258    267     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       268    277     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR       278    281      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — banco + número de cheque |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Banco emisor |
| — | CogSecd | — | Solicitud de emisión origen |
| — | CogDec | — | Descripción extendida |

---

## Observaciones

- Tabla principal de cheques emitidos; ver `CogChe` para el cronológico.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
