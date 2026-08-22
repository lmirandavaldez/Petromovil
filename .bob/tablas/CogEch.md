# CogEch — Control Cheques Entregados

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Control de entrega física de cheques. Registra cuándo y a quién se entregó cada cheque emitido, para el seguimiento del proceso de distribución de cheques.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR         4      4      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 BANNCH         5      8      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE
 ECHNOM         9     53     45        A   NOMBRE PERSONA RECIBIO CHE.               NOMBRE_PERSONA_RECIBIO_CHEQUE
 ECHCED        54     68     15        A   CEDULA DE QUIEN RECIBIO                   CEDULA_PERSONA_RECIBIO_CHEQUE
 APLDIA        69     70      2   0    P   DIA ENTREGA DEL CHEQUE                    DIA_QUE_APLICO
 APLMES        71     72      2   0    P   MES ENTREGA DEL CHEQUE                    MES_QUE_APLICO
 APLANO        73     75      3   0    P   ANO ENTREGA DEL CHEQUE                    ANO_QUE_APLICO
 APLWSI        76     85     10        A   TERMINAL DONDE SE ENTREGO                 TERMINAL_DONDE_SE_APLICO
 APLHOR        86     89      4   0    P   HORA QUE SE ENTREGO                       HORA_QUE_SE_APLICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — banco + número de cheque |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCheh | — | Cabecera cheque emitido |

---

## Observaciones

- Controla la entrega física de cheques a beneficiarios.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
