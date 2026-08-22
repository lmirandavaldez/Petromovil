# CogDec — Descripción Extendida del Cheque

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Descripción extendida de cheques emitidos. Almacena textos adicionales de descripción o instrucciones que acompañan a cada cheque emitido.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR         4      4      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 BANNCH         5      8      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE
 DEXSEC         9     10      2   0    P   SECUENCIA                                 SECUENCIA_DESCRIPCION_EXTENDI
 DEXDES        11     80     70        A   DESCRIPCION                               DESCRIPCION_EXTENDIDA_SOLICIT

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — cheque |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCheh | — | Cabecera cheque emitido |

---

## Observaciones

- Texto ampliado para impresión o archivo del cheque.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
