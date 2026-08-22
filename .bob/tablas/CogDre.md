# CogDre — Descripción Extendida Solicitud Recurrente

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Descripción extendida de solicitudes de cheques recurrentes. Almacena textos adicionales para solicitudes de cheque de carácter periódico o recurrente.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDIERE         1      4      4   0    P   NUMERO SECUENCIAL RECURRENTE              NUMERO_SECUENCIAL_RECURRENTE
 DEXSEC         5      6      2   0    P   SECUENCIA                                 SECUENCIA_DESCRIPCION_EXTENDI
 DEXDES         7     76     70        A   DESCRIPCION                               DESCRIPCION_EXTENDIDA_SOLICIT

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — solicitud recurrente |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogSreh | — | Cabecera solicitud cheques recurrentes |

---

## Observaciones

- Descripción extendida para plantillas de solicitudes recurrentes de cheque.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
