# CogUnr — Último Número de Solicitud Cheques

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Control del último número de solicitud de emisión de cheques. Mantiene el consecutivo actual de numeración de solicitudes por compañía y banco para garantizar la secuencia.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CLAVE          1      1      1        A   CLAVE DEL REGISTRO                        CLAVE_DEL_REGISTRO
 ULNORD         2      5      4   0    P   ULTIMO NRO.                               ULTIMO_NUMERO_SOLICITUD_CK

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — compañía + banco |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Banco |
| — | SegCia | — | Compañía |

---

## Observaciones

- Control de consecutivo de solicitudes de cheque para evitar duplicados.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
