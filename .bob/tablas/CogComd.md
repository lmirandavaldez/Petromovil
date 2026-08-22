# CogComd — Comentario de Documento Detalle

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Comentarios a nivel de detalle de documentos contables. Almacena textos adicionales asociados a líneas individuales de asientos contables.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 COMTDC         1      3      3        A   TIPO DOCUMENTO                            TIPO_DOCUMENTO_COM
 COMDRE         4      9      6   0    P   DOCUMENTO REFERENCIA                      DOCTO_REFERENCIA_COM
 COMDES        10     79     70        A   DESCRIPCION                               DESCRIPCION_COM
 COMSQH        80     82      3   0    P   SECUENCIA HAEDER                          SECUENCIA_HDR_COM
 COMSQD        83     84      2   0    P   SECUENCIA DETALLE                         SECUENCIA_DET_COM

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta documento + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogComh | — | Comentario cabecera del documento |
| — | CogDged | — | Detalle del diario |

---

## Observaciones

- Comentarios a nivel de línea de asiento; ver `CogComh` para comentarios de cabecera.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
