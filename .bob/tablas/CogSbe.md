# CogSbe — Segundo Beneficiario del Cheque

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Segundo beneficiario de cheques emitidos. Registra los datos del segundo beneficiario cuando un cheque se emite a nombre de dos personas o entidades.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR         4      4      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 BANNCH         5      8      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE
 SECBE2         9     53     45        A   SEGUNDO BENEFICIARIO                      BENEFICIARIO_2


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

- Complementa la información del cheque cuando tiene dos beneficiarios.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
