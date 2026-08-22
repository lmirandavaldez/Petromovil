# NomAcah — Acumulado Concepto Anual

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Acumulado anual por concepto de nómina. Almacena los montos totales acumulados de cada concepto de nómina durante el año fiscal, usado para cálculos de ISR y reportes anuales.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 CMCCVE         3      5      3   0    P   CONCEPTO                                  CODIGO_CONCEPTO_CM
 ACAANO         6      8      3   0    P   ANO ACUMULADO POR CONCEPTO                ANO_ACUM_POR_CONCEPTO
 ACACAN         9     15      7   2    P   CANT. ACUM. ANUAL CONCEPTO                CANT_ACUM_ANUAL_CONCEPTO
 ACAIMP        16     22      7   2    P   IMPORTE ACUM. ANUAL CONCEPTO              IMPORTE_ACUM_ANUAL_CONCEPTO
 ACAAPA        23     29      7   2    P   APORTE PATRONO ACUM CONCEPTO              APORTE_PATRONO_ACUM_CONCEPTO
 ACAISR        30     36      7   2    P   SALDO A FAVOR/EN CONTRA EMPL              SALDO_ACUM_FAVOR_CONTRA_EMPL
 ACAVEX        37     43      7   2    P   VALOR EXONERADO ISR ANUAL                 VALOR_EXONERADO_ANUAL_ISR


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta concepto + año |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCmc | — | Concepto de nómina |

---

## Observaciones

- Acumulado anual de conceptos; ver `NomAcad` para el acumulado mensual.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
