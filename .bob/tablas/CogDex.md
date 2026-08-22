# CogDex — Descripción Extendida Solicitud

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Descripción extendida de solicitudes de emisión de cheques. Almacena textos adicionales asociados a las solicitudes de cheque para mayor detalle o justificación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SECCVE         1      4      4   0    P   NUMERO SOLICITUD DE CHEQUE                NUMERO_DE_SOLICITUD_CHEQUE
 DEXSEC         5      6      2   0    P   SECUENCIA                                 SECUENCIA_DESCRIPCION_EXTENDI
 DEXDES         7     76     70        A   DESCRIPCION                               DESCRIPCION_EXTENDIDA_SOLICIT

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — solicitud |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogSech | — | Cabecera solicitud de emisión de cheques |

---

## Observaciones

- Descripción ampliada para solicitudes de cheque antes de su emisión definitiva.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
