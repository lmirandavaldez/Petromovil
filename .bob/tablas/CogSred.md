# CogSred — Detalle Solicitud Cheques Recurrentes

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalle de las solicitudes de cheques recurrentes. Contiene el desglose de cuentas y montos de las plantillas de solicitudes de cheque de carácter periódico.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDIERE         1      4      4   0    P   NUMERO SECUENCIAL RECURRENTE              NUMERO_SECUENCIAL_RECURRENTE
 SECSEC         5      6      2   0    P   SECUENCIA                                 SECUENCIA_DEL_REGISTRO_SOLICI
 CTACVE         7     24     18        A   CUENTA CONTABLE                           NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        25     26      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        27     30      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        31     40     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 SECDES        41     80     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOV_DE_SOLICI
 SECVAL        81     86      6   2    P   VALOR DEL MOVIMIENTO                      VALOR_DEL_MOVIMIENTO_SOLICITU
 SECORI        87     87      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_CONT_DEBITO_CREDITO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogSreh | — | Cabecera solicitud cheques recurrentes |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Detalle de la plantilla de solicitudes recurrentes; su cabecera es `CogSreh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
