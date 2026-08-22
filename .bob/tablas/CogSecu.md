# CogSecu — Datos de Usuario Solicitud Cheques

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Datos del usuario que registra o aprueba solicitudes de emisión de cheques. Almacena la trazabilidad de usuarios involucrados en el flujo de aprobación de solicitudes.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SECCVE         1      4      4   0    P   NUMERO SOLICITUD DE CHEQUE                NUMERO_DE_SOLICITUD_CHEQUE
 BANCVE         5      7      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR         8      8      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 BANNCH         9     12      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — solicitud + usuario |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogSech | — | Solicitud de emisión de cheques |
| — | SegUsr | — | Usuario |

---

## Observaciones

- Trazabilidad de usuarios en el flujo de aprobación de solicitudes de cheque.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
