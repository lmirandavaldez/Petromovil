# CogPehd — Detalles Pago Exterior Definitivo

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalles definitivos de pagos al exterior. Contiene el desglose de cada pago realizado a beneficiarios en el exterior con sus cuentas, montos e impuestos retenidos.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PGETDC         1      3      3        A   TIPO DE DOCUMENTO                         TIPO_DOCUMENTO_PGE
 PGENUM         4      9      6   0    P   NRO DEFINITIVO PAGO EXTERIOR              NRO_PAGO_EXTERIOR_DEFINITIVO
 PGESEC        10     12      3   0    P   CONSECUTIVO                               SECUENCIA_DETALLE_PGE
 CTACVE        13     30     18        A   NUMERO DE CUENTA CONTABLE                 NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        31     32      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        33     36      4   0    P   NUMERO DE AUXILIAR                        CLAVE_AUXILIAR
 CCOCVE        37     46     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 PGEVTR        47     53      7   2    P   VALOR TRANSACCION                         VALOR_TRANS_PAGO_EXTERIOR
 PGEORI        54     54      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_CONT_TRANSACCION_PGE
 CONSEC        55     57      3   0    P   SECUENCIA DETALLE CONCEPTO                SECUENCIA_DETALLE_CONCEPTO
 MOVAXV        58     58      1        A   ES AUXILIAR VARIABLE                      ES_AUXILIAR_VARIABLE
 PGEDE1        59     98     40        A   DESCRIPCION                               DESCRIPCION_TRANSACCION_PGE
 PGERAU        99     99      1        A   REGISTRO AUTOMATICO                       IDENTIFICACION_REGISTRO_PGE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPehh | — | Cabecera pago exterior definitivo |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Detalle de pagos al exterior confirmados; su cabecera es `CogPehh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
