# CogCbac — Descripción Documentos Temporales

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Descripción de documentos temporales de conciliación bancaria. Almacena los datos descriptivos de los documentos en proceso de conciliación antes de su confirmación definitiva.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 TDICVE         4      5      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 DGEDOC         6      9      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO
 DGESEC        10     12      3   0    P   SECUENCIA                                 SECUENCIA
 DGEDES        13     52     40        A   DESCRIPCION                               DESCRIPCION_DE_LA_TRANSACCION
 DGEORI        53     53      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_DEL_MOVIMIENTO
 CBADEM        54     55      2   0    P   DIA DE EMISION                            DIA_DE_EMISION_CHEQUE
 CBAMEM        56     57      2   0    P   MES DE EMICION                            MES_DE_EMISION_CHEQUE
 CBAAEM        58     60      3   0    P   ANO DE EMICION                            ANO_DE_EMISION_CHEQUE
 CBAVDC        61     68      8   2    P   VALOR DEL DOCUMENTO                       VALOR_DE_DOCUMENTO
 CBASTP        69     69      1        A   STATUS DEL MOVIMIENTO                     STATUS_DEL_DOCUMENTO
 CBACTA        70     87     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CBAAUL        88     89      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 CBAAUX        90     93      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CBACCO        94    103     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CBAPRC       104    104      1        A   PROCESADO S/N                             PROCESADO_SN
 CBASN1       105    105      1        A   DESEA CONTABILIZAR S/N                    DESEA_CONTABILIZAR_SN
 CBASN2       106    106      1        A   ESTA CONTABILIZADO S/N                    ESTA_CONTABILIZADO_SN
 CBASN3       107    107      1        A   APLICA LIBROS S/N                         APLICA_LIBROS_SN

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCbah | — | Cabecera conciliación bancaria |
| — | CogBan | — | Banco |

---

## Observaciones

- Documentos temporales en proceso de conciliación bancaria.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
