# NomNcc — Comparativo Nómina y Conceptos

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Comparativo de nómina por conceptos. Almacena la comparación de montos de conceptos de nómina entre dos períodos o ciclos para análisis de variaciones.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 CIPANO         5      7      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         8      9      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 UBICVE        10     11      2   0    P   CODIGO DE UBICACION                       CODIGO_UBICACION
 DEPCVE        12     13      2   0    P   CODIGO DE DEPARTAMENTO                    CODIGO_DEPARTAMENTO
 SECCVE        14     15      2   0    P   CODIGO DE SECCION                         CODIGO_SECCION
 CMCTIP        16     16      1   0    P   TIPO DE CONCEPTO                          TIPO_CONCEPTO
 CMCCVE        17     19      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 VALACT        20     26      7   2    P   VALOR NOMINA ACTUAL
 CANACT        27     33      7   2    P   CANTIDAD NOMINA ACTUAL
 VALANT        34     40      7   2    P   VALOR NOMINA ANTERIOR
 CANANT        41     47      7   2    P   CANTIDAD NOMINA ANTERIOR
 DIFERE        48     54      7   2    P   DIFERENCIA ENTRE NOMINAS


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta concepto + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCmc | — | Concepto de nómina |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Comparativo de conceptos entre períodos para análisis de variaciones de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
