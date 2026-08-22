# NomFol — Foliadores de Nómina

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Foliadores de documentos de nómina. Controla la numeración secuencial de los documentos generados por el módulo de nómina (cheques, comprobantes, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 FOLCVE         1      2      2   0    P   COGIDO DE FOLIADOR                        COGIDO_DE_FOLIADOR
 FOLDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_DEL_FOLIADOR
 FOLTEM        43     46      4   0    P   NUMERO TEMPORAL                           NUMERO_TEMPORAL_FOLIADOR
 FOLDEF        47     50      4   0    P   NUMERO DEFINITIVO                         NUMERO_DEFINITIVO_FOLIADOR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — tipo de documento + compañía |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCia | — | Compañía |

---

## Observaciones

- Control de secuencias numéricas de documentos de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
