# NomNce — Comparativo Nómina y Empleados

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Comparativo de nómina por empleados. Almacena la comparación de montos de nómina por empleado entre dos períodos para análisis de variaciones individuales.

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
 EMPCVE        16     19      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCTIP        20     20      1   0    P   TIPO DE CONCEPTO                          TIPO_CONCEPTO
 CMCCVE        21     23      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 VALACT        24     30      7   2    P   VALOR NOMINA ACTUAL
 CANACT        31     37      7   2    P   CANTIDAD NOMINA ACTUAL
 VALANT        38     44      7   2    P   VALOR NOMINA ANTERIOR
 CANANT        45     51      7   2    P   CANTIDAD NOMINA ANTERIOR
 DIFERE        52     58      7   2    P   DIFERENCIA ENTRE NOMINAS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Comparativo de nómina por empleado entre períodos.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
