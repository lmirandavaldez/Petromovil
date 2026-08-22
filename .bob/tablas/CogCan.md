# CogCan — Cheques Cancelados

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Registro de cheques cancelados. Almacena el historial de cheques anulados o cancelados con sus razones y datos de cancelación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR         4      4      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 BANNCH         5      8      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE
 RCCCVE         9     10      2   0    P   CLAVE RAZON CANCELACION                   CLAVE_RAZON_CANCELACION_CK
 APLDIA        11     12      2   0    P   DIA QUE SE APLICO                         DIA_QUE_APLICO
 APLMES        13     14      2   0    P   MES QUE APLICO                            MES_QUE_APLICO
 APLANO        15     17      3   0    P   ANO QUE APLICO                            ANO_QUE_APLICO
 APLUSR        18     27     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI        28     37     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR        38     41      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de cheque |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Banco emisor |
| — | CogRcc | — | Razón de cancelación |

---

## Observaciones

- Historial de cheques cancelados; ver `CogRcc` para las razones de cancelación.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
