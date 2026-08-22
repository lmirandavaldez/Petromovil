# NomRcf — Equivalencia Nómina - Liquidación

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Equivalencia entre conceptos de nómina y liquidación. Define la correspondencia entre los conceptos de nómina regular y los conceptos utilizados en el proceso de liquidación de empleados.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RCFCVE         1      2      2   0    P   CODIGO LIQUIDACION                        CODIGO_LIQUIDACION
 RCFDES         3     42     40        A   DESCRIPCION                               DESCR_RELACION
 CMCCVE        43     45      3   0    P   CONCEPTO                                  CODIGO_CONCEPTO_CM
 TBLCVE        46     48      3        A   CODIGO DE TABLA                           CODIGO_TABLA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta concepto nómina + concepto liquidación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCmc | — | Concepto de nómina |

---

## Observaciones

- Mapeo de conceptos entre nómina regular y proceso de liquidación.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
