# SegPtb — Proceso Transferencia Batch

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Control de procesos de transferencia en modo batch. Registra el estado y resultado de los procesos de transferencia de datos ejecutados en lote.

---

## Campos

-----------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIACVE         1      2      2        A   NRO. COMPA#IA                             NUMERO_COMPANIA
 USRCVE         3     12     10        A   USUARIO                                   CODIGO_DEL_USUARIO
 PGMCVE        13     22     10        A   CLAVE DE PROGRAMA                         CODIGO_DEL_PROGRAMA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCia | — | Compañía que ejecuta el proceso |
| — | SegCep | — | Control ejecución de procesos |

---

## Observaciones

- Controla la ejecución y seguimiento de procesos batch de transferencia de datos.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
