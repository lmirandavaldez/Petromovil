# NomRct — Relación Concepto Tipo de Nómina

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Relación entre conceptos de nómina y tipos de nómina. Define qué conceptos aplican a cada tipo de nómina (regular, ejecutiva, producción, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CMCCVE         1      3      3   0    P   CODIGO DE CONCETO                         CODIGO_CONCEPTO_CM
 TNOCVE         4      5      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta tipo de nómina + concepto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTno | — | Tipo de nómina |
| — | NomCmc | — | Concepto de nómina |

---

## Observaciones

- Define los conceptos habilitados para cada tipo de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
